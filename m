Return-Path: <linux-pm+bounces-23150-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D49A490D3
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 06:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F395116D9A9
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 05:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4F91BCA0C;
	Fri, 28 Feb 2025 05:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="pzkC+MzY"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2012.outbound.protection.outlook.com [40.92.41.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F231A4F22;
	Fri, 28 Feb 2025 05:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740719789; cv=fail; b=m/mFrEanf+Y90XR8iRMwQmdDjwpYFg0i35oSGc94hb6kFkgobPJP5B9TtljOzM/x+1yo6pvCEariZxgpsId3N0W4/yNK4tGAJ/qAVO645f8uO4YsS9Fs4Ka62jT8kIlnB1AeUeFm7XJhGxZM2kxfLZFef7Gh/0fABU3PtHjLPMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740719789; c=relaxed/simple;
	bh=eaCtd0KymCzFas5ulmkoh5eLRZIl/lZHW2kWBaiftmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n4OnPIdcn1faRLLcWnGHDI0XCIx1cx2kCsfwSpXpAagOLn03IM0/5/6Uta0J50fSo59VbmIy2sg5Bw/xl9zubR+QSFtdRWIAsT9vX/4NX2lYFZtAwG74m0pQB6Nss4WnaT0f+yzSVxjWmQzSr3o5JMrQzXMjP1AB7zmGKfVRQKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=pzkC+MzY; arc=fail smtp.client-ip=40.92.41.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=upNfSMAqB0UFs91QVJWpnjCnLhXi1An6kX5j4kGowIVetJZDpK7Kt9jBy2CcABWV/5StzYrabyk/AWU13l1UfuwyFO3JAyqU3ceciwj/9aFpccpJ/rpSthTf4n3qh1aXjdYl0hZLlAWbM0+et04+kGFJCDu5Rn+IfQqY2NfFRK51Xi0XZOBOCvnUleBtXQ3NKXblxegsHdHriTWVc7v6BVJoe6VGcGFD06XqFsoXUkPxc9FTEyTXThPYYuiimNEH6BVH6pWYEtRTgPaGpeRcGWHLVHUi/HxnxLYBUJ7shh13a2mXCaUHWS1qCrboFNlcBc8iDYdVG+YKa/tdyE1V1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=chM2xbh+7BGU6O61ZwA+ZVJj6BEREQgnODUJyOT9Edw=;
 b=i2XpFGe397HuE72r5gQ6hml3EJ1bmFZKoA8tb1h4W0C5LBoWG+JQW2+YjxeSG6W6BYfWEJK9tvXUgn4BMbMAopul6OunpFDyNfw08wfHp99259Y7jzwyVT0qUq752CdYzjJ8TQp/BdVmsKVV5VFi3d39AxBLSLwsoi55CGYMhwmiG31aI4vEVgwnP5kukd2P7JKahLY2rK4ZJKr7rQz+Y1imz5uy3s0w4Dohb8acCjwCpxQaWzHzyd4nwzZRlt5YHx2fcDge2aBdv9J84eFFf4KOuMmATcR/zvJuRrDozSs46ngAFXDTitdHi0vo3O5MCijtXDS6H1UbV6l9hi0ilg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chM2xbh+7BGU6O61ZwA+ZVJj6BEREQgnODUJyOT9Edw=;
 b=pzkC+MzYNkCyORkOWd6g3NHfx55x7M30VElKEEWQySy+MwgA9s5nASRV5GWWlAlefy9wnMRKEx4jdJb2artXeu5xL0EJT7+CZNUDQ24+ycC89Xn0jfhq0F053UhOlQrqtYi/5ywxIMHe0VFKZpSut3rON4XnMIFVxoVM35ZbdBy8oZVhe+GRGj6mSKOo5BxtEKadz5dFWZk7C20sDsi+rSlhLKWM7LWNuT1FIwq+Wl9CYHLgThp46Zq70neWU7+95tzjtwTXSuzZWKJYLeRcFJnS+9bErAozvapglLheavW8sWbJljG2K1/21r7mdivAdFSB0DpgNgTmgmzUUmdKRg==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by LV3PR19MB8318.namprd19.prod.outlook.com (2603:10b6:408:215::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.21; Fri, 28 Feb
 2025 05:16:25 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8466.020; Fri, 28 Feb 2025
 05:16:25 +0000
From: George Moussalem <george.moussalem@outlook.com>
To: linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	daniel.lezcano@linaro.org,
	rafael@kernel.org,
	amitk@kernel.org,
	thara.gopinath@gmail.com,
	dmitry.baryshkov@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	quic_srichara@quicinc.com
Cc: George Moussalem <george.moussalem@outlook.com>
Subject: [PATCH v9 6/6] arm64: dts: qcom: ipq5018: Add tsens node
Date: Fri, 28 Feb 2025 09:11:39 +0400
Message-ID:
 <DS7PR19MB88832B88DAB1DA7942C686869DCC2@DS7PR19MB8883.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228051521.138214-1-george.moussalem@outlook.com>
References: <20250228051521.138214-1-george.moussalem@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DX0P273CA0025.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:5b::19) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <20250228051521.138214-8-george.moussalem@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|LV3PR19MB8318:EE_
X-MS-Office365-Filtering-Correlation-Id: 00af272b-8f5a-4aaf-8df3-08dd57b70bf5
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|7092599003|8060799006|5072599009|19110799003|13031999003|15080799006|41001999003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T1bUFVcscZshmf04o9IZFB5ua7DOzp8DbQYt7M/cAnuU/FizTCZc5EZ7mF5+?=
 =?us-ascii?Q?MDLwf5iEDM+sLJXDpknkVvYdKAyiwSoxFPmZQCep6SNXUggFTrm1cp1NzLqn?=
 =?us-ascii?Q?uHEk20IAcsuzU3X4FQaxn/VssaZ0Xrea3jmbfpdgb1agP6Gedlb6c8KZTKDY?=
 =?us-ascii?Q?6pxugCe4WoryJkqN37ULz2tVmMHq7DPLrRKPEmrB/tUOqhA99N2sfUlWGQFk?=
 =?us-ascii?Q?9/pJydYQnt3en+6aYdx5vmpgt6OX6mYxGBvjaEX2dGaDw6wZk02bkmX7EDQz?=
 =?us-ascii?Q?VEJgcjnmhVp7jCJDiK2svtEJI4FFJUlqdH/aUwqiHrQ9gPApneJRlqk3SdmJ?=
 =?us-ascii?Q?d89M/Zme0TETNnX9TzU719ng9ZyeOMlE4KSOJ89tW2z2A1SdRrOmIeDlRUx1?=
 =?us-ascii?Q?41+Dl22eVZqZPPYpWZ5THmBwU81TdS5tQrPhThdMnJZVKtGIPfgKULVOoe7t?=
 =?us-ascii?Q?69BuIQrTRj/A34pED+jZVGMtzrJN+TnXTsjKGsxOqFC3Ml23Qwa+MuW2F1IC?=
 =?us-ascii?Q?3jCNGcemQIj7bXhI4X3N72v3bDQv9pECKqo4jFxb+3pey8OiRylM6q6cOJzc?=
 =?us-ascii?Q?lB7DvbhA/GNbBzdwLWxnHU7Mgg0MxwP8jRlK5yZ9X18xqGCLI5q4XgGqJu1c?=
 =?us-ascii?Q?wDchddf8YF4eyAkm2hLIH9dY2hfYaJUpTaFktmMT1RbR28J9PE1fzexT3iQ5?=
 =?us-ascii?Q?T3FGdFq3QFThRSGZSP/MAVQM6Hg/hRE3GL9HE9bskHgsqbrwhhLuMaIoeom6?=
 =?us-ascii?Q?sL5e6Xuu2I+McuXSxEc69CN6QaM8cdSANMQbutOZ7IIJrUwcZQxKIswxRfYH?=
 =?us-ascii?Q?0XVT/vFFmBG5kDdN6iE+RufGtoykkiU6iIh9AViFquJdi3lVCL5DpHZr9dmK?=
 =?us-ascii?Q?dwn0lEEBUq0i+MXMZR/mFi1tOMV0zK95huEr10MVm3nuQo6KXWMqzgNa5ZH9?=
 =?us-ascii?Q?kMIusZLYCiwqyBLjFszKnhwX3EGyevjiCBa3d8KTu41dUkSZ69dKg/Etwlh2?=
 =?us-ascii?Q?4XSF73987f/jLNUvg7do6gbzjZTzgETqj/ZoAl/XZ7mbUDF64dYdYK1ShHH7?=
 =?us-ascii?Q?bs/22Fh+JlV5D6fW9f3B72NrXsQLaD9ph5NcGr46b+1IjUy0twpfF1ShQ0Qz?=
 =?us-ascii?Q?NS6HEIxNIVgjEUFgBTj7Ewl8XeGOTXrKhdJfqrzwcC3MZj0mpO+AfHM=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bZGYu+TaZOBgFyqccEcmlYnGm14BdEIqSUVRao15ciL9+ZTViRfrrwPlbJ7Q?=
 =?us-ascii?Q?HCLREOE2CUMHgiI/ZT9oaQPhT7+k2LWdMxenjmnDsgn1maevBeAPi8e3oEoe?=
 =?us-ascii?Q?AZiyT05Pksn0PWk7/Aa+JBwUMQ/HU9pSg0dSS4DkjcifZVZ35V8q0cBoy+at?=
 =?us-ascii?Q?0jtQtaJ6haA6KD1dtr1Aw/M9aP6xUVjvoYuKEQYE8IwqUnz6hBFs8FPgUgav?=
 =?us-ascii?Q?hM0o/7naQ0lDGY0ApfRn7kyvGWffeCVw5qX6qFEeXhs3yxwlLc7rVM0uHbts?=
 =?us-ascii?Q?AY7a+KLgRJ2O2MUerVM4dViA6P2k99fYI+2ckO6LXtUXFyvoyUOlYCzxy9uV?=
 =?us-ascii?Q?0WzXoZeZhVYEOXxGE60QKO7hLJ8XORS5xKh1/CxeXtRhjKjx6QWRXluuGmR0?=
 =?us-ascii?Q?DX6jjSXg16F1C5tD7kkt3+WM9+fEPyTtlgaQt9PVHPlUId2fw886BzZFPmFe?=
 =?us-ascii?Q?DPF1dZkp4oFavz+MnVB+/c4eGQFp6jxpYwSdD77tKn+/sKk9n/U/B0kdfV31?=
 =?us-ascii?Q?b2TRsMYA/Qry/lqX2FGvRqoaEarExGnDDLELALTKtID40bA/KttAeGTRSSuN?=
 =?us-ascii?Q?EkD1zpb0QWJnYH3GVVdRSVVJV7f2AfQ5PE9/RkSgl9QV+DnLoGVCX3Iq/UVg?=
 =?us-ascii?Q?zICcNIwW6RHK4LjxCiBuwK7GXW11xlImnjuxYX09jsgM0Y7yIPMhHQ5uCpVn?=
 =?us-ascii?Q?B7KOObVmb3TU4H0JqwMgwBFUiqt6lp33nUrRtiQ8oDbziQdrYI8UE6jjGH37?=
 =?us-ascii?Q?i2lqZnN9Lw+bYqqe2fzo+MA6mM1h4Gb4CaEq1oAPL15ZpvbO91QyymMlYe6n?=
 =?us-ascii?Q?AOmtsla3ZPnZ14gzC9UT/ZiH17MA/DeeCqwGvtoBfrbyjqivUpvxWO6GTWTM?=
 =?us-ascii?Q?gN1o3yaIDZuy3DLC4dE5pQPyCzLRft1HJNAHitnUsDxM/DCz8d98dAGBxCsM?=
 =?us-ascii?Q?t3RUIdERQ36I2yp6FR4fpbUH/+fdg7UGaKkiqUQJwS5RvLPccOsEy88VqgBb?=
 =?us-ascii?Q?1zHZrKtfSy5RJnDkvcPz6cI+w+lF/gvG0ruxoIUuSjj9W1ybQx2PEuwqhowK?=
 =?us-ascii?Q?eDQc9OcbxOb038JCCY946miQKUhqK8PNldgboyx+Y7K8NCNcAApmG2xhlbsY?=
 =?us-ascii?Q?AsLiHDTGmpBZGAIHP1nnGh9Tp45widb4ifk2n54aSZ9kr9rEeOSEQmYVrlaH?=
 =?us-ascii?Q?7c7bpcZhuJiexDoUU/mOdEpekWIcSye2lwsUt54AzkQjaK1FzHthjGtXs/Q3?=
 =?us-ascii?Q?c78VSdtS5kTQ4V1q/o9g?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00af272b-8f5a-4aaf-8df3-08dd57b70bf5
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 05:16:25.4987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR19MB8318

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
2.48.1


