Return-Path: <linux-pm+bounces-42243-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACRrAmCEhmmIOQQAu9opvQ
	(envelope-from <linux-pm+bounces-42243-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 07 Feb 2026 01:16:32 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F2010441C
	for <lists+linux-pm@lfdr.de>; Sat, 07 Feb 2026 01:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CCDAC30066B8
	for <lists+linux-pm@lfdr.de>; Sat,  7 Feb 2026 00:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A6F1946C8;
	Sat,  7 Feb 2026 00:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gnrhfctF"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010067.outbound.protection.outlook.com [52.101.69.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313FB15B998;
	Sat,  7 Feb 2026 00:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770423387; cv=fail; b=Xww1q1NFKuiBh2faB3dgSg5KJUkZPzR/YPW2H5BfoHNpagUFGzmOAOQjASALxh82z4sy9AczlKHPOE5byijIexfZN5tOx/YRcBUCjbaWRGUNGAkWR6UueRSINB6d7BL4zANi5ab9/y4ufxP1gg/eYJKdZZv7p+92CuBXFHORHdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770423387; c=relaxed/simple;
	bh=FM/kbZqsPG0ypSAL0b0Kg6Wzo1UxNTs4EqG0pn/O7ac=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sJk9XoVZqr4mDPDWfsgsGtiMOFeloiUfBA5IXK55eP6NcDOorHTLXkChent3jGQTRhSCZ3bRgQtFrtsgnrTjaugKeMJjhFecWveyvf+PQ91FTTzkqAwzII67H/CxAbintkwS1O8adJvNsTQVh1JZWoW17XwgaDeH2ovG1AsPPIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gnrhfctF; arc=fail smtp.client-ip=52.101.69.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eJnohF+ymVDm4yEbfijGOI5YnUhHo1bAUwkMheTMN7L53sQMHWfC9LOAGTLTVzIGEuSXOPFR2e63H76bW85+42AvdVytJeSu0/Ww19yRNtrDOXDWQ0CI4ri15EO/xRD944QG087RLyeyzdysgGAlCZvuRz73IT0L/XEVZ87tNxPRq/T3z2vT7EgMcsnho79Yq3+t3dQzyPT6T4yaAzJjCVk6STe3yiIdjdAERfDYkWbsQmHM+ufFZ3ANJ+b8QncHXxLw3dWWqpAs83GsTX3/wdr/ivFOFTSGY2A3b05DzqngBleL9FPv1rP/JtX9y1nycB2M3s/2AeuQUVrpk0D/PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FM/kbZqsPG0ypSAL0b0Kg6Wzo1UxNTs4EqG0pn/O7ac=;
 b=Npbp2a6tMe6tOrJSeKf0O9NDfgXH//l5VZTmxzAPfYUJrIJRP8m0++An+nuXByXhotKPqQF9SL6UqClj35st7mKQYTG2hO1zhJwlCcgn+5hK+12bNqUptFyGQiY50cfrnnSIXxKaI0qRE1lR93ZNnikVGIr9jJRE12EzIxlK8Ua/YYiAeIt8lOywsMl+6Hdy8baq+df5h4iK7s4SgikrcFEL+tz5LT/l3sAaIlOBm9aXqzNUcOkRBqkiMDJ3cwYAZzQpmdks2j77smjynTFevhQCPAzXsNEOsJ1xKZoeTk5NWD+2R8q/Wf5EcOVWVZu4S0ypFlici1qCmE4B9wL1lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FM/kbZqsPG0ypSAL0b0Kg6Wzo1UxNTs4EqG0pn/O7ac=;
 b=gnrhfctFbsVtlwBZpOy7uNfKEr4J8RGHjo7hzHLuCRObrCE8oJ9XXxVX0UvZ9bPLmZmjsJUIpJjztIHiM2aVo7O1pFxdk7uBnzkRmOyPXhMqVOLtjNDV4wxS42s9vzqSiNmQzuln4djM6+usi8PjjcCJRD4yTQvSD2yBeG96e2Fs13yj8YPd9g4Y+hLcAFwfsZG+MSqJsp3hw7IxYFdchTZnWmSCxZ5m+VJTfoKPPC2xOovZ25fDzqckSoUPBPWgFToliYhAD4drk8O3/VkZKFnNvc7vluEg6qmvTbFE7aXjvFgRTBqusGAPKLJZy/011x7sYyhbgxV6EhLqpmIzkA==
Received: from VE1PR04MB7213.eurprd04.prod.outlook.com (2603:10a6:800:1b3::8)
 by PA2PR04MB10088.eurprd04.prod.outlook.com (2603:10a6:102:40e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Sat, 7 Feb
 2026 00:16:24 +0000
Received: from VE1PR04MB7213.eurprd04.prod.outlook.com
 ([fe80::3e5c:ea79:66ab:c67b]) by VE1PR04MB7213.eurprd04.prod.outlook.com
 ([fe80::3e5c:ea79:66ab:c67b%2]) with mapi id 15.20.9587.013; Sat, 7 Feb 2026
 00:16:24 +0000
From: Jacky Bai <ping.bai@nxp.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich
	<dakr@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"driver-core@lists.linux.dev" <driver-core@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH] PM: sleep: core: Fix race condition in async noirq
 suspend
Thread-Topic: [PATCH] PM: sleep: core: Fix race condition in async noirq
 suspend
Thread-Index: AQHcl3nHoGhvDVmtGEO1G6MsWkkzzbV2EgEAgABKrcA=
Date: Sat, 7 Feb 2026 00:16:24 +0000
Message-ID:
 <VE1PR04MB721393217EA1792A7B8AE7DA8767A@VE1PR04MB7213.eurprd04.prod.outlook.com>
References: <20260206-noirq_async_suspend-v1-1-d10f2418df4c@nxp.com>
 <CAJZ5v0i7zuAmvWGPjGKkMKV=qmpc6dJOQXRUVUoqtzd1bdeEdw@mail.gmail.com>
In-Reply-To:
 <CAJZ5v0i7zuAmvWGPjGKkMKV=qmpc6dJOQXRUVUoqtzd1bdeEdw@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VE1PR04MB7213:EE_|PA2PR04MB10088:EE_
x-ms-office365-filtering-correlation-id: 34f87eb7-2185-45e3-a982-08de65de20d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|19092799006|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?N3hKdmdYMkR5QyswWkNLdlhJWkRsMVZzeWhCVEJuMGhWTERTMmhmZTk0K240?=
 =?utf-8?B?VUN4YUxHbVIydEVFOHowS0xjM0M0NTIrN1d1QXNXbTBpSzBmTzMxRkRyY1BJ?=
 =?utf-8?B?MHNyU3NFejFJV0ZsYnJUeE5WMzZZUHRndkFNbVhHWTFxS0l6RDBwR1E3aE1z?=
 =?utf-8?B?K2syZUpkRCs1ZjVZWHdKSGpieUJndkpNRFJhK3VyTnIxMmRYOEQzWk1xUjBu?=
 =?utf-8?B?RzBYUm40SU5MYXBoMG81a2ltcU43cUJOS1p5VmJhUUpEdXhQY0FPQXBGc3o5?=
 =?utf-8?B?VGI0MmV6MGNBd3FjeGkyeE9oZWdkSGNHTkg3T0pkUlk3Y3pYZWdOVW0vSHNB?=
 =?utf-8?B?OU5BL2dNdTA2dDZuM1RLMVlSdjY3QTNhZTRhZWMrdlhKbEdPVVdHT2g5a2pP?=
 =?utf-8?B?ek5iK1JUbVpVekp5a0JpTzllc2YydkpNZjJvLzBLUUZ1MkxMOS9VU2ErMEpX?=
 =?utf-8?B?c3JZUDhZS05rRXhHdTlNTTZXaFRidGcxb1NtNjZPRUx4czZPZmJXZDF1bGNj?=
 =?utf-8?B?QWJ3bTh3RW4wUjhuSDZxN0FJQTJHb0dZTFRVOVVjZDY2QmpLeTB6L3dJN2dC?=
 =?utf-8?B?MVF4dHJVNTJ5blF5NlJsMjJyTnYzR3Jnb01WeVRZczhwV241WVh4QnJnbHVw?=
 =?utf-8?B?eDZxYytwV1RBOU44OGpZVk05YVlNb3ExM09weUlNTERFYjVCaytZaFVwSWdD?=
 =?utf-8?B?cWE5K0V3UFpzR3RRWGFrSzJ6TmFQQTVBeGNxWHFOSTJ2bEhtRWc3MEtBRUJk?=
 =?utf-8?B?SGtyVTBjR280dWN2UWJlanlPTUtnNTZBcUhVdVgxU09pYWs2RjdnakMrUWNW?=
 =?utf-8?B?UGZTNENzMS9IYlJGcjNYdlNIVVJFUWd5RGdETXpnUEJyVUVKRUpRZjRrWUk4?=
 =?utf-8?B?blZoTDFIN3V4UTFTODUxalFyWmdIQlhqMjFMQ0I2S08xbUxlTmFBTmp6ZUlU?=
 =?utf-8?B?MDBLNHYxdTJ1YkhvWm90ZEpjeGJSYWdBdDFPRFpIbkUvck5Oc2FSbTBkTHlD?=
 =?utf-8?B?RHVib216VHBFNmZhalhVRVhPTVhqdlZSTE9mS2U2K2MvVWxrM3RqbnBEa3Bz?=
 =?utf-8?B?VnBKZkNsTm14NU5uUjc1aHBzbjJiMHNjRUFnRVhtSGZSY0dZRldyQ1Q1bFNn?=
 =?utf-8?B?M1hQenhIaTRUeUlWbDhJM0dwUnF2RFNXZTRlanVVL0hZZFU1NTI0RHNpc1gy?=
 =?utf-8?B?TDJWbk90VWNvOXpGUThPNG9XVENRcXJGQjNpK05BdDNybUFURUtldVFpRFVE?=
 =?utf-8?B?ZmZ2QUQyOFNFaTZRbFV6V1ZGVUlxaW05emxFZk5LUWcvaXZMazFacDdYVjJ6?=
 =?utf-8?B?YTBxK0JyTjJmbTlyelR1YU02QnZIaWp1MnVZb04xaUR1UVZUTklxejRlemdV?=
 =?utf-8?B?YkREZ1pPQ1poZDY0STJVN2c0TkFkekVIeGQ4cU9ha3NRSXgxdS9ydkFUdW9D?=
 =?utf-8?B?MmNZeWRFKzBIS3d4RUdWNTVnb1RPTXViTGhCdi9KakNjL0FpaDFsemx6bnhY?=
 =?utf-8?B?cHo0QUZPdHpueHRySGx4dkVTT09JNjcxVWs4N0J3VUpuVFlLN3FrdVZkMDkr?=
 =?utf-8?B?SnNKcnV2UjBiYWVpeU5XTHE1R0l2Qmc3UG5pOHdFNi92NGhTTElBTWx6SjBP?=
 =?utf-8?B?NDJudmF3RmYyd0lUQlZZK1hLTG1ITWd4aFVWcTFWU25YU0FtNEV5YUszMUt3?=
 =?utf-8?B?WURadnJuSUZtSkZXZU12QTg3ZlhGWXdUNDlNRkV6bzk4aHdQSWFYS0Nxc3V2?=
 =?utf-8?B?TXpsWHpnRTZGVkNlTlYrbko2QzlienovajZab0JjeHVjSHVONEdYS29CRENx?=
 =?utf-8?B?TzJ4ZTVZeGVUR09YRHRTclN4SENZU25GSlZDNnhDUmZRbGxibGVHNTM2S3hR?=
 =?utf-8?B?emEwelBnRFdRYWdiMzdzY09lN2lQSnducEo2V3lyUWRFMDlDTkRIU2srVzl4?=
 =?utf-8?B?b2t5K0d3cjB2aDExb3F3MmplaUJ4T3A3UnNZSmhrZjFDeTdISE5mTVEvdUFJ?=
 =?utf-8?B?anc1MXpRMlF5T3BsVlNnVFNOR1dBSlVHenJ4aXBYQ0N6WE1oTHBIdFVOdEhj?=
 =?utf-8?B?c0haTm5za2ZWc1k0dW13TEcrM1NzUGY4T0xrSVM3a0h5SVRycnRkU09hU0NP?=
 =?utf-8?B?QnM1c0YrL2FHYUhOYjZhMlBEUG9pRCtmWE5Qb2E4YXlGWFJzeWc2cHpaT3l6?=
 =?utf-8?Q?VU15w9RQZJJ9/EIs+2IkOo4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7213.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(19092799006)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TDErbHd2STN1Y3hPMTdvVnY3SnJIWjZKb2gweG4zRmxNaHJ5WTdXbCt5Rzdj?=
 =?utf-8?B?S3haeXFkMVh6U1h0alVsTmhxS0VrRUVSM3VQdDJUbVcza093NngzcFBsSVBQ?=
 =?utf-8?B?SjV3bTJ0Q1NIVDkyNmE4VFdSZnN3KzVQWVA2cjl1dDdMc29wOThlNXMzU2JH?=
 =?utf-8?B?aS9JamU0Y092cXRsZXZ1OEdpQU1wWmtBYm5ZZkkxbVBMUGovS1VUNitNS25G?=
 =?utf-8?B?WlprVGVtcXdkY2lNcVpiS2h2OHZXTWNpV2pXSDBDSzVSWWwvYlZQQi80RDd1?=
 =?utf-8?B?K2JZMm5ZN25KTGZVTkd3d1VwWmZNTG00MW1USTlETit3aHVTemxTT2E3VnB1?=
 =?utf-8?B?UXdhSDdUVm03NjZUQWJ3NzYxWUdYbWs4NXUyVGlZckR4cUpVRTVJZnVabDJB?=
 =?utf-8?B?WXloTi94bXQ0MUdId2tpTHUzSDFaODdSZkVNZCt4MGlOUFFhTEFZTWFic1E0?=
 =?utf-8?B?cjNTQUIwRk9zTDJvSGljOU5TSHBER0Y5OEY4NWZ4Y2dXOENwNjRuUzg2K3FH?=
 =?utf-8?B?UmtZNmEzVDVicWxxSFVXSG1jc2VDby96ZkxzQ0U2eHRyYStKVnZKUGlaT2da?=
 =?utf-8?B?ZURtd2hKZXBXL0R0eEUydWR4L25nNzFZOVhkWHFteXBwZVI1RmVDTG5pbCsw?=
 =?utf-8?B?OEdqZVE5cGQ0L3dWdmppa1hVMmtXSTNGaktnakJZczk0cGJ5anIvQ2gxRnRk?=
 =?utf-8?B?WUF0RDBXYWpadlpaOXI1L1RZenM5WlVnNklSenVZSnhxY3owR3BwekxlbHBQ?=
 =?utf-8?B?b2FleWJkaGt5SmtBODZsemp2V0NEbm1UckhoQ1pMYXRBVDFBdkJmL2dLSmdN?=
 =?utf-8?B?WlYvak01SFFjZ1g1emtCcEVhaWFoWHBESm9oNlpHZFpnZjZrVnhHWHduZGVX?=
 =?utf-8?B?bmtFcVZONWg4Q2t0M2ZmZkdDRHB4WGQyS0RkRXN5OW9UZ1cxcWg5Sm1PcTFB?=
 =?utf-8?B?cks1cjNyMjJOTXIyVXI5Z1RVLzNxNmJ5WTZQRVEzbExvYUVqcXdoeE9TWGU5?=
 =?utf-8?B?T0VnRzNIMWVzSExYdVdScEtERU1oazkxdHc1VDAxRTlwa2hva0U3cHhXQUVZ?=
 =?utf-8?B?LzFWQ1pTK0pRd2s3ZGxvVTNWaXpBYzRQZXJZTVcwYVZNRGZ5MkFESVRRRHVQ?=
 =?utf-8?B?M2FyV2RUb0JFWmhaOGRsdDY2OE9hN3UzMkhmcU96cHdaOXRhaUdMeHREMlZO?=
 =?utf-8?B?VTladlVsMzlFalBTSi9hVWVsbEhVR2c4ZURZNTRpRlBQUnNDZWtvV3pQTDBP?=
 =?utf-8?B?TlVnNGxXdi9iRWRFbnNPQXBMejhEQVJMTE5uT2cyeVhaOHV3MmJmTWNYYnhy?=
 =?utf-8?B?Znp3YW00TjlmeTh0NDFCNzRUZ3ZyYlFvRERrWjcxS0FqamV1NGxQQnhpT1pj?=
 =?utf-8?B?VUk5TWVkeXppUkVOaU9XRWFleXZnaStVdTAydEducGNJejh4U2FmdFJxMXo5?=
 =?utf-8?B?WngvKzhnVlJpWlYzcUF6L0NJbEZ1Z3hzL3NNMno0QXVZbDJiSUREQlhadjhE?=
 =?utf-8?B?NGZXVEdWdlNXS09EL0dudkdkM2EvUmoyQnk3WU1OT1NYTVg2S2lhKzF3cGdh?=
 =?utf-8?B?L3djcE5yeS9WOTA0Q0ZSMDRSUlBKRjkzMTNKTzVQVVZPcE55elVjYVkrS200?=
 =?utf-8?B?cWdLZmVaWU5FMVlON3JuR3BZNVNpZFVYWXlST2FsbU5neEc3blI5NVlsRnkv?=
 =?utf-8?B?ZSsvcW5EZE9nMkczckZmQVFsVURIZFBWQ2NDdUNHblNBZ2sxNXNTUXpsU2k3?=
 =?utf-8?B?TGV2V2lMYkVjSlNEOHo0cEs1VjNkbjNRMDE4d0RVYVhUTnVnSG5YN0FaUkpw?=
 =?utf-8?B?ZnVnZkc3NVNTcm9MRmhBWE9IRURXRzU2YldINFBNU05hVUpRT0RVV3ZHaWNL?=
 =?utf-8?B?NWxXekxySU9jTUJNUHdUN2hVTms4TE1yNG5UQ3IzTnFObis0SFJ0RFhFQ25y?=
 =?utf-8?B?VDZ4UU1vVys0dExnS1NCbXNOQUw3UFJwa0JSUjlaODZvODJ0M1M0eTlSaWNK?=
 =?utf-8?B?OHpMU0I2dGtrSjZobnZuME11dmRmVjZoSkdUd1hueEs4UW1DVmhZejJhVStN?=
 =?utf-8?B?RXlrYllPTE5ETGpJNjU3U2hTSmMyS1k1UWZ1VE9MOG9XUUdTNHh4N2FyY2hD?=
 =?utf-8?B?N3Z3anhBdUsvWnQ3NDFlUUUyMXBGbm5XWW1mL3R1SE9relFBeENZRjFXaysx?=
 =?utf-8?B?RWhHTFY1Mmtsd2tkYXhlNlcyZlRZTEhKVjdOUS94VUVsNEVOdTJ4cTBBaWpD?=
 =?utf-8?B?Sm0yVmdjbHE4OTVmTm5CMTZDUmpFY1Y0dXlmZ0dvUkE1ZkpVS2J6TXhrQ2RL?=
 =?utf-8?Q?W//YhdubwOk2yi/iJw?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7213.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34f87eb7-2185-45e3-a982-08de65de20d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2026 00:16:24.1016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gt6ptgkYhovzkdTRFLMfp7gFiTI/JMDbPcPdIhh1B8lyDTzxHWmAWWOZst2wCtDeT84wGydf8jzgQOIsZNh1Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10088
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42243-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ping.bai@nxp.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 82F2010441C
X-Rspamd-Action: no action

PiBTdWJqZWN0OiBSZTogW1BBVENIXSBQTTogc2xlZXA6IGNvcmU6IEZpeCByYWNlIGNvbmRpdGlv
biBpbiBhc3luYyBub2lycQ0KPiBzdXNwZW5kDQo+IA0KPiBPbiBGcmksIEZlYiA2LCAyMDI2IGF0
IDQ6MDPigK9QTSBKYWNreSBCYWkgPHBpbmcuYmFpQG54cC5jb20+IHdyb3RlOg0KPiA+DQo+ID4g
QSByYWNlIGNvbmRpdGlvbiBvY2N1cnMgZHVyaW5nIHRoZSBub2lycSBzdXNwZW5kIHN0YWdlIHdo
ZW4gYWNjZXNzaW5nDQo+ID4gYml0ZmllbGRzIGluIHN0cnVjdCBkZXZfcG1faW5mbywgY2F1c2lu
ZyBzeXN0ZW0gc3VzcGVuZCB0byBoYW5nLg0KPiA+DQo+ID4gRHVyaW5nIGFzeW5jIG5vaXJxIHN1
c3BlbmQsIGxlYWYgZGV2aWNlcyBhcmUgcXVldWVkIGZvciBhc3luY2hyb25vdXMNCj4gPiBwcm9j
ZXNzaW5nIHdoaWxlIHRoZSBtYWluIHN1c3BlbmQgdGhyZWFkIGNvbnRpbnVlcyBjbGVhcmluZyB0
aGUNCj4gPiAnd29ya19pbl9wcm9ncmVzcycgZmxhZyBvZiBvdGhlciBkZXZpY2VzLCBpbmNsdWRp
bmcgcG90ZW50aWFsIHBhcmVudHMNCj4gPiBvZiB0aG9zZSBsZWFmIGRldmljZXMuDQo+ID4NCj4g
PiBJbiBzdHJ1Y3QgZGV2X3BtX2luZm8sICd3b3JrX2luX3Byb2dyZXNzJyBhbmQgJ211c3RfcmVz
dW1lJyBhcmUNCj4gPiBiaXRmaWVsZHMgc3RvcmVkIGluIHRoZSBzYW1lIGJ5dGUuIFRoaXMgY3Jl
YXRlcyBhIHJhY2Ugd2hlbjoNCj4gPg0KPiA+IDEuIEEgbGVhZiBkZXZpY2UncyBhc3luYyB0aHJl
YWQgc2V0cyBpdHMgcGFyZW50J3MgJ211c3RfcmVzdW1lJyBmbGFnDQo+ID4gICAgdmlhIGRwbV9z
dXBlcmlvcl9zZXRfbXVzdF9yZXN1bWUoKQ0KPiA+IDIuIFNpbXVsdGFuZW91c2x5LCB0aGUgbWFp
biB0aHJlYWQgY2xlYXJzIHRoZSBwYXJlbnQncw0KPiA+ICAgICd3b3JrX2luX3Byb2dyZXNzJyBm
bGFnDQo+ID4NCj4gPiBTaW5jZSBiaXRmaWVsZCBvcGVyYXRpb25zIGFyZSBub3QgYXRvbWljLCBj
b25jdXJyZW50IG1vZGlmaWNhdGlvbnMgdG8NCj4gPiB0aGUgc2FtZSBieXRlIGNhbiBjb3JydXB0
IGJvdGggZmllbGRzLiBUaGlzIGxlYXZlcyB0aGUgcGFyZW50IGRldmljZQ0KPiA+IGluIGFuIGlu
Y29ycmVjdCBzdGF0ZSwgY2F1c2luZyB0aGUgc3lzdGVtIHN1c3BlbmQgdG8gaGFuZy4NCj4gPg0K
PiA+IEZpeCB0aGlzIGJ5IGFkZGluZyBsb2NrIHByb3RlY3Rpb24gYXJvdW5kIHRoZSBiaXRmaWVs
ZCBhY2Nlc3NlcyB0bw0KPiA+IGVuc3VyZSBhdG9taWMgcmVhZC1tb2RpZnktd3JpdGUgb3BlcmF0
aW9ucy4NCj4gPg0KPiA+IEZpeGVzOiA0NDMwNDZkMWFkNjYgKCJQTTogc2xlZXA6IE1ha2Ugc3Vz
cGVuZCBvZiBkZXZpY2VzIG1vcmUNCj4gPiBhc3luY2hyb25vdXMiKQ0KPiA+IFNpZ25lZC1vZmYt
Ynk6IEphY2t5IEJhaSA8cGluZy5iYWlAbnhwLmNvbT4NCj4gDQo+IFRoZXJlIGlzIGEgZml4IGZv
ciB0aGlzIGFscmVhZHkgaW4gbXkgdHJlZSwgc2VlDQo+IA0KVGh4IFJhZmFlbC4gVGhlIHBhdGNo
IGluIHlvdXIgdHJlZSBwcm92aWRlIGEgbm9uLWxvY2tpbmcgd2F5LiBNeSBwYXRjaCBjYW4gYmUg
ZHJvcHBlZC4NCkkgV2lsbCBwaWNrIHRoaXMgcGF0Y2ggSW50byBvdXIgaW50ZXJuYWwgdHJlZSB0
byBmaXggdGhlIGlzc3VlIHdlIG1lZXQuDQoNCkJSDQpKYWNreSBCYWkNCj4gDQo+ID4gLS0tDQo+
ID4gIGRyaXZlcnMvYmFzZS9wb3dlci9tYWluLmMgfCAyMCArKysrKysrKysrKysrKysrKy0tLQ0K
PiA+ICAxIGZpbGUgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Jhc2UvcG93ZXIvbWFpbi5jIGIvZHJpdmVycy9i
YXNlL3Bvd2VyL21haW4uYw0KPiA+IGluZGV4DQo+ID4NCj4gMTg5ZGU1MjUwZjI1NmJkYzFjZGMz
MzAwNmIyYzM4NmQwNzk0NDg1Zi4uNTYxZTI0YzI1N2Q3NzlkYjUxYTBmMGQNCj4gNTBkY2YNCj4g
PiBlZTYxZTk4ZGU2NGYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9iYXNlL3Bvd2VyL21haW4u
Yw0KPiA+ICsrKyBiL2RyaXZlcnMvYmFzZS9wb3dlci9tYWluLmMNCj4gPiBAQCAtNjMzLDcgKzYz
Myw5IEBAIHN0YXRpYyBib29sIF9fZHBtX2FzeW5jKHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gYXN5
bmNfZnVuY190IGZ1bmMpDQo+ID4gICAgICAgICBpZiAoIWlzX2FzeW5jKGRldikpDQo+ID4gICAg
ICAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4gPg0KPiA+ICsgICAgICAgc3Bpbl9sb2NrX2ly
cSgmZGV2LT5wb3dlci5sb2NrKTsNCj4gPiAgICAgICAgIGRldi0+cG93ZXIud29ya19pbl9wcm9n
cmVzcyA9IHRydWU7DQo+ID4gKyAgICAgICBzcGluX3VubG9ja19pcnEoJmRldi0+cG93ZXIubG9j
ayk7DQo+ID4NCj4gPiAgICAgICAgIGdldF9kZXZpY2UoZGV2KTsNCj4gPg0KPiA+IEBAIC02NTYs
OCArNjU4LDExIEBAIHN0YXRpYyBpbnQgZHBtX2FzeW5jX3dpdGhfY2xlYW51cChzdHJ1Y3QgZGV2
aWNlDQo+ID4gKmRldiwgdm9pZCAqZm4pICB7DQo+ID4gICAgICAgICBndWFyZChtdXRleCkoJmFz
eW5jX3dpcF9tdHgpOw0KPiA+DQo+ID4gLSAgICAgICBpZiAoIV9fZHBtX2FzeW5jKGRldiwgZm4p
KQ0KPiA+ICsgICAgICAgaWYgKCFfX2RwbV9hc3luYyhkZXYsIGZuKSkgew0KPiA+ICsgICAgICAg
ICAgICAgICBzcGluX2xvY2tfaXJxKCZkZXYtPnBvd2VyLmxvY2spOw0KPiA+ICAgICAgICAgICAg
ICAgICBkZXYtPnBvd2VyLndvcmtfaW5fcHJvZ3Jlc3MgPSBmYWxzZTsNCj4gPiArICAgICAgICAg
ICAgICAgc3Bpbl91bmxvY2tfaXJxKCZkZXYtPnBvd2VyLmxvY2spOw0KPiA+ICsgICAgICAgfQ0K
PiA+DQo+ID4gICAgICAgICByZXR1cm4gMDsNCj4gPiAgfQ0KPiA+IEBAIC02OTgsNyArNzAzLDEw
IEBAIHN0YXRpYyB2b2lkIGRwbV9hc3luY19yZXN1bWVfc3Vib3JkaW5hdGUoc3RydWN0DQo+ID4g
ZGV2aWNlICpkZXYsIGFzeW5jX2Z1bmNfdCBmdW5jKSAgc3RhdGljIHZvaWQNCj4gPiBkcG1fY2xl
YXJfYXN5bmNfc3RhdGUoc3RydWN0IGRldmljZSAqZGV2KSAgew0KPiA+ICAgICAgICAgcmVpbml0
X2NvbXBsZXRpb24oJmRldi0+cG93ZXIuY29tcGxldGlvbik7DQo+ID4gKw0KPiA+ICsgICAgICAg
c3Bpbl9sb2NrX2lycSgmZGV2LT5wb3dlci5sb2NrKTsNCj4gPiAgICAgICAgIGRldi0+cG93ZXIu
d29ya19pbl9wcm9ncmVzcyA9IGZhbHNlOw0KPiA+ICsgICAgICAgc3Bpbl91bmxvY2tfaXJxKCZk
ZXYtPnBvd2VyLmxvY2spOw0KPiA+ICB9DQo+ID4NCj4gPiAgc3RhdGljIGJvb2wgZHBtX3Jvb3Rf
ZGV2aWNlKHN0cnVjdCBkZXZpY2UgKmRldikgQEAgLTE0MDcsMTMgKzE0MTUsMTkNCj4gPiBAQCBz
dGF0aWMgdm9pZCBkcG1fc3VwZXJpb3Jfc2V0X211c3RfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRl
dikNCj4gPiAgICAgICAgIHN0cnVjdCBkZXZpY2VfbGluayAqbGluazsNCj4gPiAgICAgICAgIGlu
dCBpZHg7DQo+ID4NCj4gPiAtICAgICAgIGlmIChkZXYtPnBhcmVudCkNCj4gPiArICAgICAgIGlm
IChkZXYtPnBhcmVudCkgew0KPiA+ICsgICAgICAgICAgICAgICBzcGluX2xvY2tfaXJxKCZkZXYt
PnBhcmVudC0+cG93ZXIubG9jayk7DQo+ID4gICAgICAgICAgICAgICAgIGRldi0+cGFyZW50LT5w
b3dlci5tdXN0X3Jlc3VtZSA9IHRydWU7DQo+ID4gKyAgICAgICAgICAgICAgIHNwaW5fdW5sb2Nr
X2lycSgmZGV2LT5wYXJlbnQtPnBvd2VyLmxvY2spOw0KPiA+ICsgICAgICAgfQ0KPiA+DQo+ID4g
ICAgICAgICBpZHggPSBkZXZpY2VfbGlua3NfcmVhZF9sb2NrKCk7DQo+ID4NCj4gPiAtICAgICAg
IGRldl9mb3JfZWFjaF9saW5rX3RvX3N1cHBsaWVyKGxpbmssIGRldikNCj4gPiArICAgICAgIGRl
dl9mb3JfZWFjaF9saW5rX3RvX3N1cHBsaWVyKGxpbmssIGRldikgew0KPiA+ICsgICAgICAgICAg
ICAgICBzcGluX2xvY2tfaXJxKCZsaW5rLT5zdXBwbGllci0+cG93ZXIubG9jayk7DQo+ID4gICAg
ICAgICAgICAgICAgIGxpbmstPnN1cHBsaWVyLT5wb3dlci5tdXN0X3Jlc3VtZSA9IHRydWU7DQo+
ID4gKyAgICAgICAgICAgICAgIHNwaW5fdW5sb2NrX2lycSgmbGluay0+c3VwcGxpZXItPnBvd2Vy
LmxvY2spOw0KPiA+ICsgICAgICAgfQ0KPiA+DQo+ID4gICAgICAgICBkZXZpY2VfbGlua3NfcmVh
ZF91bmxvY2soaWR4KTsgIH0NCj4gPg0KPiA+IC0tLQ0KPiA+IGJhc2UtY29tbWl0OiA5ODQ1Y2Y3
M2Y3ZGI2MDk0YzBkODQxOWQ2YWRiODQ4MDI4ZjRhOTIxDQo+ID4gY2hhbmdlLWlkOiAyMDI2MDIw
Ni1ub2lycV9hc3luY19zdXNwZW5kLTY0NWJkNmI4MzA1ZQ0KPiA+DQo+ID4gQmVzdCByZWdhcmRz
LA0KPiA+IC0tDQo+ID4gSmFja3kgQmFpIDxwaW5nLmJhaUBueHAuY29tPg0KPiA+DQo+ID4NCg==

