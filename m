Return-Path: <linux-pm+bounces-8169-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 650B88D046F
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 16:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0E9A1F2105C
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 14:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0F816E880;
	Mon, 27 May 2024 14:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TrRJEzrd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A68715FA63
	for <linux-pm@vger.kernel.org>; Mon, 27 May 2024 14:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819558; cv=fail; b=jcH5VyBPpGaYzJzfHi1s8l+ksEPiUvja0hhggLNgXeWx4ECjXFJtEqSqO+BuoLPVYENvtmFI/aTtiFbk59iRacJ0+CIHkPtu4rRFSlcW1xWkP3SluOfHRPYrrHldC8kEDZcC9501v9dzmAsw4iEJFJomjvJJJNJwhkl0/DB/tC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819558; c=relaxed/simple;
	bh=toMnSb0AULwVGqwnYOQgWErne5cCnFlxUrTr55hO8oQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gjSUhgZ+LKxnFi1c8MDxP1UOLQkXRR+4ruod7uBGzXVNxo4B5bE6LIesk12UzkjQ4/zf0XvaLAIa1uCpN06U1R1daohegQPmzzllve3SK6dopaqJgXJQEDGFbt/sDGZemPSHo8+lf21Bfm63i0hkRLmMOXVDrlvXsLL7vI/2mek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TrRJEzrd; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716819557; x=1748355557;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=toMnSb0AULwVGqwnYOQgWErne5cCnFlxUrTr55hO8oQ=;
  b=TrRJEzrdqJp/PibodWnN9aJAif4CXZMZ7rC2egGodvVboOthdcAqjrVx
   erTetNRgv1IOMV6S/poUjucl6aoXMhTTFEnxErcXYOV3ZJ4c4v7z8pnIf
   qIxv9lvPIOhxYtB6z6aQ9XK0XVCUI/B6zAJOZlsEuqWNF7mx/aroA5nEA
   UwKIK+ASjlX2BTOs/HGy8xG4g75aUboIOYwo9oMQokO/un9wClbKPHJ60
   Ajgilt9cTE1DnYyizepAVcSA6dL5ZWZEKkH2TI+BuQ/GYbw0gjkqzZ7JE
   NpWCK/AEDV1LlkDW3lsnYKhy+4Pyee+bSkerbOwDrEqAUasq6Qpr2SJE5
   g==;
X-CSE-ConnectionGUID: /28GIldlS+yhl/SodWbHQA==
X-CSE-MsgGUID: 1RGrXp2+SgSx8F5L5ps6iA==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="16975127"
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="16975127"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 07:19:09 -0700
X-CSE-ConnectionGUID: WgJ4RHKgQnePDkEN1JOSWA==
X-CSE-MsgGUID: knk//fgmTJinhS7/Em/FFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="39185484"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 May 2024 07:19:09 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 27 May 2024 07:19:08 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 27 May 2024 07:19:08 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 27 May 2024 07:19:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QVE1eVDFvZcwsvTHe3hGn+GkheevR2GuyV7loHgM2MqZ3/lQDufRDDn1iRh/Vmr0oj8YP32CpEzlAJfMMJnuYip0732tVRtHmDl2yf1Qbp8pyifNJNt59ZIebzXy66kAoVOf8Gdv/jbAmKEudRuHk8zwZiX6N4ZLlnpTyf+ra+N3imsWqspQHrtl4VLev9cZeyT39/1hv6eqOkCJUUVDThX94Lvuclb5qrH0wqj8XIpvAjWmCZ+sgXEfQ1fXecz9ZUYQTdd1cfz/ILmzbjtS+X1TJT1fJKyG2wUI/IhVlY7T72n5jaE1OdHjIopsqy70ac5ZXO3NRS1N1rQnsejG4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=toMnSb0AULwVGqwnYOQgWErne5cCnFlxUrTr55hO8oQ=;
 b=lV94HpTYkPawjkSOT/wIthpzvYydqH2H+nzJ/cb40fFQ2T1MGG8ryW/flRKFYUl3LbqdxwVDpdkAdV5PgFiQbRRjx7aDaMkjj9tKTKXACfGoNMm6sgnJO+AYfamrV3xI4SjtmQ5tHEr6s16mKsmE42S/sW3MY2fQloUPVX2MUQtnaP8MMUNRT+OzAs2gBDTA8rGjkMk/T7uwL9BnPhOidNqRn+3oncnGCqx1Vwx5wa5oWyfcs7+H2FM8hHMyrd9yrkEHZxVrPT0Q+NlXmSg7XLblHdISA+0kcmCDsCcUR8suLIYj0TnLkH2ZxbRMF3MceiAImG2e2SWRYtmz1EFiJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by DM6PR11MB4642.namprd11.prod.outlook.com (2603:10b6:5:2a2::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 14:19:06 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%5]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 14:19:06 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "Pandruvada,
 Srinivas" <srinivas.pandruvada@intel.com>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: powercap ABI clarification
Thread-Topic: powercap ABI clarification
Thread-Index: AQHasDVGuh1xQBglm0uP9v8YcHNYRrGrHfUA
Date: Mon, 27 May 2024 14:19:06 +0000
Message-ID: <9c97e4f8549744b1e2464a3b632f0716514ff55c.camel@intel.com>
References: <59e5a949-ef20-4f11-a0a7-247c457f1dd3@linaro.org>
In-Reply-To: <59e5a949-ef20-4f11-a0a7-247c457f1dd3@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|DM6PR11MB4642:EE_
x-ms-office365-filtering-correlation-id: a8ffaa42-6194-4373-eda4-08dc7e57f7b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?QlMxTEFpblJMNi9LbEhGNDVtZHhnaDVPaGtCMEI3c2cxS25YLzJuZElnOE9j?=
 =?utf-8?B?TWRzNmtwOGVNUXhvUVdpelhnd0JSa05SeklpckdOYWh1NUJrY3IwZkZoNmRK?=
 =?utf-8?B?dFl4VTE3aXZibWxRMUNqbzMyMWkwV2x3U3pjNUhzUmkzZjJremdQV3RTZ3Uy?=
 =?utf-8?B?b0E3aTFtYzB5QnBLYi9lOTJIaFJhOHdzVnZxMGR4eUtjUEdUUzlMQUtOeVNN?=
 =?utf-8?B?T2hZN2I5ditpNjQ1bUZYQytyOWxZd0V4Q1VSWjI2TDlrL1QxMStFZTdMSE5D?=
 =?utf-8?B?c1RrNXFwdDRZYTIwZE9BRkpZdjE2SncyS2QxVGhkS2MwSlRqNkpESmExd3d5?=
 =?utf-8?B?RXpoQkw5R1ZvWDVLTmVGU1RLcmRDeUxQdVZxR1FlYWFHNVhNVHhGTkZEYnNM?=
 =?utf-8?B?dW9ZV2VCYTVhMjI1UFJmMmxNUmxrR3V5T25ybHM5TFBsT2ZZd0J6eUJacWxh?=
 =?utf-8?B?aUtpdVZlK2NiTytWZUE4d3FqdGY0bVFKd2lDUTdQRW9kNmVndi9SRmpkc2k0?=
 =?utf-8?B?SFNZTnovU2QxWW5yOVhrZFcvMmpaWUZxRGI0VXFSUlc0Tlc0eE5QN01iNGJy?=
 =?utf-8?B?TWFHNjdMaUVEVzVWdUJsK2ZxbUVyTWg0eFNyeVBNemJJN0RwZVR4NSs5MDBM?=
 =?utf-8?B?Q0FlSnpDWUdKMU9wNkptQVRBOHBnN1NIMVV2NSttbE1lSVE4djBQeGpUMkF1?=
 =?utf-8?B?OGYvZXNCMzc3VDlHU0VsSVZVQ1ZHWDF3Um02Ulo3MlgyTldkM2hZVmpPaWt2?=
 =?utf-8?B?VkMvUnRxOWVLZGtUa3dQL21TQSt4K0FVVWoydnYrblVRM3hBWisxMi9yaTV2?=
 =?utf-8?B?cG1uRW0xTUJScFQ0OE5sd25HeXlOWk1XWlFNakxXUVlxYnJHZHdxRWVkekJD?=
 =?utf-8?B?bEM0ekt4dDA4Z3lsRTdmdnRyNExGdzFWcUdRTXlkeFo1MDJvM3ZnT1E1NlBz?=
 =?utf-8?B?QkpxYjhScmV3Slo4c21PYmxSaEFGeWJpb3F3S3p6LzM4cGtQZ3BEUExETXJu?=
 =?utf-8?B?MlNVT0VwVG1mWmc0TmU1Q2tqUS9VSXJVVy94ZUxBaVRhZXZ5ZFRFYUlndnZk?=
 =?utf-8?B?SmRRUkQ5czVzTnFjVWlpQXhhZjdzZ2pIRXhxR2NtLzZxc0tJT250RVBDTTcy?=
 =?utf-8?B?dTM0VlRvbGRSM2NtUG5Vd2ZVekxrYzR3TitER21ZT1dxRDFMeDhsTHNPUUY4?=
 =?utf-8?B?YlJXODRBVzBFQnV3cVAwZVNpVjNTL3pvL3BVNForeFBRNEFldzdqZk1YZElL?=
 =?utf-8?B?L2xmeUxDUGtMekpEV1gyOFlmWlgvdmxHcVl5aGRIdThKTDAvb2czMVBud3hx?=
 =?utf-8?B?b1oyRXBGTmthRnFQU1V4b3NmMlI4T3RBNWQwVS9iRXA5OWJDZTdXczk2TDFX?=
 =?utf-8?B?QkxCVXdwVlArWjdwb1NGQ1NKNlRKVUFhTVpVdmZ2YktJVEp5VCtlRjhSS2Vr?=
 =?utf-8?B?eS9uOWNMQWgwb0xpdUM1MFR4SG11aGdLMFdSOHRTZUlnTmtMOVlGQi9CUUJH?=
 =?utf-8?B?b09uRlJ2TDQzSTh3MWFUYy9neHlESjJCN0RQcTY1dFFEYnFubVdyRmZVZHk4?=
 =?utf-8?B?Z1k3WUNjVGRHa2FYd25Xc0tsanEzK0RYVDFMYjJab2RpWWc1QVByVnIvQ3V4?=
 =?utf-8?B?QWh0QlZHRm8vd0NjL1h2RXl5QnRJMTkydWdQakROSU8wTUV3U0I2NXU5eVo4?=
 =?utf-8?B?eCsvN2NUZk42ejJhZytta2owQnBPN2tTcXB5MndWTnluQ0d4QXRyMDdUZlly?=
 =?utf-8?B?THhVMTZpR1ZQbjFtU21taTBtVURqeDJGUUhwbG52K0VNTnQ2eTNVQlMyc3JB?=
 =?utf-8?B?YTI4TlpqWStGdHBSbW9Pdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGVjYXNNV2lCSGR4OGxUSHJpcjkzMTdVbFMxU0RyMjduekpkeURIOHR2aW5Q?=
 =?utf-8?B?dTNDQ0xRMEEvQXhCN05wamI5dzBnK0JsTVVSUzg4UUY3NHBsaEhZVSswT05W?=
 =?utf-8?B?dEpMWjkvb0ZGWi9DSHRaOGZVOGlvbWdCbzh4aXJ1RHdmNXF6RDZoV1ZCZmJh?=
 =?utf-8?B?NzhDY2RpMXZnb2x0SFJvL29xOFhHQTZqMVVMNEhpWlVTZmhGa1N5WVVzdkFJ?=
 =?utf-8?B?NHpjVG5vcFJjUkV4R2JMSDNBOTFFZ2J6WWVlY1lzL2xjOHBFSTlqa2xLRUV0?=
 =?utf-8?B?S29Zamc5Mk9pVXRCY3pqUmphem1kRVhBMTZjeWFDY1RMTXFwbGU1U0ZQSUl3?=
 =?utf-8?B?REVxaW8zOUpFWGd6dW9TUEZUY25tZXhtQmgyY3ZaQ1AzZzFwYWNUenVQSk14?=
 =?utf-8?B?Q3FBaEttTndnR0sySnB4aHc3eXhXbzVyWFhxZCsrYmlsVkVXbEJ1Y3A4ckZP?=
 =?utf-8?B?QzcyYWxoRzZsZ0NpQ1FZWXYyL0kvNFdKWFozNmVEdlNMN3pBMkZZUWxNdTVm?=
 =?utf-8?B?MCtYalpCOFhwUDZSUGpneGtyZUs4K0dTQmQxNlVleXEwdDE4RzE0OWxPQ1Bo?=
 =?utf-8?B?eXp4by9hVllqemVLbjk3M1NQOEJGT2VXcEY1MUZMRWg5Y3oveGtrMWFyeTAx?=
 =?utf-8?B?WFJpeGlKV0lySU1YVzduUVFKamZNUzRpaEhKSDlNaUhlQlMzRmxvYkFJdXJT?=
 =?utf-8?B?YkduZHluTUUvMWdzUWpCV05wbXlDTS82VWtManpBa1M3UXk5bDNZYk5hbXFS?=
 =?utf-8?B?dzlRbGlMY2QvVXFHOVd3M3NKL3E2bThaazlGYkNXUVZXL01TYXh3eDJkRmF1?=
 =?utf-8?B?YmhhejNhQzlWK2ZKVC9iaVRrajg3OTQ2c05lUlVWVEYwU1kxQ25RdmdzVURy?=
 =?utf-8?B?WWhlVFZ1NG9VOXpDNTZndG9WWHFSWTVDVC9ORXVCUjQ0TGVlTlJ6TnY0RWRk?=
 =?utf-8?B?WURRbGtUQTBKSHQrb3FaYUZVQjRoZWl5UXN4eTZUYlBtL2pybnUvVDRLbGhn?=
 =?utf-8?B?QVRaWkwrNnlSelY5K2w1UzlwRG00d21qQjA5aWh4UGY3bGRaRStOc2pscWwr?=
 =?utf-8?B?LzVNeWNtVzR5RkorclQxOTFlRGR2aTNiSmNBTGk0UWYwcTVnZER6QllWVzlX?=
 =?utf-8?B?aVVSc2RubHU1UDdxWC9iSFB2bmdJcHpaZ3dtRjFkcmZSMzBFWE9EU3RRUU1G?=
 =?utf-8?B?SWpBaldmKzdBT0dIY0ovd1NweTRZdEVnUldrZ1NkcUEwVTVDMzFYZHNNRDRS?=
 =?utf-8?B?cGx3d0dTNFhha0dCN0l4WlU5UDFwOGVxWnM4NWlHTHFHN0dVVkp6aGtRSXdV?=
 =?utf-8?B?QjJ3MWkrSEp0d3ZqREphRlJrL29GK0tRazlQVzlFRmVnLzd6OXErUEREUDlO?=
 =?utf-8?B?VVlaaUFjRTZpYzhxNlhyK20rTzRYYXdYY3FieFUrSGpFVWt6QmlvYlZSc1g3?=
 =?utf-8?B?U3VvRk5LREgyK09ySzhqdExub2ZGUVBMKzd4YTExN3VoakdURk1hb3Y1ZXBq?=
 =?utf-8?B?ekk2VU1KOUhFNHg0aTZwT2xvTlhYMnEycWtpQmQzelRnTE42d2JVdnQ0cnhU?=
 =?utf-8?B?emRMNjJ2YzNtTGxFdUxxQkhSeU44UGlSSS8wU29mUnhIMmhzM2JCVmJwdmhE?=
 =?utf-8?B?ZDVSM09kWVJGNjNRKzJKRTFFU0gvYnlnb2JoZWhPaFhnc3hIOUM4cTFiU2s4?=
 =?utf-8?B?NWFqSHdEYng0YnoyVXl3ZWFtV0w3MGxqSFRZK2hjQnZTUjRDNHdSSHhTaE5Y?=
 =?utf-8?B?UGpleGl1clhVTXE3UExEOXdQZkM5UjBEc2JTNlJKQ1I2ek84YzVHY1crc3k5?=
 =?utf-8?B?aE9xdWFzYVdsSkFnYTZoTUVZY3ZGMlk3bXZQUFRBM1dsclBrdGN4V21tbEdN?=
 =?utf-8?B?Y2JCdk9YeFordkdxYVRMZVdlZGVRaitCazBhS0xKVUtzTXQ0Tm9pYWVJZjdQ?=
 =?utf-8?B?NTJSbzBsUGNQTnlKWnVJZkVCMmZ1emlMbUF2b3BBQjNreFovY0dOSjNwY0FP?=
 =?utf-8?B?TUx3VGViVlJoUHpzM1JOTi9BdWRuSFFUWFV3c0lla1BLMnFGcVY2dk9lMjlo?=
 =?utf-8?B?WVhndHQrSXRVeE1iTXZPZzBleGswSUtBV2dLN28zV2ZhSlB6T2FqR2pqQnhE?=
 =?utf-8?B?MVNGNzFCODVONE93MnY2VitGa291bHhGek8yNkt6L2VOSXV3Q2VockVXbjNt?=
 =?utf-8?B?SEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <16F8980A44E9B040B20D797E3B3DDB4A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8ffaa42-6194-4373-eda4-08dc7e57f7b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2024 14:19:06.2986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +lUGHtqEPV+/POltbOGPhxiYv3uUHydknTHZMEFM/4XNNi9hys3iWxoIro7KaxZGaYIWigr+tLJkBBIXz7hQ8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4642
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTA1LTI3IGF0IDE0OjU1ICswMjAwLCBEYW5pZWwgTGV6Y2FubyB3cm90ZToN
Cj4gDQo+IEhpIFNyaW5pdmFzLA0KPiANCj4gdGhlIHBvd2VyY2FwIEFCSSBleHBvcnRzIHNvbWUg
Y29uc3RyYWludCBmaWxlcy4gRXZlbiBpZiBJIHN1c3BlY3QNCj4gdGhlaXIgDQo+IHNlbWFudGlj
IGl0IGlzIG5vdCByZWFsbHkgY2xlYXIgaG93IHRoZXkgc2hvdWxkIGJlaGF2ZS4NCj4gDQo+IMKg
wqDCoMKgwqDCoCDilILCoMKgIOKUnOKUgOKUgGNvbnN0cmFpbnRfMF9uYW1lDQo+IMKgwqDCoMKg
wqDCoCDilILCoMKgIOKUnOKUgOKUgGNvbnN0cmFpbnRfMF9wb3dlcl9saW1pdF91dw0KPiDCoMKg
wqDCoMKgwqAg4pSCwqDCoCDilJzilIDilIBjb25zdHJhaW50XzBfdGltZV93aW5kb3dfdXMNCj4g
wqDCoMKgwqDCoMKgIOKUgsKgwqAg4pSc4pSA4pSAY29uc3RyYWludF8xX25hbWUNCj4gwqDCoMKg
wqDCoMKgIOKUgsKgwqAg4pSc4pSA4pSAY29uc3RyYWludF8xX3Bvd2VyX2xpbWl0X3V3DQo+IMKg
wqDCoMKgwqDCoCDilILCoMKgIOKUnOKUgOKUgGNvbnN0cmFpbnRfMV90aW1lX3dpbmRvd191cw0K
PiANCj4gQXJlIHRoZSBjb25zdHJhaW50cyBjb250cm9sbGVyIHNwZWNpZmljPyBJIG1lYW4sIGVh
Y2ggY29udHJvbGxlcg0KPiBkZWZpbmVzIA0KPiB0aGVpciBjb25zdHJhaW50cz8gT3IgaXMgaXQg
c3VwcG9zZWQgdG8gYmVoYXZlIHRoZSBzYW1lIHdheSB3aGF0ZXZlcg0KPiB0aGUgDQo+IGNvbnRy
b2xsZXI/DQoNCkN1cnJlbnRseSB3ZSBoYXZlIHRocmVlIGNvbnRyb2xsZXJzLCBNU1IgUkFQTCwg
TU1JTyBSQVBMIGFuZCBUUE1JIFJBUEwuDQpUaGV5IGFyZSBhY3R1YWxseSB0aGUgc2FtZSBmZWF0
dXJlIChSQVBMKSB2aWEgZGlmZmVyZW50IHJlZ2lzdGVyDQpJbnRlcmZhY2VzLg0KU28gdGhlaXIg
YmVoYXZpb3JzIGFyZSBjb25zaXN0ZW50Lg0KDQo+IA0KPiBJcyB0aGUgdGltZSB3aW5kb3cgZ2l2
aW5nIHRoZSBkdXJhdGlvbiBvZiB0aGUgcG93ZXJfbGltaXRfdXcNCj4gY29uc3RyYWludD8gDQo+
IE9yIGlzIGl0IGFuIGF2ZXJhZ2UgcG93ZXIgZHVyaW5nIHRoaXMgdGltZSB3aW5kb3c/DQoNClRo
ZSBhdmVyYWdlIHBvd2VyIGR1cmluZyB0aGlzIHRpbWUgd2luZG93Lg0KVGhlIGNvbnN0cmFpbnQg
aXMgYWx3YXlzIGVmZmVjdGl2ZSBhZnRlciB3ZSBzZXQgaXQuDQoNCj4gDQo+IFdoYXQgaXMgdGhl
IHB1cnBvc2Ugb2YgbWlufG1heF90aW1lX3dpbmRvd191cz8NCg0KSXQgaXMgdGhlIHVwcGVyL2xv
d2VyIGxpbWl0IGZvciB1c2VycyB0byBzZXQgYSBtZWFuaW5nZnVsIHRpbWUgd2luZG93Lg0KDQo+
IA0KPiBDYW4gd2Ugc2V0IHNldmVyYWwgY29uc3RyYWludHMgb3IgYXJlIHRoZXkgbXV0dWFsbHkg
ZXhjbHVzaXZlPw0KDQpNeSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQgdGhleSBjYW4gYm90aCB0YWtl
IGVmZmVjdC4NCiJUd28gcG93ZXIgbGltaXRzIGNhbiBiZSBzcGVjaWZpZWQsIGNvcnJlc3BvbmRp
bmcgdG8gdGltZSB3aW5kb3dzIG9mDQpkaWZmZXJlbnQgc2l6ZXMuIEVhY2ggcG93ZXIgbGltaXQg
cHJvdmlkZXMgaW5kZS0NCnBlbmRlbnQgY2xhbXBpbmcgY29udHJvbCB0aGF0IHdvdWxkIHBlcm1p
dCB0aGUgcHJvY2Vzc29yIGNvcmVzIHRvIGdvDQpiZWxvdyBPUy1yZXF1ZXN0ZWQgc3RhdGUgdG8g
bWVldCB0aGUgcG93ZXINCmxpbWl0cy4iDQoNCj4gDQo+IElzIHRoZXJlIGFueSBkb2N1bWVudGF0
aW9uIGRlc2NyaWJpbmcgd2l0aCBtb3JlIGRldGFpbHMgdGhlIEFCSXM/DQo+IA0KSW50ZXJlc3Rp
bmcsIEkganVzdCBmb3VuZCB0aGlzIG9uZSwNCkRvY3VtZW50YXRpb24vQUJJL3Rlc3Rpbmcvc3lz
ZnMtY2xhc3MtcG93ZXJjYXAsIHNob3VsZCB3ZSBtb3ZlIGl0IHRvDQpzdGFibGU/IE90aGVyIHRo
YW4gdGhhdCwgSSBkb24ndCBrbm93Lg0KDQp0aGFua3MsDQpydWkNCg0K

