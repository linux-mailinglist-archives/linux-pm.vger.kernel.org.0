Return-Path: <linux-pm+bounces-41988-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIM0HiYqgmnFPwMAu9opvQ
	(envelope-from <linux-pm+bounces-41988-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 18:02:30 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7DCDC6D8
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 18:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DA7D302C93A
	for <lists+linux-pm@lfdr.de>; Tue,  3 Feb 2026 16:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8793D3307;
	Tue,  3 Feb 2026 16:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dJf671tS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F0A1C28E;
	Tue,  3 Feb 2026 16:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770137868; cv=fail; b=GGkAH5OMN3hGc6AD2wnrzkImcfc4y2NReT31lkv36dncXwHrZ3Eji89k8LTWonlVoa5aOjjtlgCn7vJlU9gf2jUo0JpSDlC0thxV3ZjOBMSqP2WcxH7GtFJgGrPp2yHMGuxYSWDTS570A//QH//Xg+oFvx9cl1kbtIHB3CQ0LLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770137868; c=relaxed/simple;
	bh=cvglmhVE4U+NT9oOtOyx37JZcyTmYDVDDDZdIH6PpwY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=luUC/FIebOiNBxfD8ZUnOy8BUkfQ5WkuTD1dI/FemJkjlkZyY6anzxYCL8lhxn8/6goxdTOKjkDNmH+V3lXUqcggTV92aFYGyYkc4Aoj3lWySdjOKHITONgot/THYVhv/DEwt2SBfS9DnxsudyCbzf4XibtcZP+maYmuEeuXBd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dJf671tS; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770137867; x=1801673867;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cvglmhVE4U+NT9oOtOyx37JZcyTmYDVDDDZdIH6PpwY=;
  b=dJf671tSyR3tMvFzzlEyzazrD7c0dSVJPo02mjDwL5fMI+vYvj+pqhsj
   C/5q9KnXx2JbzhxLbWOBaA4t6AJsUt/WJyN43ugCPDB0/WVROMf6g8rTV
   6mYQjAq5qpOQICHv3NiXfFuaBVE9FY9G71O2HAAxUtUeECwHcHN3KYk7h
   lrBnPIEWZ8wwAJr8djtX0cYcwez5DeBvyILeM1YBSt+Zxx5hKNuy5UV/f
   hBn7dEn9Z/ISe6+fh0RZL5qlTbc1W4nuzimG0zFaOpH9MemEC0LYEJRB4
   3mPJd38d/v5eyOJ53G3u0KJOZriABrCKcp0QI5w7ray3Ji95SLIH0mO8A
   w==;
X-CSE-ConnectionGUID: dEbzVRVERbirj+h3hTu69Q==
X-CSE-MsgGUID: tVDvFG4xQAega/otKHutxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="75167630"
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="75167630"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 08:57:47 -0800
X-CSE-ConnectionGUID: xWTqekugQyOKaqQKl9kS6A==
X-CSE-MsgGUID: /UQyoYSyTrmtuB2jyKyYwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="214382311"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 08:57:45 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 3 Feb 2026 08:57:45 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 3 Feb 2026 08:57:45 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.11) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 3 Feb 2026 08:57:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yNlKrC3AcFiviTC6jlfeewfDoacQaqi1+l8/c1LiYDbP4JGnBzxCTMDy5t3CftMTRtIWJt8PxbWD3YEFR8w9ViNITODICxFK3UpduEyEOuPj4mQn6h9O1bm2g9o+lhhlwy0UHiWoDU/zhozzpvfmhSxLNOhDjUWITD/PK/YQNH4SUELliwWBTygV+v6DNySIHg+cM6rP3LdKwwzU99UGioT1T0alU3FaYr5DuzjwmkDvmOLq81o/w6GsDsxufUs+cg6GnTgGaWTKKc2Wdhg982PDLoUTnLPlo/r/gvqYOkoiWy6dSTAnj6IX/ItURem45vHf6qdEOMfF05ALEpA05Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ns+Vra0zIZ9RItn99IeDf0f0FCdw6SgciIEq5r2wETw=;
 b=HFAf9n8xabky02Jiv9wqFpeO0OeKV+Fh02Gm6u5sRwIgFOYTM/vpGIz7WcF8/iTCfGhV8aUbx0kN4cgcizDS0EHsQaTz7fUqSSOVfKsQJwXJ1gEZpfibzCr2/3wziz6Ra4bJv5YV5Mv32aBF9E0mlBTRo37JR5DYGjrAJJdSS7g+sgYnOlIBWjVLBrqIZX8IID4ksP2RNPKYxnKdsfB921/gJeyrBEDetS+IY2sk5/K+e/O3xA0fZdUSgiOZZ0aH2YLqKdTAr9An7/2rGfC9krLvE/H0yDRxo7wSXu2A7uxIernFEqpgwyPNEFYy03tpUzihSlYFWvfDqsXwzYmXsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by IA1PR11MB7199.namprd11.prod.outlook.com (2603:10b6:208:418::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 16:57:42 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%6]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 16:57:42 +0000
Message-ID: <a6525228-2abf-4177-acc7-858843941ba4@intel.com>
Date: Tue, 3 Feb 2026 18:57:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] i3c: mipi-i3c-hci: Allow parent to manage runtime PM
To: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Frank Li
	<Frank.li@nxp.com>
CC: <alexandre.belloni@bootlin.com>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
References: <20260129181841.130864-1-adrian.hunter@intel.com>
 <20260129181841.130864-6-adrian.hunter@intel.com>
 <aXu8TiFpMiIVk5Iq@lizhi-Precision-Tower-5810>
 <dd681a97-de37-436b-b09e-5173c1de2f24@intel.com>
 <aXvKZK8tTnCDGzth@lizhi-Precision-Tower-5810>
 <a8a608c8-c6ce-415b-ac02-db1246edb15e@intel.com>
 <aXzIeLLDxsmzUhI+@lizhi-Precision-Tower-5810>
 <09622627-2ff3-4fb7-80f2-686d6474e417@intel.com>
 <aYDP847mgleQBF5Y@lizhi-Precision-Tower-5810>
 <eb335daa-ab6b-4cff-bea2-90160892bc8f@intel.com>
 <aYIbZ3PwiKUfp/eL@lizhi-Precision-Tower-5810>
 <73f7fc6b-d3cc-46d0-a07b-45c2a4190434@intel.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <73f7fc6b-d3cc-46d0-a07b-45c2a4190434@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0235.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::31) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|IA1PR11MB7199:EE_
X-MS-Office365-Filtering-Correlation-Id: 14e31fa6-8c3c-4b72-a08d-08de63455893
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T3NZbGNzVVBqUDh6Yyt5WkVyN2RaZzAwcmJYYUZiR1hIem9mTE85Q3NKMnJh?=
 =?utf-8?B?N3ZVSEZXdnExZWhHZHU0NWpUV3ZBejFZajM4VzRwU2dIREZiNkVYQ1BnQVc2?=
 =?utf-8?B?cjJDaElraDFxN1Z2ZlJWNWhXK1N6cjRMb29IdnhmT3Y5NG1LaURjdmJwWHJL?=
 =?utf-8?B?NzZ1bmRXK2hxbmJ6eHp1UXNIUWpYQmI1S3NYdVVBSnBjeXh4bVo5K0RsNWg0?=
 =?utf-8?B?czFKTjRGa2tXZHFXQUlWSzJjckZKUTE4ZzZzb2pRRUVMT2M0ZnlPazBkalY0?=
 =?utf-8?B?U3Bhd1I5Mk1QZjNYWVlBVkdGSDB5a1ArWk1JbGVLbm4zQlZxU09jT0xQSm5s?=
 =?utf-8?B?VVdKQzFVcEhPZm9mdVFpMjZ1c2tzSERQWmZTQjBWSHhoWC91M2lZWC9UTUlJ?=
 =?utf-8?B?ZmVMRGxaUlFIKy9LWFFQZ3FVV0FyN2REcm5BSnRIWWNMcU5CZVFiN3RUa1lB?=
 =?utf-8?B?dG02VnZKUEJFVFZkbkZrMktDR3NiZGt5eU9GSXNmTVI2dE56MWpIUytkVHdX?=
 =?utf-8?B?SnQ4aWc1NjdBcGY1SVl4dXIvVlB3WS9ZaW5PakVtMnF2Mk1ReVA0SXRKYk1n?=
 =?utf-8?B?UFFoQ254ckR1WWlXM1lMSVRWd0ZFMGJtb0xaZDhLZFozaUYyZmFUZFFMeExx?=
 =?utf-8?B?RitJNzV4WkVhZWs2L1hpaE1WeTBNWnFGQktHa2hIMFNiNXB6RFcvbnVFY1Jr?=
 =?utf-8?B?WE1jVTViNzVRNHVSaWIxalZzL2YwY2dwdldNNmQrRm1ybS9BVjdjd3JMOEEv?=
 =?utf-8?B?Y25kZ2FUdTZRUWRKQ3ZwZkpJMVFwWjV3em1rODNteUtxNElYL3ppbkRodzhW?=
 =?utf-8?B?L1NDYWVLZGxjQzJrWkxYRTZMVlUyS1VlWU9FWll5Z3dzVVYvalhVTGhYbXkr?=
 =?utf-8?B?eW5YeGJ0eUtxeVNwUUdnU0pFVWlmYk9teHY1UUJkRm00RjErZVllNGw3TFJm?=
 =?utf-8?B?eXFscnNZLzdDOU9RUzRRQ3BOVEpLb08xVUtDMW4vdHVUdklXRVlrMlNLT2pV?=
 =?utf-8?B?Nktjdi8yQmVRcEwzUVZYaWJkT2sxNmtIVmNpMzg2b0FXSzBubDlHQy9JZWlO?=
 =?utf-8?B?eW1tRGZnS0N3NzY0bkZra0hIellWenNET1BVTjBicWhlZk1CQVcyK1NhNWcz?=
 =?utf-8?B?bG1oWndOMCtuS2FQckRNWEM5dG9TL09KdzRXbWV6NWFEaU1jWU1jSkdQaC9Z?=
 =?utf-8?B?T0Y3MWd1elkvZnNYRnR6cEdGcEVPcGUzNmJJRFAxb2s2YU1rWGZNM0hvdEc4?=
 =?utf-8?B?K1NjdGtZc0NBeFlmZVJRd3BKdHNOUkcybXhOVUwzY20zVjZKdjFqRGh1aDZi?=
 =?utf-8?B?UTlGOVhzWXRZWDRYdlZYdE0wTE50em9qaUhBK0t6Z2lBWi9ORkdCNlRpTW9s?=
 =?utf-8?B?R1pBVFp0ZEJScXRBZVNaN3lWQk1sTEZmeHlRb3hxNDJSQ1FFKzUwMHZnTFpm?=
 =?utf-8?B?S2xlNkNCdzhta05naDhKalZkc1dINkY3QmtsM2ZuNlNnYTBEUFlpVitBS1Jx?=
 =?utf-8?B?ays3NjY4MjhCREk4SWNQN21tVytveWFCZmJQN2tSRTdIR2pONllGalI4RWF4?=
 =?utf-8?B?NXVMUnhRMXBFblNvVHAyVEFscW0wTmU4QVpjbXpZT0VXUzdYdFVzdysvNmtR?=
 =?utf-8?B?Ty8xelN6bTR2eHRUUHh3M2htR3JDVEhBMWNUb25NK3I1QXlCVVNPMHR4aFBO?=
 =?utf-8?B?eGFwRmhQbUJudkQ0YVF0VWw3bjFGTHl0TjUybnJ2U1IrQXN4QkJ5b2RWZk5T?=
 =?utf-8?B?L05EUW5OTWVUL29xSXNOOThlVTdId0s5WmxpWW5DaDNTVkJNVFFpbWwwTEIw?=
 =?utf-8?B?NDFDMjBBZ1A0Rk1ucXUzM21heTMrN1JsODBzL1ZWMWYxN2JFRnZ3RGlqVVZt?=
 =?utf-8?B?bmpwYll0eHA2SldCczRPdjdHNXJQUkxYSnJRNFp3Znl2eVBuQXovR3JFc2ZL?=
 =?utf-8?B?S2x0TGxvUE5yYllHSjJUbVZrc3RYVUNWMGMzdG50RzNmRUhIYi9TSGhWYnZ0?=
 =?utf-8?B?cVo0OGl5dXk1cmkrWDZzaE5wQXlaVERxam04M0JjSmRtMEtTUUpjeVNVQnlR?=
 =?utf-8?B?SmkwMzVVa2U0aFZSZno3QmpOZ2lMWlQ3eWdoc0o3cEFBS3lLZFpSRlZENlJG?=
 =?utf-8?Q?iPbw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dk1ZckNaSGMveWYrWm5nRUtLcUNqOFJJbHA1UzV0enIreE1CT2loZS9nRVJK?=
 =?utf-8?B?TXMyRjQ3Q3QzcDNpb2d3aWVOS0FmbmNTVHExaWlVRGFxVlc5UDJSRHdSSlF2?=
 =?utf-8?B?MVkzRWF5TzhScSsraGtMbzF1Rk9TZ2tsTGxld0dRTXVMb2xRakJtek80bk5R?=
 =?utf-8?B?cmZLVGF1SnVSenJzbnc0bU05aGhYdW92TDNWaGpyb1AxZnlHc1BHVGFDVkEy?=
 =?utf-8?B?aXZFVDBna29rTjZRMzhmNmJHNTBnbUh5VzJUQXF0bzViWlA4WkhBS0ttNlNI?=
 =?utf-8?B?UlIySmtrc3kxUHh2RXBkWUJBNS9ySXFYWTlHODBkT00yMEYwODdTNDdIaVNC?=
 =?utf-8?B?REdXbWYrdGlObDBvdE5HOGtybHp3VXFzUUZrMXh6VXRzMDBsTjBWSXFPQitw?=
 =?utf-8?B?aUNsbG1oTktxS1pLTklMa0x5dU5mUmpjVnd3cGw2T0dKYzNMeFZFMEdZRmht?=
 =?utf-8?B?M1dPTnVJaVJYSDFBOTlCa3dGQmZxWURYWjVzbGF5T0xzMGk5ZXFNVzhMcnU4?=
 =?utf-8?B?L0ZRSDhWUjhCUlVKcjJZZ0FEQklTMDgvSDRuTzNGUE50Z05oZ3FyQmRHdGZK?=
 =?utf-8?B?TDU2MUZMdHBnR0NPWkhYTmJVbnZzb3BReERHOWsybDRzcXU5Q1p2Tmk2L1h3?=
 =?utf-8?B?TnYrTTJiMVU1WUxoRmcwUXJHUmIyNHB3UmFqallHQ0lmdEpSQ29oVm5kSFZk?=
 =?utf-8?B?S0ZRVEJtN0hDMWdTM2xqYkVlUU0wYmNmQTlHM1ZJTzJjMTZFUGpnSm05OWYv?=
 =?utf-8?B?VE14QnEwMzlrT3J0WkFpUVlkME9OYnY0aGFHVzc4UnhGSENHLzJzU01NREll?=
 =?utf-8?B?R2cwQUxQWk5LaWk3RnJibXNFVGRzQ0huc0lWYS80cVVTL3ZyMzVtbXFwZGlP?=
 =?utf-8?B?OEZ6T0ZpWDRQYlQ3R282eTJYbWIzQ2taVEVjSUJHNmJVWW1uc3lNU2pOOHox?=
 =?utf-8?B?YVhESUpkdUNQYlNiNWFKdHdXdDhkcWs5dkNmTVdLNFlmYkg1WHY1cTZjNjc2?=
 =?utf-8?B?c2FFMm8vVHhVVVljVnlmb3Q3MDNrb0tycWZtYUxqR3Nyb3N2aFVTOTh1TGI5?=
 =?utf-8?B?UmdYN1UwbDBmTUxYQzkwRERkaGwrQXpPVmlWeXNBb0dOS3ZTb3Evd3JaQy9M?=
 =?utf-8?B?U2c4RHRmUjl0REtuK3pLVVRjdFpZY2o5bHZXL2xPRWZmVmdtdE5VT1VMcHBa?=
 =?utf-8?B?WERPSk5wNzdGdmRtMnU3KzJ1anYxWTZVbGtISGtyMVRiYnExaUovbVRPZzdz?=
 =?utf-8?B?RVlYeWJlRE42V2V6ZHZJRU1DWUV3bjU1N0dQL0hETHpVRDY1UldpVHhmK2ZY?=
 =?utf-8?B?ZVRuUVRJZ2daeVVqRDVCRmcxNWhQNWladkR3SGw3U0FjNTMxWHJhUC9FTnBa?=
 =?utf-8?B?cXBLYXNtVk9oaXcwR0hwNWNtM1J1eThsMkx2L2FXblhhNWl6ZFd1anFNTXFO?=
 =?utf-8?B?N2ZNckwrcnFLM0FDMzhCYVNORHFnUXVYVnpUak5MZ01Fa20yL3BFLzBrNUhJ?=
 =?utf-8?B?WTNRN2NnV0F6cW9ZMGYvUUJJdnV1ekkzMGVqQS9HZjZmcjZ2aGFYSitnSW80?=
 =?utf-8?B?TitwTkV5K1lFZHEzVkhTVnBWWVZ6UnlLWDlQd3VBSVpraE9GZkYxdGJ3eUN5?=
 =?utf-8?B?OE42TlhhN1dTc2NneERkRHFudzhNc2lpcEx0THRBZEQ3TjNxTk8yRWRYaXNK?=
 =?utf-8?B?bHk5VXVLUUxUbStoVTNOVjVGVGRwWE00aUNaRzEzOVBIQTBHMVo0aUhKeWoy?=
 =?utf-8?B?THAxY0xOQ1lxczVVc04raWhsb08xd0Q0NEZBbnhZMWFCYWQ4ckc4ODdmam1v?=
 =?utf-8?B?cWpMYjYvNHI4VERhWm9LOWxSUEJERkpQeDEvZHJrWDRZRURqNmdLUjRxSEpK?=
 =?utf-8?B?OHhidksxRXVLVnVEY0xhWjgrbkdwOXpHbWJEYXJVTTJBK3diWCt6VE1UNWJs?=
 =?utf-8?B?dUF2L29ETUlHU3FhSnJ5ZS9sWUh6NHgxeEtqaCtuOHNlVGh5YjMxLzhkSXFM?=
 =?utf-8?B?dVZQQ1lmNE1jeWluWWFBUFRXc0tPRVIycTlpSjJuTGF2RzhFeU9iWFdCT0NO?=
 =?utf-8?B?TENnNG8wcWZueG4rZEQ3ZytHREppUGR2eWhtNS8wN1NFZEdVemRuZjlWNXFH?=
 =?utf-8?B?RTBVRXMvVW8vS3A4bk1EQXJzRmZDWkxRRWlTOHRrUTRsVlpVRUhLZTZwZnY0?=
 =?utf-8?B?WG8zTWFOYmpMaGJSK211Yk0vRlRxMlVUbjlOZjBkN3N4a3BVSGx2MnNIcjBF?=
 =?utf-8?B?eXlMY0hEeEQyVGZxcTROOHA4eXBtMmZPaVBQS1djSVhoL0d0SSt5bHhOTTI5?=
 =?utf-8?B?YU9XeVZyS2Vya0tPUTNxQzhlWUluZDVGMWFtWDBCVFQwZTVQSVo2Zz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e31fa6-8c3c-4b72-a08d-08de63455893
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 16:57:42.5487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K7q1X69SLd14MBxq73b2dueZ1xMb2qZ7V7NqgW+/9Kpl3KEIQFYOnNq/I9+y6nqUgqfwUSeqP5PjJFLJ1kKqtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7199
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41988-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adrian.hunter@intel.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 8E7DCDC6D8
X-Rspamd-Action: no action

On 03/02/2026 18:22, Wysocki, Rafael J wrote:
> 
> On 2/3/2026 4:59 PM, Frank Li wrote:
>> On Tue, Feb 03, 2026 at 02:54:44PM +0200, Adrian Hunter wrote:
>>> + Rafael
>>>
>>> Rafael, this is not at all urgent, but when you have time
>>> please have a look at this patch set.  There is also some
>>> more explanation below.  Is it acceptable?  Is there a
>>> better way?
>>>
>>> On 02/02/2026 18:25, Frank Li wrote:
>>>> Does your device Hierarchy look like
>>>>
>>>>             PCI device
>>>>                 |
>>>>         -----------------
>>>>        HCI1            HCI2
>>>>         |               |
>>>>       I3C M1          I3C M2
>>> Yes and no.  There is only 1 real device : the PCI device.
>>> It implements the MIPI I3C HCI standard which allows multiple
>>> I3C bus controllers in one device (in our case 2 controllers).
>>>
>>> The PCI driver mipi-i3c-hci-pci creates 2 platform devices,
>>> one for each controller.  The platform driver is mipi-i3c-hci:
>>>
>>>   Driver                        Device                     Bus
>>>
>>>   mipi-i3c-hci-pci            0000:00:11.1                 PCI
>>>                              /            \
>>>   mipi-i3c-hci      intel-lpss-i3c.0  intel-lpss-i3c.1     Platform
>>>
>>> LPSS I3C also supports wake-up from in-band interrupt (IBI) via
>>> PCI PME.  The PME only works when the PCI device is in a low power
>>> state (D3hot in our case).  Also the PME is effectively shared by
>>> the 2 controllers i.e. an IBI signal (the controller's SDA line
>>> pulled low) for either controller will cause the PME.
>>>
>>> That means there are only 2 valid configurations:
>>>
>>>     1: Both controllers enabled to receive IBIs
>>>         PCI device    D0
>>>         Controller 1    Enabled
>>>         Controller 2    Enabled
>>>
>>>     2: Both controllers disabled to enable PME wakeup
>>>         PCI device    D3hot
>>>         Controller 1    Disabled
>>>         Controller 2    Disabled
>>>
>>> However, represented as platform devices, the 2 controllers
>>> runtime suspend and resume independently from each other.
>>> Whereas they effectively need to runtime suspend (or resume)
>>> at the same time.
>>>
>>> The proposed solution is for the PCI driver mipi-i3c-hci-pci
>>> to take over managing runtime PM for both controllers, calling
>>> into mipi-i3c-hci when it is safe to do so, to save/restore state
>>> and disable/enable the controllers one after the other.
>>>
>>> Current situation (I3C next branch):
>>>
>>>     PCI device    Runtime PM enabled, dependent on child devices
>>>             PCI subsystem controls PCI device power state
>>>
>>>     Controller 1    Runtime PM enabled plus auto-suspend
>>>             I3C subsystem runtime PM gets/puts the Platform device
>>>             Runtime suspend: disable and save state
>>>             Runtime resume: restore state and enable
>>>
>>>     Controller 2    Runtime PM enabled plus auto-suspend
>>>             I3C subsystem runtime PM gets/puts the Platform device
>>>             Runtime suspend: disable and save state
>>>             Runtime resume: restore state and enable
>>>
>>> Proposed (this patch set):
>>>
>>>     PCI device    Runtime PM enabled plus auto-suspend
>>>             I3C subsystem runtime PM gets/puts the PCI device
>>>             For each controller:
>>>                 Call into mipi-i3c-hci (when it is safe)
>>>                     Runtime suspend: disable and save state
>>>                     Runtime resume: restore state and enable
>>>
>>>     Controller 1    Runtime PM disabled
>>>
>>>     Controller 2    Runtime PM disabled
>> Controller 1/2 is child device of PCI device.
>>
>> So first patch "i3c: master: Allow controller drivers to select runtime PM device"
>> is not necessary.
>>
>> You can enable controller 1 and 2 Runtime PM with dummy operation.
>>
>> When controller 1 run time suspend, parent PCI device will reduce ref counter
>> when controller 2 run time suspend, parent PCI device will reduce ref counter
>>
>> Only runtime pm reference counter of PCI device is 0, PCI device's run time
>> suspend will be called, you can do actual disable and save work.
> 
> This sounds to me like it should work.
So, like this, then?

	PCI device	Runtime PM enabled
			For each controller:
				Call into mipi-i3c-hci (when it is safe)
					Runtime suspend: disable and save state
					Runtime resume: restore state and enable

	Controller 1	Runtime PM enabled plus auto-suspend
			I3C subsystem runtime PM gets/puts the Platform device
			Runtime suspend: does nothing
			Runtime resume: does nothing

	Controller 2	Runtime PM enabled plus auto-suspend
			I3C subsystem runtime PM gets/puts the Platform device
			Runtime suspend: does nothing
			Runtime resume: does nothing



