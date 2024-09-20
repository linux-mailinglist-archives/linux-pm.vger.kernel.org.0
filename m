Return-Path: <linux-pm+bounces-14509-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2264D97D0E5
	for <lists+linux-pm@lfdr.de>; Fri, 20 Sep 2024 07:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47C711C218F0
	for <lists+linux-pm@lfdr.de>; Fri, 20 Sep 2024 05:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C3B3FB3B;
	Fri, 20 Sep 2024 05:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="yb/7xzU6"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0153BB22;
	Fri, 20 Sep 2024 05:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726809335; cv=fail; b=paZ2cghA1amHLJA7BrqRX+C82k8UeQYOcMmaIRWJnmhMY6pBC/Qar4Z/2C+xYDhpdx8jv/BJJomGxABsXYu284Ne/WaI30v5Syu02xiCAZ8HtU0hbtelB8qBlhye6rs5m8wbV5X2TpklGReWU3x3rSUwP/ULWn9m7fu3Jw18owQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726809335; c=relaxed/simple;
	bh=EdUfwwVGRuT/SVo3/TKVhT7DhGtXbiTQ0WngS2T5TPc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J1Sw7vWtJmBItkKxSrPCziXs7f87GCtnYtWB/qDHMlZhOAOjb78hBXtJymOr/fE+tYUZB9ZAhZdBwIEfPOUXaaKTrBfc0dkBxCXJCLNHDbe98gda2O8YUJfpw8pVHhDr56knnCUjjbIMPOaK5EzCL10GPmCA1xo7Jn2D18EmkjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=yb/7xzU6; arc=fail smtp.client-ip=40.107.244.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qwU36m1us7QgyyErkRfWhoHuFDmhEQxgBs3/foWz0mD2Owo+jlUbsU8KoE3r5SnbVsfcTqkWUZXzMGIy3oYnrCLV5UJue4oh3WvRl/hgnyAYqPAf0w91yu8c8QkWtBhMuv1lCY6x8WHvh3jPzsrUxryxyCYUsRi/PvfPNhs2/hGV2TSNdRBOyl0Xg2BD+oRbpLfgYAADj/KhdcUUvUScDYRoXw+w/jl1oPZd1zulNA6innRCQkVO3S7ScweuQqskONHS6yJZV4zoLbprbpem+JqlyTJQQP+9GOILKRsQqY1cLwqzikRvyXN0rUFNpYSNFjqsfpFLAGYGN73dEC3SLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EdUfwwVGRuT/SVo3/TKVhT7DhGtXbiTQ0WngS2T5TPc=;
 b=PDZv1ihbyGzU+WTCrSWzXITedH5Q7iQvLepY1xZo+5e1UBW5Fo9mznqMQZUUFh+VR3uLhIJ1aOrsxsyjU0x7swYDJfdqGBTiDnCom7N5ZTw1GdC7MmOdlK19FzR/RnUNt1AmzFhXaAUs7vS+gMw7mJZnGEQFOErtas0Snb2qMBfSzm3T2bhgGOa3s0WPSvJaruEUPD8K5wpuQPXVE+4jQqYpTL+owbjN6B8/TPvXVC9saV/ruQD+FuYvVNPRMX+3lanwnIEpw6QGsUdKxxgo+p6utYRHuACNt9MIU2NI8BGjeXIkpxXcb0hSo0qqIlPiyx7SZI1EnCe+cNlU/J148w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EdUfwwVGRuT/SVo3/TKVhT7DhGtXbiTQ0WngS2T5TPc=;
 b=yb/7xzU622trBZv8DMU+A0r6EJnLB13Dtu+upavGHW9vBaWGx1Gc9ybE1nmeLNoUj8mcM4yFjIT9O4w3as1yAK8I6XKaW/v2EX279XVrgWmz9grXAHLk8u5cwkM9p0nn65YIbAp4fxSxtEiBkCAdPIi632CLxRa4w2iqiffNDJ+YXXhgrwRT212A8bC4JbmbKuh3skw5b/eLI9BKX7wbycV0Ngymfj6euK2iXqL53I0jWYBSN4fsGx5nH9/hTM330+DA3JhM+9xq/jquRWETruKmhf1dLYpW4MItAhWJZrFYxx8cwJsaI46w0LKdU2NESbBNEqcaSyYlZLd6aO+KWA==
Received: from SA0PR11MB4719.namprd11.prod.outlook.com (2603:10b6:806:95::17)
 by CY8PR11MB6937.namprd11.prod.outlook.com (2603:10b6:930:5b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Fri, 20 Sep
 2024 05:15:30 +0000
Received: from SA0PR11MB4719.namprd11.prod.outlook.com
 ([fe80::5303:b2dc:d84b:f3b2]) by SA0PR11MB4719.namprd11.prod.outlook.com
 ([fe80::5303:b2dc:d84b:f3b2%5]) with mapi id 15.20.7982.016; Fri, 20 Sep 2024
 05:15:30 +0000
From: <Varshini.Rajendran@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <tglx@linutronix.de>, <sre@kernel.org>,
	<p.zabel@pengutronix.de>, <Mihai.Sain@microchip.com>,
	<Andrei.Simion@microchip.com>, <Dharma.B@microchip.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v7 00/12] Add support for sam9x7 SoC family
Thread-Topic: [PATCH v7 00/12] Add support for sam9x7 SoC family
Thread-Index: AQHa/cwaNm5Q6ofHa0e2E+83MaNheLJgPKAA
Date: Fri, 20 Sep 2024 05:15:30 +0000
Message-ID: <33e94a83-e08d-4588-87f5-bd51903ee27a@microchip.com>
References: <20240903063913.48307-1-varshini.rajendran@microchip.com>
In-Reply-To: <20240903063913.48307-1-varshini.rajendran@microchip.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR11MB4719:EE_|CY8PR11MB6937:EE_
x-ms-office365-filtering-correlation-id: 24c32a9d-3925-4ef2-0213-08dcd9333f13
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4719.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?KzZmTmF0U1hkNjlLeHZmaER4TkQrT2wrK0pMekwzdFI4M2NxNVRnMFh3VmVx?=
 =?utf-8?B?MElaN3Y1c2Z1cUNEY1lUS21wa1pBOVM0V0laRmhCbENuUFEvR3BSSnY4bGly?=
 =?utf-8?B?cnd6bHk2ZjB1bSs4MW1wSmtzTTJSM3ZQNGFIVUhPUWladmNFV3kwQ1lvZXNs?=
 =?utf-8?B?ZThGVUVjdTlqTHNmNUJJVE5ncEsrSjlYNzlhMjhlMEg5VUUybEpnU0pOOUp6?=
 =?utf-8?B?eDlIZ21QNUpicXRxREpyWjNBclFtRnd0VW5VSXY0YThCbW1pQitDT3FOeTZy?=
 =?utf-8?B?MXAzN1Jja0lRYUlTSkVQOWNtY1lTWEF1dTV2QjJYWlpFT0V0YmE2T05mTnkv?=
 =?utf-8?B?TVZCYXZnNCs5bTZpdmY4MW5OYlRya0JzbTRlVERGWDJXcFlHK3ZjTzh5ZXpO?=
 =?utf-8?B?bkViTENBaExIZHpnNDhRODFwU0RTVUhBaFQ5MEIrREJ3TVFNYUQxYkRacUlK?=
 =?utf-8?B?U29vdzdDKzRKWlQvODRMK2h1U281RzZPNm1QUHprcHhBSVFHQ2hRTUZiYkVZ?=
 =?utf-8?B?TURFalRKWXY2NXE1bE9wSVYzVUVvRDhkU0ZmZDNVSzBtWlNSVGhVS0draXNl?=
 =?utf-8?B?MmpWc3gxMnh6c0ZIUU93SUVkYjVHNDNUck5WZURnRXduMmRsVE5VS1FqbG9B?=
 =?utf-8?B?ajFYZ1FubWNKWGJNVlVnc3Y0aU9oRjJhd2FYSi9sanRBT1RlSHd3Zm1KbXB0?=
 =?utf-8?B?TERnRHNHTEk5Y1BscllwTW1Lai9taXJIMk5pTEJ3RjFJTVBCbnlSZnlQYUwz?=
 =?utf-8?B?Z01PSzZRZTZPZVRKL3VNd1RlUmdtQUxBTXFRSmRWRWpTSnZEYXVENm5KS0hm?=
 =?utf-8?B?UjZXNnllS0JFQjlKKzFXNGFBMjJpWnFLMHRiY0w3MzZtU2x6a2hiOEkvUzFG?=
 =?utf-8?B?aHBHMEViQnRRR2V1SVRzRmJQQWhoZWxwQTZDWUF5a3FUdmRDZXV6NFBDUjBL?=
 =?utf-8?B?V1hXUDhsVmdoT0pxNXZXNnZRNnk5QldIK3BIZFdJb09xRzkvVllhdDdwNURX?=
 =?utf-8?B?eE9LaUN4WkJLZnQ0N3N1d3BsczVsNlRGZ3hqWlBSdGM4cnBnaHJJaG9Qc1g0?=
 =?utf-8?B?a1pZaVl2czhUQ3BOSlFtY2pMQTlLR05XVTFOa3NyY25hb0lMeWVMQjg5eVkr?=
 =?utf-8?B?cVZIUGNrN2JhUnZQRWpqWmNNcFJzQlhUMm44SUNkVXBSakI1TkdMTWdtOHEy?=
 =?utf-8?B?Zm1HUXQ2ZE90YU5haklwUnNZTU1Db3FFblhJQ0hJV1UweUdER0V6WGlSR0E2?=
 =?utf-8?B?WmZyams4VkFtbXh2QkYxWUZPVU02V3h1cyt1NFV3MHoxQ3BWMDdqTVVXSGs0?=
 =?utf-8?B?bjl2M1lBOWVaSXljbCtWWWJQcnBjYmx4ck9Fb3padkkzejIxampzalIwbEJL?=
 =?utf-8?B?SlBWTkNQc2lDbjd4Y1NqTGtJZkZmZGErQnVnVnk4cEE2SVdyeXJ4TE9ud2Fk?=
 =?utf-8?B?NzJkeHI2WUpKMjhsSzhjS2ZTZVNUS0JPcVNDTkJ3OEFKZnpmR2ZtMlk2bmZ6?=
 =?utf-8?B?N0NxOWN2VEZXKzZXSWJ2ZTVaYVFzUU85KzdWVlFrY0ErQ2Q5T1hoUlNqTlJD?=
 =?utf-8?B?VVRYT0tTaVhaMTg0eDBNSlF2VndHeHhzdG1tSGhXWVNnL0hjVThFQkVjb1hB?=
 =?utf-8?B?a2dKUWtOeFRxTDNMMFJiNTBrb1BqUk83MlRCdmFEQnc5Q1dpcVBSNHJ4R1Mv?=
 =?utf-8?B?d2lzN3duL2ZTTXhNYTNtQ2J1ZEJaWmhmSEVQYTlhSFRmbFJjMXdpZUxGdzQw?=
 =?utf-8?B?d3pJNlI5SjJLeXRRT0NKVHluRWJ4b3ZDMlRxZXgxM28vUzh3cS9tTGlNK3ZX?=
 =?utf-8?B?WHVPSDBwMCt0Ymg0Y29pNVdNQW1BekZyMUQyUHVObmhKa0pxeDlTK2xWREc2?=
 =?utf-8?B?OVQ5MWlRKzFGZzd2YmthQW11dmprY0FIVTdmV1FCUVBVZlpacFVoMGpHcUhX?=
 =?utf-8?Q?lDetXFCteC4=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cGlvTC9FNGh5OWNlQkZtVGdHTXo4eU5LU1ZHR3hja3Jha2ZoVWJRYjlWbC9s?=
 =?utf-8?B?L2hCUUR0WkxOZ3E1MHVjRnM2RDQ2N2pHdVRIU21ZZnBia3BSdTdTNm4wWVJ6?=
 =?utf-8?B?RW05dFJvNVpBQzA2cjZCODRxL0NzS2lNK1BHNnljUkY5S3hqdkE3ZTJlMUE4?=
 =?utf-8?B?ODBVL05jUWRURUlTMGpDaUxzT0dzOUlxNkE2eXVBV3pMaDVOV1c3TEw1b3hH?=
 =?utf-8?B?R2U0bHVPV01TY2s2TXBOVVU5cktKNjFGc25VVEo0ZGdudU42c0VNUjVGaFhU?=
 =?utf-8?B?S0ZLTUs1LytJcXJISjJOZmgxeGMxbkNLTE5HVFJZc2ZBNXpKaUZIeW5EMm1Q?=
 =?utf-8?B?ODVSYVpYU1lNd25SUXFVNzg3NDFBMXZXSjhoQTVvcGhqNk1ta2JndlA5cVNI?=
 =?utf-8?B?OFNnQVU5bUFIWm9OUGJRSUVRRlk5KzBoQnFVK1BYd1ByL09UWlRId0I4NytX?=
 =?utf-8?B?S2VqRC9BLzhDRHM5Smh2L09lN3I5anlSa1N2ZmlwbmRwbkN2QXNjMVcyN0Za?=
 =?utf-8?B?ZFEvZmZuQzl6dTJPZWxFZ0hIUEVsS0h5MU9ML2FPV2ZicFg4Z1N5eFcvc0ZL?=
 =?utf-8?B?N3F5VjhnbzA1K3BzV2F2WkUxTC9uaEYwUTFYWkswYTIzZWdZajZYNDRsclQy?=
 =?utf-8?B?aHVnNjBsejZxZ0g1dVpLM1ZRVjNkOXM3VjhxaWo5OFBrZWVvaVRuR1NRakFu?=
 =?utf-8?B?SWlMYzhYa0hMQjhvUy9aM1hScllra1FqZmhidFBCVVVLM05HdllLOFlPUGJx?=
 =?utf-8?B?cGhVSFo2bHBVME5mdmh3L0E4WHVxOUtmR1cwdHlPbUF3eGZXendjbGxoVGVj?=
 =?utf-8?B?a3RCN2E5YWFyTDVGZmJOVThnOUFwMHJVYldXTmdoUGN2Q0h5N3B5aUV2aFVk?=
 =?utf-8?B?Z0htei9HYXRCY1FzQVhMeGlVNU1sOVJacStLMnVGMWY4aFYyaHhhdG5jY0RT?=
 =?utf-8?B?Sm5UZEpSdkxqeEU0VjdOTzAzMlJTdkhnbFo2WGtYS21YUnZoY0J1anVGRTVG?=
 =?utf-8?B?Tlk4b1FOVlJLMHd0U2VhdzZ3NzBEZG9MK0gwUlNBeWEzaUNDcUJxaUhxV0RO?=
 =?utf-8?B?dkNqWmg1NEpTcy9XTUNBYlRyeExwYzlQR0x3QVNuMHhoQU15anNmRTJKNE9F?=
 =?utf-8?B?bHRxajYwSnpKUE9ZQUl0R3l0dVMrbHdZOHN1Unh2bkZwMCtsTy9ROHpsVy9k?=
 =?utf-8?B?OWZ2UTJyMytIQnppU0prQk1NYnN2Mm5DeThXTFdkZXVRNVQ4cHFEVE5td2xv?=
 =?utf-8?B?WWtYenZYZThEb21qNGVlSHA3WkwzVGZYWklwVGt4YlFYZWdQMU9ibVBEMkM2?=
 =?utf-8?B?ZEFyNEVSbC9NSUphcGZLTUswczJORnFnSGtoNXNlUmd1YlUwWloyeGpzM1Zn?=
 =?utf-8?B?Z3M3bGlnODg4ejl6Z3BGc3BaZjBpM1FlYlJJMDg3RHJ4VmVORU00aFZsVE81?=
 =?utf-8?B?WjhyZi9mZkpjY0F3ejAzQ04vTmI3VzVKNzVNSXZBamRDRkVpVkxMbktEN1Rx?=
 =?utf-8?B?MUNMdHFkUzRNL08zYk94N2ZLckdiN0I5S1ZWdzI2cis5Z1hwWGdXWWp6c0F4?=
 =?utf-8?B?cmtCUmVDZ2ZmbmVHbDZLNW02SC9jaVM4THdOV2lCcVhPZExrQU9OM21KeE1R?=
 =?utf-8?B?amhQengrY0R6K2RmR21JTWNkTjR1SW9waDJxYjI3SUwyWFlzSG0zSllKazlX?=
 =?utf-8?B?UFo0ODZPak1vMmVNQkRoekZXbjhXVDRJR2ZyemEvL3RtS2ZSSzZjZURxMUY0?=
 =?utf-8?B?UjdXYkVzU1hJMzRIc0RBeFJXRkJ0NVIxOWJGc3RISXo1OGEwUCs3eTdUR2lq?=
 =?utf-8?B?YWovY3JkNDZZMnV1Wk13SnRQaVRJaVZDdWZySGFWSld6TjZyMUhoUHdPbVJC?=
 =?utf-8?B?Qlhiby9Qd2VlR2I3SkVkMG5xbC9HQ054QUYxbWZWRS8rRldxTmo4Rk1FeGxM?=
 =?utf-8?B?eCtiUlk5VVFzSXk5SWVTV2NnOGdYTEhrK0p5YjRGb1FlTURYQWNkQ0FpNGlR?=
 =?utf-8?B?KzBZdTJyQkI5TWRySEZvYXVpNHlYZXB2RkI4UTRJaGZvSkthcEZpN0RRdGRv?=
 =?utf-8?B?ZGUxcHFyMkFvcjlVVjFhRlRjMkxFV2g0L0lhWGtqMGt6RUNVUFJwaHNBbi82?=
 =?utf-8?B?Zlh0S3lZMEp0ek5NRHlFY2l4Z1V2eVhPa3hqSGVTRjVZRkY0MXNIbHRaaDhj?=
 =?utf-8?B?M3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1ACE03681DFB3349ABD09F6F67F112DE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4719.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24c32a9d-3925-4ef2-0213-08dcd9333f13
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2024 05:15:30.3940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /qFgnJECT7kfw3lZwje0PgsKUA9xhK6ZqazMe1Na/oVF2JiBwGCPkztj65CzEc10GpLQ2bh3qFJNcChRoNE+qRsBB2DG5ioTXW7uYvhXcy8KW6cBFJn4K7mgG6uQJ3Tu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6937

SGkgYWxsLA0KDQpJIHdvdWxkIGxpa2UgdG8gZXhwcmVzcyBteSBzaW5jZXJlIGdyYXRpdHVkZSBm
b3IgdGhlIHRpbWUgYW5kIGVmZm9ydCB5b3UgDQpvZmZlcmVkIHRvIHJldmlldyB0aGlzIHNlcmll
cy4gVGhpcyBoYXMgbGVkIHRvIGFsbW9zdCAzOCBwYXRjaGVzIGdldHRpbmcgDQptZXJnZWQgYW5k
IGludGVncmF0ZWQgaW4gbGludXgtbmV4dC4gVGhhbmtzICENCg0KQ291bGQgdGhlIHJlc3Qgb2Yg
dGhlIHNlcmllcyBiZSBtZXJnZWQgPyBzaW5jZSB0aGlzIDd0aCB2ZXJzaW9uIGhhcyBub3QgDQpy
ZWNlaXZlZCBhbnkgcmV2aWV3IGNvbW1lbnRzIHRoYXQgbmVlZHMgdG8gYmUgcmVzb2x2ZWQuIFRo
YW5rcyBhZ2Fpbi4NCg0KT24gMDMvMDkvMjQgMTI6MDkgcG0sIFZhcnNoaW5pIFJhamVuZHJhbiB3
cm90ZToNCj4gVGhpcyBwYXRjaCBzZXJpZXMgYWRkcyBzdXBwb3J0IGZvciB0aGUgbmV3IFNvQyBm
YW1pbHkgLSBzYW05eDcuDQo+ICAgLSBUaGUgZGV2aWNlIHRyZWUsIGNvbmZpZ3MgYW5kIGRyaXZl
cnMgYXJlIGFkZGVkDQo+ICAgLSBDbG9jayBkcml2ZXIgZm9yIHNhbTl4NyBpcyBhZGRlZA0KPiAg
IC0gU3VwcG9ydCBmb3IgYmFzaWMgcGVyaXBoZXJhbHMgaXMgYWRkZWQNCj4gICAtIFRhcmdldCBi
b2FyZCBTQU05WDc1IEN1cmlvc2l0eSBpcyBhZGRlZA0KPiANCj4gICBDaGFuZ2VzIGluIHY3Og0K
PiAgIC0tLS0tLS0tLS0tLS0tDQo+IA0KPiAgIC0gQWRkcmVzc2VkIGFsbCB0aGUgcmV2aWV3IGNv
bW1lbnRzIGluIHRoZSBwYXRjaGVzDQo+ICAgLSBEcm9wcGVkIHBhdGNoZXMgdGhhdCBhcmUgYXBw
bGllZCBmcm9tIHRoZSBzZXJpZXMNCj4gICAtIFJlbW92ZWQgc2ZyIG5vZGUgZnJvbSB0aGUgRFQg
dG8gYWRkIGl0IGxhdGVyIGFmdGVyIGNyZWF0aW5nIHRoZSByaWdodA0KPiAgICAgRFQgZG9jdW1l
bnRhdGlvbiBmb3IgbWljcm9jaGlwIHNmciBJUHMuDQo+ICAgLSBBbGwgdGhlIHNwZWNpZmljIGNo
YW5nZXMgYXJlIGNhcHR1cmVkIGluIHRoZSBjb3JyZXNwb25kaW5nIHBhdGNoZXMNCj4gDQo+ICAg
Q2hhbmdlcyBpbiB2NjoNCj4gICAtLS0tLS0tLS0tLS0tLQ0KPiANCj4gICAtIEFkZHJlc3NlZCBh
bGwgdGhlIHJldmlldyBjb21tZW50cyBpbiB0aGUgcGF0Y2hlcw0KPiAgIC0gUGlja2VkIHVwIGFs
bCBBY2tlZC1ieSBhbmQgUmV2aWV3ZWQtYnkgdGFncw0KPiAgIC0gUmV2ZXJ0ZWQgdGhlIElSUSBw
YXRjaCB0byB0aGF0IG9mIHZlcnNpb24gMyBvZiB0aGUgc2FtZSBzZXJpZXMNCj4gICAtIEFsbCB0
aGUgc3BlY2lmaWMgY2hhbmdlcyBhcmUgY2FwdHVyZWQgaW4gdGhlIGNvcnJlc3BvbmRpbmcgcGF0
Y2hlcw0KPiANCj4gICBDaGFuZ2VzIGluIHY1Og0KPiAgIC0tLS0tLS0tLS0tLS0tDQo+IA0KPiAg
IC0gQWRkcmVzc2VkIGFsbCB0aGUgcmV2aWV3IGNvbW1lbnRzIGluIHRoZSBwYXRjaGVzDQo+ICAg
LSBQaWNrZWQgdXAgYWxsIEFja2VkLWJ5IGFuZCBSZXZpZXdlZC1ieSB0YWdzDQo+ICAgLSBEcm9w
cGVkIGFwcGxpZWQgcGF0Y2hlcyBmcm9tIHRoZSBzZXJpZXMNCj4gICAtIEFkZHJlc3NlZCB0aGUg
QUJJIGJyZWFrYWdlIHJlcG9ydGVkIGluIHRoZSBJUlEgcGF0Y2gNCj4gICAtIEFsbCB0aGUgc3Bl
Y2lmaWMgY2hhbmdlcyBhcmUgY2FwdHVyZWQgaW4gdGhlIGNvcnJlc3BvbmRpbmcgcGF0Y2hlcw0K
PiANCj4gICBDaGFuZ2VzIGluIHY0Og0KPiAgIC0tLS0tLS0tLS0tLS0tDQo+IA0KPiAgIC0gQWRk
cmVzc2VkIGFsbCB0aGUgcmV2aWV3IGNvbW1lbnRzIGluIHRoZSBwYXRjaGVzDQo+ICAgLSBQaWNr
ZWQgdXAgYWxsIEFja2VkLWJ5IGFuZCBSZXZpZXdlZC1ieSB0YWdzDQo+ICAgLSBEcm9wcGVkIGFw
cGxpZWQgcGF0Y2hlcyBmcm9tIHRoZSBzZXJpZXMNCj4gICAtIEFkZGVkIHB3bSBub2RlIGFuZCBy
ZWxhdGVkIGR0IGJpbmRpbmcgZG9jdW1lbnRhdGlvbg0KPiAgIC0gQWRkZWQgc3VwcG9ydCBmb3Ig
ZXhwb3J0aW5nIHNvbWUgY2xvY2tzIHRvIERUDQo+ICAgLSBEcm9wcGVkIFVTQiByZWxhdGVkIHBh
dGNoZXMgYW5kIGNoYW5nZXMuIFNlZSBOT1RFLg0KPiAgIC0gQWxsIHRoZSBzcGVjaWZpYyBjaGFu
Z2VzIGFyZSBjYXB0dXJlZCBpbiB0aGUgY29ycmVzcG9uZGluZyBwYXRjaGVzDQo+IA0KPiAgIE5P
VEU6IE93aW5nIHRvIHRoZSBkaXNjdXNzaW9uIGhlcmUNCj4gICBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9saW51eC1kZXZpY2V0cmVlL0NBTF9Kc3FKOVByWDZmai1FYmZmZUpjZTA5TVhzPUI3dCtL
U19rT2lueGFSeDM4PVd4QUBtYWlsLmdtYWlsLmNvbS8NCj4gICB0aGUgVVNCIHJlbGF0ZWQgY2hh
bmdlcyBhcmUgZHJvcHBlZCBmcm9tIHRoaXMgc2VyaWVzIGluIG9yZGVyIHRvIGVuYWJsZQ0KPiAg
IHVzIHRvIHdvcmsgb24gdGhlIG1lbnRpb25lZCBpc3N1ZXMgYmVmb3JlIGFkZGluZyBuZXcgY29t
cGF0aWJsZXMgYXMNCj4gICBzYWlkLiBUaGUgaXNzdWVzL3dhcm5pbmdzIHdpbGwgYmUgYWRkcmVz
c2VkIGluIHN1YnNlcXVlbnQgcGF0Y2hlcy4NCj4gICBBZnRlciB3aGljaCB0aGUgVVNCIHJlbGF0
ZWQgc3VwcG9ydCBmb3Igc2FtOXg3IFNvQ3Mgd2lsbCBiZSBhZGRlZC4gSG9wZQ0KPiAgIHRoaXMg
d29ya3Mgb3V0IGZpbmUuDQo+IA0KPiAgIENoYW5nZXMgaW4gdjM6DQo+ICAgLS0tLS0tLS0tLS0t
LS0NCj4gDQo+ICAgLSBGaXhlZCB0aGUgRFQgZG9jdW1lbnRhdGlvbiBlcnJvcnMgcG9pbnRlZCBv
dXQgaW4gdjIuDQo+ICAgLSBEcm9wcGVkIEFja2VkLWJ5IHRhZyBpbiB0Y2IgRFQgZG9jIHBhdGNo
IGFzIGl0IGhhZCB0byBiZSBhZGFwdGVkDQo+ICAgICBhY2NvcmRpbmcgdG8gc2FtOXg3IGNvcnJl
Y3RseS4NCj4gICAtIFBpY2tlZCBieSB0aGUgcHJldmlvdXNseSBtaXNzZWQgdGFncy4NCj4gICAt
IERyb3BwZWQgdGhpcyBwYXRjaCAiZHQtYmluZGluZ3M6IHVzYjogZ2VuZXJpYy1laGNpOiBEb2N1
bWVudCBjbG9jay1uYW1lcw0KPiAgICAgcHJvcGVydHkiIGFzIHRoZSB3YXJuaW5nIHdhcyBub3Qg
Zm91bmQgd2hpbGUgdmFsaWRhdGluZyBEVC1zY2hlbWEgZm9yDQo+ICAgICBhdDkxLXNhbTl4NzVf
Y3VyaW9zaXR5LmR0Yi4NCj4gICAtIERyb3BwZWQgcmVkdW5kYW50IHdvcmRzIGluIHRoZSBjb21t
aXQgbWVzc2FnZS4NCj4gICAtIEZpeGVkIHRoZSBDSEVDS19EVEJTIHdhcm5pbmdzIHZhbGlkYXRl
ZCBhZ2FpbnN0DQo+ICAgICBhdDkxLXNhbTl4NzVfY3VyaW9zaXR5LmR0Yi4NCj4gICAtIFJlbmFt
ZWQgZHQgbm9kZXMgYWNjb3JkaW5nIHRvIG5hbWluZyBjb252ZW50aW9uLg0KPiAgIC0gRHJvcHBl
ZCB1bndhbnRlZCBzdGF0dXMgcHJvcGVydHkgaW4gZHRzLg0KPiAgIC0gUmVtb3ZlZCBub2RlcyB0
aGF0IGFyZSBub3QgaW4gdXNlIGZyb20gdGhlIGJvYXJkIGR0cy4NCj4gICAtIFJlbW92ZWQgc3Bp
IERUIGRvYyBwYXRjaCBmcm9tIHRoZSBzZXJpZXMgYXMgaXQgd2FzIGFscmVhZHkgYXBwbGllZA0K
PiAgICAgYW5kIGEgZml4IHBhdGNoIHdhcyBhcHBsaWVkIHN1YnNlcXVlbnRseS4gQWRkZWQgYSBw
YXRjaCB0byByZW1vdmUgdGhlDQo+ICAgICBjb21wYXRpYmxlIHRvIGFkYXB0IHNhbTl4Ny4NCj4g
ICAtIEFkZGVkIHNhbTl4NyBjb21wYXRpYmxlcyBpbiB1c2IgZHQgZG9jdW1lbnRhdGlvbi4NCj4g
DQo+IA0KPiAgIENoYW5nZXMgaW4gdjI6DQo+ICAgLS0tLS0tLS0tLS0tLS0NCj4gDQo+ICAgLSBB
ZGRlZCBzYW05eDcgc3BlY2lmaWMgY29tcGF0aWJsZXMgaW4gRFQgd2l0aCBmYWxsYmFja3MNCj4g
ICAtIERvY3VtZW50ZWQgYWxsIHRoZSBuZXdseSBhZGRlZCBEVCBjb21wYXRpYmxlIHN0cmluZ3MN
Cj4gICAtIEFkZGVkIGRldmljZSB0cmVlIGZvciB0aGUgdGFyZ2V0IGJvYXJkIHNhbTl4NzUgY3Vy
aW9zaXR5IGFuZA0KPiAgICAgZG9jdW1lbnRlZCB0aGUgc2FtZSBpbiB0aGUgRFQgYmluZGluZ3Mg
ZG9jdW1lbnRhdGlvbg0KPiAgIC0gUmVtb3ZlZCB0aGUgZHQgbm9kZXMgdGhhdCBhcmUgbm90IHN1
cHBvcnRlZCBhdCB0aGUgbW9tZW50DQo+ICAgLSBSZW1vdmVkIHRoZSBjb25maWdzIGFkZGVkIGJ5
IHByZXZpb3VzIHZlcnNpb24gdGhhdCBhcmUgbm90IHN1cHBvcnRlZA0KPiAgICAgYXQgdGhlIG1v
bWVudA0KPiAgIC0gRml4ZWQgYWxsIHRoZSBjb3JyZWN0aW9ucyBpbiB0aGUgY29tbWl0IG1lc3Nh
Z2UNCj4gICAtIENoYW5nZWQgYWxsIHRoZSBpbnN0YW5jZXMgb2YgY29weXJpZ2h0IHllYXIgdG8g
MjAyMw0KPiAgIC0gQWRkZWQgc2FtOXg3IGZsYWcgaW4gUElUNjRCIGNvbmZpZ3VyYXRpb24NCj4g
ICAtIE1vdmVkIG1hY3JvIGRlZmluaXRpb25zIHRvIGhlYWRlciBmaWxlDQo+ICAgLSBBZGRlZCBh
bm90aGVyIGRpdmlkZXIgaW4gbWNrIGNoYXJhY3RlcmlzdGljcyBpbiB0aGUgcG1jIGRyaXZlcg0K
PiAgIC0gRml4ZWQgdGhlIG1lbW9yeSBsZWFrIGluIHRoZSBwbWMgZHJpdmVyDQo+ICAgLSBEcm9w
cGVkIHBhdGNoZXMgdGhhdCBhcmUgbm8gbG9uZ2VyIG5lZWRlZA0KPiAgIC0gUGlja2VkIHVwIEFj
a2VkLWJ5IGFuZCBSZXZpZXdlZC1ieSB0YWdzDQo+IA0KPiBIYXJpIFByYXNhdGggKDEpOg0KPiAg
ICBpcnFjaGlwL2F0bWVsLWFpYzU6IEFkZCBzdXBwb3J0IGZvciBzYW05eDcgYWljDQo+IA0KPiBW
YXJzaGluaSBSYWplbmRyYW4gKDExKToNCj4gICAgZHQtYmluZGluZ3M6IGF0bWVsLXNzYzogYWRk
IG1pY3JvY2hpcCxzYW05eDctc3NjDQo+ICAgIGR0LWJpbmRpbmdzOiBtaWNyb2NoaXA6IGF0bWVs
LGF0OTFybTkyMDAtdGNiOiBhZGQgc2FtOXg3IGNvbXBhdGlibGUNCj4gICAgZHQtYmluZGluZ3M6
IGludGVycnVwdC1jb250cm9sbGVyOiBBZGQgc3VwcG9ydCBmb3Igc2FtOXg3IGFpYw0KPiAgICBw
b3dlcjogcmVzZXQ6IGF0OTEtcG93ZXJvZmY6IGxvb2t1cCBmb3IgcHJvcGVyIHBtYyBkdCBub2Rl
IGZvciBzYW05eDcNCj4gICAgcG93ZXI6IHJlc2V0OiBhdDkxLXJlc2V0OiBhZGQgcmVzZXQgc3Vw
cG9ydCBmb3Igc2FtOXg3IFNvQw0KPiAgICBwb3dlcjogcmVzZXQ6IGF0OTEtcmVzZXQ6IGFkZCBz
ZGh3YyBzdXBwb3J0IGZvciBzYW05eDcgU29DDQo+ICAgIGR0LWJpbmRpbmdzOiByZXNldDogYXRt
ZWwsYXQ5MXNhbTkyNjAtcmVzZXQ6IGFkZCBzYW05eDcNCj4gICAgZHQtYmluZGluZ3M6IHBvd2Vy
OiByZXNldDogYXRtZWwsc2FtYTVkMi1zaGR3YzogYWRkIHNhbTl4Nw0KPiAgICBBUk06IGR0czog
YXQ5MTogc2FtOXg3OiBhZGQgZGV2aWNlIHRyZWUgZm9yIFNvQw0KPiAgICBkdC1iaW5kaW5nczog
YXJtOiBhZGQgc2FtOXg3NSBjdXJpb3NpdHkgYm9hcmQNCj4gICAgQVJNOiBkdHM6IG1pY3JvY2hp
cDogc2FtOXg3NV9jdXJpb3NpdHk6IGFkZCBzYW05eDc1IGN1cmlvc2l0eSBib2FyZA0KPiANCj4g
ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vYXRtZWwtYXQ5MS55YW1sICAgfCAgICA2ICsN
Cj4gICAuLi4vaW50ZXJydXB0LWNvbnRyb2xsZXIvYXRtZWwsYWljLnlhbWwgICAgICAgfCAgICAx
ICsNCj4gICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9taXNjL2F0bWVsLXNzYy50eHQgICAgfCAg
ICAxICsNCj4gICAuLi4vcG93ZXIvcmVzZXQvYXRtZWwsc2FtYTVkMi1zaGR3Yy55YW1sICAgICAg
fCAgICAzICsNCj4gICAuLi4vcmVzZXQvYXRtZWwsYXQ5MXNhbTkyNjAtcmVzZXQueWFtbCAgICAg
ICAgfCAgICA0ICsNCj4gICAuLi4vc29jL21pY3JvY2hpcC9hdG1lbCxhdDkxcm05MjAwLXRjYi55
YW1sICAgfCAgIDIwICstDQo+ICAgYXJjaC9hcm0vYm9vdC9kdHMvbWljcm9jaGlwL01ha2VmaWxl
ICAgICAgICAgIHwgICAgMyArDQo+ICAgLi4uL2R0cy9taWNyb2NoaXAvYXQ5MS1zYW05eDc1X2N1
cmlvc2l0eS5kdHMgIHwgIDMyNCArKysrKw0KPiAgIGFyY2gvYXJtL2Jvb3QvZHRzL21pY3JvY2hp
cC9zYW05eDcuZHRzaSAgICAgICB8IDEyMjAgKysrKysrKysrKysrKysrKysNCj4gICBkcml2ZXJz
L2lycWNoaXAvaXJxLWF0bWVsLWFpYzUuYyAgICAgICAgICAgICAgfCAgICA5ICsNCj4gICBkcml2
ZXJzL3Bvd2VyL3Jlc2V0L0tjb25maWcgICAgICAgICAgICAgICAgICAgfCAgICA0ICstDQo+ICAg
ZHJpdmVycy9wb3dlci9yZXNldC9hdDkxLXNhbWE1ZDJfc2hkd2MuYyAgICAgIHwgICAgMSArDQo+
ICAgMTIgZmlsZXMgY2hhbmdlZCwgMTU4NyBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0K
PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybS9ib290L2R0cy9taWNyb2NoaXAvYXQ5MS1z
YW05eDc1X2N1cmlvc2l0eS5kdHMNCj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm0vYm9v
dC9kdHMvbWljcm9jaGlwL3NhbTl4Ny5kdHNpDQo+IA0KDQotLSANClRoYW5rcyBhbmQgUmVnYXJk
cywNClZhcnNoaW5pIFJhamVuZHJhbi4NCg0K

