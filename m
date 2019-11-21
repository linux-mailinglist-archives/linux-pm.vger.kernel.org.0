Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8C6E104939
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2019 04:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbfKUDVK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Nov 2019 22:21:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:35208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbfKUDVJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 20 Nov 2019 22:21:09 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A76FE208CE;
        Thu, 21 Nov 2019 03:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574306469;
        bh=Ez6X3EKrkxhppyCurfnzf160xqaEmJGUUDMp8vXIXhM=;
        h=From:To:Cc:Subject:Date:From;
        b=VSM9cNglHXCjUUaiqDjqpR/fymL0/I82COgAM48NBfhZasH1dtOnuncvPzVEjP4pT
         /YRk2IO0fs1Rk/ZzgX/Vu6L3nwO0cJ4TLYl3tuOQ6ZNixaJJkCxvRzOc0BluEuQN6y
         prEDEdTIUjEYj1R42AEpy43SAS1O1UQ+YIhw7Juo=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v2] interconnect: qcom: Fix Kconfig indentation
Date:   Thu, 21 Nov 2019 04:21:05 +0100
Message-Id: <1574306465-8959-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Fix also 7-space and tab+1 space indentation issues.
---
 drivers/interconnect/qcom/Kconfig | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
index c49afbea3458..2f9304d1db49 100644
--- a/drivers/interconnect/qcom/Kconfig
+++ b/drivers/interconnect/qcom/Kconfig
@@ -6,13 +6,13 @@ config INTERCONNECT_QCOM
 	  Support for Qualcomm's Network-on-Chip interconnect hardware.
 
 config INTERCONNECT_QCOM_MSM8974
-       tristate "Qualcomm MSM8974 interconnect driver"
-       depends on INTERCONNECT_QCOM
-       depends on QCOM_SMD_RPM
-       select INTERCONNECT_QCOM_SMD_RPM
-       help
-         This is a driver for the Qualcomm Network-on-Chip on msm8974-based
-         platforms.
+	tristate "Qualcomm MSM8974 interconnect driver"
+	depends on INTERCONNECT_QCOM
+	depends on QCOM_SMD_RPM
+	select INTERCONNECT_QCOM_SMD_RPM
+	help
+	 This is a driver for the Qualcomm Network-on-Chip on msm8974-based
+	 platforms.
 
 config INTERCONNECT_QCOM_QCS404
 	tristate "Qualcomm QCS404 interconnect driver"
-- 
2.7.4

