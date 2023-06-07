Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258B1725FD7
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jun 2023 14:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240952AbjFGMrD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Jun 2023 08:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240743AbjFGMrA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Jun 2023 08:47:00 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F310173A
        for <linux-pm@vger.kernel.org>; Wed,  7 Jun 2023 05:46:58 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f6454a21a9so524512e87.3
        for <linux-pm@vger.kernel.org>; Wed, 07 Jun 2023 05:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686142017; x=1688734017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ng6Pec8L+42si+rxccvj/qMWQEZv9/gf2sYIBEMRJp8=;
        b=KsUby3jo/lAKaMu0brunLhbLd8LBDe4b38OfBgFsNpozyVVbugfuGYblbeJnhwj8J5
         wQPvwhO12mE2P9oURjZKZBmK8wy9ZrlPcBnxlPybOh5uGLEhL1iGLzAlf0CywkDIcxMc
         g7yIF7nGsrF5O1gtQxzUMT/RKHGWfxSFFMuHWcLlkzhVlxp6PNrja5TiRT8Q4AGhl2pb
         pqs7rYUXEvkYqew/9/vljDQDqc+dPJxmxCxcOux2i0gda+SrlLz1Yl/ekA8w0YivFSAa
         frBinLCoQqxdnlEKe8pacMYFvJGKwHSN+fcDiuN1XlOlO5UqPqEkefMGaRg1/U08600E
         zBXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686142017; x=1688734017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ng6Pec8L+42si+rxccvj/qMWQEZv9/gf2sYIBEMRJp8=;
        b=WFAmrZ92wzP7Puo9D+zyt0cigbXiih2bnx0tLehpCdiNsoZD6uJAUYVk5CUg9dOB48
         1ujZjmq+z3mQv7Qh7u/XRwX1LJuKxE0MSmkfRlJW3HSEvg0WTMNUU4gDdFeQvxDxWVAE
         +gytUy8R4c7HnFj2v/jVOpDa7SLu4IXXx1DXh1OJopqsve/lLdcc75LGUDoD/qzqQ9o3
         sNhe4Fp8sUkFZP0oy8fuDe3boJWPCBzIKaJfDjqoY4mu1JqGrx9I5N1WorIsrqoCRxeO
         bRbXA1wXjRd8BgIxcCTOfUVsEyEweg8u/jf9k85KwW4GpPAbzLqiFYYnE7ffuGPtYjF6
         FztQ==
X-Gm-Message-State: AC+VfDxOzMPxEm/D1pdYm1uKNB9wTV1YyPQdz88RYuxBx/pAO9zvtNmC
        VAfIcvXn/T4ghZYeOM4gFtv3mQ==
X-Google-Smtp-Source: ACHHUZ5i6NoVxi/AqdIAXLDNJOeVXoGNxCPGbbzioHRt3xBQPRCtjgN7RkXDUIzR1O4KErWC/PtpFQ==
X-Received: by 2002:ac2:514a:0:b0:4f2:5393:b7c with SMTP id q10-20020ac2514a000000b004f253930b7cmr1754364lfd.67.1686142016903;
        Wed, 07 Jun 2023 05:46:56 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id z7-20020a19f707000000b004f4b3e9e0cesm1781708lfe.297.2023.06.07.05.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 05:46:56 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/16] firmware: arm_scmi: Extend perf protocol ops to get the name of a domain
Date:   Wed,  7 Jun 2023 14:46:14 +0200
Message-Id: <20230607124628.157465-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607124628.157465-1-ulf.hansson@linaro.org>
References: <20230607124628.157465-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Similar to other protocol ops, it's useful for an scmi module driver to get
the name of a performance domain, hence let's make this available by adding
a new perf protocol callback. Note that, a user is being added from
subsequent changes.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/firmware/arm_scmi/perf.c | 10 ++++++++++
 include/linux/scmi_protocol.h    |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index cf7f0de4d6db..5a6ed42bfb55 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -340,6 +340,15 @@ static int scmi_perf_num_domains_get(const struct scmi_protocol_handle *ph)
 	return pi->num_domains;
 }
 
+static const char *
+scmi_perf_name_get(const struct scmi_protocol_handle *ph, u32 domain)
+{
+	struct scmi_perf_info *pi = ph->get_priv(ph);
+	struct perf_dom_info *dom = pi->dom_info + domain;
+
+	return dom->name;
+}
+
 static int scmi_perf_mb_limits_set(const struct scmi_protocol_handle *ph,
 				   u32 domain, u32 max_perf, u32 min_perf)
 {
@@ -695,6 +704,7 @@ scmi_power_scale_get(const struct scmi_protocol_handle *ph)
 
 static const struct scmi_perf_proto_ops perf_proto_ops = {
 	.num_domains_get = scmi_perf_num_domains_get,
+	.name_get = scmi_perf_name_get,
 	.limits_set = scmi_perf_limits_set,
 	.limits_get = scmi_perf_limits_get,
 	.level_set = scmi_perf_level_set,
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 4e42274a68b7..07152a0baee3 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -102,6 +102,7 @@ struct scmi_clk_proto_ops {
  *	by SCMI Performance Protocol
  *
  * @num_domains_get: gets the number of supported performance domains
+ * @name_get: gets the name of a performance domain
  * @limits_set: sets limits on the performance level of a domain
  * @limits_get: gets limits on the performance level of a domain
  * @level_set: sets the performance level of a domain
@@ -122,6 +123,8 @@ struct scmi_clk_proto_ops {
  */
 struct scmi_perf_proto_ops {
 	int (*num_domains_get)(const struct scmi_protocol_handle *ph);
+	const char *(*name_get)(const struct scmi_protocol_handle *ph,
+				u32 domain);
 	int (*limits_set)(const struct scmi_protocol_handle *ph, u32 domain,
 			  u32 max_perf, u32 min_perf);
 	int (*limits_get)(const struct scmi_protocol_handle *ph, u32 domain,
-- 
2.34.1

