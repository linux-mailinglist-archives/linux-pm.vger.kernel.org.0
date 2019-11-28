Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1C8610C98E
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2019 14:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfK1Nen (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Nov 2019 08:34:43 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36889 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbfK1Nen (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Nov 2019 08:34:43 -0500
Received: by mail-wm1-f66.google.com with SMTP id f129so11695282wmf.2
        for <linux-pm@vger.kernel.org>; Thu, 28 Nov 2019 05:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=efZXdx8nOE9IRhU/0a0pMggKVJBaJwNsJBonEmaYwBU=;
        b=EZxEFdIxvM62pDLBLLIcES0NSWNTez/Q9a9uibJWaZ3fpi98XzuotDpSxZ2Ni1JC9p
         Osoa0ZmcJGtW9bz8oF3eTtEsDo3cWTXVM65Pp+UxtNwwW/y52U4MLg2PKQw5nuuUbnCY
         91v0xn/r7zmwsm6zVneHY20HFX4ZKRbf/rQF5T+iApX/Lpvy+1QMXKY4NzURC4HoE1RC
         W+wSvMNPr1zRBZNs0t8/cHMoGyUJ7m/GSgeH5bbtafyMcJv2cbBtFg7xmon8QOYBmfON
         KUy5wwJQus2MYRSx/tvqiaPK3DvKPq/Vp3LDRY165O62TU/Dr2TbMLo/0b0nY4Luc7Rx
         frtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=efZXdx8nOE9IRhU/0a0pMggKVJBaJwNsJBonEmaYwBU=;
        b=G63FIO94yf3qjtGjtfOKYfpb6JOrSO2LPFDM5CFLNxamsvYCRmhxyEKI46m0nZIuP3
         pdbPrBA6UagSAtuuxf4WJRtmAuVkIPIyY5wIOqj2aoJKoskTiVGk+QssOFn4EMUcK10v
         pbTVbo7cnGabALqMkan/HjBQbFIhcvQX/S3zeIm9k+zWhhJLBVfoaVa2oz1vFDZtdrEl
         0c1OcT61GyP/s9Tctiw2VkOCu3Q4n3nNhQyLkH6CBudSWcAwKpjZ4miTCnZ4vzY7pkVA
         8nuctpz6xUVcPBekSU6S+SFDM4CBkZ2S3cjeA0ujiD+CYM4SzbJkUmGcS0J75wPOuNJv
         WPDQ==
X-Gm-Message-State: APjAAAU+UDKZM/5eAnF2SSbf6UFlxWJIaK4VVnLj0+UyKDP651jWnY9a
        5hr/HrN7xTayx2O10sgmlayDJliJLpg=
X-Google-Smtp-Source: APXvYqwwb/ogD8FJGE0VinCuLLQUf1L1Nd1+voYXxUCs8+wa9MLOJK5JYZXlbgdV0e2MpXbmUoEpxA==
X-Received: by 2002:a7b:cd82:: with SMTP id y2mr8272892wmj.58.1574948080885;
        Thu, 28 Nov 2019 05:34:40 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id y20sm2220451wmi.25.2019.11.28.05.34.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Nov 2019 05:34:40 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org, digetx@gmail.com,
        evgreen@chromium.org, daidavid1@codeaurora.org,
        masneyb@onstation.org, sibis@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH 4/5] interconnect: Add a common helper for removing all nodes
Date:   Thu, 28 Nov 2019 15:34:34 +0200
Message-Id: <20191128133435.25667-4-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191128133435.25667-1-georgi.djakov@linaro.org>
References: <20191128133435.25667-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The removal of all nodes from a provider seem to be a common functionality
for all existing users and it would make sense to factor out this into a
a common helper function.

Suggested-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/core.c           | 22 ++++++++++++++++++++++
 include/linux/interconnect-provider.h |  6 ++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 467c539310f3..0e4852feb395 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -735,6 +735,28 @@ void icc_node_del(struct icc_node *node)
 }
 EXPORT_SYMBOL_GPL(icc_node_del);
 
+/**
+ * icc_nodes_remove() - remove all previously added nodes from provider
+ * @provider: the interconnect provider we are removing nodes from
+ *
+ * Return: 0 on success, or an error code otherwise
+ */
+int icc_nodes_remove(struct icc_provider *provider)
+{
+	struct icc_node *n, *tmp;
+
+	if (WARN_ON(IS_ERR_OR_NULL(provider)))
+		return -EINVAL;
+
+	list_for_each_entry_safe_reverse(n, tmp, &provider->nodes, node_list) {
+		icc_node_del(n);
+		icc_node_destroy(n->id);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(icc_nodes_remove);
+
 /**
  * icc_provider_add() - add a new interconnect provider
  * @provider: the interconnect provider that will be added into topology
diff --git a/include/linux/interconnect-provider.h b/include/linux/interconnect-provider.h
index b16f9effa555..31440c921216 100644
--- a/include/linux/interconnect-provider.h
+++ b/include/linux/interconnect-provider.h
@@ -98,6 +98,7 @@ int icc_link_create(struct icc_node *node, const int dst_id);
 int icc_link_destroy(struct icc_node *src, struct icc_node *dst);
 void icc_node_add(struct icc_node *node, struct icc_provider *provider);
 void icc_node_del(struct icc_node *node);
+int icc_nodes_remove(struct icc_provider *provider);
 int icc_provider_add(struct icc_provider *provider);
 int icc_provider_del(struct icc_provider *provider);
 
@@ -130,6 +131,11 @@ void icc_node_del(struct icc_node *node)
 {
 }
 
+static inline int icc_nodes_remove(struct icc_provider *provider)
+{
+	return -ENOTSUPP;
+}
+
 static inline int icc_provider_add(struct icc_provider *provider)
 {
 	return -ENOTSUPP;
