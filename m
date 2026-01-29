Return-Path: <linux-pm+bounces-41728-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id jRNqJVXGe2m7IQIAu9opvQ
	(envelope-from <linux-pm+bounces-41728-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 21:43:01 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D40B4508
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 21:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 113E03014125
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 20:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BDF358D21;
	Thu, 29 Jan 2026 20:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="di7nVnBw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556CF3587D0;
	Thu, 29 Jan 2026 20:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769719378; cv=fail; b=KmSVX19yxfIqCzIpVCscOA75iW3+3iT8r2u4e7+26HiYL93ww79IikdKObA4qtVvwibjLobecqAZUWxL5jYK03VHp298D6YGifJLOE0d6ts77RGflSCVKy/CfwKyagCaV1Zh4eQgeMmQ3JKYsf+pkNl4k0Qofvmxi/unMqGkbes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769719378; c=relaxed/simple;
	bh=nHKKDmLCUfTA+nNFvxw0CzhQUlL91vF/eqfWAbt5SeM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SK/PTa/3nlvWVei88+uZpiBSU1aD0HsqEcH3AzNInm2aKef7N+rWqunUofEerB6P0C81bc0PkSWGJOCh02MEB9yzDXJP+ZXcZdkgAUhr6yKpmnAlDiQNndNq8n0i0DxHUehzy+0yMxb0OX6m+L2IuLJmeAM2Ct1YbiU7/HJbxnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=di7nVnBw; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769719376; x=1801255376;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nHKKDmLCUfTA+nNFvxw0CzhQUlL91vF/eqfWAbt5SeM=;
  b=di7nVnBw3FGEqUy4fHIYGfWthN5xRejJN7Ml89QLvUAkGNFr1XezEdDm
   5jnajpnZHV3TAxBG/fqU2sO6wdSxcmwjh+cheG61Nk+0A8chioEpG3q0T
   pD6hgAaeBHXRoEba0cumOBC2lphoSONJmmBd9GslHilrqMPmhw0f7gCAc
   Bq9lrHEUqlNPQQhqBNlvpEOCEWy4tsBL0GR0dtW6HxkfckcQwOZG1V6Pc
   WLvEJ9dOrB4Rq6NDxX9mqpD8P1i3IVN05Kut6sQkxjniG38PxXx56SumD
   tekAksL/LmJVhpTGd+qZix7yA1VPrK0kI4qxdCTbFNsRB529zy3/lB7Le
   A==;
X-CSE-ConnectionGUID: vBdHiO/RTsutN/VkeS7f+Q==
X-CSE-MsgGUID: 6TXInJo1S+GDyBT763Phvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="81705923"
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="81705923"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 12:42:56 -0800
X-CSE-ConnectionGUID: Qvg+9ccHRueIE+y75yDm2w==
X-CSE-MsgGUID: DoQQajIVQUKj9ZNEbpFOdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="239401158"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 12:42:55 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 29 Jan 2026 12:42:54 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 29 Jan 2026 12:42:54 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.65) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 29 Jan 2026 12:42:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zFSDKqHSO9In30tqVpFhqkRl2DQfvNk25puxeiZELuXh/ZYD6gLcFEt+NhW3xKkK2XDG4v1W2LKCnp+Nr6ShEywMe8DFtfN/kKhPZgJnV32SQnINaRWNoHUxwt9slB82rwdsFX+FfwwemZyptFvC2NBaTNSZyJFps7sQgFjav1GlupXpNpq9d1yIfEnNnNJbm14PFh2PYSP91gn8293r60AwrPFmcwVaxy6k3vNyFLS6Xgnd7GCfE5qZ9gBHuUZ13G2QGyg/n1AfsOK084aP1BEN2Cddt849aeuGDB4UIQ8MSP/oLBpKtTJLOAWyqrgI2Ys0bg7Jz8RR+oXx7kqbSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mgZo7u4kqiu47QC1Pbk2m2xHLgE240U2XprgYRA2YiE=;
 b=eIQoahFepGpYb0VwQkYoQujIjJHEha+nm9c1g8pUy22PPbmrIjBIuT8ntQ2cI6gN2Bo54QLXK55rrCRsQcq/74xZdzqTimC0UpoS5xMD0f16IXYv0kHkcetwhZT7rK5Q/MJj5TbzUsfZSxSb2mEcHae2EZYE+w3S/ikKUhP6hrkC9P2h/iwhCV08QW19JjvmH3J4KvULb604aPhXVRYn7mHcvcNaGx0oZ+3m1l6kHc1Nk+ZCqmRk/ym+Q7MCw2DuJt+TDRfGFGh6UUMSe4fkdMs6ECAOycx8W+iZ4F8ZsBvbLdcTzi+ID/OzONkrxVVsPnC7l1YbHnlz6GDSBfWFTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7215.namprd11.prod.outlook.com (2603:10b6:8:13a::13)
 by DM3PPF1721FD39C.namprd11.prod.outlook.com (2603:10b6:f:fc00::f0a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 20:42:53 +0000
Received: from DS0PR11MB7215.namprd11.prod.outlook.com
 ([fe80::9201:63e9:3175:5392]) by DS0PR11MB7215.namprd11.prod.outlook.com
 ([fe80::9201:63e9:3175:5392%6]) with mapi id 15.20.9564.010; Thu, 29 Jan 2026
 20:42:53 +0000
Message-ID: <1db7b04b-ee65-4791-8db5-0dffc7befca2@intel.com>
Date: Thu, 29 Jan 2026 22:42:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] i3c: master: Mark last_busy on IBI when runtime PM is
 allowed
To: Frank Li <Frank.li@nxp.com>
CC: <alexandre.belloni@bootlin.com>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
References: <20260129181841.130864-1-adrian.hunter@intel.com>
 <20260129181841.130864-4-adrian.hunter@intel.com>
 <aXu7UduYCweVLxdK@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <aXu7UduYCweVLxdK@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0058.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::12) To DS0PR11MB7215.namprd11.prod.outlook.com
 (2603:10b6:8:13a::13)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7215:EE_|DM3PPF1721FD39C:EE_
X-MS-Office365-Filtering-Correlation-Id: cff641c6-69e2-4023-1d20-08de5f76f95a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ci9mTEtpZGxqSWRtSXAvVkRteDN0YWg1dGo4NlFXWDVONmJaWW5WR1FZaUxm?=
 =?utf-8?B?TDhoOWpiekhhN3BFRytyNU8rZURsd3BPQzBPVnZsZXJmWFlTUHpRdFdMTWJk?=
 =?utf-8?B?SWpJeUVaRVNOY3E5MzJiNnQrbnMwNU1qTE8vQnk4V1FUTzlVdWJRYUJINGRq?=
 =?utf-8?B?QndHV1ZSZ1Y4UGsxdTRhWGZSa1JiVFk2L0hGOHBGVkRzUU9HSGdxVnZUSmZT?=
 =?utf-8?B?TWN4NTF1aHpzZzdsVUpnMFVCN0wvVDZnSEdGU3hnTDEvUmFieWVRK3lmcXI5?=
 =?utf-8?B?cXZqZy9odlNqSE1CQVBTUlFTWW0vNlpBWktEU1lwQnF2ZHluNzhEc0dNYnB5?=
 =?utf-8?B?Ri9iVlh6bWM5NThMVDhkMU9XN3FZWFZBUXVXVVIrTlBhcUpQeVkyT1EyQUJB?=
 =?utf-8?B?dm1oc3JFa0JVR3FZU1hqbnplV2x4MS9HVk13ZkVpY0Fmdm5XamtVL0xJRXBz?=
 =?utf-8?B?T01IT0FzVWxxM1cvY2FlRWQzcURUOFVaeXdVSk9oblJ5UkcvbmxaYTdQemcz?=
 =?utf-8?B?aHhZaVdpWFIwM056OHBtVU9vd1pNdHBlRHp2VGVETW1vNkFhTkVZc1hmQ2JW?=
 =?utf-8?B?cVkyMEZicmpnSHJ4NzZhNE43dkVvdSsvUTJ0bE0zNDVvRkdJQ2I0Ky9YZXlG?=
 =?utf-8?B?WVhyWTFRNmJkM0YxM2pHN21NUDBKYmdOL3VDRGQ4dXA1bG1DT29raWV1bXQ2?=
 =?utf-8?B?bFZ0dXhuTVByREJRWlliNTJqQ2tYR1lhM0kzblI4c09rK0Z4Zkx0MXA1Umlu?=
 =?utf-8?B?ejFTd3JhUHF2bC9WNVRWczFoTWw0NGFkL1p3YTVKWG1mSzlYYy9KZkxmMjk4?=
 =?utf-8?B?dlJPbnFyMDFxQVpURXdPeWRDakVMZ2NrNkNocjZra1BpejFrZmVZRC8xWDNW?=
 =?utf-8?B?Q2NFNDk3blh5TWp6SlpqK00xQlpRSnNiMmlENlF5OEVRYkFiNTN4RW14TnAr?=
 =?utf-8?B?bSs3VFd1V1JtZ1U5TEJnbm5WVEVQS3hMWW5jb3BjdkhMU0lDVTZNcmg4V3Iz?=
 =?utf-8?B?aTh2OFQ4MDM3OTYvY204TytNVmdOS2ljUFlzMjB2TC9hcGZtVzZwM1NtSFJv?=
 =?utf-8?B?bUtUeHcvZCt4ZUdPdkV5cHBuSkJ4dWhYZzFlZzdxUjY2NnZtZ1RmcmEyNU5s?=
 =?utf-8?B?d25PYVp0V2FtUC9wNmpCeHlMbEhqYUd2K3RPdG1CaS8xcGo5VUhWWHZxL2Jy?=
 =?utf-8?B?clZQOXBRSVFMLzBtL3MxQ3RORWdoVlNPcTJTQmR1TU1Jd3RlRmtOaStTSUVK?=
 =?utf-8?B?R1BLVGtManRiU2tySDMwZWhVU2l3UURzZTlqMnpnK2ZIR3p5U0svbmlMSERZ?=
 =?utf-8?B?NXZhbFUyYVJheU9oREZIbXNseFVNVkN6OHl1VXBBd1J3RW41ekFRUFRVZnEz?=
 =?utf-8?B?SXVSMllBTGZWYS9PQ1pDN2Vwd0YrNGdTNHU2a3V0c2tGRHgrTkNuYVErSG9n?=
 =?utf-8?B?WHU3RjMzSmdoZ0ErU0FFUEczZXRjK3pWZ3B4MldjYVlJN0p3OWdkdlJZTXVT?=
 =?utf-8?B?TjhLNjhYN2FuZHhJVm1aVnhDbitvcTRyaFAvVWdHWTdGOTZWS0ZuVHpSS2Zi?=
 =?utf-8?B?ZDh3ZHJtb0RtUXcvZTdBcXhQdjJVMDE4WEJwMDhPazdIb0VJRFpGQTRRLzh2?=
 =?utf-8?B?SGlBREg0MVRLSHRyYTZvbDZDcmFNRWFxR2NWeFMyKzZjQ1lUVXVSaUlxSmxU?=
 =?utf-8?B?eW9LRGlDeERGUTdZdW0xV2NIcWdqOGZXRGRYZmFtMjFhTnNHcEtsUTJnYzN6?=
 =?utf-8?B?bk91azBlSFhOYTliMEw1WFBWMVk5YVRmM0pRYVYxODlreGNpY0IraUsvZzNW?=
 =?utf-8?B?U2NWYkJUNmJJRHNqNE1WMzBGeit2SCtkekVzLzNQUkZVUTBjS3FDT2xXQnFH?=
 =?utf-8?B?dmFOeC8vOFk1YmZubEVsSExsV3RxSEpEV25USUs3cHluMElXQmFNc0JDREZ3?=
 =?utf-8?B?dGk4dmw1U0tRZktTV040b1V1emUva1VnNnZyM016VTYraytHeDFvWVR0WGR6?=
 =?utf-8?B?Mm9jWGhBZ01raG80TW9UMnJ4VE5Nd05NU2hDVndrYWVKRXZTRkdsOWlhWER0?=
 =?utf-8?B?YXMyUTRRK1BJWlloWko1QW54aDNjVm9IMUI4VWtKVEhDUXYvc09FclQzZU5V?=
 =?utf-8?Q?zxcA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7215.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUhpVE9ncUhDQTNQbXZQSWI1Tll0dlJUclpKMWN1b0VjOTh2cUlVeVlHS1FS?=
 =?utf-8?B?Y0NwRDY1ZkRRTlhPRm4xNStlRTk0YytzOHIrMlBaWEVXWDNiemZoWWRNTDEy?=
 =?utf-8?B?Um0yclRydlp5MzkwZTN3dEcvSXpxMFYzMjN4VWJScklLUVBTT01yZUt4azRo?=
 =?utf-8?B?ZUR1d0M0Wng0a2lPRGdYbmpNcllxbXpDWWoxUzdJbXQreE5HK2d2N1lqU1Vn?=
 =?utf-8?B?QUNXTzFWSFYrMEc0ZzVPMks5Z3VWUzl0VHdpdURFajhTSEhxbmQ5NVRlVDF0?=
 =?utf-8?B?b2ROcC9TMC9jOFliTmdZcDRwWGJUS0NvSE9tazN1NDRDazl6b3dhcHViUWlL?=
 =?utf-8?B?Q3V4b0hSdTFsVWhNYk1YR24zTVJiMHBiVHlGSkppTjJhcEk3UHBNOXllVmox?=
 =?utf-8?B?WlZodVZjTUVJRm85ZVgzZitJc0FHT0NodkdvMytpUTVtalZ3SSthU2tPV2tj?=
 =?utf-8?B?S3hhbHBVSFBVUVRyaEZQdmhqcEozSzZFeFpETTBpZnRsL01WVmdYaG51Y1No?=
 =?utf-8?B?cXhxSkt0c2Rkc1J6bWFGeW9kOW0rWmdaRE5obXFXTXpldHY1Q1hsaUxwVXVm?=
 =?utf-8?B?eHRVUlIwQUsxcXNwM2pQWHgyVzBDbURRYU5XL2MzY0hHOHBkVStwMUNYdTc1?=
 =?utf-8?B?b2lzekdMcC9lTk1DcUZmbXQrQkI3YU5HczRReTBXY2hOM1AzdTlJODgzMUpZ?=
 =?utf-8?B?Mit6WnZQbDY2ZnF2R1ZVYmJwL2hKRHBFM3lDdE9iblZLdk1nQkNQb2JzaDIw?=
 =?utf-8?B?c2szQm1wTHJDeXJ2emhDOXFoZ0ExODBWQ1ZUa0Z3UGRaeGxlWlVGcDZFWDhG?=
 =?utf-8?B?SUlXZGx1UFpVVEpQdHkyaHE5ZW02SHJuOXhSQkwzUUh4dEwwVDVKdWJJN1lJ?=
 =?utf-8?B?eGxVWmFsUlkrc085cmZhM3N1WnYvYjVoTWRUaERPUFlzRWN3WGdIVkZoTGVm?=
 =?utf-8?B?bGZ0cGdrRUJHQ2taMFl4ZTViaHB1dDhZczd5dHZoemYyem5FTS9ROS9hUGZ3?=
 =?utf-8?B?U0FRK0JMT2NNYndXcmJFQTJoMUpyY0YzbjYvT01lWjAzNkNRdDd6RFNPajRu?=
 =?utf-8?B?a05KMDNJTElWQVZQTnRUM004NFM0aDlKTkJXK0V4SndmYktlUHlycGgvMllY?=
 =?utf-8?B?dnJpVzJPbkxIUlovQXUwQ09VMXRvUGNlSjFwSHJUWDZUS2docHF3MDJjUEQr?=
 =?utf-8?B?SDB6eEtQcGxjaW44aEZIclVtWHc0ZmFrdlZJSmlWVmZQZU1MZksraS9jNWls?=
 =?utf-8?B?VFN5Y2pGSGZtckQxdmF6ajVmeVZXUVgxNUxEWncrM1oxcTJ3Rml4bXExOE93?=
 =?utf-8?B?dUNkVWF4a1ZpcjNtRTFybGtsWStTSUpDN1dXallWNzgyWTNtMXdtVkRHYlpk?=
 =?utf-8?B?Z21CKzBJTU55a3VnQWtEcEhzSDZYK1grTld1azZRbWZIMnVkbGlQVENSU3RE?=
 =?utf-8?B?WTZxdFNqeTFIR2M4enZoQXR5RFpNVVA0bnpDd0VXVzJIeTV6NEplR3pQZVZE?=
 =?utf-8?B?VzZyZGVXcnJMYWhIbVZmQnlJcXYxM3ZOOEszRkJ1MXoyRWpmSzV6dmJ4TVUr?=
 =?utf-8?B?Nm5DclZneXZqcElFL3J1TmxFODVMV05IY0RqY2ZQUUc4NFhBVWhCMk9sY0JS?=
 =?utf-8?B?YUdIRmNQZXdLWVZrZ3pBS2NJY3ozd2tRbTBYTklVelNQNk5Kd2FIREFTNy9p?=
 =?utf-8?B?a2M4dHBUSWhQcDVTYlV2Kzg4SC9Nb1FLbEdVVW9ST1ozdTV5NlNZRFhMS2Q2?=
 =?utf-8?B?MlppNDVHeldEZnFGcndFTGpCOUVlU21HcVNRYTlhcDNhRk81Z3dBSnMra0hW?=
 =?utf-8?B?N05XSlE0cW54ZUJUWUExRm1FTi9TTHI3cGpnblEvMmhWNld4QTE1K21kcVhv?=
 =?utf-8?B?ZnVKNzMxZVZLQVBLc0owakMrTlpzenVDeUkwWDdGUVpsOWRsVUliQ282NEM1?=
 =?utf-8?B?cjJCWkt4dkhsWnNhNjdLbUdvckNyRWlOWURnY0VpL2RoQ2FZaXJrRGJodGZW?=
 =?utf-8?B?Q29kYVVlb3ozaHRNTzI5bmdsMWx1dHJaVTlKZWVxZXFleENXRWRhOWp6UVMy?=
 =?utf-8?B?V0Y1Nm5ERkQxMGJaRjVBdnNPN0VBeVhDTkJJQWRqSTU5a0krQmw2amEvY2ZI?=
 =?utf-8?B?U1dwc25Fbyt1OWJwYkU4czFTRkRINE1waXZITmFGeGg1UlhqZldHYVNsL3Bz?=
 =?utf-8?B?VXl4NFlINFIvaHZyWE1yRWxUL25UdUFZcm00eVRBUDRmWmhtU2JRVjJoT09Q?=
 =?utf-8?B?dUZ2cU5TRmRGdHVhUE52L2JrQnMrbzRKSmZxcnJXaU1DSW14eTV0N25xU1hD?=
 =?utf-8?B?ZDJGRTJSSi9yblZ1VzlNSnpkQzZ4Rm9yR3hzamZQYXdYV1k0dzIrZz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cff641c6-69e2-4023-1d20-08de5f76f95a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7215.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 20:42:53.0172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A7n9CCyETlZLdPWDmo7pej6XCYtY2P/DlsdXMg6H1pIim5XZvXTluqhpTeTkvP41HUwyGXZCoUI1CN6zsCw0OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF1721FD39C
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41728-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adrian.hunter@intel.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 87D40B4508
X-Rspamd-Action: no action

On 29/01/2026 21:56, Frank Li wrote:
> On Thu, Jan 29, 2026 at 08:18:37PM +0200, Adrian Hunter wrote:
>> When an IBI can be received after the controller is
>> pm_runtime_put_autosuspend()'ed, the interrupt may occur just before the
>> device is auto‑suspended.  In such cases, the runtime PM core may not see
>> any recent activity and may suspend the device earlier than intended.
>>
>> Mark the controller as last busy whenever an IBI is queued (when
>> rpm_ibi_allowed is set) so that the auto-suspend delay correctly reflects
>> recent bus activity and avoids premature suspension.
> 
> look like this can't resolve problem. pm_runtime_mark_last_busy() just
> change dev->power.last_busy. If suspend before it, nothing happen.

It should be effective.

rpm_suspend() recalculates the autosuspend expiry time based on
last_busy (see pm_runtime_autosuspend_expiration()) and restarts
the timer is it is in the future.

> 
> irq use thread irq, in irq thread call pm_runtime_resume() if needs.
> 
> And this function call by irq handle, just put to work queue, what's impact
> if do nothing here?

Just premature runtime suspension inconsistent with autosuspend_delay.

> 
> Frank
> 
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>  drivers/i3c/master.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
>> index bcc493dc9d04..dcc07ebc50a2 100644
>> --- a/drivers/i3c/master.c
>> +++ b/drivers/i3c/master.c
>> @@ -2721,9 +2721,14 @@ static void i3c_master_unregister_i3c_devs(struct i3c_master_controller *master)
>>   */
>>  void i3c_master_queue_ibi(struct i3c_dev_desc *dev, struct i3c_ibi_slot *slot)
>>  {
>> +	struct i3c_master_controller *master = i3c_dev_get_master(dev);
>> +
>>  	if (!dev->ibi || !slot)
>>  		return;
>>
>> +	if (master->rpm_ibi_allowed)
>> +		pm_runtime_mark_last_busy(master->rpm_dev);
>> +
>>  	atomic_inc(&dev->ibi->pending_ibis);
>>  	queue_work(dev->ibi->wq, &slot->work);
>>  }
>> --
>> 2.51.0
>>


