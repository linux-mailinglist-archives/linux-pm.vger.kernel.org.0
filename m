Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4F4E10C9CA
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2019 14:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfK1Nsn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Nov 2019 08:48:43 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46042 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfK1Nsn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Nov 2019 08:48:43 -0500
Received: by mail-wr1-f67.google.com with SMTP id j42so5357520wrj.12
        for <linux-pm@vger.kernel.org>; Thu, 28 Nov 2019 05:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hASZYFpvtuqMj2K9Ei/y6hgpj2q+o1mM77RhlWy+nlM=;
        b=i9hyxSMdXuLPXnJAJs9ZWGt2uHdPrIAytFfduuedVuEyINMo//Lzg5xsxzqpWPohGs
         NHBHrDvnfIsYCI3ppthFHJXFi8p6wrsMXd72bXnKBD2NQIjPv+qHrAoy1t4NYfiNfL3L
         LyPsENVFPLEZtpjWFHEJKMoiURSE6B3UbPSaxgoF3cSh8Ms2oprtqQuD+frRIX1pmQPC
         qEp+z6RftEsvK5EJ9nGb2TBP+VmuKU/PgV/Y/GyPqPdURFPde+H+ZPdaU/iCUpImxka9
         CmlCw60wSsu1WvpdpohBK1rfaFzDLjEFDz+iJLJe9/kap3+/7D2iIo9hQxdGUlzyei+C
         2ziQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hASZYFpvtuqMj2K9Ei/y6hgpj2q+o1mM77RhlWy+nlM=;
        b=a/STObiDgko2IJMoU3/fU2XACYb56A+V93vi3z8hJ3PeMChKuuxBxsUCPd5Drv2W85
         py0W8RGxPEFWmiDqaOvO5fRaM1JHTWEDI6x1CVZde0rBHoSj/JXR80e85iScB44QCYRp
         QyuLFd/66wiANI3iBdzPUbp6gMOh3v4Q38j70xyGn2Ap5S80ZSo2brCrPU1ltEIEijfl
         9S9Wdjc7uYIXN87b3R6ilSi6tceBy7I8egYbubIaHE5YWdDW8vztVm6TlrpbXBoQGQiZ
         WPd6aMjLakEQHCbwVMhoRfjppNEpoGR9C7bQYNk87KMcD3M2brpaoAenTdYsOnEWRoGA
         2LHA==
X-Gm-Message-State: APjAAAXeYs2YmWRTfm5M0z9W0aBGc/xsZZGgMGK1z28LOQVQKe3N+jIR
        DoZBWw6d1LKqPfu++yFmKJmN0P6VEbI=
X-Google-Smtp-Source: APXvYqwUl/c9Ev2fwHT9rSRo/CPTNmXhORMjUF9rVGT2228iCfXD2eVVfpBiCL+T0UowPmk9L4UngA==
X-Received: by 2002:adf:f445:: with SMTP id f5mr26311139wrp.193.1574948920904;
        Thu, 28 Nov 2019 05:48:40 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id m3sm8523734wrs.53.2019.11.28.05.48.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Nov 2019 05:48:40 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     evgreen@chromium.org, bjorn.andersson@linaro.org,
        agross@kernel.org, daidavid1@codeaurora.org, masneyb@onstation.org,
        sibis@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org
Subject: [PATCH 1/2] interconnect: Add a common standard aggregate function
Date:   Thu, 28 Nov 2019 15:48:38 +0200
Message-Id: <20191128134839.27606-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently there is one very standard aggregation method that is used by
several drivers. Let's add this as a common function, so that drivers
could just point to it, instead of copy/pasting code.

Suggested-by: Evan Green <evgreen@chromium.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/core.c           | 10 ++++++++++
 include/linux/interconnect-provider.h |  8 ++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 0e4852feb395..2633fd223875 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -221,6 +221,16 @@ static int apply_constraints(struct icc_path *path)
 	return ret;
 }
 
+int icc_std_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
+		      u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
+{
+	*agg_avg += avg_bw;
+	*agg_peak = max(*agg_peak, peak_bw);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(icc_std_aggregate);
+
 /* of_icc_xlate_onecell() - Translate function using a single index.
  * @spec: OF phandle args to map into an interconnect node.
  * @data: private data (pointer to struct icc_onecell_data)
diff --git a/include/linux/interconnect-provider.h b/include/linux/interconnect-provider.h
index 31440c921216..0c494534b4d3 100644
--- a/include/linux/interconnect-provider.h
+++ b/include/linux/interconnect-provider.h
@@ -92,6 +92,8 @@ struct icc_node {
 
 #if IS_ENABLED(CONFIG_INTERCONNECT)
 
+int icc_std_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
+		      u32 peak_bw, u32 *agg_avg, u32 *agg_peak);
 struct icc_node *icc_node_create(int id);
 void icc_node_destroy(int id);
 int icc_link_create(struct icc_node *node, const int dst_id);
@@ -104,6 +106,12 @@ int icc_provider_del(struct icc_provider *provider);
 
 #else
 
+static inline int icc_std_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
+				    u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
+{
+	return -ENOTSUPP;
+}
+
 static inline struct icc_node *icc_node_create(int id)
 {
 	return ERR_PTR(-ENOTSUPP);
