Return-Path: <linux-pm+bounces-23469-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 352E8A4F8FC
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 09:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AC6D3A4AEE
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 08:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447181FC119;
	Wed,  5 Mar 2025 08:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="b9o0mnC4"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F9142AAF;
	Wed,  5 Mar 2025 08:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741164073; cv=fail; b=YW/tC4SrMsUdEEu9jhcfz8+V2/sNvnVGp67J2BUAmKzihskDAs46RLf7kInTxAF4EWs9rXMIypmeFEdvgpqLIOtA0adGkR8J1vRS+lxH3qXK7bsXCk3Kr4mSLQhrZ/Vpynx1cN4srTHD/Rhlmd7qaqhzqZ31r6+qmRTpo7t9/dY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741164073; c=relaxed/simple;
	bh=Oh0ugGWFtllahK7ljAvy/HBScQO2/yYQrN8UyZFaQVg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gsAer59VlhPXFUXK52N5JDgm7HD7LBCH24k3FSeNSF5ep11eUTUpx3cjxSxwShWZ3bMPlrqj9ScE0NaItiWCUGzlQQ5OXh6ylhdHZnQTbiJVcUyCyq3qwZ3/gKUsknvB/szvfm148LX3AEgtbn6Mp0pXt6mb/awzLKGy7VOYGsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=b9o0mnC4; arc=fail smtp.client-ip=40.107.93.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yBNWPpV7daGzOLg7DT1/nlXbUUznogByLwrsBmiq03oqNYMJiFwegUw3jDxFN4UKf5nZrTgzTrgLPZVYPTXzERIjP27HK4KbN2A8E6GRj1JE7ZDwFCjg+999fXnN1UgZYqJF/iXbq5RuFBRsFpyf5swdkaC6N8Jh7xVUfU8EYN3JlDSPRpoxn+WUWfOgL5QvyUfVlq1JzgNdJxVT9Uy2ehJF/hyFvWz6B4uB6ZOv6Ta0axsfLyxnPgeczkSRg4p54fNKAYv+FrQ2UuooJ9Z+6QNbjvCFEb6lvsOI1crDtvNzabgmdIRIZzIrPnspykO4x2Q2iFFpshFLnr4462BXbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oh0ugGWFtllahK7ljAvy/HBScQO2/yYQrN8UyZFaQVg=;
 b=Vsru4mmzAEWhqe3vUztMRLPiEN2WshDASzN64ICWTABrY/6fz1f52X3ltNjNKFFjaqZlnMkYMyd7+V00N66hcp9rT75WVUWmAISL3Jf66Bsulmy3pruY8hDLoLMWlJg/1h412UEY7j/K2MQIajPw7OP0NJBLmlAlMShfffUR1q3N/jR6JLcttTJnN3XZEpO2FlGJ2HXK3s/B2TvX4ZZQbRccUuQOb90I4copHVem2IpIEqmOxeozrRq2//hTQAzJsA/0E8xOkIB8C0eVb9AwlMyJ18ST5MgXs25D38XRBrVqC/UIqIzRD6oCtWDtmv52Jm6vTG/6sSKrtZeGAtNSgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oh0ugGWFtllahK7ljAvy/HBScQO2/yYQrN8UyZFaQVg=;
 b=b9o0mnC4UMx2Zqwgy9VIBe0mz8GQ8NbZQ0gMozDppVmi850+DDGyHItE4P8zYOww1DyWCG2M4yfYtg49xd+9/h+TNhKpXk5V5qlBqwq/+MC3igtA7pL24HjqBgoVaxGuMQdiOnCBbNG/DVoLmOLpjiGHeheAABhu5FdE7dnmvzvmgdIW3uSXxwCQlawq8/Hx8Ord2WwejfP3mzszT3kFJZEaUcaq1SF8KrtElvTta8hIgxOQuF0f0ZiDP+jIUxRI9bSfvLFIA/J0A94h+cNKH73mNkXXAskW7uosn31tBjVSWvVTuIL6kfvac/O97PUgMDVE+vAmxY2dRl8RnoP4Gw==
Received: from SA0PR11MB4719.namprd11.prod.outlook.com (2603:10b6:806:95::17)
 by CY8PR11MB6820.namprd11.prod.outlook.com (2603:10b6:930:60::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Wed, 5 Mar
 2025 08:41:08 +0000
Received: from SA0PR11MB4719.namprd11.prod.outlook.com
 ([fe80::5303:b2dc:d84b:f3b2]) by SA0PR11MB4719.namprd11.prod.outlook.com
 ([fe80::5303:b2dc:d84b:f3b2%7]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 08:41:08 +0000
From: <Varshini.Rajendran@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <sre@kernel.org>, <p.zabel@pengutronix.de>,
	<Mihai.Sain@microchip.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>
Subject: Re: [PATCH v8 0/9] Add support for sam9x7 SoC family
Thread-Topic: [PATCH v8 0/9] Add support for sam9x7 SoC family
Thread-Index: AQHbGww0eNfdnuYAy0uOwjFkVwXjc7NlHpGA
Date: Wed, 5 Mar 2025 08:41:08 +0000
Message-ID: <e984d79a-f687-4c2a-ae70-32645ba6d14e@microchip.com>
References: <20241010120142.92057-1-varshini.rajendran@microchip.com>
In-Reply-To: <20241010120142.92057-1-varshini.rajendran@microchip.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR11MB4719:EE_|CY8PR11MB6820:EE_
x-ms-office365-filtering-correlation-id: a32ccba0-3c32-48fc-4343-08dd5bc179c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?M1ZZMncwRi80UzdoendyUWxRdHc5OWtRVU1zV1hEZ3I3SlZNTm9MMzArNTdV?=
 =?utf-8?B?N2hxbVI0R0ZRQkdLUW9lZlB2NnoxTWlySHVDdDVkdExXNW9HcFZWYWR2MnA0?=
 =?utf-8?B?elRKRkN0cVJZRk9nRzhxSG5oWDhYeWNtUUpQTC9PY2p4UzdJejlpZWpGWmxq?=
 =?utf-8?B?cXRQdEVOZnNacXJOUnhSeXNGKzY5YVdGVXdPUDl5S1ZMUTZuUVhBb1Jjc0ZD?=
 =?utf-8?B?TWNCR2lpczRRUnRhbTZaV1k3dk9iSDhWZTRITlVJYWh2cXNJVjdodHkrdDFE?=
 =?utf-8?B?by9zaThBa2VLUENPVUhHUndYWWdLVnVxZitsczBKWjVRbzMySzJucTFwWUsy?=
 =?utf-8?B?Z2FhWkZWTnFUbTJha1NNVFhnQ1ZMT3p6b0lSeDNwc3Ywd1hZUUtCMFBEa1Fm?=
 =?utf-8?B?WWJtSEhySGhHUHI4bjVFTmJrakFqTmk3Zy9wK2dpQTh6TnpjcWdWZTZVMEg3?=
 =?utf-8?B?NWdKcU1kc0tqMldscVJyeDBHczdLU3pyZ244VkM0N3F3cU5GU3E5bm9FRGdn?=
 =?utf-8?B?cHFqZ0FyWGxWM0RHVlhhcXo3VWZXczBmRVRoK3FkTlpWOUVtd3Y0UVVacFJv?=
 =?utf-8?B?Q01HaExhbGduU0t1T2RHOFFOaERNUkVZU3FkdDhRaTQrRE5SeE5Pb0k3WjBT?=
 =?utf-8?B?OSs4dVVLMS9ieGpMUE5PSTN5SDl5NitZOFFDcFFrY1BOUWJDRE1Fdy9WQ2px?=
 =?utf-8?B?YzdxZ2tsaHFYMkdHVEN1N2FPbjF3TTNCSFdVRUNONEUrZTgvR0QxMWpXMjhU?=
 =?utf-8?B?UmJZcXJBL3R1cjBXRm96OVROZjBHeFExUlFDMmJreTdvejR6VU9pT3JXcWNM?=
 =?utf-8?B?VHZRaGJ5dTBSbnVpWWRkSXZPTE1FQmwwUll1ZHE3emVjbkN2bEM0M0RYT2xU?=
 =?utf-8?B?TXlYZWhXbGJKc29WU1F3VmtEdGNmRmJ6Sko4UmwvbmZGMGNVSjZ3WGZ5MmpY?=
 =?utf-8?B?Mk8xMU9GL1BWall5Q0lMd0VsZ2VKb1RTWHc1eTRhRkVwZUxUVDIrakNVanBh?=
 =?utf-8?B?UC9wbUlzUnpjYlYzN2hpT3FaYmZmUEY5L01VUk5pTXVlWVg1cjRHR2dQTGUv?=
 =?utf-8?B?NXB1Vy9Odm5TNmwvS0t1aDNYS1lCem5FY1U4SHl0ckkwaW9vaWNlVnlpMHNZ?=
 =?utf-8?B?R05vNzk1VHRlaU5HZGpFZE13clQ0bGEySUdDSVgvOW81U2pIVFZRMm5DWmRa?=
 =?utf-8?B?VFpPREdxWExmWHA5TElCREU1MWVzS1p3NzVYbkQ5dzJ5RjhtZE9WNE9odlBn?=
 =?utf-8?B?YU0vNHdVK2xxSGRlK29BbUNvZU9hMGt0cmpzdy9FbDZyUVR0SnhkZUxGblBo?=
 =?utf-8?B?ZDFWVTAzRktweVRUVU9KeWRKekIrSlZKZjlZRlBGaDBqKzF6TDBqcXJYSUxv?=
 =?utf-8?B?R1dGd0VpeG02bEFXSnIzbitWV1BxbmN6REFrdXpRSXZnUlh5cG4vZnRsWE5s?=
 =?utf-8?B?YlhxdlFhVHh3dXZOa1NJemEwVkYyVW1IbkpoVzlyczdIU3Z0RnhFZWxmNkE2?=
 =?utf-8?B?MjllUUxlbEdTZCsvcDFwV3U0STlvSTduK0x4VDNTNUZESDUrU040YnB6WVVL?=
 =?utf-8?B?NXVyaVNCanJ6WWd2dFMzYUJnM3UrY2drZmNTbUxZM3p4VllYSGQ5NjVyamlx?=
 =?utf-8?B?SjFTUkFYQjVvWnhLeUFhMFNNZ2lrN0FsejFCSjhpZ0N6SVRCTUZoOWZ3dm9E?=
 =?utf-8?B?UmErMHlYWkJUaHFacUtJWlM1SWJvak9sZTd0Y0xLc21xbmc5ZVlYdmFwaEow?=
 =?utf-8?B?dkVKRWcxQWNITlFPQkFNM05vM0wwUFgwL0xQQ3NkSElCVUJ5SDNRK2ZTR2tz?=
 =?utf-8?B?ellLREpPY3dzQXhiQ2tmeFdzb1IzMkJqNm8xamxvandZNWV6Yk5PSFJJVkF2?=
 =?utf-8?B?YU5iVlF5cnJ5RGU4Zkc4TFNqZlQ2MEpQcm9OT1ZMUDY2RFA5K2p0eUpPbTRS?=
 =?utf-8?B?V1p5bFJLMHFLTVdWa2RDLzFkUHk5M1lmR0lCY2dWcXV4THVIb2o1aWxsVUhm?=
 =?utf-8?B?WWZ3a0FxT1BRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4719.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZFFCejEzdWR1dlFmdlg0M2hUTVUrcUpYN3BlZllIL0ZnUjhTTWJxN1drTVJo?=
 =?utf-8?B?dlhBTm5pdTRieTc5SWx4YkNXVnpLTkNrS1JOenVyOGk2RVQrSnVVQmxYT3Vx?=
 =?utf-8?B?Nkt5U1l3QSthMU1tanpLL1lxNVQyZzAyRWJVOG5KTTFTdnl3bTdGNUFaRVFk?=
 =?utf-8?B?RTZrNkFvTjJVZjMxNjJWNFJ3d2dHOUxETUpGcjFNbTdWWUl6K3Vhbm1FVlhG?=
 =?utf-8?B?ODVVZlovTnMvYlFTcVRNWCtSTVczRDJFZDN3K2c2VUtLUEpJbnk1S3Z2TW10?=
 =?utf-8?B?MkoxMUUzcSs2YlhoVVFhL083aVFseVFrOFR4WmlscEhxNXU3SWJhNXdZS094?=
 =?utf-8?B?a2hINlNmU2cxak9rRnRwYnBoOEN5OWlwMXR6NmtuQzdWTFFIWENWZXphUjlh?=
 =?utf-8?B?a1pMOFF1MW5SdEs3dWQyclRLQTVhZ2p1WWtTb1UwUFZLYWdxTjI5bHF5cmJD?=
 =?utf-8?B?VjlmNWlzaTYrVjdTNEJSSlArRklhTjliVk5nOHU3N3JDb3Qyc3lIbXVxMEVL?=
 =?utf-8?B?OHdBOWx1ZnZML3FOQTFVM1ZKNitOVHdiRnJISTcyVjVZQXB6QzFwWjBkVjVs?=
 =?utf-8?B?NnJEY2xFeWdRQ3RRNnR4c1FUNEg0M0J2V1hMRnRKcDJraEhEK3lLQ244aTdx?=
 =?utf-8?B?djNkUmN1NUJZR2V2NnB2VFU2K3JBTUsrWnlFSFBnbDlPcENVWStySEJpb01M?=
 =?utf-8?B?YmQ2a05zVkpMVWhUVy83cXpsRUZuTXFVWExTTGxuc2tOb2p0SG5Wc0xjL1Nv?=
 =?utf-8?B?UjBNUzZ4Ri9KRHNTdU9rSThmNk94NXc0bUozYnB6dVlQME9GMzRnaFgvTXNP?=
 =?utf-8?B?a1E2NXJQbVV4cHZ2VWpRZnhJUDBYcUNjaUMwT3d5c0x6dlJyT2Z6SFFvRU1k?=
 =?utf-8?B?TmxCaVV3UURBdHZYUFp3c3Nad2hzQTJONUtVcXhIekxvRk5RajVDdkRsMVBZ?=
 =?utf-8?B?N0prYmJFT0V4SXdaa3ZUL3AwM2c2QUUwWUx0V3k2OUhWdk5hZ3FGRFRZT0pQ?=
 =?utf-8?B?RFV2Q2Vjd0tGcTA1UitpUGNveE1BbDdUbVFwei93YS9kQ1QxNEdRMmV1c2tI?=
 =?utf-8?B?VmhYSHVKd2pWNVM1L25QeWJPaWNxL1B4ZXBJNFFERzFGUGdCSUR4V0l1OTNq?=
 =?utf-8?B?RVZabEFDOW8wUnB3VEJOVWhoNUI5a2NKNzJZNUFFdnJrYWxLdXJUbTZsK1Bs?=
 =?utf-8?B?cFZPZ0t3NU4yaDc5R0d2M29PSDNxd09xTTV6MTdBYTVMZ2FhRFhORmtKczQ2?=
 =?utf-8?B?T2pHSXdoQytNaUk3ZkdtTENDSjJvRFRNWDk1REhLUTJuVGRUSFQ1dnR1dlFu?=
 =?utf-8?B?VjZwb2FjVFZSVzZ1a2E5N0g3c3crRnV0bmFlUkd6TURiQ25iN1NLOUp0NE15?=
 =?utf-8?B?NUF3ZHZIOVV2SzVEVnJXb0FHdkZIYmNIQTZ5cDBPTk1vNURPWWdCdExsdUVh?=
 =?utf-8?B?L1ZTNjgvZTRkMjZxcjdyaHMxM2c4dnYrS2YrMTRZYWxpS1FkMjNpVy91aTIz?=
 =?utf-8?B?RWt5S2JYalVPZXcvU0krbFVrTk5oM283ZXQraCtmRzRkNHdxZHEyOExPeU1O?=
 =?utf-8?B?L1VOMTJpai93emwwMnkvblJoRXRLQmo5dElJSFYwK0hXU2xWUnExalVLRGZV?=
 =?utf-8?B?OE1wS3o0OTVFM0djYmZIZG96ZXNIZFN0aE44SUxRY2ZYRjVtdGs1QXhPQk9n?=
 =?utf-8?B?UzZsMGNwTzI1dm8reVh6aDVYQ29PR3RjZFJIMk81VU1HNGxXdi83OXN5Q3Fs?=
 =?utf-8?B?cVdWcTdRbEhsUGFXZ2x5Sk0wRitkRG9ISmpyMC9FSjNQY1R3ejl5Q1cya3ZF?=
 =?utf-8?B?M1ZOc3ViWmN1T3NzQS8yd1N5NmRkQk5CS25YelJqM2p6enFZNjBvRzFqQVJN?=
 =?utf-8?B?eXY5RWlWRU01bXFzQWRHYzZGZFBlNVlDRm9KajBTaDZZT2RPQjM2eGV3ZVRB?=
 =?utf-8?B?Q25XN2h5K0MrTlJGMGpHVC81WFRaN0d6VFZMdGtuMHpPMHBnNTYzaHNEbjEz?=
 =?utf-8?B?VkV2TTFvWGNFd3lVdTRFcHh6a3BXYWo2VXJBWll4ZTBxSy9oSFk2bUZDS3NF?=
 =?utf-8?B?R3BEMTdZbklTWTVCeTJsZWpjVTFKVnEwOFZ5bGZIMG8rbW1ycFhMMkpPOEYv?=
 =?utf-8?B?MHAwL2VyVVNDVzF0V0taNnAvR2VmYTNnNDNIU0RFdlpLanY3VHZlYUhnMFI5?=
 =?utf-8?B?cGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <92DF9E1C8DC7C84AAC074D9AABD9B9CC@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a32ccba0-3c32-48fc-4343-08dd5bc179c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2025 08:41:08.5984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tMfWEou6f0BX1rLsRZ4DWc/AbjTmHdT06mSmVULmIRoPPSrE7OU+J5BiUS6v69+R3XnQ3NLmrj0vNlUrTj0rw8MzJm0Gwzteh8kcsQPRqL9SPkHrdslSR2kRFUwSBIxR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6820

SGkgYWxsLA0KDQpUaGUgcGF0Y2hlcyBiZWxvdyBoYXZlIGJlZW4gbWlzc2VkIHRvIGJlIG1lcmdl
ZCBmcm9tIHNlcmllcy4gSSBoYXZlIHNlbnQgDQphIHJlbWluZGVyIGEgd2hpbGUgYmFjayBbMV0g
YW5kIFsyXS4gU2hvdWxkIEkgcmVzZW5kIHRoZSBwYXRjaGVzIHRvIGhhdmUgDQppdCBtZXJnZWQg
PyBQbGVhc2UgbGV0IG1lIGtub3cuDQoNClsxXSANCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xr
bWwvMjAyNDEwMTAxMjAzNDUuOTI4NDQtMS12YXJzaGluaS5yYWplbmRyYW5AbWljcm9jaGlwLmNv
bS8NCg0KWzJdIA0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC9jYWI0YWQ2OC1jZjNlLTQz
ODUtODcyMS04MzczNzJkZjJlMTJAbWljcm9jaGlwLmNvbS8NCg0KDQpPbiAxMC8xMC8yNCA1OjMx
IHBtLCBWYXJzaGluaSBSYWplbmRyYW4gd3JvdGU6DQo+IFZhcnNoaW5pIFJhamVuZHJhbiAoOSk6
DQo+ICAgIGR0LWJpbmRpbmdzOiBhdG1lbC1zc2M6IGFkZCBtaWNyb2NoaXAsc2FtOXg3LXNzYyA+
ICAgIGR0LWJpbmRpbmdzOiByZXNldDogYXRtZWwsYXQ5MXNhbTkyNjAtcmVzZXQ6IGFkZCBzYW05
eDcNCg0KDQotLSANClRoYW5rcyBhbmQgUmVnYXJkcywNClZhcnNoaW5pIFJhamVuZHJhbi4NCg0K

