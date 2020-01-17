Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA5DA140713
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2020 10:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbgAQJ61 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jan 2020 04:58:27 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45799 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbgAQJ60 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jan 2020 04:58:26 -0500
Received: by mail-wr1-f68.google.com with SMTP id j42so22013693wrj.12
        for <linux-pm@vger.kernel.org>; Fri, 17 Jan 2020 01:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vdr1R6he+EPUd/NCIYt7CQBDB83sSDrPxTnifgtApfQ=;
        b=ROhabsZfAAiEDR7Gzc8sCW8VUDb0mnVMwJ06LQzZcVDa8sh7M+fsbMH83pXxpwM+U1
         Xa3XjS8pqN9oEcjv/1DIf5uRHpbrCwMesgQCfzdTbrh9fSHnoXq/dAEGtOAk2iFs1Pke
         CpuYNTjhkp1JN8cF/f4n5ICIo7eKCktztF8g69TA2UF5348dxmb6wABTxzDfnPatN54a
         qKVaOc8ULZPv5VU8K9uYDmS6tl5M3sYwNi14NL+46CihyhOAXeNSTSln6KVR/iGquJar
         1b0zxh3WLCpley9d6LWSCRco2mkxjleo5/NvJXy0Z0kIg4ImjUmt051jkCUzBiodVGQw
         3DLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vdr1R6he+EPUd/NCIYt7CQBDB83sSDrPxTnifgtApfQ=;
        b=MATHoNzjm5i8pZRC0aLWV1DpScST/hCtDlX/IZVUjMy+bw7pxBtNmifmcjJPqCnJsw
         WXqCX5JJYhCzwhgD0tLd0grAyQiaYphAp7jxiO8WukC2ih5Nz4weryMQIfACabUuuDuE
         m8Hv5iVcsE7gwRdefyPXx3Ohiji2go8iDXW9sAMUds5/HwOQ8R8NBMhpTK8k0uiiDwz/
         aAkzmsvNkh5ituPQK+v782f/tuK5SunO3w1YWizD4UrYptD2/2FcWcqKX64ko+lUgy6c
         CZvUizmKot5u6Cvw7eIT8/gdzv2kBPdWgWAsRk8YKTXx1HRa6CtFiLQkOSct1dJ+MbMl
         yEZA==
X-Gm-Message-State: APjAAAUtESRjB6Mp6JMHHUPgfjiy2VyqwObGzcWfbtMEn5wg+h721WVK
        QPW8Wgd2AfKdJ34C8bt2+X+Ieg==
X-Google-Smtp-Source: APXvYqyKSTIDCTHrX8b2t3m5uHVW+d+9ClLZ1lMfZMNYkwzcXqTaqzGYB0PXLzgjZl0YD61ceN2+sA==
X-Received: by 2002:a5d:6406:: with SMTP id z6mr2166824wru.294.1579255104160;
        Fri, 17 Jan 2020 01:58:24 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id r62sm9967007wma.32.2020.01.17.01.58.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Jan 2020 01:58:23 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 04/12] interconnect: Add a name to struct icc_path
Date:   Fri, 17 Jan 2020 11:58:08 +0200
Message-Id: <20200117095816.23575-5-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117095816.23575-1-georgi.djakov@linaro.org>
References: <20200117095816.23575-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When debugging interconnect things, it turned out that saving the path
name and including it in the traces is quite useful, especially for
devices with multiple paths.

For the path name we use the one specified in DT, or if we use platform
data, the name is based on the source and destination node names.

Suggested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/core.c     | 18 +++++++++++++++---
 drivers/interconnect/internal.h |  2 ++
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index f30a326dc7ce..4f9bdb7f9165 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -356,9 +356,17 @@ struct icc_path *of_icc_get(struct device *dev, const char *name)
 
 	mutex_lock(&icc_lock);
 	path = path_find(dev, src_node, dst_node);
-	if (IS_ERR(path))
-		dev_err(dev, "%s: invalid path=%ld\n", __func__, PTR_ERR(path));
 	mutex_unlock(&icc_lock);
+	if (IS_ERR(path)) {
+		dev_err(dev, "%s: invalid path=%ld\n", __func__, PTR_ERR(path));
+		return path;
+	}
+
+	if (name)
+		path->name = kstrdup_const(name, GFP_KERNEL);
+	else
+		path->name = kasprintf(GFP_KERNEL, "%s-%s",
+				       src_node->name, dst_node->name);
 
 	return path;
 }
@@ -481,9 +489,12 @@ struct icc_path *icc_get(struct device *dev, const int src_id, const int dst_id)
 		goto out;
 
 	path = path_find(dev, src, dst);
-	if (IS_ERR(path))
+	if (IS_ERR(path)) {
 		dev_err(dev, "%s: invalid path=%ld\n", __func__, PTR_ERR(path));
+		goto out;
+	}
 
+	path->name = kasprintf(GFP_KERNEL, "%s-%s", src->name, dst->name);
 out:
 	mutex_unlock(&icc_lock);
 	return path;
@@ -519,6 +530,7 @@ void icc_put(struct icc_path *path)
 	}
 	mutex_unlock(&icc_lock);
 
+	kfree_const(path->name);
 	kfree(path);
 }
 EXPORT_SYMBOL_GPL(icc_put);
diff --git a/drivers/interconnect/internal.h b/drivers/interconnect/internal.h
index 5853e8faf223..bf18cb7239df 100644
--- a/drivers/interconnect/internal.h
+++ b/drivers/interconnect/internal.h
@@ -29,10 +29,12 @@ struct icc_req {
 
 /**
  * struct icc_path - interconnect path structure
+ * @name: a string name of the path (useful for ftrace)
  * @num_nodes: number of hops (nodes)
  * @reqs: array of the requests applicable to this path of nodes
  */
 struct icc_path {
+	const char *name;
 	size_t num_nodes;
 	struct icc_req reqs[];
 };
