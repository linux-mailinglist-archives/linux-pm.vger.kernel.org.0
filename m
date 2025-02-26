Return-Path: <linux-pm+bounces-22998-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEC0A460D5
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 14:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BA9F3AF21C
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 13:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CF0221732;
	Wed, 26 Feb 2025 13:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="I+XYnPTK"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04olkn2037.outbound.protection.outlook.com [40.92.46.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BB421C19F;
	Wed, 26 Feb 2025 13:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.46.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740576277; cv=fail; b=ERlPpLqVut+ML3w/997YqcSiomWSEeR0mzCRxdsCcyug9451TGfcu9lwRzF1L724j3wXX0R0edRp1Z/kx6RTypc9tVspUgmcOQBoSpUDy79tN6j5ABQcNl+Z5MmnHQ15z1M83yxjpEvg/wl7rmOzKr2IAOjl+/5Zb0zvZgY8Pb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740576277; c=relaxed/simple;
	bh=ppT0eVV3GiEqywvKxT4h6a+kZQUoHGIBNyc6o2VeDD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EGbmXnTT4MufRckeyJC58dXKfLwLVw+la0lDkDEo+PdABSuZ/7VPHCEoOYP21KlYZ3Tds3o3NHyE05veuYua3XBQkPzTzzM6A/lTF194XITGk5gG8bUXkn/VoYKsww/Otll6Lx5SGliI2/wCsfso0zIIIq+9aG9ROpFaC6I3keI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=I+XYnPTK; arc=fail smtp.client-ip=40.92.46.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JxRck60bNpC3CYkfQV12qzs/1edxByznJPhML75EkudAxFWuxzqinsME+D4XGlYh91rLiNSi3hAlgWXnxpHpcjdFLV5RvGxNMjLv5dWY3ieoTVm7eMCkG//+/KvnnNJhRBWoxSeLG3UrdriQXm4rwomwoJa0qSf2OTgAKwrAAU2KDX1ygtM++ZIHJiUex0ENLDwWCG9H/84NY2AxbzVgsTjlkZrNbA7FeouoRyhz4oKxfsudTNtypkGk3vkr7Tmt1NbHHK0r8hXPJqacTLKwFPUQjCZZZfp4ELlfsf2qiZUL/LIFpVKoLCfObD1bqWUofLxomp8zbRDbqSVKlT18Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3q35Y5tAw2XBoubkQYCuTrUDorBQzx0Jkmaum1pDt0=;
 b=wzvfS3ollBz/tHBe4H/4m7qTJSI6mIG0WUR0UcaYKcBRk8ZXPpL4slhCX3Mf82boJh5O3FRp/KS2/OWZLH3L+77P2qHS2JXr6S5QkKgDNOJyTsbgKb+XKL2wA+I4uftMkPdgVlaaFCqg5jw6swYXZ9HMejJ1sPhncIgAMBiI9ai0txznrpwoyC1wisKRkPMENCqs6dW2PzChXaHDUT7K74nZ7un2HVb3bWUNILECIcpa3AQQJVcy3OdPF9xf0lBx5dxYlvywHDemYFSWNfTjOqRvOoClhkcXurhdtjYzUIx17bYVaFf2EHVCcoogd/Joc13zEIf4gYCoVv1e00z/UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3q35Y5tAw2XBoubkQYCuTrUDorBQzx0Jkmaum1pDt0=;
 b=I+XYnPTKBFGFG0AJc3Eici4hw23Q6Q8nBDggxIp6ZOZ5hdcHVaWwCs+no8AwxDImPmA9hebWdafOvpmVev8Fn9c8Ts8ZT7hvfCd/2X7HmtO4sxOSjM/DOjKg0OfYithz39rHH1iJw3bGnLz/qgoP+cKy5FJWE4DG5NCpnKm6RxvlKwNSHaWNJWJOneckHZw9UAj29uYGcEjh8zS5JDzRRSUbrCSDw7F4WfjPHDurRQAGrEZpPcqFIOvLT3x2jwArKrGvXHbsQQ4BFycSstSNc9bZbgpjz6QJsh+mZuZ2ssuAsi8PYjD/yBpRait3meBOiwlWVSoVgOjNw1tRUIMGlg==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by DM8PR19MB5270.namprd19.prod.outlook.com (2603:10b6:8:4::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.18; Wed, 26 Feb 2025 13:24:33 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8466.020; Wed, 26 Feb 2025
 13:24:33 +0000
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
Subject: [PATCH v7 5/5] arm64: dts: qcom: ipq5018: Add tsens node
Date: Wed, 26 Feb 2025 17:23:56 +0400
Message-ID:
 <DS7PR19MB88836BC0B4FCDD9C122EDC859DC22@DS7PR19MB8883.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250226132356.9398-1-george.moussalem@outlook.com>
References: <20250226132356.9398-1-george.moussalem@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DX0P273CA0030.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:5b::7) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <20250226132356.9398-7-george.moussalem@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|DM8PR19MB5270:EE_
X-MS-Office365-Filtering-Correlation-Id: 017e6d27-f9be-4e4b-1674-08dd5668e824
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|13031999003|461199028|8060799006|5072599009|19110799003|7092599003|15080799006|3412199025|440099028|41001999003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hhtQHZAG2VGHj3zw1o3IfCeiAwsyKvz7PNL6PtBiW7lJTbd3/TbTz+ntgdGW?=
 =?us-ascii?Q?fNPDy4XqBxp2YFE5uhj9E4XFDI1ms0smEqMtMoB+pDiVcGLcLstqYaNyHtJJ?=
 =?us-ascii?Q?Vr+u9g+FR+/VXhTo0RhOKrE1csZ6lV5OYfNxb7AIK25GjMkKWwGpHVFFPlqy?=
 =?us-ascii?Q?MX2amtgKreJScxd51/ex46Pdx6HU7zrDQIAakcfZkGgLU2NlFfEdh/Ubv5PS?=
 =?us-ascii?Q?lpEecZ5t42YEvrRBCmGwdU6PvZIUwwHAlyv3pVtsm8zlvlywS6yY0vsvZcpk?=
 =?us-ascii?Q?FfxPu+dipTNT06Vh8st4TEdNHOlO9ZLTa52jOn78/sxmN97dNEQCx832LiOh?=
 =?us-ascii?Q?E+kKM/Q8qfUPTc5gjS0f4F6mLMovPlcxKuoGwOR654l9xuE/lAicGBp4Bic7?=
 =?us-ascii?Q?M3xaYPBz9k5/q/D/VQBKr4UJbK+7tFk6K1vVYWtADkyo9ElgQmJTzsv8/6XP?=
 =?us-ascii?Q?jiaHL+clQRqwnQlSsGTBIFINBsQZv39kHju+yLghdHYzPphehgARF+sWrN+m?=
 =?us-ascii?Q?lMvVv2nOfKEM6SzhIJ52x1XfO1hmhjqLYQcLswjBLMG+r2B4tedRkzzdOMwK?=
 =?us-ascii?Q?MezU85WSP+0iGXmgmIEbAwQfonMwHK7sEI13DnEPMdIfj6+9XQ/FjRN4ph5s?=
 =?us-ascii?Q?25p9a2NbU3uVWaLpWAjH2C2bDb70QshyjQqxYVOKMQMW+EMGjzLiRfigJa3D?=
 =?us-ascii?Q?cb+1szjTHfzMGVksiOXASWxs1Yi1q5+sQQVjkcf7rsaLlqfbEl1yFPv8AkzL?=
 =?us-ascii?Q?amHzuISIP+q8OPamM12VV84ofs4UrjskoXx2jkZm4lAMyK15RVtIQfw4f5Nz?=
 =?us-ascii?Q?s7WJleqOjeHex0/cdnszz445U0LU8aS9acQESXBxq0d+GTBTZzzGTHFQ8SRD?=
 =?us-ascii?Q?qac+3S0oJJeY0ePBNVd6z9KEoOAx3QZrduMHBh5hBDCx5XJ+fIq1z6WPT9Fr?=
 =?us-ascii?Q?8KI74zUdkn3zWO3YK64uUSVybMYn1tNLTr1FdWjh5zrYzgYRzEt3ZP0sASSj?=
 =?us-ascii?Q?TGQexqQ5NOlzdpZ9DYYejTggVYvCUYpZ4u+TkhbADfdiYXmSNXGvP4lQaIdu?=
 =?us-ascii?Q?p543OLzfsHt0qGt8aC2tG81SNlfOh9X1ej5/+MiQ6TLpPoBOYBbqcBPm5kid?=
 =?us-ascii?Q?+ogB8aSc6paun9vjeCQ+ahcRO+zVRRjxQsH+HZ0JBdRxx1wHwueZomA=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nvZNTdT6U6ln/TlDPsZ9TCMK7unFvbe6UvIVCZ33RucdYj3SmSOB2KQf4uvp?=
 =?us-ascii?Q?P/smTmQ5tUNtgOcCv1midj6KCormvMQRs4q+DT9Ybx42c+Qr7DdUqF0ojTk2?=
 =?us-ascii?Q?OgDqpeJq/TTDtHEWoSyNSDbUraG3DDKqFzyP/ti9jgMWS53aj8nbNAz1pZHt?=
 =?us-ascii?Q?DepmATwotYH9M3YyG/dA4cChJ5yQjR2ZZ7dE8JmtH8Wac28l+tcvCXT7sJNH?=
 =?us-ascii?Q?l8iWgSmmsNAuEcGf6TMteZKmac4Yo/RFN1jyUr3kU6nlahQh9Nca/XqdPsKv?=
 =?us-ascii?Q?fzWQp1oKjyt/0Pe+nEZmuV4HmFcCGJiY7p/mR8xf+zgrvstG/3AyAd2gqP1/?=
 =?us-ascii?Q?enzeP0HVFWcnWS7lLVIHTe2qlvKLpc/T1WKnao08yJb0mgwhIkpIDoQP5vXY?=
 =?us-ascii?Q?+MlejPvkoP34qLQIrVf20Z5T3EvgrT57kAxR4AGHrJ+5t+JyLSRGFKavcb3O?=
 =?us-ascii?Q?kpoPF2Vov+lgdAW1PY0g+AW1VWnICIaW8fHnkPAVk6ZT8x77P2lwPvYQx7nz?=
 =?us-ascii?Q?uGDeNJ3/n+aKzgwII6/NzRqSsPeOE4cjBxRNuUZ8oyxSP9hC/Q/VCi07cvPA?=
 =?us-ascii?Q?o2SMSwOIgmn9B6mu2OXulUlGQZVsBK9LHy8Zm5mOGVPZDuLc3efoDOX2pNOB?=
 =?us-ascii?Q?518PnzevKgRSSa6Jy3k6IumEOIJY+HOreT7Spp9QGC717T59I4Ef8CvM/Hr6?=
 =?us-ascii?Q?G10ThxkNeJSjMe43JSV1cp1w7jPt8fAztqT3xjrn4tcfs9L9Osd4jlQE48II?=
 =?us-ascii?Q?hf5Lz1timizi4l5P8pGKeYYW0DEZWVTngXf0OFZcnALNZ3M/wo01P8QNKBtt?=
 =?us-ascii?Q?U3XAr61ax1XFTUCcCmQUaQB1lup7mRteESxmFExIjmSADfSNMHTaZj3PJq7U?=
 =?us-ascii?Q?iDfAbAqvovrFtN8d8sL2Bwk3zjSfkV4xbrGUdqYGYr6zcZb1XS+mRPHBsDnf?=
 =?us-ascii?Q?ZMKxPtCYW8e8ZWXJgDgtvQWoznigiroWAX2BwQtqsBn0MsQgEe0zXCYJe8wm?=
 =?us-ascii?Q?sETQZXr2xh8czw99/cqtiO+1c2Dc5AXi/dBPCCZD0AhOXQGE8g9aVvswH0Il?=
 =?us-ascii?Q?K8L3ing/ISQwN9daYPtq0ivzhtlgOLq8WgNT6/kpg7O1oflogW2UH+8Ji37f?=
 =?us-ascii?Q?UGBxg82WGAO5sTrfsgpoKms8e68B9zgYINWYqvv5t5afvmS32DNIjvNv5CMR?=
 =?us-ascii?Q?w6Ov840jEDa6gYKtwsmWuS3HVmHcYVZlJ4lyONa+TD8w4u7/EMZL/yxswf4b?=
 =?us-ascii?Q?RZVRWcPLQTgU/fV8TR9H?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 017e6d27-f9be-4e4b-1674-08dd5668e824
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 13:24:33.3095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR19MB5270

From: Sricharan Ramabadhran <quic_srichara@quicinc.com>

IPQ5018 has tsens V1.0 IP with 5 sensors, though 4 are in use.
There is no RPM, so tsens has to be manually enabled. Adding the tsens
and nvmem nodes and adding 4 thermal sensors (zones). With the
critical temperature being 120'C and action is to reboot.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 arch/arm64/boot/dts/qcom/ipq5018.dtsi | 169 ++++++++++++++++++++++++++
 1 file changed, 169 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
index 8914f2ef0bc4..91c062cce903 100644
--- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
@@ -147,6 +147,117 @@ usbphy0: phy@5b000 {
 			status = "disabled";
 		};
 
+		qfprom: qfprom@a0000 {
+			compatible = "qcom,ipq5018-qfprom", "qcom,qfprom";
+			reg = <0x000a0000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			tsens_mode: mode@249 {
+				reg = <0x249 0x1>;
+				bits = <0 3>;
+			};
+
+			tsens_base1: base1@249 {
+				reg = <0x249 0x2>;
+				bits = <3 8>;
+			};
+
+			tsens_base2: base2@24a {
+				reg = <0x24a 0x2>;
+				bits = <3 8>;
+			};
+
+			tsens_s0_p1: s0-p1@24b {
+				reg = <0x24b 0x2>;
+				bits = <2 6>;
+			};
+
+			tsens_s0_p2: s0-p2@24c {
+				reg = <0x24c 0x1>;
+				bits = <1 6>;
+			};
+
+			tsens_s1_p1: s1-p1@24c {
+				reg = <0x24c 0x2>;
+				bits = <7 6>;
+			};
+
+			tsens_s1_p2: s1-p2@24d {
+				reg = <0x24d 0x2>;
+				bits = <5 6>;
+			};
+
+			tsens_s2_p1: s2-p1@24e {
+				reg = <0x24e 0x2>;
+				bits = <3 6>;
+			};
+
+			tsens_s2_p2: s2-p2@24f {
+				reg = <0x24f 0x1>;
+				bits = <1 6>;
+			};
+
+			tsens_s3_p1: s3-p1@24f {
+				reg = <0x24f 0x2>;
+				bits = <7 6>;
+			};
+
+			tsens_s3_p2: s3-p2@250 {
+				reg = <0x250 0x2>;
+				bits = <5 6>;
+			};
+
+			tsens_s4_p1: s4-p1@251 {
+				reg = <0x251 0x2>;
+				bits = <3 6>;
+			};
+
+			tsens_s4_p2: s4-p2@254 {
+				reg = <0x254 0x1>;
+				bits = <0 6>;
+			};
+		};
+
+		tsens: thermal-sensor@4a9000 {
+			compatible = "qcom,ipq5018-tsens";
+			reg = <0x004a9000 0x1000>, /* TM */
+			      <0x004a8000 0x1000>; /* SROT */
+
+			nvmem-cells = <&tsens_mode>,
+				      <&tsens_base1>,
+				      <&tsens_base2>,
+				      <&tsens_s0_p1>,
+				      <&tsens_s0_p2>,
+				      <&tsens_s1_p1>,
+				      <&tsens_s1_p2>,
+				      <&tsens_s2_p1>,
+				      <&tsens_s2_p2>,
+				      <&tsens_s3_p1>,
+				      <&tsens_s3_p2>,
+				      <&tsens_s4_p1>,
+				      <&tsens_s4_p2>;
+
+			nvmem-cell-names = "mode",
+					   "base1",
+					   "base2",
+					   "s0_p1",
+					   "s0_p2",
+					   "s1_p1",
+					   "s1_p2",
+					   "s2_p1",
+					   "s2_p2",
+					   "s3_p1",
+					   "s3_p2",
+					   "s4_p1",
+					   "s4_p2";
+
+			interrupts = <GIC_SPI 184 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "uplow";
+			#qcom,sensors = <5>;
+			#thermal-sensor-cells = <1>;
+		};
+
 		tlmm: pinctrl@1000000 {
 			compatible = "qcom,ipq5018-tlmm";
 			reg = <0x01000000 0x300000>;
@@ -389,6 +500,64 @@ frame@b128000 {
 		};
 	};
 
+	thermal-zones {
+		cpu-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tsens 2>;
+
+			trips {
+				cpu-critical {
+					temperature = <120000>;
+					hysteresis = <2>;
+					type = "critical";
+				};
+			};
+		};
+
+		gephy-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tsens 4>;
+
+			trips {
+				gephy-critical {
+					temperature = <120000>;
+					hysteresis = <2>;
+					type = "critical";
+				};
+			};
+		};
+
+		top-glue-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tsens 3>;
+
+			trips {
+				top_glue-critical {
+					temperature = <120000>;
+					hysteresis = <2>;
+					type = "critical";
+				};
+			};
+		};
+
+		ubi32-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tsens 1>;
+
+			trips {
+				ubi32-critical {
+					temperature = <120000>;
+					hysteresis = <2>;
+					type = "critical";
+				};
+			};
+		};
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-- 
2.39.5


