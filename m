Return-Path: <linux-pm+bounces-22661-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0EEA3FB4C
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 17:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91E13867D74
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 16:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977AD1F8ADB;
	Fri, 21 Feb 2025 16:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="oclRAtEV"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2109.outbound.protection.outlook.com [40.92.19.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D700A1EBA14;
	Fri, 21 Feb 2025 16:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740154286; cv=fail; b=WCEie2E+u61OugvRqkdKdW/G7gmkXWuIarOC737Alwc7qRHP7/h9e5zW3hCMUFsC5/rPbq4uLOx9cFScX4Wh+rbCa1o75f/1FNwdy5t6Fx8T2j3THETKT5MRUpF3NCYOq85oJNgyOHiM0Ylrs2+xUvvx61yuvE2F+YHlnzzSuYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740154286; c=relaxed/simple;
	bh=nedc5SnoCsWZEHJ9F3vDuFGQUCVynsQYdytBtzmoawc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jaz0j9pbdbc7cpG1Qmfs8Nfoeb5q38mfGhJIoSCLv2ABrN+K1a1k5SGkY8o80U6dWnGtvuoVHp3na5O4AdTWRJ7lQyTPHqECYPmbA44dZBPdRNIArPBU6MxVEhLRiGx8n98JM5Po1uW0VzG581gB5eqeCGfK2f68Xh3+aLZzdxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=oclRAtEV; arc=fail smtp.client-ip=40.92.19.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kg0T8rHuQvPvKkrtcGFT8Eas1oT+aoLXCK1P65RqQIEFIFNJ+acGRWnZIDQFLDDDvBLfkWhk0ECjxelcTHBN2l/YSLmN9dUbxcdDh4GulBFivm1c1xUuJ/UwSrrilkq6nFLho+rMDW4k+IHBaI35/ew74S+ga/PRpBq6FcNLS2luwqQbPUbgs8yGCYnreUPRu8YFVEkoKID1Cn9s0FyEUHXhX7Q5kGEz90lxGVdipnQDbxY0L2Pwx79yl8EF0vc6N42VtrdeQGzAgDIEmpQESo9Dpz92CE+b8psOTR2sIFe0oINfpO97fh7ixldQ/RjEDCUgEO/w+nNTYICBC02EZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NmJ+1ME5HZnxt6sFXATaMprFYAScSAaOoecpG4QTkv4=;
 b=scXyULsmWTz7AQg5tRLtO1Mqb8pMGHRNs04sG+Zd+5QtvYTNVrADKhRvIuj43yq5hVVKhnzSjMGgRPw9oVMZwJLCkPwJLn0POP61G4Kg6Fkv5KZMi0bT/Qbl2lcfGT0VW9gCtNID2iHXmUNrI4BU4J4S7SY0TOJDTl3JGpr48+ZfES2l1D5yzrtXnCeIVcuby0y7+zVkALGS4okeQXY0dbobCp9pDkL2KkByCuTLpdw/F+VZPrEJkSCP1l+vsW3f+3jt3TAK01beNmk8LlvFLv/w2G9YCGgmTZsXzJVG6YiDYj725Vm0OVBNGV/vkjRpSh9zojaCrCyQKIC8+XtvSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NmJ+1ME5HZnxt6sFXATaMprFYAScSAaOoecpG4QTkv4=;
 b=oclRAtEVHC12/wmzxHTlOJGnQjNM8O+E1brkQBqCl9Rl0iG/BH1oEOLnOTQi6POBNsaPbua9nN8okpuM0poZziyW2pCP7vECP9yiCAZldpxKXEvYjk6NE3Mlm3xS87hxWESDvpmQQvK23rd7vmYIfqDcbGmFbibav1h08ibBnKG9baeIYLk2bh0OHhi6tU8GJFyYfJacSC8iBcjq3bYIsdtRhImzTOJo/G+F1g4UFA+TjRZfZQEhuplKFcXuMGQSRNGN48e6yI6VCSAWC+9KCNEppXcmY7heMtA1hjwH7LSIOvOS+HZHCNmoprwh62h2+eTWgflPpzYIl+N5BAeI0g==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by IA3PR19MB8736.namprd19.prod.outlook.com (2603:10b6:208:51b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 16:11:20 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 16:11:20 +0000
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
Cc: George Moussalem <george.moussalem@outlook.com>
Subject: [PATCH v5 2/5] dt-bindings: thermal: qcom-tsens: Add ipq5018 compatible
Date: Fri, 21 Feb 2025 20:10:58 +0400
Message-ID:
 <DS7PR19MB8883DF34B19B205311902C579DC72@DS7PR19MB8883.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250221161101.17204-1-george.moussalem@outlook.com>
References: <20250221161101.17204-1-george.moussalem@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DX0P273CA0048.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:5a::9) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <20250221161101.17204-3-george.moussalem@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|IA3PR19MB8736:EE_
X-MS-Office365-Filtering-Correlation-Id: 419e085f-a52c-4e36-62eb-08dd529260ce
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|5072599009|19110799003|7092599003|15080799006|461199028|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LokuffezQ9zMVUsTrPPOQvioW/FyA0CSQG1iFAUkIPgfngU3KEFQ+qaNI9iB?=
 =?us-ascii?Q?I/tpfnbu8WEuOq4zMovHg/8RRybFn/YHcAUrN/3fj0Qoko43++BSJuBymO3p?=
 =?us-ascii?Q?PbZ5AdKLN64PVtjOwzC9M4zP3ZL7W1WMETlwb+MOnIUzeAkTLazXhwkJX+Rc?=
 =?us-ascii?Q?6cmsKq+q9afpXxKt7Rj+I16DxFSnjubupp9c9H2f10j4RVDs7rgl0fg2Jm5a?=
 =?us-ascii?Q?OTj9ykIgPMFKnAETczGe//XpXok6ikGRKwVnqiT/c6vqo1/vNfQKUEleMd+7?=
 =?us-ascii?Q?D27G9uw7Ya48EbHEFN6+jCCq0EDV61aKgt3oliVBq2nlXGTu08Ay4sdScSSW?=
 =?us-ascii?Q?DLibumu+4d6M3JIESi45+RnqAIMaA+EoQJgCqlolUvTNASfE14llqFoVpHg0?=
 =?us-ascii?Q?avSDa/4iRydRPWHz1RvUUA6/YFrguvZg+9EM8SzyCAvg8HQIq0qYN56stHk+?=
 =?us-ascii?Q?EAzZbbgoSF69zALdaHj364KLpdiahTuQWKctXtjG7UpjH9dHxDrFh3TEMI8t?=
 =?us-ascii?Q?p43zEr4VPXMjXt9BFOX13HzcTtWT8QM86+iiGo1WRcyCYq7/m8zHnneppINB?=
 =?us-ascii?Q?FKjnDzjAwYuLEAKk6n9pAy2qptSC1W4FqyqqNvUb+/vgyQYpP1NgUrdhV2Uv?=
 =?us-ascii?Q?nwz7O3ZCXyIv9KWQTNOy4NAsFJyBQ8WKWuFw+kQG57TX/qz/JArFRTnBLMUy?=
 =?us-ascii?Q?wbN0mNXH1slBp71I4UJNHFyIamaR5ja+4C7cdBXfngvhEaZrY55meKqhlx52?=
 =?us-ascii?Q?Nfe9Sjeqr1N4IQI9KVYjkBf1kvoc7eYITMBYekG5DD6oIqg6axSAixfsWIfu?=
 =?us-ascii?Q?0ZI3gSD16uvmYmBoM+25k4/kmzjgMjvE8JVUosw7y/9o2GeScl5CdKXHaEAY?=
 =?us-ascii?Q?viIQyuWhGoE7oMmfUdKoEKgqD7F25fj+n5nbN+rEYzeD2bzNE1GsvBm+eXTH?=
 =?us-ascii?Q?15Wj15czbbUhi18L233RFNeul+fcK3WyYUdGwcnXn+2lcsQ0aJ2ujzzWRlu6?=
 =?us-ascii?Q?DD3L2ej9iarM3upEX9cSHf0Jwk+hMJTmORXIlChahzRloFyoVXtOb9fDhh3A?=
 =?us-ascii?Q?N5/0wN9mQUIjAtcS8khWmNkFhdGZ84X1KTJ7aLIde4ldMIOehF4=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SYTTpBA5dctfEYVYN9slIiQ/CRC+X5VyD1qXX9l1t60lyL22P55HUUQYPx6Q?=
 =?us-ascii?Q?Agp7CU7Uy+vfyY4N68FfpZJ1aXB815BYTtRPy/NYafa7WRRxmGl0nlMzBC8R?=
 =?us-ascii?Q?aqOR5XxXJo5UglG6zidhciLTrOOJAHmQfgedJrMWkdFFNKN0WQmQuX9mnJTG?=
 =?us-ascii?Q?wx/v0y9Sut2QxhqRUGuDAWIoB4iI8Cb/L5bvoi8iJgyCVHATPiZFRux+U9Ka?=
 =?us-ascii?Q?xBRxvtxCik3MAY/G8bEGS4p8fWFYZuFLzyYFevHE2ohlVUyPcelUTYSAwlBO?=
 =?us-ascii?Q?TcQ5XImOk8YXeNtOe+e7G7c6Rsppq8xbQHoyNqP8f677IqNdxIXt6bjPgP59?=
 =?us-ascii?Q?3h1+J2xcGLjTaoP+ODEBX4DtEzf2ko+SDpWtAyxFWaGQjdEgX7+UyZRnkpj/?=
 =?us-ascii?Q?CukZjkI7cFu9TU7AN+mtQ5Z39/Qgf9nb03gnbrrCbh4g/xPD6yzlPYIvAAqq?=
 =?us-ascii?Q?gcw5FtdihYFp6H4orYxCiSyMnWr/VZBhLH/lvuqONwIjxGDUzOoncER2GjVV?=
 =?us-ascii?Q?UkTNDX5+3Id4zvHjih2FfKNvvW6IMaU2Rkga/MkuDVHbZWW9zsa6vmmPGx8k?=
 =?us-ascii?Q?quOP8ipTGu5eZZ0Pnxa3s1CpfMn0Mzn4ieYUK4GlTDSRHdCRYKsqLJy8QqVp?=
 =?us-ascii?Q?jFRknYE1yTaFHQAJQh0s0WGm4hfk08AkRGdCG9ck9tLtZlzKY13dgkKK7coE?=
 =?us-ascii?Q?chiC3yfAA9kt8KArOk3zpZjUouzLhZ12Ck2tWNRUrBfikl09cEgVeXuftOVL?=
 =?us-ascii?Q?y1dmb8sgaOt7WDIEQflG5q1QvoxwIqt5auD+gSLQPzmSNxSNVHIKQK+Yzoxg?=
 =?us-ascii?Q?Xpxa2b0bfnvbm4L8m5z44keUj6gZ8WRyThNroo/Qz4V+VMZ+2A1Yf1C57i6R?=
 =?us-ascii?Q?ZicFIH/RhZ8Q5fRyFEgvlwIkMz1IeKGPWxceHXO8yuKh4KngMb7pIv1+7WyB?=
 =?us-ascii?Q?+L9oVy2us6OfbPKx46uqt8gTFFvPJtWvTNf7H0n0Cicu8wHfxuhgnpEXGbKP?=
 =?us-ascii?Q?PJjARtUNCehfbG1KIIGlqmdVg/AzAVUIZJgemllBytEnPblO3BcRH0oYZAIx?=
 =?us-ascii?Q?OoQ4yXmCHLVgNav8e1GQia4cb7mXkz8r7yGPu05gcwr40RkNzvOyZrBetliA?=
 =?us-ascii?Q?hTgNlFmygLIfEcbxILfPoi48c/edtM5T/iRgAQOV60dQ1EGm1JiEmdjjvrmR?=
 =?us-ascii?Q?qzKQEwLzrUNnQUbudaehSf+GBgnErafoyVZZ07oKhYrCL7iKyMy/SLN0YBZq?=
 =?us-ascii?Q?AW/Z8iWaWLoR5Sz5BoUm?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 419e085f-a52c-4e36-62eb-08dd529260ce
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 16:11:20.4803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR19MB8736

From: Sricharan Ramabadhran <quic_srichara@quicinc.com>

IPQ5018 has tsens v1.0 block with 5 sensors of which 4 are in use
and 1 interrupt.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index b9829bb22cc0..8bc468e44f85 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -39,6 +39,7 @@ properties:
       - description: v1 of TSENS
         items:
           - enum:
+              - qcom,ipq5018-tsens
               - qcom,msm8937-tsens
               - qcom,msm8956-tsens
               - qcom,msm8976-tsens
@@ -237,6 +238,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,ipq5018-tsens
               - qcom,ipq8064-tsens
               - qcom,msm8960-tsens
               - qcom,tsens-v0_1
-- 
2.39.5


