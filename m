Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4F285A57
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2019 08:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731076AbfHHGN0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Aug 2019 02:13:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46162 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730694AbfHHGN0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Aug 2019 02:13:26 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0F8166050D; Thu,  8 Aug 2019 06:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565244804;
        bh=JhHYfYaCvSYgvfGbhWmRAsUEmiyOd+CAHB6FO6d7I58=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A6RgqiNagleLp6PaLgGsFEJzHmpHqH5kEQd2XAxSN7ZIObnW/ra43abfdUaZSw29f
         ZSlNKpXhQ9jsU1GmQBCeH366APPix6LPQEGtE5jFQSKG6ShMOdjuMCsQyJqlIdcst/
         SkIybOgbVzxu3HEArQh1JpZkJTI08X850cv6pnN0=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from mkshah-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0B33E6083E;
        Thu,  8 Aug 2019 06:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565244803;
        bh=JhHYfYaCvSYgvfGbhWmRAsUEmiyOd+CAHB6FO6d7I58=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lzeav3yWFeFeQoPmkybBHxlKlXu5wvQoAu7nSEkUomDz30C2PzsamTaDPnntp1btb
         ZDXaxZsV8JdeGtBMCXIrA/No9rrWG5Q9/HNaNq/bdeo6JTvJlw/oPRRZODDsSoTkhS
         hgRQ35vTTQtwaA1Ay189c/0qsueo9yxaAVN77rks=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0B33E6083E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
From:   Maulik Shah <mkshah@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        bjorn.andersson@linaro.org, evgreen@chromium.org,
        dianders@chromium.org, swboyd@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org, mkshah@codeaurora.org,
        devicetree@vger.kernel.org,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>
Subject: [PATCH 1/2] dt-bindings: Introduce soc sleep stats bindings for Qualcomm SoCs
Date:   Thu,  8 Aug 2019 11:42:27 +0530
Message-Id: <20190808061228.16573-2-mkshah@codeaurora.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808061228.16573-1-mkshah@codeaurora.org>
References: <20190808061228.16573-1-mkshah@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add device binding documentation for Qualcomm Technology Inc's (QTI)
SoC sleep stats driver. The driver is used for displaying SoC sleep
statistic maintained by Always On Processor or Resource Power Manager.

Cc: devicetree@vger.kernel.org
Signed-off-by: Mahesh Sivasubramanian <msivasub@codeaurora.org>
Signed-off-by: Lina Iyer <ilina@codeaurora.org>
Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
---
 .../bindings/soc/qcom/soc-sleep-stats.txt     | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/soc-sleep-stats.txt

diff --git a/Documentation/devicetree/bindings/soc/qcom/soc-sleep-stats.txt b/Documentation/devicetree/bindings/soc/qcom/soc-sleep-stats.txt
new file mode 100644
index 000000000000..ee40687ded34
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/soc-sleep-stats.txt
@@ -0,0 +1,36 @@
+* SoC Sleep Stats
+
+Always On Processor/Resource Power Manager maintains statistics of the SoC
+sleep modes involving lowering or powering down of the backbone rails - Cx
+and Mx and the oscillator clock, XO.
+
+Statistics includes SoC sleep mode type, number of times low power mode were
+entered, time of last entry, time of last exit and accumulated sleep duration.
+SoC Sleep Stats driver provides sysfs interface to display this information.
+
+PROPERTIES
+
+- compatible:
+	Usage: required
+	Value type: <string>
+	Definition: Should be "qcom,rpmh-sleep-stats" or "qcom,rpm-sleep-stats".
+
+- reg:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: The base address on the Always On Processor or Resource Power
+		    Manager from where the stats are read.
+
+EXAMPLE 1:
+
+	rpmh_sleep_stats: soc-sleep-stats@c3f0000 {
+		compatible = "qcom,rpmh-sleep-stats";
+		reg = <0 0xc3f0000 0 0x400>;
+	};
+
+EXAMPLE 2:
+
+	rpm_sleep_stats: soc-sleep-stats@4690000 {
+		compatible = "qcom,rpm-sleep-stats";
+		reg = <0 0x04690000 0 0x400>;
+	};
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by The Linux Foundation.

