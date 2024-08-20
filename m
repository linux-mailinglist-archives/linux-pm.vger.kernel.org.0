Return-Path: <linux-pm+bounces-12530-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 062D7957F10
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 09:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A31B1F237F9
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 07:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B68116BE0F;
	Tue, 20 Aug 2024 07:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cVFtVYTu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF2818E34A;
	Tue, 20 Aug 2024 07:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724137699; cv=fail; b=m7Ib0+jCjBMnUS5Yxn/e139gVK7kBtYjz0GQFFzmBmbDW37zvE/or1xbLVyuOseldJDnKr1TpPSy+ehmFEypZZRziGa5m/UCvQ2xhjfQ7BJz5LQeNW+hCnitd3tlISUS6cd2DkrTfWjmDb9ONG1yuIr56tm0X5H5Ck0IJa3l/Vo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724137699; c=relaxed/simple;
	bh=/MK8gkj2a99PR5NPZ4HYVHi91GYxtq5KgKvjNOQFOX8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mLzwCfb5wD36uKNXUaWNACZRWhyqGpITfb1G0qrUJx50TSN4k+kh9/l7bqUy1EyGXexLjgadWDJjYvnOgBIgR3+uHxIuAhekFzp4qFK6Xce0rywJSuVayMYDVHyiV+bfp06Fnctme9LzRRZsHtniTtcLELP/wlISCzBq68RyvIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cVFtVYTu; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724137697; x=1755673697;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/MK8gkj2a99PR5NPZ4HYVHi91GYxtq5KgKvjNOQFOX8=;
  b=cVFtVYTu9BkH3656A2rI6B5UAkV5ZXfd5asVY7BQjv6g9BvhRUr0A2Dv
   f/IZskVL6qoYh4xmCO3K9FYmgNGlj+c1M/ZNaqV/SvRYUV6nHsN8houWF
   7dETs3nFgQgyopHM4ysIH6Vei4CCL4UiMIkVX7oF0W1DKvDZQsFdYqaNw
   HJyPobOwPoFVAKvGAXnmubaQUZFTVYEYttv7L5chn9uPLMcZcbHkZLJAG
   fJJ/vKuubVHUMJKJcfLyRE1BnEWK6nNtn4GHAsdiHBmqCR3uey+JNj8EO
   UnIrch1cNmSO7gxxXxDumI+LoE9ST9X4rxeXsuFo6fG2HhLX3xg5znNUJ
   Q==;
X-CSE-ConnectionGUID: BmUI1R+VT2KUF+ZAhaf9tg==
X-CSE-MsgGUID: 4cA0rZNMQR+PbNS9Ghzz2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="26216427"
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="26216427"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 00:08:17 -0700
X-CSE-ConnectionGUID: /FhcuaRqQnCZOARvDomG/w==
X-CSE-MsgGUID: 4gLm1T6VT16asT/zilVAgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="65454314"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 00:08:17 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 00:08:16 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 00:08:16 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 00:08:16 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 00:08:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PczjZdOzZLPO0yghbGkRaFKPMkzCHrhEl0KPfz45U418HF5ND25k1gP083cGAvRhZm6NPrRumizztL+ryKmCYOV5g3VHYW4hGkA+NFY+q/+bcH7ArrKfJB1rXdX1y5tVldUau9VNkgG1LZ+obTctY09X9WihEs65kqVQapqtA38DLdFPjZaW80wWK2I9gHOIJL8IHRp48XhuAx1R+ECiohrdji7whOeGD0o9ilEaHmE9xLnTkU+rwF12Qu/ixqG6Bt9H13PW7cPBbTcNreHsV/CW07llbYrqkqoHhStJhTD0X70RydY+fQn79dB17Y8vFnR4II10w0KHK35dQcxKyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/MK8gkj2a99PR5NPZ4HYVHi91GYxtq5KgKvjNOQFOX8=;
 b=C0t5rYGH+SaVnhRLQD+ga1eHPYR/fmiIWPS/Kbk3ceMl1UtZ3QlsbpgKUZXqV6qnrhTnq0nNY545oi0ZXbrPsd8gECe6JIivHyjkCaG+7izy22/vDC2xR7j8L6CUm3XMHVPnSea+MxY6+vPDo04j3VDC9wBevRUPmt/CPFNVlgzDidg/m4lW12wn9mOWM5DwoZso6ERevGA3PGEhMi7Ank/PnBl7QAXdoM3bpDrDAwQyG5PuqgSi1IgyLvqX4w2cly+Dw3W54IS10/VjfcTzVZR6Z6MrBMyrfGB59yQ/QxY/ToAVYQvD4/gRrnqY2tWHTgXaL28x5xqqokOJQeCVNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by PH0PR11MB5125.namprd11.prod.outlook.com (2603:10b6:510:3e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Tue, 20 Aug
 2024 07:08:14 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%4]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 07:08:14 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@rjwysocki.net"
	<rjw@rjwysocki.net>
CC: "lukasz.luba@arm.com" <lukasz.luba@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v3 08/14] thermal: core: Unexport
 thermal_bind_cdev_to_trip() and thermal_unbind_cdev_from_trip()
Thread-Topic: [PATCH v3 08/14] thermal: core: Unexport
 thermal_bind_cdev_to_trip() and thermal_unbind_cdev_from_trip()
Thread-Index: AQHa8lKtewV6YKihPECWQM0vbI9UO7IvusuA
Date: Tue, 20 Aug 2024 07:08:14 +0000
Message-ID: <11021c846dea715b512bd16b6e4fd3426c5bd77d.camel@intel.com>
References: <2205737.irdbgypaU6@rjwysocki.net>
	 <3512161.QJadu78ljV@rjwysocki.net>
In-Reply-To: <3512161.QJadu78ljV@rjwysocki.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|PH0PR11MB5125:EE_
x-ms-office365-filtering-correlation-id: dfd00eb0-ab3d-47b6-4536-08dcc0e6dbe7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?R2RsekNBUjMwOWJKcjlsbUVyTDkvTlFFTEx2QmlYUUNjYyt5RmFNUEcyMWN2?=
 =?utf-8?B?WFBIam1vOEJkbVlVMXg3cWIyQlJuQ2JIUXBQVEdDVTNDdUpvOVpMaUZyY2g2?=
 =?utf-8?B?V3pBaHVFWlhTYkdmNk1aWHJ4elF4cjVjTDRDaHNXOGo2OUptYjJUUUVUQy9y?=
 =?utf-8?B?Y1g4azVySFMvKy9wSW12WjJHcTRaWXpRcjJvTFp5N3hrWHYxRlpPWHVmL1d1?=
 =?utf-8?B?SFpldUdJdHdPdmJjdW5ySW5JUHBDWmROQ0YweS9CY21qS05aa3ZQb291K3Vw?=
 =?utf-8?B?aWlsVTU5eXlVeGxnNVBGWTN0cjU1WGhicEs1UGJCbFNGWFdGWHFrMWtPK0xQ?=
 =?utf-8?B?eWkzM0t6UnprR1dCQkpJc2kvRjFhSGJOQmV6UE5WV3ZUcTFyc29LU1ZDTGpG?=
 =?utf-8?B?ZkQ0dGt1a3ZOSlZiVlo0ZnE2RkdMTXcxdTdkZE1YRFZvVE5Idlk2YlZPVWNQ?=
 =?utf-8?B?TFp2OWtGdTVjRC9MbUxSdSs4aHpiVE9RaEpoT3ZyNjRRMlhKSTZoSWphSGp6?=
 =?utf-8?B?SjN0T2xVRlpJODhDMjRJa1Z0NDlMbGJWNWZnamdZb3kyN0hTQ1RkZ3V4K0U3?=
 =?utf-8?B?VVhBWVdEdVcxZE1wZ3BIK1h5bWQ0aE1mK0ZXUFdXTEoweERBbFlSTVM3MW5x?=
 =?utf-8?B?L0RRSXJERDB3T3dXV2IxNGJoUU9IdnhVVzlmRFRBUzk0Ym9YV3RuMTAxUm1t?=
 =?utf-8?B?bnpSazlHNlUxZm5oT2VkS0V6czRIdmpQeUNLem0xSjdQdGVwNDhVYjZvbisx?=
 =?utf-8?B?clhoeFFaTVVoK1ZiSTBtenZiYUZaMzJsYVdMTFh2UlhNcS8ra2RPem9VUm5E?=
 =?utf-8?B?MWEwd0QwaHgrZ1VrQWlYaU5lZTVlN08wNVRJOUM3clVsQWx3UWNieGI5UTJQ?=
 =?utf-8?B?UzVkWWthTmN1bkpzOGFqNUpCTFd2MVIwZ3NuYmVzOEtlclpUYXdXdHIxYm5J?=
 =?utf-8?B?Um5BOTUzOEwvdzdxKzBOTU1uWHQvaXY4UEpRZmhxT3JYY2tSL2UyK0hFSm95?=
 =?utf-8?B?SC9nQ292eDhsalk4Y2FLMmhnN09kRFpvc1dMNUVWQkFxUkJzZ0lid1J2UVYw?=
 =?utf-8?B?SGd1U3ZEclNNT2dMMWI1Y3NLOEF0cUJvaWM3R1ZDWHRvUncrTFJLV0FBYzhY?=
 =?utf-8?B?b2ZjTXVWNGM1RjlkUzBiaVIrNmFuR3FRb1k1WDQveHB4SEVxck90Y1NHL2lF?=
 =?utf-8?B?SW41UGdzNUJqbE1sc1BZMXZuZGt1dk04UGJhTXZCb0dvVUUzOG50Rkw5bHJK?=
 =?utf-8?B?RS82emxiZ2Y2aHVKc0ZwMTYwZHN2bmdSR0pzUFc4Y0VONWl1VnJpUzFidnp3?=
 =?utf-8?B?NENUa3d3UUNGbFFPdVBuOHRiczRLUEQrOU1zSGhzdnJqdWxtWWtSYUpmUnBm?=
 =?utf-8?B?MEVBYkZBakl1cEs2VmtRMFJ3bGhveUZRS1NjU2NEVWZOQ3lpWUhMS1ZneFAy?=
 =?utf-8?B?MWtMc2NLNTgvRS94MDNXRlEvMktGRkRiQ0M3K05WdzAyZWFER2RWdEt0RXJh?=
 =?utf-8?B?UlFUYjhLUnl3OFJvTFFkNklUSzVSNVdHZFEwL2VHSjJVNi94Vm85cERhak9U?=
 =?utf-8?B?TmdTRkpmWnNRM285OGNXajl1QmpUUzJkRUZYczhodTFTZFVUM1NqQzFnVDA3?=
 =?utf-8?B?WTNpeFJhcFlDOXJGT2JnWXVKTjJRRm13QzJoa2VkNHFkNEQxbkY1NE9sWm03?=
 =?utf-8?B?RUlILzdTcmJtNjR0dUY1YVF3ZzZZTG42NGFObEFnSnlVNHNzTFRJQk1wNEZ4?=
 =?utf-8?B?ekxKRDdhUk95Z1NzTmVuZGZjV0IvQjdkSk9aTmZ2d1UxNVpkeDBtOHZud1NM?=
 =?utf-8?Q?Gw6sJikOSUzPvZG8H6lpDmMrsr55laYTlLNHA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TDQ4R3ZPc3lhY1hkcHl5bmFESEhMOHpYTzYvSG1sRXhYOFFvSHp1RVNmWmNi?=
 =?utf-8?B?UlpKQzB1RkJUa3RyN0c5NzNWbWJLS2dHeC9YZUZDb3dZeUtoN1BzZDVrY0J0?=
 =?utf-8?B?ZEtSVTVCVWhBN3JHa0ltMzhkclpLcWh0bkNLVkIxRVY2aFhpUVpKa0g1YzRn?=
 =?utf-8?B?YURJWnZBbTcrK0E3SnZqYnV1alpWeWRmSjVYOS93cnJqc1JvQWV3YUI0TTFH?=
 =?utf-8?B?ZVM5T2cwLzhhYXN5OG85RDhNUnZIRUQxMVRQYmEvQlM3dUNYS0tCYWVoVGtm?=
 =?utf-8?B?aFc1ZkVWZngxT2loM0Nhcnpwd0c3OFRKVzVlS29WZlk0SFlMcUpUL1ZJVHha?=
 =?utf-8?B?SjcyWUJJUzZtenJLcklmU3dtVmFZaU5PZmkvVU1ZYlBicnFvenNZV1JpVFJK?=
 =?utf-8?B?ajRyVFJySFY3TWFsdlBjOEtkaGppOWFydEI4bC9MM3FwdzVkalVvNi9uZjho?=
 =?utf-8?B?Ri8wNkY4Yk1pc2lQeWlWZC9yZHVxUkJtT1FxSzRDN3BwWnN4R20yOHJueUNs?=
 =?utf-8?B?eWpOd1ZZN0thR1NXZFNEUjBBcEZoRlBQSmJSMkozaFFjeUhJTkx6eXhKQU44?=
 =?utf-8?B?NUIyeGhZTUk1UTdlL2VNVElZamJCclVwRGkzWWdhR3VtZUhrVFhQREpEaWxJ?=
 =?utf-8?B?dUxib1RPc3gxWFdWQURnNC9LS1B6MEVxaGlYTEJkRWszYXkvdTJHUm9kOVpX?=
 =?utf-8?B?cmJQKzNRYTdyZkNtdld1TXRSTlI4VHBiMEhXNXBOc09LU3VRckRYWG5BMjg0?=
 =?utf-8?B?dVdlWUdrTVI5VWNiYzhoUFl0S1ZOcCs4Zm5nTzZQTUxZaFdGVkQxUW9xMGg2?=
 =?utf-8?B?RzBsOFBrcmQrYThHWnJmc0cwSjh4cERNNnBxTEtaNWVZWXNYK09BY1haWXUz?=
 =?utf-8?B?Z0RXSzhLSlE4cmwyaGtCWnZoNFg3WitIV2F5UFdTNFpraDNNYi9rb2xaNzND?=
 =?utf-8?B?UFZ4VUJuenZUY0FlWmd6Qnhpa3ZWK09xQ1VQWjdnNi8vcGxCSDR3cXFnaTVt?=
 =?utf-8?B?cTRBUmQyMTRpN1RVRGRNdVZ4ei9mUzljbzUrenBjZHpaTUtoWHFuRmdqK3lI?=
 =?utf-8?B?RmptN0tSVk93L2F5NjFQbGpPV3lrMUJtNW9XaUVSMWF4eU03cEhES1hpaGxi?=
 =?utf-8?B?V2xjNEdjUXFqRGl5RFVkWndLZktoQ2xOb1lkZzZhOHdoMzFmdWsvSU5yM2w0?=
 =?utf-8?B?L1orYTVvWEtUZW1WTWJHS0VRTTJqaHF1WU9BR1o3aFdvNTlqV3lDV0xvRWNp?=
 =?utf-8?B?RnVkYmFiU2JURUFWTzEwdHg5M3MzdFVETTZQN2w2QndORVVUSjBUVmdjQmVJ?=
 =?utf-8?B?WmZ0b2ljSmM0d3hyMkhNRWp4MFJqOG1qWDg5OHZNS21ZMlJlcURoaHp6ZHJV?=
 =?utf-8?B?eml6MjQ1VUhDZnJNNExLM1F5QWEybld5TWdKeUxGTURLTkF5VW9rbFFqQ2Qx?=
 =?utf-8?B?akYwZ0d2ZmFiU1NHNjBPQ1p3YkE3aXVTOXZvam9kbHFvYXpNYzlaUjF1d1Ny?=
 =?utf-8?B?a3ltVDZ3cFVpd29jODRXc2Z2L1I4NFBNcXFXak1PZkZxRTVReDB1cHRNSFdU?=
 =?utf-8?B?QkNqMjQ3SGlmMEIxc2NQM3JMSU5kcVgvTXdYY2hlRys2bnlkeFMwUUE0RGhi?=
 =?utf-8?B?azBaeGlMQm5UbzBsQTZhRXp1dHpHN0VQTlNCb1F4V3lVL1JKT2RkN0ZKTVA2?=
 =?utf-8?B?R1c3V1JhbzRETFVXdjRWU2FkWGsxMU5QakJrQ2o2N2V2VFZZb2JNNWduNGRL?=
 =?utf-8?B?U3Npd2JFV0RlNFVWVnBhRlZPZjRWUExEUUVmL2ZmMVd2SzZIeDJVeGhoVEhz?=
 =?utf-8?B?UDdYVktjSFJBVmNEazRHUk4wSmp6SUlMUDMxenVRYXBjaEw2ajEvS1pySmE0?=
 =?utf-8?B?TStFQzVYRFdoM0dVWWtQZUdkTVpJbjZRM0poUjQ5SEtZcjVaVkp1aUt6d3R3?=
 =?utf-8?B?dFU0YnpheW1pNy9TcFloVVlBUHJHcngvcUROYTFEVm54aEZEVXN3ZGsrZTRJ?=
 =?utf-8?B?R0V0RXQ1SWt3cHo1ZHdQR0ZiQ3pRd25RN2VtS3FJaXJBd2VWU2VzYWZpWlZw?=
 =?utf-8?B?Z3hSZWp6S1dnbjRVbGdYZFJhSzNkK3JCQVMyWlB5UzdRVDJtY2lNa1VpWjJS?=
 =?utf-8?B?TTdDZ0hFS3loSHpXRm0wTUdiNzNsakFoMWlncDlvcUZvaHl0MDNLc1NjN0w1?=
 =?utf-8?B?UXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <517FE9904C937540B6AE1C58214937EB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfd00eb0-ab3d-47b6-4536-08dcc0e6dbe7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 07:08:14.3904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E96c43bX6Tjl9VPdeN7y6VepJJnoQlX8gZSwUwDcK8NfsLEKemjSBZg0DloJSq4oQwvl9uPSGyPhm988d+G5fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5125
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTA4LTE5IGF0IDE4OjA1ICswMjAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToKPiBGcm9tOiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb20+
Cj4gCj4gU2luY2UgdGhlcm1hbF9iaW5kX2NkZXZfdG9fdHJpcCgpIGFuZCB0aGVybWFsX3VuYmlu
ZF9jZGV2X2Zyb21fdHJpcCgpCj4gYXJlIG9ubHkgY2FsbGVkIGxvY2FsbHkgaW4gdGhlIHRoZXJt
YWwgY29yZSBub3csIHRoZXkgY2FuIGJlIHN0YXRpYywKPiBzbyBjaGFuZ2UgdGhlaXIgZGVmaW5p
dGlvbnMgYWNjb3JkaW5nbHkgYW5kIGRyb3AgdGhlaXIgaGVhZGVycyBmcm9tCj4gdGhlIGdsb2Jh
bCB0aGVybWFsIGhlYWRlciBmaWxlLgo+IAo+IE5vIGludGVudGlvbmFsIGZ1bmN0aW9uYWwgaW1w
YWN0Lgo+IAo+IFNpZ25lZC1vZmYtYnk6IFJhZmFlbCBKLiBXeXNvY2tpIDxyYWZhZWwuai53eXNv
Y2tpQGludGVsLmNvbT4KClJldmlld2VkLWJ5OiBaaGFuZyBSdWkgPHJ1aS56aGFuZ0BpbnRlbC5j
b20+Cgp0aGFua3MsCnJ1aQoKPiAtLS0KPiAKPiB2MiAtPiB2MzogUmViYXNlIGFmdGVyIGRyb3Bw
aW5nIHBhdGNoZXMgWzA0LTA1LzE3XSBmcm9tIHRoZSBzZXJpZXMKPiAKPiB2MSAtPiB2MjogTm8g
Y2hhbmdlcwo+IAo+IC0tLQo+IMKgZHJpdmVycy90aGVybWFsL3RoZXJtYWxfY29yZS5jIHzCoMKg
IDEwICsrKystLS0tLS0KPiDCoGluY2x1ZGUvbGludXgvdGhlcm1hbC5owqDCoMKgwqDCoMKgwqAg
fMKgwqDCoCA4IC0tLS0tLS0tCj4gwqAyIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwg
MTQgZGVsZXRpb25zKC0pCj4gCj4gSW5kZXg6IGxpbnV4LXBtL2RyaXZlcnMvdGhlcm1hbC90aGVy
bWFsX2NvcmUuYwo+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT0KPiAtLS0gbGludXgtcG0ub3JpZy9kcml2ZXJzL3RoZXJt
YWwvdGhlcm1hbF9jb3JlLmMKPiArKysgbGludXgtcG0vZHJpdmVycy90aGVybWFsL3RoZXJtYWxf
Y29yZS5jCj4gQEAgLTc3Myw3ICs3NzMsNyBAQCBzdHJ1Y3QgdGhlcm1hbF96b25lX2RldmljZSAq
dGhlcm1hbF96b25lCj4gwqAgKgo+IMKgICogUmV0dXJuOiAwIG9uIHN1Y2Nlc3MsIHRoZSBwcm9w
ZXIgZXJyb3IgdmFsdWUgb3RoZXJ3aXNlLgo+IMKgICovCj4gLWludCB0aGVybWFsX2JpbmRfY2Rl
dl90b190cmlwKHN0cnVjdCB0aGVybWFsX3pvbmVfZGV2aWNlICp0eiwKPiArc3RhdGljIGludCB0
aGVybWFsX2JpbmRfY2Rldl90b190cmlwKHN0cnVjdCB0aGVybWFsX3pvbmVfZGV2aWNlICp0eiwK
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgY29uc3Qgc3RydWN0IHRoZXJtYWxfdHJpcCAqdHJpcCwKPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgc3RydWN0IHRoZXJtYWxfY29vbGluZ19kZXZpY2UKPiAqY2RldiwKPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgdW5zaWduZWQgbG9uZyB1cHBlciwgdW5zaWduZWQKPiBsb25nIGxvd2VyLAo+
IEBAIC04NzcsNyArODc3LDYgQEAgZnJlZV9tZW06Cj4gwqDCoMKgwqDCoMKgwqDCoGtmcmVlKGRl
dik7Cj4gwqDCoMKgwqDCoMKgwqDCoHJldHVybiByZXN1bHQ7Cj4gwqB9Cj4gLUVYUE9SVF9TWU1C
T0xfR1BMKHRoZXJtYWxfYmluZF9jZGV2X3RvX3RyaXApOwo+IMKgCj4gwqBpbnQgdGhlcm1hbF96
b25lX2JpbmRfY29vbGluZ19kZXZpY2Uoc3RydWN0IHRoZXJtYWxfem9uZV9kZXZpY2UgKnR6LAo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBpbnQgdHJpcF9pbmRleCwKPiBAQCAtOTEzLDkgKzkxMiw5IEBAIEVY
UE9SVF9TWU1CT0xfR1BMKHRoZXJtYWxfem9uZV9iaW5kX2Nvb2wKPiDCoCAqCj4gwqAgKiBSZXR1
cm46IDAgb24gc3VjY2VzcywgdGhlIHByb3BlciBlcnJvciB2YWx1ZSBvdGhlcndpc2UuCj4gwqAg
Ki8KPiAtaW50IHRoZXJtYWxfdW5iaW5kX2NkZXZfZnJvbV90cmlwKHN0cnVjdCB0aGVybWFsX3pv
bmVfZGV2aWNlICp0eiwKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb25zdCBzdHJ1Y3QgdGhlcm1hbF90cmlwICp0cmlw
LAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHN0cnVjdCB0aGVybWFsX2Nvb2xpbmdfZGV2aWNlCj4gKmNkZXYpCj4gK3N0
YXRpYyBpbnQgdGhlcm1hbF91bmJpbmRfY2Rldl9mcm9tX3RyaXAoc3RydWN0IHRoZXJtYWxfem9u
ZV9kZXZpY2UKPiAqdHosCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb25zdCBzdHJ1Y3QgdGhl
cm1hbF90cmlwCj4gKnRyaXAsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QKPiB0aGVy
bWFsX2Nvb2xpbmdfZGV2aWNlICpjZGV2KQo+IMKgewo+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3Qg
dGhlcm1hbF9pbnN0YW5jZSAqcG9zLCAqbmV4dDsKPiDCoAo+IEBAIC05NDUsNyArOTQ0LDYgQEAg
dW5iaW5kOgo+IMKgwqDCoMKgwqDCoMKgwqBrZnJlZShwb3MpOwo+IMKgwqDCoMKgwqDCoMKgwqBy
ZXR1cm4gMDsKPiDCoH0KPiAtRVhQT1JUX1NZTUJPTF9HUEwodGhlcm1hbF91bmJpbmRfY2Rldl9m
cm9tX3RyaXApOwo+IMKgCj4gwqBpbnQgdGhlcm1hbF96b25lX3VuYmluZF9jb29saW5nX2Rldmlj
ZShzdHJ1Y3QgdGhlcm1hbF96b25lX2RldmljZQo+ICp0eiwKPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGludCB0cmlwX2luZGV4LAo+IEluZGV4OiBsaW51eC1wbS9pbmNsdWRlL2xpbnV4L3RoZXJtYWwu
aAo+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT0KPiAtLS0gbGludXgtcG0ub3JpZy9pbmNsdWRlL2xpbnV4L3RoZXJtYWwu
aAo+ICsrKyBsaW51eC1wbS9pbmNsdWRlL2xpbnV4L3RoZXJtYWwuaAo+IEBAIC0yNDcsMTggKzI0
NywxMCBAQCBjb25zdCBjaGFyICp0aGVybWFsX3pvbmVfZGV2aWNlX3R5cGUoc3RyCj4gwqBpbnQg
dGhlcm1hbF96b25lX2RldmljZV9pZChzdHJ1Y3QgdGhlcm1hbF96b25lX2RldmljZSAqdHpkKTsK
PiDCoHN0cnVjdCBkZXZpY2UgKnRoZXJtYWxfem9uZV9kZXZpY2Uoc3RydWN0IHRoZXJtYWxfem9u
ZV9kZXZpY2UgKnR6ZCk7Cj4gwqAKPiAtaW50IHRoZXJtYWxfYmluZF9jZGV2X3RvX3RyaXAoc3Ry
dWN0IHRoZXJtYWxfem9uZV9kZXZpY2UgKnR6LAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb25zdCBzdHJ1Y3QgdGhlcm1hbF90cmlw
ICp0cmlwLAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBzdHJ1Y3QgdGhlcm1hbF9jb29saW5nX2RldmljZSAqY2RldiwKPiAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdW5zaWdu
ZWQgbG9uZyB1cHBlciwgdW5zaWduZWQgbG9uZwo+IGxvd2VyLAo+IC3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBpbnQgd2Vp
Z2h0KTsKPiDCoGludCB0aGVybWFsX3pvbmVfYmluZF9jb29saW5nX2RldmljZShzdHJ1Y3QgdGhl
cm1hbF96b25lX2RldmljZSAqLAo+IGludCwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IHRoZXJt
YWxfY29vbGluZ19kZXZpY2UgKiwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgbG9uZywgdW5z
aWduZWQgbG9uZywKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgaW50KTsKPiAtaW50IHRoZXJt
YWxfdW5iaW5kX2NkZXZfZnJvbV90cmlwKHN0cnVjdCB0aGVybWFsX3pvbmVfZGV2aWNlICp0eiwK
PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBjb25zdCBzdHJ1Y3QgdGhlcm1hbF90cmlwICp0cmlwLAo+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0
cnVjdCB0aGVybWFsX2Nvb2xpbmdfZGV2aWNlCj4gKmNkZXYpOwo+IMKgaW50IHRoZXJtYWxfem9u
ZV91bmJpbmRfY29vbGluZ19kZXZpY2Uoc3RydWN0IHRoZXJtYWxfem9uZV9kZXZpY2UgKiwKPiBp
bnQsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgdGhlcm1hbF9jb29saW5nX2RldmljZQo+
ICopOwo+IMKgdm9pZCB0aGVybWFsX3pvbmVfZGV2aWNlX3VwZGF0ZShzdHJ1Y3QgdGhlcm1hbF96
b25lX2RldmljZSAqLAo+IAo+IAo+IAoK

