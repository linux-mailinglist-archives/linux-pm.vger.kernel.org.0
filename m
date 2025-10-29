Return-Path: <linux-pm+bounces-37046-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A354AC1BEFB
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 17:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 22DD4507D26
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 15:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F45311C06;
	Wed, 29 Oct 2025 15:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bg6pHVAS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414E32E62D0
	for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2025 15:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761751475; cv=fail; b=fLjEwGpVCpD68HBOIUulVGRIkjwOr7QV3QTduV094PXaAl36cs8ZxHJWrT4zomoelvCHkWFJgnkzmM4Oiae8de/ayhK6BSWE/Dafx28xJbsgY6u+Mg3VH4llje5lBsflPzkwPP7rVNuECluFyz/9IGi2f1Z42Ia7m/X1EmtlFso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761751475; c=relaxed/simple;
	bh=WpEyXhA5f7QRHi2UZYM3WR5ecx6l6LzfEqlWkyOD0eM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DIpFwgY2cP3A9SzA+EqjT7xEGxc3YurTTeoPRtYQbYE4hnSJE/fzF1P+QCFA2XXW8t+1/32UvQ8z/ku7mcyuUclosOdYtQupfZyXNt07CBrE//LdmJm9zk+Va13YV/d+SNlLwrew22+4cWkvPArC0Fms5u9ZfSbRX3m5E3yI0dA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bg6pHVAS; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761751473; x=1793287473;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WpEyXhA5f7QRHi2UZYM3WR5ecx6l6LzfEqlWkyOD0eM=;
  b=bg6pHVASgdj4MbNIH2m1cNuNX8wZJ85XiwlFiATPYbhPZ7tj6KvRQ2wx
   JFIn75xPwzrwpD7jV0gf/ehOJNudZtso4w6XzECITiaislPec5A/cO+Tf
   /4A26pLRBVcu/l3hss+NRQWgmIJ38PkaIA8NYMmcf0bwyhTdhL7nYR3yV
   PWEVZbI8uBrYN9aDf6xVCrmbKRI9eXmErUSfoT2RBpH6KAPsbsETeqdh3
   yinHL4H7gb9l3ddHvX68FMeU8Z9kBtoN0KdWfM8pb1V09/3oSjgaES/yN
   nlX09xKdBiOt3Ufr2YQjzZkphOMMN5nPvdKW4/aPccP0IuL1PE8XMbzco
   Q==;
X-CSE-ConnectionGUID: Ow/fTXhrQwK3u+5D/f7Hng==
X-CSE-MsgGUID: wHAsr6NFQ3KXa8aZbjz2vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="67529291"
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="67529291"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 08:23:22 -0700
X-CSE-ConnectionGUID: Hq8c82F7RF650Wzk/ZRWBw==
X-CSE-MsgGUID: /Y0DjRP0RuWQUMnk+3wtEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="216558430"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 08:23:21 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 08:23:21 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 29 Oct 2025 08:23:21 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.2) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 08:23:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FDf6NqE6XEQynNulEV6ZkGjz6pciw+dutE2yTJYG7geZ5e7N9h3ff9DylkQNUd5QB+QC4+Jf0CVFVnrkDKuUWIzfW6MHQsND03YqsUJmzWG6AHrz/u9sCNmSEGRjdzyFysT+5Gs43wYldDZ962zIhCsPRDuJ+gGpiCCdBbZ+thiQY4D7z/SpYh5l9fznhkamLnvciDz7RlITnKUgIsG8gWI9b/BeTxmHi8OvZ09feI7sXppeBrxBFeY5/pObaw+9M93w/7dQWNG1pFhPxSdpzpH4aO8ZDf9s/TBebgW7mm3l3qtqqXw5ODhe4ttpbp7STP4I3J2IwN70bBai1Rksxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JVZe8kIYatkf8yZADj/6RZvSLcA/XdxF1zAuy+fQ87s=;
 b=SXt5KpC3LTWk8ehATYc2LhqQDAAhD7OujTHnot7Nui17q9nR07q2qxa9tPX8dgUKqKAzF5IfMpDce5dtpA2YYqYsAwpULRRqTMa+aUegc6lvCdtzh1Te9AiTvyqjurZqb9lBeoxApUkY0EP87P6VBh9h+drDDDWzOMzh3OXT7vn6BQ/cNt1xbj2py63bB2I+JFTNva/wKrl58Q1hy90LihFPu8qrkOCTvTLEAlgu+3HGQ9EkU1mAG87caY8fujHaLn1Wc/2trBJgZojqkuwR8PySYyBAKYrIlpLe/e0mgOIrfM9HzL7o+ulwqfTvIWaN9ZxK2nxizsEZNThZljcAHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by BY1PR11MB8054.namprd11.prod.outlook.com (2603:10b6:a03:52f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Wed, 29 Oct
 2025 15:23:18 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.9253.017; Wed, 29 Oct 2025
 15:23:18 +0000
Date: Wed, 29 Oct 2025 08:23:15 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
CC: <rafael@kernel.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2] ACPI: mrrm: Fix memory leaks and improve error
 handling
Message-ID: <aQIxYyNx65UQYTh3@agluck-desk3>
References: <20251029091013.3682552-1-kaushlendra.kumar@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251029091013.3682552-1-kaushlendra.kumar@intel.com>
X-ClientProxiedBy: BY3PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::23) To SJ1PR11MB6083.namprd11.prod.outlook.com
 (2603:10b6:a03:48a::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6083:EE_|BY1PR11MB8054:EE_
X-MS-Office365-Filtering-Correlation-Id: 036fd86d-f4d3-4d20-102b-08de16ff15a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?e0aMoEYs1/SenXoEmLx9Or0Ss5uwo6cPMgO8emdS4N/X6S1V6E49OFVbyWd+?=
 =?us-ascii?Q?9ytr+hrOs3dCYkwgTw4evGtALWCvJ7ducdwjPlSHMIR5KBCUfC1ZsHv3VUtJ?=
 =?us-ascii?Q?e6KGxWLBWbsdVYypkHvfPYOoUVdDNQHMOOnFRvolbuUVxN9MCz3NYMfSzIv0?=
 =?us-ascii?Q?vCyGXJ6/mmQ+X5xy7guxuF+Byi4PcmmmXjlIqlIpwkI2BjjgEi6Q7al9S5+4?=
 =?us-ascii?Q?53s2IzDKc6z0MgbXGYDfIbwL/rx9aEX6EKfrFDVF1AoL51JTMExw3RGvJcwa?=
 =?us-ascii?Q?kwX1Es4FfepnB9SuD69cr+3Zp7AN98iVamCPoykFvK3RtFr2A7wF9PA1hEKt?=
 =?us-ascii?Q?6WBvD5m6hHgjoxdAiCSHpHRv/CnnwaCZBkZtcmACk3a5sGx/srag5GfOWukT?=
 =?us-ascii?Q?9DtdgWh1zLE4pEVU5SvYHlBS6ofdGO6oHOQAbcOcBUEkw74ko7jWb+7VR9hJ?=
 =?us-ascii?Q?Db1f2Z8HNpHcQ5XnbEUgvE/Zd1zFNzz/CZzmGDmt1Ypi6PNTh4uGEBiMI2xi?=
 =?us-ascii?Q?cEeC0k7LPXtXUL1VbmpOFkpep42wqi5OcrzXI8JgXbAJcZE7BmUm1Lpp/mTh?=
 =?us-ascii?Q?sBott6sePD/+GhidBawcej7q9fqeu0TElBrl2OO5eegULSWRxrcMx5b988cW?=
 =?us-ascii?Q?SXannp9iH2rSdsE/4s0cHfmO/ydihwWnM9cXZsdAxiwQU8MKdhYr+sG07+vr?=
 =?us-ascii?Q?EZH1RWJNc5hiUrinXAxcQH4pAMTnJ1/NN/BNhghnonlrNKCKWpoYKu9t9rpC?=
 =?us-ascii?Q?GAWULhj8temBJjM5wRFAYLIBZcmkmsNvbjLj2N6/OTt18liMChtlA5GEIlp+?=
 =?us-ascii?Q?NXF4NfSQafxUi1Hnm4VXqY13cKz0h3EJEo57svqyT9A5+a/B5JztSjULo1zl?=
 =?us-ascii?Q?xqCrLIzIyGrql9ZIBhe0FtQBhDJ5NU3sqrgTMoVUkOFR5dYYY+/pspJlNKAT?=
 =?us-ascii?Q?i3Tw2NExOB5P9X6AK9LRxcH05SvRxxopbaTb9ZGL2e9OgjzRUXuIAhXv+3WY?=
 =?us-ascii?Q?qeaINgqANDYr5pEyp7nUOZ5HvmgkhtWU1wO/xdT6uKg7J63/jorgpQYsELHq?=
 =?us-ascii?Q?+hMGg0+xwGbU41Gb2JluZF+5ODr6P7SIs5pJYd7chhWW2tn9qCfGETPB2Qkd?=
 =?us-ascii?Q?HmwM9cy4J7RrDQnMTKW8g2dbNP1Y6hsInxpjFBxKzlCpGDi0G7A2cLSuVnq6?=
 =?us-ascii?Q?X+oEW0tydaXYqjtJrdF8VtwopLjomF+z+KO5mdwMbhRlu/w0iTxO064G4bV0?=
 =?us-ascii?Q?Wcx28KPorV0X17KjDjV4GkTcj51Z5HWsckrLIgAk3CZcsA6roVU00dUpk6ar?=
 =?us-ascii?Q?fvvw11ylG4FenwTl58+NhQ6YE4pYyBHMMLjIBk5F5P6fwo9W4gHb4tc5vQ/O?=
 =?us-ascii?Q?nd/mqgrS6QYRtCNTKksySnxVXsLTDIzFMv14kyxXtD/ZweSJRhnXw6/8gCuw?=
 =?us-ascii?Q?vaU1/LZGi1YLleXA9kzveBP6Y2MWaDKZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RbiyHKyybxGCb3NeAa+tqI+ykV5gcwdyWzI5o2dVl7PXzvVyhsoCgH/Yd4ll?=
 =?us-ascii?Q?wrL8YWLbj9v4INQv+mEZq/d6oo59iwW3owD4x24zognWGwEwow5hkYjFM/Xf?=
 =?us-ascii?Q?esGH5x/CSnFT+THhtTbquZG7TNjFIzjHNxY73K/q3+fsQTQwpsmEE2vxoB//?=
 =?us-ascii?Q?dsyd92CmdoNci5qO45b2APeuM4eoZYe5BVOoIHhtznqs4PBJ/N2x2YRBBHNk?=
 =?us-ascii?Q?SgGN7RSGjQ2jIts2p6Tt2t7osO/fB/YtEeDXREbHOIPFCHa0nmrk0fhkHcSp?=
 =?us-ascii?Q?/8CIfM6uWqz9Kkj9Y7ZWSQ3aPlcGHH7vu8yuUpdxhFzyYoXMVB/40HDt99ch?=
 =?us-ascii?Q?PiIOBgz+BaG96gmPIxgnZS13aMUm5pp4fgdQ5a376RNrz3/S5BYCstysgJGK?=
 =?us-ascii?Q?QaCA0mCs8Vllzz+l/HbBkmekmr8T0Ouod5M6RLbKf5GNBO3Dwmm5mfnQzfbG?=
 =?us-ascii?Q?p46+AJZCKgWEiOpsza+qdg3K+KeU+2CKTUG0HcBu99165P8lmZ5vZRemIACc?=
 =?us-ascii?Q?tlXVG3zcCDDUkgayR/tAQVT3tsCpVwxwKPAo0KDamGtUj17swVh6d+an2v/V?=
 =?us-ascii?Q?gQpxkGiIafgXS1XF8vpI8k/896K72inX98i2/imInSwcMmJRO2xqErleF3a1?=
 =?us-ascii?Q?MO6D0k5O8ebT2IN/82N6LFDrH86R+aLJvDSZf17zqxfZF8aFd1ee5JSivBi+?=
 =?us-ascii?Q?jkQtiftuI/GiairqS7vFvF4AFfvwdrM5wGErkYOgs39UJNzKGDBMhDqQLdtG?=
 =?us-ascii?Q?kJaYmiXxm7PN0viUva/Ad2siX+NO2KyBclKIuzWczfjkQtAVYmc7qcvSQZSk?=
 =?us-ascii?Q?EYLY2p9e4IHEyO5HrPFHR1OwkeGN7I3MZLPOFC+LXHSzEe0bDHGt3SdBghap?=
 =?us-ascii?Q?gxfWRxQns9KOcoGu1C/mwGeftaR0PhnAvE0SEG+udN0JRHKGIFI8bai2fCRj?=
 =?us-ascii?Q?RYIsYGtE6L0Tug0jzvDJh8dmZPh+IIs8CwWbsdVJzGNk0/hwnn0hISMFc1Bw?=
 =?us-ascii?Q?CQ5xh2Nrh6s1ewzysy63QRV15qHs3lQO40tLOg8PiFJ3jXBm8pRe/EbR48om?=
 =?us-ascii?Q?MjqHvn/O3ViHxFa1e6z0F0sAZeJCQO02AODq1Xyy8+HriEa38ezYk3Nwtk5v?=
 =?us-ascii?Q?a2yvYMGgOHeef9XC6hfhVflgr5lkUpCipGAAccj+CtcU6EHOXGOESUxxbNas?=
 =?us-ascii?Q?RrJYV7dxWAtfvoujcO9BlgvEksXYZJpaUYjgfxq/N3zEgbTWhgjqLxFvo/qX?=
 =?us-ascii?Q?lLCItPugjIs1BokRvLlgnSfVNtS8GbpGxURt20bBX7HF+M6RgWGfHkyo0nw4?=
 =?us-ascii?Q?F9jaPkh0wPvPXFcmGZhKI7q3bUCJpKG+tXdZferVa/NYJfFo2wml4ignHg6b?=
 =?us-ascii?Q?/JYJ9X98FIQol/QQBuQ+Ky3ITplzwuTd0YaWwQovv+J8bzzCMG0u+JAB2eNf?=
 =?us-ascii?Q?MdgFQ3kwMR+WRv5RKhB6Txq2s721Y87NiiHK9r5cGGLieshcpS3m4xrp+g/8?=
 =?us-ascii?Q?XHuCHjPRrKJg/4T3ha8gxbd8iL5E5QURZaCJB0fQIHxA6oC3eBRkbYCEID0c?=
 =?us-ascii?Q?oK8G0a7Zp+2KgSsF/FSMeVa3HBYmwJl110PS3s9V?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 036fd86d-f4d3-4d20-102b-08de16ff15a9
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 15:23:18.2725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FZz3is1YzZawNxDlBcPChWa6VXtEKDuSb/1FKInUlIOxCTFv4Uh3UPInMTvOTwZQ1sutsi7STr9Ej1aTv9i8Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8054
X-OriginatorOrg: intel.com

On Wed, Oct 29, 2025 at 02:40:13PM +0530, Kaushlendra Kumar wrote:
> Add proper error handling and resource cleanup to prevent memory leaks
> in add_boot_memory_ranges(). The function now checks for NULL return
> from kobject_create_and_add(), uses local buffer for range names to
> avoid dynamic allocation, and implements a cleanup path that removes
> previously created sysfs groups and kobjects on failure.
> 
> This prevents resource leaks when kobject creation or sysfs group
> creation fails during boot memory range initialization.
> 
> Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
> ---
> Changes in v2:
> - Use local buffer for range names instead of kasprintf/kfree as
>   suggested in review.
> 
>  drivers/acpi/acpi_mrrm.c | 42 ++++++++++++++++++++++++++++++----------
>  1 file changed, 32 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_mrrm.c b/drivers/acpi/acpi_mrrm.c
> index 47ea3ccc2142..1718a35a5f56 100644
> --- a/drivers/acpi/acpi_mrrm.c
> +++ b/drivers/acpi/acpi_mrrm.c
> @@ -149,26 +149,48 @@ ATTRIBUTE_GROUPS(memory_range);
>  
>  static __init int add_boot_memory_ranges(void)
>  {
> -	struct kobject *pkobj, *kobj;
> +	struct kobject *pkobj, *kobj, **kobjs;
>  	int ret = -EINVAL;
> -	char *name;
> +	char name[16];
> +	int i;
>  
>  	pkobj = kobject_create_and_add("memory_ranges", acpi_kobj);
> +	if (!pkobj)
> +		return -ENOMEM;
>  
> -	for (int i = 0; i < mrrm_mem_entry_num; i++) {
> -		name = kasprintf(GFP_KERNEL, "range%d", i);
> -		if (!name) {
> -			ret = -ENOMEM;
> -			break;
> -		}
> +	kobjs = kcalloc(mrrm_mem_entry_num, sizeof(*kobjs), GFP_KERNEL);
> +	if (!kobjs) {
> +		kobject_put(pkobj);
> +		return -ENOMEM;
> +	}
>  
> +	for (i = 0; i < mrrm_mem_entry_num; i++) {
> +		snprintf(name, sizeof(name), "range%d", i);
>  		kobj = kobject_create_and_add(name, pkobj);
> +		if (!kobj) {
> +			ret = -ENOMEM;
> +			goto cleanup;
> +		}
>  
>  		ret = sysfs_create_groups(kobj, memory_range_groups);
> -		if (ret)
> -			return ret;
> +		if (ret) {
> +			kobject_put(kobj);
> +			goto cleanup;
> +		}
> +		kobjs[i] = kobj;
>  	}
>  
Need to
	kfree(kobjs);
here.

> +	return 0;
> +
> +cleanup:
> +	for (int j = 0; j < i; j++) {
> +		if (kobjs[j]) {
> +			sysfs_remove_groups(kobjs[j], memory_range_groups);
> +			kobject_put(kobjs[j]);
> +		}
> +	}
> +	kfree(kobjs);
> +	kobject_put(pkobj);
>  	return ret;
>  }
>  
> -- 
> 2.34.1

-Tony

