Return-Path: <linux-pm+bounces-18428-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 377AF9E16CA
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 10:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE56E1622FB
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 09:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422C11DE4E5;
	Tue,  3 Dec 2024 09:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uclouvain.be header.i=@uclouvain.be header.b="UIdhyV8x"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2136.outbound.protection.outlook.com [40.107.21.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B041CD204;
	Tue,  3 Dec 2024 09:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733216985; cv=fail; b=sCYXT0ss2wiV5zYvMi8NKrkGR7hqbRsU4SsOGIRvRJG9TyoPGk+7cYRhyOF8ZlWtNgsUY8qyHuxki5wcKzzfzV/N+BBfvT4kVEMDNXqgZ4cLPcOUrYvZqMEw6Hso+r8ZA4XKlxmC2PhBJ4qFdJJSGk72cwMf59yLCAV1QbspyBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733216985; c=relaxed/simple;
	bh=Gp6VfUeq+LcjcLqLaaqagxwWc8KoL7gEqK1ODGWXs4A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cHp6MtD4WseOakCPyjT+2svpWQ8jZzYCuwCfSAigvMeDVGBx9BP/+Zu+noHg6OyYpPeaQm97IwqwQzkyINeUVN5jGLnnCWC+A83fWDuahyd+q8lri5NvZ2ngXjzFZeGqnONG498dKGgw+1u9qLCYIAnKAUHIRxu7S1LrjMAVIzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uclouvain.be; spf=pass smtp.mailfrom=uclouvain.be; dkim=pass (2048-bit key) header.d=uclouvain.be header.i=@uclouvain.be header.b=UIdhyV8x; arc=fail smtp.client-ip=40.107.21.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uclouvain.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uclouvain.be
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=evsE56DynzvfpvPib8pQgu6A9PyDke0FU18RPOKE7srn9efGbXRsoodlkEv3oAKyspMZqPIfkFJ1pV9Eb3lbLVERCMECDQehoGLgdVeDAKep077Hf5HzH/m7fA6OK7mbV2xPYadWlQOTnsLlDdZPhIsf4vgQ3u9+04ksDIHBlFWMYS2GEBh3xUaOeR/WKq7uvPUREaBApm0o4uaRQpjs8OYS6rqtS3sZrOR3qTjDpm5Gk/M4p3V1C3dJkvh7t1FWle3ehs13O7GtsfJEZp+RTqdfyvH/OuqqsRCR8hkJSIDg7L8Fs3buIimqxrJ6tCZiwdy5zPu5V9v8F933rmV03w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6XGfhlFoDY+MWRmLrWOEt+DCFy4InqaVqG92GtCOCfE=;
 b=LOg5pCjkuX0AdMjjCtrhniPP+dKCLIP2jyH0SCHi+P4fcSx8rmKHwhKfulZvGFc+7rPLAkwCw0B4/2RrBwapv7V7tppL4GsKPMejR2ICEuxfir72+F2hh40fDdGXtTWY2d6DalSeesWnjlTRZ7lrXpf8qDfE/OOJ14vLAmjm+rvmtfaYYM1AxK3AA34g7tS5GaERLCiadFLwtKpTXNxV3IgzbWISryy4ew01R/naMmuXOOX1+UMLeqJ1s1DL/W0HmDwqdim98w5JHDPPwSnhQdF5FvgVn/5ltSQniVOhN1yIYxPdDBT4RciHGFTWEMkGwKdGFllFzZGKLE9Yl8sxfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uclouvain.be; dmarc=pass action=none header.from=uclouvain.be;
 dkim=pass header.d=uclouvain.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uclouvain.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6XGfhlFoDY+MWRmLrWOEt+DCFy4InqaVqG92GtCOCfE=;
 b=UIdhyV8xmteJwRyoe/n/Ek7JM2f9eVAo0dCA8NaDkugIE1iTey5Fc1yn7NGfp8mUge2W9eTrhf/C7nbVkthM/ar+bK/KFsWHAXl3ZPWlMd2EPUj5lDa8FBLMtVuX203D+Yw44fvrVNM7GhnSBA/Eyk3dK/Q6jgOMrbw05iT6dYWDo2RQPNHLJVR2fhr8muv+qjcY2jU3Xqr0DROln8ZsLF3+tp1XCCW94HNRak6kQ1raQzv+EUu1NM+Qf5Ou9NqIuHLKQ+/gcRgIf4Q+Lzz9+J9N0hU0HXghT8J3yc7diVicH34ZZ87ananMnxVGOMW3SY9wAxuQRyBj0Xyc9FvN9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uclouvain.be;
Received: from AS8PR03MB9047.eurprd03.prod.outlook.com (2603:10a6:20b:5b6::13)
 by DU0PR03MB8265.eurprd03.prod.outlook.com (2603:10a6:10:31e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Tue, 3 Dec
 2024 09:09:37 +0000
Received: from AS8PR03MB9047.eurprd03.prod.outlook.com
 ([fe80::c90e:deef:6dcf:538c]) by AS8PR03MB9047.eurprd03.prod.outlook.com
 ([fe80::c90e:deef:6dcf:538c%6]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 09:09:37 +0000
Message-ID: <9387c0cf-d291-485a-8cd1-1aced7eba14e@uclouvain.be>
Date: Tue, 3 Dec 2024 10:08:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] power: supply: add support for max77759 fuel gauge
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org
References: <20241202-b4-gs101_max77759_fg-v1-0-98d2fa7bfe30@uclouvain.be>
 <20241202-b4-gs101_max77759_fg-v1-1-98d2fa7bfe30@uclouvain.be>
 <c377f3302c6c282ad826211c859e2b65bb1222cb.camel@linaro.org>
Content-Language: en-US
From: Thomas Antoine <t.antoine@uclouvain.be>
In-Reply-To: <c377f3302c6c282ad826211c859e2b65bb1222cb.camel@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR0P278CA0093.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::8) To AS8PR03MB9047.eurprd03.prod.outlook.com
 (2603:10a6:20b:5b6::13)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR03MB9047:EE_|DU0PR03MB8265:EE_
X-MS-Office365-Filtering-Correlation-Id: 9313a88a-ff57-44a3-7dc5-08dd137a3652
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VVl0RmZXc0tNaExhTWxPKzY5RjdSbkovMGpZTmRrRFBuS1JiYkZpMSthSUtT?=
 =?utf-8?B?NXJFeElXaUJiTnovUjNOVzVIT3BRd2RsL2RsSzgwZkZ3eHZTb21rMElvWndj?=
 =?utf-8?B?ZEVWNzFYV1dMaW80SlFVZ05ZTlN4d1RIb01kS0t4czRRbkFZQ1R6TzVueGFs?=
 =?utf-8?B?Y3lkQWtPOEJmWGhLeC9IMXhRLzE4eFU3M0docE1rN2k5NWNncTl5RlBvOHZr?=
 =?utf-8?B?aHcxZ25FWDVKam1CYXE4S3AwcWhid1Vka29IRGFrdUVuN0pVNnVGd01NYUZp?=
 =?utf-8?B?WklhLzZBSFNRRUlJU29QQjZWVFNCT0haSWhxWkRJUjBud2dKNUxuamNicXov?=
 =?utf-8?B?dDdoTmxTcDg2SjBjd1F5djNVbDNXdVBqWk81RHZoWDVmZjljbGllSSszV1JH?=
 =?utf-8?B?eHJpcmsya2srVGptODVuaFp4cFBLNCtKZ0RrTitWNjdYSXVDcytkcDZ3NEZO?=
 =?utf-8?B?bEZ2VmU4UitORGhlVzZLdnpoaURoSmVBblR6SDlGZ0daUlZoZkE5RldvRWhV?=
 =?utf-8?B?by80UEJSN2NvaTdsVGhPL1JDYkt5dzRGNFAxTWtiVlpPa2RCby92am5aZlJr?=
 =?utf-8?B?T1BQYU43TTd1Z3EzVTBEVU5qek5Sd2tWRmtpQzFFVXdVQnUrMGJ6Z29IUjRi?=
 =?utf-8?B?VzcvSnNNeFNFR1VLWisyZmlsZHljNWtrRHlHREpJbWNmRjczWllFWCt1a2VU?=
 =?utf-8?B?YTdzNzJFTmJNZXl5dlcxRzhhR21VU0cvTHNiakdEY1lPb2JDeE4xN2twQnBR?=
 =?utf-8?B?OVVPYXc0SG9JTE9nK0FBdUpWU21DYjBWdmYzSG5IaGxwWDBlOXlkNFZ2ZWtn?=
 =?utf-8?B?dU4wQWdydloxTHhRMCtmWHg4Z2IvRE5oMUQ1ZnZuZS8xTVp5ZFJyNElJYmRM?=
 =?utf-8?B?ZDJ2a3NIY2dYWVJmWi9qcXNGR1N0K2lqUEJobTBzaEdBbGhDTGd6V3JBQXUz?=
 =?utf-8?B?M1daTWV6bjdaSE5iWDJwbXFZaU9mRmZ0ZHB0TTJYa1Bzb1dDV285b3RBWDJ0?=
 =?utf-8?B?VzZnUXlpL0pkdDNSZytZL05lUThqbE9tclNpZ1JWRUxlM2gvWGtzZHpEbktw?=
 =?utf-8?B?V3lZaGpoZWRUNFNuVG4zZW9CUzRYSlhYWndtU3Y4SEhEZk9zVnpTd0ZnbGJl?=
 =?utf-8?B?dTVidU1lTmxUSWVlNVdGR3lzWFZxK2ZUaXY1OHRPVW5XQTNUQnNDNHJsZjR6?=
 =?utf-8?B?eUJGdmh2S1VnYTkyWExRSW54QjhpRE5HVmQ0OFZXcHZvWUYwcHgvMFEvanpn?=
 =?utf-8?B?K2R2S2daT2JlMklGNlZta3NIUVE5Y2dMOExRTkd4ZlJkakN6djhzazFYaDlU?=
 =?utf-8?B?Zm9DdWt5STBIRG1KakNVQnJaMGp3eU9JaVMzNmNvZVNoc040M1l2VUpLancx?=
 =?utf-8?B?ZytnVHIwRUE2K1FnMTRXRXUxTXdkOWFxY3M4Vnp2Mnk5UDBVWWJLU09XYVND?=
 =?utf-8?B?eGNQR2tKeTZLYXIrbnA4bm9lWVhQVVBjaVpCM08xTCtCRml6SnhDd3FmWklX?=
 =?utf-8?B?bFY2bEtHMmR2OWJSTGtYSW9kZ2VaeVVCV2lPVTVOQTNjUUNGTzR1SWVILy9K?=
 =?utf-8?B?M0EzTXZKMGd4amc2eXNmTjVRWUU4Y3NvYndKcnh2SkxqS1ZqU3ROY0dJc2tF?=
 =?utf-8?B?QXUrRjNXcDlZeTdrTUcvRTJyVDNqMDg5RWhTb3Z5LzkvSzBFS3pPOTl1akNl?=
 =?utf-8?B?TCtxTkJUNGF2SEFFc25oWm5JWlFWUXVCTk1SNjUyZjdYVWNIRFNJN0xnSElQ?=
 =?utf-8?B?U2Y5dVZ4MWpEK3R0R0RjWkhPcG0zV0h1ZFNzN0JKVitKMG9kdlJZVVcxMUZF?=
 =?utf-8?B?OUp3VTVuYVRvbFNna3NlY0M4K3Rnamg2N3ZDMU9jWmlpM2hnK3NrZFJVU0Fn?=
 =?utf-8?Q?j8/MxZgX9xutj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB9047.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3ZwMGtDd3RKRzhTdDZTNEp5QitBa0kyMUhPbW16ZG5GSUsrOHJtT2hRWnhv?=
 =?utf-8?B?dmpEYUY0a1BITUhDcnpQK3ArUXJGSVk2ZnpWaWdHcUlLUzRlUFhCcDdVamFF?=
 =?utf-8?B?R3RFZTJIYXpEM1RVdVhxejc0ZVJFMXBGM1VNWTZHKzUvOUJEbGZPeFd5YTFi?=
 =?utf-8?B?M0NJSncyc3NSR0RBK0IyWXZocDYzOWoweXdNMzM2b3A4empOWnJIalV0NXVX?=
 =?utf-8?B?d2FtcmpWTEtoc0wvSXdUeDlpc21MWndwVVFHdS90cENlV2pFeVB1M0d0d3JO?=
 =?utf-8?B?WjgrYURTN0Zmdy9CbVZFZ0dGZGJ6QTJya1o5YUZnY1pjdTIrclBuUlFUc3Ex?=
 =?utf-8?B?N25nWHJHS21OWTVwOUJjM3lyZkZnQThMMVY4NU9FZGZoNkNhd2NNbzZsZlpN?=
 =?utf-8?B?NmNPbytYa2dpUjdWd1RBUEtySDNkVW81cHNJa2xBZlVkdUplWnhOS1cvMXNr?=
 =?utf-8?B?MmROU3VEWWdOcFFhWFhSMnZrc0hkYTBRWGQxemFSSnUwUWRaQ1ZmOUxxaGhD?=
 =?utf-8?B?aGdLVjRCdjV6eGt6WU9KQ1g4ZklUV0JpZWNRNnZUR2xuWXRhR0h5UTlVTytn?=
 =?utf-8?B?RmlDaUdKdEpNRTVucXR2b2N3djZrdjd6cCtxTW1uMjFjYnlkWk8yR2M5cGNV?=
 =?utf-8?B?M2t2V1Q3OUtvV2NYQ2E5SmlYalJNV0dORVQ4UWdFNXRqa1ZMS0pnWTQ2Nnc2?=
 =?utf-8?B?Y0tuMTRTUEU1UHpVRkRMZ0hRZUxWMGViUncrRzdSY3FyaWZ3ZXBCZXJ3ekRY?=
 =?utf-8?B?bEZsakRLaGRUcVJjQWp6V00rR2IzbGtkSUQ3UktaSEViSmNrRCs1cG1Oc25n?=
 =?utf-8?B?WkkvN1dBSzFpclhydFlsSWlVK1JYWGp6d01qaW9wOTFOdWlyN1Z6VUFtcWFG?=
 =?utf-8?B?R0FGd2I1dUVPN1BiOWVmaTFGOWhzUlhPR3JQZkllOTUzdDFvZVhOeU5kM0oz?=
 =?utf-8?B?eWpLVG5WMDFyemI2QURYRVhCZVhWNWg3VGIwMkg3M3lPK2d1VXk5Z3UyZG0w?=
 =?utf-8?B?eVpWaWNOOVh2V0JFOVFHNmhwUTNXSS9vTjI0R2RMbGZ1OWlpSytHQ1VQM0FD?=
 =?utf-8?B?cndlMmRwd2pKT3RUcUw4S2tMZHU3djB0WTZ5NjVydU5RWXg2ck5pSDhQRkk4?=
 =?utf-8?B?KzF2eEJNdUwvMitDbVhtbDBIb0RKWGVDTjE4UmNUblNqc28zaXJyWmc3YTRO?=
 =?utf-8?B?blVTY0JMWWNGd0gxT25yNkhPUUdjdW5oQ0Z3MWFpM2lCczBTTmhMMXdYZHZY?=
 =?utf-8?B?MVZBT0V3NHprYWVQZHVDdHZ0d1RtY0w0SHNrSnBMa2xZYUlKNHpLZ1RmT2Za?=
 =?utf-8?B?MU5NMXZVVnRBVFdNc3l1bHNPRmt1aTlMa0hpTEJtMXNLUGZCTDdKaFM3NHMv?=
 =?utf-8?B?NkVMeUdDZ2psK3VZWFJkRjdRS3I4UWtFS09xaEwxQ0FJcHVLbGswVVJieHd4?=
 =?utf-8?B?c0ZacWpVb3ZiTUNmUHpTbzNaYVhzYVlEZ0dDbVIyOTNPWWV3ZitkWDgwWEtS?=
 =?utf-8?B?dTZDNG15a3ZMSFEzVUVQOFdhWmppTm9obEVrSnl5TlMwMExuU0JtSDdMWFNr?=
 =?utf-8?B?ZTRYYS9ubHN0VVVaVWpWTVBjM1B0d3ZWTkxzZUcvVVpvT2hJRElDS0xURWt0?=
 =?utf-8?B?U0RDa0lPMHZ0anpvZmNBZHRZSS8yRUpXc1l6ZVRPQkRrWmY0U2JWeFBKV2ox?=
 =?utf-8?B?cWxqU1BlUGlZOTZVb1BhSjJML2VqaS80dkFaUGt6VnN2d2ZCNzBOdFdscndz?=
 =?utf-8?B?YVExMXJhTDI1THFpalBsTFB5c0NpRStqSXFVRUZjb3pMeTdLNEhvS3EzK1Bl?=
 =?utf-8?B?WVVDallVcXhpMk15TWlmd3hJVHROTmd2SUF0OUFZS0NUUW9SQ0Jlak9COFcy?=
 =?utf-8?B?TEpVK0ZJWHhicHVUUm15Skd6TFFWeXozNTJYNkVRd1NLVS8vZUh2WGtHT0hy?=
 =?utf-8?B?NkxaYzdMME5JUDZad3dwNkJNaEZlUmtOd3FJTGJSYzEyMVd4b3Y5azgybWpa?=
 =?utf-8?B?RVJWUHM1eGttTHB6SlpPOFV1VDJhemQzdm90a3dEWjM4MFl2dTlZc0dwN3lR?=
 =?utf-8?B?TTU4dTVITy9SbDkzVUlsRWwwV202MHpOYlU1WEs3b3JKdllESmJta0kyRlJF?=
 =?utf-8?B?V1l3cU1DK2QvV1lXNmRWYnJJKzZCb1daUUxtT2pJZEcxNCt4anNnc0hDNy9t?=
 =?utf-8?Q?vPVNFOM/uG5c9grc2OTKtW0/Iyz3S0aU4y/PxM4V5NC8?=
X-OriginatorOrg: uclouvain.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 9313a88a-ff57-44a3-7dc5-08dd137a3652
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB9047.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 09:09:37.6496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ab090d4-fa2e-4ecf-bc7c-4127b4d582ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jv3psuhoEmEux0k+HCDjWANELoDfVkhOsrdfYXhJBM77CRG4YYEU65AMs9DprCEu2qaZ8EGJWhq4FR6F10g77A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB8265

On 12/3/24 07:47, André Draszik wrote:
> Hi Thomas,
> 
> Thanks for looking into this!

Hi,

With pleasure! This is my first time trying to contribute to the kernel
so sorry for any beginner mistakes I might do.
 
>> From: Thomas Antoine <t.antoine@uclouvain.be>
>>
>> The Maxim max77759 fuel gauge has the same interface as the Maxim max1720x
>> except for the non-volatile memory slave address which is not available.
> 
> It is not fully compatible, and it also has a lot more registers.
> 
> For example, the voltage now is not in register 0xda as this driver assumes.
> With these changes, POWER_SUPPLY_PROP_VOLTAGE_NOW just reads as 0. 0xda
> doesn't exist in max77759
> 
> I haven't compared in depth yet, though.

Is the voltage necessary for the driver? If so, we could just not
read the voltage. If it is necessary, I can try to kook into it and try
to find in which register it is located (if there is one).

>>  static const char *const max17205_model = "MAX17205";
>> +static const char *const max77759_model = "MAX77759";
>>
>>  struct max1720x_device_info {
>>       struct regmap *regmap;
>> @@ -54,6 +57,21 @@ struct max1720x_device_info {
>>       int rsense;
>>  };
>>
>> +struct chip_data {
>> +     u16 default_nrsense; /* in regs in 10^-5 */
>> +     u8 has_nvmem;
>> +};
>> +
>> +static const struct chip_data max1720x_data  = {
>> +     .default_nrsense = 1000,
>> +     .has_nvmem = 1,
>> +};
>> +
>> +static const struct chip_data max77759_data = {
>> +     .default_nrsense = 500,
>> +     .has_nvmem = 0,
>> +};
> 
> This should be made a required devicetree property instead, at least for
> max77759, as it's completely board dependent, 'shunt-resistor-micro-ohms'
> is widely used.
> 
> I also don't think there should be a default. The driver should just fail
> to probe if not specified in DT (for max77759).

I hesitated to do this but I didn't know what would be better. Will change
for v2.

>> +
>>  /*
>>   * Model Gauge M5 Algorithm output register
>>   * Volatile data (must not be cached)
>> @@ -369,6 +387,8 @@ static int max1720x_battery_get_property(struct
>> power_supply *psy,
>>                       val->strval = max17201_model;
>>               else if (reg_val == MAX172XX_DEV_NAME_TYPE_MAX17205)
>>                       val->strval = max17205_model;
>> +             else if (reg_val == MAX172XX_DEV_NAME_TYPE_MAX77759)
>> +                     val->strval = max77759_model;
>>               else
> 
> This is a 16 bit register, and while yes, MAX172XX_DEV_NAME_TYPE_MASK only
> cares about the bottom 4 bits, the register is described as 'Firmware
> Version Information'.
> 
> But maybe it's ok to do it like that, at least for now.

I thought this method would be ok as long as there is no collision on
values. I hesitated to change the model evaluation method based on chip
model, where the max77759 would thus have an hard-coded value and the
max1720x would still evaluate the register value. I did not do it because
it led to a lot more changes for no difference.

>> &max77759_data},
> 
> missing space before }

Will change for v2.

Best regards,
Thomas

