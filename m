Return-Path: <linux-pm+bounces-42903-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LwzFB3el2mp9gIAu9opvQ
	(envelope-from <linux-pm+bounces-42903-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 05:07:57 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB3C164783
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 05:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5A56130078BD
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 04:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320BC2F39B9;
	Fri, 20 Feb 2026 04:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojTeck12"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4402777F3;
	Fri, 20 Feb 2026 04:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771560471; cv=none; b=lPfD0USO9WAS991R0wZ4eRi9Ke9v6kyk0apKp4MRyurGNvuk6IWsM4G1mq3q6cnip9ZII4AhTcDRoTyLqD6EqT6PVdklzaSXD+9sQjC+sMjwbGlR3BpX443cqdmZVIUdOfodYE5osRFl3O9J1IRvQ7PjZZEn4TfIcpLxBOdY8hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771560471; c=relaxed/simple;
	bh=kc6F+SBT+t6RBPoescqazJkCAj0W3LZVUOZACt/NSVo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n76ER3457DrQOhv0GxtxRUQ4s7ffp97VZQCl/mSjKyy3Q+hVbbyVqyzqRSPJS3N27AvLKc/9QG/sXaVwbORQ9fLVi780K5nWDcvlmTVE+h94kWR7BKA5Vb3SNCZxmZ45uHV97KhuVUCiXVeB/h3VbX472QGOpRa9nfD/vC77PLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojTeck12; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9FE8AC4AF0B;
	Fri, 20 Feb 2026 04:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771560470;
	bh=kc6F+SBT+t6RBPoescqazJkCAj0W3LZVUOZACt/NSVo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ojTeck125QIyvfKidocpfUBrDapSZVV6C3gO/+67DSAQhnC0seVaAR6xueO+o8iRy
	 Yy/DajFDjNbXKQ340pf6Iz+aHzpCCB0G/zwhZaKo+LWCNEOfjFlmAeJM77v57wHAP0
	 fmkOvDWkPma48C8xiuFSoxl7ciBFQjUcFnZuQNB3vusgoHwNhM9UtJW2Yc6YuDM9Pk
	 xHVKCs3q3Ee19T6ZZNQoC8GcOvJBGli4w6t4Qcu3ro0WocAZrx18NpTiRCUVUrCy/Y
	 4zs3LOmrOq0TaWc0A0SC/HWBQP4/W/ELepOd0BDIr8QLgnFNAZ/zkAuXRrP7OgQ3Ep
	 Sk9+U0/pcCa3A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91320C531FC;
	Fri, 20 Feb 2026 04:07:50 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Thu, 19 Feb 2026 22:07:40 -0600
Subject: [PATCH v3 2/2] arm64: dts: qcom: sm8550: add cpu OPP table with
 DDR, LLCC & L3 bandwidths
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260219-sm8550-ddr-bw-scaling-v3-2-75c19152e921@gmail.com>
References: <20260219-sm8550-ddr-bw-scaling-v3-0-75c19152e921@gmail.com>
In-Reply-To: <20260219-sm8550-ddr-bw-scaling-v3-0-75c19152e921@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>, 
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Aaron Kling <webgeek1234@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771560469; l=15161;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=8VtROm9THEXwYG/h6H8x8IE15M3GbTOmPIsXQU8MGbU=;
 b=lz9mCmf+kp9G6sYtHzt8wauRJ4COixJMcOmjUG3b0l2yR+i1u7hZYnjdOF6BWqII2lh22JGVV
 ten7fNbIHOED5UPfAhWYyvUg5MwEWolTRMx+Beb8WrN/c5l/z00azQA
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42903-lists,linux-pm=lfdr.de,webgeek1234.gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-pm@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,linaro.org,oss.qualcomm.com];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	HAS_REPLYTO(0.00)[webgeek1234@gmail.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EDB3C164783
X-Rspamd-Action: no action

From: Aaron Kling <webgeek1234@gmail.com>

Add the OPP tables for each CPU clusters (cpu0-1-2, cpu3-4-5-6 & cpu7)
to permit scaling the Last Level Cache Controller (LLCC), DDR and L3 cache
frequency by aggregating bandwidth requests of all CPU core with referenc
to the current OPP they are configured in by the LMH/EPSS hardware.

The effect is a proper caches & DDR frequency scaling when CPU cores
changes frequency.

The OPP tables were built using the downstream memlat ddr, llcc & l3
tables for each cluster types with the actual EPSS cpufreq LUT tables
from running a QCS8550 device.

Also add the OSC L3 Cache controller node.

Also add the interconnect entry for each cpu, with 3 different paths:
- CPU to Last Level Cache Controller (LLCC)
- Last Level Cache Controller (LLCC) to DDR
- L3 Cache from CPU to DDR interface

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-HDK
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 367 +++++++++++++++++++++++++++++++++++
 1 file changed, 367 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index e3f93f4f412ded9583a6bc9215185a0daf5f1b57..de4d43f7b8d2416997db70c98b0fc36d25f3c2a6 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -17,6 +17,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interconnect/qcom,icc.h>
 #include <dt-bindings/interconnect/qcom,sm8550-rpmh.h>
+#include <dt-bindings/interconnect/qcom,osm-l3.h>
 #include <dt-bindings/mailbox/qcom-ipcc.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/power/qcom,rpmhpd.h>
@@ -78,6 +79,13 @@ cpu0: cpu@0 {
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <100>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &gem_noc SLAVE_LLCC QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&mc_virt MASTER_LLCC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&epss_l3 MASTER_EPSS_L3_APPS
+					 &epss_l3 SLAVE_EPSS_L3_SHARED>;
 			#cooling-cells = <2>;
 			l2_0: l2-cache {
 				compatible = "cache";
@@ -104,6 +112,13 @@ cpu1: cpu@100 {
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <100>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &gem_noc SLAVE_LLCC QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&mc_virt MASTER_LLCC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&epss_l3 MASTER_EPSS_L3_APPS
+					 &epss_l3 SLAVE_EPSS_L3_SHARED>;
 			#cooling-cells = <2>;
 			l2_100: l2-cache {
 				compatible = "cache";
@@ -125,6 +140,13 @@ cpu2: cpu@200 {
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <100>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &gem_noc SLAVE_LLCC QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&mc_virt MASTER_LLCC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&epss_l3 MASTER_EPSS_L3_APPS
+					 &epss_l3 SLAVE_EPSS_L3_SHARED>;
 			#cooling-cells = <2>;
 			l2_200: l2-cache {
 				compatible = "cache";
@@ -146,6 +168,13 @@ cpu3: cpu@300 {
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			capacity-dmips-mhz = <1792>;
 			dynamic-power-coefficient = <270>;
+			operating-points-v2 = <&cpu3_opp_table>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &gem_noc SLAVE_LLCC QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&mc_virt MASTER_LLCC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&epss_l3 MASTER_EPSS_L3_APPS
+					 &epss_l3 SLAVE_EPSS_L3_SHARED>;
 			#cooling-cells = <2>;
 			l2_300: l2-cache {
 				compatible = "cache";
@@ -167,6 +196,13 @@ cpu4: cpu@400 {
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			capacity-dmips-mhz = <1792>;
 			dynamic-power-coefficient = <270>;
+			operating-points-v2 = <&cpu3_opp_table>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &gem_noc SLAVE_LLCC QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&mc_virt MASTER_LLCC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&epss_l3 MASTER_EPSS_L3_APPS
+					 &epss_l3 SLAVE_EPSS_L3_SHARED>;
 			#cooling-cells = <2>;
 			l2_400: l2-cache {
 				compatible = "cache";
@@ -188,6 +224,13 @@ cpu5: cpu@500 {
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			capacity-dmips-mhz = <1792>;
 			dynamic-power-coefficient = <270>;
+			operating-points-v2 = <&cpu3_opp_table>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &gem_noc SLAVE_LLCC QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&mc_virt MASTER_LLCC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&epss_l3 MASTER_EPSS_L3_APPS
+					 &epss_l3 SLAVE_EPSS_L3_SHARED>;
 			#cooling-cells = <2>;
 			l2_500: l2-cache {
 				compatible = "cache";
@@ -209,6 +252,13 @@ cpu6: cpu@600 {
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			capacity-dmips-mhz = <1792>;
 			dynamic-power-coefficient = <270>;
+			operating-points-v2 = <&cpu3_opp_table>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &gem_noc SLAVE_LLCC QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&mc_virt MASTER_LLCC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&epss_l3 MASTER_EPSS_L3_APPS
+					 &epss_l3 SLAVE_EPSS_L3_SHARED>;
 			#cooling-cells = <2>;
 			l2_600: l2-cache {
 				compatible = "cache";
@@ -230,6 +280,13 @@ cpu7: cpu@700 {
 			qcom,freq-domain = <&cpufreq_hw 2>;
 			capacity-dmips-mhz = <1894>;
 			dynamic-power-coefficient = <588>;
+			operating-points-v2 = <&cpu7_opp_table>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &gem_noc SLAVE_LLCC QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&mc_virt MASTER_LLCC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&epss_l3 MASTER_EPSS_L3_APPS
+					 &epss_l3 SLAVE_EPSS_L3_SHARED>;
 			#cooling-cells = <2>;
 			l2_700: l2-cache {
 				compatible = "cache";
@@ -397,6 +454,306 @@ memory@a0000000 {
 		reg = <0 0xa0000000 0 0>;
 	};
 
+	cpu0_opp_table: opp-table-cpu0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-307200000 {
+			opp-hz = /bits/ 64 <307200000>;
+			opp-peak-kBps = <(300000 * 16) (547000 * 4) (307200 * 32)>;
+		};
+
+		opp-441600000 {
+			opp-hz = /bits/ 64 <441600000>;
+			opp-peak-kBps = <(300000 * 16) (547000 * 4) (384000 * 32)>;
+		};
+
+		opp-556800000 {
+			opp-hz = /bits/ 64 <556800000>;
+			opp-peak-kBps = <(300000 * 16) (547000 * 4) (499200 * 32)>;
+		};
+
+		opp-672000000 {
+			opp-hz = /bits/ 64 <672000000>;
+			opp-peak-kBps = <(300000 * 16) (547000 * 4) (499200 * 32)>;
+		};
+
+		opp-787200000 {
+			opp-hz = /bits/ 64 <787200000>;
+			opp-peak-kBps = <(300000 * 16) (547000 * 4) (729600 * 32)>;
+		};
+
+		opp-902400000 {
+			opp-hz = /bits/ 64 <902400000>;
+			opp-peak-kBps = <(300000 * 16) (547000 * 4) (844800 * 32)>;
+		};
+
+		opp-1017600000 {
+			opp-hz = /bits/ 64 <1017600000>;
+			opp-peak-kBps = <(300000 * 16) (547000 * 4) (940800 * 32)>;
+		};
+
+		opp-1113600000 {
+			opp-hz = /bits/ 64 <1113600000>;
+			opp-peak-kBps = <(300000 * 16) (547000 * 4) (1056000 * 32)>;
+		};
+
+		opp-1228800000 {
+			opp-hz = /bits/ 64 <1228800000>;
+			opp-peak-kBps = <(300000 * 16) (547000 * 4) (1152000 * 32)>;
+		};
+
+		opp-1344000000 {
+			opp-hz = /bits/ 64 <1344000000>;
+			opp-peak-kBps = <(300000 * 16) (547000 * 4) (1267200 * 32)>;
+		};
+
+		opp-1459200000 {
+			opp-hz = /bits/ 64 <1459200000>;
+			opp-peak-kBps = <(300000 * 16) (547000 * 4) (1267200 * 32)>;
+		};
+
+		opp-1555200000 {
+			opp-hz = /bits/ 64 <1555200000>;
+			opp-peak-kBps = <(466000 * 16) (768000 * 4) (1478400 * 32)>;
+		};
+
+		opp-1670400000 {
+			opp-hz = /bits/ 64 <1670400000>;
+			opp-peak-kBps = <(466000 * 16) (768000 * 4) (1478400 * 32)>;
+		};
+
+		opp-1785600000 {
+			opp-hz = /bits/ 64 <1785600000>;
+			opp-peak-kBps = <(466000 * 16) (768000 * 4) (1478400 * 32)>;
+		};
+
+		opp-1900800000 {
+			opp-hz = /bits/ 64 <1900800000>;
+			opp-peak-kBps = <(466000 * 16) (768000 * 4) (1689600 * 32)>;
+		};
+
+		opp-2016000000 {
+			opp-hz = /bits/ 64 <2016000000>;
+			opp-peak-kBps = <(600000 * 16) (1555000 * 4) (1804800 * 32)>;
+		};
+	};
+
+	cpu3_opp_table: opp-table-cpu3 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-499200000 {
+			opp-hz = /bits/ 64 <499200000>;
+			opp-peak-kBps = <(300000 * 16) (547000 * 4) (307200 * 32)>;
+		};
+
+		opp-614400000 {
+			opp-hz = /bits/ 64 <614400000>;
+			opp-peak-kBps = <(300000 * 16) (547000 * 4) (499200 * 32)>;
+		};
+
+		opp-729600000 {
+			opp-hz = /bits/ 64 <729600000>;
+			opp-peak-kBps = <(300000 * 16) (547000 * 4) (499200 * 32)>;
+		};
+
+		opp-844800000 {
+			opp-hz = /bits/ 64 <844800000>;
+			opp-peak-kBps = <(300000 * 16) (547000 * 4) (499200 * 32)>;
+		};
+
+		opp-940800000 {
+			opp-hz = /bits/ 64 <940800000>;
+			opp-peak-kBps = <(300000 * 16) (768000 * 4) (729600 * 32)>;
+		};
+
+		opp-1056000000 {
+			opp-hz = /bits/ 64 <1056000000>;
+			opp-peak-kBps = <(300000 * 16) (768000 * 4) (729600 * 32)>;
+		};
+
+		opp-1171200000 {
+			opp-hz = /bits/ 64 <1171200000>;
+			opp-peak-kBps = <(466000 * 16) (1555000 * 4) (940800 * 32)>;
+		};
+
+		opp-1286400000 {
+			opp-hz = /bits/ 64 <1286400000>;
+			opp-peak-kBps = <(466000 * 16) (1555000 * 4) (940800 * 32)>;
+		};
+
+		opp-1401600000 {
+			opp-hz = /bits/ 64 <1401600000>;
+			opp-peak-kBps = <(600000 * 16) (1708000 * 4) (1056000 * 32)>;
+		};
+
+		opp-1536000000 {
+			opp-hz = /bits/ 64 <1536000000>;
+			opp-peak-kBps = <(600000 * 16) (1708000 * 4) (1056000 * 32)>;
+		};
+
+		opp-1651200000 {
+			opp-hz = /bits/ 64 <1651200000>;
+			opp-peak-kBps = <(600000 * 16) (1708000 * 4) (1267200 * 32)>;
+		};
+
+		opp-1785600000 {
+			opp-hz = /bits/ 64 <1785600000>;
+			opp-peak-kBps = <(600000 * 16) (1708000 * 4) (1267200 * 32)>;
+		};
+
+		opp-1920000000 {
+			opp-hz = /bits/ 64 <1920000000>;
+			opp-peak-kBps = <(806000 * 16) (2736000 * 4) (1267200 * 32)>;
+		};
+
+		opp-2054400000 {
+			opp-hz = /bits/ 64 <2054400000>;
+			opp-peak-kBps = <(806000 * 16) (2736000 * 4) (1478400 * 32)>;
+		};
+
+		opp-2188800000 {
+			opp-hz = /bits/ 64 <2188800000>;
+			opp-peak-kBps = <(806000 * 16) (2736000 * 4) (1478400 * 32)>;
+		};
+
+		opp-2323200000 {
+			opp-hz = /bits/ 64 <2323200000>;
+			opp-peak-kBps = <(806000 * 16) (2736000 * 4) (1478400 * 32)>;
+		};
+
+		opp-2457600000 {
+			opp-hz = /bits/ 64 <2457600000>;
+			opp-peak-kBps = <(806000 * 16) (2736000 * 4) (1478400 * 32)>;
+		};
+
+		opp-2592000000 {
+			opp-hz = /bits/ 64 <2592000000>;
+			opp-peak-kBps = <(806000 * 16) (2736000 * 4) (1478400 * 32)>;
+		};
+
+		opp-2707200000 {
+			opp-hz = /bits/ 64 <2707200000>;
+			opp-peak-kBps = <(933000 * 16) (2736000 * 4) (1478400 * 32)>;
+		};
+
+		opp-2803200000 {
+			opp-hz = /bits/ 64 <2803200000>;
+			opp-peak-kBps = <(933000 * 16) (3686000 * 4) (1689600 * 32)>;
+		};
+	};
+
+	cpu7_opp_table: opp-table-cpu7 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-595200000 {
+			opp-hz = /bits/ 64 <595200000>;
+			opp-peak-kBps = <(300000 * 16) (547000 * 4) (307200 * 32)>;
+		};
+
+		opp-729600000 {
+			opp-hz = /bits/ 64 <729600000>;
+			opp-peak-kBps = <(300000 * 16) (547000 * 4) (499200 * 32)>;
+		};
+
+		opp-864000000 {
+			opp-hz = /bits/ 64 <864000000>;
+			opp-peak-kBps = <(300000 * 16) (547000 * 4) (499200 * 32)>;
+		};
+
+		opp-998400000 {
+			opp-hz = /bits/ 64 <998400000>;
+			opp-peak-kBps = <(300000 * 16) (768000 * 4) (729600 * 32)>;
+		};
+
+		opp-1132800000 {
+			opp-hz = /bits/ 64 <1132800000>;
+			opp-peak-kBps = <(300000 * 16) (768000 * 4) (729600 * 32)>;
+		};
+
+		opp-1248000000 {
+			opp-hz = /bits/ 64 <1248000000>;
+			opp-peak-kBps = <(466000 * 16) (1555000 * 4) (940800 * 32)>;
+		};
+
+		opp-1363200000 {
+			opp-hz = /bits/ 64 <1363200000>;
+			opp-peak-kBps = <(466000 * 16) (1555000 * 4) (940800 * 32)>;
+		};
+
+		opp-1478400000 {
+			opp-hz = /bits/ 64 <1478400000>;
+			opp-peak-kBps = <(600000 * 16) (1708000 * 4) (1056000 * 32)>;
+		};
+
+		opp-1593600000 {
+			opp-hz = /bits/ 64 <1593600000>;
+			opp-peak-kBps = <(600000 * 16) (1708000 * 4) (1056000 * 32)>;
+		};
+
+		opp-1708800000 {
+			opp-hz = /bits/ 64 <1708800000>;
+			opp-peak-kBps = <(600000 * 16) (1708000 * 4) (1267200 * 32)>;
+		};
+
+		opp-1843200000 {
+			opp-hz = /bits/ 64 <1843200000>;
+			opp-peak-kBps = <(600000 * 16) (1708000 * 4) (1267200 * 32)>;
+		};
+
+		opp-1977600000 {
+			opp-hz = /bits/ 64 <1977600000>;
+			opp-peak-kBps = <(806000 * 16) (2736000 * 4) (1267200 * 32)>;
+		};
+
+		opp-2092800000 {
+			opp-hz = /bits/ 64 <2092800000>;
+			opp-peak-kBps = <(806000 * 16) (2736000 * 4) (1478400 * 32)>;
+		};
+
+		opp-2227200000 {
+			opp-hz = /bits/ 64 <2227200000>;
+			opp-peak-kBps = <(806000 * 16) (2736000 * 4) (1478400 * 32)>;
+		};
+
+		opp-2342400000 {
+			opp-hz = /bits/ 64 <2342400000>;
+			opp-peak-kBps = <(806000 * 16) (2736000 * 4) (1478400 * 32)>;
+		};
+
+		opp-2476800000 {
+			opp-hz = /bits/ 64 <2476800000>;
+			opp-peak-kBps = <(806000 * 16) (2736000 * 4) (1478400 * 32)>;
+		};
+
+		opp-2592000000 {
+			opp-hz = /bits/ 64 <2592000000>;
+			opp-peak-kBps = <(806000 * 16) (2736000 * 4) (1478400 * 32)>;
+		};
+
+		opp-2726400000 {
+			opp-hz = /bits/ 64 <2726400000>;
+			opp-peak-kBps = <(933000 * 16) (3686000 * 4) (1478400 * 32)>;
+		};
+
+		opp-2841600000 {
+			opp-hz = /bits/ 64 <2841600000>;
+			opp-peak-kBps = <(933000 * 16) (3686000 * 4) (1689600 * 32)>;
+		};
+
+		opp-2956800000 {
+			opp-hz = /bits/ 64 <2956800000>;
+			opp-peak-kBps = <(933000 * 16) (3686000 * 4) (1689600 * 32)>;
+		};
+
+		opp-3187200000 {
+			opp-hz = /bits/ 64 <3187200000>;
+			opp-peak-kBps = <(933000 * 16) (3686000 * 4) (1689600 * 32)>;
+		};
+	};
+
 	pmu-a510 {
 		compatible = "arm,cortex-a510-pmu";
 		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW &ppi_cluster0>;
@@ -5437,6 +5794,16 @@ rpmhpd_opp_turbo_l1: opp-416 {
 			};
 		};
 
+		epss_l3: interconnect@17d90000 {
+			compatible = "qcom,sm8550-epss-l3", "qcom,epss-l3";
+			reg = <0 0x17d90000 0 0x1000>;
+
+			clocks = <&bi_tcxo_div2>, <&gcc GCC_GPLL0>;
+			clock-names = "xo", "alternate";
+
+			#interconnect-cells = <1>;
+		};
+
 		cpufreq_hw: cpufreq@17d91000 {
 			compatible = "qcom,sm8550-cpufreq-epss", "qcom,cpufreq-epss";
 			reg = <0 0x17d91000 0 0x1000>,

-- 
2.52.0



