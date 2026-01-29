Return-Path: <linux-pm+bounces-41726-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJOzBvXCe2k9IQIAu9opvQ
	(envelope-from <linux-pm+bounces-41726-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 21:28:37 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D15B43D3
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 21:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 214AF30075E5
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 20:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD8935292A;
	Thu, 29 Jan 2026 20:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UU2tgCPG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76551350A36;
	Thu, 29 Jan 2026 20:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769718514; cv=fail; b=ezkpEUWh+hMvcd7jlJ7B5RupkKQGfrzm55lOhN3fDA/t8VUg8TpZvgiSYDIdWzYuDkLcGHXLS81hZoPIHbSz4ap+XL8imQEZYAKR8qbxpoKd/Hfd+1hKqaxRJTVmCXbSlDgpRLUScvu9ydLTPqQevJ2KATJsp673y6pfQmyXWpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769718514; c=relaxed/simple;
	bh=PVD6YbVGAtn+YSbiix/j/io1xtuVNUC0DzAnE+mkUOA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OlBKryyJ84MAhTQVhVjpQEtMXCUo+aH98Dh28RRZ5NyLKf28hL3YZB4bUXoKHIZtqo1+5ASJgARg82x3OdqfiEdocC78WDGGXuqNH4nwXo3j4jPZo8fGJEHN/fP3rQVe0UUQTAtVxv7avlyo+uN2NzQB2HC+sVjJekzOuCTqZYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UU2tgCPG; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769718512; x=1801254512;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PVD6YbVGAtn+YSbiix/j/io1xtuVNUC0DzAnE+mkUOA=;
  b=UU2tgCPGxHtsJL+qUiCog2rNqz8xdZ0n62IdnMRM/DrWTjm8oS7WZE+R
   2MqGwBU/PdkG+2wtNYjI5f5jtptYtj1fkNqnGY/cw5iNT7nrOkIVbDBvq
   nDL6jeEZ7nMWmf4G63E2jT65ktuCbBy784Xac3d587lX4g5sWv0J9XqaS
   KIBGl/FxMKxFphC/aWQM2JiKDhO1EOjlzkiHFnH6tWPwO68FeQEbzAXTz
   S2X83cg/bsHs/MDUjEszrX6SLVEn2vbTzo4voJZUcvinUp5DtptdRdfze
   tuwWdbIPU1tHRaZW+k51IpFbtKnmisd4RD8IXFS+K2m71CBOBNBWraAez
   g==;
X-CSE-ConnectionGUID: bBqDQzL0SF6aHkOaFBiJUQ==
X-CSE-MsgGUID: a/RLpXKMQQqxnOjHqQkJJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="88543296"
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="88543296"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 12:28:32 -0800
X-CSE-ConnectionGUID: 3BRp5zdBQpuaRIzAAWqrpA==
X-CSE-MsgGUID: dbi3fmm4Rj6PzdFpE7ijMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="208587382"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 12:28:31 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 29 Jan 2026 12:28:30 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 29 Jan 2026 12:28:30 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.47) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 29 Jan 2026 12:28:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SHBHPhDIotQ4ejZky95OmKBNrT6Z3Zef+xsgyKRPyt+ZJ5oV2mexPiyv901/vDTYoPlFTA66UZQSEH4X6hCriRABg2+veh2eIW7LLkHA7pMvFlYaSonKyddukX7A15P3wvKmWUeV3WwoqdnLeAflznzMeHPzKO6l8nH71C1OimBjD2rxNP55zddnsXNnzeYCqgFH1KWzgNU1XWdq9rX892dfm/AvIJ8ZwnutDyuiTyQBlopGJt6reMMr2O2PesNrqEnZXtieyzttBbTnGLyIVAgss8/osDnbS+SQRpKrC3n3pRZnDkaS6g5iIyREknWjSL3INclCTu7YrvPqUgYE2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d7jcPr1ZgexATUkrDN5V+08atRsRU4rC3A6uT2K12to=;
 b=mHuKtjbfvxADC/++IAhAHTffD1xTlRJGxLTqURYmwurQaHPIfgoGlqy0n9SjJvS19PVsp2P12DbF0uqEAq2xasl3+1/OyYQnF04cLl4YuK05zx+4A6F9OI4+LR/QURy03ed/+bcy4I7yWR1mZiza1/ep9t7Z4hnCD01fGHfeonZUR8Y9irWUty9PHabPH01IQapv0xxHKbw6Gx+uU8o3pJwF4xKLaFFJuEJQ37pL6kVE1fJZlXdeKTDytZlWzor08uAJS9u+wi1TYH417yDlA/YJeU5Vs/CtdotyZWdYd4QA4Q3Fe7PxKvAYawkRl7gE7kVcHiOjyO/FMxxRpfSbAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7215.namprd11.prod.outlook.com (2603:10b6:8:13a::13)
 by DM3PPF63A6024A9.namprd11.prod.outlook.com (2603:10b6:f:fc00::f27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 20:28:22 +0000
Received: from DS0PR11MB7215.namprd11.prod.outlook.com
 ([fe80::9201:63e9:3175:5392]) by DS0PR11MB7215.namprd11.prod.outlook.com
 ([fe80::9201:63e9:3175:5392%6]) with mapi id 15.20.9564.010; Thu, 29 Jan 2026
 20:28:22 +0000
Message-ID: <dd681a97-de37-436b-b09e-5173c1de2f24@intel.com>
Date: Thu, 29 Jan 2026 22:28:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] i3c: mipi-i3c-hci: Allow parent to manage runtime PM
To: Frank Li <Frank.li@nxp.com>
CC: <alexandre.belloni@bootlin.com>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
References: <20260129181841.130864-1-adrian.hunter@intel.com>
 <20260129181841.130864-6-adrian.hunter@intel.com>
 <aXu8TiFpMiIVk5Iq@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <aXu8TiFpMiIVk5Iq@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU2P250CA0029.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:231::34) To DS0PR11MB7215.namprd11.prod.outlook.com
 (2603:10b6:8:13a::13)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7215:EE_|DM3PPF63A6024A9:EE_
X-MS-Office365-Filtering-Correlation-Id: f59840a1-f7d8-4603-a841-08de5f74f23e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eXMycXEwZXgwQVpuRW1IWmxWZVI0K3MzczRIeTdDT2wvbGd2RkZjVTVSMFYv?=
 =?utf-8?B?ODRYWFl2Mjc4dFFKME9aR0JVQ3FRU012Qi80TzYzdWg4cTBoVDVHVTFQYVBP?=
 =?utf-8?B?R253anNtQlhib3Z4YVRHaDZhY0tIRFhGK3FjazEzZHZ2RnN1MkxSWHdZc2xF?=
 =?utf-8?B?R3d2dm53MzBLMGpvNkZvTTFuR3FhN1FEMkJOaEhERGdXYUY5WXc1Nm9VSUpj?=
 =?utf-8?B?VUZXZ09UV1lHcjI3bmtrWDQwZ0N6OVA0NWRyemNGbTlGb1FnRjgxSTROa0FE?=
 =?utf-8?B?eDlrQ2dQWDRid3JuUjN1cjJpMFdielZZVElFK2JkZnV6MVBLQUpYMVVDR0hH?=
 =?utf-8?B?ZnkyeFArT2N3b1Z4WW91V2Q5eVRCSlg2ZVVJU0hNMDFBWjZ4bWRiZXBkOXBt?=
 =?utf-8?B?ZVNORFBzaW9Md1Q5b1ovaHlTQlhuaE0rQ2dkQUk4WUtNMU1XR01rOUhVbHJa?=
 =?utf-8?B?SWxuSFZxV0RWcGVSRXBzdWMycXBDM2RLREdldTFsdVNxWU8wSjl2WVBZRmY2?=
 =?utf-8?B?SlZleSt1aGxaQXA4V1Rja0dGYjVRMlByWTlKZkh2TTB4dlRoY3puVUdRcis3?=
 =?utf-8?B?dDExZjdGdWNVYlNKb3ZTTjlZNzA3Q3hhYXRtNDEwZUdOby9YWXRxQm50NXEr?=
 =?utf-8?B?TktnclJaRVRrKzk5M1R1UCtNY21JSDBnRWlvL2JSc05Vc0JYR0I0WUJqeTRt?=
 =?utf-8?B?ejZ2cmt1ZnhCY0VZVGlXZ1RyYStHYnU1VThFWlg3N3Y2Mm5wNkQ4SklNYi9w?=
 =?utf-8?B?cUFRUVhPZHFIbEVROCtURzFuT1ZZNjZvQm03a3VhaDFBa25uRTJDSFdOczlC?=
 =?utf-8?B?YU9OdzJSS1c5NndmWGQxaVJtd0RLUGV1TUJpVVJiczQzUGkvazZmeG9remZ2?=
 =?utf-8?B?Tzg1WS9YbFVJTW40VHp4eE8yZHZ5d3NIaDQ2ekxNNENoVVZuV3poNU0wenh1?=
 =?utf-8?B?TExEZ1VwSWxGelJTRTU1YWloWVZrVG5sc1FpYnJEbEVvemxMYWE1VGVqa3dN?=
 =?utf-8?B?KzZ1TDlBeVdhU3laNktITzZEREMzSEFNRU1XVXRqYWdlSWliU0ZpaG5PVjBB?=
 =?utf-8?B?WEk1THJtRGx3bWFERHlBcUYxR3JWVkVHc0dFL1BuRkhrVy93OFhUdnRsc3Jz?=
 =?utf-8?B?Q1MrdkRYd1VSeXM5d3ZCNDRSM3hla0dRTE5NYWRTcWZVck5IN3Y5RHBYOVdn?=
 =?utf-8?B?c1pSVHZacHpMZnVQTERoeld1ZytmNkd5ZjZkQnVlWEZaKzA3L1pTWk81Q3U0?=
 =?utf-8?B?WnJqSXVrekZUTVlWSS80ZU9nVDlMYWhIaGw0QU5aZGF2bVNHNUlrZEp6aFNz?=
 =?utf-8?B?dHZRYWF5aUN6anowN0U0eEx1TzhJZ3RCeDJDSktEa01rdVdzL0w4T3hrVnh0?=
 =?utf-8?B?N2dMYndoUXd3T25nOVBLK1RYUGlDRFg0N3JVOEh6QXdVckxnYjl5S1hYNWpF?=
 =?utf-8?B?Y1FLNlhNOGNJMzZEb1lva1VGdEdxOTZhclh2Wmc4SHc4UFNhT0NhT0NjZnFp?=
 =?utf-8?B?bHJLZWl5MnNkUTRUeUtPZGlabHZSU2NGWXBWeFprNllqaERodlVJTW1uNmwr?=
 =?utf-8?B?cEJoNG1LSkV4a0xKd2lGTytES3hxT2lZam9zR1ZnRDRyQmd0TlNuUXBweW9U?=
 =?utf-8?B?SUlQc0tLQUFYUjliUENvVW9yMVpOYUpTam1GRUpyK1RYR3BTd2tveUt3cXc3?=
 =?utf-8?B?ZFlqRXAvaUdWaWhEZFQvd0k1Y0l5ZUI5NE9MMEpvdlhuQUFWVzUxK2dJRFBX?=
 =?utf-8?B?ZVNRZUtxc2cvaUtJamM3YWc5UktZQ2hnN3JybTFhOWNsckhVQ1YrVTJ4K2ZG?=
 =?utf-8?B?c2w1dWx1SW1SS1MzNVpYbjg5SUR1YktLcTRjN1VDd1l4ZHQ1aW1DR1ZaWHpS?=
 =?utf-8?B?Z0NaTHRybHo0UFBMZVJZOTVaRisvOU44WFRTUUE4V0hZNnF3bzVkOGVzeDRH?=
 =?utf-8?B?OS8rWmg0RFkvUXkvcjY0UHNTLzY4dGViakdBaTN6MUROdVEzUnRacVBTcWtV?=
 =?utf-8?B?N3B4THl6K0I4eHRFcVMweEhGS2pqRlkrQ0MzR3pSTGxnTkJtL1B4MUkzL3Fo?=
 =?utf-8?B?N0h0K09LOHNtS2ZjRnVSQnRNTlNXaU9XazJUQXhQTXNqMTlheXlnVHRQeldz?=
 =?utf-8?Q?4p/Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7215.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkZpSFFDZU1ZREt6NkRPOXVJMkpaNmpvQzYwODd6QXFxYldYeFBuYnJGTGVr?=
 =?utf-8?B?MDN4VElBSHN5R3JYT0NMc3RRdGVmR3FVbUdLN0RiUUFsdVJlTXRaY2o3Tmda?=
 =?utf-8?B?ZUJyRWp6RWRiVUJOWFJackwwUTUwNW1TcTVONndOaGhET0hLOTZrWXpwYm40?=
 =?utf-8?B?cDg0Yk55WnN3TFZsVldXMHJNaUVsOXhoVklkRm5SalF0d29ZOE5FcVpKTnBN?=
 =?utf-8?B?Skt1NmkrdW82SGh3S0RmamwzeFBVeEVCUTZBckJBN1l4MWU5dEdCUnlUcWxE?=
 =?utf-8?B?VDRRM1QrSmNEYWs0dnMwKzlzeGVNWXNPa2JYUEdsRlhldG5DOGFXL2dEV0lC?=
 =?utf-8?B?QUV6VlUyQjIzV3oreGVLV1FJSVJIT2h4WnRyOHRaUUhQUE1jMVFFcEhBUkxG?=
 =?utf-8?B?aEJrbWxXemQ0M01NdVVBaWtSTEdjalVSMGU1d29HYXBSMGRhcE45YWJoZ1BV?=
 =?utf-8?B?YWg3REx6UEppTFZqWUNXRWZrK3VLSGVId0JjMlQ2Rm9hM1h1UHM4UzBqcnRI?=
 =?utf-8?B?K2FDcjIrRGRsaTh1U29SWnBwR2pkam5CWU4yN3ZQdUZheXJjZDNpaEp5WTdT?=
 =?utf-8?B?NEpFbGlmdHhKaFpvblpZNEwvS3I1UGtzTUxYVG1TTkg2bVZkY29FUlNHVzQz?=
 =?utf-8?B?V1VBVWYzYXhDdTAwaUJhN1JZalhYRmdPdlVIdUNPL2czT1ZuZVllRUh3ek9F?=
 =?utf-8?B?d3FmUDErT3YwMmNoaEZxTVpvdU9CbEViN2M5clYrMldGL0tCY3ZqOFNCZm8r?=
 =?utf-8?B?a012U1psZk5oZ1ZsR2xldzlLZUp1Z3B4N21KNWczOFZxNGlRanVES2JYS1Q2?=
 =?utf-8?B?N29JRHh0Mk1HNEs2TFVlZ2hNYVZtcnlhVFBnSmlteGJQQ0E3anYxZlFHeldi?=
 =?utf-8?B?TUdwRnRReVVvSDBFTkFIUTJrWXVXMkQvaDZTdURON1BWUjRENjVINDNSRUk5?=
 =?utf-8?B?VWZPZndWd1ZwKytJMGZJY0dLditrNGtoOGVUQmZSWmh4VzZLYU9sZG1qZFdC?=
 =?utf-8?B?TDhuN05qOHdtRUhyQUR4WnA5M2JWY0oyaWJNRlErU2pYTFplZkZpbUxrREpT?=
 =?utf-8?B?U25xN01CYVBaQnh5WnExSlVmZ29wMVV4QTZ2N3FaQ1V3NTFuaFFiNDFNM25z?=
 =?utf-8?B?cXIwcURwYmFRd0NtcEtKeHFyeFNxdkxoby95ZmRtMHZoN1ZhYnJHbm9XWVVW?=
 =?utf-8?B?Ukp1dGhvSUdnTmxpRTI0SWpPNkRLRXF6SlEyWVZjbU9GM04vYTVjeC95WkRW?=
 =?utf-8?B?cWFya3dsdXZhMjNRV0JrcjYyZzFvbWxRTktlZEtpMXYyeUpHUHg0Uk1LZGFW?=
 =?utf-8?B?cS9EQjJHcFM3aitDenB1Tytqb2ozSUF3Z1hYY0g4dHNTUGhVTFZGcmQwT3lx?=
 =?utf-8?B?Z1A2eG9URmRIYlFlOU16MHdmaDdXNERyOEhzUUpLRkhpSUJYbUlNNHdzS2hJ?=
 =?utf-8?B?S3ZQTzBGaktoT1I4Tmp2amJ1M0ZleFBQS0EwNkc0aFUyR3B1SDVmTWoyaFND?=
 =?utf-8?B?d2l1Q01iZHFZdG5neXZVWkZzY0tXWnBOTk15WTJJeUJUR0hQYUdmQ2pjTEc1?=
 =?utf-8?B?UmpqcXlQWHkvdlF5Z2NuUkxBQklNRHU5TTVhb3BaYzZ4TGxxTXFlSGlxajhL?=
 =?utf-8?B?MWxQeWNXeGRaOGJpQnpIcGpKTzRQRUdLTXRHRGdITzNyUVNnVWhEcXZ3NnJX?=
 =?utf-8?B?Vk9wOFVGcDRDSEI5Q0hOWVZ2NGRWN1lZbHh1b0pROXpuMjduM0NpMDBuVTR3?=
 =?utf-8?B?YVdHbTFjR0I1YWxDWDQycWV4NlA3VjJnY01VUkp3ZE9acUxsV0ZwSHNCNmEr?=
 =?utf-8?B?cUJVd3RDMnJwSlpYcEluZm0rQlYxRUpNL21WU2s0eDBpM29IWGp4bjdQOHVJ?=
 =?utf-8?B?TkR0Q01kUlA4cWhwNE85UWFhZEtTMEhFTWRnb1NzWW1TVHZMWU5WVEhxMXoz?=
 =?utf-8?B?SHlTZzFXWi96Z0ZnbzE0b2tVaGd6cXN4RDhCd0ZwalhWMWgxRCtZZDJSRll6?=
 =?utf-8?B?QzdKNDl1dkdpaG1EOWxjcVBTbnQ4WWtvZ05rcUd6bzJ0N29pTE9mRkQ0VUYx?=
 =?utf-8?B?MXpMbElSNklCVjY0dDFMc3lwRW5iempUOGdtTm9Wb1phOXRTSmpnRmd3azRG?=
 =?utf-8?B?a0gzd04wMXJ1aEZQKzg3VmVHeHFMQTJURjdIUms2TWFibGVMcHovU2J5cGt2?=
 =?utf-8?B?M3BRbUdveGJ3K1c1UzBXcnFJSUlFYVAwcE40bnBzdTFSdVpRQ0d5YlVXS3lB?=
 =?utf-8?B?Tmo4N2pQY0s5Zlg1UWcvNEFIWTk3dEdaSkIzdFppY05rYTVmcWtDWWU0ZTFL?=
 =?utf-8?B?Tmp2VEZxb1lkTjl5YWFUeDZVSDVyb285VVNwU3VqbW4wME43UXhrZz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f59840a1-f7d8-4603-a841-08de5f74f23e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7215.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 20:28:22.0440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VUqdzADtJy5DFdAxjChe1rktAbXbvXKGAwrWR2vqayyZMgUQ7b/3mIpWbGErTChZT+Il96/H3bG9a56WIKdlBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF63A6024A9
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
	TAGGED_FROM(0.00)[bounces-41726-lists,linux-pm=lfdr.de];
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
X-Rspamd-Queue-Id: 67D15B43D3
X-Rspamd-Action: no action

On 29/01/2026 22:00, Frank Li wrote:
> On Thu, Jan 29, 2026 at 08:18:39PM +0200, Adrian Hunter wrote:
>> Some platforms implement the MIPI I3C HCI Multi-Bus Instance capability,
>> where a single parent device hosts multiple I3C controller instances.  In
>> such designs, the parent - not the individual child instances - may need to
>> coordinate runtime PM so that all controllers enter low-power states
>> together, and all runtime suspend callbacks are invoked in a controlled
>> and synchronized manner.
>>
>> For example, if the parent enables IBI-wakeup when transitioning into a
>> low-power state,
> 
> Does your hardware support recieve IBI when runtime suspend?

When runtime suspended (in D3), the hardware first triggers a Power Management
Event (PME) when the SDA line is pulled low to signal the START condition of an IBI.
The PCI subsystem will then runtime-resume the device.  When the bus is enabled,
the clock is started and the IBI is received.

> 
> Frank
> 
>> every bus instance must remain able to receive IBIs up
>> until that point.  This requires deferring the individual controllers’
>> runtime suspend callbacks (which disable bus activity) until the parent
>> decides it is safe for all instances to suspend together.
>>
>> To support this usage model:
>>
>>   * Export the controller's runtime PM suspend/resume callbacks so that
>>     the parent can invoke them directly.
>>
>>   * Add a new quirk, HCI_QUIRK_RPM_PARENT_MANAGED, which designates the
>>     parent device as the controller’s runtime PM device (rpm_dev).  When
>>     used without HCI_QUIRK_RPM_ALLOWED, this also prevents the child
>>     instance’s system-suspend callbacks from using
>>     pm_runtime_force_suspend()/pm_runtime_force_resume(), since runtime
>>     PM is managed entirely by the parent.
>>
>>   * Move DEFAULT_AUTOSUSPEND_DELAY_MS into the header so it can be shared
>>     by parent-managed PM implementations.
>>
>> The new quirk allows platforms with multi-bus parent-managed PM
>> infrastructure to correctly coordinate runtime PM across all I3C HCI
>> instances.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>  drivers/i3c/master/mipi-i3c-hci/core.c | 25 ++++++++++++++++---------
>>  drivers/i3c/master/mipi-i3c-hci/hci.h  |  6 ++++++
>>  2 files changed, 22 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
>> index ec4dbe64c35e..cb974b0f9e17 100644
>> --- a/drivers/i3c/master/mipi-i3c-hci/core.c
>> +++ b/drivers/i3c/master/mipi-i3c-hci/core.c
>> @@ -733,7 +733,7 @@ static int i3c_hci_reset_and_init(struct i3c_hci *hci)
>>  	return 0;
>>  }
>>
>> -static int i3c_hci_runtime_suspend(struct device *dev)
>> +int i3c_hci_runtime_suspend(struct device *dev)
>>  {
>>  	struct i3c_hci *hci = dev_get_drvdata(dev);
>>  	int ret;
>> @@ -746,8 +746,9 @@ static int i3c_hci_runtime_suspend(struct device *dev)
>>
>>  	return 0;
>>  }
>> +EXPORT_SYMBOL_GPL(i3c_hci_runtime_suspend);
>>
>> -static int i3c_hci_runtime_resume(struct device *dev)
>> +int i3c_hci_runtime_resume(struct device *dev)
>>  {
>>  	struct i3c_hci *hci = dev_get_drvdata(dev);
>>  	int ret;
>> @@ -768,6 +769,7 @@ static int i3c_hci_runtime_resume(struct device *dev)
>>
>>  	return 0;
>>  }
>> +EXPORT_SYMBOL_GPL(i3c_hci_runtime_resume);
>>
>>  static int i3c_hci_suspend(struct device *dev)
>>  {
>> @@ -784,12 +786,14 @@ static int i3c_hci_resume_common(struct device *dev, bool rstdaa)
>>  	struct i3c_hci *hci = dev_get_drvdata(dev);
>>  	int ret;
>>
>> -	if (!(hci->quirks & HCI_QUIRK_RPM_ALLOWED))
>> -		return 0;
>> +	if (!(hci->quirks & HCI_QUIRK_RPM_PARENT_MANAGED)) {
>> +		if (!(hci->quirks & HCI_QUIRK_RPM_ALLOWED))
>> +			return 0;
>>
>> -	ret = pm_runtime_force_resume(dev);
>> -	if (ret)
>> -		return ret;
>> +		ret = pm_runtime_force_resume(dev);
>> +		if (ret)
>> +			return ret;
>> +	}
>>
>>  	ret = i3c_master_do_daa_ext(&hci->master, rstdaa);
>>  	if (ret)
>> @@ -812,8 +816,6 @@ static int i3c_hci_restore(struct device *dev)
>>  	return i3c_hci_resume_common(dev, true);
>>  }
>>
>> -#define DEFAULT_AUTOSUSPEND_DELAY_MS 1000
>> -
>>  static void i3c_hci_rpm_enable(struct device *dev)
>>  {
>>  	struct i3c_hci *hci = dev_get_drvdata(dev);
>> @@ -962,6 +964,11 @@ static int i3c_hci_probe(struct platform_device *pdev)
>>  	if (hci->quirks & HCI_QUIRK_RPM_IBI_ALLOWED)
>>  		hci->master.rpm_ibi_allowed = true;
>>
>> +	if (hci->quirks & HCI_QUIRK_RPM_PARENT_MANAGED) {
>> +		hci->master.rpm_dev = pdev->dev.parent;
>> +		hci->master.rpm_allowed = true;
>> +	}
>> +
>>  	return i3c_master_register(&hci->master, &pdev->dev, &i3c_hci_ops, false);
>>  }
>>
>> diff --git a/drivers/i3c/master/mipi-i3c-hci/hci.h b/drivers/i3c/master/mipi-i3c-hci/hci.h
>> index 819328a85b84..d0e7ad58ac15 100644
>> --- a/drivers/i3c/master/mipi-i3c-hci/hci.h
>> +++ b/drivers/i3c/master/mipi-i3c-hci/hci.h
>> @@ -147,6 +147,7 @@ struct i3c_hci_dev_data {
>>  #define HCI_QUIRK_RESP_BUF_THLD		BIT(4)  /* Set resp buf thld to 0 for AMD platforms */
>>  #define HCI_QUIRK_RPM_ALLOWED		BIT(5)  /* Runtime PM allowed */
>>  #define HCI_QUIRK_RPM_IBI_ALLOWED	BIT(6)  /* IBI and Hot-Join allowed while runtime suspended */
>> +#define HCI_QUIRK_RPM_PARENT_MANAGED	BIT(7)  /* Runtime PM managed by parent device */
>>
>>  /* global functions */
>>  void mipi_i3c_hci_resume(struct i3c_hci *hci);
>> @@ -156,4 +157,9 @@ void amd_set_od_pp_timing(struct i3c_hci *hci);
>>  void amd_set_resp_buf_thld(struct i3c_hci *hci);
>>  void i3c_hci_sync_irq_inactive(struct i3c_hci *hci);
>>
>> +#define DEFAULT_AUTOSUSPEND_DELAY_MS 1000
>> +
>> +int i3c_hci_runtime_suspend(struct device *dev);
>> +int i3c_hci_runtime_resume(struct device *dev);
>> +
>>  #endif
>> --
>> 2.51.0
>>


