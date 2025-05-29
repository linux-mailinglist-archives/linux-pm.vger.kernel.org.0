Return-Path: <linux-pm+bounces-27803-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA22AC7B73
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 11:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28C90188F3AA
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 09:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2229220F5E;
	Thu, 29 May 2025 09:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MttcHiJ3"
X-Original-To: linux-pm@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010066.outbound.protection.outlook.com [52.101.84.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE4528DB5B
	for <linux-pm@vger.kernel.org>; Thu, 29 May 2025 09:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748512444; cv=fail; b=tS8jjY4hifFyR0IQF5tKZX217plivrUv814YM28ngIVMdNz9GV3kj5hOc4sx3I4/5zv5i/gVCezV8R8jT9L5+wcNpO9cRqPZDe6PYP4yTWoYZb3J109myryFQUrE+6mjcyU/WL/lLqCujT28uKopkzdTezlEw9Q3m3vSnpFtg4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748512444; c=relaxed/simple;
	bh=cCQ/MBQzSZAXudbh0lhoylRSyMGt137sVs3zPxUgoUI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kmz1Vq8hOxo7ynKbEK8dNHIuwzcRF0+MVXMWJ9rGc9BYlgYZUshe2YUqwrWT62hy16eX6c/XYsTS+0Lsu9UwMXq+wiReznPlMe7YA8wds57WlqfRHOCMgJp/7hqT+tMr7eal2CgUcKMUhYBNaD34EcViS0Ll1E0kBPyOvhIIpWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MttcHiJ3; arc=fail smtp.client-ip=52.101.84.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eh5f2zBPHqtmrR2lwflIi9+s/sU4+Hcp7B72SoRnkdAMn995x2JGFLKQPHTDeQDcruEbZULZw191RxUgycXcZ6XsSLKawy3mQcStwoPRag6cTe8ki3pznaz34fMUO2aRY/ddJ/65DT2JcDvJY9/crXjGv8MBhYVf1vCVcl2mf6vvOEHXvOQkwdNUuiId1GYQx9KXv6iZEzyYS54H3diotRQCWkjQNm7hcHMioH0WAqINbgB32cNXiUBuxUTH4WUPR1G2+UEZ/oALDRZqPS5ukQLVks+xG6F8aU7W6qqj63hNfp9ikiaVzA39U2iOYIvscAFS4X541YYFH1jHE40Rmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cCQ/MBQzSZAXudbh0lhoylRSyMGt137sVs3zPxUgoUI=;
 b=Jhi22tuI8zW4UR+X8JqSLcYZlQLcqLxSNPG2j/wFWJ6lv6A2WcTa8LY6f+exvGhYwSOigi1eWRC7PxnFL4Hx1tk3Iak6/VSMHIaWTsL7F1by55XvJwW+XRwPI89Fqz1ws25MkYTQOFx2Lyv+k7HMdBp08Yfdtuaih7Z+ZcvY1vvtunrDSsc9g8QabcXnkfc+h4zMcIIb1RRWE21ghwiQLTyguE4dc0OkWhyvSDoA7NEw3rBdiHzBk7viCFhlUBSYjg7exvcnm3Uij3JalHWrpuXm76DKlMBG2I8001uoXMtavBHGxhfqpuRv3sK+wVXOpI50hri5zHlSA/nqY5yS5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCQ/MBQzSZAXudbh0lhoylRSyMGt137sVs3zPxUgoUI=;
 b=MttcHiJ3WPg54Vb8GrLG+QlU8I/GlfVL5HoulomEcLCIbCjBqOiPIgbfU+Y8obJfSB+AFQBOJbizIR2YRhxrGYfWD7xBCPAN7Z/HAKmLRRFFNmsjMu+4xXO2c/2TxFxUVRqTzPIsMSNxW8VJbRrqKqgERtz1kOAblYeptajao2wMDQPqqZO5dk/a1sHprCWvX+fT15ClVuKgamNVrBOKaa1wb8gNDi7NbiVB96JQrOCFOm1vzFUm6pk7XGThmnjbPl2F6JYWjO1iAWNk8Usxq6okccA1O4bU/lq3aVpc1aOu/5MujP8xZdPljL8StnvNy3SR3BAWY60dS7LJsrSo+w==
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com (2603:10a6:20b:429::24)
 by DB9PR04MB9964.eurprd04.prod.outlook.com (2603:10a6:10:4c1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Thu, 29 May
 2025 09:53:58 +0000
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb]) by AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb%5]) with mapi id 15.20.8769.029; Thu, 29 May 2025
 09:53:58 +0000
From: Jacky Bai <ping.bai@nxp.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Aisheng Dong
	<aisheng.dong@nxp.com>
Subject: RE: cpufreq can't scaling frequency after cpu cooling event
Thread-Topic: cpufreq can't scaling frequency after cpu cooling event
Thread-Index: AdvQa6t4EAQe8cPfTYqUIZcN255IZQAEruGAAAAaMRA=
Date: Thu, 29 May 2025 09:53:58 +0000
Message-ID:
 <AS8PR04MB86424E152ED9F846E597E9E28766A@AS8PR04MB8642.eurprd04.prod.outlook.com>
References:
 <AS8PR04MB864266B4BF3B629C96464DC98766A@AS8PR04MB8642.eurprd04.prod.outlook.com>
 <CAJZ5v0hjenzF_8=vfbaE-HeVhyWA9Q608NAH0dcvA1t=RGHyeQ@mail.gmail.com>
In-Reply-To:
 <CAJZ5v0hjenzF_8=vfbaE-HeVhyWA9Q608NAH0dcvA1t=RGHyeQ@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8642:EE_|DB9PR04MB9964:EE_
x-ms-office365-filtering-correlation-id: 09ed6193-7bf5-40ce-c039-08dd9e96bb7f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aXVHUXhGWEhuSlhNN016c2lidFFqV2ZJb2YwWTZReWs0c21FbnhTVXBBa29K?=
 =?utf-8?B?UWRDNFRVbmxDOHd3NzBKNmptclduTjhPWnp1QWFEVE90V0hvSEpHOFQ1NjZh?=
 =?utf-8?B?QUVzK1JwQnVQckx1Tko2YnNhdlZQZVUvZ0I2b1hJMEdxSFp4VHkvVGExTm95?=
 =?utf-8?B?MWczR2NiTWtKdDdJTUlQT2hqK0hZSjN4aDRNaDlxM2ErOUtGMVM0WkMwR2tm?=
 =?utf-8?B?Z1poRTVDWlpldDdXMjJFUFAvaUZnS2ZicmNrOXhVL1UvdWxvNitpWlU5dWo4?=
 =?utf-8?B?TGpHU080SWEvelErcnN4U1BGMEpVdEl5OUtBbFFKQzZxRWVlQUx1cEVoVjhn?=
 =?utf-8?B?VWN3MHoxVWZZQUFSN1locWt3cHQwbVBRZVl3a2l3aThMdWJ3SzFZcFArdXdB?=
 =?utf-8?B?KzU2M3BTRDRRMjNZbWJ2a3BscGVweGFXTXJGK1FCMTI1RFZBVXI1NzI5M2Fw?=
 =?utf-8?B?RmRIc3ZFQ29Qc2s5NytjaTl4UFNSY1FLeW9HQ2h4UEJpMVczdmFNUkRpRjZM?=
 =?utf-8?B?a0hTbjJGaUJxS3V2aHVyY05HM24wWTBCdUlyZzE0Q2R0UjdiVEQvRFR2Yko4?=
 =?utf-8?B?VzJzcktpWGkyaTZET0toUmFza29zNHZITytyVmVmd1JFcFRKeFJKWDBWL3Yz?=
 =?utf-8?B?UXFQVWN3VGpwandTZmowQ2VSNmxGS05aZmg3Ri9lb0tsZlBlMEl4OTBibFV0?=
 =?utf-8?B?b1M3QnhYc3hWYnRtbEQ2RmdvRXFHK3ljME5XRGpTb0I5WkdjOThQSnl2Rkt5?=
 =?utf-8?B?Sm1VTTNTK1BYZjYzczZmcEZlbTZnWWJXOU83bFRHaUg1SkJsTDl2QmRIMTVn?=
 =?utf-8?B?SythK3NoTzZxMWlNaGMxZm1McUFHQ3JqKzFPZDlKSnBmSkVjTmViMFF3LzZt?=
 =?utf-8?B?dlp1cWtEY2VlMHZUVm4wcElPYXNSUUNpUkxEMmE4bDJtY21hWDFNaGFkNy9q?=
 =?utf-8?B?NjJJRGs4a1ppZVkxbnIxd295MmV5ODl5QzRrMUVVcVZ2NHJ3Z1M0cFFSNGZr?=
 =?utf-8?B?VzZIb1FxK1FTWFJIdktNeFVBVDJVeExDYm5ZZ3hBcWozUjU5NEpJYllDRDdn?=
 =?utf-8?B?Rkphc0pNdjVIZjdDWkNOa1c0a2tnRGRGdUlSbWpDa1F4SEprWXBZU01xNExD?=
 =?utf-8?B?Vkc2ZG8weXhGSjE2MVVZL2crdEYwQ2Ixa3JTRkdBSWhtcXJIdVNxQmhadGNP?=
 =?utf-8?B?MDNEOWRVUGtrd1p0TVRMZmNLRUpXcVA3dGErQjE2WStEZVdMYzlCazl2NlZj?=
 =?utf-8?B?NlE4T3Y4bnlza215blhYbkdIejRmSC9JSkgwa1lpaXZEeUkrQmZDTFgveGRl?=
 =?utf-8?B?SmtBQmlMSXQvYVZrOGEwaUNUSzhDMHVROUtFTkQ2eTA5NlViaFRYazdDdC92?=
 =?utf-8?B?VkVNcTJXc0Y4U2ZZV2dQNndoOEFiVFZiQ0RTbGY3R0EyeHlzZk1pZlF5Y3hE?=
 =?utf-8?B?ODQ0Q05jRTdjRll1MFBVMHl6UklOVTZHdXdQblBXWlk5bnZRa1I2ZTJGYnFT?=
 =?utf-8?B?MEFaY0FucDBjdElrV3Bubm5RTVY4cnJsZjBjRnNZdW5sdHpIYnFueUw1czlY?=
 =?utf-8?B?ZmNZZE1XOTIrUktyYm9QYjljWUFYNG0vaEtOaXJST09oOFhCeVpid2dSYWZo?=
 =?utf-8?B?cTg0d3dKZ3ExQ0Irb1ZWZERnZHlJTWV2ZUlyWERSZXU0c0JVRkYwQ2w3ZG5t?=
 =?utf-8?B?eDk0SG9SZUx4UlA1S0xaWWYvVFRFWUU5NWhMdUREMm1KVUNCWU5zVWtiT3Yv?=
 =?utf-8?B?STZJanNjM0hzc2UxYUcrMnVSWitBU2MzU3pVVkhtWUpFSnZ3VmJLY2I0SS9C?=
 =?utf-8?B?dzA0NnBRb05MblVpVi9HaGJBQUlBMWR4NG1TOGljOGdpTi9hV0xMVWVxZjBa?=
 =?utf-8?B?bm5XaUdBNTdPejFxeERvMkhOTUVNWW1qRzBCYlZLUk1kTVdjc2lPcEUyMC9k?=
 =?utf-8?B?RndoRzJ5dzRob0RaUEUrMnY0UUw2V3Iyb0RQN3d4NWJQZDFSMG5ybUI5TlFa?=
 =?utf-8?Q?QVbmJErB8ZL+GCf00urMXKO1TjAVXk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y0JPK1QwVWVvZ3ZYNlZ0dGFVTTJscHpJeXQ4ZGpXM1RuMEQzT0cwK3NBNVRs?=
 =?utf-8?B?K20xTlMyMFQ5NGk4eGpnNmlqb0phSVRRNmdsZlVSWmFTMGhoWFBzZU1lZ25H?=
 =?utf-8?B?Y0lPaVRQbDIzRFp5RTNWbndYK2xUSzVlNkx1TWZuUzJud01iaCtONDBrdHB6?=
 =?utf-8?B?NkorVi95YmU4Y3U5Qml6dndjdUxvL1piSVZhY2orZnVabi9hOGlUV3k1UkVD?=
 =?utf-8?B?dk9Lc1VQYXo0ajljdjkrZVRjejBEamNzb1pXUk5CRXBjZ0Z0L1J4UUhpOUVl?=
 =?utf-8?B?WE00TW1vUUlZcGQ0U1pwYVJwUXltTGVRVzB0WmJXaEU1bWRjd0NjZmV6eVhS?=
 =?utf-8?B?djA3bkx2ZFU5dkd1d2hIYm5SSnZUQlRJV0xIam5JN0lqNWs1Zmc4eENKNFh4?=
 =?utf-8?B?c3REU2RRa2FWQ2xqcUpEQ3ZFWlp6NE5GdzVISEgrbGZuNWJXOWtBVUlaT3ZB?=
 =?utf-8?B?KzFydUZYN2pML0tzSjBrOUNyVllxVEFXQ1JSQkNqK3JrbWRZMWpZK2YyUTc3?=
 =?utf-8?B?cTVPUG9EK2lCMGgvaHYxeHJkS3AvUUJ4aVYyUEEyT2Y4cWNNS2l4YjhscGMr?=
 =?utf-8?B?YTZRM01HMFBUc3psK1F3cnpWL0thRUlwTERpYUVLWXVveUNkZWJiL0swR0RX?=
 =?utf-8?B?blhkemptKy9QeVVTNU96SWRITFRDQjB5dTJWNmcxQ1VsY0NSeDVpeGhDWmdI?=
 =?utf-8?B?djR0L255c052NDQxS3ovYW5qQUtOckZmVDM1cUhEeEJ5K1lJdEZrSGFPdjVE?=
 =?utf-8?B?NDAwMUQxZjliWXcrTVIrNXZIaXc4b09tUHY1czN2b3RSV1VUelB6K1RKZ1Z5?=
 =?utf-8?B?cTNnTWNTU1l1U3FiR2E0YnhvNmlWR2h5TWZ0UXVUaVRYTnNneUtRVEpkaGlz?=
 =?utf-8?B?UE9oVWhVU3k3UU92dmJCemdsR3k2N0dRdGF3Y1ZraFA2elN6ZVlkR1pNL0F6?=
 =?utf-8?B?WVdtYWVTekV3UmpmVDBLeUJDZ2FyeHVXUnYrUGFKSGozS1dJYkxzWVhTZ2FG?=
 =?utf-8?B?Mk9wK1lsNkxURW14SWZEV1RxTHlPWXFOSFNtMENsMG44ajJQRWJsVmRqMWZa?=
 =?utf-8?B?R2I1TnRzZjJqUmllazhvaUx4bXlURVhqZlZ5YmIvZURORmVvajVBOE43cmlW?=
 =?utf-8?B?Ymw2SFRqY0F2V0FaMmdOM0RFU2tVbWZUUE9vVDBvNXhVZGFrbWR0MGdvU3hq?=
 =?utf-8?B?a2NDajRQS0dsU2RZRnlPcTgvS3p6WWg3aEdhMmNzV0tqQ2tLcnpmeUgzcFo0?=
 =?utf-8?B?UFJPTXowajBHUXhIVXNleGYzVyt6RHdaK2NYTmhVcEFmdEJCeit1emtleFQ2?=
 =?utf-8?B?dUc4aXFJYUIzYmRzaGVBZnpVWTJyL0RmbVRHaDJzRTBseU4yTERwTGE3TGdX?=
 =?utf-8?B?VC8yejU3UWFFUDdHakdlSU5YeDFYUnRhZzRKYm5JK0pURm1weFFSMGNtcDFi?=
 =?utf-8?B?a2ZDSFpCdm5xdDhQUXVUTHBwNWMyTmZXbDhhUmJ2UzZtYkw1djY5S3A0d2Zv?=
 =?utf-8?B?YUdhUUxUNnZza0pld3JjSE1LR29LZ2lyZTNWOTRmeDh4MTVvekZxUVlSUXBn?=
 =?utf-8?B?ZG5WNXVxUWgzdmxmMHFzWWtBdk41WE9qMnltekNFZEpMTENSYmZTYit5cEIv?=
 =?utf-8?B?NW5ycmhUYlRLUnRkL0tDQ1ZtNVVvSjJPVW1iVTc0VHc0M3NENUU2RlhkMWJZ?=
 =?utf-8?B?MEpsbkJ4NkdNUHViWllnK0lZS2lSNjVWQ054aytONzRzM09QK1hGSittR1BX?=
 =?utf-8?B?V0hkYkQzZDcyTWU5MFhwTUNzc2laRGF2QXV1MXpqVE5sQTVGWU4xTnMxSXl5?=
 =?utf-8?B?ZTVrNWErUm5DaVRhSXRpdTJLdHF2MFE4Z25kSkRDY3pEZGRxL3l4TlRTTkZL?=
 =?utf-8?B?UDk0dXlpelcwd0NPaFhiZXAxbFFabUdzdjdsOERKTDJ0QmVRL0VEalVCejFE?=
 =?utf-8?B?REZaSUloalpwaEZCVGY4dmZUN3llRExNRkw2QnlUak9UaDN5d09CS29UK3A1?=
 =?utf-8?B?MGo5b3lNMEY4VmlKSTR1Qm9TKzNsaG10Y2FITnRLTTNhM0Q4ZDNtcU9XMXd4?=
 =?utf-8?B?NlNaNVdjMGFpTFhReWd1YWRtUmZiVzQyV3JGSVFvTEREL2dIUTRqd050ZjNq?=
 =?utf-8?Q?W7q4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 09ed6193-7bf5-40ce-c039-08dd9e96bb7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2025 09:53:58.4148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f9axef9ozZKGWPW+iPNsg/Z6NS8V+1P6rpL39zaetoC2SOSGcJy7PirZ+xv6FLNVcWA0b7bAaiXx+CFedkeX6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9964

SGkgUmFmYWVsLA0KDQo+IFN1YmplY3Q6IFJlOiBjcHVmcmVxIGNhbid0IHNjYWxpbmcgZnJlcXVl
bmN5IGFmdGVyIGNwdSBjb29saW5nIGV2ZW50DQo+IA0KPiBIaSwNCj4gDQo+IE9uIFRodSwgTWF5
IDI5LCAyMDI1IGF0IDk6NDPigK9BTSBKYWNreSBCYWkgPHBpbmcuYmFpQG54cC5jb20+IHdyb3Rl
Og0KPiA+DQo+ID4gSGkgUmFmYWVsLA0KPiA+DQo+ID4gSW4gdGhlIGxhdGVzdCBrZXJuZWwsIEkg
c2F3IGJlbG93IHBhdGNoIHdhcyBhZGRlZCBpbiBjcHVmcmVxIHN1YnN5c3RlbS4NCj4gPg0KPiA+
IGNvbW1pdCA0Zjc1MWYyNWFiODkyODEwOTY4Y2VkNWMxMGZhMTkzZGQxNmM0YzZkDQo+ID4gQXV0
aG9yOiBSYWZhZWwgSi4gV3lzb2NraSBtYWlsdG86cmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb20N
Cj4gPiBEYXRlOiAgIFdlZCBBcHIgMTYgMTY6MTI6MzcgMjAyNSArMDIwMA0KPiA+DQo+ID4gICAg
IGNwdWZyZXE6IEF2b2lkIHVzaW5nIGluY29uc2lzdGVudCBwb2xpY3ktPm1pbiBhbmQgcG9saWN5
LT5tYXgNCj4gPg0KPiA+ICAgICBTaW5jZSBjcHVmcmVxX2RyaXZlcl9yZXNvbHZlX2ZyZXEoKSBj
YW4gcnVuIGluIHBhcmFsbGVsIHdpdGgNCj4gPiAgICAgY3B1ZnJlcV9zZXRfcG9saWN5KCkgYW5k
IHRoZXJlIGlzIG5vIHN5bmNocm9uaXphdGlvbiBiZXR3ZWVuIHRoZW0sDQo+ID4gICAgIHRoZSBm
b3JtZXIgbWF5IGFjY2VzcyBwb2xpY3ktPm1pbiBhbmQgcG9saWN5LT5tYXggd2hpbGUgdGhlIGxh
dHRlcg0KPiA+ICAgICBpcyB1cGRhdGluZyB0aGVtIGFuZCBpdCBtYXkgc2VlIGludGVybWVkaWF0
ZSB2YWx1ZXMgb2YgdGhlbSBkdWUNCj4gPiAgICAgdG8gdGhlIHdheSB0aGUgdXBkYXRlIGlzIGNh
cnJpZWQgb3V0LiAgQWxzbyB0aGUgY29tcGlsZXIgaXMgZnJlZQ0KPiA+ICAgICB0byBhcHBseSBh
bnkgb3B0aW1pemF0aW9ucyBpdCB3YW50cyBib3RoIHRvIHRoZSBzdG9yZXMgaW4NCj4gPiAgICAg
Y3B1ZnJlcV9zZXRfcG9saWN5KCkgYW5kIHRvIHRoZSBsb2FkcyBpbiBjcHVmcmVxX2RyaXZlcl9y
ZXNvbHZlX2ZyZXEoKQ0KPiA+ICAgICB3aGljaCBtYXkgcmVzdWx0IGluIGFkZGl0aW9uYWwgaW5j
b25zaXN0ZW5jaWVzLg0KPiA+IC4uLg0KPiA+DQo+ID4gV2l0aCB0aG9zZSBjaGFuZ2VzLCB0aGUg
Y3B1ZnJlcSBjYW4ndCBzY2FsaW5nIHRoZSBjcHUgZnJlcXVlbmN5DQo+ID4gYW55bW9yZSBhZnRl
ciBjcHUgY29vbGluZyBldmVudC4gVGhlIHJvb3QgY2F1c2Ugb2YgdGhpcyBpc3N1ZSBpcyB0aGF0
DQo+ID4gYmVsb3cgJ1dSSVRFX09OQ0UnIGNoYW5nZXMgbWF5IGhhdmUgc29tZSBwb3RlbnRpYWwg
aXNzdWUuIFdoZW4gdGhlIENQVQ0KPiA+IHRlbXBlcmF0dXJlIGlzIGhpZ2hlciB0aGFuIHRoZXJt
YWwgcGFzc2l2ZSBjb29saW5nIHRocmVzaG9sZCwgdGhlIHRoZXJtYWwNCj4gZnJhbWV3b3JrIHdp
bGwgdHJpZ2dlciBjcHUgY29vbGluZyB0byBsaW1pdCB0aGUgY3B1ZnJlcSBwb2xpY3ktPm1heC4N
Cj4gPiBGb3IgZXhhbXBsZSwgaWYgdGhlIENQVSBzdXBwb3J0cyB0aHJlZSBzZXRwb2ludDogMS4y
R0h6LCAxLjRHSHosIGFuZA0KPiA+IDEuNkdIei4gVGhlIHBvbGljeS0+bWF4IHdpbGwgYmUgbGlt
aXRlZCB0byAxLjJHSHogaWYgdGhlIHRlbXBlcmF0dXJlDQo+ID4gY29udGludW91c2x5IGluY3Jl
YXNpbmcgYW5kIGhpZ2hlciB0aGFuIHRoZSBwYXNzaXZlIGNvb2xpbmcgdGhyZXNob2xkLg0KPiA+
IFRoZW4gaWYgdGhlIENQVSB0ZW1wZXJhdHVyZSBkZWNyZWFzZSBhbmQgbG93ZXIgdGhhbiB0aGUg
dGhyZXNob2xkLCB0aGUgY3B1DQo+IGNvb2xpbmcgd2lsbCBiZSBjYW5jZWxlZCwgdGhlIHBvbGlj
eS0+bWF4IG5lZWQgdG8gc2V0IGJhY2sgdG8gaGlnaCBmcmVxdWVuY3kuDQo+ID4NCj4gPiBCdXQg
d2l0aCBiZWxvdyBXUklURV9PTkNFIGNoYW5nZXMsIGlmIHRoZSBwb2xpY3ktPm1heD0xLjJHSHos
IHRoZQ0KPiA+IG5ld19kYXRhLm1heCBpcyAxLjZHSHogb3IgMS44R0h6LCBUaGVfX3Jlc29sdmVf
ZnJlcSByZXR1cm4gdmFsdWUgaXMNCj4gPiAxLjJHSHogYWxsIHRoZSB0aW1lLCB0aGUgcG9saWN5
LT5tYXggd2lsbCBiZSBmaXhlZCBhdCAxLjJHSHogZm9yZXZlciBldmVuIHRoZQ0KPiBuZXdfZGF0
YS5tYXggaGFzIGEgdmFsdWUgbGFyZ2UgdGhhbiBjdXJyZW50IHBvbGljeS0+bWF4Lg0KPiA+DQo+
ID4gc3RhdGljIGludCBjcHVmcmVxX3NldF9wb2xpY3koc3RydWN0IGNwdWZyZXFfcG9saWN5ICpw
b2xpY3ksDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgwqZzdHJ1Y3QgY3B1ZnJl
cV9nb3Zlcm5vciAqbmV3X2dvdiwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICDC
pnVuc2lnbmVkIGludCBuZXdfcG9sKSB7IC4uLg0KPiA+ICAgICAgICAgIC8qDQo+ID4gICAgICAg
ICAgICogUmVzb2x2ZSBwb2xpY3kgbWluL21heCB0byBhdmFpbGFibGUgZnJlcXVlbmNpZXMuIEl0
IGVuc3VyZXMNCj4gPiAgICAgICAgICAgKiBubyBmcmVxdWVuY3kgcmVzb2x1dGlvbiB3aWxsIG5l
aXRoZXIgb3ZlcnNob290IHRoZSByZXF1ZXN0ZWQNCj4gbWF4aW11bQ0KPiA+ICAgICAgICAgICAq
IG5vciB1bmRlcnNob290IHRoZSByZXF1ZXN0ZWQgbWluaW11bS4NCj4gPiAgICAgICAgICAgKg0K
PiA+ICAgICAgICAgICAqIEF2b2lkIHN0b3JpbmcgaW50ZXJtZWRpYXRlIHZhbHVlcyBpbiBwb2xp
Y3ktPm1heCBvciBwb2xpY3ktPm1pbg0KPiBhbmQNCj4gPiAgICAgICAgICAgKiBjb21waWxlciBv
cHRpbWl6YXRpb25zIGFyb3VuZCB0aGVtIGJlY2F1c2UgdGhleSBtYXkgYmUNCj4gYWNjZXNzZWQN
Cj4gPiAgICAgICAgICAgKiBjb25jdXJyZW50bHkgYnkgY3B1ZnJlcV9kcml2ZXJfcmVzb2x2ZV9m
cmVxKCkgZHVyaW5nIHRoZQ0KPiB1cGRhdGUuDQo+ID4gICAgICAgICAgICovDQo+ID4gICAgICAg
ICAgV1JJVEVfT05DRShwb2xpY3ktPm1heCwgX19yZXNvbHZlX2ZyZXEocG9saWN5LCBuZXdfZGF0
YS5tYXgsDQo+ID4gQ1BVRlJFUV9SRUxBVElPTl9IKSk7DQo+IA0KPiBUaGlzIGlzIG5vdCBob3cg
dGhlIGNvZGUgbG9va3MgY3VycmVudGx5IGluIHRoZSBtYWlubGluZSB0aG91Z2guDQo+IA0KPiA+
IC4uLg0KPiA+IH0NCj4gPg0KPiA+IFBsZWFzZSBoZWxwIGNoZWNrIGl0IG9yIHN1Z2dlc3QgaG93
IHRvIGZpeCBpdC4NCj4gDQo+IFNlZSBjb21taXQgYjc5MDI4MDM5ZjQ0ICgiY3B1ZnJlcTogRml4
IHNldHRpbmcgcG9saWN5IGxpbWl0cyB3aGVuIGZyZXF1ZW5jeQ0KPiB0YWJsZXMgYXJlIHVzZWQi
KS4NCj4gDQoNClNvcnJ5LCBJIG1pc3NlZCB0aGUgYWJvdmUgcGF0Y2ggaW4gbXkgbG9jYWwgdHJl
ZS4gVGhhbmsgeW91IF5fXg0KDQpCUg0KSmFja3kgQmFpDQo+IE9yIGlzIHRoZXJlIGFueXRoaW5n
IHN0aWxsIG1pc3Npbmc/DQo=

