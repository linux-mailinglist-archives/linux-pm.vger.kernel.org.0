Return-Path: <linux-pm+bounces-22995-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1138A460CA
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 14:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A86C18999DA
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 13:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE11F221571;
	Wed, 26 Feb 2025 13:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="U8K3C3Gr"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04olkn2062.outbound.protection.outlook.com [40.92.45.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC861552FD;
	Wed, 26 Feb 2025 13:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.45.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740576260; cv=fail; b=psOYjcUTGi3YK7gDSfEE018a1ToJvAXIDVREtjX67oWmQ3KGcnKVxDy5hEUECKxbE7pkeNQ3ckDt1gCecdyYLfHBuqPtZs6oO+X8DE9GSlojbqsoTrWLwwnag2nYRrv94+/uCyCQN1DdhN+DAVW2zOj2S6RRt1wWDOS0CvVAuHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740576260; c=relaxed/simple;
	bh=mN8UJ/VoYCIF4FdKAujafvvnKTUYE37ttCZB1h5iwEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZlvSu6aKj+XSkCDrBE9qO6pDYJ1mDxt1LTThRumP++2aeoyyE9qA+QrxohZm20L+hlrD4adY2i0oq8snQz1yg/goDsjXIsJVUoAfhi0wMo7C9ccZgsQAp5Aq6S2ugU+QL080cx9rwU01VNC3CgJp4Ek3nfKMZDQMBSKyRqPThEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=U8K3C3Gr; arc=fail smtp.client-ip=40.92.45.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LYZmuSLFe/NQcOW2ETIFvs4o1D9RyxaEAVhAsfmcFEjnzhWo0Z6xu4hllP1//MDrvANFlLG7Tw+43Kx7d2zYrJj0FyeVhbckGdO1P5I8bT4mfZrTuZd+w1lmUAoMGeJiueZKOw/rVmmUPW/Pa2ZOeOjqZ/7ABjorano9pXeX60Hnj9IC41+sTYNg8XHaEUASobCXX1QGf4qXjujBy3gTpKCpAsIpZvjJp/cgeTBQ3i9QUhU9FIrlcIHWG7yvMOWuUkSlsjFeA31BrX0TTtjLsjT444BjqoBp9t/P37c5JimIr8YTXbksftfmGwJHBuJS6w9MxrTgHa9fDCPTiyhEgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qLI2YsPe4HnhCW8A9uCoEvILxdcQmoXuoDJrVeio8MQ=;
 b=NQGsNUx3xQ48tQY/cwEKhx2QEz7Ql48KNf/EVcM47Z80swqcvntK1mR/XKSsy30h9lrWQLz0ka7saeI84Vvg65C1ELc7ixH8Kjow70/b63VAI98rTpePl/XGRXWDs/8599YFY6wKodJy6vgWPV9tNTigaSY9S9xwQstfqXjOUBjzvvVnrD9U9vH1iPrtO9fkFqmbTkUgT/SYV88A7HJ3PpQr61XwtkNyNJAw7f4fS+8IE44Q4vwgiPoP3c9+b/skTi0xJS2Tn90y4pFTcxvonwsCBmKKMwnN5wNFH94osUCyWNEyydxurjuzp2SzN3Z8TKS6qfng/vsx39GP8j+wpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLI2YsPe4HnhCW8A9uCoEvILxdcQmoXuoDJrVeio8MQ=;
 b=U8K3C3GrgO6bpHpV9GOpdVHSj8ndE2iHLwvzjdo8RCm3mEDQ1/0828ofP+KytFez5AmupO54YYwYMqY47Y8A1d6qUR+0akReouzP+bSNPhJlmgVruZ6BUoDz2jkkMc1IIh8H23S4lXYY31ggNGCgg0AXCBK3uDuYjP8m7pNXlsqQurpNzgB8Hiur8N8eQbiqXwkrpYSQxY4N3aR/Nh9ybAI+VlYoOGZ/pAnIuVzYnTeFKbatg2sbOUZJ/E2qFU5WmqipqBrvVk1Co9R2goKIqJ7nDPUPuFu+crQzgv9DDFgNOSy5Z7MoRAnt1hX9nZPMgpnCudN+pduKpN3ics7jCg==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by DM8PR19MB5270.namprd19.prod.outlook.com (2603:10b6:8:4::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.18; Wed, 26 Feb 2025 13:24:17 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8466.020; Wed, 26 Feb 2025
 13:24:17 +0000
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
Subject: [PATCH v7 2/5] dt-bindings: thermal: qcom-tsens: Add ipq5018 compatible
Date: Wed, 26 Feb 2025 17:23:53 +0400
Message-ID:
 <DS7PR19MB8883CBF8589875B0C70FFB699DC22@DS7PR19MB8883.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250226132356.9398-1-george.moussalem@outlook.com>
References: <20250226132356.9398-1-george.moussalem@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DX1P273CA0004.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:21::9) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <20250226132356.9398-4-george.moussalem@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|DM8PR19MB5270:EE_
X-MS-Office365-Filtering-Correlation-Id: 241e7207-2c46-460d-331e-08dd5668dedc
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799006|5072599009|19110799003|7092599003|15080799006|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cdcBEdJyoc8td1TOFTiIjKJz4WFa+Aud4mgRK0TJg3mT2EK/xLw35i8ORcrX?=
 =?us-ascii?Q?VjRfMwhcJLzGwSt37LKXvND66QD6qVsVwki0nbpFK0fpf3iq80tD2npu3SPl?=
 =?us-ascii?Q?A3BxSCQ9E70+4eiCQMzyArJye4xlIeT7dYdBDwRayNPAoHbyzxWIdipdiOLE?=
 =?us-ascii?Q?mU7OgeilwNA8l4NEuhUNiQR2BxedEPgsyffuR/OEkCnsggap6pxom/K3Wegj?=
 =?us-ascii?Q?hjUyoyVh9Mdi8qOJkgivhmRvInioUcJ3ADVF3i2vZCA6OyOZZM76lM+uU5nX?=
 =?us-ascii?Q?efjFTG4CIw5z/YpQXSaKKZnTw8iy5T+Zx2170zJBFZYL2m54DKOqWVnPy/1T?=
 =?us-ascii?Q?HS4v2JXUFvst0R9Rq832X1fWakJdFh4uSg5MW82wZOJkpBO4EUhNnvFEdmdV?=
 =?us-ascii?Q?qLbEgZSkiUnNJd9712qTcCLoBoQpt5Kl0KJv1zNisw+4xAavk7ieB7kKpIZy?=
 =?us-ascii?Q?1q1Ga5Bl7bCwsw7AWz4KjbUJl7hI7fMAcnPSFZXca9D8gmtXxPVtsynpZuvS?=
 =?us-ascii?Q?z7fUKQXcV1amtiFSuS6t3XI5VsRKf5ojVZI/NnvVvdlsv5Bdk0snE9Fc6LaW?=
 =?us-ascii?Q?V0XLNJchsqfBoMoQ8bFZVukuR/yfvngyGu2/AEgUU2ekYV+DEDxIoejxY6ZS?=
 =?us-ascii?Q?GbYCNnsGWtcHnqFfy860ffU1AJ+q0WXBpntyunxmLDHvxp8XFcgSno7h+VH1?=
 =?us-ascii?Q?Zz7xWeHOoa/4AEOh3XBnnRNeXtmk+KKK8hZr3OepnX2bvE1gBJNQFeb9evh9?=
 =?us-ascii?Q?oLEh1NTBdjyIDlppMUXG+KtI+xhGdnHbIkfGsVkfXK8/tjo2okPJEjGv0vjv?=
 =?us-ascii?Q?5Nx0YgDRqa6Vea+iuuJ7KxBW3fDu1jTaytHne0x+z3OVyCHCVL22lfjam5mg?=
 =?us-ascii?Q?LcV/e8XhKYooR8x/1C5RwNKHTuKP+LCA6YCvlRIQZ7Uxy4895vk/cQU0+7g+?=
 =?us-ascii?Q?TpS9SKOwVKOU/eNYp0JJaP3sDCuoNqQv+Mq5QBh7cn+8KXYpmZ/kwSEbxau6?=
 =?us-ascii?Q?4BUdQB8zhJYQI4CecXwl3PKJzsYNtAOXgFoVhff90uj7HnM5TLd+pa87ffev?=
 =?us-ascii?Q?Ng/G7bheiawDiPvMT+WAF2aXPUUCDbbEgiuNSxiZgcrh4GjCHzY=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9T7ioUkKNgE5+jXGTtLrZmh1EJzaHuU9Bywi7IB6RkdTI9kZHuRa3izF/uM/?=
 =?us-ascii?Q?1D4Xh7x1fGENcwA1JDpFIX2PV3Dk2VHZlSuyhQCwkhowh1SUctElPn6YUwVT?=
 =?us-ascii?Q?WXybGKZ5qlB4JyPrmv8UjHpwrvvcmRTzEOkeG2fLmsT8b/bkxlaHEuMboqsm?=
 =?us-ascii?Q?Kx5K9LxluiibcewEYuGPvU16BEq8F+F2CPrLeKQlb3lxBWUqVB5qMP9XPse9?=
 =?us-ascii?Q?+wGUfNhiTxsbu5tm8BGohaXnbYUebKn61Z0wacYuuF7T7yuMmq6Tk6Cb+I1g?=
 =?us-ascii?Q?2cii+zUWOqaJlYS1VpMR+zQjgvNinVC9SU08lA1lNkDl9MLGeyrECvVWjfg6?=
 =?us-ascii?Q?yE/BMCq8Fyhe+9BcX89mG2Nb8+++nc4Hy0cQc0dYbJq+bmWaFI2wYRo3oX/A?=
 =?us-ascii?Q?gzshQVRY0lRDtxbOP9kmE6/zzIOYL4kG62cjACer2j/H5rIL+NdPldc2BOkt?=
 =?us-ascii?Q?9hAZ7b2q7xXjTGCNaML08tcAPOmLa9qkR51lE5Fu9DkY/SL6T0k2TyBiWTU0?=
 =?us-ascii?Q?hmo0H6PJpu96LmQBpuV+e7AQexXasK0+miiYch1Kb4DXLGvv7HzGKCAvvJBl?=
 =?us-ascii?Q?fUI4EkH7aBr8896On0Q0AjgDcNECm4eHKw6TKh/oVaqKDCDXb62pIvOH1BPI?=
 =?us-ascii?Q?hUCZ+mYBgikt09+FCaGnw4tpWsOQ+seRSJvbSibqPVuspgnWz3xte+fa205g?=
 =?us-ascii?Q?4B5xbZcOLrEhMLlBbrzpcJEp0oVI8yy5/i90b1i5gqjujqTlEh+8uVGEYzpS?=
 =?us-ascii?Q?D/oMmHkFgwjrLGE0q2hMWWPCSpzVye4aLdTpxJtvnbtGFpP6tP9U8qEolDUM?=
 =?us-ascii?Q?fPcjca/bq+KDfZriO8APUWfs+VeRvNdZ9TvV8WDs/uPKwZGIF/rZ4Uy1DYD0?=
 =?us-ascii?Q?2/APmB5Y51kNik2DPxIeHz1sRhItKHr/1ldzwWxfz355agRai+tOn+pdW+hM?=
 =?us-ascii?Q?ZJTgqtBD1LuqutLR+H3gHd1LHdenX4lnaVGJW5XkBR/pHLlv6HcWFH5HdDK6?=
 =?us-ascii?Q?3N9aU6yIPeUB77YfFqa2ocG9c4MiogrC+ZB+hwLzV57kNOS/m/6PrVH8setU?=
 =?us-ascii?Q?WHTqpp3j5lW7pBvEIl54rGFx17GlLet1e17zZF6sFJ20ZTRrTBFgsp9rHL8F?=
 =?us-ascii?Q?rlDAqM2zJvnwwvzqkUDnEdxvCfBQVA5pvAP4POD9wiIoSDAOodzKM27Y6yxg?=
 =?us-ascii?Q?DXaYWatNfj+mrwsNkxaa+wCAgExIBo+2n6MvkM8Ydt0gXKR+QNgL2hbyjAJ3?=
 =?us-ascii?Q?sk04+oPVeWcE5MiW2N5j?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 241e7207-2c46-460d-331e-08dd5668dedc
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 13:24:17.7528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR19MB5270

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
index f9d8012c8cf5..0e653bbe9884 100644
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
@@ -251,6 +252,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,ipq5018-tsens
               - qcom,ipq8064-tsens
               - qcom,msm8960-tsens
               - qcom,tsens-v0_1
-- 
2.39.5


