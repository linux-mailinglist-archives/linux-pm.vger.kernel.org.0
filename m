Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63AA72FF553
	for <lists+linux-pm@lfdr.de>; Thu, 21 Jan 2021 21:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbhAUUDp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Jan 2021 15:03:45 -0500
Received: from relay06.th.seeweb.it ([5.144.164.167]:40215 "EHLO
        relay06.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbhAUTyK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jan 2021 14:54:10 -0500
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id B5B303EEBD;
        Thu, 21 Jan 2021 20:52:52 +0100 (CET)
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
To:     viresh.kumar@linaro.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org, rjw@rjwysocki.net,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        amit.kucheria@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, jeffrey.l.hugo@gmail.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Subject: [PATCH v5 1/7] cpufreq: blacklist SDM630/636/660 in cpufreq-dt-platdev
Date:   Thu, 21 Jan 2021 20:52:44 +0100
Message-Id: <20210121195250.492500-2-angelogioacchino.delregno@somainline.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210121195250.492500-1-angelogioacchino.delregno@somainline.org>
References: <20210121195250.492500-1-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the SDM630, SDM636 and SDM660 to the blacklist since the CPU
scaling is handled out of this.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index bd2db0188cbb..f82f4ec17ff2 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -135,6 +135,9 @@ static const struct of_device_id blacklist[] __initconst = {
 	{ .compatible = "qcom,msm8996", },
 	{ .compatible = "qcom,qcs404", },
 	{ .compatible = "qcom,sc7180", },
+	{ .compatible = "qcom,sdm630", },
+	{ .compatible = "qcom,sdm636", },
+	{ .compatible = "qcom,sdm660", },
 	{ .compatible = "qcom,sdm845", },
 
 	{ .compatible = "st,stih407", },
-- 
2.30.0

