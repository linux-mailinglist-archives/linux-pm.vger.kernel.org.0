Return-Path: <linux-pm+bounces-28379-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAD0AD384F
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 15:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B44D7AE626
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 13:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F069429AAE3;
	Tue, 10 Jun 2025 13:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Liy1rDUv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F6B2980D0;
	Tue, 10 Jun 2025 13:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749560623; cv=none; b=POuD2ZB2uBfeCDu/3bh1nQdpATQwuR/sGFl8qefGSx0SjN8mooMGmbkiJJltmMjEDOuk9pwpgyukvMz+jvFpvCOX0nNLzVj268mBgKUqfebLrs9D3vOCmdrl0q1qD/4KmGjlQfUR3i1Cu6gshKbOpVNBfHPLNDri/BMEusNMB2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749560623; c=relaxed/simple;
	bh=VtRG7DfzhJh56X3RJNGS6YUWTSlI7il++qkOZT/n2j0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Xh2p3HyHHBxnl79zkbWPDvWBhRznIU0i3yGmdXaRQzJ4SMCAl9Jf/bSGd1ltwxsP81p10iGdUPNe3nprFSjEUQKZr03jFmjnSS1t3M1LsmoC8LSX8VIcj1NIY5n4n53pj4wVhGhRd0KB/gW5VAfPnlklutq9TPHhlvoiLMl+yuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Liy1rDUv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9C2B7C4CEED;
	Tue, 10 Jun 2025 13:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749560623;
	bh=VtRG7DfzhJh56X3RJNGS6YUWTSlI7il++qkOZT/n2j0=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=Liy1rDUv+UlTCCsd97xZODV/uK9bD0kU2uTpPkHI/Bol5SwnGVFxsDtrgVKpPTH4m
	 lZhEmE+rGdxEvBl7E/2FxhO5l/OU+clxbVrammr9I1DOctl8uCBQXnQItvx7jLr7US
	 nlMiLVKFQ0WerqITLsgQAIMP6wNj7XMHEdwX5MjikEtJdtqtw7wdWq6sC3E/BRc5mE
	 Fsd135hgctWsY/irN+shC3Xv60ZzekgmRduzBMNNC+qw6aiVu4a7+dlyCRD2OE0VxZ
	 CSpR5VeX8A+OWYJWlUmOgvHUyRpWfeuid67hAJX5KdO96QWvBx0G7KUxFHp4ty4Uow
	 NBuXMw8WD8aVg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1F7C5B552;
	Tue, 10 Jun 2025 13:03:43 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Tue, 10 Jun 2025 17:03:34 +0400
Subject: [PATCH v10] arm64: dts: qcom: ipq5018: Add tsens node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250610-ipq5018-tsens-v10-1-3a10a5a2642c@outlook.com>
X-B4-Tracking: v=1; b=H4sIACUtSGgC/1WMQQ+CIABG/4rjHA5QFDo1oWNbq2PrYALJSiCw1
 ub87zlvHd+3770JJB2tTmCbTSDqj03WuwUw2mSg61t319CqZQAEEYpKVEIbXhRhBsekXYJVeTO
 cGlUUuAaLE6I29rsGL9eFTfQDHPuo27Uiz/XxhPmhYYwVlRQVryjFdI+JrFHTEMGlEGT3d8tdO
 4SoMM9D9Cr37/Hp/SPv/ADm+QeMRN+4wQAAAA==
X-Change-ID: 20250404-ipq5018-tsens-64bf95fd3317
To: Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 George Moussalem <george.moussalem@outlook.com>, 
 Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749560621; l=9602;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=yu3qG3q34AVTZVwyPg7XgkDM9uBnXGU5mfAmQhOKUAo=;
 b=D8XiKy7N34c5iF/yKh41z9UXEkkUHv1N5i61xCQJWMg9OKdn6kZk8yn3liDmyqKBcrqhth1Ok
 ThaC6R2uaMJCmWVE6gAKR3wq/Jz9Q1xaJ/VPY9lvtD80eku9mPFn5Vs
X-Developer-Key: i=george.moussalem@outlook.com; a=ed25519;
 pk=/PuRTSI9iYiHwcc6Nrde8qF4ZDhJBlUgpHdhsIjnqIk=
X-Endpoint-Received: by B4 Relay for george.moussalem@outlook.com/20250321
 with auth_id=364
X-Original-From: George Moussalem <george.moussalem@outlook.com>
Reply-To: george.moussalem@outlook.com

From: Sricharan Ramabadhran <quic_srichara@quicinc.com>

IPQ5018 has tsens V1.0 IP with 5 sensors, though 4 are in use.
There is no RPM, so tsens has to be manually enabled. Adding the tsens
and nvmem nodes and adding 4 thermal sensors (zones). With the
critical temperature being 120'C and action is to reboot.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
IPQ5018 has tsens V1.0 IP with 5 sensors, of which 4 are in use,
and 1 interrupt. There is no RPM present in the soc to do tsens early
enable. Adding support for the same here.

Last patch series sent by Qualcomm dates back to Sep 22, 2023.
Since I'm working on OpenWrt support for IPQ5018 based boards (routers)
and Sricharan Ramabadhran <quic_srichara@quicinc.com> in below email
confirmed this SoC is still active, I'm continuing the efforts to send
patches upstream for Linux kernel support.
https://lore.kernel.org/all/63dc4054-b1e2-4e7a-94e7-643beb26a6f3@quicinc.com/

[v10]
	*) Rebased onto updated pull of master to resolve merge conflicts in the
	   DTS patch
	*) Link to v9: https://lore.kernel.org/all/DS7PR19MB88836DC6965515E12D70BB2C9DCC2@DS7PR19MB8883.namprd19.prod.outlook.com/

[v9]
	*) Updated checks in tsens to more strictly evaluate for v2+ upon enabling
	   v2 features as suggsted by Dmitry.
	*) Split patch 3 into two, one to update conditional statements as
	   mentioned above and the other to implement tsens IP v1 without RPM.
	*) Added back Dmitry's RB tag on patch 6 which wasn't carried over
	   from v7 to v8
	*) Link to v8: https://lore.kernel.org/all/DS7PR19MB88833F7A9C8F4FC484977BA69DCD2@DS7PR19MB8883.namprd19.prod.outlook.com/

[v8]
	*) Tsens V1 uses v1 interrupts and watchdog is not present (only on v2.3+).
	   As such, replaced VER_1_X with VER_1_X_NO_RPM in conditons to ensure
	   v1 interrupts are set and watchdog isn't enabled.
	*) Tested on Linksys MX2000 and SPNMX56
	*) Link to v7: https://lore.kernel.org/all/DS7PR19MB88831624F11516945C63400F9DC22@DS7PR19MB8883.namprd19.prod.outlook.com/

[v7]
	*) Updated cover letter
	*) Replaced patch 3 with a new one to add support for tsens v1.0 with
	   no RPM and removed Dmitry's 'Reviewed-by tag
	*) Refactored patch 4 and split support for IPQ5018 from support for
	   tsens v1.0 without RPM. As such, also removed Dmitry's RB tag.
	*) Depends on patch 1 and 2 from patch series to add support for
	   IQP5332 and IPQ5424 applied on Feb 11 2025:
	   https://patchwork.kernel.org/project/linux-arm-msm/cover/20250210120436.821684-1-quic_mmanikan@quicinc.com/
	*) Link to v6: https://lore.kernel.org/all/DS7PR19MB88838833C0A3BFC3C7FC481F9DC02@DS7PR19MB8883.namprd19.prod.outlook.com/

[v6]
	*) Include (this) cover letter
	*) Picked up Dmitry's Reviewed-by tag on patch 5
	*) Link to v5: https://lore.kernel.org/all/DS7PR19MB88832FDED68D3EBB0EE7E99F9DC72@DS7PR19MB8883.namprd19.prod.outlook.com/

[v5]
	*) Adjusted commit messages to indicate IPQ5018 has 5 sensors of
	   which 4 are described and in use as per downstream driver and dts.
	*) Padded addresses of tsens and qfprom nodes with leading zeros.
	*) Link to v4: https://lore.kernel.org/all/DS7PR19MB8883BE38C2B500D03213747A9DC72@DS7PR19MB8883.namprd19.prod.outlook.com/

[v4]
	*) Documented ipq5018 in qcom,qfprom bindings
	*) Constrained ipq5018-tsens to one interrupt with description
	*) Added Rob's Acked-by tag
	*) Added Dmitry's Reviewed-by tag
	*) Fixed modpost warning: added __init to init_common
	*) Sorted tsens nodes by address
	*) Sorted thermal-zones nodes by name
	*) Link to v3: https://lore.kernel.org/all/20230922115116.2748804-1-srichara@win-platform-upstream01.qualcomm.com/

[v3]
	*) Added the tsens-ipq5018 as  new binding without rpm
	*) Added Dmitry's Reviewed tag
	*) Fixed Dmitry's comments for error checks in init_ipq5018
	*) Ordered the qfprom device node properties
	*) Link to v2: https://lore.kernel.org/all/20230915121504.806672-1-quic_srichara@quicinc.com/

[v2]
	*) Sorted the compatible and removed example
	*) Fixed the name for new tsens_feature
	*) Used tsend_calibrate_common instead of legacy
	   and addressed comments from Dmitry.
	*) Squashed patch 3 & 4
	*) Fixed node names, order and added qfprom cells
            for points seprately
	*) Squashed patch 6 & 7
	*) Link to v1: https://lore.kernel.org/all/1693250307-8910-1-git-send-email-quic_srichara@quicinc.com/

George Moussalem (2):
  thermal: qcom: tsens: update conditions to strictly evaluate for IP
    v2+
  thermal: qcom: tsens: add support for tsens v1 without RPM

Sricharan Ramabadhran (4):
  dt-bindings: nvmem: Add compatible for IPQ5018
  dt-bindings: thermal: qcom-tsens: Add ipq5018 compatible
  thermal: qcom: tsens: Add support for IPQ5018 tsens
  arm64: dts: qcom: ipq5018: Add tsens node

 .../bindings/nvmem/qcom,qfprom.yaml           |   1 +
 .../bindings/thermal/qcom-tsens.yaml          |   2 +
 arch/arm64/boot/dts/qcom/ipq5018.dtsi         | 169 ++++++++++++++++++
 drivers/thermal/qcom/tsens-v1.c               |  62 +++++++
 drivers/thermal/qcom/tsens.c                  |  27 ++-
 drivers/thermal/qcom/tsens.h                  |   4 +
 6 files changed, 256 insertions(+), 9 deletions(-)

--
2.48.1
---
 arch/arm64/boot/dts/qcom/ipq5018.dtsi | 169 ++++++++++++++++++++++++++++++++++
 1 file changed, 169 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
index 130360014c5e14c778e348d37e601f60325b0b14..4677e1d19cdabefab44d9eaeae431150fd74abd5 100644
--- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
@@ -182,6 +182,117 @@ pcie0_phy: phy@86000 {
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
@@ -631,6 +742,64 @@ pcie@0 {
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

---
base-commit: afc582fb6563b8eb5cd73f9eca52e55da827567f
change-id: 20250404-ipq5018-tsens-64bf95fd3317

Best regards,
-- 
George Moussalem <george.moussalem@outlook.com>



