Return-Path: <linux-pm+bounces-12244-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7601A952843
	for <lists+linux-pm@lfdr.de>; Thu, 15 Aug 2024 05:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35881286E66
	for <lists+linux-pm@lfdr.de>; Thu, 15 Aug 2024 03:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E037828683;
	Thu, 15 Aug 2024 03:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lALWLcuL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E783BBC9;
	Thu, 15 Aug 2024 03:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723692399; cv=fail; b=GG6zK0wHiwxNo0gCNhZIfZNTQeF4ob0rLez5hS/hDgjhpC9/82HCHWQQRNIv3bo9CMs0gghzfYkg40zlvwqDzcR5AQx1YVpIQPSOQb/Rq0tYVXaqjGk4gi0DadT5CzTwuSR/yL6Qh45+NR7SMqKdNZVdM2AXx41A7jf8Lc5WFK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723692399; c=relaxed/simple;
	bh=+oRx0g0B8wUTLIo72HiAoicVyGaoCybpvuW10O3w8cA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WeWswgPuegdtLrtXp3hSf6dxPBljscKBtl3zVOF5u04HVVBwYKM686Kf0A7xgG2iwZIXMcnZaJsoBjFN6EKgT1ewFOCQRbapKg1wNWyo3aCRSUqqOujiHpVJ9ug0RInEJfhR1jTg7n88+OeuTZxuDM9/oSnOGO1XUWgNferp98M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lALWLcuL; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723692398; x=1755228398;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+oRx0g0B8wUTLIo72HiAoicVyGaoCybpvuW10O3w8cA=;
  b=lALWLcuLhfCxZXXRCDSyeVvYHEWb97O5tAz33NOUu+vAEyDnt/u/sO/Z
   tOY7ntxLr9Mdm0QUwAi8xLImQiZFMjY4539zj1QrYFvoSJ/77aXPq3da2
   MFMUMmU58Ed0oWRYfscMEFvgkg1zjVsjpZSiR0v5dvIQSJ7iOXAgFaEBG
   crllEIa92qB+IwqfdZJ1kn04f7HCGt0pC7ZXNuado9iZZYZRKpJ0p42AU
   LGskXSmwaY37uutdM98UbZB6MrbWGFnysnxUP8MuNTqF2Tdc1WokEQt6Z
   KOYERp/EtmSgxnS8P+aFgJX2PJAwhSh+Qa6kZ3JAvaLRTm6alTnj3wEv6
   A==;
X-CSE-ConnectionGUID: 7wopTuZfQUaJneSoksSQ6Q==
X-CSE-MsgGUID: f07v+GSZRB2CX82C+WeHZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="33329539"
X-IronPort-AV: E=Sophos;i="6.10,147,1719903600"; 
   d="scan'208";a="33329539"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 20:26:37 -0700
X-CSE-ConnectionGUID: p39mcLAeQdGLKKvucHna3Q==
X-CSE-MsgGUID: TFzbZA+VQAW4Au1EbP/RQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,147,1719903600"; 
   d="scan'208";a="82432349"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Aug 2024 20:26:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 14 Aug 2024 20:26:35 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 14 Aug 2024 20:26:35 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 14 Aug 2024 20:26:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Df11GGhuYvS0XwcnHhJ7t/KcvsnJr5s94642Fto1eQhz8esDi3sEnIEYjnGuwU2RDElhLCZu60KTmP+CXYVx+Pwf6A4sEdCTQ/td+exdO4hMdpK2M1OT9pmPJvWu0Qo02vklJqmscl930p5AmulPgcNCAfRphWGspXIGdiZVTZSHfzXp8UCARLtL7XnmK28MtagL3N/B3Y/hmcGepePfYSyO8PBohqLJ8aWeV4lsMUbiA+p7Ob5ovI7RtxhVDM8jN56xTJUPXx1RF8jxbhBdgcDqxDovCVqSpYBJ3XZ9+Tjt9qFFS6Gb2y2sVVmFujWQ6rT0E8vu7iP8RAp5600L2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+oRx0g0B8wUTLIo72HiAoicVyGaoCybpvuW10O3w8cA=;
 b=v5J8tUkxmCHoRMJ/HkUUtYR6BW9dNAWueaSnNUtF2BnObSYdXVwwkmUMeL1hV2pYBTq/6kJrs0jIF1zcLzNQUmU56HEhHOETdmJZ1uowSPkIPEVD2tXAcnV0Mhb/Pm3kFBiDXkpMm8sdpFch6BcGjZymutxx8IRKt+SZ2r1dZLfrkoGr4n2uJbpHezzfZRtCqSrYzfRVTJvHhE2KiroDMe9bx4CchMz8I9IngwfYQUJ6jbnlzpgRWG1+ucqi19REhUPKt/sQQ8vvhv4K9rvpUWMlIYx12dwlcWn1aVfGrURq6LoSQ7TVmN9RYYqzIY9l6vBZAVz8v6foJxfO+R5GAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by PH7PR11MB7073.namprd11.prod.outlook.com (2603:10b6:510:20c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33; Thu, 15 Aug
 2024 03:26:18 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%4]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 03:26:18 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "rafael@kernel.org" <rafael@kernel.org>
CC: "lukasz.luba@arm.com" <lukasz.luba@arm.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "daniel.lezcano@linaro.org"
	<daniel.lezcano@linaro.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
	"peter@piie.net" <peter@piie.net>
Subject: Re: [PATCH v1 4/4] thermal: gov_bang_bang: Use governor_data to
 reduce overhead
Thread-Topic: [PATCH v1 4/4] thermal: gov_bang_bang: Use governor_data to
 reduce overhead
Thread-Index: AQHa7Y0/nb0hc/COjUmHmsGZ2tMf8bImRdwAgAC9OACAAKeXAA==
Date: Thu, 15 Aug 2024 03:26:18 +0000
Message-ID: <6f3c94464ae9c2fd4e4d3c75f7f837aa073517ee.camel@intel.com>
References: <1903691.tdWV9SEqCh@rjwysocki.net>
	 <2285575.iZASKD2KPV@rjwysocki.net>
	 <2f16fd5a59d6655ec9339473d516ac49c89e43f8.camel@intel.com>
	 <CAJZ5v0icxkRyd_1T53JmX3XDQOC6_Ak9nOD65Yx-rhZbDa4Y_w@mail.gmail.com>
In-Reply-To: <CAJZ5v0icxkRyd_1T53JmX3XDQOC6_Ak9nOD65Yx-rhZbDa4Y_w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|PH7PR11MB7073:EE_
x-ms-office365-filtering-correlation-id: 110f274a-c0d9-4796-8687-08dcbcda06ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Z2w0eGJVZ3BUakhlZnBsTTBiT2k0dFBiTG1NeXU5eU8zYWhyQ1MrVE9GMjlu?=
 =?utf-8?B?cTZ4bS9PNUpxejMyOFlJV0x2cExoWUJpU1JwZC9YM1BIYUhuK3RVa05YMUJs?=
 =?utf-8?B?NXFobHhoaDBhYVFxVHppb2tUaDVxZThIbEpBVE44amN2R0lZaExlUjQ3Mk52?=
 =?utf-8?B?MEowYTQrbWMxM1JpdWF1WHlmRlUvMmhLbERkUGpUUDlDanIwbW9MTnRkc3Fa?=
 =?utf-8?B?Ulhkcm14d3lMclZWWEQ3VXZlYk1mZ3pGeTBRcUJXVjRTTmRLTTJDbFNuNVhJ?=
 =?utf-8?B?WTl3R09GcnRuTzUyV0V6TXRQdk8yaHRzRHowM3FRZVNvOXhHeXVNbVBUN254?=
 =?utf-8?B?Vk0vVHVueUV3cWZHVHBYcGNIQ2JsQk93dlk2MmxkYUFMdWJxTnVFdGxFdDRJ?=
 =?utf-8?B?cGxmOW9SSVdGMmdlZk4zVzVjSjE0M0ZIenFobVJuUjBkNy9FdnFsOFpIdEdY?=
 =?utf-8?B?K3dJM3N6WUhnTmtvTjN4UldnMW5jQUdsZUV2QkNyUit4L0toNGZKNXdCcjZw?=
 =?utf-8?B?bTJTTTFINFZ3dXdrUm85YmYwNVFiSGJsR0xHSUFIeDFHcUNyTTVZWUJHMEt2?=
 =?utf-8?B?bHNDZHZiWEdtRmZBWEZDUlNQSUdGcjFjeE9kcXJKbi8rUU82Tk1WZDM0dmNr?=
 =?utf-8?B?bEIrMHE0Unp4Y25OTE5RcW9pbE1tZzhGWXUzTHJuMXhKdk1TOTNzUmtzZ1F4?=
 =?utf-8?B?Q1lydWxER3ArVGt1ZHV5MG8yTkV4MWswYlVvVUc3OVRzekVvNHJMNUxEQkpQ?=
 =?utf-8?B?eHNlWjd0cTNSMEJEVUZkbE1SUCtUZWdabVV4TENDWWxXS3lWSE5uRGVqMndO?=
 =?utf-8?B?SDZUdnR4NTdnN2ZCekMzdjBFRWtZbzVpN2VMc3JZOFlJOGovdklFUE92bWlP?=
 =?utf-8?B?bmZNVUpHZ05MclhKTVkvUXNJT0R6Vi90MVBjUFdMRmlxQnJsRnF2ZjhucDgr?=
 =?utf-8?B?WHVsTExzeE0zUjFQM2NRUDRtWUd3K2dSdFVONjRZcCtETzhhanRkdWtMdmVt?=
 =?utf-8?B?ckd4ZFlRRzZHREZuekRSUmFISmliKzJwakU4SVZzV3UraFUwdC9QRXBOOW9I?=
 =?utf-8?B?NDYzNWM0UGhENkp2RWpBV3NJa2RKTlVab2w2VFFzK0FzeWMxRGgwaHorYmxo?=
 =?utf-8?B?UlNpaldER2s2NDNtS0lKVG9rbWh3SEVmSGN4NWJCUUltMEQwdFh1M0dtRUVh?=
 =?utf-8?B?ZHgwS0s0QU1TZkRxd2RveHJzenY1TTRXeU1rcUdabHNiQUMvYU1iZ3B0Kzg5?=
 =?utf-8?B?QVNBUElTWjljNWZBTWlUL2NjSGJUK0Z2QkdQNG1IcTIvQjM1bjgxdVhkTlps?=
 =?utf-8?B?VzlPN01BTG9mWU9PUkpyMmNudWlIM2pGcE5Od1dFVzZrd0ljYkx5QS9ITXA4?=
 =?utf-8?B?ZUdmTTZMTlNKVVFRZElCdFJCaTZCR2lWWmJFdzFNc3EyZnpBcTR0V2I4VHVs?=
 =?utf-8?B?TXlVSlh1WDJaYktrV2UvZjhHQlJOdWJ5RDdhT1NlTkdYTHhaQmZFTTBlVHdq?=
 =?utf-8?B?eEJ1ODZzRkdKSllqb2w1bDliRnZzMkYxV3VxdmFjcWtnM1FWRlplVmtyQ0ZS?=
 =?utf-8?B?V2ZNOEVka1lzSzFMSVdjUXpZUC9vbVdsTmVNWUlKTVVjVDNQandNNnBZbGpV?=
 =?utf-8?B?KytnV0VxNU9LL2JHeTlHZzJzVThSdmZIMTExdGtWVkxZb0tNMTdhVDNFaFIy?=
 =?utf-8?B?MmN1ZmRGR2NpMHRVTGVUMjlWZkVJK005SE5PWUwrUzNreGpUdmY0L01BRmcz?=
 =?utf-8?B?bGJoQzQyTFRPTmxuMVdXRElDTjRsc2oxbmR3eTI1a3AydUpNVHliNEZvV3Jj?=
 =?utf-8?Q?fydn79c2IYb/RdHwGPwFvoaGiOyhmHmHXT4gU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d04wOHFsQitIOXNNSnBta1pxVE5FbzJHV0FoVHU3R0d6eDNQT3huQ2FMNmVE?=
 =?utf-8?B?ZFRwU0trZVFVMXdpcUlVOEl4dHJwMGw1enUzVGVXRU50TWdIRm5FVGhrTXN4?=
 =?utf-8?B?WFNLdnR3OUdXVzB3Y01qR2t2UXpSL01VSVIzNy9udjg3REZPSVd1ZkdHR09J?=
 =?utf-8?B?NCtQdkxVTzMvN1psYVhScXE1NXZLV3JqZ251a0Evd0RlK2ZEaGZiOXd3ZXJ6?=
 =?utf-8?B?VENSTGUzcy9oWlQwK2Nnano4VjZvY0dvMjdBY0Z0bkhoODNMN2s3ckdBV05Z?=
 =?utf-8?B?YXEyV3dES2RUS21GRUpINGZvNXlBQkFSbWpMT2drSEN2V1p0UUJYdWcwejJo?=
 =?utf-8?B?dC9oRkU2TUt0bEF3SmFuM3ZrVVZ2UDFIQ1Q3ZnB4ZGtnQ3V4RmxuRW16VDlB?=
 =?utf-8?B?QnplWEU5Rm83WElUVVp4Kyt1TjdMM3kvZW1yU256YzVha3U3YlhzeXowMU5X?=
 =?utf-8?B?NFE4UFpiRkQ0SGdxd1BYODMzYWFXOXZ0MVJOUFpDRHpWdDZlVEo1L3BQVjlk?=
 =?utf-8?B?VmtUbklRSnMxQTVhRzA2QURaS29MUU0ydklaUGNZRFZac1JuSVUyWk9EamJY?=
 =?utf-8?B?Mm9pZkNrNC84MXB2cVlwU28yS25BMTlKSDFjbGozU2xBVnRYb3JYeWFTTkVX?=
 =?utf-8?B?eWh3amdSZWpiM2hOaXNNOHY4YWV6SjFvVkxlMnd3N01WSlpBNDJqYU1hNWhi?=
 =?utf-8?B?QXVyak5heFFkSVltUks0djJLZTJiNkU3U1hYb3VESklBV0FkUlY1ejBWN0Fz?=
 =?utf-8?B?OE5hbTBnUXB0bnp5MVRIb1VIYWJWQmNJY2JsWVpWK2xOUzhBWHZON3N3M29M?=
 =?utf-8?B?UE00bzltRUtVc2llVlAxWlJMdm03MWZrLy9DVEdPQzcwY3hIbEJkZVVwWUtS?=
 =?utf-8?B?bHpIV1JMWGFHRlFFcWtXM2NuejZOTG4vOXZTMG82a3pNYVZmRUtaQjR0WXNO?=
 =?utf-8?B?NFRYZ1MyMlp2dXFZc3FwemJvNGx2ZEw2TWJ3ZkJha1F6TmpIVm1DODBxR3NV?=
 =?utf-8?B?V1NjSUhPVnZuWVN2OXpkVTgybVJueWpVQVYySDkrd1cyaEVnVEsrN0E4TlpP?=
 =?utf-8?B?SW9GZTF0WGJYb1E0UmZsRDJDQ1dZUzM0OTBFRnFpamdBTk5DYnJ3VUZPdUUx?=
 =?utf-8?B?ZlBtL0VlbnhhbE1YWWp2b0R0RXFmRElDclBIUjI2NmJOTVBVNkZhM2pIUWFS?=
 =?utf-8?B?THNTck8xL0o3aHQzWk1QQ3RSREVMSFJJc1FoeHFFTTNEd0NlQmJqaUZCa05v?=
 =?utf-8?B?dTB1MWtSb0NRLzBPZEcyUVJFT0MzUFhqZ1hWOENNakNRYnRBd3ZZbEZ2YXpl?=
 =?utf-8?B?NHk1MSttWXY5cDhPSkh1UUtadkJMYUUwc0ZHYTE3QU8xc3R1Q1hiclFFUXBO?=
 =?utf-8?B?WXFyOGtXL2xrcGV2VTZWRmJxelNiZTRjTW5mS1A0RUdXMzBQYjlDVjdtQjJH?=
 =?utf-8?B?TjdOa1RJR0ZIMnZFVklLRHhxclg0ZkZKL2dWeUtDdmZOYnRKbi9tRzl1ZWVw?=
 =?utf-8?B?MzU4RTAyelVxNDdLOVNSZXE5dWpwazNVbDNSSUJTZUFQZGVRNUdqVGM0bDcr?=
 =?utf-8?B?cWthcUdtLzN2QWE3TGh6TDdTVzdDT0VFWHE1RUd2bzZlTklpTFpFODIxcFdZ?=
 =?utf-8?B?WHpKNEE0MVk3UlZ6d01mOWY1RXJYVFJZeHlReENDRlNSRkRnME5GZGxNb3p1?=
 =?utf-8?B?Yjdvb25STC9jSjVhRUZtVlI0dkdjZjF1aHlkcDB6TXcydHFBVjlJSmpNUnFj?=
 =?utf-8?B?MFc2VENQaUNnU3dMdWZVMmpINDVESGdxeDVLOHFlSC82VHY2ME5CcHp1cmJu?=
 =?utf-8?B?eDBiem9PSjN6UTBLWGtUcVB6c2NRaVNWb2ppejRvQWlWWjdrVzB1WEp2RDZO?=
 =?utf-8?B?TVlnSHlTMW1nWWdaSENlNGVtWjg3aXBJUG14YmFHTGpTdjJUWWk0MEs3Z0NG?=
 =?utf-8?B?SGpEazJSaTRGTWRmOG9vdFUrK2VlK051a1FWU2R4MlpjMXhEZEhOOW1GV29y?=
 =?utf-8?B?L2hIaGl6NnRyZG92a0xvMzRydTNxZ0tod3ZSN3Yxa01xc094bjFtL1c1ajVR?=
 =?utf-8?B?ODlEM0NCUERlc2dlOEF1SDlteWNjVFl2c0ZSQ29lT3JSVDYyYU5kSzgwcngr?=
 =?utf-8?B?WGU5VXVCZzcrR0lrcDRtaGV4RnR3V2svakxYY21iSXg3R2RSK0w2NmhjNW8z?=
 =?utf-8?B?YkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E9EDDBE65DEBE48821D2F6174832301@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 110f274a-c0d9-4796-8687-08dcbcda06ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2024 03:26:18.4453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pu6t8+FJFtiKBgk2fGNXlne3ZPcaQ4dTdM6sGNgNO8TQ0Q/VaFTEuwit0DiYkfE2u6cCT9+htmpQu6mj+3qj8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7073
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI0LTA4LTE0IGF0IDE5OjI2ICswMjAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gT24gV2VkLCBBdWcgMTQsIDIwMjQgYXQgODowOeKAr0FNIFpoYW5nLCBSdWkgPHJ1aS56
aGFuZ0BpbnRlbC5jb20+DQo+IHdyb3RlOg0KPiA+IA0KPiA+IE9uIFR1ZSwgMjAyNC0wOC0xMyBh
dCAxNjoyOSArMDIwMCwgUmFmYWVsIEouIFd5c29ja2kgd3JvdGU6DQo+ID4gPiBGcm9tOiBSYWZh
ZWwgSi4gV3lzb2NraSA8cmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb20+DQo+ID4gPiANCj4gPiA+
IEFmdGVyIHJ1bm5pbmcgb25jZSwgdGhlIGZvcl9lYWNoX3RyaXBfZGVzYygpIGxvb3AgaW4NCj4g
PiA+IGJhbmdfYmFuZ19tYW5hZ2UoKSBpcyBwdXJlIG5lZWRsZXNzIG92ZXJoZWFkIGJlY2F1c2Ug
aXQgaXMgbm90DQo+ID4gPiBnb2luZw0KPiA+ID4gdG8NCj4gPiA+IG1ha2UgYW55IGNoYW5nZXMg
dW5sZXNzIGEgbmV3IGNvb2xpbmcgZGV2aWNlIGhhcyBiZWVuIGJvdW5kIHRvDQo+ID4gPiBvbmUg
b2YNCj4gPiA+IHRoZSB0cmlwcyBpbiB0aGUgdGhlcm1hbCB6b25lIG9yIHRoZSBzeXN0ZW0gaXMg
cmVzdW1pbmcgZnJvbQ0KPiA+ID4gc2xlZXAuDQo+ID4gPiANCj4gPiA+IEZvciB0aGlzIHJlYXNv
biwgbWFrZSBiYW5nX2JhbmdfbWFuYWdlKCkgc2V0IGdvdmVybm9yX2RhdGEgZm9yDQo+ID4gPiB0
aGUNCj4gPiA+IHRoZXJtYWwgem9uZSBhbmQgY2hlY2sgaXQgdXBmcm9udCB0byBkZWNpZGUgd2hl
dGhlciBvciBub3QgaXQNCj4gPiA+IG5lZWRzDQo+ID4gPiB0bw0KPiA+ID4gZG8gYW55dGhpbmcu
DQo+ID4gPiANCj4gPiA+IEhvd2V2ZXIsIGdvdmVybm9yX2RhdGEgbmVlZHMgdG8gYmUgcmVzZXQg
aW4gc29tZSBjYXNlcyB0byBsZXQNCj4gPiA+IGJhbmdfYmFuZ19tYW5hZ2UoKSBrbm93IHRoYXQg
aXQgc2hvdWxkIHdhbGsgdGhlIHRyaXBzIGFnYWluLCBzbw0KPiA+ID4gYWRkDQo+ID4gPiBhbg0K
PiA+ID4gLnVwZGF0ZV90eigpIGNhbGxiYWNrIHRvIHRoZSBnb3Zlcm5vciBhbmQgbWFrZSB0aGUg
Y29yZQ0KPiA+ID4gYWRkaXRpb25hbGx5DQo+ID4gPiBpbnZva2UgaXQgZHVyaW5nIHN5c3RlbSBy
ZXN1bWUuDQo+ID4gPiANCj4gPiA+IFRvIGF2b2lkIGFmZmVjdGluZyB0aGUgb3RoZXIgdXNlcnMg
b2YgdGhhdCBjYWxsYmFjaw0KPiA+ID4gdW5uZWNlc3NhcmlseSwNCj4gPiA+IGFkZA0KPiA+ID4g
YSBzcGVjaWFsIG5vdGlmaWNhdGlvbiByZWFzb24gZm9yIHN5c3RlbSByZXN1bWUsDQo+ID4gPiBU
SEVSTUFMX1RaX1JFU1VNRSwNCj4gPiA+IGFuZA0KPiA+ID4gYWxzbyBwYXNzIGl0IHRvIF9fdGhl
cm1hbF96b25lX2RldmljZV91cGRhdGUoKSBjYWxsZWQgZHVyaW5nDQo+ID4gPiBzeXN0ZW0NCj4g
PiA+IHJlc3VtZSBmb3IgY29uc2lzdGVuY3kuDQo+ID4gPiANCj4gPiA+IFNpZ25lZC1vZmYtYnk6
IFJhZmFlbCBKLiBXeXNvY2tpIDxyYWZhZWwuai53eXNvY2tpQGludGVsLmNvbT4NCj4gPiA+IC0t
LQ0KPiA+ID4gwqBkcml2ZXJzL3RoZXJtYWwvZ292X2JhbmdfYmFuZy5jIHzCoMKgIDE4ICsrKysr
KysrKysrKysrKysrKw0KPiA+ID4gwqBkcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9jb3JlLmPCoCB8
wqDCoMKgIDMgKystDQo+ID4gPiDCoGluY2x1ZGUvbGludXgvdGhlcm1hbC5owqDCoMKgwqDCoMKg
wqDCoCB8wqDCoMKgIDEgKw0KPiA+ID4gwqAzIGZpbGVzIGNoYW5nZWQsIDIxIGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkNCj4gPiA+IA0KPiA+ID4gSW5kZXg6IGxpbnV4LXBtL2RyaXZlcnMv
dGhlcm1hbC9nb3ZfYmFuZ19iYW5nLmMNCj4gPiA+ID09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+ID4gPiA9PQ0KPiA+ID4g
LS0tIGxpbnV4LXBtLm9yaWcvZHJpdmVycy90aGVybWFsL2dvdl9iYW5nX2JhbmcuYw0KPiA+ID4g
KysrIGxpbnV4LXBtL2RyaXZlcnMvdGhlcm1hbC9nb3ZfYmFuZ19iYW5nLmMNCj4gPiA+IEBAIC04
Niw2ICs4NiwxMCBAQCBzdGF0aWMgdm9pZCBiYW5nX2JhbmdfbWFuYWdlKHN0cnVjdCB0aGVyDQo+
ID4gPiDCoMKgwqDCoMKgwqDCoCBjb25zdCBzdHJ1Y3QgdGhlcm1hbF90cmlwX2Rlc2MgKnRkOw0K
PiA+ID4gwqDCoMKgwqDCoMKgwqAgc3RydWN0IHRoZXJtYWxfaW5zdGFuY2UgKmluc3RhbmNlOw0K
PiA+ID4gDQo+ID4gPiArwqDCoMKgwqDCoMKgIC8qIElmIHRoZSBjb2RlIGJlbG93IGhhcyBydW4g
YWxyZWFkeSwgbm90aGluZyBuZWVkcyB0byBiZQ0KPiA+ID4gZG9uZS4gKi8NCj4gPiA+ICvCoMKg
wqDCoMKgwqAgaWYgKHR6LT5nb3Zlcm5vcl9kYXRhKQ0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgcmV0dXJuOw0KPiA+ID4gKw0KPiA+ID4gwqDCoMKgwqDCoMKgwqAgZm9yX2Vh
Y2hfdHJpcF9kZXNjKHR6LCB0ZCkgew0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGNvbnN0IHN0cnVjdCB0aGVybWFsX3RyaXAgKnRyaXAgPSAmdGQtPnRyaXA7DQo+ID4gPiAN
Cj4gPiA+IEBAIC0xMDcsMTEgKzExMSwyNSBAQCBzdGF0aWMgdm9pZCBiYW5nX2JhbmdfbWFuYWdl
KHN0cnVjdCB0aGVyDQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoA0KPiA+ID4gYmFuZ19iYW5nX3NldF9pbnN0YW5jZV90
YXJnZXQoaW5zdGFuYw0KPiA+ID4gZSwgMCk7DQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgfQ0KPiA+ID4gwqDCoMKgwqDCoMKgwqAgfQ0KPiA+ID4gKw0KPiA+ID4gK8KgwqDC
oMKgwqDCoCB0ei0+Z292ZXJub3JfZGF0YSA9ICh2b2lkICopdHJ1ZTsNCj4gPiA+ICt9DQo+ID4g
PiArDQo+ID4gPiArc3RhdGljIHZvaWQgYmFuZ19iYW5nX3VwZGF0ZV90eihzdHJ1Y3QgdGhlcm1h
bF96b25lX2RldmljZSAqdHosDQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVudW0gdGhlcm1hbF9ub3RpZnlfZXZlbnQg
cmVhc29uKQ0KPiA+ID4gK3sNCj4gPiA+ICvCoMKgwqDCoMKgwqAgLyoNCj4gPiA+ICvCoMKgwqDC
oMKgwqDCoCAqIExldCBiYW5nX2JhbmdfbWFuYWdlKCkga25vdyB0aGF0IGl0IG5lZWRzIHRvIHdh
bGsNCj4gPiA+IHRyaXBzDQo+ID4gPiBhZnRlciBiaW5kaW5nDQo+ID4gPiArwqDCoMKgwqDCoMKg
wqAgKiBhIG5ldyBjZGV2IGFuZCBhZnRlciBzeXN0ZW0gcmVzdW1lLg0KPiA+ID4gK8KgwqDCoMKg
wqDCoMKgICovDQo+ID4gPiArwqDCoMKgwqDCoMKgIGlmIChyZWFzb24gPT0gVEhFUk1BTF9UWl9C
SU5EX0NERVYgfHwgcmVhc29uID09DQo+ID4gPiBUSEVSTUFMX1RaX1JFU1VNRSkNCj4gPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHR6LT5nb3Zlcm5vcl9kYXRhID0gTlVMTDsNCj4g
PiA+IMKgfQ0KPiA+IA0KPiA+IGNhbiB3ZSBkbyB0aGUgY2RldiBpbml0aWFsaXphdGlvbiBmb3Ig
QklORF9DREVWIGFuZCBSRVNVTUUNCj4gPiBub3RpZmljYXRpb24NCj4gPiBpbiAudXBkYXRlX3R6
KCkgZGlyZWN0bHk/DQo+IA0KPiBUaGF0IHdvdWxkIGJlIHZpYWJsZSBpZiB0aGUgem9uZSB0ZW1w
ZXJhdHVyZSB3YXMga25vd24gYXQgdGhlIHRpbWUNCj4gLnVwZGF0ZV90eigpIHJ1bnMsIGJ1dCBp
dCBpc24ndC7CoCBTZWUgdGhpcyBtZXNzYWdlOg0KPiANCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvbGludXgtcG0vQ0FKWjV2MGppXzdaLTI0aUNPX1h4dTRabTRqZ1ZGbVI5alZwOFFOaUNPeHpW
OWdxU25BQG1haWwuZ21haWwuY29tLw0KPiANCj4gQXMgbG9uZyBhcyB0aGUgem9uZSB0ZW1wZXJh
dHVyZSBpcyBub3Qga25vd24sIGl0IGlzIG5vdCBjbGVhciB3aGljaA0KPiB3YXkgdG8gaW5pdGlh
bGl6ZSB0aGUgY29vbGluZyBkZXZpY2VzLg0KDQpyaWdodC4gVGhlbiB0aGUgcGF0Y2ggTEdUTS4N
Cg0KQlRXLCB3aGF0IGRvIHlvdSB0aGluayBpZiB3ZSBhZGQgaGFuZGxpbmcgZm9yIGZpcnN0IHRl
bXBlcmF0dXJlIHJlYWQgaW4NCmhhbmRsZV90aGVybWFsX3RyaXAoKSwgc2F5LCBzb21lIGRyYWZ0
IGNvZGUgbGlrZSBiZWxvdywNCg0KaWYgKHR6LT5sYXN0X3RlbXBlcmF0dXJlID09IFRIRVJNQUxf
VEVNUF9JTklUKSB7DQoJaWYgKHR6LT50ZW1wZXJhdHVyZSA8IHRyaXAtPnRlbXBlcmF0dXJlKQ0K
CQlsaXN0X2FkZCgmdGQtPm5vdGlmeV9saXN0X25vZGUsIHdheV9kb3duX2xpc3QpOw0KCWVsc2UN
CgkJbGlzdF9hZGRfdGFpbCgmdGQtPm5vdGlmeV9saXN0X25vZGUsIHdheV91cF9saXN0KTsNCn0N
Cg0KVGhpcyBzaG91bGQgaGFuZGxlIGJvdGggdGhlIGluaXQgYW5kIHRoZSByZXN1bWUgY2FzZS4N
Cg0KdGhhbmtzLA0KcnVpDQo+IA0KPiBJbnRlcmVzdGluZ2x5IGVub3VnaCwgdGhlIHpvbmUgdGVt
cGVyYXR1cmUgaXMgZmlyc3QgY2hlY2tlZCBieSB0aGUNCj4gY29yZSB3aGVuIHRoZSB6b25lIGlz
IGVuYWJsZWQgYW5kIG5vdCB3aGVuIGl0IGlzIHJlZ2lzdGVyZWQuDQo+IA0KPiA+IFRoZW4gd2Ug
ZG9uJ3QgbmVlZCAubWFuYWdlKCkgY2FsbGJhY2suIFRoaXMgbWFrZXMgbW9yZSBzZW5zZSB0byBt
ZQ0KPiA+IGJlY2F1c2UgYmFuZ19iYW5nIGdvdmVybm9yIGNhcmVzIGFib3V0IHRyaXAgcG9pbnQg
Y3Jvc3Npbmcgb25seS4NCj4gDQo+IFRoYXQncyB0cnVlLCBidXQgdGhpcyBpcyBhbGwgYWJvdXQg
YSBjb3JuZXIgY2FzZSBpbiB3aGljaCBubyB0cmlwDQo+IHBvaW50cyBhcmUgY3Jvc3NlZCBhbmQg
dGhlIGNvb2xpbmcgZGV2aWNlcyBuZWVkIHRvIGJlIGluaXRpYWxpemVkDQo+IHByb3Blcmx5IHJl
Z2FyZGxlc3MuDQo+IA0KPiA+ID4gwqBzdGF0aWMgc3RydWN0IHRoZXJtYWxfZ292ZXJub3IgdGhl
cm1hbF9nb3ZfYmFuZ19iYW5nID0gew0KPiA+ID4gwqDCoMKgwqDCoMKgwqAgLm5hbWXCoMKgwqDC
oMKgwqDCoMKgwqDCoCA9ICJiYW5nX2JhbmciLA0KPiA+ID4gwqDCoMKgwqDCoMKgwqAgLnRyaXBf
Y3Jvc3NlZMKgwqAgPSBiYW5nX2JhbmdfY29udHJvbCwNCj4gPiA+IMKgwqDCoMKgwqDCoMKgIC5t
YW5hZ2XCoMKgwqDCoMKgwqDCoMKgID0gYmFuZ19iYW5nX21hbmFnZSwNCj4gPiA+ICvCoMKgwqDC
oMKgwqAgLnVwZGF0ZV90esKgwqDCoMKgwqAgPSBiYW5nX2JhbmdfdXBkYXRlX3R6LA0KPiA+ID4g
wqB9Ow0KPiA+ID4gwqBUSEVSTUFMX0dPVkVSTk9SX0RFQ0xBUkUodGhlcm1hbF9nb3ZfYmFuZ19i
YW5nKTsNCj4gPiA+IEluZGV4OiBsaW51eC1wbS9kcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9jb3Jl
LmMNCj4gPiA+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09DQo+ID4gPiA9PQ0KPiA+ID4gLS0tIGxpbnV4LXBtLm9yaWcvZHJp
dmVycy90aGVybWFsL3RoZXJtYWxfY29yZS5jDQo+ID4gPiArKysgbGludXgtcG0vZHJpdmVycy90
aGVybWFsL3RoZXJtYWxfY29yZS5jDQo+ID4gPiBAQCAtMTY5Miw3ICsxNjkyLDggQEAgc3RhdGlj
IHZvaWQgdGhlcm1hbF96b25lX2RldmljZV9yZXN1bWUocw0KPiA+ID4gDQo+ID4gPiDCoMKgwqDC
oMKgwqDCoCB0aGVybWFsX2RlYnVnX3R6X3Jlc3VtZSh0eik7DQo+ID4gPiDCoMKgwqDCoMKgwqDC
oCB0aGVybWFsX3pvbmVfZGV2aWNlX2luaXQodHopOw0KPiA+ID4gLcKgwqDCoMKgwqDCoCBfX3Ro
ZXJtYWxfem9uZV9kZXZpY2VfdXBkYXRlKHR6LA0KPiA+ID4gVEhFUk1BTF9FVkVOVF9VTlNQRUNJ
RklFRCk7DQo+ID4gPiArwqDCoMKgwqDCoMKgIHRoZXJtYWxfZ292ZXJub3JfdXBkYXRlX3R6KHR6
LCBUSEVSTUFMX1RaX1JFU1VNRSk7DQo+ID4gPiArwqDCoMKgwqDCoMKgIF9fdGhlcm1hbF96b25l
X2RldmljZV91cGRhdGUodHosIFRIRVJNQUxfVFpfUkVTVU1FKTsNCj4gPiA+IA0KPiA+ID4gwqDC
oMKgwqDCoMKgwqAgY29tcGxldGUoJnR6LT5yZXN1bWUpOw0KPiA+ID4gwqDCoMKgwqDCoMKgwqAg
dHotPnJlc3VtaW5nID0gZmFsc2U7DQo+ID4gPiBJbmRleDogbGludXgtcG0vaW5jbHVkZS9saW51
eC90aGVybWFsLmgNCj4gPiA+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+ID4gPiA9PQ0KPiA+ID4gLS0tIGxpbnV4LXBt
Lm9yaWcvaW5jbHVkZS9saW51eC90aGVybWFsLmgNCj4gPiA+ICsrKyBsaW51eC1wbS9pbmNsdWRl
L2xpbnV4L3RoZXJtYWwuaA0KPiA+ID4gQEAgLTU1LDYgKzU1LDcgQEAgZW51bSB0aGVybWFsX25v
dGlmeV9ldmVudCB7DQo+ID4gPiDCoMKgwqDCoMKgwqDCoCBUSEVSTUFMX1RaX0JJTkRfQ0RFViwg
LyogQ29vbGluZyBkZXYgaXMgYmluZCB0byB0aGUNCj4gPiA+IHRoZXJtYWwNCj4gPiA+IHpvbmUg
Ki8NCj4gPiA+IMKgwqDCoMKgwqDCoMKgIFRIRVJNQUxfVFpfVU5CSU5EX0NERVYsIC8qIENvb2xp
bmcgZGV2IGlzIHVuYmluZCBmcm9tIHRoZQ0KPiA+ID4gdGhlcm1hbCB6b25lICovDQo+ID4gPiDC
oMKgwqDCoMKgwqDCoCBUSEVSTUFMX0lOU1RBTkNFX1dFSUdIVF9DSEFOR0VELCAvKiBUaGVybWFs
IGluc3RhbmNlDQo+ID4gPiB3ZWlnaHQNCj4gPiA+IGNoYW5nZWQgKi8NCj4gPiA+ICvCoMKgwqDC
oMKgwqAgVEhFUk1BTF9UWl9SRVNVTUUsIC8qIFRoZXJtYWwgem9uZSBpcyByZXN1bWluZyBhZnRl
cg0KPiA+ID4gc3lzdGVtDQo+ID4gPiBzbGVlcCAqLw0KPiA+ID4gwqB9Ow0KPiA+ID4gDQo+ID4g
PiDCoC8qKg0KPiA+ID4gDQo+ID4gPiANCj4gPiA+IA0KPiA+IA0KPiANCg0K

