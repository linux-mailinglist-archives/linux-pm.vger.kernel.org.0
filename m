Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3995510CA43
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2019 15:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfK1OSg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Nov 2019 09:18:36 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43034 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbfK1OSY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Nov 2019 09:18:24 -0500
Received: by mail-wr1-f66.google.com with SMTP id n1so31355160wra.10
        for <linux-pm@vger.kernel.org>; Thu, 28 Nov 2019 06:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qyyDjQdnoeb2queL1lR7vTcgx8zyzYmqnXXfouU/oLY=;
        b=Cr18FxmY/IBf8ucdTROQ28wKO0nRAvii2N1tI+avejHCJ4/M7e7lber8GjL6Z6I0st
         Oe3eI3Ts6y+pKbGAl8WOoMVTRDGX8NDwhBn867vxFfbBxPea6/0RhV4zOLJkWtdVUnF0
         Cq5KT7SilV9g0vqVttuzBuhy3w4thT4RQqxjrbixVTnPK0IH8fESguUQXqHoOSxcOpPF
         GDTTtQKYJTpRDi9pMuOv5bxJuUfpxQnbFhJtH/GxKPc/XyzvR38MJfg72g9W1BFP7n5Y
         iVvAtpxpO34HGYmRP2wO6okXrof2yNGfNh/BCvWrdvJALnRg1eawTMdSCK4vmMlfiDr7
         djNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qyyDjQdnoeb2queL1lR7vTcgx8zyzYmqnXXfouU/oLY=;
        b=mQmEa+/aOWXSa7NUTNtOkiOaMZ5LIEVV7pOHP0Bz+MU8C3VJSHXntonQ/IYrqbmRiy
         wECFdPciN2wjkpmFtRW2uUAeu4d+huerRyKLfyE9rC00PAWiWaRdRG30kpR1cD+nCwQk
         E+NYQdJNWEj6vxstYcRCbhWjiKALkIf9W+epyCPcKDX7AZoXdziR0y+GoW1cTnZm/wJT
         FKPouEHbCN3CxdP3eTJg3g4sYfTq7cU5LyMJKQebC4/00hebpMO28GXmXNm7lG9lGr5Z
         uK//VhgNQoW3jvixCD3QTb8nhuVTWvUYsUaMmIwAApeBv/tltofIFQvLDiH9f2YDYhVW
         lG+Q==
X-Gm-Message-State: APjAAAUYym1JpqygtdQQKkpr/PF9FRYGIQ0zwS/j60oDpi5Ln6iRHpBe
        TUJZ4bvemlwV81FkGUVeuhKHCeecDH0=
X-Google-Smtp-Source: APXvYqwCgQz6TJbmvCy58G73SgRuCmaOeDmHeE5hwehaXWFQCG5K9PP7/edDoHjbuxaZQFCYw46elA==
X-Received: by 2002:adf:ea8d:: with SMTP id s13mr48495689wrm.366.1574950703019;
        Thu, 28 Nov 2019 06:18:23 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id f6sm23947092wrr.15.2019.11.28.06.18.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Nov 2019 06:18:22 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     rostedt@goodmis.org, mingo@redhat.com, bjorn.andersson@linaro.org,
        vincent.guittot@linaro.org, daidavid1@codeaurora.org,
        okukatla@codeaurora.org, evgreen@chromium.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH v4 2/3] interconnect: Add a name to struct icc_path
Date:   Thu, 28 Nov 2019 16:18:17 +0200
Message-Id: <20191128141818.32168-3-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191128141818.32168-1-georgi.djakov@linaro.org>
References: <20191128141818.32168-1-georgi.djakov@linaro.org>
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
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/core.c     | 18 +++++++++++++++---
 drivers/interconnect/internal.h |  2 ++
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index f30a326dc7ce..c9e16bc1331e 100644
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
+		path->name = kstrdup(name, GFP_KERNEL);
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
 
+	kfree(path->name);
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
