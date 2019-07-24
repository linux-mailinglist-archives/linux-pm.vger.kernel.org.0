Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2567371D
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2019 21:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfGXTAA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jul 2019 15:00:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:43992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbfGXTAA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 24 Jul 2019 15:00:00 -0400
Received: from localhost.localdomain (unknown [194.230.155.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67A4B206A2;
        Wed, 24 Jul 2019 18:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563994799;
        bh=l6A5jGNR1HnhxnJetFoPTiR82L5guam3FXGVgAkh2N4=;
        h=From:To:Cc:Subject:Date:From;
        b=v9yTgQ8GlV/ZOj6/skGSMDudMVN3qRAoB8hzOutwxq5d+v1b0d1RbmYQPv8NSTFed
         n72CeaESkWILt9EdcVWSIgHkCWbxxH2g4B4PUsJbNyYQJg5ikPal7ID67ExWzbGeC4
         JQtTLCLa6a2jLU44bclSdVs+E3sU9ZPQ1NWnua78=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] devfreq: Correct devm_devfreq_remove_device() documentation
Date:   Wed, 24 Jul 2019 20:59:53 +0200
Message-Id: <20190724185953.17545-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Correct the documentation for devm_devfreq_remove_device() argument.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/devfreq/devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 784c08e4f931..446490c9d635 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -867,7 +867,7 @@ EXPORT_SYMBOL_GPL(devfreq_get_devfreq_by_phandle);
 
 /**
  * devm_devfreq_remove_device() - Resource-managed devfreq_remove_device()
- * @dev:	the device to add devfreq feature.
+ * @dev:	the device from which to remove devfreq feature.
  * @devfreq:	the devfreq instance to be removed
  */
 void devm_devfreq_remove_device(struct device *dev, struct devfreq *devfreq)
-- 
2.17.1

