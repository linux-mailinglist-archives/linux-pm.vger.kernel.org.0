Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D28E103B80
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2019 14:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730651AbfKTNd1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Nov 2019 08:33:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:40844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730650AbfKTNd1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 20 Nov 2019 08:33:27 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB73C22521;
        Wed, 20 Nov 2019 13:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574256806;
        bh=crDJnPjOlOMnMpToasc/QNgCCxnojz7Gt+oJifbABfA=;
        h=From:To:Cc:Subject:Date:From;
        b=IFtJmZwVGAu+M1OiaNeJ8nii6218nM+iENEqrLh3wAGGxJJgDi4onqPhYQP15NAQJ
         RdSR3FehinLGwknGIHrJ7zgUL20ZJB8KqINs4tX7tlmfkFq/qOs2CyylENRqIInqDS
         ylBgk5+xHCkbooit8zRWuURusc9DeFUUI4wBNo+g=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH] interconnect: qcom: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:33:07 +0800
Message-Id: <20191120133307.6421-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/interconnect/qcom/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
index c49afbea3458..b6735f11438c 100644
--- a/drivers/interconnect/qcom/Kconfig
+++ b/drivers/interconnect/qcom/Kconfig
@@ -11,8 +11,8 @@ config INTERCONNECT_QCOM_MSM8974
        depends on QCOM_SMD_RPM
        select INTERCONNECT_QCOM_SMD_RPM
        help
-         This is a driver for the Qualcomm Network-on-Chip on msm8974-based
-         platforms.
+	 This is a driver for the Qualcomm Network-on-Chip on msm8974-based
+	 platforms.
 
 config INTERCONNECT_QCOM_QCS404
 	tristate "Qualcomm QCS404 interconnect driver"
-- 
2.17.1

