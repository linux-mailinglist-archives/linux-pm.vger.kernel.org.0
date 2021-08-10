Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A32203E546C
	for <lists+linux-pm@lfdr.de>; Tue, 10 Aug 2021 09:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235980AbhHJHht (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Aug 2021 03:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236151AbhHJHhs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Aug 2021 03:37:48 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A095C061799
        for <linux-pm@vger.kernel.org>; Tue, 10 Aug 2021 00:37:26 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id j1so31853712pjv.3
        for <linux-pm@vger.kernel.org>; Tue, 10 Aug 2021 00:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L1wUGUmm+RM+WFeAm1m0YDv4o3hsF8ZYP495ftWlyX8=;
        b=fk5tOWy2yIUEWF2V3Hv2HPVQoMpXxyOfrZoZs5z9PCvwXNRxlF3y2dGoDt0fdKZps4
         IbMw4UJUArG/kcdJj/hQW+gC6Fjc7Uy7Q7eXxGsHSKRS58gzOIq3mtjk+r1BP8frQ+hj
         XeJESYYtha+eG0XHEMuLWJVYKlLqw2C6DH3U0NEX8+CzlLWeqGbA89xPaGxK3NP6FPal
         VRk9tRzQSZNXBmH7YfJnPt25AUAe3B9Rnk41CoEwyyYTyz1QPVbLxvft0t1W/HyfLMMO
         5SOEcRbNNj2U4+4IkR860KlCkU06v04ruyoOd6jqP7hmoIYdvDN1z6+rgLomaQPLmzGq
         SDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L1wUGUmm+RM+WFeAm1m0YDv4o3hsF8ZYP495ftWlyX8=;
        b=sEFl5ebXJPI3BJUS7GcEJC6vXvyJpicWI8oUGVos6iydX5HXdRh44lJGB9W6D6RQeY
         muJi/ly5zkKYuUR2IlBUgoAR2sWQTo0YAg4/zR7G51+EnZXMVHoBtWPvVRa7HXFjgSVk
         5sFtWSH5z+6Rj0aAax0lFbB0RLE1g1mbUCmOWF+mdtCRncphAx+yWhpPhcRft0KtA0oa
         k41QT35WVA65Lcdwk1WJRkIz29Sj/zNr85KGiTd47kdO7KDdr4usa3tU5/cvyCO7Oybg
         cGTmdXhYZ7eYyaGIsNUTG3T/B/Ibcn+6SAM//q/LdsJrNQxaGHm2q7tJJz8tSl6/ges0
         oDig==
X-Gm-Message-State: AOAM530Z37gknVFjN/enhHYGWbuUd3R84z6qudSp8eFFi9xZuGUgUtRb
        gyMdorAEwT2BWHaIp47FDpHYJg==
X-Google-Smtp-Source: ABdhPJy6odAoxRJWsRTHspaa3DWkY51nCBGS9TeOq5tf4FZvJblg2UxP5w6LQHDhzkx3BjexLyTSuQ==
X-Received: by 2002:a17:902:e746:b029:12d:1cb0:9649 with SMTP id p6-20020a170902e746b029012d1cb09649mr9705017plf.21.1628581045913;
        Tue, 10 Aug 2021 00:37:25 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id fh19sm1879612pjb.27.2021.08.10.00.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 00:37:25 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        lukasz.luba@arm.com, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] cpufreq: qcom-cpufreq-hw: Use auto-registration for energy model
Date:   Tue, 10 Aug 2021 13:06:53 +0530
Message-Id: <0b0d533988c3a4318b9fdc5e10c857348e203132.1628579170.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1628579170.git.viresh.kumar@linaro.org>
References: <cover.1628579170.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use the CPUFREQ_REGISTER_WITH_EM flag to allow cpufreq core to
automatically register with the energy model.

This allows removal of boiler plate code from the driver and fixes the
unregistration part as well.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index f86859bf76f1..221433c6dcb0 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -362,8 +362,6 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 		goto error;
 	}
 
-	dev_pm_opp_of_register_em(cpu_dev, policy->cpus);
-
 	if (policy_has_boost_freq(policy)) {
 		ret = cpufreq_enable_boost_support();
 		if (ret)
@@ -406,7 +404,8 @@ static struct freq_attr *qcom_cpufreq_hw_attr[] = {
 static struct cpufreq_driver cpufreq_qcom_hw_driver = {
 	.flags		= CPUFREQ_NEED_INITIAL_FREQ_CHECK |
 			  CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
-			  CPUFREQ_IS_COOLING_DEV,
+			  CPUFREQ_IS_COOLING_DEV |
+			  CPUFREQ_REGISTER_WITH_EM,
 	.verify		= cpufreq_generic_frequency_table_verify,
 	.target_index	= qcom_cpufreq_hw_target_index,
 	.get		= qcom_cpufreq_hw_get,
-- 
2.31.1.272.g89b43f80a514

