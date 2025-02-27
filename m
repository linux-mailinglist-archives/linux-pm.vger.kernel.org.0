Return-Path: <linux-pm+bounces-23057-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C6DA47B6E
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 12:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3E0F17123D
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 11:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3751222C327;
	Thu, 27 Feb 2025 11:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="fVwTHhYo"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2025.outbound.protection.outlook.com [40.92.41.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779C922B8BE;
	Thu, 27 Feb 2025 11:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740654331; cv=fail; b=q9ko69E8qL7kQQDhh1VfQVRIWpIXz7Lo8slbHEc+e79/RCUL/7FYP25aAJDsSPQYMaQDjRV4wffDPQ8yR/DBTwDc3vfNcfJXqPfOagb/G5v2lIvOG9huM8jOGQWy4ZaOh3cJcfLTn2cabR4EbNAOqTFkYec5iaIPmQnd9F/6DUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740654331; c=relaxed/simple;
	bh=+ZXI3CVyjg+YhUXIKX2hcUAXiedyppt8aMSOEPTQ1Cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PWLftxNhXKXhRMjUi/dNPtBoZ8T6KKOP/ZWMN8YsPbJB/2yHAQdU9vFLHhbcz5Wk1TwOsJSZ1FRGSI6MKkHrdBhslnZxd3RTLbu7zXnj6eFum58+VTpzGXhShdcdrySkmmGVX6aDcFsfMIL/U+xH9681m6lOglqTeVpbiGtR3gQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=fVwTHhYo; arc=fail smtp.client-ip=40.92.41.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YC0u/AgorVt6RHNL8hAWdu8aYoA9DerWEAzlxKDHW8mDmg2bwJ7t1sHxWPR0m6eneCYEBum+OMpk5ey5PG+XUO0VJu9WGn1MRWaYOPeHhpXeBRepRg1EPgBXNHnhoIu95K/ANKUT8nC1Yw6v/nvpXWZNIVAzPB6fAaJRvRImSSMu+tXnPaMVDSkZWEHgilRSKa+3SgX2KZfZUisCtjSn7sZUWQk/PFZldarScF9nYjdLTApqaD3Yn4883dWptsUXIZ9eSE6wUPz1s3qTIbwKtDiZ/wEJy6lYK/U1yizgDqgF/QU9uUS/J/FqKwlx9Ay7NTmKgCgCL+kdQzXlDQKohg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2SSj7QgoDONfKcaWLlz5r9EV5ONOIzzXfN8ZyOwCgcc=;
 b=ORFneItNaAROnn1T2E7dK47w4Yt6/yvljqw5XqHHGFGBE6aKRP7oaUwzLPLj+T729vlbyx2abpDnq3XorGvd+BWCxLjwSOflTRfxrdA5vEpl6FbULThAc7kGqqD9qEycFFJ8LE0MyySOCHrq+9awyRkP4FWcyY/qUVpjAuiFDPUSbZjcvR5xxRWQIsoSrax4oCpI9qHudxMVMn5IA5/gZy4L/hNajJxNZi5IVSMGcdvmof7LexD0Btje66Sol5Sls+Baw/wZqCFEJc17Qioia7VATfC2u5olei4cujSgRrqd/ObTweGley9GcSZv9k5ZwPjwHyOumvWf43JKFi1U+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2SSj7QgoDONfKcaWLlz5r9EV5ONOIzzXfN8ZyOwCgcc=;
 b=fVwTHhYoocG6y5lcvq1aJTYU+unYfoZ0Lp9pJHciu1PR/iZKdvHEwXtPE7MKyl6aTJK//nJXU054HKXloIj3KXURp7ub/WCZGN9dEZulohWFcig9KLEJPFUl4gvNUXu9/aakQKAFesF7tATGgyjGCN7dTOH/y1GVLflNgYg+WvnYjcT1gSnYWhRE53VwuO5YFGv7ms5mt09ECp5SEOiXoAqJA4u1JhfMjVfsHJvHZvUSJ9Cgn0809TmKB244wYyy6mMEUZFVT3Z20h+gzefjgJrHjcYt0+q4St/0sPypV5TYslVhcD00b/VJfaZhumk+NhmRQkFvcXCcpWFZVmAUvQ==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by SN7PR19MB7333.namprd19.prod.outlook.com (2603:10b6:806:348::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Thu, 27 Feb
 2025 11:05:27 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8466.020; Thu, 27 Feb 2025
 11:05:27 +0000
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
Subject: [PATCH v8 5/5] arm64: dts: qcom: ipq5018: Add tsens node
Date: Thu, 27 Feb 2025 14:56:43 +0400
Message-ID:
 <DS7PR19MB88837954A5FECEC8B84C40A79DCD2@DS7PR19MB8883.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227110423.8418-1-george.moussalem@outlook.com>
References: <20250227110423.8418-1-george.moussalem@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DX0P273CA0085.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:5d::15) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <20250227110423.8418-7-george.moussalem@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|SN7PR19MB7333:EE_
X-MS-Office365-Filtering-Correlation-Id: e587ea9c-2bb7-4c08-c674-08dd571ea3b8
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|8060799006|5072599009|13031999003|15080799006|461199028|7092599003|3412199025|440099028|41001999003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kXu/PYDFFdITijnDDaVFY8COlBtozsk+Qa8rdAWwEI1jzpUrkwDJmQV1LuQp?=
 =?us-ascii?Q?KDE+FvOj2XyvolAWXhcdCSkfY8eHaIFs/VyiQaCH49D2dAQ+s4bLDhPMNhL9?=
 =?us-ascii?Q?hcWsOII9cK23HxyUzNDvn5R3tsRAAJ0ZERQwM1/N0TgLFGYXnsq2YT25CDCK?=
 =?us-ascii?Q?ImN7H1t5VQtzxIosZAJ1cHB4VpAXN5Q645iJG/nef9q5HaLLSRtaDsgY1bXZ?=
 =?us-ascii?Q?HRFfNNJrEnoPJYqVuPXmqUhVUasamxTSM2bJoltPm1hgG9Ymv/O82lDZDeL2?=
 =?us-ascii?Q?2GR3AWB+QK+oZtNEY2WOjy1X43VnKDvpweQ99CuD+MsTi+rBZPEIfIpcnTdo?=
 =?us-ascii?Q?G3Mw901P/7//zG84Fjz+ruMVXC6aX+1/MD++5YyTQkeh1cFnlLpN4Y8kUfMY?=
 =?us-ascii?Q?xZp4LtF90ds4eO37FgPil1haLhTiKTdVhw6fZSse0pEV8LLxBmG48L6Ed3LR?=
 =?us-ascii?Q?4KfHGEaG3rQJApjTbRVEsEottOvI6/jec66dR+Zu5uw6bJtRNs1V0yy3p2u1?=
 =?us-ascii?Q?suq4Zlj8w2LIfmmEKngpVZK9ilxjc0YBTyShg4l63r7wi0cQeXA4zRsg0VTi?=
 =?us-ascii?Q?6RUvbgWe1zkruLZvrkPXst7BCmvMPCNgb8LQgQdhYrzlqEGXf61tEub0N0q9?=
 =?us-ascii?Q?XbutEa7p1xSkPqjFwoje7wqE7VsldFPXk+4QjLKNpIcDFfs2vcG6bIwGQrUb?=
 =?us-ascii?Q?pQwAq3GC3JCQUtbPiMA0Tq5YUNG88XbDRJDWlL9Q3A07l7xblrMUopoCD+X+?=
 =?us-ascii?Q?kj1nADWhrRDiDCpZtUUxVxK8/E9hjP1+rOCh/ljV2kxSNgo1uoPMv4uULTgx?=
 =?us-ascii?Q?fmXjn6G8DMNT1lvxtbBS9GXIV93N1f8A9c/hkvn04uwwgVd6obf0I+Lt7bxk?=
 =?us-ascii?Q?56aPOaQiu2A2I9jtDqAfFO+6zHuNxaiqwE/QEAtNsm7paQNZ7826LvuYJ/iH?=
 =?us-ascii?Q?dKvAwJ3ptImxSOXiKFw7hzmDjF1I+BFeI32uUobGXxsZWoQEy4QlnGTotK0o?=
 =?us-ascii?Q?JUo0B6eXyCN/bd1oRc+IYdpr4GfbC0zUvTeSly4Qe7yYXcRi6xJQFWTqYALo?=
 =?us-ascii?Q?AWF0ViWL+T+q+09YrN8edVVhRjrnDbKYig6Ehp2b+M7PUJ5MunBc/JwOsbhj?=
 =?us-ascii?Q?veGi1A/Tnuh3BtpH13M7w5F/CJ+wXFfYFoqjSFJbZM/2SOPZmgpa/+w=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ItW/CPRFapcbtRh+nisVbQvktSsNUDC7R323w+e6ptD1RoeY1ZB9sEwbnfyq?=
 =?us-ascii?Q?3O75VcCOk0scjiHNP7cA4bMVGgkwj9vCqF/Kzb13aHk0mYLCyLrkXSBkH31A?=
 =?us-ascii?Q?8IMmucNo+8xGUQOKAOemHtk394Q/2ZWl05AcnYG47BWyx4d93vyfAFLPzR5B?=
 =?us-ascii?Q?b/JQOy95tXIb0r4N/7CkWW4/DJ1vYzylUjRULMOTMq6rhabbkM/n2a3RZ3P9?=
 =?us-ascii?Q?YM/8Tl/kCdLcoDbg9MEsR+qU8KNsWdWQRIJbEFnFsokomRRkARRGbhDJoGI5?=
 =?us-ascii?Q?T4laV7Vc8U5LFjoeWpj3LBggmA12/SJO86Mq98YH6PK5D+M1VILgjM0xywuZ?=
 =?us-ascii?Q?N1idSSN14FZi4DzFy+Ig4zToPOtj2q4VumICYaE6UmM2dxjfTJWzJmdOzWIZ?=
 =?us-ascii?Q?5gTIIoz+MURcOF/bpEJijrejFl28vcvmTVupnTBvDZnWBY2Z/cfofkVzT5Rx?=
 =?us-ascii?Q?y+zrVptVT7eHoG0ulMwSTPTxRn/byHvC+gWy4lhPwKwCybWc4HAC1Ev0yAU3?=
 =?us-ascii?Q?IydKgADfhvq6U/zCH9JPIEIiDwEXR44rcdyqk0jOG7nsDlLmvQYD794Wwr/k?=
 =?us-ascii?Q?FJxPapc7v19C9AiI+kuwANrm4jWcuuIx33L9BLxs3SpDa3ZeyRCJ8tsmYKET?=
 =?us-ascii?Q?sjJ6EmSZSEEe3QsUSMjPO+Ttm2exayo8p9LKxr6X5jSh09MTQuR/V4Ix3UFV?=
 =?us-ascii?Q?CmdDUtzYqDS94xSNzK1AmIniZvVJT8dbXsTzDF39zVPeNBEeALYUYYqC/8kj?=
 =?us-ascii?Q?dNNQ9lUlDW7VBCFWbA1EQ5+5cRp9DcMsT86bcLFxTj2JTq2+ZbWWDeaJwTCP?=
 =?us-ascii?Q?ZoD6fACWS9SwJ+g890OQ3M0yi82qP3k4PVdMrnrqstKlmbVBsAylk/dc2uwl?=
 =?us-ascii?Q?Nvb25qgE3PT8m8LRt0XkL+ci8YbrHBM6Pnekc3gCgQMTpBlw9SXVawWjPtSs?=
 =?us-ascii?Q?wydcEbvlDjBbiWXwuGtSxGQdPEHmO1AA0L5yMZ07jHcUceAKIUjfc6tyrnFQ?=
 =?us-ascii?Q?xBjCAV3T1YWqfSZI7OA0pCMaezIwviMUxySadPlaotrJwUdXFjZ77goDJgTA?=
 =?us-ascii?Q?YAda3w7TmX1/k09C2j1CXx7VZw2LFHk+3297EvRCjMQyUY/mgZwWJiY894y5?=
 =?us-ascii?Q?ekppBWQtXYL/rrfwkLHw+L1K3S2ovCXFzm862j6jCPqXFKbOHVijoAyN7uYQ?=
 =?us-ascii?Q?B+xdnoq5DzoJjP0UwEihLmEXTugXqiDLqiw71EF5SqKUeHaHCJ8iEHQhRUQD?=
 =?us-ascii?Q?ARyYct3zliRBUcIPJxFB?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e587ea9c-2bb7-4c08-c674-08dd571ea3b8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 11:05:27.0787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR19MB7333

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


