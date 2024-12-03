Return-Path: <linux-pm+bounces-18439-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0779E1B38
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 12:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CBB8B2C52C
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 10:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37E91E2018;
	Tue,  3 Dec 2024 10:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uclouvain.be header.i=@uclouvain.be header.b="QmdsBfrp"
X-Original-To: linux-pm@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021101.outbound.protection.outlook.com [52.101.70.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E581E1C35;
	Tue,  3 Dec 2024 10:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733221887; cv=fail; b=fKTuv2U7860YsAR2VJuymBYFY4GNy6/OJBWzquREFes1+C6p2SYSlqHSJLRwcQWrKrF73tAQMaRKWShrFcpp/W4/qH6DhfqtCvwRcut+sGi5D+LFsYs5BKRG6Bf9cB7HXtHa53P2Yi5eJUg5ELZbAzbLMxyNqAembkpekvwO3hg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733221887; c=relaxed/simple;
	bh=praOht0B7/LhonHYzhVmfHX7WshqGJut+uu0bCcSqXY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=siyswgGxzt2iT8bmux0YierKwQ/BCbNIhSWrTaMkJwpv7x40ldWB+EqgXxua0kw/5iPlb5E7Wh4NauRr4Gytm16oSZ8SbE48yNxcoWzLBz8bcXMshnlRiprv5HloNvkQC0qqxAOzAPVFH3Co1yC+WuqIImjJBVwn3xPRo7ChPDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uclouvain.be; spf=pass smtp.mailfrom=uclouvain.be; dkim=pass (2048-bit key) header.d=uclouvain.be header.i=@uclouvain.be header.b=QmdsBfrp; arc=fail smtp.client-ip=52.101.70.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uclouvain.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uclouvain.be
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W3HcYd3llBNx1JOZEpFaYlufq9Moq31ki5nzDv//ZePdeAuLbigkKaKCpfLQ0sBYyBRoh3fmPESZ2UpU25cwt4hoYGRxIcLdIs3DJY4gweXiWtu4oB8PPIrjlaaYWzRd8Ty/NK042R3keI8pS9O/Ow77OGN/3ic7k+DVAfDumh217oLIdXc0VkHZ3fIHkJwiJssr09axRs9yZy9UkrOKW2KIikze0to9DdWy4cSpcDOM3ChTnWXeGY0kNikx2Yyj4a+iU1h/V8o/vJqPUNENdiaQuGaIS+bYHytmKEqs74x3WjcjmTrVjcTLvnX2Xatfeat2Geg7r8OqL0cj1Tb4bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vg9hXZb8PNqLpaZ04iUCJMvQPgHIqg6FkupdnyAOmrA=;
 b=g36rwyUSvZ8WEsudNNaufiDQkA3s0TN10EKic6uFYZuuvSWahDRNZ14onJWNCHMk8iKE6HVHNcgdenYouEBkDmiXBcsTtGIE71hbWPilvbu7rqlsy70ksQ5KaFwpRRT9aq4+nCiEka6xSoMOyBQ2EB14CRNfCTFhLppaWraBuVz33ItJGTL4IV+AAJASKQPAo2cqnnAiLO0XBpluzDqKDD3qadc9In6UDxIWHIogzTb9Cx+lLPv+CG3Em9YO+csz/R25/7PhGruAxBLjOBMNLd46raR/PwIyyN0FYyfb750CtUVOCtAxzDapQpKKPnvtjrboXo3mUXXVavbo4bCCiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uclouvain.be; dmarc=pass action=none header.from=uclouvain.be;
 dkim=pass header.d=uclouvain.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uclouvain.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vg9hXZb8PNqLpaZ04iUCJMvQPgHIqg6FkupdnyAOmrA=;
 b=QmdsBfrp1YAqiqQieAh2xanp+T/Ccmwu19Tfza4+3GA/uZv4nndGEEhntDn4u38OYBGEttwgWPTnHnxeFQVQxQ5zSKyEXR9rJJpv71UWFe7M2mm+CnYmtFThCTfSL4xzCCfECPaevXBxF0H0nMdSgANm4r+ncFmci/tI9oyDnOiHx1RVaJNTfFVliSevll7Qit12gRH/Sm8INnm4VvAc7CXOsql94sS2BfhPKsf+pOa7PXG39yIcsjy+wkBOyuLnEsVV3NsbyYx8quUw+7HLwRfWAeVYi/qlF76U5BvNV46U56P/SBJP6OCaB/AXw7CgGgeIrd45vhzSpuiHlehSIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uclouvain.be;
Received: from AS8PR03MB9047.eurprd03.prod.outlook.com (2603:10a6:20b:5b6::13)
 by VI1PR03MB6173.eurprd03.prod.outlook.com (2603:10a6:800:142::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 10:31:21 +0000
Received: from AS8PR03MB9047.eurprd03.prod.outlook.com
 ([fe80::c90e:deef:6dcf:538c]) by AS8PR03MB9047.eurprd03.prod.outlook.com
 ([fe80::c90e:deef:6dcf:538c%6]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 10:31:20 +0000
Message-ID: <61a54367-2406-4106-bf8b-9fda4f2d11a6@uclouvain.be>
Date: Tue, 3 Dec 2024 11:30:38 +0100
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
 <8f585460a1bc52f78a6d0867aed87398bde30152.camel@linaro.org>
 <18629c9edd295a524a1c9764f013a0e97e0b275f.camel@linaro.org>
Content-Language: en-US
From: Thomas Antoine <t.antoine@uclouvain.be>
In-Reply-To: <18629c9edd295a524a1c9764f013a0e97e0b275f.camel@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR0P278CA0023.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::10) To AS8PR03MB9047.eurprd03.prod.outlook.com
 (2603:10a6:20b:5b6::13)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR03MB9047:EE_|VI1PR03MB6173:EE_
X-MS-Office365-Filtering-Correlation-Id: d1c81939-30f7-4466-9d71-08dd1385a0e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q0oxNmMyckFNWnVRNzN2dFBWd0QwR3gxeWRUbDNQNll5TlBMTVgwNTRiVXBE?=
 =?utf-8?B?Ull1ajRCaGljcDNselQ4SGlqQVg0REdPWmFxYTh3WDlKTlZKSElNQzZYNnpL?=
 =?utf-8?B?TjFCUG1YLzQ4UWdZY2kwS3NCUkx3TTAvWStBeDBQck5xVDBWb09HSG5HZmVh?=
 =?utf-8?B?RURjbGV4V3M3NUNJdkxwd3NWdjk4dnpCL0lhblBISU1sTUY5OURlVjZNTkJw?=
 =?utf-8?B?ZmlqQUpBQ0VHNFZQeDEyN2wwVWxOd09mbk1XRThGVEwvNEdIdEpBSFI4ZTk0?=
 =?utf-8?B?MHVkT09iSVNmS3o2SndQKzV3U0NVWFgyVm9GUFBhUFVBNitpQUQ2RkhtYUlI?=
 =?utf-8?B?U0ZUUUlkVHpwd1JTK0lhSkEwcWI1UDI4emhJYXlYR08rNnowaVVRZlpOaEFi?=
 =?utf-8?B?SnVtTjNkbm40MjZDb3NLbGNaSWtHRmVuYnJFY3hQUUtUUFR2MFU3T01mMXAx?=
 =?utf-8?B?Zk1OV0lSVkY0YkVuaVN2MWNXelkyVTJtTlg1NUt2NFdpWWRpNVlQcEJCYkNr?=
 =?utf-8?B?Sk8vMGxGWUJWR2hLaVFySGQrMlF4RE1PS3g3WEEvSTlZUzdnNDNSWVg1VTVw?=
 =?utf-8?B?Mmt2b3JadWRzM0lSSlpIV2I1bFFYUWFIelRuNEdYSFhCU3poTi85Uk1EZWJK?=
 =?utf-8?B?YUI3aHZsYU5vSzdDc2tMeGkyUTd2WFcrRWNxZ3M1SUxUYjZrZ1RYTkFTVEt4?=
 =?utf-8?B?K1VRUUthRVRGT1pZT1U3ejU1Q1NQd1pwZkZiN1MrWndCWDVhZTRxQmg4eWNE?=
 =?utf-8?B?WkhEL09FMDJvZ3hFdmJwT0k2VXVVUDFaeG94d3E0Z3JsU0VPQ0Mrb1BkaThz?=
 =?utf-8?B?TzBIUENTaDFxZnJHaDYwcWd0RGhpelZCb3Y4dkcrOFFXUWo4ZVRRS3ZQNDVi?=
 =?utf-8?B?N3N0cndwUTUreTZwY2F4RjV6dFNPWFVXNm8vMnNzUUxoZjdJYmZja1VwQlEv?=
 =?utf-8?B?QWR2ZlBtNjFtUEkzeWV5RE1idytUYWtSQnFULzBOV2ZNbmUvd3oxazJLdzNK?=
 =?utf-8?B?MitQUGlwZ1RkazVrN25GYlEzeGFmcEtNV1hkK3JFN1QwcS9aQXE3TVk1a3Mv?=
 =?utf-8?B?YkZnVG15WXdPaE9ydklDcU5vNE1QTGNYdXFySE03R01nR3ZyekJDektId3kr?=
 =?utf-8?B?V21FRUY5UFQvTmtwZlEzcEpIQUNsSVl2Znk5c0FTaGluL0hvTlhlSjYyb3Rp?=
 =?utf-8?B?bmhBaDByTU9Odmh0U3NwYmU3Y3hoZTg1MStObXFOT0pDMmdLaEwva0dOQllL?=
 =?utf-8?B?Sy9SenlsSHRGQXZEL3Q0dEs0OWFPQ2ozNXFSbFhqZEYzN3N4RkkycWl3T1NW?=
 =?utf-8?B?NHo3SFdSa1JpL1ovc0prQUt3d2lTbTluTjVBK09vUjhEbG80OTVxQTVUMFVO?=
 =?utf-8?B?UUJ5UnFlZHdzU0ExZHY4eDh5b2c5TnlTSHB3TjN3aFFOeENpUS9lNzZjNWpq?=
 =?utf-8?B?VnppOUtVbGh1amE5M0lTNmxNVGVpa216aDBOZzE4b0hPMDg4U3Y1QUpnUS9Z?=
 =?utf-8?B?UFRCK2RvNFFwSXJIMkZpTXdISS91Sk1JWmZPYURGRnVzb3M0M2lneHpLcEp0?=
 =?utf-8?B?RHpBZUdZY3BjZEdmK1JVSDlJNnJ6VCtZVFJvb3dWQkQ0ZFdTQU9SRGNBbWFr?=
 =?utf-8?B?bzdtSDJrZ3I0Z3ZGaGpieENwZlJYVVFSVkQwSUtpUGI3NnhlQm5JWmlLZmZO?=
 =?utf-8?B?YzFqQ2lpd081NXREWVAwVzU1NFVnV01Za0xsdWFUdkVESVZCNkx4ZzVqODdX?=
 =?utf-8?B?a2YxdldXSjd0WXlRNDBVWi85Zml0bG9kMlhoaUJVZ3hLZjJkUEFCUGFBRG8y?=
 =?utf-8?B?MlN5dzlEc2l2N3lTTzhCYVhYQndzREJQQnV5d3g1K3FCZlNEbkVMRDRNa3BR?=
 =?utf-8?Q?rHXsb6XBDjgdV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB9047.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUZVb0lTZko1aGYwcTdwdFI5aVlDVGxSd3J6VzFpazBCWmlwaDhzdjBCRVF5?=
 =?utf-8?B?ZzFPWEQ3MzY5WEJsanh4eWl5eFQ0LzM0a0Q0YzhEMTR4ZGIxVXFWa1ZpcnBl?=
 =?utf-8?B?VDVOdDVjeUVPQ0cvZnZJYWs5eWhYUndYL3pBN1h2dy9OVFlXWkx4NDN3eTBl?=
 =?utf-8?B?RmFCUjU0VURZazRLbkN6MVE2VkxLczROVmszSEZlV0J5Z3pkdG5wSDBORjY5?=
 =?utf-8?B?MUVjcjhOT3k1L0Z0U2pIdHA1VkpNdWhDNFhiZDNoT2dSNE5ZbjNUNlhpOTZm?=
 =?utf-8?B?d3Q1Y3EwMFl4N0J6ZlVVTUxPSVVUS3Qrc2FkbTEyeG05U1psQ09nQlFHT2Jr?=
 =?utf-8?B?d1R0ZDZDbVBkSVZoV0Q5WVJ4VXJFTzJzWjVOMWgvdEZzQWx5cUlZb3dXNlNu?=
 =?utf-8?B?YXJMSzd5a3JTamFkY3RXL1RnWUMzWmgraHYxU2RTdTdLcGVZaTY2VytUcGxJ?=
 =?utf-8?B?ZDJGNnlJMUp0aHM3THNzYndkWE5YRlo2emV0bEVtb2l3SDFVVUlOQmM2VU5o?=
 =?utf-8?B?VXJuRWpBSEtRanMyRllVWkxvcm9jS0xWcS9EekRzZGFhcG1McTFSQm9hZTdm?=
 =?utf-8?B?QWd1ZGNRS1J3L0pPYU9mUDQ2L2JFaldXcSthZ2FNRXdnRXlZdDQ0a3N3eTRB?=
 =?utf-8?B?Nzh4akE0UUZVSmlKYW5JNEFJTUQ0VWY0ak1Xa254WS9PbUFPL04yT21GR1pr?=
 =?utf-8?B?S05DR2RKbWNzM1ZNQnoxUEl6TWdxbkQ4RTBwczNraDRNczZOeEo5MEdGQS90?=
 =?utf-8?B?Nm9KUlV4Q3JrMDBWR2xrd3phSEk5MFJjaURJbnBUVEU1Vml3ZERFY3RGcVVC?=
 =?utf-8?B?NjIxUFJ5M3B4eFUxSGx1U1N4NGRXc0JFdGs5NW42cEIveDdTdnJPb0hZSU1N?=
 =?utf-8?B?WDhmc05PODBrKzE3d1NOU2ZubjJ6Ujhxa1ZJQnRuZVVtL3FCcXY0NXNOTjFR?=
 =?utf-8?B?OTFwcSs3V29BV3l3MmhYZWJMVnhlUW43V0pqREVUem9CV0Y4VVpFZW9HU2hD?=
 =?utf-8?B?UWNBaWozd09Ca2JtdVB5b1FXaGVxZGFvcE9XUmN6Z3JFUXVza1o0Sk12eDFa?=
 =?utf-8?B?S0doQ0wySThTaXFvQUxZRG9XYzhHeUJrNjdzMkYrZG8wMEFJbERtQjhUK2tB?=
 =?utf-8?B?TGlHVW9lK1M5NUZiOStNMkQzcVJDU1FKRlpJRnRzTTdyM2RIVjRUTkx2dWti?=
 =?utf-8?B?Z2VIRzVtRFd3bzRkVWQ1bm54TmtYUkRLQVVadnNUS2RObnJnVnVaRjgwME95?=
 =?utf-8?B?NUx1T0trZXg0aThJR2FnR00rZVlqTTRKY1B1ZTVBc2hmT005WVVEU2huclBS?=
 =?utf-8?B?UFFrOTMvYWY2OGhGOUJxVUdHN2ZrNU8xN0hVMDk5d2kzdXFvUTA0UnBpZHBo?=
 =?utf-8?B?MUlxRkY1TEh2NWs4SWE5ODNzTTk1cmo1ZGEyK0dvZmZZMlpDSk51Y1FDY0xj?=
 =?utf-8?B?Sy9uY3czZ1VQWEV2d3UxbVNBcnh6WnhacVlRNFB5OU51LzZqTm1oMCtPaVNt?=
 =?utf-8?B?UW1yamxleEpYZWVMT2llWmRVUDljTUZEOFRLMHhWSkgyUkpWVWhWUWQ0TkJQ?=
 =?utf-8?B?ais5Tm9VZTFHQmxKQ2s3c3ZWYkYxajBWYlRSVVhhUE9QRVQ3ZWZwMVc1eFc1?=
 =?utf-8?B?VmxlV2pmaDZlYXMwelFqRU5QNTBLMVozY2pUZnBLZ243RXdBMkxISGwwZFFP?=
 =?utf-8?B?TGxXV3FvbWoyeUUrTTUxTktVbWVyYWJBU3ByUCt1b3pYWmFIUTZuTUJsdVRN?=
 =?utf-8?B?UEptOE83ZUtFem5SUVBva1N4T1NLK1M0d1l6ZXJxejloV3hKTjdRS244SXoz?=
 =?utf-8?B?dUZyUUEyc1FOWDBadkplVml3UXoyYy9WZjlJajBOODE1bU9DWi9tU2twSS9k?=
 =?utf-8?B?K2poVWZMVitWeXdFTFBSbjVHQ1FHQzJBOHF6SU5JOFZ6cjRrc2pBditWbENm?=
 =?utf-8?B?N1B2TGVubHhSdlNwOExkUjBCekFmZU5qVkd0aFZaYUkraGovNUcxeHhCZy9K?=
 =?utf-8?B?TXBzanRoM3k0SDFTUzNXb3FvaE1YNlZCTFVQdDFUaTNkZmNtdlJaNGZIN1ND?=
 =?utf-8?B?cllkUmlmcVV1VncrUHdLa3ZRU2VPcHF4eE1mejZjcm55dmlPWis3WGxkZWtF?=
 =?utf-8?B?MHdxTXlNbWlBSkxwbGd6b1p2MXo0REw0dkp3Y2tTYXZrT1VhQ0pIN0JjRXVN?=
 =?utf-8?Q?hF2irJeRptNUhGCiud0SLiyKSAHj6+FJTVABZ3Xk4daQ?=
X-OriginatorOrg: uclouvain.be
X-MS-Exchange-CrossTenant-Network-Message-Id: d1c81939-30f7-4466-9d71-08dd1385a0e6
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB9047.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 10:31:20.9133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ab090d4-fa2e-4ecf-bc7c-4127b4d582ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V/PbYMBv/acj7xyuVJLyTrvs1URPHwo7uslFWGtPknih4y9Sh0SCpLTpdFDn6QBzxQiPvuXuqw1I7r7pA5huQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB6173

On 12/3/24 10:45, André Draszik wrote:
> On Tue, 2024-12-03 at 07:23 +0000, André Draszik wrote:
>> On Tue, 2024-12-03 at 06:47 +0000, André Draszik wrote:
>>> Hi Thomas,
>>>
>>> Thanks for looking into this!
>>>
>>>> From: Thomas Antoine <t.antoine@uclouvain.be>
>>>>
>>>> The Maxim max77759 fuel gauge has the same interface as the Maxim max1720x
>>>> except for the non-volatile memory slave address which is not available.
>>>
>>> It is not fully compatible, and it also has a lot more registers.
>>>
>>> For example, the voltage now is not in register 0xda as this driver assumes.
>>> With these changes, POWER_SUPPLY_PROP_VOLTAGE_NOW just reads as 0. 0xda
>>> doesn't exist in max77759
>>>
>>> I haven't compared in depth yet, though.
>>
>> Regarding the regmap in this driver, please see below comparison I had
>> collected some time ago:
>>
>> 	regmap_reg_range(0x24, 0x26), // exists
>> 	regmap_reg_range(0x30, 0x31), // exists
>> 	regmap_reg_range(0x33, 0x34), // exists
>> 	regmap_reg_range(0x37, 0x37), // exists
>> 	regmap_reg_range(0x3B, 0x3C), // exists
>> 	regmap_reg_range(0x40, 0x41), // exists
>> 	regmap_reg_range(0x43, 0x44), // exists
>> 	regmap_reg_range(0x47, 0x49), // exists
>> 	regmap_reg_range(0x4B, 0x4C), // exists
>> 	regmap_reg_range(0x4E, 0xAF), // 0x4e 0x4f exists
>> 	regmap_reg_range(0xB1, 0xB3), // exists
>> 	regmap_reg_range(0xB5, 0xB7), // exists
>> 	regmap_reg_range(0xBF, 0xD0), // 0xd0 exists
>> 	0xd1 .. 0xdb don't exist
>> 	regmap_reg_range(0xDB, 0xDB),
>> 	regmap_reg_range(0xE0, 0xFF), // 0xfb 0xff exist
>>
>> the comments refer to whether or not the register exists in max77759
> 
> I think this should make it more clear:
> allow:
> 	regmap_reg_range(0x00, 0xff),
> deny:
> 	regmap_reg_range(0x50, 0xaf),
> 	regmap_reg_range(0xc0, 0xcf),
> 	regmap_reg_range(0xd1, 0xdb),
> 	regmap_reg_range(0xe0, 0xfa),
> 	regmap_reg_range(0xfc, 0xfe),

Should I explicitly deny their use in the code for the max77759 or is it
just for information?

Best regards,
Thomas

