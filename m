Return-Path: <linux-pm+bounces-35441-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FC0BA28BC
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 08:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE81D1C23C73
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 06:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6197A27C150;
	Fri, 26 Sep 2025 06:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gl6MaZv4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D56424DFF4;
	Fri, 26 Sep 2025 06:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758868939; cv=none; b=SBxHz0jTCL2nR+y76B021lzO2K4vwjLEhRj6+nqfvPRyf+tjMbOvWMO5mwDsJDbMu81mpUDT5b34ohKa6nG1ytIbvzPDhYMWl9zQEuyuxSGCY8B4RFh2qis6uU4I5jnr4WaLmSlTxytKST9ewiXoW/NnMtwFXEH5LvjZPuy52R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758868939; c=relaxed/simple;
	bh=SgZxbyWjLLNAfsdL8p6PT1jsimc6gg1IOc/TL/1Qzag=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rD4IcBKWongO7S5hNd9bO1KDoUO7kH9pDA7uf6ZXfwmy3ukvKAd60HWDmuhYRA34sstzcerYQR9nBW3L+lt6osSfXhSKDqMECf5tdREkNVhNy0PFYzEP2dK20YJizOz+oMdvf88yFSm7puzcR9hAal42mstGHU+CEP6jyRbdusQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gl6MaZv4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B473FC113CF;
	Fri, 26 Sep 2025 06:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758868938;
	bh=SgZxbyWjLLNAfsdL8p6PT1jsimc6gg1IOc/TL/1Qzag=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gl6MaZv44HK8AJnbO/eZIurVSJToxXJGaSXnR5NVCpN/GlRzO4QECsOEktPqW3/qh
	 yt38fOrJRoYmakB6p3v5Ku4WjL5HzIwVw4Gg+zi4dZ6FjzQoZjqxR2c/ejoHEDRtBu
	 aIdj7HH9DVjOLaIeLZO4nGgZFTTi9HzEwzOeaa879OWFziq5d04t2PFD+l4kUUqVGm
	 1tZuknjwCEXVsX/UxYkoTS/67UcnjHmopG+ydqP8sge4pt7yEqjV2NjGI9N7aNQ18p
	 3BS40I22akvJggFdzshoxEWwKIy4EfBTYzZhkzbp9JsATjVW7GtQrxsR4GMVArPAiJ
	 WJlgcWfN1Pglg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E618CAC5AC;
	Fri, 26 Sep 2025 06:42:18 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Fri, 26 Sep 2025 12:12:09 +0530
Subject: [PATCH v2 1/2] interconnect: qcom: sdx75: Drop QPIC interconnect
 and BCM nodes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-sdx75-icc-v2-1-20d6820e455c@oss.qualcomm.com>
References: <20250926-sdx75-icc-v2-0-20d6820e455c@oss.qualcomm.com>
In-Reply-To: <20250926-sdx75-icc-v2-0-20d6820e455c@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, 
 Rohit Agarwal <quic_rohiagar@quicinc.com>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 devicetree@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>, 
 Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>, 
 Lakshmi Sowjanya D <quic_laksd@quicinc.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3921;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=ce9KrwjYprM+n3TPtekMvu+4lvBF/x4wucCd3clZOxQ=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBo1jXI2cks4rWMXbxWFQdClTK5ARjHTM8HMBTgK
 Op4WYAzVIeJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaNY1yAAKCRBVnxHm/pHO
 9TAGCACR61rPFciCybbh7xmNgzO05w+K312L5XRkHxS1qulGqH8jUQex/BtQjGQIgtWoZFJxoQ8
 Mq6xLKEK8sqcmGPKl/YRdoTZQkKNsWlB2pSAmViOKgugzGnbN86UBVKgJyRo8BpOn+NuhBGaCQc
 nFbhSVpAaciRwpJItgWlFyLFk/UJWTYPse7LNbYp8PbHWsoa/FdDsc/tbswdP9qMVY0NFFZXWlv
 N5qtX1doNpkBEDiJrP4CrKSK6i/y0V2Qt3OIT0oi+gURWoI/DgrVmTZG6izzPKP8DILUIrA4Zay
 4Iia+UWwF/VR1Uzr7eefbjbkP+d+634UDZt7Ev59q1mq2fR+
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>

As like other SDX SoCs, SDX75 SoC's QPIC BCM resource was modeled as a
RPMh clock in clk-rpmh driver. However, for SDX75, this resource was also
described as an interconnect and BCM node mistakenly. It is incorrect to
describe the same resource in two different providers, as it will lead to
votes from clients overriding each other.

Hence, drop the QPIC interconnect and BCM nodes and let the clients use
clk-rpmh driver to vote for this resource.

Without this change, the NAND driver fails to probe on SDX75, as the
interconnect sync state disables the QPIC nodes as there were no clients
voting for this ICC resource. However, the NAND driver had already voted
for this BCM resource through the clk-rpmh driver. Since both votes come
from Linux, RPMh was unable to distinguish between these two and ends up
disabling the QPIC resource during sync state.

Cc: stable@vger.kernel.org
Fixes: 3642b4e5cbfe ("interconnect: qcom: Add SDX75 interconnect provider driver")
Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
[mani: dropped the reference to bcm_qp0, reworded description]
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/interconnect/qcom/sdx75.c | 26 --------------------------
 drivers/interconnect/qcom/sdx75.h |  2 --
 2 files changed, 28 deletions(-)

diff --git a/drivers/interconnect/qcom/sdx75.c b/drivers/interconnect/qcom/sdx75.c
index 7ef1f17f3292e15959cb06e3d8d8c5f3c6ecd060..2def75f67eb8e0adf0a14a1bd13f24c401cc722a 100644
--- a/drivers/interconnect/qcom/sdx75.c
+++ b/drivers/interconnect/qcom/sdx75.c
@@ -16,15 +16,6 @@
 #include "icc-rpmh.h"
 #include "sdx75.h"
 
-static struct qcom_icc_node qpic_core_master = {
-	.name = "qpic_core_master",
-	.id = SDX75_MASTER_QPIC_CORE,
-	.channels = 1,
-	.buswidth = 4,
-	.num_links = 1,
-	.links = { SDX75_SLAVE_QPIC_CORE },
-};
-
 static struct qcom_icc_node qup0_core_master = {
 	.name = "qup0_core_master",
 	.id = SDX75_MASTER_QUP_CORE_0,
@@ -375,14 +366,6 @@ static struct qcom_icc_node xm_usb3 = {
 	.links = { SDX75_SLAVE_A1NOC_CFG },
 };
 
-static struct qcom_icc_node qpic_core_slave = {
-	.name = "qpic_core_slave",
-	.id = SDX75_SLAVE_QPIC_CORE,
-	.channels = 1,
-	.buswidth = 4,
-	.num_links = 0,
-};
-
 static struct qcom_icc_node qup0_core_slave = {
 	.name = "qup0_core_slave",
 	.id = SDX75_SLAVE_QUP_CORE_0,
@@ -831,12 +814,6 @@ static struct qcom_icc_bcm bcm_mc0 = {
 	.nodes = { &ebi },
 };
 
-static struct qcom_icc_bcm bcm_qp0 = {
-	.name = "QP0",
-	.num_nodes = 1,
-	.nodes = { &qpic_core_slave },
-};
-
 static struct qcom_icc_bcm bcm_qup0 = {
 	.name = "QUP0",
 	.keepalive = true,
@@ -898,14 +875,11 @@ static struct qcom_icc_bcm bcm_sn4 = {
 };
 
 static struct qcom_icc_bcm * const clk_virt_bcms[] = {
-	&bcm_qp0,
 	&bcm_qup0,
 };
 
 static struct qcom_icc_node * const clk_virt_nodes[] = {
-	[MASTER_QPIC_CORE] = &qpic_core_master,
 	[MASTER_QUP_CORE_0] = &qup0_core_master,
-	[SLAVE_QPIC_CORE] = &qpic_core_slave,
 	[SLAVE_QUP_CORE_0] = &qup0_core_slave,
 };
 
diff --git a/drivers/interconnect/qcom/sdx75.h b/drivers/interconnect/qcom/sdx75.h
index 24e88715992010d934a1a630979f864af3a8426c..34f51add59dc008c7378dec3c1409f0f55b93056 100644
--- a/drivers/interconnect/qcom/sdx75.h
+++ b/drivers/interconnect/qcom/sdx75.h
@@ -33,7 +33,6 @@
 #define SDX75_MASTER_QDSS_ETR			24
 #define SDX75_MASTER_QDSS_ETR_1			25
 #define SDX75_MASTER_QPIC			26
-#define SDX75_MASTER_QPIC_CORE			27
 #define SDX75_MASTER_QUP_0			28
 #define SDX75_MASTER_QUP_CORE_0			29
 #define SDX75_MASTER_SDCC_1			30
@@ -76,7 +75,6 @@
 #define SDX75_SLAVE_QDSS_CFG			67
 #define SDX75_SLAVE_QDSS_STM			68
 #define SDX75_SLAVE_QPIC			69
-#define SDX75_SLAVE_QPIC_CORE			70
 #define SDX75_SLAVE_QUP_0			71
 #define SDX75_SLAVE_QUP_CORE_0			72
 #define SDX75_SLAVE_SDCC_1			73

-- 
2.48.1



