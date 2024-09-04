Return-Path: <linux-pm+bounces-13543-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B832596B530
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 10:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68ED22824F1
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 08:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80171D2F6B;
	Wed,  4 Sep 2024 08:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aUk4mUNh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5321F1CEE87;
	Wed,  4 Sep 2024 08:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725439028; cv=none; b=TgxkLZ0MVGQAo+f8uIfH/9iTqS3X56a6ZBjlVxbmxeWFZ0fVuJ4g44I9twoVkhqX77OniS4O67S+5B6QiybHyNWCy8aXzLkfBfUjpjO/fNmt8HPXuF+t9GX1YMJMTym60H9SRw5vojn5SRjQ8M6UrEumTENUqOoeTXcTmvdeRJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725439028; c=relaxed/simple;
	bh=zW/6+GCByPhS7OULBHu6qQ/aJdJtxrI0SFIWLreTeZw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=RGQbUb9RTlK0mp35mNRaoJLg7Yfoa+sL8QOAz0jilmDyGNcAEMnexD+Np9whtAKoQBW8aYN8TZyWCYhMYZ+bz8m6Z7IL0AD9p3iBbAJc6w0QTgX7FZJWrGrFjBmWQwoM6YM64JiBuocrUiUXe6o3e4GeAFHzx3DjIH3R7kUPFPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aUk4mUNh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4840W2Pj009100;
	Wed, 4 Sep 2024 08:36:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yaky0RXEc5hYZiWCBvivvR58FCKNa5kXww4M9u3Rtaw=; b=aUk4mUNhqJQ68qdk
	c9Q/fS8X0zqHgjqfn789bDlasWhN1ah0+sl5SDuaEqBsqqeCQRk5pBpJdnbAShC0
	zQTyhuMpzKHb7mCSFONGfnjMHBs01wcLg4/EyxbjFfi2FdObJWtWX50CdwyWwqAk
	SRHjrnOvXiYdkEaKQUfDN8I1uphG4NWvMPqKQk0hXYxBthT+B3aFPl7O4DBjhKXx
	+ibF4/SSZ0DvlWtw5xoDZh2HmOlu5BqBL28xRO1ZhQT6lDlBKyFRcwk+UpKodqN1
	OyBaiIZllQOMwonAjodUAef3tXVuEDJdolmHNHHeEjYDAnhYa8imfQdpjFufLX1j
	HQYs1Q==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41btrxt256-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 08:36:43 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4848agn2013073
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Sep 2024 08:36:42 GMT
Received: from jingyw-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 4 Sep 2024 01:36:31 -0700
From: Jingyi Wang <quic_jingyw@quicinc.com>
Date: Wed, 4 Sep 2024 16:33:59 +0800
Subject: [PATCH 18/19] arm64: dts: qcom: add initial support for QCS8300
 DTSI
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240904-qcs8300_initial_dtsi-v1-18-d0ea9afdc007@quicinc.com>
References: <20240904-qcs8300_initial_dtsi-v1-0-d0ea9afdc007@quicinc.com>
In-Reply-To: <20240904-qcs8300_initial_dtsi-v1-0-d0ea9afdc007@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Bartosz
 Golaszewski" <bartosz.golaszewski@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>, "Andy Gross" <agross@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Thomas Gleixner" <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
        Robin
 Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh
	<quic_gurus@quicinc.com>,
        Jassi Brar <jassisinghbrar@gmail.com>, Lee Jones
	<lee@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-scsi@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, Jingyi Wang <quic_jingyw@quicinc.com>,
        Zhenhua Huang
	<quic_zhenhuah@quicinc.com>,
        Xin Liu <quic_liuxin@quicinc.com>,
        Kyle Deng
	<quic_chunkaid@quicinc.com>,
        Tingguo Cheng <quic_tingguoc@quicinc.com>,
        Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725438840; l=37176;
 i=quic_jingyw@quicinc.com; s=20240829; h=from:subject:message-id;
 bh=zW/6+GCByPhS7OULBHu6qQ/aJdJtxrI0SFIWLreTeZw=;
 b=dbsvTeoLYDZg9XWiG5h2YTxX7EjET3dbZLPHN9VWDgkZ8EK57vGkhlZhIlf2tXhvs/A9VrWqi
 DfpNx0Si5BGDAPtHvEOZOEY0uZPDeZnOwLtQ+qRlfa48Zmu3Kh4xhcd
X-Developer-Key: i=quic_jingyw@quicinc.com; a=ed25519;
 pk=3tHAHZsIl3cClXtU9HGR1okpPOs9Xyy1M0jzHw6A/qs=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ns3chGZ0sPrSki_AeumUFlXbH-j6R1yP
X-Proofpoint-ORIG-GUID: ns3chGZ0sPrSki_AeumUFlXbH-j6R1yP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_05,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 clxscore=1015 suspectscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2409040065

Add initial DTSI for QCS8300 SoC.

This revision brings support for:
- CPUs with cpu idle
- interrupt-controller with PDC wakeup support
- gcc
- TLMM
- interconnect
- qup with uart
- smmu
- pmic
- ufs
- ipcc
- sram
- remoteprocs including ADSP,CDSP and GPDSP

[Zhenhua: added the smmu node]
Co-developed-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
[Xin: added ufs/adsp/gpdsp nodes]
Co-developed-by: Xin Liu <quic_liuxin@quicinc.com>
Signed-off-by: Xin Liu <quic_liuxin@quicinc.com>
[Kyle: added the aoss_qmp node]
Co-developed-by: Kyle Deng <quic_chunkaid@quicinc.com>
Signed-off-by: Kyle Deng <quic_chunkaid@quicinc.com>
[Tingguo: added the pmic nodes]
Co-developed-by: Tingguo Cheng <quic_tingguoc@quicinc.com>
Signed-off-by: Tingguo Cheng <quic_tingguoc@quicinc.com>
[Raviteja: added interconnect nodes]
Co-developed-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
Signed-off-by: Jingyi Wang <quic_jingyw@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qcs8300.dtsi | 1282 +++++++++++++++++++++++++++++++++
 1 file changed, 1282 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs8300.dtsi b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
new file mode 100644
index 000000000000..244fa8bf97d9
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
@@ -0,0 +1,1282 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <dt-bindings/clock/qcom,qcs8300-gcc.h>
+#include <dt-bindings/clock/qcom,rpmh.h>
+#include <dt-bindings/interconnect/qcom,icc.h>
+#include <dt-bindings/interconnect/qcom,qcs8300-rpmh.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/mailbox/qcom-ipcc.h>
+#include <dt-bindings/power/qcom,rpmhpd.h>
+#include <dt-bindings/power/qcom-rpmpd.h>
+#include <dt-bindings/soc/qcom,rpmh-rsc.h>
+
+/ {
+	interrupt-parent = <&intc>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	clocks {
+		sleep_clk: sleep-clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <32000>;
+		};
+	};
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a78c";
+			reg = <0x0 0x0>;
+			enable-method = "psci";
+			next-level-cache = <&l2_0>;
+			power-domains = <&cpu_pd0>;
+			power-domain-names = "psci";
+
+			l2_0: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
+				next-level-cache = <&l3_0>;
+
+				l3_0: l3-cache {
+					compatible = "cache";
+					cache-level = <3>;
+					cache-unified;
+				};
+			};
+		};
+
+		cpu1: cpu@100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a78c";
+			reg = <0x0 0x100>;
+			enable-method = "psci";
+			next-level-cache = <&l2_1>;
+			power-domains = <&cpu_pd1>;
+			power-domain-names = "psci";
+
+			l2_1: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
+				next-level-cache = <&l3_0>;
+			};
+		};
+
+		cpu2: cpu@200 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a78c";
+			reg = <0x0 0x200>;
+			enable-method = "psci";
+			next-level-cache = <&l2_2>;
+			power-domains = <&cpu_pd2>;
+			power-domain-names = "psci";
+
+			l2_2: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
+				next-level-cache = <&l3_0>;
+			};
+		};
+
+		cpu3: cpu@300 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a78c";
+			reg = <0x0 0x300>;
+			enable-method = "psci";
+			next-level-cache = <&l2_3>;
+			power-domains = <&cpu_pd3>;
+			power-domain-names = "psci";
+
+			l2_3: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
+				next-level-cache = <&l3_0>;
+			};
+		};
+
+		cpu4: cpu@10000 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x0 0x10000>;
+			enable-method = "psci";
+			next-level-cache = <&l2_4>;
+			power-domains = <&cpu_pd4>;
+			power-domain-names = "psci";
+
+			l2_4: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
+				next-level-cache = <&l3_1>;
+
+				l3_1: l3-cache {
+					compatible = "cache";
+					cache-level = <3>;
+					cache-unified;
+				};
+			};
+		};
+
+		cpu5: cpu@10100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x0 0x10100>;
+			enable-method = "psci";
+			next-level-cache = <&l2_5>;
+			power-domains = <&cpu_pd5>;
+			power-domain-names = "psci";
+
+			l2_5: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
+				next-level-cache = <&l3_1>;
+			};
+		};
+
+		cpu6: cpu@10200 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x0 0x10200>;
+			enable-method = "psci";
+			next-level-cache = <&l2_6>;
+			power-domains = <&cpu_pd6>;
+			power-domain-names = "psci";
+
+			l2_6: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
+				next-level-cache = <&l3_1>;
+			};
+		};
+
+		cpu7: cpu@10300 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x0 0x10300>;
+			enable-method = "psci";
+			next-level-cache = <&l2_7>;
+			power-domains = <&cpu_pd7>;
+			power-domain-names = "psci";
+
+			l2_7: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
+				next-level-cache = <&l3_1>;
+			};
+		};
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpu0>;
+				};
+
+				core1 {
+					cpu = <&cpu1>;
+				};
+			};
+
+			cluster1 {
+				core0 {
+					cpu = <&cpu2>;
+				};
+
+				core1 {
+					cpu = <&cpu3>;
+				};
+			};
+
+			cluster2 {
+				core0 {
+					cpu = <&cpu4>;
+				};
+
+				core1 {
+					cpu = <&cpu5>;
+				};
+
+				core2 {
+					cpu = <&cpu6>;
+				};
+
+				core3 {
+					cpu = <&cpu7>;
+				};
+			};
+		};
+
+		idle-states {
+			entry-method = "psci";
+
+			little_cpu_sleep_0: cpu-sleep-0-0 {
+				compatible = "arm,idle-state";
+				idle-state-name = "silver-power-collapse";
+				arm,psci-suspend-param = <0x40000003>;
+				entry-latency-us = <449>;
+				exit-latency-us = <801>;
+				min-residency-us = <1574>;
+				local-timer-stop;
+			};
+
+			little_cpu_sleep_1: cpu-sleep-0-1 {
+				compatible = "arm,idle-state";
+				idle-state-name = "silver-rail-power-collapse";
+				arm,psci-suspend-param = <0x40000004>;
+				entry-latency-us = <602>;
+				exit-latency-us = <961>;
+				min-residency-us = <4288>;
+				local-timer-stop;
+			};
+
+			big_cpu_sleep_0: cpu-sleep-1-0 {
+				compatible = "arm,idle-state";
+				idle-state-name = "gold-power-collapse";
+				arm,psci-suspend-param = <0x40000003>;
+				entry-latency-us = <549>;
+				exit-latency-us = <901>;
+				min-residency-us = <1774>;
+				local-timer-stop;
+			};
+
+			big_cpu_sleep_1: cpu-sleep-1-1 {
+				compatible = "arm,idle-state";
+				idle-state-name = "gold-rail-power-collapse";
+				arm,psci-suspend-param = <0x40000004>;
+				entry-latency-us = <702>;
+				exit-latency-us = <1061>;
+				min-residency-us = <4488>;
+				local-timer-stop;
+			};
+		};
+
+		domain-idle-states {
+			silver_cluster_sleep: cluster-sleep-0 {
+				compatible = "domain-idle-state";
+				arm,psci-suspend-param = <0x41000044>;
+				entry-latency-us = <2552>;
+				exit-latency-us = <2848>;
+				min-residency-us = <5908>;
+			};
+
+			gold_cluster_sleep: cluster-sleep-1 {
+				compatible = "domain-idle-state";
+				arm,psci-suspend-param = <0x41000044>;
+				entry-latency-us = <2752>;
+				exit-latency-us = <3048>;
+				min-residency-us = <6118>;
+			};
+
+			system_sleep: domain-sleep {
+				compatible = "domain-idle-state";
+				arm,psci-suspend-param = <0x42000144>;
+				entry-latency-us = <3263>;
+				exit-latency-us = <6562>;
+				min-residency-us = <9987>;
+			};
+		};
+	};
+
+	firmware {
+		scm: scm {
+			compatible = "qcom,scm-qcs8300", "qcom,scm";
+			qcom,dload-mode = <&tcsr 0x13000>;
+		};
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		/* We expect the bootloader to fill in the size */
+		reg = <0x0 0x80000000 0x0 0x0>;
+	};
+
+	clk_virt: interconnect-0 {
+		compatible = "qcom,qcs8300-clk-virt";
+		#interconnect-cells = <2>;
+		qcom,bcm-voters = <&apps_bcm_voter>;
+	};
+
+	mc_virt: interconnect-1 {
+		compatible = "qcom,qcs8300-mc-virt";
+		#interconnect-cells = <2>;
+		qcom,bcm-voters = <&apps_bcm_voter>;
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+
+		cpu_pd0: power-domain-cpu0 {
+			#power-domain-cells = <0>;
+			power-domains = <&cluster_pd0>;
+			domain-idle-states = <&big_cpu_sleep_0 &big_cpu_sleep_1>;
+		};
+
+		cpu_pd1: power-domain-cpu1 {
+			#power-domain-cells = <0>;
+			power-domains = <&cluster_pd0>;
+			domain-idle-states = <&big_cpu_sleep_0 &big_cpu_sleep_1>;
+		};
+
+		cpu_pd2: power-domain-cpu2 {
+			#power-domain-cells = <0>;
+			power-domains = <&cluster_pd0>;
+			domain-idle-states = <&big_cpu_sleep_0 &big_cpu_sleep_1>;
+		};
+
+		cpu_pd3: power-domain-cpu3 {
+			#power-domain-cells = <0>;
+			power-domains = <&cluster_pd0>;
+			domain-idle-states = <&big_cpu_sleep_0 &big_cpu_sleep_1>;
+		};
+
+		cpu_pd4: power-domain-cpu4 {
+			#power-domain-cells = <0>;
+			power-domains = <&cluster_pd1>;
+			domain-idle-states = <&little_cpu_sleep_0 &little_cpu_sleep_1>;
+		};
+
+		cpu_pd5: power-domain-cpu5 {
+			#power-domain-cells = <0>;
+			power-domains = <&cluster_pd1>;
+			domain-idle-states = <&little_cpu_sleep_0 &little_cpu_sleep_1>;
+		};
+
+		cpu_pd6: power-domain-cpu6 {
+			#power-domain-cells = <0>;
+			power-domains = <&cluster_pd1>;
+			domain-idle-states = <&little_cpu_sleep_0 &little_cpu_sleep_1>;
+		};
+
+		cpu_pd7: power-domain-cpu7 {
+			#power-domain-cells = <0>;
+			power-domains = <&cluster_pd1>;
+			domain-idle-states = <&little_cpu_sleep_0 &little_cpu_sleep_1>;
+		};
+
+		cluster_pd0: power-domain-cluster0 {
+			#power-domain-cells = <0>;
+			power-domains = <&system_pd>;
+			domain-idle-states = <&gold_cluster_sleep>;
+		};
+
+		cluster_pd1: power-domain-cluster1 {
+			#power-domain-cells = <0>;
+			power-domains = <&system_pd>;
+			domain-idle-states = <&silver_cluster_sleep>;
+		};
+
+		system_pd: power-domain-system {
+			#power-domain-cells = <0>;
+			domain-idle-states = <&system_sleep>;
+		};
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		aop_image_mem: aop-image-region@90800000 {
+			reg = <0x0 0x90800000 0x0 0x60000>;
+			no-map;
+		};
+
+		aop_cmd_db_mem: aop-cmd-db-region@90860000 {
+			compatible = "qcom,cmd-db";
+			reg = <0x0 0x90860000 0x0 0x20000>;
+			no-map;
+		};
+
+		smem_mem: smem@90900000 {
+			compatible = "qcom,smem";
+			reg = <0x0 0x90900000 0x0 0x200000>;
+			no-map;
+			hwlocks = <&tcsr_mutex 3>;
+		};
+
+		lpass_machine_learning_mem: lpass-machine-learning-region@93b00000 {
+			reg = <0x0 0x93b00000 0x0 0xf00000>;
+			no-map;
+		};
+
+		adsp_rpc_remote_heap_mem: adsp-rpc-remote-heap-region@94a00000 {
+			reg = <0x0 0x94a00000 0x0 0x800000>;
+			no-map;
+		};
+
+		camera_mem: camera-region@95200000 {
+			reg = <0x0 0x95200000 0x0 0x500000>;
+			no-map;
+		};
+
+		adsp_mem: adsp-region@95c00000 {
+			no-map;
+			reg = <0x0 0x95c00000 0x0 0x1e00000>;
+		};
+
+		q6_adsp_dtb_mem: q6-adsp-dtb-region@97a00000 {
+			reg = <0x0 0x97a00000 0x0 0x80000>;
+			no-map;
+		};
+
+		q6_gpdsp_dtb_mem: q6-gpdsp-dtb-region@97a80000 {
+			reg = <0x0 0x97a80000 0x0 0x80000>;
+			no-map;
+		};
+
+		gpdsp_mem: gpdsp-region@97b00000 {
+			reg = <0x0 0x97b00000 0x0 0x1e00000>;
+			no-map;
+		};
+
+		q6_cdsp_dtb_mem: q6-cdsp-dtb-region@99900000 {
+			reg = <0x0 0x99900000 0x0 0x80000>;
+			no-map;
+		};
+
+		cdsp_mem: cdsp-region@99980000 {
+			reg = <0x0 0x99980000 0x0 0x1e00000>;
+			no-map;
+		};
+
+		gpu_microcode_mem: gpu-microcode-region@9b780000 {
+			reg = <0x0 0x9b780000 0x0 0x2000>;
+			no-map;
+		};
+
+		cvp_mem: cvp-region@9b782000 {
+			reg = <0x0 0x9b782000 0x0 0x700000>;
+			no-map;
+		};
+
+		video_mem: video-region@9be82000 {
+			reg = <0x0 0x9be82000 0x0 0x700000>;
+			no-map;
+		};
+	};
+
+	smp2p-adsp {
+		compatible = "qcom,smp2p";
+		interrupts-extended = <&ipcc IPCC_CLIENT_LPASS
+					     IPCC_MPROC_SIGNAL_SMP2P
+					     IRQ_TYPE_EDGE_RISING>;
+		mboxes = <&ipcc IPCC_CLIENT_LPASS
+				IPCC_MPROC_SIGNAL_SMP2P>;
+
+		qcom,smem = <443>, <429>;
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <2>;
+
+		smp2p_adsp_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		smp2p_adsp_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	smp2p-cdsp {
+		compatible = "qcom,smp2p";
+		interrupts-extended = <&ipcc IPCC_CLIENT_CDSP
+					     IPCC_MPROC_SIGNAL_SMP2P
+					     IRQ_TYPE_EDGE_RISING>;
+		mboxes = <&ipcc IPCC_CLIENT_CDSP
+				IPCC_MPROC_SIGNAL_SMP2P>;
+
+		qcom,smem = <94>, <432>;
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <5>;
+
+		smp2p_cdsp_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		smp2p_cdsp_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	smp2p-gpdsp {
+		compatible = "qcom,smp2p";
+		interrupts-extended = <&ipcc IPCC_CLIENT_GPDSP0
+					     IPCC_MPROC_SIGNAL_SMP2P
+					     IRQ_TYPE_EDGE_RISING>;
+		mboxes = <&ipcc IPCC_CLIENT_GPDSP0
+				IPCC_MPROC_SIGNAL_SMP2P>;
+
+		qcom,smem = <617>, <616>;
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <17>;
+
+		smp2p_gpdsp_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		smp2p_gpdsp_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	soc: soc@0 {
+		compatible = "simple-bus";
+
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0 0 0 0 0x10 0>;
+
+		gcc: clock-controller@100000 {
+			compatible = "qcom,qcs8300-gcc";
+			reg = <0x0 0x00100000 0x0 0xc7018>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>,
+				 <&sleep_clk>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <0>;
+		};
+
+		ipcc: mailbox@408000 {
+			compatible = "qcom,qcs8300-ipcc", "qcom,ipcc";
+			reg = <0x0 0x408000 0x0 0x1000>;
+			interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			#mbox-cells = <2>;
+		};
+
+		qfprom: efuse@784000 {
+			compatible = "qcom,qcs8300-qfprom", "qcom,qfprom";
+			reg = <0x0 0x00784000 0x0 0x1200>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+
+		qupv3_id_0: geniqup@9c0000 {
+			compatible = "qcom,geni-se-qup";
+			reg = <0x0 0x9c0000 0x0 0x2000>;
+			ranges;
+			clocks = <&gcc GCC_QUPV3_WRAP_0_M_AHB_CLK>,
+				 <&gcc GCC_QUPV3_WRAP_0_S_AHB_CLK>;
+			clock-names = "m-ahb", "s-ahb";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			status = "disabled";
+
+			uart7: serial@99c000 {
+				compatible = "qcom,geni-debug-uart";
+				reg = <0x0 0x0099c000 0x0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP0_S7_CLK>;
+				clock-names = "se";
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_uart7_default>;
+				interrupts = <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>;
+				interconnect-names = "qup-core", "qup-config";
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 0
+						 &clk_virt SLAVE_QUP_CORE_0 0>,
+						<&gem_noc MASTER_APPSS_PROC 0
+						 &config_noc SLAVE_QUP_0 0>;
+				status = "disabled";
+			};
+		};
+
+		config_noc: interconnect@14c0000 {
+			compatible = "qcom,qcs8300-config-noc";
+			reg = <0x0 0x014c0000 0x0 0x13080>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		system_noc: interconnect@1680000 {
+			compatible = "qcom,qcs8300-system-noc";
+			reg = <0x0 0x01680000 0x0 0x15080>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		aggre1_noc: interconnect@16c0000 {
+			compatible = "qcom,qcs8300-aggre1-noc";
+			reg = <0x0 0x016c0000 0x0 0x17080>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		aggre2_noc: interconnect@1700000 {
+			compatible = "qcom,qcs8300-aggre2-noc";
+			reg = <0x0 0x01700000 0x0 0x1a080>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		pcie_anoc: interconnect@1760000 {
+			compatible = "qcom,qcs8300-pcie-anoc";
+			reg = <0x0 0x01760000 0x0 0xc080>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		gpdsp_anoc: interconnect@1780000 {
+			compatible = "qcom,qcs8300-gpdsp-anoc";
+			reg = <0x0 0x01780000 0x0 0xd080>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		mmss_noc: interconnect@17a0000 {
+			compatible = "qcom,qcs8300-mmss-noc";
+			reg = <0x0 0x017a0000 0x0 0x40000>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		ufs_mem_hc: ufs@1d84000 {
+			compatible = "qcom,qcs8300-ufshc", "qcom,ufshc", "jedec,ufs-2.0";
+			reg = <0x0 0x01d84000 0x0 0x3000>;
+			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
+			phys = <&ufs_mem_phy>;
+			phy-names = "ufsphy";
+			lanes-per-direction = <2>;
+			#reset-cells = <1>;
+			resets = <&gcc GCC_UFS_PHY_BCR>;
+			reset-names = "rst";
+
+			power-domains = <&gcc GCC_UFS_PHY_GDSC>;
+			required-opps = <&rpmhpd_opp_nom>;
+
+			iommus = <&apps_smmu 0x100 0x0>;
+			dma-coherent;
+
+			interconnects = <&aggre1_noc MASTER_UFS_MEM 0
+					 &mc_virt SLAVE_EBI1 0>,
+					<&gem_noc MASTER_APPSS_PROC 0
+					 &config_noc SLAVE_UFS_MEM_CFG 0>;
+			interconnect-names = "ufs-ddr", "cpu-ufs";
+
+			clocks = <&gcc GCC_UFS_PHY_AXI_CLK>,
+				 <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
+				 <&gcc GCC_UFS_PHY_AHB_CLK>,
+				 <&gcc GCC_UFS_PHY_UNIPRO_CORE_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK>,
+				 <&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
+				 <&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
+				 <&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>;
+			clock-names = "core_clk",
+				      "bus_aggr_clk",
+				      "iface_clk",
+				      "core_clk_unipro",
+				      "ref_clk",
+				      "tx_lane0_sync_clk",
+				      "rx_lane0_sync_clk",
+				      "rx_lane1_sync_clk";
+			freq-table-hz = <75000000 300000000>,
+					<0 0>,
+					<0 0>,
+					<75000000 300000000>,
+					<0 0>,
+					<0 0>,
+					<0 0>,
+					<0 0>;
+			status = "disabled";
+		};
+
+		ufs_mem_phy: phy@1d87000 {
+			compatible = "qcom,qcs8300-qmp-ufs-phy";
+			reg = <0x0 0x01d87000 0x0 0xe10>;
+			/*
+			 * Yes, GCC_EDP_REF_CLKREF_EN is correct in qref. It
+			 * enables the CXO clock to eDP *and* UFS PHY.
+			 */
+			clocks = <&rpmhcc RPMH_CXO_CLK>,
+				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>,
+				 <&gcc GCC_EDP_REF_CLKREF_EN>;
+			clock-names = "ref", "ref_aux", "qref";
+			power-domains = <&gcc GCC_UFS_PHY_GDSC>;
+
+			resets = <&ufs_mem_hc 0>;
+			reset-names = "ufsphy";
+
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+
+		tcsr_mutex: hwlock@1f40000 {
+			compatible = "qcom,tcsr-mutex";
+			reg = <0x0 0x01f40000 0x0 0x20000>;
+			#hwlock-cells = <1>;
+		};
+
+		tcsr: syscon@1fc0000 {
+			compatible = "qcom,qcs8300-tcsr", "syscon";
+			reg = <0x0 0x1fc0000 0x0 0x30000>;
+		};
+
+		remoteproc_adsp: remoteproc@3000000 {
+			compatible = "qcom,qcs8300-adsp-pas";
+			reg = <0x0 0x3000000 0x0 0x00100>;
+
+			interrupts-extended = <&pdc 6 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_adsp_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_adsp_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_adsp_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_adsp_in 3 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog", "fatal", "ready",
+					  "handover", "stop-ack";
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "xo";
+
+			power-domains = <&rpmhpd RPMHPD_LCX>,
+					<&rpmhpd RPMHPD_LMX>;
+			power-domain-names = "lcx", "lmx";
+
+			memory-region = <&adsp_mem>;
+
+			qcom,qmp = <&aoss_qmp>;
+
+			qcom,smem-states = <&smp2p_adsp_out 0>;
+			qcom,smem-state-names = "stop";
+
+			status = "disabled";
+
+			remoteproc_adsp_glink: glink-edge {
+				interrupts-extended = <&ipcc IPCC_CLIENT_LPASS
+							     IPCC_MPROC_SIGNAL_GLINK_QMP
+							     IRQ_TYPE_EDGE_RISING>;
+				mboxes = <&ipcc IPCC_CLIENT_LPASS
+						IPCC_MPROC_SIGNAL_GLINK_QMP>;
+
+				label = "lpass";
+				qcom,remote-pid = <2>;
+			};
+		};
+
+		lpass_ag_noc: interconnect@3c40000 {
+			compatible = "qcom,qcs8300-lpass-ag-noc";
+			reg = <0x0 0x03c40000 0x0 0x17200>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		dc_noc: interconnect@90e0000 {
+			compatible = "qcom,qcs8300-dc-noc";
+			reg = <0x0 0x090e0000 0x0 0x5080>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		gem_noc: interconnect@9100000 {
+			compatible = "qcom,qcs8300-gem-noc";
+			reg = <0x0 0x9100000 0x0 0xf7080>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		pdc: interrupt-controller@b220000 {
+			compatible = "qcom,qcs8300-pdc", "qcom,pdc";
+			reg = <0x0 0xb220000 0x0 0x30000>,
+			      <0x0 0x17c000f0 0x0 0x64>;
+			interrupt-parent = <&intc>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			qcom,pdc-ranges = <0 480 40>,
+					  <40 140 14>,
+					  <54 263 1>,
+					  <55 306 4>,
+					  <59 312 3>,
+					  <62 374 2>,
+					  <64 434 2>,
+					  <66 438 2>,
+					  <70 520 1>,
+					  <73 523 1>,
+					  <118 568 6>,
+					  <124 609 3>,
+					  <159 638 1>,
+					  <160 720 3>,
+					  <169 728 30>,
+					  <199 416 2>,
+					  <201 449 1>,
+					  <202 89 1>,
+					  <203 451 1>,
+					  <204 462 1>,
+					  <205 264 1>,
+					  <206 579 1>,
+					  <207 653 1>,
+					  <208 656 1>,
+					  <209 659 1>,
+					  <210 122 1>,
+					  <211 699 1>,
+					  <212 705 1>,
+					  <213 450 1>,
+					  <214 643 2>,
+					  <216 646 5>,
+					  <221 390 5>,
+					  <226 700 2>,
+					  <228 440 1>,
+					  <229 663 1>,
+					  <230 524 2>,
+					  <232 612 3>,
+					  <235 723 5>;
+		};
+
+		aoss_qmp: power-management@c300000 {
+			compatible = "qcom,qcs8300-aoss-qmp", "qcom,aoss-qmp";
+			reg = <0x0 0x0c300000 0x0 0x400>;
+			interrupts-extended = <&ipcc IPCC_CLIENT_AOP
+					       IPCC_MPROC_SIGNAL_GLINK_QMP
+					       IRQ_TYPE_EDGE_RISING>;
+			mboxes = <&ipcc IPCC_CLIENT_AOP IPCC_MPROC_SIGNAL_GLINK_QMP>;
+			#clock-cells = <0>;
+		};
+
+		tlmm: pinctrl@f100000 {
+			compatible = "qcom,qcs8300-tlmm";
+			reg = <0x0 0x0f100000 0x0 0x300000>;
+			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&tlmm 0 0 133>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			wakeup-parent = <&pdc>;
+
+			qup_uart7_default: qup-uart7-state {
+				/* TX, RX */
+				pins = "gpio43", "gpio44";
+				function = "qup0_se7";
+			};
+		};
+
+		sram: sram@146d8000 {
+			compatible = "qcom,qcs8300-imem", "syscon", "simple-mfd";
+			reg = <0x0 0x146d8000 0x0 0x1000>;
+			ranges = <0x0 0x0 0x146d8000 0x1000>;
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			pil-reloc@94c {
+				compatible = "qcom,pil-reloc-info";
+				reg = <0x94c 0xc8>;
+			};
+		};
+
+		apps_smmu: iommu@15000000 {
+			compatible = "qcom,qcs8300-smmu-500", "qcom,smmu-500", "arm,mmu-500";
+
+			reg = <0x0 0x15000000 0x0 0x100000>;
+			#iommu-cells = <2>;
+			#global-interrupts = <2>;
+			dma-coherent;
+
+			interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI  98 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI  99 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 318 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 319 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 322 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 396 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 398 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 399 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 401 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 402 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 412 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 706 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 689 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 690 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 691 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 692 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 693 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 694 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 695 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 696 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 410 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 411 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 420 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 413 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 707 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 708 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 709 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 710 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 711 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 414 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 712 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 713 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 714 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 715 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 912 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 911 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 910 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 909 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 908 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 907 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 906 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 905 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 904 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 903 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 902 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 901 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 900 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 899 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 898 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 897 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 896 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 895 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		intc: interrupt-controller@17a00000 {
+			compatible = "arm,gic-v3";
+			reg = <0x0 0x17a00000 0x0 0x10000>,     /* GICD */
+			      <0x0 0x17a60000 0x0 0x100000>;    /* GICR * 8 */
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			#redistributor-regions = <1>;
+			redistributor-stride = <0x0 0x20000>;
+		};
+
+		memtimer: timer@17c20000 {
+			compatible = "arm,armv7-timer-mem";
+			reg = <0x0 0x17c20000 0x0 0x1000>;
+			ranges = <0x0 0x0 0x0 0x20000000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			frame@17c21000 {
+				reg = <0x17c21000 0x1000>,
+				      <0x17c22000 0x1000>;
+				frame-number = <0>;
+				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			frame@17c23000 {
+				reg = <0x17c23000 0x1000>;
+				frame-number = <1>;
+				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
+
+			frame@17c25000 {
+				reg = <0x17c25000 0x1000>;
+				frame-number = <2>;
+				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
+
+			frame@17c27000 {
+				reg = <0x17c27000 0x1000>;
+				frame-number = <3>;
+				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
+
+			frame@17c29000 {
+				reg = <0x17c29000 0x1000>;
+				frame-number = <4>;
+				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
+
+			frame@17c2b000 {
+				reg = <0x17c2b000 0x1000>;
+				frame-number = <5>;
+				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
+
+			frame@17c2d000 {
+				reg = <0x17c2d000 0x1000>;
+				frame-number = <6>;
+				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
+		};
+
+		apps_rsc: rsc@18200000 {
+			compatible = "qcom,rpmh-rsc";
+			reg = <0x0 0x18200000 0x0 0x10000>,
+			      <0x0 0x18210000 0x0 0x10000>,
+			      <0x0 0x18220000 0x0 0x10000>;
+			reg-names = "drv-0", "drv-1", "drv-2";
+			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
+
+			power-domains = <&system_pd>;
+			label = "apps_rsc";
+
+			qcom,tcs-offset = <0xd00>;
+			qcom,drv-id = <2>;
+			qcom,tcs-config = <ACTIVE_TCS 2>,
+					  <SLEEP_TCS 3>,
+					  <WAKE_TCS 3>,
+					  <CONTROL_TCS 0>;
+
+			apps_bcm_voter: bcm-voter {
+				compatible = "qcom,bcm-voter";
+			};
+
+			rpmhcc: clock-controller {
+				compatible = "qcom,sa8775p-rpmh-clk";
+				#clock-cells = <1>;
+			};
+
+			rpmhpd: power-controller {
+				compatible = "qcom,qcs8300-rpmhpd";
+				#power-domain-cells = <1>;
+				operating-points-v2 = <&rpmhpd_opp_table>;
+
+				rpmhpd_opp_table: opp-table {
+					compatible = "operating-points-v2";
+
+					rpmhpd_opp_ret: opp-0 {
+						opp-level = <RPMH_REGULATOR_LEVEL_RETENTION>;
+					};
+
+					rpmhpd_opp_min_svs: opp-1 {
+						opp-level = <RPMH_REGULATOR_LEVEL_MIN_SVS>;
+					};
+
+					rpmhpd_opp_low_svs: opp-2 {
+						opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
+					};
+
+					rpmhpd_opp_svs: opp-3 {
+						opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
+					};
+
+					rpmhpd_opp_svs_l1: opp-4 {
+						opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
+					};
+
+					rpmhpd_opp_nom: opp-5 {
+						opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
+					};
+
+					rpmhpd_opp_nom_l1: opp-6 {
+						opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
+					};
+
+					rpmhpd_opp_nom_l2: opp-7 {
+						opp-level = <RPMH_REGULATOR_LEVEL_NOM_L2>;
+					};
+
+					rpmhpd_opp_turbo: opp-8 {
+						opp-level = <RPMH_REGULATOR_LEVEL_TURBO>;
+					};
+
+					rpmhpd_opp_turbo_l1: opp-9 {
+						opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
+					};
+				};
+			};
+		};
+
+		remoteproc_gpdsp: remoteproc@20c00000 {
+			compatible = "qcom,qcs8300-gpdsp-pas";
+			reg = <0x0 0x20c00000 0x0 0x10000>;
+
+			interrupts-extended = <&intc GIC_SPI 768 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_gpdsp_in 0 0>,
+					      <&smp2p_gpdsp_in 1 0>,
+					      <&smp2p_gpdsp_in 2 0>,
+					      <&smp2p_gpdsp_in 3 0>;
+			interrupt-names = "wdog", "fatal", "ready",
+					  "handover", "stop-ack";
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "xo";
+
+			power-domains = <&rpmhpd RPMHPD_CX>,
+					<&rpmhpd RPMHPD_MXC>;
+			power-domain-names = "cx", "mxc";
+
+			interconnects = <&gpdsp_anoc MASTER_DSP0 0 &config_noc SLAVE_CLK_CTL 0>;
+
+			memory-region = <&gpdsp_mem>;
+
+			qcom,qmp = <&aoss_qmp>;
+
+			qcom,smem-states = <&smp2p_gpdsp_out 0>;
+			qcom,smem-state-names = "stop";
+
+			status = "disabled";
+
+			glink-edge {
+				interrupts-extended = <&ipcc IPCC_CLIENT_GPDSP0
+							     IPCC_MPROC_SIGNAL_GLINK_QMP
+							     IRQ_TYPE_EDGE_RISING>;
+				mboxes = <&ipcc IPCC_CLIENT_GPDSP0
+						IPCC_MPROC_SIGNAL_GLINK_QMP>;
+
+				label = "gpdsp";
+				qcom,remote-pid = <17>;
+			};
+		};
+
+		nspa_noc: interconnect@260c0000 {
+			compatible = "qcom,qcs8300-nspa-noc";
+			reg = <0x0 0x260c0000 0x0 0x16080>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		remoteproc_cdsp: remoteproc@26300000 {
+			compatible = "qcom,qcs8300-cdsp-pas";
+			reg = <0x0 0x26300000 0x0 0x10000>;
+
+			interrupts-extended = <&intc GIC_SPI 578 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_cdsp_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_cdsp_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_cdsp_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_cdsp_in 3 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog", "fatal", "ready",
+					  "handover", "stop-ack";
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "xo";
+
+			power-domains = <&rpmhpd RPMHPD_CX>,
+					<&rpmhpd RPMHPD_MXC>,
+					<&rpmhpd RPMHPD_NSP0>;
+
+			power-domain-names = "cx", "mxc", "nsp";
+
+			interconnects = <&nspa_noc MASTER_CDSP_PROC 0 &mc_virt SLAVE_EBI1 0>;
+
+			memory-region = <&cdsp_mem>;
+
+			qcom,qmp = <&aoss_qmp>;
+
+			qcom,smem-states = <&smp2p_cdsp_out 0>;
+			qcom,smem-state-names = "stop";
+
+			status = "disabled";
+
+			glink-edge {
+				interrupts-extended = <&ipcc IPCC_CLIENT_CDSP
+							     IPCC_MPROC_SIGNAL_GLINK_QMP
+							     IRQ_TYPE_EDGE_RISING>;
+				mboxes = <&ipcc IPCC_CLIENT_CDSP
+						IPCC_MPROC_SIGNAL_GLINK_QMP>;
+
+				label = "cdsp";
+				qcom,remote-pid = <5>;
+			};
+		};
+	};
+
+	arch_timer: timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 12 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+};

-- 
2.25.1


