Return-Path: <linux-pm+bounces-22769-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9008DA41529
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 07:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBB0A188E848
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 06:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDAA1C860D;
	Mon, 24 Feb 2025 06:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Y4tB3LkU"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2072.outbound.protection.outlook.com [40.92.19.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAF11C8608;
	Mon, 24 Feb 2025 06:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740377577; cv=fail; b=G7U77ZkQ9Tlhy0yYNnsZRyR2ejgPib+xNSiD9hLfMkZEpO84CmN3mGXx4fUAVPhr70seem+foIWjlEiUjXoR3uyN3Q+qVo7XJP0s/5hSyTwTC/LhlsExSGqvciXsEEmOCLyhEIS8WKfCHuCvcXByb+/mwSyMmXZd36mv5DT4FDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740377577; c=relaxed/simple;
	bh=nedc5SnoCsWZEHJ9F3vDuFGQUCVynsQYdytBtzmoawc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a7cSlbNM8EBe2u8yzdJKT4vzfUPDlPuB5DUfKogmTQDRabA4wIPNmIz3xAovwbhkflKhHGIPxUgDIYj4akvEels0T87RqENQMXP89CKlEeG8nHdwyfb/sTu5UjAcmxsga7y5+qrJp1uTBNj1L1kpbIA0E+w+mcnWliwcjqC1Ru0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Y4tB3LkU; arc=fail smtp.client-ip=40.92.19.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a8VxTd+w5NA2DBblv711oixobKGoXSnUOC65mLek+1q7HQxEpo05aX7OrEyiqaXdzuaaahovBdXh+/Cyqgiyn/6R1c9vOt+bD3rJD7vhlqNO2BSjLI6GUdmmn+GCrQgVgUhMkq/aetNL1IiEMO8UkbJNJPF2I2isArNXny5dxVYnFOdgs9ytYRw2oGT4znRrXkHkgkcbK+L9ZadQvw4UAXLsa0C0YUOIfvIQgGC99wUY3EypOmykcV/mwSTucefbmDtieVigG8LcKSIliJo8j8abqrkqqBV4ZQ4zWJesi5+EostHsmQNc/lAG5YzHSQAvXnyBCwOat5+oXXZ7wqKbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NmJ+1ME5HZnxt6sFXATaMprFYAScSAaOoecpG4QTkv4=;
 b=lUf/12xSwPeryVwKU/1/bfp5b/OhplM84jVTz8n7e4G/k4+kp9zo3cPemG3YJZTMq8Lkx5MsZrqGHQasbGXnVXgaNgv5ZKVQQ6Fzy2l/mPtkS7L8tczbHPuCKdvv6zukgdM8pU6GomBUSRxPh3YtA/DloFkPYZbQcqbIUs6UR3Gi7YkuLPGLvMNE6wEWrZa/Tj4F41Ife8riiH7FNArPCEl1ncX94UIZbSxqJ5PkjhwiBuJik9SYUwYmQyGjSKYx4zBHlsNSz7SO62yAgXOGsTJOqR0ytsl2BA4qz3E/vMe0T9IzVfZKJbVEHCKuxPlFswkw8AkWBqUHYZR2Bs6uPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NmJ+1ME5HZnxt6sFXATaMprFYAScSAaOoecpG4QTkv4=;
 b=Y4tB3LkUvQyewEurVv4/eAiPUZs51kxPLEwRT7LGXbc3nLMwj+2fr2XgD4OPquubLbLNN/pF7MwqQU8EdpFQw6fJN/EsHU0TBqgQPrO5JwL3GNtxN+6vSIGEEwQlkKLb4Z7k2TTZc/MrFoAyQJQimgbfvRkUMmiMMbTVT38O9X6eh+SukPkThU8vV2mIh6CFSDmcapZMnh3UtAYf0MRXKtBYlS8FYzg7AZTHeE9XFwnqry9j88aGFDcFwe3KaNnJc3XWtokKQIMjyEaAnZ9tWnBkvOJ5VhCOsJAPuHvsF3CmahhqPKalrpFT8LS+imgtqjnApLtLUjdTgMEag84YkA==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by CY8PR19MB7179.namprd19.prod.outlook.com (2603:10b6:930:92::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 24 Feb
 2025 06:12:54 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 06:12:54 +0000
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
Subject: [PATCH v6 2/5] dt-bindings: thermal: qcom-tsens: Add ipq5018 compatible
Date: Mon, 24 Feb 2025 10:12:21 +0400
Message-ID:
 <DS7PR19MB8883A7E4ECFFB083C2358DEB9DC02@DS7PR19MB8883.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224061224.3342-1-george.moussalem@outlook.com>
References: <20250224061224.3342-1-george.moussalem@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DX0P273CA0052.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:5a::6) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <20250224061224.3342-3-george.moussalem@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|CY8PR19MB7179:EE_
X-MS-Office365-Filtering-Correlation-Id: ee53fc43-a9c7-46f1-1d4b-08dd549a4648
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|19110799003|461199028|7092599003|15080799006|8060799006|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rA8s54Jp6jjZdWDdX0+uqohWKzOsOhAoE6A/HSE5W/UV2+v95Fo+zjvapMTL?=
 =?us-ascii?Q?iz/+6OYQvzBKMDGMJTiFMLIV3pECS/BzmSD66LECW2tN5M2WVzyTbNs2A1U8?=
 =?us-ascii?Q?DFWOiBGhd40+PFjoCSj/L/4EbJIcv3FoufbPSQ+qxztna1O0A3vh+ZYQ6hyG?=
 =?us-ascii?Q?4yiqNwvNM/Ir9o3ar+HQmWhnb4oRKZaCkpa3OGlddyQW+vj144l46skdrxoI?=
 =?us-ascii?Q?OziWgKuBUJFyizg/jnaOJeCPCOhqdJfoISjcsmq2OSt3TNp9fu26TYIyvg6Y?=
 =?us-ascii?Q?D/moLaLGaYtRABVOB/q3CtohYbNp6ku/+fsciBmXabERLJDJo4v8qEj9U1Np?=
 =?us-ascii?Q?0OqiBy79mJ/0R+remoP3SQCLAhaCNo8TQxshLpSuHc8ETi5bbRdrddIi0gZZ?=
 =?us-ascii?Q?XMlj5NhtQzuvP1/iQSbWZLeAhTZ/3dd1c/mRj90gfWeTvWfuC+AkG15ut5f7?=
 =?us-ascii?Q?EgD0gnR8HBdGZGMuQKkHsg/GZ5uo+ZIy30ZrIpntkpkvxcexvkUHVU1WDAQw?=
 =?us-ascii?Q?gMpQABnpOByXkgsAIBJIX584n+SngDi9vs9VEMx3iEbyP7O4Jm5vIsO6vMgC?=
 =?us-ascii?Q?YccCv0xuD6yUAZ4RU+hys9SwjwLbwCxBi1mFxMMlFBDdVDMn9OxsoQma6ucJ?=
 =?us-ascii?Q?K2DcB0ChELQuxo4RAwYpjPYLFPQa52NjAugX9UsdHCrT/rtx+uRm+Y5JDi1X?=
 =?us-ascii?Q?Jo6ik7xU89HgKksUBbhqSchdEm4FRSJG4IQZTaE/IO8Cs74tutZ8Y94Hz3eg?=
 =?us-ascii?Q?32VneWMsuQ6PVj0ZS728dtTGN1+cpHm/KIyhEtWe8PuaTVb8WdELzO2sLtWO?=
 =?us-ascii?Q?uK9SQrFXWSGPwQFtbot7G7qh0PK4lNwj0vbOxEplYExX4SEh1/7tQ0m/AM/s?=
 =?us-ascii?Q?rF/lqhtI0cYi5e1zakd8O50EOe6/hcjglsNZDS7rLo+fMTOcAlWYIfhoTRXr?=
 =?us-ascii?Q?oZrx9w/0U+S/Ufftx4baJ9R6haYEBsY57w4o9NBgMBVfENctI1Kc8nm7cAu6?=
 =?us-ascii?Q?EsUpYll6d/Ylqo6wrlpx79gP6bR2clEPNVlbopfimF3lH+iYo3eEaskjWY5P?=
 =?us-ascii?Q?etqhzEMnmB+eJ6FKHADpsSTwcFXHuG0q0ioP7ocT61SvvMUqUiw=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jjWdCahT8hUXnnrwjPc8Rugm/1ll9hWmUA7kV8fmTSWLbibLwLQ3KwQoMjXN?=
 =?us-ascii?Q?U2wSAkrbBGHoT2vNreaoKdXjgMGx1D/zAAov9nwlFc29ESUUtrxS7xBR4reS?=
 =?us-ascii?Q?sLlPLGoO7C6OKSl9yLAJrJjZBgN57RpOlnSfF+b0kyiGXxTToSQ8322KXa1U?=
 =?us-ascii?Q?a86OImA7dx95/2ZLaFee9lZN4PvxaX5+VHpvgpuSGpZLgoA54PXh6q0WKPMz?=
 =?us-ascii?Q?FKvecwFUR87ulR9TflWYOWNz/QdOMyGshSjR9M+FAzVXPntnV5CYcuDinyla?=
 =?us-ascii?Q?4C46ENtJg453rL9/OQO05B8vcymd+dxvf1yrVT2hPXQcxLIhg8Z0P4C4I6fx?=
 =?us-ascii?Q?r/+1KX/AuxTfFu+u43CHNjkym0XnZJ8iE3LT0G9cjwt8cpIsRJEozZ+o4sMW?=
 =?us-ascii?Q?/hW7qxSntG86Cj4ouuB+fzvY+28ST6WDGiuYhq8IUaXYR/HQamG5xQQ7hCZE?=
 =?us-ascii?Q?Gb6w3u/bbJB/2/ZfwBcr7sIkzR8eje/wg6oc00O758BA82IThskglJznPTLL?=
 =?us-ascii?Q?/piD4npbGbpOzbXncBfWfhUIHjV1RM3+1RphP2c+xsAxymh7R8C7K1GdqYy3?=
 =?us-ascii?Q?HT3hfrq8aITKZKFmwhULgFH2j2GtdAZA61DzQQIonO1dFTQPRDEQ+jiTfPq4?=
 =?us-ascii?Q?wrpmMzCXRdkgxOwVR7sr/aSMlbxJZtidcTBo7ZieXTAkFOFmekx1ElkH1x3D?=
 =?us-ascii?Q?owTWw5Iu0pbY9mgRgZr/V3faFHxPduT/JDDjWu6FGEzB5c19F2VyUKx05J/m?=
 =?us-ascii?Q?ayH+S2OHGHdSOMRTT1Ct1bINcLoIINOx8xX2xNbZRcOfa+xQPdcp8qpfNW/x?=
 =?us-ascii?Q?HzHoQ0vFqD5RFgxnM9bKpdCS4fs96iO6YPcEnOuSdU3Y9c9ryuuz8g9p8qHj?=
 =?us-ascii?Q?1eIdokX+cpGi6XwfTbBO5O7MbCIqRYFSYh7GdX70G+vvMN/tn7KfQOKIpRIJ?=
 =?us-ascii?Q?NJDvzqk3Rg9n9dK1akTH+J207zqvY9tRBE9bVTo8VlJsOIofa7l4o3Zf18Um?=
 =?us-ascii?Q?z0mab21tiHBDKh/Amsi7GVencOHHjtPIhIVVvycn0SkmD4L8gJNPKC1qXiBY?=
 =?us-ascii?Q?L+wl/fW4mnoiqxNFwj3PLZDwagGLpmELQ7vDOF52Umg5SqawMN34XQ+S//Qf?=
 =?us-ascii?Q?bdG8D+KNaWYid5ddX9I1W71er5b6jhqLywHxLW9NqCvq9iB1uupkTR8jx0DL?=
 =?us-ascii?Q?0KDlcvJ3ApO3ctYaVlgGsqpcLACQHNEylrLnCXKjt1/OZX61SzcUfdguBuXd?=
 =?us-ascii?Q?a5EQDvLd+hu+3RNquSIq?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee53fc43-a9c7-46f1-1d4b-08dd549a4648
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 06:12:54.3405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR19MB7179

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


