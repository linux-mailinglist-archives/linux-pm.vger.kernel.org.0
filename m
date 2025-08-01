Return-Path: <linux-pm+bounces-31764-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E67B1842D
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 16:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D233F7A2FA7
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 14:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6A22701B1;
	Fri,  1 Aug 2025 14:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="N6XZsxYq"
X-Original-To: linux-pm@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011063.outbound.protection.outlook.com [40.107.130.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E4D26FD9F
	for <linux-pm@vger.kernel.org>; Fri,  1 Aug 2025 14:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754059736; cv=fail; b=sDS/fVC2iJbydGyIMb3ZlInpJ6UP9pEC0euoFk19ve1Af5yv44wv+JG2Z/qtaJRdgk7fftRErNDkDqNDOVo7vApV3KWxa0Si/6Mep1pwjcD4YUJR4w6dZVixlsbPYtOvR5C/WB5vA6HwVd7RcVytD+w4AKXJlnO8RzXw44Vs/Tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754059736; c=relaxed/simple;
	bh=bB8Ydk81DdrypjZIlrdQER8+P5s8BS9l08FM/LgCW00=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jgkOhHGR6IniEnOrOG633j0MThL11C+nlTi/FU+LGXQn55Pv4fIvB1GbGoF7WOCZS+iZgxYdVklI4h95SkZ/TaEgV9lzEAPz9/qfrp0PpthTXjkRDXebCKDY2s3CpEuuN3gYcVTpovfRR4kMA+FCVN2CNY4CBxA8B95Ss2Qpm88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=N6XZsxYq; arc=fail smtp.client-ip=40.107.130.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L4aFr8EV20c+8roHFnKv6FY8vUzAakPz1m/8n3wnDhVI93Mepjjq5ZW2KOyHt6+BxfE+KOzyZnVRBtVoS/iUg61C9825QTWivP3rCycYjD0Z/sRw+NV4BmMW4VRw56JzbSjppdPDE/r7v3LxuzauTvNHTtHUuRQNKYOlosKERSGEXe13QQLTzqmqmtv2cs87H00yM9opgFprwj2EmdULRPRaDa0OlLRbwBBKp5hd+huuCy0YdvkKtGD+Zgmun8ArUlAoNUuHYEqLPk+YQhzZj6Orde0xF58DL2LtXatK2PeDZyRSnsz6RuL6BkMyurN89SlmL8hbOimnB/seI9KL2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bB8Ydk81DdrypjZIlrdQER8+P5s8BS9l08FM/LgCW00=;
 b=ZadxoPBocJ9dpjMhElr9tTnTMsSFBc3e0lq53b2LyKHpH27EDhNYl24PQ4WUvSLVT2SPMDWiQbnEckPHKnoHICR8GzxjRXTFq3eOqvJ887wyHXjrIrol341c4VMrumYoB4lP/dIdQKRR+hF5ySzyj8PWUrx13lhbjdpA54vR3bS5SVkXda24jUW039+rJ8W43YBiVagknnEbV45smp2QOYDwPJfr44trWCjhLfymHNlsv/pGwVWs+ND72y1RvAMg2ARa2iy0QipbfltJ5ROn5JItdalPQcr79Yqpm1F8iG/zTgNT3DeEkfOkz59wahCh218PLM7OR12SPs82WahRLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bB8Ydk81DdrypjZIlrdQER8+P5s8BS9l08FM/LgCW00=;
 b=N6XZsxYqEsJItvhFHuvyxwhw67pHxqxeADsh/uZco9QI8tPFqEtQfjO8OUBCmB0xwg8+IXRlVeg4fDE5GWjWucRRs1Kf9qa6hM4o8P4YjaQsoG4344XwSez4F9mdsZm972xn8hh2fEMQXkvX7Vp4Fc/1gK9Olhy3hkG+j+0BpYlS0Ugl8kI3wP6LKcheipfLebsMWWaat5zdVmHjkqQt0L5YrZbsCngr//oQXGcVXahdWdUIeuCwVPhElK9leNEoxFW9lM9ZVefmLh8FSBM8eij0jkRaKzNHD2qILmcgHR4kgLVDYUZixYOLd7ide0aFLi/0DFCtbn4KMuMTn2ElWg==
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com (2603:10a6:20b:429::24)
 by AM8PR04MB7972.eurprd04.prod.outlook.com (2603:10a6:20b:236::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.16; Fri, 1 Aug
 2025 14:48:49 +0000
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb]) by AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb%5]) with mapi id 15.20.8989.015; Fri, 1 Aug 2025
 14:48:49 +0000
From: Jacky Bai <ping.bai@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "rafael@kernel.org"
	<rafael@kernel.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
	"rui.zhang@intel.com" <rui.zhang@intel.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>
Subject: RE: [PATCH v2 1/4] dt-bindings: thermal: qoriq: Update compatible
 string for imx93
Thread-Topic: [PATCH v2 1/4] dt-bindings: thermal: qoriq: Update compatible
 string for imx93
Thread-Index: AQHcAruCK9AVRi8T/0uCABEvdDU5/7RNfnUAgABhgAA=
Date: Fri, 1 Aug 2025 14:48:49 +0000
Message-ID:
 <AS8PR04MB86424D1EE8AB3255D5C88CD28726A@AS8PR04MB8642.eurprd04.prod.outlook.com>
References: <20250801081119.1999298-1-ping.bai@nxp.com>
 <8dcbdb51-82ba-44bd-800f-ceb43f88cf4d@kernel.org>
In-Reply-To: <8dcbdb51-82ba-44bd-800f-ceb43f88cf4d@kernel.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8642:EE_|AM8PR04MB7972:EE_
x-ms-office365-filtering-correlation-id: 88474672-1acf-4548-9616-08ddd10a8685
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|1800799024|376014|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MTErR3dWNERqV2xtMXJrd1Exek1KdUpLRVo2Y0c4T0hhR24wSzE4U0lmd1Ni?=
 =?utf-8?B?T2o3VTRySXhnWThWajIzU3BESWtiZXp2NUVCQkwrbmpVRit2NGx5UlMxVEhD?=
 =?utf-8?B?akxvbjRmdkJwbmpFTEFic0ZiK2pFUm9GQjdoS0tGT1lBRDE2ODU3QUlkN2dq?=
 =?utf-8?B?bHhubzNzNXlsZkRFYTI2dkV2UEp2c24wQXZqMy84TC9NL1c3M3JFcDNQSWU1?=
 =?utf-8?B?YXJYL3FMNVNVMnUzS3N1a1IvWmNpMEVvNjQrTnBKdm9YWFdsbjRFd1M0ZjZ0?=
 =?utf-8?B?V1JqY241d0wrbWhSRUhIT3lXdHFIeW9jSUgyN1ZWb2xZVkZRQitSbDV1Y0wz?=
 =?utf-8?B?akJsWS80M0VFejZXRDRCbzNxUnZkcnRCdGR6V05BZkVQWFN4blIxL0hLd0h0?=
 =?utf-8?B?aWc2WlQyRFhoOHpwbGRsM3ZteEVLcENZc1J5STN3SEVwdFNUeUl1Z08zQXRJ?=
 =?utf-8?B?ZHdlOHJvL3JVSWpsK1pPa29RMWkvL3pyUHgxN2RDU29iVk9EMllUbHBTWGh3?=
 =?utf-8?B?aUxvUGhoSnBFYUUyVW1UdUUvZWlvYUlrNlpxQVV1Tk1XaWVaalNhUXJyYmZE?=
 =?utf-8?B?YjlZT0tXZUcyOCtHbzRuU0JRTWxIaWVFeGZZT0VmMEdYUnFpMzJMZk5Dc1Iy?=
 =?utf-8?B?eWcxVFpaS3ZaTmk5N0owQXIzOWdPWGFOend5OEoyVEZEVnRIUmdVdTJZWmRY?=
 =?utf-8?B?eEFJbFdSdUdmRG9lRWdERzNjdkdrd3FoM1NTbkh3WWVKaCtrSTJRK2RuRGlU?=
 =?utf-8?B?Y2RsZGp4QU02MTFRNmVHY2Q1OHVvUGFKT05mR242OFN5cWt2dWJiRHBlWDFl?=
 =?utf-8?B?K1FNeS9iUzFuRTZtc1V0SEc2bEhKMDh2Qlk3Mk42SmFtTGlyWlhIK3F5cEZV?=
 =?utf-8?B?dzc2NEl5UDJtSm8wOWtpZkQyZWI4L2puWVFVQWdwZW83TTJIWVNLbUZIbURH?=
 =?utf-8?B?UkNyUjExZGxZVUJURGhOc01zS3NKME13RFRxZzNITnVnVnpMTXZrejhvQm5E?=
 =?utf-8?B?QmFQdng4d0wremZoYWpHWkdVSzBpZ2pyb1ZTU0JoNWtEbURscXdESS9oeVFR?=
 =?utf-8?B?NHlRSHFTTXpOcGtOMkhSd1hrUGVkS2p5UEVBNXNYbnA2MzVYZlAxcUdwR1FY?=
 =?utf-8?B?NndaMGUzNWkvWWtIN2lJblRiTnVyYTl2L2RTeE9VZng2N0dwWk1YQVVSREx3?=
 =?utf-8?B?VWkyWUNreWJCeFljb0tiSElFQ0lrRVBsSm1ValN3VThJWXMvNGVXWjNTaEd0?=
 =?utf-8?B?Zks4L1lDbmZFc1pWa2o2RGI1ZTBtSGJ2SE5va0ZXcUJZRHErYjA5aERjT2tE?=
 =?utf-8?B?d2hXZ3BkN3E5bC83WlNrYmViMStwQU5iZUJnckRaZitTeGFXQmdtMEVVNHhZ?=
 =?utf-8?B?c2F6SjFBc0xDZFpLdmhJZ1BEVFVkZ1ZoQVdXU0N2c094U3lIU1ZmQTJtWVJR?=
 =?utf-8?B?UGNDdGNFblhyRGNzQk1HYmF2ZVRNZFFacUliMUIwMFQrQW9MK29zWVk2c3RX?=
 =?utf-8?B?YXRkblBpM3NSelJ3YTU1VXZNYkVhMTFxZE1WMUVUcHAyWk1DYzBtc2dSNTVL?=
 =?utf-8?B?ckxRUnFxR0NqNG84cEZjUEFOb0V4SnJCZjhFV05RdmZacTVlQUcwMy9LSXBU?=
 =?utf-8?B?SDVuY0UxTTVUcEc5a093cXRFbCs4NFpFM3pHMUNoUWdMQ09aRjBnNUhCblQ5?=
 =?utf-8?B?N2ZSZEo4eTlFeVhBMnR3eW1teURmRGtHdHB6R3hQeGZyTmFnSjgrbG1DMXNF?=
 =?utf-8?B?MFd1VE4vM3RwUjJ4WnBEVy84d0wrZUZWQ2dQUjNmVnRiRkpHYnR5YkpEUkJG?=
 =?utf-8?B?aVA4TktxUWxmOENvMTgwRllZNytscy9JN1lTTHZpWnQzWEsybzZTbE5sb2tN?=
 =?utf-8?B?N3dnc3o2ZXR5TzBoRlN0RC9HRE93SkZmUGUvUkJiZURCa1RtLzFMY3d1Wmlm?=
 =?utf-8?B?SjI5RTBSL1llM0xkSm1XK1EwSndoekxhTUN5cEdqNlRVR3lTdkZOQUJkVGlQ?=
 =?utf-8?B?a09YMnlEcjVnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?czhtMklHZHFZYmYxVi9JalNZRDlnWjVMVUZ4bWpjMUZHZW9qbkVyN1ZTajVQ?=
 =?utf-8?B?SXZyMksyRmRnN3N4bml4SHVmUVdFcG04dml0bFpHWHZMSUVoeXQ2ZDZjNHNy?=
 =?utf-8?B?WFJsQStobnZicGV0ci9uajBTNko2UFlBSHBIclI5M3dnNFlxNHEwUFE2YTZ2?=
 =?utf-8?B?YzVuMDZiWTRFdEp1cDF3YkRpY29GVDZXbkxCd0dua3N6WFdnVkoydk5NMzg1?=
 =?utf-8?B?aHFUWE9EOUxOTjJibVhxU2FTckpMM3EwZmlSSTB6MW1XTW5rUHVNQklyOEpt?=
 =?utf-8?B?bkJqektYYUJmZFpEOWNHL0hhK1ZlcVNDbkduU2hlMEQ3KzF6UkdSTTNyM2tT?=
 =?utf-8?B?TzJvOE9ZZ2gzS1BzRlkxeStRdmRIclkzSEthQ2p6ejJ5Nk5lNkdoWU5uWWdu?=
 =?utf-8?B?MS9ySTVXMHk4VG5rQ0c5aUZrdlFQWlRBQklublNISU1GcnNINUxTdEZXR3Y5?=
 =?utf-8?B?OW9kdlZDdnNZaGdna2JHOXIvTE5tamRXMnRDL2ZuN1VHdWlWeTJ6OFZtaExx?=
 =?utf-8?B?TStsSEQ5MWR0czViZS9HeWlra0Ivb0YvUnl0YVRjdHhxYTM0RXdPMHE4bGhW?=
 =?utf-8?B?L0ExQUlSZmdTR0FDRWxOSGxyVEprVUtsWjZPQWhtNUZuVG9rc1B4ZHkyL2lv?=
 =?utf-8?B?MGVERzNoL0E1eFhWUkZ5dklhMTgvMHdYVUd1M0h5NjUxMi8wYlRGdmJjQlZM?=
 =?utf-8?B?Tm40bkQxL1RsQWk0UHZ1cWR6TGpEZkJvKytLa1BkSFZWOXoxMmN0N2pRTGwx?=
 =?utf-8?B?V1hkYmlVM3RvMEkraElFZU5mQlUvOG5jRjdGMWFxdXdZaHY2aHM1WUVwMDh4?=
 =?utf-8?B?Z1A4UTZqQ1BHVnRURHRyaEhRK2xHcDNybEpTdVg5NkJUaEF5YWZBQUMvUnVs?=
 =?utf-8?B?WGFnTGZpUnVjdUN1K3hIQVUreXpmOUxWZS94T1BmYXZCWnVpT2dRR1pEaFY2?=
 =?utf-8?B?QVdNV2ZyWHZsUktwaE5YNVdMSFhOMjVZdkxqN1pNZUdQaVJGSEJ1OURVem9W?=
 =?utf-8?B?K2JOdWYvd1JWbWxOcWdVK0t0a1VDTkRNaDM4WERuT1U5SG41Q2F5ZGlFL3lP?=
 =?utf-8?B?Z3NGQ21oSXJnYmxWSjZLdUgzOVhNaE9sQkZDcW5MWjJSQ2ZhMVQrTGFTRDlJ?=
 =?utf-8?B?T3Zvakx3NEprSjJPaXU5SmRKUWRZamx6eHJMWXd5a29pUklCelNSeWNhT2pD?=
 =?utf-8?B?MmlGMHFEd28rWGllVHBQc3c0Tk5YbkVLbzIzOVgvUFVUNTRFT1BhQzFhb2Rx?=
 =?utf-8?B?T1JIZHgwUVFJTWZoWEoxdzk0SU5VRUZCYitBUEQwYzI5cDlyVzArckR1bU14?=
 =?utf-8?B?TW9VZjkrbVMyVnVzdFQvNURqRXBHZVBJUmdSUE5LM0hFWS9jRVdnUkFMM29p?=
 =?utf-8?B?WC9hV29qYVRDUWFZUW5xc2VhSzgyeWxMMmxxdXltcVBjU3FucTl0RjI5dHZO?=
 =?utf-8?B?QTkyV0t5M1FNazZGbUdYOU9KSDQ2N00wT0Z4dXZIVU8yVDNqaTNvRHFmeDlr?=
 =?utf-8?B?M1NVS3B6bSsyVlMwTXRSNlZVQmlIakZEelQxaWEyRGplVmVKR2wveDVhL3dk?=
 =?utf-8?B?UDQvMGdNQjZYYjNEZzczTlN3VkpHUFBKZVg5djN0NERrejBYY25obXBLU0tn?=
 =?utf-8?B?bWlNb3lFVERYT2FsVHROZHFHODBHd0lWL3F2QVdIOEk1TjdRNzhZNXhTNjZy?=
 =?utf-8?B?bVNGRnZoWTdZREdZRnVXN0VROUtja2tiVmZ1ZEJKM3Z4WjQyZFZueTJvMk5w?=
 =?utf-8?B?Mkd2eXJuOE5kaURjS2hDbHJ2cERwdmVqRk8xUG1waktyZUY2cVl2R2k5Qm1S?=
 =?utf-8?B?dlk4eDgzWGhuNFpFNWwvUmtFdTRNRE1mTlYrWTFsbCt2WTd0RWhlT2wzb3Y5?=
 =?utf-8?B?U1lzM3gxVWRTNjdkK2pFMVVKdHBkTFFrOG9GemdxVk5abjRETk0zVTd4SlYw?=
 =?utf-8?B?aFRhcFRpWmlPbnEyT2FlV3dLTm9BNytESUd1czdMZGJwZ0pneTNvTi9teVBC?=
 =?utf-8?B?OVR3eHpOY1JZN2wzMkx4SlZyTmRKQzZFVHhIUHJnNkdUMWxuc0wxcExURkNK?=
 =?utf-8?B?SnoxYVJuZFkwR0dEZTBWZzFZcTArL2NPekRkUFdrZVVURUt6UUd6WVNUQlRv?=
 =?utf-8?Q?vBYk=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88474672-1acf-4548-9616-08ddd10a8685
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2025 14:48:49.2636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HNHDevDY8JFBCFki8QX1MdBt/LtEhZMGLWQFRnISRpBi2xlSkE5rmKZhdw9lNzKN7hvH0/lyC7nqEAoVZUaIDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7972

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDEvNF0gZHQtYmluZGluZ3M6IHRoZXJtYWw6IHFvcmlx
OiBVcGRhdGUgY29tcGF0aWJsZQ0KPiBzdHJpbmcgZm9yIGlteDkzDQo+IA0KPiBPbiAwMS8wOC8y
MDI1IDEwOjExLCBKYWNreSBCYWkgd3JvdGU6DQo+ID4gVGhlIFRNVSB1c2VkIG9uIGkuTVg5MyBo
YXMgc29tZSBzbGlnaHQgZGlmZmVyZW5jZXMgYW5kIGJ1Z3MgY29tcGFyZWQNCj4gPiB3aXRoIHRo
ZSBvbmUgdXNlZCBvbiBRb3JJUSBwbGF0Zm9yYW0gZXZlbiB0aGUgYmFzaWMgZnVuY3Rpb24gaXMg
dGhlDQo+ID4gc2FtZS4gQWRkDQo+ID4gaS5NWDkzIHNwZWNpZmljIGNvbXBhdGlibGUgc3RyaW5n
IGFuZCBrZWVwIHRoZSBmYWxsYmFjayBhYmlsaXR5Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
SmFja3kgQmFpIDxwaW5nLmJhaUBueHAuY29tPg0KPiANCj4gPGZvcm0gbGV0dGVyPg0KPiBQbGVh
c2UgdXNlIHNjcmlwdHMvZ2V0X21haW50YWluZXJzLnBsIHRvIGdldCBhIGxpc3Qgb2YgbmVjZXNz
YXJ5IHBlb3BsZSBhbmQNCj4gbGlzdHMgdG8gQ0MuIEl0IG1pZ2h0IGhhcHBlbiwgdGhhdCBjb21t
YW5kIHdoZW4gcnVuIG9uIGFuIG9sZGVyIGtlcm5lbCwgZ2l2ZXMNCj4geW91IG91dGRhdGVkIGVu
dHJpZXMuIFRoZXJlZm9yZSBwbGVhc2UgYmUgc3VyZSB5b3UgYmFzZSB5b3VyIHBhdGNoZXMgb24N
Cj4gcmVjZW50IExpbnV4IGtlcm5lbC4NCg0KTXkgZmF1bHQuIFdpbGwgYWRkIGFsbCB0aGUgbmVj
ZXNzYXJ5IGxpc3Qgd2hlbiByZXNlbmQgdGhlIHBhdGNoLiBJIHVzZSB0aGUgZ2V0X21haW50YWlu
ZXJzLnBsLCBidXQgdGhlDQpkZXZpY2UgdHJlZSBsaXN0IG1pc3NlZCBieSBtaXN0YWtlLg0KDQpC
Ug0KPiANCj4gVG9vbHMgbGlrZSBiNCBvciBzY3JpcHRzL2dldF9tYWludGFpbmVyLnBsIHByb3Zp
ZGUgeW91IHByb3BlciBsaXN0IG9mIHBlb3BsZSwgc28NCj4gZml4IHlvdXIgd29ya2Zsb3cuIFRv
b2xzIG1pZ2h0IGFsc28gZmFpbCBpZiB5b3Ugd29yayBvbiBzb21lIGFuY2llbnQgdHJlZSAoZG9u
J3QsDQo+IGluc3RlYWQgdXNlIG1haW5saW5lKSBvciB3b3JrIG9uIGZvcmsgb2Yga2VybmVsIChk
b24ndCwgaW5zdGVhZCB1c2UgbWFpbmxpbmUpLg0KPiBKdXN0IHVzZSBiNCBhbmQgZXZlcnl0aGlu
ZyBzaG91bGQgYmUgZmluZSwgYWx0aG91Z2ggcmVtZW1iZXIgYWJvdXQgYGI0IHByZXANCj4gLS1h
dXRvLXRvLWNjYCBpZiB5b3UgYWRkZWQgbmV3IHBhdGNoZXMgdG8gdGhlIHBhdGNoc2V0Lg0KPiAN
Cj4gWW91IG1pc3NlZCBhdCBsZWFzdCBkZXZpY2V0cmVlIGxpc3QgKG1heWJlIG1vcmUpLCBzbyB0
aGlzIHdvbid0IGJlIHRlc3RlZCBieQ0KPiBhdXRvbWF0ZWQgdG9vbGluZy4gUGVyZm9ybWluZyBy
ZXZpZXcgb24gdW50ZXN0ZWQgY29kZSBtaWdodCBiZSBhIHdhc3RlIG9mDQo+IHRpbWUuDQo+IA0K
PiBQbGVhc2Uga2luZGx5IHJlc2VuZCBhbmQgaW5jbHVkZSBhbGwgbmVjZXNzYXJ5IFRvL0NjIGVu
dHJpZXMuDQo+IDwvZm9ybSBsZXR0ZXI+DQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRv
Zg0K

