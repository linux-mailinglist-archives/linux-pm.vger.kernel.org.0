Return-Path: <linux-pm+bounces-12287-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 049B4953FED
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 05:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0B28283F63
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 03:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D461F53363;
	Fri, 16 Aug 2024 03:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ip3djuU8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7890225622;
	Fri, 16 Aug 2024 03:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723777257; cv=fail; b=kSY0RuQ+f16iA1P6zxpUH77YO8tH0GsnrLMmiIF6RNU/eHK3Hpmbk2KAlqSGR9zbkfL2uMlvuHdUOo21+U5685cVQHbyjv0yHlvT1zA7d8ux+DVGiu2P2Aeh2kozjmRuKqt12rHFS/BoZpxd25rZ++fhtVpVx6+nELtbeyQbRgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723777257; c=relaxed/simple;
	bh=U+tY36lh5gRScFgxxyH66IKeAOkaFza+IBpLvfgJ5Bs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BQNZPv+K7mOfkuMIppylSr2FaGn5D0i2sL8i9myei7hjl3UKOUeIy+2/zsVq5Zf+m5xMGzPvNZ0SZWGCPJFZ1eVRT/eV+zg6tABtc4C511FZAheLaUrugOq6g/2QoQq7ZRPcuq6vRI705e5L0XTb07BzvTYMs4TOvEQZHJd6ELQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ip3djuU8; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723777256; x=1755313256;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=U+tY36lh5gRScFgxxyH66IKeAOkaFza+IBpLvfgJ5Bs=;
  b=ip3djuU8PD6o4y/n13NuZs86oHlOvr/nH8D9I2po/7gJSwSfrradv3La
   3ijxn5hGBSbhCSThCqzMRLR7kOt8jjIY0fEJcqqvQ+Br+9ODrfEoR4oOl
   B0a60Y8ahb411/bBMiHcCBQ5aB7z/HhmHn7mlp/jS7gPHdehEU2RZxeYb
   6PqYOwq/fxn0ead/bf/tYDEoJpsv2NvYCBk54l1lr1xNNOsDDjhaU/Qlx
   2AfuZe38AToWvLG9Rmuu/C2JNueaCPJoiL3pwqhdfCoofmF5RKtI04eHT
   HicIzZeVuF841a7eG6QYY2ZAoPGANd6/lPZIqWJevtKrzGisXm3Oi/x39
   g==;
X-CSE-ConnectionGUID: 4MM+jZOnT7ea86C+XnQW1w==
X-CSE-MsgGUID: 2k8ul4dCSz223W+Uz9sz+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="21879303"
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="21879303"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 20:00:55 -0700
X-CSE-ConnectionGUID: oZx/gV/jSROdW4xZqZIxoQ==
X-CSE-MsgGUID: Bj/HAw03SvyWQfbvb6TWEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="59499991"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Aug 2024 20:00:54 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 15 Aug 2024 20:00:53 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 15 Aug 2024 20:00:53 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 15 Aug 2024 20:00:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wv7/5M927IzGHxS2uj8PNFLmxJC40e1hhK92LyzqPMzfWfsYE8sy7xge1Wl57zRDbz0t4xG9VAgjnI7JrdZqaGJ5Fh68KrMSlB7bR3SL7cPIN7mhTfyAsxXHVz5uNjIzwhD4B10ZEW+BkrTtTrO9w7mSz4VAvcDFiDlaktiDnYI35AFW7nLk7sjWl6KiM8b2KLz1dwC8y/LP29lbwTIEISToOlGcGZ3U/f0GsW5+VWazKwz/DaGvMm9mF0EPSz7zxmfyYeW2Q7YAR3X9oE6Tfzk4wSwsaHMLv4poXuF/kXmjXddSFemxBA+ndVFzO0U7darKaJE/eabXmvAT7WSvsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+tY36lh5gRScFgxxyH66IKeAOkaFza+IBpLvfgJ5Bs=;
 b=knPsTIvO1rVtd1Ay3WyBFNmxl2C7aFP9GhFTQUY2A+EYU7Uyzh7gHHEQ4X9ALbY1Ti8KWTv4wU26yqEn1SY8sl9GgeJrPlvtKjgNtY/4avhATsAZrbObrVNVFad2WJ2sWb/2xdj6xiKZeMr9t+Nu9q1nuAxqpKMnLuoBeSMeV/ssAJcHu6FcB1BAvyONOQHR19jMCWL6abX+ymuZu3EYd3ozeW3QpTJQbGqUVFqxazBNjr3tD5MfrU3wnymyccXFjU2ugmt2qCdyKcoV8OE8nm6MmqD+A6tUHxgh5jw+iwRBNngFW4xvRfrYdmm/DiMxr1Mzw1s/NQvXRUHKPSprHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by SJ2PR11MB8500.namprd11.prod.outlook.com (2603:10b6:a03:574::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Fri, 16 Aug
 2024 03:00:51 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%4]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 03:00:51 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@rjwysocki.net"
	<rjw@rjwysocki.net>
CC: "lukasz.luba@arm.com" <lukasz.luba@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "peter@piie.net"
	<peter@piie.net>
Subject: Re: [PATCH v1 2/4] thermal: gov_bang_bang: Split bang_bang_control()
Thread-Topic: [PATCH v1 2/4] thermal: gov_bang_bang: Split bang_bang_control()
Thread-Index: AQHa7Y18OZg95ex2K0qq3V9MS6OqcrIpNeOA
Date: Fri, 16 Aug 2024 03:00:50 +0000
Message-ID: <6a60b2c7a4e733f8bbe08a7d5159b22df763d7e4.camel@intel.com>
References: <1903691.tdWV9SEqCh@rjwysocki.net>
	 <3313587.aeNJFYEL58@rjwysocki.net>
In-Reply-To: <3313587.aeNJFYEL58@rjwysocki.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|SJ2PR11MB8500:EE_
x-ms-office365-filtering-correlation-id: ae326f57-183e-4bc6-6ae7-08dcbd9fa2e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?N2NZN1c4dUpGbXlMNjdWUUhMZW13dzhvUm9wb2FvQW5EbCtWTjdGMGowWGQz?=
 =?utf-8?B?aHBNcFMrRUVMU3J4TTRKMy9WL3NhRDJ5ZzlNQUJhUnhyekEzZzFtOHlHM3dL?=
 =?utf-8?B?dFNmMHNSWmlNZEZFamJaeEFSeVBmdFFIaTdYdmdXZFB4L1phQzZLQzlPTFp5?=
 =?utf-8?B?WjdWbW1KZFp3MmlKbFY3VW1jOGlwalZWaDJrM0JQWDNWMlNYZGVtUjJzSDFr?=
 =?utf-8?B?cC9XU2ZHc0ZQdW5GMHdvZFFSWmlzWUpUVjhERFo2elg1UDRpMEE5SlZsZDdV?=
 =?utf-8?B?aDFMTHV2K3JjL2hoVHRMUEZtbkJ5V3VRWTJGMSswWmNISmtKcVNuK3FtWlky?=
 =?utf-8?B?ZkduVWZhT0xwcTZva2NndkZLejE2SkNNUlEwYnR5R3RHQ2MxQTVObmpUTjlH?=
 =?utf-8?B?ZmNEbi9Pb2xVSmpLN25tTjl3VEhuZzczdlhSaURZdlpQMFdFOVZtUUF4Y2hh?=
 =?utf-8?B?dGNJcjlKUkhmbW5jS3dLSWJVZnNsYjdhK3NpWmFPQ2RYZmRrcDdJb1lMNXps?=
 =?utf-8?B?SDRBOXR6Zm0xVnhZOHpPOCthUG9SVXJwVTliUHpZM2VYaklraHR2cE5XVU9C?=
 =?utf-8?B?Q25xYmh6VzcwZDQwUFRyNS9DZWYxaFRXNXhGcUdZd2pUNzlvU2FERm9CenZz?=
 =?utf-8?B?TnUzeC9jNFE1KzVjaWkzRjVqU3R5TUUrRWVoaWhUanFMV2N5bTRrSjcxdEJL?=
 =?utf-8?B?RG9kbjFtWjRaSUo1MzJqTmdWQzhNM2tDS0NXTThkWVNBeVFKTGRVZW82SUFn?=
 =?utf-8?B?c0YvT1pScVNBSCs0VE53VXl6WE9qRnQ1SzlETzJzV3dVU0ljVGxPUzczV3Qy?=
 =?utf-8?B?NW9XZzRySXUrZWIyR1lmZE13R2o0MXRZSFNHTlRPdnRpRGJlcHRvczB1NFEx?=
 =?utf-8?B?YnRDdHJRVFk4ajBXL1F1UGg0L2JMRG9CTGFqU0JVT0JNTHI5b3NEbS9oSVJq?=
 =?utf-8?B?ZGR3K3hLbXh3QXYyYnZUWkdKbTd4a2UwV3YrdVBxR2JkdHdjcTgyQitzamRw?=
 =?utf-8?B?SWR1WXNheTBZd2Q0cU1Oa0ZjSitwWUhBZVRZNVhYbzRybllabmFWaXVIWUF5?=
 =?utf-8?B?Y3ZLSnVIcDF0S0NSWkgycTdhODRoVDYxN2c1dnc5SUtQL3dDcUtPNHA4Njlv?=
 =?utf-8?B?RjhhOHN2dnN5dFAyd3lKajR5ZTZlaFlaSTU0YWVEL3J1MUVQdExKdnVJQlFt?=
 =?utf-8?B?THdjY0EraGlJN3JDNVkyR25FeERKWmdDVWVuQWd2alQwVXI4Z29YLzRraEJs?=
 =?utf-8?B?cy9JK2hHNmpDL1ZHanBWand2WkRRQmpWNXB0c1UzcS93aUtSOUdUbDg4MkRT?=
 =?utf-8?B?ZldsRzlEM0QzVWdlaWpqMnovUDM0WVUrTTl6Vk16dUdSNkJ3OTI0YjJMc2Jz?=
 =?utf-8?B?S0RGTmxrMEdvN3NPWXlVQVVNaHBGZXpDcXNXRjZCRzJDZjRnaG1HVEQ1aXBV?=
 =?utf-8?B?MC9jMVVDNm5xWHBlVG1SUTErelpjdkRwZmVVQVBIZzU4bFJvSnpEdTAvZVlV?=
 =?utf-8?B?eHBnMU9qc3NmR0JRQWRXZ3g2NmJaY3dab09kamM3TXVrUWl6Tk0rV0VDS2xo?=
 =?utf-8?B?RU1IV1dyTjYxdUUyVFM3eGtYSFljNU1NUFdTOTVYTXl1WGxod0ZXK0YxRTE3?=
 =?utf-8?B?RWxCRitHRWNtSzlRSzFyaWd4dG5FWkZYRkxnSXlXNnVzTWRPMzBXWXFzUjZ3?=
 =?utf-8?B?cmx1ZCtUQWkzVWQzOGdXVVB6NGdqWlJEcEkvdTBCSjByMERwcHpKN1V4Wklt?=
 =?utf-8?B?WmpRcWM2UkJiaEszUzBUcWozVktzd3gyc01Za29xRExkeVhWcks2NnBGSmY4?=
 =?utf-8?Q?PF6s2KBG2h7vL5bjvm+Vb6ZFk5XuikVYlWMtw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SDh4NXdWVGNYaFFxWm1JRG9xSlFvblZ6M0k2YlMxS2NvRmowQmhzSm5DS2Nk?=
 =?utf-8?B?WnhpdjIvK0x3WUlISS9ieDBFQkZjZFlnaEFETDR3dEFIem1nMjZ2NjBLaWpu?=
 =?utf-8?B?Q0phOEgvS1BIcG1VWndkY3FsZGNaUUlFckVtMnJUZUxTNExQSUVkQTBNbm0z?=
 =?utf-8?B?eXE5Yys5YmthQjVFaUdpaUkxb1RGbHFrMzBFNk0vNWdYR2lTUWhxSm9BTzdj?=
 =?utf-8?B?dndHeWRLYXJLbmNmQ0J3cnZzREZvaVdFcDB5eEZHZ3E0NTBQSWVNSnpWbXdE?=
 =?utf-8?B?UDl6TEV4bnZsOXNGc1Q2QlBYdU1RdERiU0h5MFd6WFlYZ04zQjBCNVRDb1BR?=
 =?utf-8?B?MFRiWElJVWJRM1pCTjlBMFl0UDc4d0NTQU1WT3J6TmNaQjJVVVVmYjZRa3NC?=
 =?utf-8?B?ckgzVytmcWxlYzRmUDYySXhmNk1VQktFOEhUU1RtUEJCdU41cHVyWXhTcWFv?=
 =?utf-8?B?MkpiSFJZSVloL1IrVjl6STRBWHU1UnFSQnBFMEdBbHBjcTUwclBMWW9MenBF?=
 =?utf-8?B?UThab3Yyc2hpTlhnRzZua3lYL0pZbjhZc3VBR1VuWm1ZOUFCMGFRYTBTTHhn?=
 =?utf-8?B?VlM1NzJ2UzAwb0hLSDNZd0xLV2FnRnNCSUpHUndCZWczclFlbGN4aU9UN2VV?=
 =?utf-8?B?Z3RueE40UGlmT3o2Z25USDVEcjQ1N1FUUHRpbkFyc0J3Rmt5NjhTNUNza3Bz?=
 =?utf-8?B?NU40aFZtR2g3YlhtMG9zdi9pQnFSUTgvaTRiRW9GTUdwRFFhK3hqYUpkbjFF?=
 =?utf-8?B?N3N1a25SaGFaZ2J0TWg2aVlOK0pKSkVNUnRaYmxjbWdYQnFZbXNncHhYZVFu?=
 =?utf-8?B?YWl5Yy9WNEN0YXpYZC9QdndvY2xmL2Z0UTRKTFQ4b09GKzNPS2kxa2pQcXZi?=
 =?utf-8?B?SWVnUmJWWWtDOVdJVmlMc1JFT09GeDNDbmd4dXpGTXhGRjRoUHd1SlZFVWtW?=
 =?utf-8?B?NWlnM0RzcXh4enBldmNvdU5WdC9KWGhuN1RUYlN1N1craTQ3ckNtaVdtaVlU?=
 =?utf-8?B?N2JxSWlDNWI0NTJPSVJvY3RYRTh5VTc3T21TdERSYll3SjVmSmE1QVhSd0FI?=
 =?utf-8?B?WEgzN051K0V6WlFnTGZSRzk4U1o0VjR3S2tEaFZSMDNLbStMTExzdFhxdWgw?=
 =?utf-8?B?R3BIYnhObGJVYjJqY0ZoRmMzam5nbFVIb2ZFdXJEb0ZUdnJNOWNCQXl5YWhP?=
 =?utf-8?B?Z0pTaG5DY3U5VzRvaTI1VFVTVmUzVWRzMFBiSnZ0NVFSY3dNNVo4SzRraGZQ?=
 =?utf-8?B?aUZiL3lLL2t6a1ArQjdHdXNYYWxaRk4ySDRVeUhVUUtHRzRvOFZNMEZ4WnRD?=
 =?utf-8?B?MHBlV2c1M1BjMUtBcm9MUytVYjNYcEdSVUJzVzIwQW5FL05OdHVGdkNuRGNE?=
 =?utf-8?B?dWVJSHZSdzNJbkZxK2dKZ0VGdTNDdmNDdGU2ZWJwWmVzdnUyQnpIUkxQcUlU?=
 =?utf-8?B?a0pJSDZoTWFzcytVRWxrOEZVcWdBL0dPUUtoblI2Zk9hdDYzakxoTUhQSU5a?=
 =?utf-8?B?eE52OThEN2lNNHp5UnRucVJVcnRSNmh5Mjh1Yk14VFd5WTB2NllNdWFhdWpa?=
 =?utf-8?B?TU5qOVQ1ZzRQSkhmZEFhTklXTzV5L2tNaUZ0NXgrRXVnaDhPeitqcm5RWkhu?=
 =?utf-8?B?dmJ6cFdwMjFhMXM0UTJMcWlLUzdmWHdETG14b0hlWjM4d3NlV01DR0lpOXVK?=
 =?utf-8?B?ZjZtTmI1YTFxbWtrV1BrQmpyR0YvYThCQjAvTUM0ZDRuVFNzWHBrNUxEM1g0?=
 =?utf-8?B?ZWpXWE11WTE5NTVTVjdOOWRGZkdRb21iLzFZS2xMR0R4dzFlNFdyWDcvZnly?=
 =?utf-8?B?ZVh6d045TlduMS81eDRxYzE3M213UTh3c1hYT2JKaGZRanh4ZjVEL0ZpM2VJ?=
 =?utf-8?B?MWs1cW5ndXVESTFBWHRQNVc1WU1GMXp3RkIwbDFWZS9wS1VXU1IrYzFYbCtC?=
 =?utf-8?B?QWtyOFJQbWZnY3g3aUhJYkZkS0xRcHFpTGZhdGV5ZCtHQ0pRS25FUDhmR2hB?=
 =?utf-8?B?RTFQVHZOejM4alBWelM2Z1BTVllJUGsxdHorcXBzOVZMWGFhU3RkRXFtdE4w?=
 =?utf-8?B?bElvV3QxdzJSaTk2cG41ckJvdFNDR0VGUVFEQU03Wmh0b1g0OFBLa1o1eDI5?=
 =?utf-8?B?elp2aTdTRytwVHE3YW4zZVJtdWZDN0FsNFFiSllweXlDUDNtRFp3dDh5blFs?=
 =?utf-8?B?bGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <01B5C503E00ED243B8685A7DCB5DBF66@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae326f57-183e-4bc6-6ae7-08dcbd9fa2e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2024 03:00:50.9964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XHANHHC6wcMSLQfGyAM2UkgYZmT2v0XLQlnmI47l77E29gCNk+umsgKvPYpl7L86NsNREEk1HI0La3aPotsUNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8500
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTA4LTEzIGF0IDE2OjI2ICswMjAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToKPiBGcm9tOiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb20+
Cj4gCj4gTW92ZSB0aGUgc2V0dGluZyBvZiB0aGUgdGhlcm1hbCBpbnN0YW5jZSB0YXJnZXQgc3Rh
dGUgZnJvbQo+IGJhbmdfYmFuZ19jb250cm9sKCkgaW50byBhIHNlcGFyYXRlIGZ1bmN0aW9uIHRo
YXQgd2lsbCBiZSBhbHNvIGNhbGxlZAo+IGluIGEgZGlmZmVyZW50IHBsYWNlIGdvaW5nIGZvcndh
cmQuCj4gCj4gTm8gaW50ZW50aW9uYWwgZnVuY3Rpb25hbCBpbXBhY3QuCj4gCj4gU2lnbmVkLW9m
Zi1ieTogUmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29tPgoKUmV2
aWV3ZWQtYnk6IFpoYW5nIFJ1aSA8cnVpLnpoYW5nQGludGVsLmNvbT4KCnRoYW5rcywKcnVpCgo+
IC0tLQo+IMKgZHJpdmVycy90aGVybWFsL2dvdl9iYW5nX2JhbmcuYyB8wqDCoCA0MiArKysrKysr
KysrKysrKysrKysrKystLS0tLS0tLQo+IC0tLS0tLS0tLS0tCj4gwqAxIGZpbGUgY2hhbmdlZCwg
MjMgaW5zZXJ0aW9ucygrKSwgMTkgZGVsZXRpb25zKC0pCj4gCj4gSW5kZXg6IGxpbnV4LXBtL2Ry
aXZlcnMvdGhlcm1hbC9nb3ZfYmFuZ19iYW5nLmMKPiA9PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Cj4gLS0tIGxpbnV4LXBt
Lm9yaWcvZHJpdmVycy90aGVybWFsL2dvdl9iYW5nX2JhbmcuYwo+ICsrKyBsaW51eC1wbS9kcml2
ZXJzL3RoZXJtYWwvZ292X2JhbmdfYmFuZy5jCj4gQEAgLTEzLDYgKzEzLDI3IEBACj4gwqAKPiDC
oCNpbmNsdWRlICJ0aGVybWFsX2NvcmUuaCIKPiDCoAo+ICtzdGF0aWMgdm9pZCBiYW5nX2Jhbmdf
c2V0X2luc3RhbmNlX3RhcmdldChzdHJ1Y3QgdGhlcm1hbF9pbnN0YW5jZQo+ICppbnN0YW5jZSwK
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgaW50IHRhcmdldCkKPiArewo+ICvC
oMKgwqDCoMKgwqDCoGlmIChpbnN0YW5jZS0+dGFyZ2V0ICE9IDAgJiYgaW5zdGFuY2UtPnRhcmdl
dCAhPSAxICYmCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgIGluc3RhbmNlLT50YXJnZXQgIT0gVEhF
Uk1BTF9OT19UQVJHRVQpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHByX2RlYnVn
KCJVbmV4cGVjdGVkIHN0YXRlICVsZCBvZiB0aGVybWFsIGluc3RhbmNlICVzCj4gaW4gYmFuZy1i
YW5nXG4iLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGluc3RhbmNlLT50YXJnZXQsIGluc3RhbmNlLT5uYW1lKTsKPiArCj4gK8KgwqDCoMKgwqDCoMKg
LyoKPiArwqDCoMKgwqDCoMKgwqAgKiBFbmFibGUgdGhlIGZhbiB3aGVuIHRoZSB0cmlwIGlzIGNy
b3NzZWQgb24gdGhlIHdheSB1cCBhbmQKPiBkaXNhYmxlIGl0Cj4gK8KgwqDCoMKgwqDCoMKgICog
d2hlbiB0aGUgdHJpcCBpcyBjcm9zc2VkIG9uIHRoZSB3YXkgZG93bi4KPiArwqDCoMKgwqDCoMKg
wqAgKi8KPiArwqDCoMKgwqDCoMKgwqBpbnN0YW5jZS0+dGFyZ2V0ID0gdGFyZ2V0Owo+ICsKPiAr
wqDCoMKgwqDCoMKgwqBkZXZfZGJnKCZpbnN0YW5jZS0+Y2Rldi0+ZGV2aWNlLCAidGFyZ2V0PSVs
ZFxuIiwgaW5zdGFuY2UtCj4gPnRhcmdldCk7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoG11dGV4X2xv
Y2soJmluc3RhbmNlLT5jZGV2LT5sb2NrKTsKPiArwqDCoMKgwqDCoMKgwqBfX3RoZXJtYWxfY2Rl
dl91cGRhdGUoaW5zdGFuY2UtPmNkZXYpOwo+ICvCoMKgwqDCoMKgwqDCoG11dGV4X3VubG9jaygm
aW5zdGFuY2UtPmNkZXYtPmxvY2spOwo+ICt9Cj4gKwo+IMKgLyoqCj4gwqAgKiBiYW5nX2Jhbmdf
Y29udHJvbCAtIGNvbnRyb2xzIGRldmljZXMgYXNzb2NpYXRlZCB3aXRoIHRoZSBnaXZlbgo+IHpv
bmUKPiDCoCAqIEB0ejogdGhlcm1hbF96b25lX2RldmljZQo+IEBAIC01NCwyNSArNzUsOCBAQCBz
dGF0aWMgdm9pZCBiYW5nX2JhbmdfY29udHJvbChzdHJ1Y3QgdGhlCj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqB0ei0+dGVtcGVyYXR1cmUsIHRyaXAtPmh5c3RlcmVzaXMpOwo+IMKg
Cj4gwqDCoMKgwqDCoMKgwqDCoGxpc3RfZm9yX2VhY2hfZW50cnkoaW5zdGFuY2UsICZ0ei0+dGhl
cm1hbF9pbnN0YW5jZXMsCj4gdHpfbm9kZSkgewo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBpZiAoaW5zdGFuY2UtPnRyaXAgIT0gdHJpcCkKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNvbnRpbnVlOwo+IC0KPiAtwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgaWYgKGluc3RhbmNlLT50YXJnZXQgIT0gMCAmJiBpbnN0YW5jZS0+dGFy
Z2V0ICE9IDEgJiYKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGluc3Rh
bmNlLT50YXJnZXQgIT0gVEhFUk1BTF9OT19UQVJHRVQpCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwcl9kZWJ1ZygiVW5leHBlY3RlZCBzdGF0ZSAlbGQg
b2YgdGhlcm1hbAo+IGluc3RhbmNlICVzIGluIGJhbmctYmFuZ1xuIiwKPiAtwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW5zdGFu
Y2UtPnRhcmdldCwgaW5zdGFuY2UtPm5hbWUpOwo+IC0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgLyoKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogRW5hYmxlIHRo
ZSBmYW4gd2hlbiB0aGUgdHJpcCBpcyBjcm9zc2VkIG9uIHRoZSB3YXkKPiB1cCBhbmQKPiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogZGlzYWJsZSBpdCB3aGVuIHRoZSB0cmlwIGlz
IGNyb3NzZWQgb24gdGhlIHdheQo+IGRvd24uCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAqLwo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpbnN0YW5jZS0+dGFyZ2V0
ID0gY3Jvc3NlZF91cDsKPiAtCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRldl9k
YmcoJmluc3RhbmNlLT5jZGV2LT5kZXZpY2UsICJ0YXJnZXQ9JWxkXG4iLAo+IGluc3RhbmNlLT50
YXJnZXQpOwo+IC0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbXV0ZXhfbG9jaygm
aW5zdGFuY2UtPmNkZXYtPmxvY2spOwo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBf
X3RoZXJtYWxfY2Rldl91cGRhdGUoaW5zdGFuY2UtPmNkZXYpOwo+IC3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBtdXRleF91bmxvY2soJmluc3RhbmNlLT5jZGV2LT5sb2NrKTsKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKGluc3RhbmNlLT50cmlwID09IHRyaXApCj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBiYW5nX2Jhbmdf
c2V0X2luc3RhbmNlX3RhcmdldChpbnN0YW5jZSwKPiBjcm9zc2VkX3VwKTsKPiDCoMKgwqDCoMKg
wqDCoMKgfQo+IMKgfQo+IMKgCj4gCj4gCj4gCgo=

