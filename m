Return-Path: <linux-pm+bounces-22606-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F008A3ED16
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 07:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E6EF3B7A9C
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 06:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BE41FCCE3;
	Fri, 21 Feb 2025 06:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Hs8/Fa4y"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2104.outbound.protection.outlook.com [40.92.19.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC8A45948;
	Fri, 21 Feb 2025 06:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740120795; cv=fail; b=WxGYEIUELEGCvKzM0wNLY53kW18yGtNBoYhHejtcR0fEyoj+iiK3gt8rzrzZGepWxHyJsWnNzHERF3g+STgumxxRcpkDknnzicfFS52LKz8moGZpqO0rDU+p7FNmStwePjtbtcCEjAEfHlZ8/0o9fXvIWplx0AbA9OCuHX9Te8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740120795; c=relaxed/simple;
	bh=1aku6Z5ppd/42iAluL++zwQ00qw/JN6s7zoujQbsfIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XSompRZHtzWXOG2rYZG0s5JjtBpwccbZ/XC76YfxFf6IU95mddthyc/YCNBQH11nNCv9UuNF/rvHJcclOpmlncWUfGYVmIMrP52SPm32D28v2TSIH2bG/v1EscYtPKm9NmgxzrQ4fr1L9XXHVS0Cuz9NjdWlScPf7/MLnc4TSdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Hs8/Fa4y; arc=fail smtp.client-ip=40.92.19.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=woYWJYzWat8scI4qRos+1iQhFmVUepY22VzYVSkn8Ram4o4vjjaQDNPAwT/S+pL4j8hfmp4F5u4WhKQvJp+joE38cXUTvdmXEU8YyJAUPXm2nzjYj0hVj1SSkLagiGTn8CrsUgI+N5hV5am0zej9rsliF+abw7Q+byxkOyG/Ov+fog+M1kt8kZVpw6ZBp18pQIAEaa+pYVf3PpIP9FzNM9rB7Ne2fRytbi0mH23+nuPEuVsi5G3coUim/rhiioguNfuTt9aEeGbkRwXsCfemOu0EWAlRq1ijMis93JfB1m7n/kHqm9xsKBv0UQo/XSFUDF+CELE7SFkpEpXhu5iyig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ClOXmhbDI8hd0Fa9Q9Xh2cm/de1JJUUXFqHoaCBgMic=;
 b=lm4DcOgkwbEBchXZexHWV8mIyHqp4p6NhzRV4hieLX/kU92N823jc2qGJsrksW5NWBNwF8jvR+VH9kIWxa5xhwZeX6TYv9LIODps28PKv+k2kEqvHmH1MkbyQMp8SHsShN7gsVf9fFR3nQDXYgeMaQQ0gRaSv3F5hquO2IvaQ2H3ffxW7rQNnjjJbmbwdc0VOJr4fE76J8dNp/KAA+4T7lJRZlVfLv6rpMGxqh9WP8nn1ICCsik1f1jF7nPu6dP91MZ4zzK54eAc7ugIQmDWn+LmHu/GVgi/vwhRY+sL1dINbU7yCYfuc4nTWY5zANFGC0CsTtca49wRQ/wbVxYSzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ClOXmhbDI8hd0Fa9Q9Xh2cm/de1JJUUXFqHoaCBgMic=;
 b=Hs8/Fa4yKLGgJ4nO8HTnqOGBUFErsErOwtKQzn5vfAKtKooN2G3WXb6oku2AiDri303nqRIWLqQghtc7gGTZbdrzOFMEzj5ppu3gZuaPoEZiHUMrMhZaJXSJLuvzGVGIwBMDglnO5rtBQJF9oR/zI1iseKIa3Ndyjo+JYQjrxDeG4vhV3E5hpvRUC9BzRDvKo0TBDNFJadWy6jQ3r0EHx2QrbDqX3HfLaJkse/7lZG+fTxUSDWbn8tnDNta9dS1qJWavGUx3NvgYNyii1Sl8nRaTQrxGMOzP0xpBOLyVhvvph3I8X3YX+i8eKsx7MA6Jcxv/DCe6G8rMuYT3gNVm3w==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by DM6PR19MB4248.namprd19.prod.outlook.com (2603:10b6:5:2b0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Fri, 21 Feb
 2025 06:53:06 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 06:53:06 +0000
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
Subject: [PATCH v4 5/5] arm64: dts: qcom: ipq5018: Add tsens node
Date: Fri, 21 Feb 2025 10:52:19 +0400
Message-ID:
 <DS7PR19MB88835438AC6C94F2B057986E9DC72@DS7PR19MB8883.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250221065219.17036-1-george.moussalem@outlook.com>
References: <20250221065219.17036-1-george.moussalem@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DX0P273CA0013.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:26::18) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <20250221065219.17036-6-george.moussalem@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|DM6PR19MB4248:EE_
X-MS-Office365-Filtering-Correlation-Id: b0deabfe-8220-4d95-b84b-08dd52446514
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|8060799006|5072599009|13031999003|461199028|15080799006|7092599003|3412199025|440099028|41001999003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KdaqAqM6bYzAJ7NMdeuF1Tb7p+MJCflD9R3CYhgF+CxnHX/0ydYZtb3GI/Ow?=
 =?us-ascii?Q?ti2rCOzj2WyuQ7iFMqxr/gfZ4Y+iW55DdjNwzM357QjKekOAF7tKiqAXkS4L?=
 =?us-ascii?Q?IFQG6n5dkjyWCxdo5l1foUVPeFsCEWZO8Py/vaWNkWyHpQbYizowQrQ7Lxt5?=
 =?us-ascii?Q?XVSSH5ZB6eSwD/vuIQE8R1ryVongZ02W459bdw1SyjyoVbyzznJlJJ0+DpFg?=
 =?us-ascii?Q?QEol5Yi+AJQGelIba9Ufd9RiRRZ1t+iLbNFdFSQsDeVu6cO3EL6CVgCC3CQN?=
 =?us-ascii?Q?66vAbcQGiub3Ct4JLcQiEwvtm29a+41IzPqB7UO+twPiuTDG0vmqWHk2nwkZ?=
 =?us-ascii?Q?aKYI7yBBDioLDGCe1gqCEkRtqnlbNA7OIj50b8NduFOM40l1AAwQrwqcr0oP?=
 =?us-ascii?Q?lHOAcKHqWqyTkszL8gkZAW8Pr0YcSpWOKUoA4oQS5onsQWDGVUrurJWcjT7g?=
 =?us-ascii?Q?AZlgg5ZQFW9sZtcK7SIJzXls3acONsr7KqWIRBwc+xd0vn+JBGOXK08NriaV?=
 =?us-ascii?Q?2EQ2rA7ChkcOO+dVWfkWTGKra7J7KemsFqVpFTBEMEi+mMJAMaF4muXZ4FOs?=
 =?us-ascii?Q?iDiTHF7qz9eaRX5DWgiKs/llKU/l0QIr+gBc94C/vt2hmkXzyZ+vatMlLQxy?=
 =?us-ascii?Q?rjsyKj8EeTqgDzNK9GPW6Hodoz/yjKOmCHaDfmZ1vlEWB7UvveJNgSDRfswC?=
 =?us-ascii?Q?nXsr7+1pZ5zigW+BW3915Kf7E1PoQzOBGEyXh0DVL4GpaSDVsdi8C8qFhYcW?=
 =?us-ascii?Q?eydQQyvVsGRMHAy8iw3HhplgzIv50mvyq9GjxuNy3vvZN6XYzotUl2tapfPm?=
 =?us-ascii?Q?2a75AeXMo0AVL/NKvRrnNxZdAk517/FMOYHZaQ0wowbfG71z1+ZWjM59APYY?=
 =?us-ascii?Q?+horGX8ThdHhGdkcz8Pd7GmFpMXq3MYYs7X9SASOm6hVYPSMt9/CD+S7+58Y?=
 =?us-ascii?Q?raIVC2/lJxI+judLhRS8sKJj2Bm2WAcRkx0YuLZ6VL8gAqYhDxxxIOgCEVWt?=
 =?us-ascii?Q?xeaTqe4Ln8sWgRUmlgvvBtfRgnepztP9sDThZAuOy67fc3offav8uqvGw/8+?=
 =?us-ascii?Q?cOe+jwW1MyMkZmJbpmuSPlijDI2PtEEd1a4EQTGKo7rvukNqFnqrvXPy3DDo?=
 =?us-ascii?Q?VWFNyDVTsK/qoo4jF22nhm4dXcrsEEjxobkGdC8YwF9J3ITJZ7kZNUk=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oUcUD2tBlP1+opnHckE4sDqPr6EuidMNui52YPxXstySPx5aTqAnn5Xz0bmN?=
 =?us-ascii?Q?1/qpBErw9KlOFXBsEwsD0XjtWJWgET7XTMIZ3EcMHJBp3Ok5NqiGN+UHOfS/?=
 =?us-ascii?Q?5pboqS8vaiUrEkttA17ON4x8gUBsQ2Pyl0uWaauGVdspCgMasmX6ME81VTmo?=
 =?us-ascii?Q?EdxYQxhTjNBDw8J+bnSCuUsyD7zuloQsTuM7xWZU5U7HIHCB96PtFvJ9ZUDK?=
 =?us-ascii?Q?6QNkjFZPCEfwkaXXgrAJx3ySLIrYf8SdCEqoptw+FnHxdBuFiiNjBO1UuJwi?=
 =?us-ascii?Q?8Pnf3Lzp4V9sfQeMjomLQ4es4OdE32qp1kBXJag1B4F31fFsl4G0aH665Vmw?=
 =?us-ascii?Q?srSms2LOG+zGSJ6MpVSAWNONuDuxABarQ9USymq5aq1mOrZXUHuFIYb/hhP3?=
 =?us-ascii?Q?zhu22zWVNYhDC/n0hmhepkDgQJg9hK8LhI1VjPLDutASnv03/j6xJhArQVNY?=
 =?us-ascii?Q?UXgAz9D0d3/Yi/OzMqAxucP2FGweywqYxLgCQ3CKrxDq97bOnb9DKYHdqS/P?=
 =?us-ascii?Q?7l0Yg2sx0wDjbdVSX4rnjKkkvBQ46JaUBkELyQVJ9MFl5pQi15NNGQ4MDgFg?=
 =?us-ascii?Q?kTAPtgQN4dhuOh6HAdiikt0Mc1NhDRrtWaAgRWgh3OabLKW7tRut8M7bB+As?=
 =?us-ascii?Q?UgShdR9SvKnHGnvIVNvy7DzYdVvURbDLrYTUk+HWusXpwJaPprHqkj2f22OJ?=
 =?us-ascii?Q?1bS4RczxYofplzsgDhx0ohcW3CNaJcaAYyDBEuDqfu6XIOoAmHp+VEonQnzX?=
 =?us-ascii?Q?nE7a0TdlGNC5cWwYb7UyeEfp23S7ka3jhKvqtdzvm99nU2Wap8uShZ9Nye00?=
 =?us-ascii?Q?6SR8ADgIMx/Aqw/oJGdcD3Sp4DridDko4XKSIA11g/WcHSeP/WJdOFdAYFrZ?=
 =?us-ascii?Q?90ID3RclZ07Oxf0iBHvRuotRneAqs9xPnpUMxxj2U1WwipqPKkjJ3kvsL4yD?=
 =?us-ascii?Q?xSSaGYAXAGIWF99M0HpbUWRKd2ZicwDU5gs4SmTj4KLQl4L1fdmerf2weVwp?=
 =?us-ascii?Q?M5NOqiHHFNLxJ70xB6f2BXnBfnwOTmpyOOONx8fk/vCf6H8aFje7dJ7hGOmU?=
 =?us-ascii?Q?pCq5X0P7jAFzKYLdmLvjB0rC0y/ZikGhyJ/6szW6UglE5Gbg8Po09vXwdjbZ?=
 =?us-ascii?Q?hgyUq5SUyt2Lu5B85IVCL9JGY6sdkac6ACbJR1RLANJlRrf3nxFNRi8MrNtw?=
 =?us-ascii?Q?g5xzKGHa+s4e59l+6Zo//RdwkkF8oEILOMlgJnmC4q5s7KuK9npHBpOgikfK?=
 =?us-ascii?Q?3UuiLo7Uk1r+Cp7C3eKZ?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0deabfe-8220-4d95-b84b-08dd52446514
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 06:53:06.8072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB4248

From: Sricharan Ramabadhran <quic_srichara@quicinc.com>

IPQ5018 has tsens V1.0 IP with 4 sensors.
There is no RPM, so tsens has to be manually enabled. Adding the tsens
and nvmem node and IPQ5018 has 4 thermal sensors (zones). With the
critical temperature being 120'C and action is to reboot. Adding all
the 4 zones here.

Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 [v4] Sorted tsens nodes by address
      Sorted thermal-zones nodes by name

 arch/arm64/boot/dts/qcom/ipq5018.dtsi | 169 ++++++++++++++++++++++++++
 1 file changed, 169 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
index 8914f2ef0bc4..a15078f85ecf 100644
--- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
@@ -147,6 +147,117 @@ usbphy0: phy@5b000 {
 			status = "disabled";
 		};
 
+		qfprom: qfprom@a0000 {
+			compatible = "qcom,ipq5018-qfprom", "qcom,qfprom";
+			reg = <0xa0000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			tsens_mode: mode@249 {
+				reg = <0x249 1>;
+				bits = <0 3>;
+			};
+
+			tsens_base1: base1@249 {
+				reg = <0x249 2>;
+				bits = <3 8>;
+			};
+
+			tsens_base2: base2@24a {
+				reg = <0x24a 2>;
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
+			reg = <0x4a9000 0x1000>, /* TM */
+			      <0x4a8000 0x1000>; /* SROT */
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


