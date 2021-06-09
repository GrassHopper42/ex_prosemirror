import { Schema } from 'prosemirror-model';
import { generateSchemaMarks } from './marks';
import { generateSchemablocks } from './blocks';

/**
 * @param {{customBlocks: Object[], customMarks: Object[], blocksSelection: JSON, marksSelection: JSON, inline: Boolean}} options
 */
export default (options) => (
  new Schema({
    nodes: generateSchemablocks(options),
    marks: generateSchemaMarks(options)
  })
);
