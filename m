Return-Path: <linux-pm+bounces-8852-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3664A901EA5
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 11:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A31AB21005
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 09:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9369A768EC;
	Mon, 10 Jun 2024 09:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MOzlAhiP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6691A42AA1;
	Mon, 10 Jun 2024 09:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718013340; cv=none; b=UFUN66YDGVx4WIcsyE7VO5wYawbVbj/wTK6WoQgnIyB/7b+XRxDUH7/dFWvXOKzQPSXG0b9/wEDXSaDPBqlQTnglGCLK//h7UXyJqqH1zGWMwQXX8yK3cjiE9CmGLGkYvScIIjQILzCx7X618EBfkJoNNB+/WE2E4xKVe0dwvD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718013340; c=relaxed/simple;
	bh=qP3A/bPQSWOrxCQjGjByVI5xJWXodHkxEeKNixMY78k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nYh3aDzYDRa3zIU59PYAyYxm9nfKezsENEwMIJ19xVdMXz44Zt1ZoGj5O0k73+YZRDwEMXPKnF+LhF1a1IcGD3cB6lNenrmHAotg1TKeu8rTri/DL7KhIu8bnDQ5KGpqrgVkmE3RnastE13x9DPLXXv2+bKTcoC4bVbU73B7GGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MOzlAhiP; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718013339; x=1749549339;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qP3A/bPQSWOrxCQjGjByVI5xJWXodHkxEeKNixMY78k=;
  b=MOzlAhiPo/4QaFM423UTk5b6pYFuWCaWPu2VztCWAjEp7Dc+aldGldSv
   Jk05bNQnShsbQw6fRBwWcI7rqpZbwKklkrupya7/QHZAN+N4V4AzMA5Io
   LD+p+T3/QCCebzgQAqZdqAzAmBf8xYdJoeKJVJjZxUdDQQYDOEPS6YaY5
   DdUSET4uIN/Ycr3jP8d2X81z1lXVU9aUcR6x8Az5O5ILT0o0rAY13Ht7G
   eMoUZAk0v8PgD1splUOkH8rOnF1YIVkJ70CFQJu1uRnkw3KpRhUBtpf7w
   14hOYRH5JqLD0B22eSzoXZ30hxyo3gfz+bKlefNjqO8GJMToA+MGj7B9+
   A==;
X-CSE-ConnectionGUID: iNRrUx+rRbWf2y+aOAAvkA==
X-CSE-MsgGUID: fMrzlGlLTHq9mdOi+kY3Qg==
X-IronPort-AV: E=McAfee;i="6600,9927,11098"; a="14397401"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="14397401"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 02:55:38 -0700
X-CSE-ConnectionGUID: MkV92I2KQourMl9gtN6Vyw==
X-CSE-MsgGUID: aSJXRSOETPugBl8FAbyybA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="43935030"
Received: from lkp-server01.sh.intel.com (HELO 8967fbab76b3) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 10 Jun 2024 02:55:34 -0700
Received: from kbuild by 8967fbab76b3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sGbkR-00022r-1R;
	Mon, 10 Jun 2024 09:55:31 +0000
Date: Mon, 10 Jun 2024 17:55:31 +0800
From: kernel test robot <lkp@intel.com>
To: Adam Skladowski <a39.skl@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, phone-devel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	Adam Skladowski <a39.skl@gmail.com>, Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Georgi Djakov <djakov@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] interconnect: qcom: qcs404: Add regmaps and more bus
 descriptions
Message-ID: <202406101715.AMP9VWkx-lkp@intel.com>
References: <20240609182112.13032-7-a39.skl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240609182112.13032-7-a39.skl@gmail.com>

Hi Adam,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.10-rc3 next-20240607]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Adam-Skladowski/dt-bindings-interconnect-Add-Qualcomm-MSM8976-DT-bindings/20240610-022416
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240609182112.13032-7-a39.skl%40gmail.com
patch subject: [PATCH 6/7] interconnect: qcom: qcs404: Add regmaps and more bus descriptions
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20240610/202406101715.AMP9VWkx-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240610/202406101715.AMP9VWkx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406101715.AMP9VWkx-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> drivers/interconnect/qcom/qcs404.c:1070:21: error: variable 'qcs404_bimc_regmap_config' has initializer but incomplete type
    1070 | static const struct regmap_config qcs404_bimc_regmap_config = {
         |                     ^~~~~~~~~~~~~
>> drivers/interconnect/qcom/qcs404.c:1071:10: error: 'const struct regmap_config' has no member named 'reg_bits'
    1071 |         .reg_bits = 32,
         |          ^~~~~~~~
>> drivers/interconnect/qcom/qcs404.c:1071:21: warning: excess elements in struct initializer
    1071 |         .reg_bits = 32,
         |                     ^~
   drivers/interconnect/qcom/qcs404.c:1071:21: note: (near initialization for 'qcs404_bimc_regmap_config')
>> drivers/interconnect/qcom/qcs404.c:1072:10: error: 'const struct regmap_config' has no member named 'reg_stride'
    1072 |         .reg_stride = 4,
         |          ^~~~~~~~~~
   drivers/interconnect/qcom/qcs404.c:1072:23: warning: excess elements in struct initializer
    1072 |         .reg_stride = 4,
         |                       ^
   drivers/interconnect/qcom/qcs404.c:1072:23: note: (near initialization for 'qcs404_bimc_regmap_config')
>> drivers/interconnect/qcom/qcs404.c:1073:10: error: 'const struct regmap_config' has no member named 'val_bits'
    1073 |         .val_bits = 32,
         |          ^~~~~~~~
   drivers/interconnect/qcom/qcs404.c:1073:21: warning: excess elements in struct initializer
    1073 |         .val_bits = 32,
         |                     ^~
   drivers/interconnect/qcom/qcs404.c:1073:21: note: (near initialization for 'qcs404_bimc_regmap_config')
>> drivers/interconnect/qcom/qcs404.c:1074:10: error: 'const struct regmap_config' has no member named 'max_register'
    1074 |         .max_register = 0x80000,
         |          ^~~~~~~~~~~~
   drivers/interconnect/qcom/qcs404.c:1074:25: warning: excess elements in struct initializer
    1074 |         .max_register = 0x80000,
         |                         ^~~~~~~
   drivers/interconnect/qcom/qcs404.c:1074:25: note: (near initialization for 'qcs404_bimc_regmap_config')
>> drivers/interconnect/qcom/qcs404.c:1075:10: error: 'const struct regmap_config' has no member named 'fast_io'
    1075 |         .fast_io = true,
         |          ^~~~~~~
   drivers/interconnect/qcom/qcs404.c:1075:20: warning: excess elements in struct initializer
    1075 |         .fast_io = true,
         |                    ^~~~
   drivers/interconnect/qcom/qcs404.c:1075:20: note: (near initialization for 'qcs404_bimc_regmap_config')
>> drivers/interconnect/qcom/qcs404.c:1137:21: error: variable 'qcs404_pcnoc_regmap_config' has initializer but incomplete type
    1137 | static const struct regmap_config qcs404_pcnoc_regmap_config = {
         |                     ^~~~~~~~~~~~~
   drivers/interconnect/qcom/qcs404.c:1138:10: error: 'const struct regmap_config' has no member named 'reg_bits'
    1138 |         .reg_bits = 32,
         |          ^~~~~~~~
   drivers/interconnect/qcom/qcs404.c:1138:21: warning: excess elements in struct initializer
    1138 |         .reg_bits = 32,
         |                     ^~
   drivers/interconnect/qcom/qcs404.c:1138:21: note: (near initialization for 'qcs404_pcnoc_regmap_config')
   drivers/interconnect/qcom/qcs404.c:1139:10: error: 'const struct regmap_config' has no member named 'reg_stride'
    1139 |         .reg_stride = 4,
         |          ^~~~~~~~~~
   drivers/interconnect/qcom/qcs404.c:1139:23: warning: excess elements in struct initializer
    1139 |         .reg_stride = 4,
         |                       ^
   drivers/interconnect/qcom/qcs404.c:1139:23: note: (near initialization for 'qcs404_pcnoc_regmap_config')
   drivers/interconnect/qcom/qcs404.c:1140:10: error: 'const struct regmap_config' has no member named 'val_bits'
    1140 |         .val_bits = 32,
         |          ^~~~~~~~
   drivers/interconnect/qcom/qcs404.c:1140:21: warning: excess elements in struct initializer
    1140 |         .val_bits = 32,
         |                     ^~
   drivers/interconnect/qcom/qcs404.c:1140:21: note: (near initialization for 'qcs404_pcnoc_regmap_config')
   drivers/interconnect/qcom/qcs404.c:1141:10: error: 'const struct regmap_config' has no member named 'max_register'
    1141 |         .max_register = 0x15080,
         |          ^~~~~~~~~~~~
   drivers/interconnect/qcom/qcs404.c:1141:25: warning: excess elements in struct initializer
    1141 |         .max_register = 0x15080,
         |                         ^~~~~~~
   drivers/interconnect/qcom/qcs404.c:1141:25: note: (near initialization for 'qcs404_pcnoc_regmap_config')
   drivers/interconnect/qcom/qcs404.c:1142:10: error: 'const struct regmap_config' has no member named 'fast_io'
    1142 |         .fast_io = true,
         |          ^~~~~~~
   drivers/interconnect/qcom/qcs404.c:1142:20: warning: excess elements in struct initializer
    1142 |         .fast_io = true,
         |                    ^~~~
   drivers/interconnect/qcom/qcs404.c:1142:20: note: (near initialization for 'qcs404_pcnoc_regmap_config')
>> drivers/interconnect/qcom/qcs404.c:1178:21: error: variable 'qcs404_snoc_regmap_config' has initializer but incomplete type
    1178 | static const struct regmap_config qcs404_snoc_regmap_config = {
         |                     ^~~~~~~~~~~~~
   drivers/interconnect/qcom/qcs404.c:1179:10: error: 'const struct regmap_config' has no member named 'reg_bits'
    1179 |         .reg_bits = 32,
         |          ^~~~~~~~
   drivers/interconnect/qcom/qcs404.c:1179:21: warning: excess elements in struct initializer
    1179 |         .reg_bits = 32,
         |                     ^~
   drivers/interconnect/qcom/qcs404.c:1179:21: note: (near initialization for 'qcs404_snoc_regmap_config')
   drivers/interconnect/qcom/qcs404.c:1180:10: error: 'const struct regmap_config' has no member named 'reg_stride'
    1180 |         .reg_stride = 4,
         |          ^~~~~~~~~~
   drivers/interconnect/qcom/qcs404.c:1180:23: warning: excess elements in struct initializer
    1180 |         .reg_stride = 4,
         |                       ^
   drivers/interconnect/qcom/qcs404.c:1180:23: note: (near initialization for 'qcs404_snoc_regmap_config')
   drivers/interconnect/qcom/qcs404.c:1181:10: error: 'const struct regmap_config' has no member named 'val_bits'
    1181 |         .val_bits = 32,
         |          ^~~~~~~~
   drivers/interconnect/qcom/qcs404.c:1181:21: warning: excess elements in struct initializer
    1181 |         .val_bits = 32,
         |                     ^~
   drivers/interconnect/qcom/qcs404.c:1181:21: note: (near initialization for 'qcs404_snoc_regmap_config')
   drivers/interconnect/qcom/qcs404.c:1182:10: error: 'const struct regmap_config' has no member named 'max_register'
    1182 |         .max_register = 0x23080,
         |          ^~~~~~~~~~~~
   drivers/interconnect/qcom/qcs404.c:1182:25: warning: excess elements in struct initializer
    1182 |         .max_register = 0x23080,
         |                         ^~~~~~~
   drivers/interconnect/qcom/qcs404.c:1182:25: note: (near initialization for 'qcs404_snoc_regmap_config')
   drivers/interconnect/qcom/qcs404.c:1183:10: error: 'const struct regmap_config' has no member named 'fast_io'
    1183 |         .fast_io = true,
         |          ^~~~~~~
   drivers/interconnect/qcom/qcs404.c:1183:20: warning: excess elements in struct initializer
    1183 |         .fast_io = true,
         |                    ^~~~
   drivers/interconnect/qcom/qcs404.c:1183:20: note: (near initialization for 'qcs404_snoc_regmap_config')
>> drivers/interconnect/qcom/qcs404.c:1070:35: error: storage size of 'qcs404_bimc_regmap_config' isn't known
    1070 | static const struct regmap_config qcs404_bimc_regmap_config = {
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/interconnect/qcom/qcs404.c:1137:35: error: storage size of 'qcs404_pcnoc_regmap_config' isn't known
    1137 | static const struct regmap_config qcs404_pcnoc_regmap_config = {
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/interconnect/qcom/qcs404.c:1178:35: error: storage size of 'qcs404_snoc_regmap_config' isn't known
    1178 | static const struct regmap_config qcs404_snoc_regmap_config = {
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +/qcs404_bimc_regmap_config +1070 drivers/interconnect/qcom/qcs404.c

  1069	
> 1070	static const struct regmap_config qcs404_bimc_regmap_config = {
> 1071		.reg_bits = 32,
> 1072		.reg_stride = 4,
> 1073		.val_bits = 32,
> 1074		.max_register = 0x80000,
> 1075		.fast_io = true,
  1076	};
  1077	
  1078	static const struct qcom_icc_desc qcs404_bimc = {
  1079		.type = QCOM_ICC_BIMC,
  1080		.nodes = qcs404_bimc_nodes,
  1081		.num_nodes = ARRAY_SIZE(qcs404_bimc_nodes),
  1082		.bus_clk_desc = &bimc_clk,
  1083		.regmap_cfg = &qcs404_bimc_regmap_config,
  1084		.qos_offset = 0x8000,
  1085		.ab_coeff = 153,
  1086	};
  1087	
  1088	static struct qcom_icc_node * const qcs404_pcnoc_nodes[] = {
  1089		[MASTER_SPDM] = &mas_spdm,
  1090		[MASTER_BLSP_1] = &mas_blsp_1,
  1091		[MASTER_BLSP_2] = &mas_blsp_2,
  1092		[MASTER_XI_USB_HS1] = &mas_xi_usb_hs1,
  1093		[MASTER_CRYPT0] = &mas_crypto,
  1094		[MASTER_SDCC_1] = &mas_sdcc_1,
  1095		[MASTER_SDCC_2] = &mas_sdcc_2,
  1096		[MASTER_SNOC_PCNOC] = &mas_snoc_pcnoc,
  1097		[MASTER_QPIC] = &mas_qpic,
  1098		[PCNOC_INT_0] = &pcnoc_int_0,
  1099		[PCNOC_INT_2] = &pcnoc_int_2,
  1100		[PCNOC_INT_3] = &pcnoc_int_3,
  1101		[PCNOC_S_0] = &pcnoc_s_0,
  1102		[PCNOC_S_1] = &pcnoc_s_1,
  1103		[PCNOC_S_2] = &pcnoc_s_2,
  1104		[PCNOC_S_3] = &pcnoc_s_3,
  1105		[PCNOC_S_4] = &pcnoc_s_4,
  1106		[PCNOC_S_6] = &pcnoc_s_6,
  1107		[PCNOC_S_7] = &pcnoc_s_7,
  1108		[PCNOC_S_8] = &pcnoc_s_8,
  1109		[PCNOC_S_9] = &pcnoc_s_9,
  1110		[PCNOC_S_10] = &pcnoc_s_10,
  1111		[PCNOC_S_11] = &pcnoc_s_11,
  1112		[SLAVE_SPDM] = &slv_spdm,
  1113		[SLAVE_PDM] = &slv_pdm,
  1114		[SLAVE_PRNG] = &slv_prng,
  1115		[SLAVE_TCSR] = &slv_tcsr,
  1116		[SLAVE_SNOC_CFG] = &slv_snoc_cfg,
  1117		[SLAVE_MESSAGE_RAM] = &slv_message_ram,
  1118		[SLAVE_DISP_SS_CFG] = &slv_disp_ss_cfg,
  1119		[SLAVE_GPU_CFG] = &slv_gpu_cfg,
  1120		[SLAVE_BLSP_1] = &slv_blsp_1,
  1121		[SLAVE_BLSP_2] = &slv_blsp_2,
  1122		[SLAVE_TLMM_NORTH] = &slv_tlmm_north,
  1123		[SLAVE_PCIE] = &slv_pcie,
  1124		[SLAVE_ETHERNET] = &slv_ethernet,
  1125		[SLAVE_TLMM_EAST] = &slv_tlmm_east,
  1126		[SLAVE_TCU] = &slv_tcu,
  1127		[SLAVE_PMIC_ARB] = &slv_pmic_arb,
  1128		[SLAVE_SDCC_1] = &slv_sdcc_1,
  1129		[SLAVE_SDCC_2] = &slv_sdcc_2,
  1130		[SLAVE_TLMM_SOUTH] = &slv_tlmm_south,
  1131		[SLAVE_USB_HS] = &slv_usb_hs,
  1132		[SLAVE_USB3] = &slv_usb3,
  1133		[SLAVE_CRYPTO_0_CFG] = &slv_crypto_0_cfg,
  1134		[SLAVE_PCNOC_SNOC] = &slv_pcnoc_snoc,
  1135	};
  1136	
> 1137	static const struct regmap_config qcs404_pcnoc_regmap_config = {
  1138		.reg_bits = 32,
  1139		.reg_stride = 4,
  1140		.val_bits = 32,
  1141		.max_register = 0x15080,
  1142		.fast_io = true,
  1143	};
  1144	
  1145	static const struct qcom_icc_desc qcs404_pcnoc = {
  1146		.type = QCOM_ICC_NOC,
  1147		.nodes = qcs404_pcnoc_nodes,
  1148		.num_nodes = ARRAY_SIZE(qcs404_pcnoc_nodes),
  1149		.bus_clk_desc = &bus_0_clk,
  1150		.qos_offset = 0x7000,
  1151		.keep_alive = true,
  1152		.regmap_cfg = &qcs404_pcnoc_regmap_config,
  1153	};
  1154	
  1155	static struct qcom_icc_node * const qcs404_snoc_nodes[] = {
  1156		[MASTER_QDSS_BAM] = &mas_qdss_bam,
  1157		[MASTER_BIMC_SNOC] = &mas_bimc_snoc,
  1158		[MASTER_PCNOC_SNOC] = &mas_pcnoc_snoc,
  1159		[MASTER_QDSS_ETR] = &mas_qdss_etr,
  1160		[MASTER_EMAC] = &mas_emac,
  1161		[MASTER_PCIE] = &mas_pcie,
  1162		[MASTER_USB3] = &mas_usb3,
  1163		[QDSS_INT] = &qdss_int,
  1164		[SNOC_INT_0] = &snoc_int_0,
  1165		[SNOC_INT_1] = &snoc_int_1,
  1166		[SNOC_INT_2] = &snoc_int_2,
  1167		[SLAVE_KPSS_AHB] = &slv_kpss_ahb,
  1168		[SLAVE_WCSS] = &slv_wcss,
  1169		[SLAVE_SNOC_BIMC_1] = &slv_snoc_bimc_1,
  1170		[SLAVE_IMEM] = &slv_imem,
  1171		[SLAVE_SNOC_PCNOC] = &slv_snoc_pcnoc,
  1172		[SLAVE_QDSS_STM] = &slv_qdss_stm,
  1173		[SLAVE_CATS_0] = &slv_cats_0,
  1174		[SLAVE_CATS_1] = &slv_cats_1,
  1175		[SLAVE_LPASS] = &slv_lpass,
  1176	};
  1177	
> 1178	static const struct regmap_config qcs404_snoc_regmap_config = {
  1179		.reg_bits = 32,
  1180		.reg_stride = 4,
  1181		.val_bits = 32,
  1182		.max_register = 0x23080,
  1183		.fast_io = true,
  1184	};
  1185	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

