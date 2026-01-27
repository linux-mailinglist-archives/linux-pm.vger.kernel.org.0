Return-Path: <linux-pm+bounces-41530-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oG+aN3GveGlasAEAu9opvQ
	(envelope-from <linux-pm+bounces-41530-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 13:28:33 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBE39455A
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 13:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E56F6306998A
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 12:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4663134CFD4;
	Tue, 27 Jan 2026 12:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uclouvain.be header.i=@uclouvain.be header.b="nVhjSD00"
X-Original-To: linux-pm@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023087.outbound.protection.outlook.com [52.101.83.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11BE34CFD1;
	Tue, 27 Jan 2026 12:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769516619; cv=fail; b=F4mKg3uxQI8pry/xd8Jn+pERl+UxANXbAqoeadfOS8tcgSwfSZpKAX8m/EBxiZBrYYBJ8Dwfd2au5aCs3JHh2Wkae5UWXJaMyDD0Yyct0ihCu8HIRHIAWz4lcGcHgQoaE5pzIoVVTyOS9HtpAJOymn5D5CpuuiaabER7IlvNk+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769516619; c=relaxed/simple;
	bh=3Y3jWLTIKTDdo1rZhDyhOKBmN4j+Mue3ssIjD3GIwBM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=by22legAwtT/uejTd7K7oK0Jtxuqq3QvNmheHE9wryt24ccQlWReKkriiGxhK8QWaw6j3KJki/u7VdWeuMX9I9OsZppOLkbKNpJpoIXMIkj3m+r5JEV/4jhD9Xhl/qB5i9VKogfiYXh3MKFPCL4Y3pohhYm3nzZZI9+RNYGMYk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uclouvain.be; spf=pass smtp.mailfrom=uclouvain.be; dkim=pass (2048-bit key) header.d=uclouvain.be header.i=@uclouvain.be header.b=nVhjSD00; arc=fail smtp.client-ip=52.101.83.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uclouvain.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uclouvain.be
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=buaBXdZht1ZhyoRZ6BHWo0WkAQn6rwAPQl34mYOAWEGS1My+IHCAUCZBgaXVz0J9XZG+7EoJ2+bRDDd/2oleBf0u+1wMKSQnTXL7HJrlP9BAAdPqGaQzdpHvAnhMYacLNeibGy/ONWpVtv807E/yr1Yqq14JZFOpUG0mATqrdj8TGyz8hjhmicSK9Qn1l2qzMtlFDPZyDxixGomhF7tBrbLWJ1hLzlNCa08cQOwBoiiy40U7LSYwqhvPR+fDx4PEwLRUE2KT5wtOWnz2OyQTtyfnnfTagNPvW/8nIaGECCDmGW5iB2ALRygc0g4yVvC0IJz2kuqz4IT0878Ra1u7sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AndBSqJ33UEJIoSHDweS8siZBspUL2S2F+qTcib0zDg=;
 b=imtsJ6wU5ypvIagsW/2tNiz0aVXxLGXPYtoein8rKpsVjxC/NPS9v8QLFs8cXyyO9E3s9Pm9/w9kKq2qiYAxiMsFIqJpHRzK4MRErX8huol1Q3Ysr87KlNNr/r/DFrwXxlZwSIUyfFJqFDlmHFodasinTFsrfmX3IfeN7UqdPIcM+njKF1Cnimn6G4dsrWekzM8GFsLdfEYJkFO1T6sLVby1SNKKGL2I/Smy3nW7qhtVPzlJD2Ujn9tFFgu7rpdfO5RXpYL8qG35+w2iLr919HOchjE8aagXwG0LMlWcAjk0k0sINE8iKrXPLPRFxF0QD3Vt4sIarBrint367XPXmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uclouvain.be; dmarc=pass action=none header.from=uclouvain.be;
 dkim=pass header.d=uclouvain.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uclouvain.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AndBSqJ33UEJIoSHDweS8siZBspUL2S2F+qTcib0zDg=;
 b=nVhjSD00i6o8hjnsqgB2U9piI48A1OEky5SC+aFdkT6/vicvWKLLhPY5a/Wt0UMGJDsbf7sllSYg1AE+Q8ck7bQpezKblJhiyP9MdeQ8+kE5FyLGpUbsoJ0DZ0/k87mXoDQj00bH2lwLsDL1UocedF+RsC0nBUH2QvpSfLN3MqlXCy9Hkvg/cYr3UfshgAJFXhPpb9KaUG6KKDzKlpybLiA+7SfdrH0IY1M4KinqzXEMmNRpjPzxZQQLfIKNgt5h5oPKpuIws9qJ59iczGYCfd7XIkTwNTV3JT+nDuk2PLru7SHkAN1OeKr8hQCz4Ank1tYFQDAHq7HIhZ1+40TY0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uclouvain.be;
Received: from GVXSPRMB0158.eurprd03.prod.outlook.com (2603:10a6:150:322::6)
 by DU0PR03MB8217.eurprd03.prod.outlook.com (2603:10a6:10:312::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Tue, 27 Jan
 2026 12:23:31 +0000
Received: from GVXSPRMB0158.eurprd03.prod.outlook.com
 ([fe80::ee66:c518:bc2d:2173]) by GVXSPRMB0158.eurprd03.prod.outlook.com
 ([fe80::ee66:c518:bc2d:2173%3]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 12:23:31 +0000
Message-ID: <837005c7-63e2-4d38-a8c6-d4acb8310ea7@uclouvain.be>
Date: Tue, 27 Jan 2026 13:22:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] dt-bindings: power: supply: add support for
 MAX77759 fuel gauge
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Peter Griffin <peter.griffin@linaro.org>,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20250915-b4-gs101_max77759_fg-v6-0-31d08581500f@uclouvain.be>
 <20250915-b4-gs101_max77759_fg-v6-2-31d08581500f@uclouvain.be>
 <20250915-presoak-answering-2df6fca532ad@spud>
 <c5f2e6e8-2ada-476a-8557-85273b9a93b7@uclouvain.be>
 <a55d7e6e6d9515293ca735f25ffd5c925a6ec617.camel@linaro.org>
 <65xrumpt7ug5mqd7mkcknwyqmljrn4sofrqymg46bwvcmjoarr@wmt5fhsj3viz>
Content-Language: en-US
From: Thomas Antoine <t.antoine@uclouvain.be>
In-Reply-To: <65xrumpt7ug5mqd7mkcknwyqmljrn4sofrqymg46bwvcmjoarr@wmt5fhsj3viz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR1P264CA0047.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cb::8) To GVXSPRMB0158.eurprd03.prod.outlook.com
 (2603:10a6:150:322::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXSPRMB0158:EE_|DU0PR03MB8217:EE_
X-MS-Office365-Filtering-Correlation-Id: 15fd52eb-2451-43b1-47ac-08de5d9ee1b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|786006|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WGtHTDRNLzhhNEg2VkI2TEliSEFERThDeU9SRGRQUzZBRXI2elc0dU9FUTY1?=
 =?utf-8?B?bTdMZGRTV0lPNjdCbktKNFpNZTh2SlBNUGZ1dXpjbFc2Q0Q3NzFWQlp5eXNQ?=
 =?utf-8?B?aXRBNkdwNklEN3poKzFxT1pFTHdqMFlMQzlIUlRGT2RmdVBxZVhNanZsRHhL?=
 =?utf-8?B?REpyV1piajRrbEt2TWJBWWIwVHhhTHYyY2piTTdMa21MaU4zRDkvb0xMZ2dC?=
 =?utf-8?B?Z0tNREpFbTlyNmJLVXJnaVVmcGlsSzJQM0R5Z2JiSHd0aHVtaVArbnFjSndi?=
 =?utf-8?B?M2NaZVAzNEpVd0lqd1Q5SmRrTll6S1c3ZUZkcUN0SlJ5WnpVR3Y4Y0xiMGZO?=
 =?utf-8?B?TEZLOGtaUktCcTZhZkNta0RydTRrYmluUy9WejNmN3FzczZYM3VpeWYyaiti?=
 =?utf-8?B?YUw1S0pYeTNPQ0FpbEhyMVVaRy9CczEyU0QyTm9pRWVjMGZacVZKZyt4TFRW?=
 =?utf-8?B?cHp5dlRCOWlwZUhUOTBmeFRCNW5haTVWR2Z6TDlEVitQKzNWY3VxbkNCbzlM?=
 =?utf-8?B?dEQyTG44VVpualpZMTRDaW5nSmlNMG15clFQanlnMEFnTWJjU1NOaU5Cdi9r?=
 =?utf-8?B?eEpJczYwZlhYemRYQXkxV2l5Q2FHYUsvaHJpNlQ5L2syci9lMGNjeTVwdkI1?=
 =?utf-8?B?Z1pXa0Roblg5dVZiYUVsVkVza0dQbjBkVFRNNnhjUHVvSkhXNWZXcm5CeHpZ?=
 =?utf-8?B?TEpBK0Mwbldybmt5c1Z4eFlVUW00T2Fra2hOc3paaE8vanAzSzFkTGlSdUV0?=
 =?utf-8?B?cFBsTzIrZ05MdVpueHJDUWN2eFFlZlRWYjJuc0x1WVVFdUUwbDBDVUJQb05j?=
 =?utf-8?B?L3lzNlJ6ZU1oTjExc09sT1p3SWs4MXc1ci9IYmxOOS9VUEUwazdFb3YzWDNm?=
 =?utf-8?B?amN5dGVud1JsWHRkdGtjaTcvREJxelJySkdQSzROWnNuaXo0V2V3d0xEdzZX?=
 =?utf-8?B?K2l0VmVDdm1peXVLN1BvN00yd1VmZXJjS3VlV3BTVUl2N1dHN2JTa1FLQVZI?=
 =?utf-8?B?cTJ0WnIrM1RDYmVyRUkyQ2duNk40OEt4ZFA5MDlYcWYxcE5BR0g0WUIzcmJ3?=
 =?utf-8?B?bVdUSWEwMVVXL2RkdURpVndENmpWV0FGaVNoTndnQXFLSys1YWtpeGttQW9L?=
 =?utf-8?B?cnU2NVVnbHlacHhnU3orelRYQVJDQTJCQ3NVQWd2clphbitIZ1RTYjRRU2Ny?=
 =?utf-8?B?OGlOM3ExN09uamZpUUhiRkVJZ2ZtQ1VMYllObHFiak1vRFRtSGY4K3I0NHFH?=
 =?utf-8?B?b1MwTHV0enNVZ3h1NnB3RkxhU0IzRURHSnFFaXFvREVTSi9QU0hrajIzaXJO?=
 =?utf-8?B?ZlRpaDNhSFZCaDRIdVZaWWN3RGFJVGpaR1orcXQxYmsveVl5U21GYVVFY2Mx?=
 =?utf-8?B?NjM0U0Z6ZzU3YzJqTWt1RE5FZVArNHZ5ZUo2Nnpkc0hUUXBxTFdEc3FJd2Nl?=
 =?utf-8?B?NkFWSncvZnhtQzJ4b1cycnJJWDZTRFIzaUs0Q0FDOTN3WnFVbDQxQXdKZjhx?=
 =?utf-8?B?TDFyaDlPbW1RNVpWWlkyOVlTa0txMy9jSUEwbHY4aTNnS0hTQlk5V3J0dCtN?=
 =?utf-8?B?S2hzS0ZvQVJBUDExNXU0bkxvSlJwU2Z6OXBlMERick9wemJyenNVYTVSWDJ3?=
 =?utf-8?B?cU9nWElib05FczJXemZBRUZwSXFuK1N3ZU8xNnYvdlRRdFdpVzNqQkVhdUhw?=
 =?utf-8?B?ZVZpckY1dmRaZVhqVkUzaG9vNjZMTzNXbXNITHo5MHlXSWYrTHFMdzNvNVpN?=
 =?utf-8?B?Nkk1disvQ08xZ29SZzJIbmJkdTNEcTZ0RTV2U0RnMVlCQkJDMkxLakdMWTcr?=
 =?utf-8?B?NFdZTFltRjF6OHExUjVFMFNYNXlQOHpKSnIxaWFaTnp4MnlBemlSNkpOVTZ6?=
 =?utf-8?B?V05zRlpUdFExaU9mOWd2MVA2aVRmUzlMeDdwNHZ0U2Y2ckZabExwMm5VVTM0?=
 =?utf-8?B?YlRUMkNKWk9hU25Fd2Q3a3c0Qm5GdnAwS2tsMTVxMlNCejltV0ZDTjNNQkZy?=
 =?utf-8?B?Tm5TSW1iVC8zdnd4TkFtelBJQzRWb0VQYm9LRW91ZEVsaGpvZmRzRXRBS2JL?=
 =?utf-8?Q?jCTtA8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXSPRMB0158.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(786006)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGRGQUdoUDVWTmhadC9ySzBkT3QrUDRtM01NU0k3VUJXRWJGekZsWXYwdUdI?=
 =?utf-8?B?MUVOS000aGk3eHFXSUJtS1dBZTJFVVlBV2pmZWlKWHJERnBiRTIwd3VUcmE2?=
 =?utf-8?B?YUc5VWdzc09DVXA4MWN0Z2wxTFdTQWNDSkllU1ZSVWxjTklMZUdvdzNJNlZM?=
 =?utf-8?B?MmFkeUpLdjdlOXl4WmFKWm5Pb0N4UjUrT3RxU2swNEFwZlhra1lqei9xR0tW?=
 =?utf-8?B?a0ZDVGNGWFNmT2ZMb0R4bk1YVW1mUVZnSEtIR2xOZGNFRENjTWVBTFE5ZzlN?=
 =?utf-8?B?OHNkSDlENC9BMldOb3AzY2lpQjJ4enozYzJWS2FsYVY4TXVNOFlibGhSeGlz?=
 =?utf-8?B?dlRZdjdQT2d1Y25TSmk3b21sS0x6NkNWSFpjSlFzaURYNW9RRU1pbHhjV1U1?=
 =?utf-8?B?QkQxQXU2OHJHL3F6azNtaGlIY2dTOEExR1NCU3JOb3RBUHI1ZjdPdklKMDd6?=
 =?utf-8?B?TlQyN1hhbXlzcnBJb2Z6T243c3NWMVFkUXI1enZheDJvcytaY1BpY1MvQXh4?=
 =?utf-8?B?NzZ2T1h3dEUxRGIzaEZIM3JMMFdmOVU4blU2V1hJM2Z0WDBXbTM5RERPRWRE?=
 =?utf-8?B?SUszcWxYYU1ITXg5L0FONURlYTdxUEVhM2xuV0l6M1Y4YnUzUUg1TGluU0g1?=
 =?utf-8?B?TnlVYjVyVFpqM2ZEK3A2dDNxM25JL3I2cHRzYnFjUFNIT0JLOURXakpDa2xL?=
 =?utf-8?B?WDF3VWVpZUhkNnNENFlrYXVNc25PeTQwbk9PUHNUWmszVHZqSE9hdStmTDRn?=
 =?utf-8?B?SEdzN0I0UHJKUk02THBGYzA5a2xiN3NYSzhnOTR5TXR5YWhqaWRFL0RxNXhQ?=
 =?utf-8?B?dzE0a3NyK1ZMRThoMjQyMmkxTkRQR1BWOC80SzR1dnFuY1ZiNFpPV3hDWjBW?=
 =?utf-8?B?T1RkYTczZWp6YzRzZTFMN1p3aVFLMEVkMlJTKy8xN09LQjk3L1o0SU43VUo2?=
 =?utf-8?B?YmZ5dlVEbHBVS2FUM0ZiSnd2Rm9iRGdhTC9wZllPblZ4OWRuZ1B5TUNEd0Va?=
 =?utf-8?B?R3k1dUxDSVdYQTE2SXJydExWVGRTc2I5NkI5T1FGNHY2WDFBUUVJY2tQTmda?=
 =?utf-8?B?WnFqMjY2cm80Y1U2RHZBWmVnVzY4eTlTbi90YjJXT1ZDdC8xQVRuS1NoeThC?=
 =?utf-8?B?eFI1MExFRjU0Y0ZReW50eWdvczllb1dMMzBQRG5IdWhGWHFTWTdpdGZ4Z05K?=
 =?utf-8?B?ZG0vNnZDS0plcFFuR0JPdENiL1U5UVBzdmY2UlVjV1dWdG10eGpTWXpGZ3dF?=
 =?utf-8?B?MkVLTmdSbXBnQUp1SXd3eTFSdi9ZU0NNWlBPd1R6SDRkSko2RmNYN0dkV05n?=
 =?utf-8?B?Wm5VeVZqZGJKaHZVcmFOc1pLZGFBcCtiSS8xY1hMSXFzQ2pWQ2FDVWc0S29a?=
 =?utf-8?B?Uy93YzRKazZCUXJhOVZQSGU5QUZDQm41NmN3NWtjKy9INmVlazhuK2krcVNK?=
 =?utf-8?B?SjFjV0JKZUFURUt2V2hONVBEL09MS2xNSWF3dDNiTi9nU1hERjlrdkVUTFIz?=
 =?utf-8?B?ZHBkWjRYMXQ1b0s4aVNORGpNNFl2V0hNcHQ2cHF0UDlncTFBOVNSOUQwYnFk?=
 =?utf-8?B?c1liVzIxYmFFMUFsa0tTU0FCNTVTakhWTWVIQ0pVa2M3VlJQWEp3NFgwUlN0?=
 =?utf-8?B?MENlT09ycitkMUFYL1AydEpoT1VZaVpGMmpkUHNqZ3ppZVlMWlZYNytRN2RO?=
 =?utf-8?B?TTd4WTBTZTNZK05OUVNsRkMxZmxDcGhjbHpFalJYOFYrNXdpV0JHYzA2WEo1?=
 =?utf-8?B?TUo4TWZzQWhRY2RpZGpOb1FubnRWenFwTENoeTBtaUFLb1l1S28vamF6STdh?=
 =?utf-8?B?UFVMcGVBN00xR3N3MGhWRjdIOWxXdEpIVnB5ZDg4ZlZRekV5RWdmMnY4djlT?=
 =?utf-8?B?c0pCdkFjL0lLU0NpTjFCdUFNWW5HN2FkSGp5ZDlZTCtuQTZRTmQ0RkVBajR0?=
 =?utf-8?B?TmtpbVNTODFldW5OWllWTmhDbXN2TDkvWll1WjlJdWNsbU1scm5aUUZUdUN3?=
 =?utf-8?B?T2FTWjYwRDU2QzNTaUgzUTk0VGdubWFmeEdSb2xPZkw1bFl4U3VJRWc4VjB2?=
 =?utf-8?B?a3FUNnAraCswMXJRWUhzUy9YK0E1WVlQTFZ1ZlhmVVFCMXhxNXpBcHRMcldn?=
 =?utf-8?B?MlVrQXVrVFowMGVCTzZyRUxXYzl0M0xKUHJJL290YW9pUHNtd3l4d3NVZkFZ?=
 =?utf-8?B?eVhKdjVlN0Z4d2RPdzhEMHB5SVBzdGZpTUVlT01JSHZ4RkM4bmt0NzhKQjd3?=
 =?utf-8?B?eFoweGhCbTcwUFJaanhwQW5IQ0dxVmxkQnltNVJWMmNqMHkyME9WaTBReGZJ?=
 =?utf-8?B?ZWUwMGg1RmhiVkp6M01Zc3F0R0tWeGp4bVFNdkhvSVUrR3gwd2huQUc4OE1r?=
 =?utf-8?Q?oesbN6ePy7yyO5QGQmfSZskZNVDQSjAkcyP3V/QDuerre?=
X-MS-Exchange-AntiSpam-MessageData-1: FNmQNSW46Y+pGw==
X-OriginatorOrg: uclouvain.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 15fd52eb-2451-43b1-47ac-08de5d9ee1b2
X-MS-Exchange-CrossTenant-AuthSource: GVXSPRMB0158.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 12:23:30.7070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ab090d4-fa2e-4ecf-bc7c-4127b4d582ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kVmTZ/DzKaILRO5+CZCcoNtaD6LmdBjs4IdzSAJKliUF24/mXIxnZ5VRuRcz7ZAl3XncVz85iu5OQmDmXoYNvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB8217
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[uclouvain.be,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[uclouvain.be:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-41530-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[uclouvain.be:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[t.antoine@uclouvain.be,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[uclouvain.be:email,uclouvain.be:dkim,uclouvain.be:mid,devicetree.org:url,0.0.0.43:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,googlesource.com:url,0.0.0.42:email]
X-Rspamd-Queue-Id: 3DBE39455A
X-Rspamd-Action: no action

Hi,

On 9/19/25 12:32 AM, Sebastian Reichel wrote:
> Hi,
> 
> On Thu, Sep 18, 2025 at 02:02:55PM +0100, André Draszik wrote:
>>> On 9/15/25 7:31 PM, Conor Dooley wrote:
>>>> On Mon, Sep 15, 2025 at 12:14:11PM +0200, Thomas Antoine via B4 Relay wrote:
>>>>> From: Thomas Antoine <t.antoine@uclouvain.be>
>>>>>
>>>>> The Maxim MAX77759 is a companion PMIC for USB Type-C. It contains
>>>>> Battery Charger, Fuel Gauge, temperature sensors, USB Type-C Port
>>>>> Controller (TCPC), NVMEM, and additional GPIO interfaces
>>>>>
>>>>> Use max77759-fg compatible to avoid conflict with drivers for other
>>>>> functions.
>>>>>
>>>>> The battery node is used to pass the REPCAP and ICHGTERM values
>>>>> needed for the initialization of the fuel gauge.
>>>>>
>>>>> The nvmem cells are used to get initialization values and to backup
>>>>> the learning and the number of cycles. It should work out of the box
>>>>> with gs101-oriole and gs101-raven which were previously running
>>>>> Android.
>>>>>
>>>>> Signed-off-by: Thomas Antoine <t.antoine@uclouvain.be>
>>>>> ---
>>>>>  .../bindings/power/supply/maxim,max77759.yaml      | 78 ++++++++++++++++++++++
>>>>>  1 file changed, 78 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max77759.yaml
>>>>> b/Documentation/devicetree/bindings/power/supply/maxim,max77759.yaml
>>>>> new file mode 100644
>>>>> index 0000000000000000000000000000000000000000..4d45739fcaf26273ec57b60049d6d0421df38efb
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/power/supply/maxim,max77759.yaml
>>>>> @@ -0,0 +1,78 @@
>>>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>>>> +%YAML 1.2
>>>>> +---
>>>>> +$id: http://devicetree.org/schemas/power/supply/maxim,max77759.yaml#
>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>> +
>>>>> +title: Maxim Integrated MAX77759 fuel gauge
>>>>> +
>>>>> +maintainers:
>>>>> +  - Thomas Antoine <t.antoine@uclouvain.be>
>>>>> +
>>>>> +allOf:
>>>>> +  - $ref: power-supply.yaml#
>>>>> +
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    const: maxim,max77759-fg
>>>>
>>>> Compatible doesn't match the filename, why?
>>>> I assume the "fg" is fuel-gauge, but can this device be anything else?
>>>
>>> The max77759 is a multifunction chip.
>>> The following compatibles are already used for some of those functions:
>>> - maxim,max77759 (for the pmic)
>>> - maxim,max77759-gpio
>>> - maxim,max77759-nvmem
>>> - maxim,max77759-tcpci
>>>
>>> The fuel gauge functionality that is added with this patch is very similar
>>> to the functionality of the max1720x which is why the filename was chosen
>>> to fit other maxim fuel gauge chips pattern.
>>>
>>> Maybe it would be better to use the maxim,max77759-battery compatible to
>>> match the filename? It would also fit with the already existing
>>> maxim,max77705-battery and maxim,max77849-battery compatibles.
>>
>> It also has a (battery) charger, a -battery compatible could be misleading.
>> The datasheet refers to these subblocks as FG (for fuelgauge) and CHARGER.
>> I'd suggest keeping those terms.
>>
>> Additionally, the FG block can also measure temperature and battery ID. For
>> those, a combination of (top-level) PMIC and FG registers are needed
>> unfortunately. Which means that the FG should probably be an MFD child
>> device, even though the FG itself doesn't depend on the top-level. Otherwise
>> it'd be hard to access the top-level PMIC register.
> 
> My understanding is, that the FG has a dedicated I2C device address
> and thus cannot be a simple MFD child of the PMIC. Did I misunderstood
> that part?
> 
> Assuming I understood things correctly, I think I suggest to model
> things like this for the battery temperature/ID:
> 
> i2c {
>     pmic: pmic@42 {
>         compatible = "maxim,max77759";
>         ...
> 
>         pmic_adc: adc {
>             compatible = "maxim,max77759-adc";
>             ...
>         };
>     };
> 
>     fuel-gauge@43 {
>         compatible = "maxim,max77759-fg";
>         ...
>         io-channels = <&pmic_adc MAX77759_ADC_BAT_TEMP>, <&pmic_adc MAX77759_ADC_BAT_ID>;
>         io-channel-names = "temperature", "ID";
>     };
> };

I have been looking into this and I don't think I understand how this
is needed.

When looking at the downstream driver for the battery level, battery
temperature is just returned based on the current level returned by
the chip. There is an optional filtering function:
LINK: https://android.googlesource.com/kernel/google-modules/bms/+/refs/heads/android-gs-raviole-mainline/google_battery.c#732
And from what I see in the downstream devicetree, it is not enabled.
So the current temperature should behave like the one on downstream if
the chip is correctly initiated.

For the battery id, it is stored in the EEPROM at address 50 of hsi2c_8
which I plan to use throught the nvmem framework like in v5 of this patch.

Am I missing something which would actually require this io-channels setup?

Greetings,
Thomas

