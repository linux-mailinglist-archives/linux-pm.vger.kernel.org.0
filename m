Return-Path: <linux-pm+bounces-28034-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3553CACCB46
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 18:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF12A3A0812
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 16:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B5823E33A;
	Tue,  3 Jun 2025 16:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EYJPILtO"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CCE1EDA0B;
	Tue,  3 Jun 2025 16:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748968138; cv=fail; b=mQIHU9dCZJ5ffQCLSoviVkVZIFoptZo++OO4F2X9wMUo6YJGv9zgJXdgiz0fvOEQi2DTohBp7jYGh5OBilIp63Ge3hhoEusYkYvUQ1sc9Rb/I8rF08Sp49cWJWQ3aezOaquwO+p3Ez+dycGFJjaM7P5aKa/zh5oI5wWfPFRasUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748968138; c=relaxed/simple;
	bh=0UjCZtRtsPXAuwLxikiwgdKpD7B9tGVk5ZHHXFpeEXM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VyWgYs7DHxHVaL90j1gcrEcSzVLIMye7ZiY0WdEHHHSsoBrvcyES8p8xLUrHJKTER32aFFbYKavXjRiIvUWjvd8HoDqVQm8jgesv4jUQhcPwpAWcQP6ai6X8UIY9m3TjORZ6QBSy3IEv7bm4dpBH0EhJHkJBMOTXvPmxYYpdL+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EYJPILtO; arc=fail smtp.client-ip=40.107.92.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WXZEZubqJFA1n5TGTIDov78noIo+YiTg00PgKsfDY5tTLrC34NKZHPa3MnbtBkfAnSVsStgCIyhFdbcyjDZpyhUG9rnUfIwKxfSbSehhxGusCnPsOSFZ+lGJ9wMDK3ZRxmtIAfpJAIEEVeUVPh8n2iPZ20637TkB0qbtp8076H2dWgbud0Tx1ZqLTjjkc4E/vu4SUGEJSIMRTlYhBkZcu1bHv/XzDfef6xs9y+2O2uu8ARpQ6Je8bWBir+i5Lw5FvR9cMzUizL8kwtCS2Insuk2hodKyeFjLUSwqoND/vwu/oK75KKdKizVvl5vioODfL57BF4qG8PMBo9ZbgUYqww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0UjCZtRtsPXAuwLxikiwgdKpD7B9tGVk5ZHHXFpeEXM=;
 b=RI5dceQpLCTR84CeTdy5a/lHux/OJfza0zwwTOH/ds1aSMNFZGxp8A2IKwCPQtU4m+SJ0kLbWbsL7Idyiw9mWLGatiWdUvvqSNJ2WGv6lO1ue1MAoOgs9yIckCw5FPBvEVAVaN9PDkWWxnZmol5+e9JFWLJq+5kVpybRF0Z5T08cyiiCRmjLBLr7sCRUCVDhUsOWDcBRWm2hnvnSMUaL7ACIc4lTelycZVkWzalZBf9157ku9Cs78gmseJndQcZk7A9XHy/BFPNNV0IMTUythGrOJ/OJ2wl2Pjy2CUt6EDmD6jkm2EbqRiGAh6x5l7iQJS/lAhETmH/7TjqaQtbmAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0UjCZtRtsPXAuwLxikiwgdKpD7B9tGVk5ZHHXFpeEXM=;
 b=EYJPILtOtjBmYeJiGQPLYeNo8YHUIDoyMBctO8vADe1ZUZKlGDjU31dGALKp2CqePMtF0scjhiM19FukflGvEuVjxhNpCvnzMOUkKI9cR0HhoizrQftgmPSiYoZZZcKXaQHkdQVyhhnfJ0LgTf/NJvqkKSGovDidm39cerTzEjQ=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CYYPR12MB8870.namprd12.prod.outlook.com (2603:10b6:930:bb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 16:28:53 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.8769.035; Tue, 3 Jun 2025
 16:28:53 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM
	<linux-pm@vger.kernel.org>
CC: LKML <linux-kernel@vger.kernel.org>, Chris Bainbridge
	<chris.bainbridge@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Saravana
 Kannan <saravanak@google.com>, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v1 0/3] PM: sleep: Fixes related to aborted suspend
 handling
Thread-Topic: [PATCH v1 0/3] PM: sleep: Fixes related to aborted suspend
 handling
Thread-Index: AQHb1KOu5RtGSVzK0EqRPF2fzZlcerPxn+iA
Date: Tue, 3 Jun 2025 16:28:53 +0000
Message-ID: <124f27b1-e7b0-4cba-a1d5-8e7805fc9809@amd.com>
References: <6166108.lOV4Wx5bFT@rjwysocki.net>
In-Reply-To: <6166108.lOV4Wx5bFT@rjwysocki.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|CYYPR12MB8870:EE_
x-ms-office365-filtering-correlation-id: c75215d8-6baa-4ea0-db14-08dda2bbbb20
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z3I3akw3MzYwYWc1UWR2K214b0VROWtYTGhqZmFORnFieFBhbmdOMTV6STBs?=
 =?utf-8?B?OVhGMCtGSkRqUW5kYUVQQ0RjaWoxaS9VZFlXN3oxNHpiMVQ5cnNmQXJKclIz?=
 =?utf-8?B?Q2JxWEJ6amxhYlNOeDF4M2RqWWVpU1JRUmZOTHI3NElzbG5aNzJRMHRqS040?=
 =?utf-8?B?N2JlVmtiZ0RvR0l5OGk2am9ybVBXWjk2WnZsZW5oUmhzZCthRGp6N21PT0VO?=
 =?utf-8?B?VlBBOUtzbzJrbUJQUWUzeVZqK1FuMUZCckVFSEQ1VEpSQWlwSUFpOTJvSFRs?=
 =?utf-8?B?VEcrbjRYYVhyMkY5Slc2ampZOXdTNlJxRFdTbnRvZTQ5VktydUhnMjdOeGRl?=
 =?utf-8?B?dDAwaENDbDB0ZzBJM3hFblFhWlJmTmxrOSt5N3lROHhIYnI4SE9VekZvYnpY?=
 =?utf-8?B?Q0RQK3F3TDV3RnY4Q3JHS1R6dGMrZlozU0MyT2hVRVZpdXZ1cEF1RDJkOXlF?=
 =?utf-8?B?QnpZdk54QTRrOWtXWG8wM0xMekdkNndjM1dCUkdhZ2VoSzZONE91UzB4WTFD?=
 =?utf-8?B?OERoY0pXVFRab0dldXJCR1ZobVVIQ0N0SEVJRW1qbVdPRTBXSUZkc2VuVEo3?=
 =?utf-8?B?NFVLMnFnTTROcnh1dTI2VkN2Tmh4dFdZMWw5NU1RN3RLd0hib0NGbjIxdGpY?=
 =?utf-8?B?blVhZTFIZHYvQm80TmhIeG5hVFUrc21oU0lXd3Q2UEZvM2xTcUxvYUp6T3Jt?=
 =?utf-8?B?M2RGM1hTWTNrbFVmRmFxckNXMWo0M21RSlNUV25idml4REZNQWxWVWUyc2Nn?=
 =?utf-8?B?SGlJZ2tKYk1HV3o0SmxmVVpoVndXSVhXcDJ0N25DeFZGRW15YzN3R24vVlIr?=
 =?utf-8?B?Qk5wQlNvRkE1dFFtREM1ZkwwSWp0N3JLQVgwU2pJV2tVVm9tQ01VT0Z6N3BK?=
 =?utf-8?B?UVBJMm9qbUN3ZnE3S2ZqVXptVGhGZTBzdzNocFdiWWRzQmk1enZZTFFyUTJa?=
 =?utf-8?B?Q015R01veExRM3lFV2xDemFRWW5LOGNMaXIxUWQwWXcxUXRDMnFYSUJMOHk0?=
 =?utf-8?B?VXR4cUxYUGxmV0pXWmRnZG4xaVJEY0pYMXBqYnJ3TFR1Q0pMUGhFZ0haTDFy?=
 =?utf-8?B?MVBDWVZ0dHpIQ2lVallqV1Vwc0hIOGEvRVoxUFZCaG5Jc2YxTHpZRjE1T3FJ?=
 =?utf-8?B?OGRmaTJlZmpXOUlpOElYZnlZaHRmd3F5NHE0R0IvWi93THkveTJKU3Jma1Zk?=
 =?utf-8?B?QW0xTmMwUG4zc1ZYL3VoaVJaTjBqN245eDdCL1VPYzRmVlA4OHMvUkg3b0NS?=
 =?utf-8?B?MnFSL0JHenkxcVB6NC9nUTQxT1p3ekNsWlVrWFZQbkFuMUY4UGpnUGFOLzhQ?=
 =?utf-8?B?TTlIaWNFSTgrZUVjaTdkdUgvTGxqVzZIUUhiT0g2WXZYalRmZ1ZrQ3UzcnpZ?=
 =?utf-8?B?Wm01ZGtEN2tUbWNXT1dUZTMvb281SUFUVmVITS9scC96TWJ2TXNTeFg1aGlp?=
 =?utf-8?B?KzZ1NlZCNHc4d21aNHF6cmxMZWEvSHZjU2djRGdKZkw1VGdTUXljdWJPejE4?=
 =?utf-8?B?WlNMNjQ3bnZCSkJ5ZkR1WWxHSW1VRForUHIyV0RZMEVkVVhuZzNMWXBXcXVv?=
 =?utf-8?B?czVyUFFYRWwzbnBLK1JvUW5uSVdkaER5a092bVpZbit4TThWNjh1b01ENlBl?=
 =?utf-8?B?RitpTTVqM2NOMExQeGpXMmtLZm5jTVJDYVpCdDZvcTJkdkI5N0J6Qy83ZVF5?=
 =?utf-8?B?ZHpucW8xYXJVVCtVcWF2VUs4cG9NYkJwaHNpU1VRd1JSMWV6b3pTM0x3aUdo?=
 =?utf-8?B?OVAwNEI2NWNOT2tQelNEb25FcmVNZDd1NEJsQ3pkazE2dW1iVUpieHgxMVNm?=
 =?utf-8?B?b1BiZzZiNVduMG9raEJKWURBeDN4a0ZQeFZsaG9ZY3VjNENyamJYZWdGeFRB?=
 =?utf-8?B?cnMwYWR3TmNTRzNIeXpiTXhkcmU3VnNXZjVScUM4Q3Naa05mZmFkN2RwSzc5?=
 =?utf-8?Q?5k/MPbyGpzE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U1ZlZWJZaFdoU1ptSjVGckJUWjFsdEpRbUNrclNlTjNhT2hLN3crVEZKWkxq?=
 =?utf-8?B?TU5aTnBDQ1RJRWIzMy84OUpzTVJGc1d0YlBtU1p0d3h2MzgwVmlzN0hkbEVp?=
 =?utf-8?B?OVhZQXNsLzZxd3BxZ3JSMjFJSzQzQzdPSzhvQ2pNY3VJalNTYlJqMm51UGM0?=
 =?utf-8?B?YmZ5eUM1SmtadFZ5U3dDenp6aVZ0RkJGTVhLL1BaQnoreW9idk5TbVlPOTZp?=
 =?utf-8?B?TU91YkJGRzZMLzVRaVR0UWVtSlltVDJSUjd3NnE1VDMwUi9qZUoxN3hNaE1z?=
 =?utf-8?B?OXZnRDd3VGFSazlBQVNmVGoySnNpSXQreThWOERKSmVENXJKZmhweG5KN0VO?=
 =?utf-8?B?eGFFYlV1TEo1N1pYN0YvY2dSc000UjhZaVg0UENhRmIwR1FOdnc3citST21y?=
 =?utf-8?B?QU0ydnozYjdjckY0T2xSdGVZbXFzOTU4c01CeThRZW4zNHJpa3dKS1o1R25j?=
 =?utf-8?B?cmxtZGR6UTJYVUdSZWxSTHBxR2l2TklyUGExUDVqSW5NM1RSZ250K3hONFM3?=
 =?utf-8?B?bllxL0wwZ0tpSllrYktCWW1TRDIxYlJRNXlWQ29NS01lMkZCNjBmaFI2QnJC?=
 =?utf-8?B?UERZZ0NjU3JnMXpoaDU1enVTYnFKbDJBbkxCK2Z5cldWRHZwZHBKS3dZT1Jo?=
 =?utf-8?B?Y25GUmljdUo2ejhQT0hDSE02RzhtRzgzT2Y0Rkp0MEZ4WDV4NXpxckxsN2l2?=
 =?utf-8?B?cEhlN1lkdFhrT0tZQ0ZHRmR2N2R0MDVTeGJXY3hSaTVsOXhjQWEyVzdpeHl1?=
 =?utf-8?B?TXEwbWwvQmx3d1kwWVUyaHlaeHFmL3VKblVwZmoyaFBYcHhBNVhRQ3lTbHNP?=
 =?utf-8?B?bU1EdVB5QThIcUFQQWdDSXlESXlvMENDYVdjV0w5OTZ6R1BHZDd5MGc5Z2NM?=
 =?utf-8?B?VmdzUHovSFVmblVnT1RZcDNZQ3pwN0pva0twQzFJTUxPV3c4T0MxL0Fic1Bo?=
 =?utf-8?B?UC9wMzA1Zmg5UDhsS3RldCtEc3J1ZGRUUjhoUVJhRmpobVZLRis2TGd5cWs0?=
 =?utf-8?B?ZGRaQmZVU2Vja2JyZ0Exd0ZnZWhjaFhxT1VRdnR3Q0FZa2g3YlJWeml5TWFa?=
 =?utf-8?B?NVhPeGcxZEJLbFZubkhyT3VpMmRpcjU0M1l5eEgySkt2ZzI0dzdqNDRDSlNq?=
 =?utf-8?B?RXNkaFRVOVFrbklDWEJYUDJ2WCtQbUg2L0czd1FCWC9GMm5pNllTbXYxVWUy?=
 =?utf-8?B?aXAvcWZxSHhKM1pmT29yY3BwVWJLa3Z3S1Fkd1g1ZjkrbHlDRVJBeWtFUlpa?=
 =?utf-8?B?RDF3ZXFkSHJOajlyenZ5VnRnK0VCWXlTSW0zY1lqdGhWQkZYK2lrT2xzS1Ju?=
 =?utf-8?B?M2hrcm9GbVpHeTZDb2lONlVmRHlPM1czV1NwWmE2QWFuNkJkK0xqcTRjZURo?=
 =?utf-8?B?WW5FNVgvY2pSclA1cWxDdWJURW13WFhuQWJFakFmandJMkhBVzZwLy9qN1Iz?=
 =?utf-8?B?eXh4NFF1eWxpbCtkMnZkV20raVNOQ1RJYXNjT0xyRjZ2d0dNVjVwQ21JdktH?=
 =?utf-8?B?Ri9TeVM1OXRPbS9NRDBJZTRwQ1MwbmI2VzBZKzdSVUEwbU1LeUluY0FQSkJz?=
 =?utf-8?B?a3dpQTlSUForK2diSDNLUUJ3TTZwUVpudEVUUm1JaVdrYkVGZEpxSVdnc1dp?=
 =?utf-8?B?bklxOSt5WnVpTlN2WGs3eGcxbnZkN1h3K01NQW1URy8wMWhOL1ZiZUxsS0ZO?=
 =?utf-8?B?cm9PYTVheHpHUjJvNC9HWlN2WW1vbzR0SVk5OFA5YmNHQWpJM2VTWTVZdnor?=
 =?utf-8?B?MXpYeDI3S0x1SmNSQVgrNnJMNzdSL1BsaDMwdGF2TVpEUmpkUGsvcTNFWWFN?=
 =?utf-8?B?WUp4alFVdGkwQ25zTUZDc2o3T0RNMDQwZzNjYU5CYktzbFU5cG55NHU5L2Rr?=
 =?utf-8?B?SWpQQzM4dUxpWEpBNEpXdDBmS3JmSU95SXVDMEFNUytickcvYjFvQmNEeE43?=
 =?utf-8?B?MmhTWmJHM2Z1R3pRb053Nmt0R0tBUXYxM3dYS3RLK3lmQmRJczdlUFZqL0Fj?=
 =?utf-8?B?MEgvNFV4eVhKTm1iNlRSQW9UNVdPVThPY3pyYnlhRnV4MTY0Q3g4TnAzTktz?=
 =?utf-8?B?Y1FVSkYvOGNkSHN4TmRoUFdZSGZlYmFuZWp4a0FzVGhmNDNpWWJsamVjQXBi?=
 =?utf-8?Q?AkF4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E85F798D1DBCDF44A1FF94C574FBD90C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c75215d8-6baa-4ea0-db14-08dda2bbbb20
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 16:28:53.8321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ixxkRofbdGHHRZnEG0BEbesTxnRuUIjLvUsQqZ1yIYqFxlWeWq4kCqZtU0Xr/xMc614Uuy8asvTHGMT7+Tq9Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8870

T24gNi8zLzI1IDExOjE2IEFNLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90ZToNCj4gSGkgRXZlcnlv
bmUsDQo+IA0KPiBSZWNlbnRseSBtZXJnZWQgdXBkYXRlcyBvZiB0aGUgUE0gY29yZSBoYXZlIGlu
dHJvZHVjZWQgdGhyZWUgaXNzdWVzIHRoYXQNCj4gbWFuaWZlc3QgdGhlbXNlbHZlcyB3aGVuIHN5
c3RlbSBzdXNwZW5kIGlzIGFib3J0ZWQgYW5kIHRoZSBwYXRjaGVzIGluIHRoaXMNCj4gc2VyaWVz
IGZpeCB0aGVtLg0KPiANCj4gUGxlYXNlIHJlZmVyIHRvIHRoZSBwYXRjaCBjaGFuZ2Vsb2dzIGZv
ciBkZXRhaWxzLg0KPiANCj4gTWFueSB0aGFua3MgdG8gQ2hyaXMgQmFpbmJyaWRnZSBmb3IgcmVw
b3J0aW5nIHRoZSBpc3N1ZXMgYW5kIHRlc3RpbmcgdGhlDQo+IGZpeGVzLg0KPiANCj4gVGhhbmtz
IQ0KPiANCj4gDQo+IA0KDQpJIGZvdW5kIG9uZSB0eXBvIGluIGEgY29tbWl0IG1lc3NhZ2UgaW4g
dGhlIHNlcmllcywgYnV0IG90aGVyd2lzZSBpdCANCmxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5
OiBNYXJpbyBMaW1vbmNpZWxsbyA8bWFyaW8ubGltb25jaWVsbG9AYW1kLmNvbT4NCg0KSGVyZSdz
IGEgdGFnIHRvIGluY2x1ZGUgZm9yIGNsb3NpbmcgdGhlIGlzc3VlIHRoYXQgdGhpcyBzdGFydGVk
IGF0IGFzIHdlbGwuDQoNCkNsb3NlczogaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL2Ry
bS9hbWQvLS9pc3N1ZXMvNDI4MA0K

