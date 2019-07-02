Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB3865C864
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2019 06:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbfGBEgw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Jul 2019 00:36:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52190 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbfGBEgw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Jul 2019 00:36:52 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6AE64607CA; Tue,  2 Jul 2019 04:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1562042211;
        bh=mgMehHvBkR+GBicy9Yj53pOCNoXk3pHBimhXl6uHn/A=;
        h=From:To:Cc:Subject:Date:From;
        b=lQnrgPrzoP6tXmO5ymf566ofe+JYIhP7Ukizfg70CdRNzrx5D7BN31R81R8dHnlHP
         ZDORrOnyo3G43pfN+9bRAMhltfeJThv1A4vKgcKz/eycel6CPncf8mfnZI/EYQKkEe
         njQugLVEGwVo6prDaTUGW6UF+jPFkZYBlmXsXWuI=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 14DF1601B4;
        Tue,  2 Jul 2019 04:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1562042210;
        bh=mgMehHvBkR+GBicy9Yj53pOCNoXk3pHBimhXl6uHn/A=;
        h=From:To:Cc:Subject:Date:From;
        b=CkiwfEX3pcuHxLNmwyGKq8LBRXwjpaBuphjz11/WOeKqNXuIiaeTCcu4d1khnnP+0
         ccCC5bzpxoZ/zzuSezeXNJrAW6Qkr1uaKxFTq9SoUR8zXZqSIzR2ZodNLmm0Q4lpp+
         BTR7eJ1IIdr7Ulmy/VBEL6qTr8TIP9BeYYjadYxI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 14DF1601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     vireshk@kernel.org, sboyd@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH 1/2] opp: Export dev_pm_opp_set_genpd_virt_dev()
Date:   Tue,  2 Jul 2019 10:06:42 +0530
Message-Id: <20190702043643.1746-1-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Export dev_pm_opp_set_genpd_virt_dev() so loadable modules can use it.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/opp/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 8fbdbedc009c..ae033bb1e5b7 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1797,6 +1797,7 @@ struct opp_table *dev_pm_opp_set_genpd_virt_dev(struct device *dev,
 
 	return opp_table;
 }
+EXPORT_SYMBOL_GPL(dev_pm_opp_set_genpd_virt_dev);
 
 /**
  * dev_pm_opp_put_genpd_virt_dev() - Releases resources blocked for genpd device.
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

