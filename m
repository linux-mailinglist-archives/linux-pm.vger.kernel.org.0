Return-Path: <linux-pm+bounces-22664-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D70A3FAFE
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 17:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68554163D56
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 16:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3778B224881;
	Fri, 21 Feb 2025 16:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="qKTIKRq9"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2012.outbound.protection.outlook.com [40.92.21.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DCC2236F3;
	Fri, 21 Feb 2025 16:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740154300; cv=fail; b=gzgTnarLhWOiGc1wqWY9mfy2ft/a33zBI/G532RCrDHC6H3yJSaxK4PXtZvx3125gdqPqhORytvLMF8TBRRNOo3iXCCNdE15mHooiMIwBKBtAlg0euw74aIg/bdejjSaGdsoETjoBfAXTa+PeUD2qHlQCZMcUlHdhBg3IYskdZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740154300; c=relaxed/simple;
	bh=egNiOMc1vvJiZmmWUANQBxYQanMei76iEQy0i8IvteQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fxAGO/mU7AA013JiL+XkLcF/UKJcU2SoDSkrq+AowxGWUH3sofBWOJQ2tsL1eJX4CP08+L6KcE5LtkwOTeut65Pbzjb/GUNS4+sgrYCnp4P3aGAAl7FBIdeEbn14i9PRpZflNG3DIXGzzc1rDpxkrazzLJTSfPAKlw/GiCJ1PdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=qKTIKRq9; arc=fail smtp.client-ip=40.92.21.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wnuKBTIY5o1rz7PQ1cY4tMgNpiZCdBiOgBCSZjzhtRN+YsGsvt/nUeK6BqN+kBhPuXEFNtAfo7Zm4OqLhedH3cdJ4C2KqSQ1og+ynHTUTD6Cnnunh1DpqTG+klDfjMJr0xJDy2FtyV2NB+ERdQZFPPjyeflH2mCCTUMSJy4Ot6DkK0MYA9cpUm5iiAQ6NbuVlCT7GFQt3r1QA9N1ahhTn/lCBdemvxpUW4K5ErlrsXyYN3agV5r+H4je2rrmgbLKJ6c54hxRfiUmZUGKXZg2ZHdFbiMs/dUIi3POybvRrpKI2QlAX+gR49Hgp6UncLjdadzZN9VM19NSCjEabsAilg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRmYfp8rXzrqAQ6ru7rx/oEytw5iexPEKUihqJKHfwo=;
 b=J7AJp2Uw2StdLaOi+EkjmwlcbWFhJ37LScszrzb2wSi3TuHK75+kCc1PLscgPjrS+6zaA20aMyZGIMDYstqQzN23QNe0uhmPbATSyyqjGKmlDqh9qXBfJJS1RpVIF/gaAddk6kGn6+VPtTu2/zXiNa+n23TAxTTDkM4rPSp3o7IgP4WJo/1uDnY83cF8I4/QFL/P3oAFRAS4R+ibW//nSpauq8Q3iiH/JLFpFwqafIVbghx6r0krFDSKr6RM9Qfu4bHtXn7DyTscDJRhqGtjmOLp28oK0rjQFmdSK2Mhfcv2b1BJJS7KwJEFIccdKqTY50JA8eqDYVxXgPI2XB6mUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRmYfp8rXzrqAQ6ru7rx/oEytw5iexPEKUihqJKHfwo=;
 b=qKTIKRq9WXHoXpEXjdW8+O076EjX34MCHuKSBPrHFHC1Wu93IqE6VtDo7wf/iuhpnYagDET6qbmV0TaQQ7QgIkZ/XkSQYlP+J7/pO+0SX6DBSLZc2VkPp43Kkm2AarM1O7sOU7lIhcCL3/WDZ0H8aaIg+k6ibu8vM+r87BP01qbbqRW7NLWowt4EKQLnl1JrRjWZ4PXKz89RAtG2eSDWbrSr7AvxtrW1GWwh5dIwae2jKaKNLX5xR9UIn7vRGICsIsT2CAbErh6zMhlDhSGPDls4fvd7NvxV5vz+qHQb5zu+IJkNPd0tPbJyZ58wYmtxeeS5zGtTlzMRonAvamkl+w==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by CH3PR19MB8108.namprd19.prod.outlook.com (2603:10b6:610:174::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 16:11:36 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 16:11:36 +0000
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
Subject: [PATCH v5 5/5] arm64: dts: qcom: ipq5018: Add tsens node
Date: Fri, 21 Feb 2025 20:11:01 +0400
Message-ID:
 <DS7PR19MB88835D0B88C56EBE6127120C9DC72@DS7PR19MB8883.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250221161101.17204-1-george.moussalem@outlook.com>
References: <20250221161101.17204-1-george.moussalem@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DX1P273CA0004.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:21::9) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <20250221161101.17204-6-george.moussalem@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|CH3PR19MB8108:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a8ef86f-1b76-4438-1c64-08dd52926a31
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|19110799003|13031999003|8060799006|15080799006|7092599003|461199028|3412199025|440099028|41001999003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yqD9xSxTHrpa23PTNLYBI8qj9f4nIy5lFwC4oi5Oev2q1fudlYpG7bs52ctN?=
 =?us-ascii?Q?cWeXLy6jgOHsKbNzBQlAOD50kvhL/QA3e4/dGdpsglfWTqBDKcbk34No6VZV?=
 =?us-ascii?Q?tPmkr3J/LeFFOqR2yxYXaZeiYTT1PPLeWPeKLCUcAQE6WuHW9S06aeEpJx/y?=
 =?us-ascii?Q?inyE7l2fxXoj0Fn/ufH8nnh8TyUSScceYC5NsT9ylTL6CsPuHmBn/5vinecX?=
 =?us-ascii?Q?3WQyGV5YOdo9tdHSJmrqwMwBcR9rMnZDRilztj0XmOunginKvMHVxPVOyyuN?=
 =?us-ascii?Q?QVDPy4/sHYLnDYduc6gizJyWsl6KeHczfHxlK9myUbmE9vpdbs0TsfYps0y3?=
 =?us-ascii?Q?LQA+Ar/etUKVLTxDG77hCOQf9Qx3X7jKk7jfdUgIjmafxaTd4+BiROyQsYfr?=
 =?us-ascii?Q?ABp57M+L5jp636mgrmvvpNc/ZoGNbQMYzQnyJ0ZlqaCNIVOexXbWArcCwm4L?=
 =?us-ascii?Q?LNQXN3pgqSSdb7pEaFDTDGAaLEby1+wsruBA3Wfc87TETQNS7LAlA5/ZmWnR?=
 =?us-ascii?Q?rbwQE7vON3nRhfYiD7I1J1CqdPibXjxqUqzcH48/hxgADuam/lg9N8bRGhRe?=
 =?us-ascii?Q?gw9kZXqDaN48WRN5Crr/gqWdDo6cbdiYkGhrzOETcHD6+Omxq8LwHfGF2/54?=
 =?us-ascii?Q?Q7f3EyXVwebJ5XhNtLkF7EFFXe4tl4B5MmDalYWZ+akQ17YlK9RiL5dgibN6?=
 =?us-ascii?Q?2nwWFyQN9iis1fW9v+sHLrFScuHyhm9OZ9WPxTdH3M4TNq62ubroXJnPYrvK?=
 =?us-ascii?Q?1UYzDGUNhBR38M0tVEz55aXvp4mC+7tDqv+WVppSrRKompH5ckkCVXbRf8Aj?=
 =?us-ascii?Q?QtKedyTYJedRAkp2Ax+BtaO7XJeoK9oIhUhgNTYebZefJSB1XOj0UC24e495?=
 =?us-ascii?Q?x8Kot89psLbNeVhvHUxf8Vmr/NBrIQqH9JzWUfU7sWCn0iq1MRIbCBs5GW4E?=
 =?us-ascii?Q?9SKowTKdT9I+hSHb0dOpIkZcVicTJzybLAwpNd0WAHB45feLBT/E3gjbX3vv?=
 =?us-ascii?Q?OUL8ag+Jvc9YyoCegDvgzIaMt7MfcxSJJT2Jxah4nGKb1/vQyEuPhjIirR5N?=
 =?us-ascii?Q?U4cgZNf7E2tHllrQdybMW8vNL/q6lPuSmBIfarQR2LPjgOxR6+wa0PuOc6os?=
 =?us-ascii?Q?Ek0PxtsdgkH37ng8xiDi2OYd9TWnf/UPTdx1g3sawI8rI4HPCFDSv1Y=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FEZ8BYDC5VgZt0gbhDV1WhKzZ6srD/ingtEC1o8tm0UAKYLWe6Ur1GEXjp4Y?=
 =?us-ascii?Q?WMW1ZASnJf14GnJ/JheheqEgjz44K2VeSy3x3KDOJ8H0SEmjxkfYmfVOpVs6?=
 =?us-ascii?Q?rCqCblQTDUR0qJQdYf6ZTM58PatksJLDOoFKhWxCrbvBv0u93JuwhAnBGzNH?=
 =?us-ascii?Q?ycrbqq9T1cL+wBJr9U48rR3Kpo5mIDfJO0PGF7z258VDIkEOCXFbkVk/tBE6?=
 =?us-ascii?Q?9zs/ahntEbaUCUJwAE2+zj55N2MMStPyqZbjgwia4O1EwtUVWgjl/K1zguQd?=
 =?us-ascii?Q?VXBKTwM1wq80sAjCW2NFqcWrtZgdtacz6wk3IEmRZbKN4dhmX7bEJJv0Kta0?=
 =?us-ascii?Q?C8zn16yl6HPHWK0HUk+bBaxc3auPH/4yVAk6ySHeqN5rApP7TCPT5fRzp64A?=
 =?us-ascii?Q?7o4FQ/Y7wFMfqqSZKQmVpSwjZCpSYNpidpEs4c1B7uMuLqFpXkhOQcr7nPh8?=
 =?us-ascii?Q?31Ok+np1gSOMEWihrstfW6OfiOJygmVDyJSiAyAUIn1ACc0g6QhtjwcHTEWB?=
 =?us-ascii?Q?UvJm2dF4q1HVMidNfMIcYGPSwOdBA7niADuaVd/IF6DsjmEi/WBvfyvYbYM9?=
 =?us-ascii?Q?Awkv1lYSul5hjXFkgH6DBWUirqpcB65vGlnbDMxBLFFIIB06xx5nd4hBuz3u?=
 =?us-ascii?Q?oDw+Z6fshSudVeugS0tEoVn6aTTR4frn1dtRUjmwZEbRjXViw7j0s48xlWvn?=
 =?us-ascii?Q?/gJ+BGTK/HsYzoX2PpR4P51JuREc70Fcq6CvTTSGi8y0vdziqV7y+eMeI8km?=
 =?us-ascii?Q?XbZnqhcfx/oXFgtjlJukLIfv8No2ruCV54n0T82fZvwdLzpB1TZoZTJrckDF?=
 =?us-ascii?Q?5lNoAXHVyDVSh1vZlnlZ0+AtyxWYqEPrs1kJ9a8b5JsbDsG9Z+iwjDsw2+nC?=
 =?us-ascii?Q?3FBXiapb0mgOiWG/eRGq7SnxnHhYkBqJeZnDnroZUyNpnec0L4kMAIFd9lgE?=
 =?us-ascii?Q?EGEoGwwO6zXwVUr/MlAZWaiIb/lRZb9EYIYTr0+hcApcYQ3NWD8XHtXOvBj3?=
 =?us-ascii?Q?IBuewhnkqcaHeDb2iMIFs3IEPFMGbW/Zi1uiTsxfQwVgBJuvsTUhO4zACl9A?=
 =?us-ascii?Q?fm13BM5KcJb5Ct69YZ07xfzbCVZ9AHxhPQt3pD5+1LzFo4cm8vJoBB62lzSt?=
 =?us-ascii?Q?fnU9QWxhSjf3+6ZJIW6tnBCD3kZYu2iBDoo4nVkKdEmFAMvQqsBSuqHav5xy?=
 =?us-ascii?Q?70ZAAGUHdNIHu66F0Nuw9wiHKevaArnSspy5Lc2QrAai0SFgj24GaayIivAf?=
 =?us-ascii?Q?xYglUT68mXnma1zT2YJj?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a8ef86f-1b76-4438-1c64-08dd52926a31
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 16:11:36.1508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR19MB8108

From: Sricharan Ramabadhran <quic_srichara@quicinc.com>

IPQ5018 has tsens V1.0 IP with 5 sensors, though 4 are in use.
There is no RPM, so tsens has to be manually enabled. Adding the tsens
and nvmem nodes and adding 4 thermal sensors (zones). With the
critical temperature being 120'C and action is to reboot.

Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 arch/arm64/boot/dts/qcom/ipq5018.dtsi | 169 ++++++++++++++++++++++++++
 1 file changed, 169 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
index 8914f2ef0bc4..28b809e59031 100644
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


