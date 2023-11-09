Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE30F7E665D
	for <lists+linux-pm@lfdr.de>; Thu,  9 Nov 2023 10:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjKIJOJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Nov 2023 04:14:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjKIJOI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Nov 2023 04:14:08 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F7A2592;
        Thu,  9 Nov 2023 01:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699521246; x=1731057246;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GS8dbLhC+m1/CpSugFOf9ABa4muzjNydMqJPnmvrbiE=;
  b=FREdehzEdLmizhvtP29rvdfDOOPr5kBxJWFD/egrCq/JZmpHbG+AxSiS
   0TfvWUBJ/JvKc8VcXLhPqGH8CfCokLrsfmBgf6ICAM92gjY4uoyOqO842
   iDM8Oueb+aNMpcZPth1vyi5mAU1sqOLqADO055fDx9ywndcmtwMnNnkGg
   vp9LWwCVi7tOo0V+IvfdHSeTmsdgfRhE6e5Nkk1bvwved10Lg6t+AQefP
   bPZc5z4ROED+KETQZ/ibXcdk6EkqX8UkQiT1Nw2kYpjboWiW3Cr/eoo32
   W233xMuzXQsbBZCsr49BlzQctKZzSwN/Fcm+aa1wN9bG7El1LgbbR452f
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="454251091"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="454251091"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 01:14:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="880535126"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="880535126"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 09 Nov 2023 01:14:03 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r116v-0008br-1I;
        Thu, 09 Nov 2023 09:14:01 +0000
Date:   Thu, 9 Nov 2023 17:13:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-pm@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [rafael-pm:acpi-mipi-disco-img 5/7]
 drivers/acpi/mipi-disco-img.c:537:6: warning: format specifies type 'int'
 but the argument has type 'unsigned long'
Message-ID: <202311091629.3jyzqiV7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-mipi-disco-img
head:   54d87fab9fb060ff0489886ca0fdb101f6a3c03f
commit: a5dbdbb2bfb28643b71d23f75205845cb23af965 [5/7] ACPI: scan: Extract MIPI DisCo for Imaging data into swnodes
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20231109/202311091629.3jyzqiV7-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231109/202311091629.3jyzqiV7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311091629.3jyzqiV7-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/acpi/mipi-disco-img.c:537:6: warning: format specifies type 'int' but the argument has type 'unsigned long' [-Wformat]
                                    ret * BITS_PER_TYPE(u8), num_lanes + 1);
                                    ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/acpi.h:1216:47: note: expanded from macro 'acpi_handle_info'
           acpi_handle_printk(KERN_INFO, handle, fmt, ##__VA_ARGS__)
                                                 ~~~    ^~~~~~~~~~~
   1 warning generated.


vim +537 drivers/acpi/mipi-disco-img.c

   481	
   482	static void init_csi2_port(struct acpi_device *adev,
   483				   struct acpi_device_software_nodes *swnodes,
   484				   struct acpi_device_software_node_port *port,
   485				   struct fwnode_handle *port_fwnode,
   486				   unsigned int port_index)
   487	{
   488		unsigned int ep_prop_index = ACPI_DEVICE_SWNODE_EP_CLOCK_LANES;
   489		acpi_handle handle = acpi_device_handle(adev);
   490		u8 val[ACPI_DEVICE_CSI2_DATA_LANES];
   491		int num_lanes = 0;
   492		int ret;
   493	
   494		if (GRAPH_PORT_NAME(port->port_name, port->port_nr))
   495			return;
   496	
   497		swnodes->nodes[ACPI_DEVICE_SWNODE_PORT(port_index)] =
   498				SOFTWARE_NODE(port->port_name, port->port_props,
   499					      &swnodes->nodes[ACPI_DEVICE_SWNODE_ROOT]);
   500	
   501		ret = fwnode_property_read_u8(port_fwnode, "mipi-img-clock-lane", val);
   502		if (!ret)
   503			port->ep_props[NEXT_PROPERTY(ep_prop_index, EP_CLOCK_LANES)] =
   504				PROPERTY_ENTRY_U32("clock-lanes", val[0]);
   505	
   506		ret = fwnode_property_count_u8(port_fwnode, "mipi-img-data-lanes");
   507		if (ret > 0) {
   508			num_lanes = ret;
   509	
   510			if (num_lanes > ACPI_DEVICE_CSI2_DATA_LANES) {
   511				acpi_handle_info(handle, "Too many data lanes: %u\n",
   512						 num_lanes);
   513				num_lanes = ACPI_DEVICE_CSI2_DATA_LANES;
   514			}
   515	
   516			ret = fwnode_property_read_u8_array(port_fwnode,
   517							    "mipi-img-data-lanes",
   518							    val, num_lanes);
   519			if (!ret) {
   520				unsigned int i;
   521	
   522				for (i = 0; i < num_lanes; i++)
   523					port->data_lanes[i] = val[i];
   524	
   525				port->ep_props[NEXT_PROPERTY(ep_prop_index, EP_DATA_LANES)] =
   526					PROPERTY_ENTRY_U32_ARRAY_LEN("data-lanes",
   527								     port->data_lanes,
   528								     num_lanes);
   529			}
   530		}
   531	
   532		ret = fwnode_property_count_u8(port_fwnode, "mipi-img-lane-polarities");
   533		if (ret < 0) {
   534			acpi_handle_debug(handle, "Lane polarity bytes missing\n");
   535		} else if (ret * BITS_PER_TYPE(u8) < num_lanes + 1) {
   536			acpi_handle_info(handle, "Too few lane polarity bytes (%d vs. %d)\n",
 > 537					 ret * BITS_PER_TYPE(u8), num_lanes + 1);
   538		} else {
   539			unsigned long mask = 0;
   540			int byte_count = ret;
   541			unsigned int i;
   542	
   543			/*
   544			 * The total number of lanes is ACPI_DEVICE_CSI2_DATA_LANES + 1
   545			 * (data lanes + clock lane).  It is not expected to ever be
   546			 * greater than the number of bits in an unsigned long
   547			 * variable, but ensure that this is the case.
   548			 */
   549			BUILD_BUG_ON(BITS_PER_TYPE(unsigned long) <= ACPI_DEVICE_CSI2_DATA_LANES);
   550	
   551			if (byte_count > sizeof(mask)) {
   552				acpi_handle_info(handle, "Too many lane polarities: %d\n",
   553						 byte_count);
   554				byte_count = sizeof(mask);
   555			}
   556			fwnode_property_read_u8_array(port_fwnode, "mipi-img-lane-polarities",
   557						      val, byte_count);
   558	
   559			for (i = 0; i < byte_count; i++)
   560				mask |= (unsigned long)val[i] << BITS_PER_TYPE(u8) * i;
   561	
   562			for (i = 0; i <= num_lanes; i++)
   563				port->lane_polarities[i] = test_bit(i, &mask);
   564	
   565			port->ep_props[NEXT_PROPERTY(ep_prop_index, EP_LANE_POLARITIES)] =
   566					PROPERTY_ENTRY_U32_ARRAY_LEN("lane-polarities",
   567								     port->lane_polarities,
   568								     num_lanes + 1);
   569		}
   570	
   571		swnodes->nodes[ACPI_DEVICE_SWNODE_EP(port_index)] =
   572			SOFTWARE_NODE("endpoint@0", swnodes->ports[port_index].ep_props,
   573				      &swnodes->nodes[ACPI_DEVICE_SWNODE_PORT(port_index)]);
   574	
   575		if (port->crs_csi2_local)
   576			init_csi2_port_local(adev, port, port_fwnode, ep_prop_index);
   577	}
   578	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
