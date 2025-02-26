Return-Path: <linux-pm+bounces-22994-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1113A460C8
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 14:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 462D1189936F
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 13:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A9C22154E;
	Wed, 26 Feb 2025 13:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="s5CDS7mj"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04olkn2102.outbound.protection.outlook.com [40.92.46.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3116521B9D2;
	Wed, 26 Feb 2025 13:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.46.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740576255; cv=fail; b=q9gzQMa0p6g9FH2yj1HfjyrZ6tqA17Kq8zo8kyPB6/PFG8/8Uc273WdtI0OaQnGjfZTyLsLL0Im4GqjxGw+2SMUrrDX8HzF8vUFQE1AsNBbWAxZlg4lZZc9e/MFAi409F+gBTeaMg9/K1qbAu8y29mk5RkPR74ErHF3UyJg0tpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740576255; c=relaxed/simple;
	bh=y5/GfodOADYBuUi/XJZOIjmzHFgFGiQp3RDcUdbfcpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UTmTaUSU7rfOhgtGD4y2uXOUk4iYrKYRxRUxc8fAI8Xacx58TuQafcWdaXW02I140yreCT9ZyGZl+pzEVK3/zi6gOuRv35YmBT7ad7Iump57ydpOG3gQegVK+Yq68ETsodEUhx79zB+eIn0z5EyBP9FrMRziOFTuR9B9h3tNzvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=s5CDS7mj; arc=fail smtp.client-ip=40.92.46.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ak/Awytc50TQjTJJR/EySXSgOlI6jFXaOHP/BWtePHO8Ew0n/2n3S94Rh3iUcEg9IS01qSwx/CC57MknDEVrVKyPIavsLLRXL/ikvegAGGohibxrLB/rAUrDhwPkCEuiScuTsQL2D4NLdOy8VjZaqYVCL4U1z90D2H84te47YIGEsR6MnkwoDkLRux4Nw6QjZoXV+tN+3kucpsPGDNaxP0wt8/mhtw6rCB4EGPXxNMIPSly9Ird6iTdAU8AtDP5pJXEqi6NL5aDdjT7RBxRPtZBBbdu4jAMno6XKZXhsuEot4KLZs20z/tMG9JSDkTxCEXAaK05rssqIZMNUjFmqNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/EdbcgUAQZOKmN/YsPH6pyb5rvfRjPLhk5+gDF0YYE=;
 b=UBaTQ4ym65zZrQHBTbi9i0D+W+lhXDXSh41G5lWkpqgqa6G5cL6Jgjcyhnbs4mECZ40rzFni0AYMLLajDpOZg6hoAecLKU3mK1T9tT0FcCqQmdj4Yb71Q8qXD+16/FDSSRl52GYeyUJ2oBf5XQCgY6j95+JD0JTTBn29INXBWhO4MRi6nDs66H/HsFmHTzO733FQqqPH2B+rlphdRyp73XJIn1lzjSU/75BWMB5iMEG7ETgInMyR4dtMBpC3L8GRTimQwqTT6zUbdiDIDJSsI/4MnMvXhNo5hy8NmKQdJqBzMdvV7QDy8VElvHmYDo6pAgWSxMXbGXVxevCkhbkz8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/EdbcgUAQZOKmN/YsPH6pyb5rvfRjPLhk5+gDF0YYE=;
 b=s5CDS7mjZF9xqsZxcOCs4wpXYE/OtJQ2rQJYXSw8P4ZWlof75nvjC99VBs0Ghlwk7cB6k7rPAtURTPuiDHC+jKig094xtDWI0sLRXSd28KmQJ2kBHJdNj9bVhwNTTtczGnEd9m2k/00zrnQeGkIIgK0RrJMuuNsexyLJGu3r0VuyS2KGm+0tASTtI7Qd3TitTk0240neT5vzNv9FOvdjYB+NIAR6xq/f0bgbuzuro1is2umghtE//TEqF/nwSeIEt+r94IPvAVDPtRfrXhnuVBUzOlrLN42MKoix1OpkmFssJa9EYY3lipw3H3PyRCsGCr5DbCvl8c+3J78a2bERXw==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by DM8PR19MB5270.namprd19.prod.outlook.com (2603:10b6:8:4::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.18; Wed, 26 Feb 2025 13:24:12 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8466.020; Wed, 26 Feb 2025
 13:24:12 +0000
From: George Moussalem <george.moussalem@outlook.com>
To: linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	amitk@kernel.org,
	thara.gopinath@gmail.com,
	dmitry.baryshkov@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	quic_srichara@quicinc.com
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	George Moussalem <george.moussalem@outlook.com>
Subject: [PATCH v7 1/5] dt-bindings: nvmem: Add compatible for IPQ5018
Date: Wed, 26 Feb 2025 17:23:52 +0400
Message-ID:
 <DS7PR19MB88833E947FC0002049C659839DC22@DS7PR19MB8883.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250226132356.9398-1-george.moussalem@outlook.com>
References: <20250226132356.9398-1-george.moussalem@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DX1P273CA0002.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:21::7) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <20250226132356.9398-3-george.moussalem@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|DM8PR19MB5270:EE_
X-MS-Office365-Filtering-Correlation-Id: 29e19e93-524b-4364-c518-08dd5668dbf8
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799006|5072599009|19110799003|7092599003|15080799006|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TMDBDytTe8j0X5G8kfnt8H91B6DcredvDJDa5m6V/eixZBAywGN5vPRU3pTK?=
 =?us-ascii?Q?efRc8tewQ3VCCL6sv7wYPtFx1wXPdAwmWW9uY2UBHgHsv3hUZCFn0lfcNL7H?=
 =?us-ascii?Q?Eq0j2rqRr19Br9+5gM85O5e/I7FUmC3RMTmeI8w2DgUDsjaHva4LPE1iGwDe?=
 =?us-ascii?Q?pu8TNDnlS3RpFMjwOwePDluJZdkSq58v6Wq4b7C+HoVkTTiJfR/Kf3vpce2j?=
 =?us-ascii?Q?/bCBEpNCu5p+hCFsbBYQSsFeMLFgZwVDP2taFL12GwsflJh92V77huBuagCc?=
 =?us-ascii?Q?w/Mm0JOBd/6R6eYC8mCJBpP6Cs7KzgRyx6QJsZUVu33kh1JLobFqQ+HEABaO?=
 =?us-ascii?Q?xxXD1xjR/En9uO21OUvkjkeEFnf68KUW3gM7Yrjgb7mKjOBfHELTqscpknTK?=
 =?us-ascii?Q?VU7mXKGAkqAp6JorKLYfAe6tMj1mSHrphy1IcG/wE9oK3ui42jrceyUzm5G+?=
 =?us-ascii?Q?1QVS44tBITre6Au3vLo9rgpnodUtoKQM4bmZ3IznRi8fH/J9Xl5m9UAN0T7e?=
 =?us-ascii?Q?J/+RCN4Tg/1qMKVk38JI2iZ3gLEoZMAzD59tNEvMqLIfEmxyjIRsCr5IBz5L?=
 =?us-ascii?Q?Ky/8BbO4HR9en0k5Hpqw7mUiNHSJrz3IJVuCFab/iiNpV5anVHplDUJdQrn5?=
 =?us-ascii?Q?148BoyDvoDwHMV39OGR8gdblSd+aooCj3jr4uqRoQ9TgtlWhnXJhIblLB2ZA?=
 =?us-ascii?Q?qGXe0YA74k1y0SvQR60iGLSSOIIh1kFP1faG53RYqRkhgSuWx6TKzazLtTu2?=
 =?us-ascii?Q?kVuqCQJVSIg4/R1PBDHdUX7vKyQqc8YICHhL+FmW6COqhByq4sLTWipZt6JY?=
 =?us-ascii?Q?uDP8B2aDTlrkS7f+Zs9nLBPuPxMqIMgusilAzIhsSGlB7eiN0mXRsJOZJQ0y?=
 =?us-ascii?Q?/lbUfdUdo8V6WoeXXIIwED1bS+XhURpCd9LuBVLIB6ONaAbWMDmkeqc935Jn?=
 =?us-ascii?Q?96L9a7kg998ad9IiVC8Tw6EsNA4vB1kJiacwFpLFHkbxDiu5344m8U3dsVhF?=
 =?us-ascii?Q?4t4I/lbeJky8LXH/sH3p06JSUvbuQV1dfLhcyYFASvUlOwI08Ke1xt7kgYRi?=
 =?us-ascii?Q?Vbf/c1F3YQSZNAen21lDJsvsUvx0gWHq/P/tJXtN27ZS9kaLyoE=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?whjC41ve74FE9j5Q7+OBKW75Bs4Gg0J+CMoPjgc7soZ6+UHs0tPCLmeBT5Cj?=
 =?us-ascii?Q?0ieJmFMP96nAP+EdPb0sRI1Qlo77+npk6J+6EedFQfGyWStv+nLJMZPNMXCs?=
 =?us-ascii?Q?rSoY9A8kWhky4hRBptHCnP80t9B5vykLk5fLCjzIW6452IqyLmmAh+dirAJ3?=
 =?us-ascii?Q?pdquqhhKK32+OyYwsGvFUiYSAikMZsHGeJdT0x8/4l/B8pqOe9ojkeud1FRj?=
 =?us-ascii?Q?MBOrhgXrUUGSm8gQ/7yb1RpDBObA/V/UB/d4jhha74LPDWT+ExGiwk1Q8JIE?=
 =?us-ascii?Q?eEYd9XC7NwePg4rrIhknfYD2S19cGn9GVMp/0ZR0iuuAe9TL6g4Fb5MuFfoL?=
 =?us-ascii?Q?hYFNYnx3XCtaKltWW8h6AQ7COM9+dKHkKArDTY8wGVWQYiSPTrjG0XQoSYSe?=
 =?us-ascii?Q?5VxHPWdWCBQxO1eqkeUjT9XRc3PfnlWbCTl5ikpC7/+Rbi+wyPyDDzKMbPFF?=
 =?us-ascii?Q?1nYA6h5eSJpOlddUvuxxfn4b8Kkx6Uj5P35gKbj5ZbI02yCVuynu8JgV/pYc?=
 =?us-ascii?Q?YGHZOj0ausKZOe8T4v06zhXThahU1FisUt5MkK46uEQ9WVPDxOit1mT2eH6d?=
 =?us-ascii?Q?2TFZLr2bOE4o/wJ4lyLsAW64cHavYVckj1K23ef2rc+jrVa7bc5nKSX24uWl?=
 =?us-ascii?Q?O1XUZWJYqGfdHFPOoMNp0qtWuOUeBCX8alzNEyDChmXTP1en/jn9NidkXW/M?=
 =?us-ascii?Q?SoGQvBiT/P2U8zlGNUzovjqYNnuPB90Gxx+zsON6CULrxzRZ9RRnidS6ACJk?=
 =?us-ascii?Q?JWyPi8lhlLiLEnFIkCFfTjEf5i9sujGUEqliU7HmhVmhLeIYiUC5lEtCEy1L?=
 =?us-ascii?Q?FGuOhElXOvmh1+bqox2njNUfWRJ76CcLa51+H5beClHQV3IL7XGAWM62uVHa?=
 =?us-ascii?Q?jmtDtieAJI5WB/JKIPbdV9C2wCfvlvHO5+xydcQetvPtR+JvYZdeDB2lSiJf?=
 =?us-ascii?Q?iQzUtqEv4s2fpkXowhrsImgFSgx5YehvprXzhZSz6JkMnZJ8IkNcKBehx4ay?=
 =?us-ascii?Q?hlPJxyowdqjM1cQkt6ADuzlQD5fqQgdwJX/bOgr6qbttNQCber1MS6gyqa1g?=
 =?us-ascii?Q?xV3NXGSCNdbP0nZTpGQcOtAHN7KbhFOw34ygLE6FPwL9Up6IGQxJ7xzg/Qz5?=
 =?us-ascii?Q?5e5aY09AUpbOwOYlsckv5i3XhX0Jbo/Wu+qqVjy0gyyZZEgMVqdAJMj4Mj9k?=
 =?us-ascii?Q?Zbd0EcYkTPjmHFzkDIHz1AU+BdxAQHRqy4aYEhZx0U43p67lNLpO+nylYoIj?=
 =?us-ascii?Q?bQpdHxwIGa4gaPsCPC5Y?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e19e93-524b-4364-c518-08dd5668dbf8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 13:24:12.9011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR19MB5270

From: Sricharan Ramabadhran <quic_srichara@quicinc.com>

Document the QFPROM block found on IPQ5018

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
---
 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index 39c209249c9c..de262f3153ed 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -19,6 +19,7 @@ properties:
       - enum:
           - qcom,apq8064-qfprom
           - qcom,apq8084-qfprom
+          - qcom,ipq5018-qfprom
           - qcom,ipq5332-qfprom
           - qcom,ipq5424-qfprom
           - qcom,ipq6018-qfprom
-- 
2.39.5


