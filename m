Return-Path: <linux-pm+bounces-11869-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E244946777
	for <lists+linux-pm@lfdr.de>; Sat,  3 Aug 2024 06:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82C4B1C20C85
	for <lists+linux-pm@lfdr.de>; Sat,  3 Aug 2024 04:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574CD41A8E;
	Sat,  3 Aug 2024 04:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LHCxe4HQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D274C6D;
	Sat,  3 Aug 2024 04:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722660372; cv=fail; b=QQ5ONu6tKacBua63ZWOCezrj1aiFvU8fI5IPhn1OBj7KGjS9L18rf7PvEWwhYJrN135AbxpoTPuYsjO8M3fxEb7aO51Qbi7S/iOrMuTiXGQJDB6JcvPYruihrAAK3dn/rONK4NVILIIrdBPiyrURCfXa/2YFq1awB38P3kKPZUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722660372; c=relaxed/simple;
	bh=iSETx5JgsmIBo+QS3/m1z599qGcynFN33J4NHNpumgU=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=se+YHzXwRijQzpJPGZXdgAXBdmPjSMSmacPSI/bI7pz/rbAUcAFH91oUqNRhxyXNTvHFfO71OpsvBEpaU1PJdiqVeMTvBUogRt1g4mZlN7ShQOZ56eoqc37fSpaA/uDcogmUBDTubjaXkwvfnFzn9MarexrQ9RyCH7Sq/e6iZ2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LHCxe4HQ; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722660370; x=1754196370;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=iSETx5JgsmIBo+QS3/m1z599qGcynFN33J4NHNpumgU=;
  b=LHCxe4HQbk2lqpsQegA99rqpOW4tZ18BWlxVqwpKQ7tbsWnl3/ylIce8
   zvwRlxP4X2GdDSRYBjSZerY80tKU5PVML65Aw9aiNPgMcY0Yep4Wqshnq
   7MIKwCivl2hEyND9sZe+sui+8IBM3Oshb4U4vg9k+xgA1pYnmj2F8Vj4n
   xbtTQffQfSfsLIKCp3rY1YsvjpkakW77trREccQqlRfvtD5ons/0XRkxi
   my99ApLUTPgI/n2WK+JZOVlpFUp4kpJe6xNfjINf1l5EDGYWEkmY1N24G
   0RFXfHTpW/luTjW0Ejz9vdwNpzx5cuudEriqkNcsECkfxosCKNatFG75q
   A==;
X-CSE-ConnectionGUID: q8d15VEpSW+BvzJqVlNgig==
X-CSE-MsgGUID: bdL0ma1VTgO93wYSTKY/JQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11152"; a="24457618"
X-IronPort-AV: E=Sophos;i="6.09,259,1716274800"; 
   d="scan'208";a="24457618"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 21:46:10 -0700
X-CSE-ConnectionGUID: wFScDh9xTCGXrgXSnmhkGA==
X-CSE-MsgGUID: KLfyPnSkTdGXs+VA0kT/gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,259,1716274800"; 
   d="scan'208";a="60252594"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Aug 2024 21:46:10 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 2 Aug 2024 21:46:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 2 Aug 2024 21:46:09 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 2 Aug 2024 21:46:09 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 2 Aug 2024 21:46:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C2QBFipkKNAvY2IiDzET5uGtykzDdCFr8eJSs+7/mt7PlgvCM6fe5qfRE7C04TRU0A/rCw+544wMzhyNMs+OVFWGSluBDU9NUtE6A3D2WLg5P4tPReA6MCTed7t0t8dnTAnw7GEkdigdm1coejD7zj97AM4gJ3sbbRVcp4H0Z+gUSKSnvN+FkIiSb6jIOdW/yeC3M0FHtCE0+azFNC+Fc9KpehgvTiF02XOmAmxrhU/cR5UgFKXkIU2dBGbikJTR1/K4/vL/fSJPwd3Y7G420Sa7jy64k54tbQkPWYylUHvK7HvaPmC1m/a9TJlwCsLR6ox3XvfgKZNKQH8wzWr3cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IedOw4hzfOXv/ynlPGd84vlegH4bDZV/PKgeh9SNvLg=;
 b=BK95hk/9V+W8SrVgyeY7RoMCOs6BKZ9PPPj8H2NxIoaOagX3Sn2zOzE7yh780YMxb/JZ0VTWTHoJzU82YcfRnmaKp4OY+LFIQkeTPMQvtN+uXPRyeHMBt7TntLnwBxfts1xNFZ5hnVmjaEzP9PRcuHjiSLxhST6L1OH4Dmwr8bfrZkTHx6H2fDGnrXZeOXWtuvJwr6Q8KwZJphoaJavCGwtXGFC5z7FwhfHzteGewP+1DLgyiTbCrGQKpk5oIAh8/L+teMdQnWL3eJPQJUjVBZnPvMvGdYXMlGjoMhGs6ITa9ognE+wFz+u+MeDgOSApe9bQFpMGMvi+6MEymf4D1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by CH3PR11MB8156.namprd11.prod.outlook.com (2603:10b6:610:165::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.24; Sat, 3 Aug
 2024 04:46:07 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%5]) with mapi id 15.20.7828.023; Sat, 3 Aug 2024
 04:46:07 +0000
Date: Sat, 3 Aug 2024 12:45:54 +0800
From: kernel test robot <lkp@intel.com>
To: Tengfei Fan <quic_tengfan@quicinc.com>, Georgi Djakov <djakov@kernel.org>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
CC: <oe-kbuild-all@lists.linux.dev>, <kernel@quicinc.com>,
	<linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Tengfei Fan
	<quic_tengfan@quicinc.com>
Subject: Re: [PATCH v3 2/3] interconnect: qcom: Add SM4450 interconnect
 provider driver
Message-ID: <Zq22AvCdq6J8f8Lh@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240801-sm4450_interconnect-v3-2-8e364d0faa99@quicinc.com>
X-ClientProxiedBy: SG2PR04CA0165.apcprd04.prod.outlook.com (2603:1096:4::27)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|CH3PR11MB8156:EE_
X-MS-Office365-Filtering-Correlation-Id: 8906a9ac-fe7c-49dc-d292-08dcb377301d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cKEm3W2rnOz8JO25E4PCexxWYdi1/Yq8rVIjLYAG0wwiXe+3cWLoABEw9SUk?=
 =?us-ascii?Q?u/Zvw11Jqz7J4+DbL9BbzQo3dGJYLet8kKs2qnLguZ37z0YOInOQMKZyjees?=
 =?us-ascii?Q?916mQNzAbPF3d3lmto89v2YZk485sBTOvYIjwDwTabOia7GBc57oL84Ri6XQ?=
 =?us-ascii?Q?/HlBAFLI8TPSi5vDfgPk1e7VylKfIss/1sJG59t2V30ZYZv8E+FzzvTAlO6H?=
 =?us-ascii?Q?7A6bMLn9XoAUeOickzO0PW7Rcnf09Zm2P8N/iStBcjN5aZHVAytpPFFO1RKR?=
 =?us-ascii?Q?8XQqWYRZvuMLEf3On+DTT0vGw1Ya5Lemcl85UtvzKSvvgk53Ww/8+69V65ob?=
 =?us-ascii?Q?9WF2W7em1XcOkOnlec43H0ueu4L70gQrIq1e9Fw1A45OGliBcKj6Hkz7Cf39?=
 =?us-ascii?Q?nh4ON0TkNQKRQ1lkQhwOS2GMKwWyn+xnaoak+5JHoK6MvQy8mTKNrTalTLf1?=
 =?us-ascii?Q?JnOibjk+NmaREi9n3u3/wkH4YJSDS+HOZVwOxTEArFOOfWb8O3mCCo3+AzLR?=
 =?us-ascii?Q?HcQxMceyRpGZ8JuoGxYbGZqOwNTI1766JMAGZ6y5N+hOYRU4K/pLTQqO2uQr?=
 =?us-ascii?Q?wYF9X1aZsthoHBgBvvBaHZHYPsKCcbVO6AFsE41lVY2IeyicyO5TBKx07ngB?=
 =?us-ascii?Q?rXVr7IEipnAXHpZ9xfaLSGXf4BIeKTDDdADJAYF19VHtFAKJSnlCKjsm9Lgk?=
 =?us-ascii?Q?oQNXMyoV6N5hP1+rTieMi/6fQAI+QucNiJPb+Ug2Mnb4Pu171O3ghIWFGj+O?=
 =?us-ascii?Q?2BM5IbKfZ3rIHIjaNMIQVe3UsWxT/8tds4GNJyZo+EnMDlVTlxv5utfaC8y6?=
 =?us-ascii?Q?yFh+ToCSkht7+5noYDgxY6WA4FYRzeaa+SX6Ge79B23KgJoIX46pp/YhqQY+?=
 =?us-ascii?Q?/9NYBQRgAd4N82J19rqutaL+4+93SlnopnR6qddA7ddvUCIwTj+LmV9+nnJ8?=
 =?us-ascii?Q?SGS/wOfwhWAzT30mM4hg4GHPhvOxfmm0qP8xaxun208NXwNk1jGKRzc0Kx/C?=
 =?us-ascii?Q?9oynPC72klKqOQOAxG41817/iTKtJ7gokgX+NynnGzVKxyKHMaPzo3HBuTeO?=
 =?us-ascii?Q?jerT9tcLiVO9FwRpPuPeVta8m/gt11XDKxCT/7xqeJm5pYvaqU1mEJoZ2T7h?=
 =?us-ascii?Q?UdXyddPJImMC9pHfJqrRaWIxMEJXqCkGn8U3D91Ox3BVgF1vHIPV0jMRg9VO?=
 =?us-ascii?Q?5wH8CVIXr55W9PayMLKYB7/0tgEAKFkAwZO0ZAjG+6HSHNhDTHWab2qOZenC?=
 =?us-ascii?Q?aF6+ESljd8Zq9YgRFlxn9sJ/vzox/3OjGwcozw+4TQejiQ5FxVgsGZhXzuCh?=
 =?us-ascii?Q?hSc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pIcLryJka1k/KwshDPlHAXKQGrasZ5iZPVxcr1V1eWwcj0vdpt9mfsu0Y4SD?=
 =?us-ascii?Q?QLedAEB45d4GAZ8Pa1Zn/5q5B+wW6IvBcbRdQSgYPUCb2UXzv8EfhTXxVoEv?=
 =?us-ascii?Q?TgQi8yWR9ik24c0UnYUoT5TlCWUE2abJ9ARv7bPvQunPxRH1mofdh+XGVwge?=
 =?us-ascii?Q?VX08mPixnbnc1HxIw4UiQAOApP4vNLysxYCgExCKBRVeI2N/6vc9fDr/Lf7P?=
 =?us-ascii?Q?RQ7oK6PoRFPJIey9Jg5Kp92GOxZvTXXLrYqA+PNcYxGdy3aLbmzTBs1F9fAO?=
 =?us-ascii?Q?NcaFlfz/D4oGEw1VoyddRTst8BRlo1aq18sh2Dwwqd9sDXgRusWfQzfxV5cp?=
 =?us-ascii?Q?PhZht2Y3D6ojl5UQzL/u75A72HQiiTnWiR7BWOcofAI7/Mtev7ql5GibA0Sp?=
 =?us-ascii?Q?xHEX19lA+DkQc+kYiyGgSMSYrnWn62U6yM8nV9HdbU+2t7JZVsN/+G4pgv6i?=
 =?us-ascii?Q?79KNnddNcQNHrEcTlyxjRt7usPRykh1RJCZ4smTNQ7ndywNFYJjzDbgYM0cY?=
 =?us-ascii?Q?cx0jMvXPfWb5C5uOmpqGxeLW3AxrqaJj1ADyPrAwBjoZ7kdfaC7zAt6ygldB?=
 =?us-ascii?Q?A4gs8+0bD7axd4zDCCr/e854iCU8RsFWo8eX6TTjNKshgtitdi2ZcxNqGJB8?=
 =?us-ascii?Q?Xtuuzv93LYL1QCcAoGuHbB97LxWWYdtFcAa9HRUb44PU9w+dpmJhq2mEfBcX?=
 =?us-ascii?Q?6JO9tRQtVaCt7yjcphV8nW9Hkazug6Nhghq1UhSqCujP4I/pwxZQOsT5exe0?=
 =?us-ascii?Q?wv5JoQ8jYjtZ55QzpcpDRWXCfcFUUtP31tL8UQ6aaBzIu9au7/qGZdPzaYBO?=
 =?us-ascii?Q?wvEJ5di1mGQHTzv0Ton792xUcBj9oO/12fP7LjPrL+b+JxaeZVajKaE45qc9?=
 =?us-ascii?Q?PUVis95GuaZw0tioI8CDVM27uN2yVaiYNAlMqgOkaFU6+SGB5usf1k2hdqEy?=
 =?us-ascii?Q?OuOyanEOQRNqJ0XP1JJuURJzzPrzgyQj2pb5Y+sh4QEHoGgfvR/aZ82/vX8G?=
 =?us-ascii?Q?XLLf1b0th4kTmXbzwG5TQfnRaE3e9UNjCSXb2pY29XXo2yy7nogQw0hOYnlL?=
 =?us-ascii?Q?kvLE/7jqxngiw1jhiWRj+0atJAXeT1l38paHsQeL33hBfdczTkWZ3jTv+PeJ?=
 =?us-ascii?Q?0eUjR0kRfmu760GyIX6UGldJNvrkVHcEuiIaYkxbtDG15SyvHkGF/qzp0Xal?=
 =?us-ascii?Q?/ovt9f+MnzKlKbWFK/2M1UwXtfk7mIiaDApAViMoqSrM3Mz2IJ1U6perXBGP?=
 =?us-ascii?Q?/4fx1aNMhkREwfZzXIF212t0jZHO1KvJvxBCiDRz5NnuyBuBndRJziA4tEO4?=
 =?us-ascii?Q?SyH+it9+oMSIAC0fWROreRswDR0jEz/3QxSMd/dURR9xipqXtNtQ4uQ8f9XJ?=
 =?us-ascii?Q?Vvnk2s6pP6dqXo35ELEeXKI0oWImvJJe2Gd1/yrZ9DImL/d3KV+f+3o1IFjc?=
 =?us-ascii?Q?xRfRnxIrqLwltsbQn2DXqfpPAl0EASg+96YXB+3ACUAg//txIQYvDlDzaoVf?=
 =?us-ascii?Q?z50rQ1SYWQMwumYTRML28Kr3KDCWmXtEZeEyalvIqJ6u+//2U4sQe4k0QzVs?=
 =?us-ascii?Q?M4zH3MfdrAhaBEV/+mx/yapsaEmpqhYgs7oDv2+0D39aW1kh7/K7Q3f9QUWk?=
 =?us-ascii?Q?uA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8906a9ac-fe7c-49dc-d292-08dcb377301d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2024 04:46:07.2385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K5l5UImhL558xeZOCa0PLS8xvK7TcDEZQRHARaY4Fk21rxZjBGd2UzrYfsOAK1/miE66xpCx3rqYzYq7oXO9zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8156
X-OriginatorOrg: intel.com

Hi Tengfei,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 048d8cb65cde9fe7534eb4440bcfddcf406bb49c]

url:    https://github.com/intel-lab-lkp/linux/commits/Tengfei-Fan/dt-bindings-interconnect-Add-Qualcomm-SM4450/20240802-194900
base:   048d8cb65cde9fe7534eb4440bcfddcf406bb49c
patch link:    https://lore.kernel.org/r/20240801-sm4450_interconnect-v3-2-8e364d0faa99%40quicinc.com
patch subject: [PATCH v3 2/3] interconnect: qcom: Add SM4450 interconnect provider driver
:::::: branch date: 11 hours ago
:::::: commit date: 11 hours ago
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202408030616.IhRcAnMm-lkp@intel.com/

includecheck warnings: (new ones prefixed by >>)
>> drivers/interconnect/qcom/sm4450.c: icc-rpmh.h is included more than once.

vim +16 drivers/interconnect/qcom/sm4450.c

    14	
    15	#include "bcm-voter.h"
  > 16	#include "icc-rpmh.h"
  > 17	#include "icc-rpmh.h"
    18	#include "sm4450.h"
    19	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


