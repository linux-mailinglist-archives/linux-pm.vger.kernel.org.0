Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDD54140711
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2020 10:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgAQJ6X (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jan 2020 04:58:23 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54961 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbgAQJ6V (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jan 2020 04:58:21 -0500
Received: by mail-wm1-f66.google.com with SMTP id b19so6763243wmj.4
        for <linux-pm@vger.kernel.org>; Fri, 17 Jan 2020 01:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qe7hebl/mzA5Y4yspidYJnXz8QIxCuPLK7wWr6/hKiU=;
        b=XnUDwVsAsNbFlvaGv/Mxxp0g86KC+WA5dTFlLpL3YnqfDrJo/0yGU2CmRdOBii7lpG
         cgNKD4vTO3v0iOZt1Jh7WC8sDleIaoYBdJDF3pzL8Mg0w0h3bmnLF7/+Gnqmj/TiHn+u
         LgoRzxYHQuZERRdKSOJOMMAT6ez71f4mH4BW+EgVXHQYR9g2DLgjw0Pzwxh9veFGhnew
         XLurquhFXdcDw336nu8esZFEMSAOfVZ+8RqYK9Q5pBxPJ/DvIcxT8WuwRCPTppiMo8ny
         NnuooOC+D0jo5hqmTC7sFj/rP5wAb3Ve1hNlMQmlo44t+cq8FP/9A3jqncxCeKwrI1PW
         mu7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qe7hebl/mzA5Y4yspidYJnXz8QIxCuPLK7wWr6/hKiU=;
        b=i4WuG1siTchDTEg+jakQegAUc/tiDfmbWejw5GO/V8T5gcZOMjFdYXAfuYnY9fRM+0
         sKu9U4isG111ThwVHXWQrhYmRUviSAHPeNmoAPglZB9Jo5WcqTlURBi+Hh32P1y1W8Kr
         wp1+qBU9RoG0wAlMZZk2oRyYu47cLLie25tLpmoqQ3GaM81mswvnOiLJLicXNBkVAXjE
         FRQ+4Z6ah6Jx0t+QZ9c0KXk+jfyoIvhOm4z4yg0obMUcstEqMlArAdBuL2Gi4WAzkye6
         Dt98QSsU5jsjuqpwizoKp837qXQU9rcWDGFMuVPniTUxRC8Yn5nVyag90Vf1geof5bac
         K4og==
X-Gm-Message-State: APjAAAUbFQ5wXufJUTuWb20fKBpBs++IJyq7R6ThsivfltjZbWA8WK/4
        M1KNOrKm1sYeZ8/l74hzPt+hnA==
X-Google-Smtp-Source: APXvYqwpwCwY0KSiQCpa+dAUbkJVcleZ1Gny74AahZORM5PCAEWPnzkdDQK3w/4N3GYV63g7phio2g==
X-Received: by 2002:a05:600c:2046:: with SMTP id p6mr3729467wmg.110.1579255099536;
        Fri, 17 Jan 2020 01:58:19 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id r62sm9967007wma.32.2020.01.17.01.58.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Jan 2020 01:58:19 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 01/12] interconnect: Add a common helper for removing all nodes
Date:   Fri, 17 Jan 2020 11:58:05 +0200
Message-Id: <20200117095816.23575-2-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117095816.23575-1-georgi.djakov@linaro.org>
References: <20200117095816.23575-1-georgi.djakov@linaro.org>
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
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/core.c           | 22 ++++++++++++++++++++++
 include/linux/interconnect-provider.h |  6 ++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index c498796adc07..1b811423020a 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -742,6 +742,28 @@ void icc_node_del(struct icc_node *node)
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
