Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC7256364A
	for <lists+linux-pm@lfdr.de>; Fri,  1 Jul 2022 16:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbiGAO6j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Jul 2022 10:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbiGAO6i (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Jul 2022 10:58:38 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863BC20F56
        for <linux-pm@vger.kernel.org>; Fri,  1 Jul 2022 07:58:37 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id n16-20020a17090ade9000b001ed15b37424so2929271pjv.3
        for <linux-pm@vger.kernel.org>; Fri, 01 Jul 2022 07:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y95vOAUApepxdfAS6VCO8MeeZD3qR/4xU+0HXt3Q4Pc=;
        b=PPFEpDRgJRyElvbUXlO/CnhqMUwwV6Pghk11+qPIMMwowcfexUKv1oBSm+0QMl0b+z
         1mBEJl2l9TgFiWvEbf/4+Yml6MWZPUmdTS60wjdzprIlHD7sQBY1YrNgYWB2QGALg/A/
         p5OljYAFccl9U8043eE/E1ZZpiB4IAL24N11Dhhmp0JaSAZXAOHVHB4wLVFzOj2v+JG9
         X4EZJ7P/+PWxsKEcZzf4pnS3DIfR4keP0jq5L9gPs2L9kbn5KzJkfsVXpO0/i9CGtjVX
         9L7k5lcgmICyR8vbzJOIqPnmJyrekapLcjPTlSUI72UJ2CgKrW/+hBm8oMAOCPwDDmVH
         LgEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y95vOAUApepxdfAS6VCO8MeeZD3qR/4xU+0HXt3Q4Pc=;
        b=Lck6hKFvbWeS0qCuG6gVOpOr7/cGJoLtmvYxR7Kd1NvXJAHyuIQpalZWLPODWqHxBo
         45XcOuQR2W2aLPYZNCxt6yLuwB52eWFvgss3QKjxkYLMztBjDJE+9w0rJGh+4pk0gOcK
         fD3wEOeuFnXhqk7kQ6ANPI8Y50QMiqh7edccwt7xjxYHorM9Uryeq0bs2jLYAEz1//yj
         ptyLmPdKkwOS0cdNjC2Ij029Oji+VPGZRHbRLmv+UKM3+Fz8gqw4IC+aGfWahemZ5siY
         5Cv1Ezz4O6A6nTGeqjNJSQVqmutbdA8XxYQNdnYs+sVhkOf3hc8F/C+utIIqjdrPFnFx
         9N1g==
X-Gm-Message-State: AJIora/kwa74ENQtP/qZjghVa1dtlWfgip2UCERoTKuEZ9JxWYe4EVSN
        g3GX1ugfULy0OplpEvpjrkxEEK8gYsSNrg==
X-Google-Smtp-Source: AGRyM1vzmrIzZf2BDabs1hjTuSEkiX8S8C1+x6OgqG+TemmvKKhNYWXUJxztzdTtoCkW8xbq3wQfsg==
X-Received: by 2002:a17:90a:f8c2:b0:1ec:d690:a269 with SMTP id l2-20020a17090af8c200b001ecd690a269mr17108875pjd.190.1656687516832;
        Fri, 01 Jul 2022 07:58:36 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c5e:e6c0:8e75:c988:f80f:8bec])
        by smtp.gmail.com with ESMTPSA id y19-20020a170902e19300b0016b844cd7e9sm9641399pla.115.2022.07.01.07.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 07:58:36 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 1/3] firmware: qcom_scm: Add support for tsens reinit workaround
Date:   Fri,  1 Jul 2022 20:28:13 +0530
Message-Id: <20220701145815.2037993-2-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220701145815.2037993-1-bhupesh.sharma@linaro.org>
References: <20220701145815.2037993-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Some versions of QCoM tsens controller might enter a
'bad state' while running stability tests causing sensor
temperatures/interrupts status to be in an 'invalid' state.

It is recommended to re-initialize the tsens controller
via trustzone (secure registers) using scm call(s) when that
happens.

Add support for the same in the qcom_scm driver.

Cc: Amit Kucheria <amitk@kernel.org>
Cc: Thara Gopinath <thara.gopinath@gmail.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 drivers/firmware/qcom_scm.c | 17 +++++++++++++++++
 drivers/firmware/qcom_scm.h |  4 ++++
 include/linux/qcom_scm.h    |  2 ++
 3 files changed, 23 insertions(+)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index 3163660fa8e2..0bc7cc466218 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -796,6 +796,23 @@ int qcom_scm_mem_protect_video_var(u32 cp_start, u32 cp_size,
 }
 EXPORT_SYMBOL(qcom_scm_mem_protect_video_var);
 
+int qcom_scm_tsens_reinit(int *tsens_ret)
+{
+	unsigned int ret;
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_TSENS,
+		.cmd = QCOM_SCM_TSENS_INIT_ID,
+	};
+	struct qcom_scm_res res;
+
+	ret = qcom_scm_call(__scm->dev, &desc, &res);
+	if (tsens_ret)
+		*tsens_ret = res.result[0];
+
+	return ret;
+}
+EXPORT_SYMBOL(qcom_scm_tsens_reinit);
+
 static int __qcom_scm_assign_mem(struct device *dev, phys_addr_t mem_region,
 				 size_t mem_sz, phys_addr_t src, size_t src_sz,
 				 phys_addr_t dest, size_t dest_sz)
diff --git a/drivers/firmware/qcom_scm.h b/drivers/firmware/qcom_scm.h
index 0d51eef2472f..495fa00230c7 100644
--- a/drivers/firmware/qcom_scm.h
+++ b/drivers/firmware/qcom_scm.h
@@ -94,6 +94,10 @@ extern int scm_legacy_call(struct device *dev, const struct qcom_scm_desc *desc,
 #define QCOM_SCM_PIL_PAS_IS_SUPPORTED	0x07
 #define QCOM_SCM_PIL_PAS_MSS_RESET	0x0a
 
+/* TSENS Services and Function IDs */
+#define QCOM_SCM_SVC_TSENS		0x1E
+#define QCOM_SCM_TSENS_INIT_ID		0x5
+
 #define QCOM_SCM_SVC_IO			0x05
 #define QCOM_SCM_IO_READ		0x01
 #define QCOM_SCM_IO_WRITE		0x02
diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
index f8335644a01a..f8c9eb739df1 100644
--- a/include/linux/qcom_scm.h
+++ b/include/linux/qcom_scm.h
@@ -124,4 +124,6 @@ extern int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
 extern int qcom_scm_lmh_profile_change(u32 profile_id);
 extern bool qcom_scm_lmh_dcvsh_available(void);
 
+extern int qcom_scm_tsens_reinit(int *tsens_ret);
+
 #endif
-- 
2.35.3

