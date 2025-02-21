Return-Path: <linux-pm+bounces-22602-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04738A3ED08
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 07:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F4CE19C35BF
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 06:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E3B1FE46B;
	Fri, 21 Feb 2025 06:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="HLujW5+a"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2054.outbound.protection.outlook.com [40.92.40.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F51045948;
	Fri, 21 Feb 2025 06:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740120771; cv=fail; b=Vora6RF15bgYIZkySC1VF47LmrjBzvObqGhN115MkQGWz/x7LZ14p6yz95GxKu6v++UOklpcPRt20R6cdvKPldjP2s9IT04x1PcSJ4B4YCgBMKD8QS1NBmEDxNLShpxLIxsmLAMFTHsHOYGkmGNVjWL7zCktzxMkvenGdJqP56I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740120771; c=relaxed/simple;
	bh=2I/pytwEuXd+8VeNrvZjSXb/Lofy4Hi7dA6jzXl6jWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rk4GHldHe5qwlaEHVDpx4w00rx5o6wiTcwYZGdg6Rh8/JbOKynh+3nwM+MGvtGf80NAZ5qPgU2pbA2LWx31wn07Qr8jWU9UWVj9Qwa2ytqyyB7hEDQSfR2kucD18wL3s2ovUVRPqUBE7xhQBMGWSO7gQdivkp9Asi2L8m/2J15A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=HLujW5+a; arc=fail smtp.client-ip=40.92.40.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sVMJOYNQp2cFit9oboNzTikJFi9B0kDcvtpf4U5jqM5OM/1wIfeyfiWO9OdggaHjD+mw2vemTNhoeUAlXutWmc3zjnL4ATSoiXmmCvZJZtHbtRioPILe8mHKK9qP1UxxjNKKXAGUd7/Uf9dScqa/hV7qVVYlo6Cn7/QmAUFiNJSihV/RZD8vTpeQH17Pdq6FzWmJkdcPx4h8NsU8Lxk6X2AU1m2kGP/pBgRS8WeLAe+vGvCENG68Pj1jatJBTps24AZ3eswOVKcUcODYT6MjeigPawSpQpLIhnRAIxTenh0X6UMOtJbxLEGy/rWJATrPMTEqKaRMcTcF74fj2hmWUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UptBSbaxc1fO13BAb0HmE05Q6RPwY71GWsaDwGcomws=;
 b=Qf0RQgvxuVXgBVPLQ9bSwC93/RkTJei7UUSLhNWlBYD50QwQ/RJgZaYN6Vlzw8u+SC+2b59bSvlEMgJgGtCAD4TeymInaR6v6+VvKe1lN18C5E2VoLBITV/fIPHHrHM1Oo36ae9u8XnwS9AerNssx1+BcuNko/nvqRxx3TX5xxlcrO+SMv4D2IwrYkmzkV0vl2vi4Y5qfDG0Wp6Yh0li8ltron7zVyiJNs4truSy6bD+bGFQBzHHv2eAjLuMvL1VfOZuBZRmaSDtqSJBpwlrbjbW//pPJrTWaFt5zAlDBpHEwzTPwUR3ygpbqKxLxS0xKFDEk3kU7ujo0BJzH7NKgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UptBSbaxc1fO13BAb0HmE05Q6RPwY71GWsaDwGcomws=;
 b=HLujW5+aEabE0H85tG7OuTri4di+1oL/OWHwbDaG1MEPTr6JTHsF+017ztyNZIKqw65MxhwXgIvEX0nXPOS/fAcvj8fRzKsHh/ODF5bLhSVVtx6XLn05RVXZFz+k6MemNbl1N/Wm2Go3NXRIjBXNZrcUtTzap/ROYWXX/n9xnJO6ntvZW2m4/X7KB+hEiZ85qs9A8UX6VtW8dXMMTZlwGk8nF4Z1PgQpka8DvDbqPtujHZTgCmfBl7wrqEHoGv+i1d1tp6PosPYvYK0U3M/8z6yw1DapX7otavH7LoQvUcithzgKNzflpdKk2x6e1+hE3cKA8wfVj0piLt89OUMKPQ==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by LV8PR19MB8323.namprd19.prod.outlook.com (2603:10b6:408:1ff::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Fri, 21 Feb
 2025 06:52:47 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 06:52:47 +0000
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
Subject: [PATCH v4 1/5] dt-bindings: nvmem: Add compatible for IPQ5018
Date: Fri, 21 Feb 2025 10:52:15 +0400
Message-ID:
 <DS7PR19MB8883C8E61B02269AAD7D8C1C9DC72@DS7PR19MB8883.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250221065219.17036-1-george.moussalem@outlook.com>
References: <20250221065219.17036-1-george.moussalem@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DX1P273CA0011.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:21::16) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <20250221065219.17036-2-george.moussalem@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|LV8PR19MB8323:EE_
X-MS-Office365-Filtering-Correlation-Id: 45b24c9b-edaa-4c69-7ae5-08dd52445936
X-MS-Exchange-SLBlob-MailProps:
	igNrEvV8uhHi5klYzQchmbXEARBtURutWVwka6wunqaUesvA7JJu3RiyrI+bKedAfrmRNnbZouzoszpo2Vj9XoJ6jEXoFR9e/HD/mKLavtFQ0gHtjNv7w1f1/hlyEXF/EEYf9dNsLI3+AC/q+PKSic3cVWl64skE44ZOADJLfZJZqRbPyBorEAvDk/7TCzJhKDHtfy+Ep5p4DYADu/OJ1irthjvWlsw9VjGoR5aLMvcJOA9hAU8f0aEvKBz6jOvJqYPem/2+fWxjwPXQlXEwJCMDkMGl/GeQqW8DnzVE1EgwuQtZn0YkxFDQPONWEHnM+EBMeGBc+1WTzX8NHMGuE5hCidC9jGHgZbbdcbabV3kveoYc2gqTyspA1imGnzwNKd20XNahJxeRpA+xGLTvCORLQApoRlAljTKvDNUep54fRpeszhtGg1b2Mq16JqHq37gBgrZdjkAB782GtQdeL2Bu2wBhYLy6BSbCB2BnYFjaPqRO8R+HSjkTAXJbFT3olw2yG6d8MDHetbeW8teEh75wqDUD2OMV96oCLl9m3NikH8sC+Oo/m5aq4K127P6maT9yTQL3o7w6E3FLaevMl0ya/ftHtHh+FCu9oW54Da81jWtYcvogrKD+CyawZ9buAe4RqobbR+am6NMTr118u6ZqjGxMTE07hHwLaULWogGXP+c1w2SiQvzmoWijFnB6SjkRAhtOAdM=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|15080799006|7092599003|8060799006|19110799003|5072599009|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zFaoEun3rdIZPPwx2HIlJ/018O92Q/f0VPTv5zguRxn6Mc/AvjXdR9vjKiYA?=
 =?us-ascii?Q?YFwR1Cwbcx6qGSie3NQpdTLoO5wP5Mc4XFOhhPiTu/msOJMVdFt/nN2WxN3O?=
 =?us-ascii?Q?vKrtR3uqu/NK4hRW0kujntqfxKKtMHH/j1H/TvqoY6xsvMIqSSE3q3PC3+zg?=
 =?us-ascii?Q?V2Nt3emn4lVwlGBunu/MXqk+BwQGuvLWkYx64hM68VTCu3m62arUyqbCy0vG?=
 =?us-ascii?Q?GfRwHDKOLfTrcFT8A00XDKLll8Hmff2LIQuCLmF4HesWryA1XMRkXIpNp2gL?=
 =?us-ascii?Q?3IEN1FTG0uvlSCZ7WCTyhRWPPmaVunWBsQY9mmwSwrSE2kKux41prbAbo0fM?=
 =?us-ascii?Q?b2dGfrwesUZUp2BTbTEk1m0AzH6SSA3qdaeizibGDBUszO2jfhKU8etSo0O5?=
 =?us-ascii?Q?ZUAYSivWVvlv5x3xS6LzX1O535AURw1akcQl5fPrCXlFLMRDYQei3bYvBlKk?=
 =?us-ascii?Q?l4gRYhfiTcDYGEdAvcjK/y6LRHVNmn7LqTKuS98Tc4ml1IalaPx5qGPRPIN+?=
 =?us-ascii?Q?mwXKMgDMx8KRQtumwQ/jvsgWewtW+/wqVIxKPR9hzZykM7aC3vddXWt07fM3?=
 =?us-ascii?Q?rTQdjrcSJuf677mHtQHCtFvcuURlL0oMmga1/uguciKvV08s9hjNt8AoPFRf?=
 =?us-ascii?Q?mk5fMZc5w5mWPvST9eoTxYkfhJ9Jz4l7wVRW7sUcoQ3fjgyyWtp9yTybCSOv?=
 =?us-ascii?Q?ohp05Yq08sKhrIUndiYetEqyR3xLAuY7dz36l+2ycs/pq6LslRgIIXZchm+q?=
 =?us-ascii?Q?m2Gm1cJ9VSLHD3Iw4Tc0IohpBnm2qo12yGKUAEwjhYRKtwJy0bbmxZ9TshS4?=
 =?us-ascii?Q?OfXDWo62Cbp1Lk7SladsYFnIr1oWVMJXJYcfBBUH9ZnpqaeKJj5ZvDOKZ7GN?=
 =?us-ascii?Q?teKq8rjm2fcFcYmgoAeXfZM42eAzV2ZgSJdDW2T8MRRBaPb4ZmOlz/GharWJ?=
 =?us-ascii?Q?1+LgpR4FOANI0cAzD54O6p/tz+7geBViXOCiuyCN5LuZ51EZsmC/iaSeCVjp?=
 =?us-ascii?Q?AYTDRpsY9bhhwlzpp7QA5fTJrIsCDUvWA6nMBEEt9XDbnCg/+5leohrEPc69?=
 =?us-ascii?Q?HINZYOOp0VM7TxykvNM22C5zoI7SahW88amJxkqTIYk0XijRMz8=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bnIMlHYkzbKU2fHOppIVHqaA6tHU2xu9Cg8Q6YnwgQ4l+r2xhgj5wc6ifgng?=
 =?us-ascii?Q?K4BBcdu92piXkQOkdR/91F4mGEcp2Twvu4LsVkc7/+FuNrRb6c86iWo8uDYR?=
 =?us-ascii?Q?NIIWFnRhqkOespyesVhQUuJis6fHJTYPNMeymqjwaYfyMRkdTctCVtioDGGk?=
 =?us-ascii?Q?83DbM/MET5xfBNwGJVVc8MShTpwjdPErZ65fAyTcRy35uVH4ZJptX7zZLXWJ?=
 =?us-ascii?Q?BYmOULM1CjuA8ikOgL43/n3umLdGuo6K5BCSTCWSh/I2ajDNUaPq2eAqqA6p?=
 =?us-ascii?Q?On4MACZ2395CMkMEyVg2JilE59M7hBqh8lt5p6CxSqGb7BFmuMP6nSkalZky?=
 =?us-ascii?Q?EnDDtuZpj4XsnkIdD4E6lYnWATCYisboZort5H87qg60CtP+iCXeB3ArxIx7?=
 =?us-ascii?Q?NHuCYjln+PzbTNaRBNrCVHNRvohGE9pCu+TAINzyEEg6tyP4C/oBii7M/zj1?=
 =?us-ascii?Q?u5E3IkUwL2kce6SC36xlG+pbg65Vvwp7yO8v4FMJZPL3Q927m6zb8Ug2z0zk?=
 =?us-ascii?Q?C5+5TXVb73kVIDNvj6cEWdNJQixW+ppbbQ8SlCvReLUQm2QpMwP7fEABZogY?=
 =?us-ascii?Q?dT4nvK6+J21L6mnMWYKaHFF46XW9Pc7J99r9e8xFi1Fht7q5dng1pNgSVycp?=
 =?us-ascii?Q?nbsiYiydd6lIppW6s0UZpXSzwUDudhYbqsYk/xTeg2r8AgqYCjBZy4sEBF7G?=
 =?us-ascii?Q?zSQ2qGIq2wSSS7HEa0tWVbuqZTTvTqgWIe96nlaafjRmyf+ES3DWAkmZtRTr?=
 =?us-ascii?Q?JJ4UPpu5m/R89xcOscp90Vr0stQYI/Mn5hjsG8KXUg2VD+UxLE9513LTdbV3?=
 =?us-ascii?Q?useQx9R3e3Nox2g1Aeh6BpChk/BMHtPsUwoAh29sMcvVxtoahUr08KlGghn9?=
 =?us-ascii?Q?CZtvC9MCldqdTLoMDHo7xQyp7Nux8D1vqsy7MZuYUrd3uoU1RO4PQ5XJP8CS?=
 =?us-ascii?Q?M4do3bc6f78RvTexamo7LRzOg118ikbtWPjGuNuLCElMpkhY8m7Y+HeQyMvp?=
 =?us-ascii?Q?AYWZl5NaAUgDv8gE+fl5oxJMZ0J+Vu28DismQf2xFbQGdmHsNV4NUTeQfUBR?=
 =?us-ascii?Q?3FZC8xtziX3qcebtUmdc6MzmYA/XNOTovhOQ7FqIXLg2hGNc89P9aJDKC7/c?=
 =?us-ascii?Q?mC4dzXrFUvxj94JkYdNVw++dfWOeq8Bn1YIruJfLACiejYgSbdGRzowamrLQ?=
 =?us-ascii?Q?yCtmYa+fkb0k3ufKbraV1Ak8OxgI3bIzPFOE5w2l4PtnpsirmPAf97UqOw70?=
 =?us-ascii?Q?hRria/keVjnk/xfPLDdb?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45b24c9b-edaa-4c69-7ae5-08dd52445936
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 06:52:47.1044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR19MB8323

From: Sricharan Ramabadhran <quic_srichara@quicinc.com>

Document the QFPROM block found on IPQ5018

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 [v4] Documented ipq5018 in qcom,qfprom bindings
 
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


