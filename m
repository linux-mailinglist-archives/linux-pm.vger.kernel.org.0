Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9DB97885A3
	for <lists+linux-pm@lfdr.de>; Fri, 25 Aug 2023 13:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233800AbjHYL10 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Aug 2023 07:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242347AbjHYL06 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Aug 2023 07:26:58 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0AC2106
        for <linux-pm@vger.kernel.org>; Fri, 25 Aug 2023 04:26:55 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4ffa6e25ebbso2242586e87.0
        for <linux-pm@vger.kernel.org>; Fri, 25 Aug 2023 04:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692962814; x=1693567614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zVpWJeH5vl6Yje0ZJiFEtM9UBDqQaysUVErrHYVLQ+o=;
        b=rugSWusf70vosp9DOB8WylmApboafo7DvVCjni1PwGdMfqtoGVJ5rHmCUpgyrCIyZC
         aboXUzFvpGVuij+vk0r2vK1GyEfc4g8Bk8JPiJdPyM5s9w43ZGakqw+ih9Uiqe+IWGQZ
         AnQcD6HFYDeQpmvRCbwFiScvF1rJkzGCwox6cuJFfZXb3gFRjGF+QVDGToG35UoCOh2k
         DMRtCuHZMfYKSex5kUt+sTNhae5P13JQcoXXL0grN9hyy0DF96P3EbDe5VWHHD/iJBWP
         7xaF7w0BizSz72oSL5EdR/clG9sOQ4NK11xiNkl+mFT/tiXCt7njez9g87w8+WYlOyhV
         j60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692962814; x=1693567614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zVpWJeH5vl6Yje0ZJiFEtM9UBDqQaysUVErrHYVLQ+o=;
        b=SguXXPvahikV+azgWOfQ5/L88E+rtKW+KqQd1FaDOqkxiNXF3K9/g8VR9pP5bG9mqS
         LRUHffitiPmgLJB1IjT6QCTyq88jhmPzhF5CnxfdpQUYfVe4hI12I8ZL32RbSzKSSjY/
         Sc26lmRL00JtKaOXb0Y0ozrGwqv2BecSaqujQvWNkxTqt9jGro27hlJnyCEljLmtOz1X
         MNsrW7YMhAoD0IZAVW3d97uf0AecTozJ/iM/J79JN3lrbhmplYxO5LeXZ2mbS+QJbXIw
         09UvD6qD/67OhbzsOKl+HqPUB5PLz6NWUrVw7Hru9Y7iSvZdMjvJ8wTdz3kc7f5pum2l
         9qrA==
X-Gm-Message-State: AOJu0Yyd5q7rYSeoyY7s1WfDHeNDAVCeddZ5fUUND5f9CNodmfogl+Mj
        EqYMwIbDYKl5+tkP+LHRJRIOdw==
X-Google-Smtp-Source: AGHT+IFXJid6x5tv979FOkJ2rrKhKWbwIqh79ZM+8kyobJcO4BCSim8pQoc9bWw5tPMhOJ5fp7hmDg==
X-Received: by 2002:a19:6451:0:b0:4f8:6253:540 with SMTP id b17-20020a196451000000b004f862530540mr6084197lfj.19.1692962813678;
        Fri, 25 Aug 2023 04:26:53 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id g7-20020ac25387000000b004fb7ac67bbdsm259164lfh.41.2023.08.25.04.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 04:26:53 -0700 (PDT)
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
Subject: [PATCH v3 01/13] firmware: arm_scmi: Extend perf protocol ops to get number of domains
Date:   Fri, 25 Aug 2023 13:26:21 +0200
Message-Id: <20230825112633.236607-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230825112633.236607-1-ulf.hansson@linaro.org>
References: <20230825112633.236607-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Similar to other protocol ops, it's useful for an scmi module driver to get
the number of supported performance domains, hence let's make this
available by adding a new perf protocol callback. Note that, a user is
being added from subsequent changes.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v3:
	- Re-based.

---
 drivers/firmware/arm_scmi/perf.c | 8 ++++++++
 include/linux/scmi_protocol.h    | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index c0cd556fbaae..9fb63dd44c20 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -423,6 +423,13 @@ scmi_perf_describe_levels_get(const struct scmi_protocol_handle *ph,
 	return ret;
 }
 
+static int scmi_perf_num_domains_get(const struct scmi_protocol_handle *ph)
+{
+	struct scmi_perf_info *pi = ph->get_priv(ph);
+
+	return pi->num_domains;
+}
+
 static int scmi_perf_msg_limits_set(const struct scmi_protocol_handle *ph,
 				    u32 domain, u32 max_perf, u32 min_perf)
 {
@@ -948,6 +955,7 @@ scmi_power_scale_get(const struct scmi_protocol_handle *ph)
 }
 
 static const struct scmi_perf_proto_ops perf_proto_ops = {
+	.num_domains_get = scmi_perf_num_domains_get,
 	.limits_set = scmi_perf_limits_set,
 	.limits_get = scmi_perf_limits_get,
 	.level_set = scmi_perf_level_set,
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index e6fe4f73ffe6..71b39cbbdace 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -101,6 +101,7 @@ struct scmi_clk_proto_ops {
  * struct scmi_perf_proto_ops - represents the various operations provided
  *	by SCMI Performance Protocol
  *
+ * @num_domains_get: gets the number of supported performance domains
  * @limits_set: sets limits on the performance level of a domain
  * @limits_get: gets limits on the performance level of a domain
  * @level_set: sets the performance level of a domain
@@ -120,6 +121,7 @@ struct scmi_clk_proto_ops {
  *	or in some other (abstract) scale
  */
 struct scmi_perf_proto_ops {
+	int (*num_domains_get)(const struct scmi_protocol_handle *ph);
 	int (*limits_set)(const struct scmi_protocol_handle *ph, u32 domain,
 			  u32 max_perf, u32 min_perf);
 	int (*limits_get)(const struct scmi_protocol_handle *ph, u32 domain,
-- 
2.34.1

