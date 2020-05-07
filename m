Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 921F81C8A21
	for <lists+linux-pm@lfdr.de>; Thu,  7 May 2020 14:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgEGMIx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 May 2020 08:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725939AbgEGMIu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2020 08:08:50 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849ACC05BD09
        for <linux-pm@vger.kernel.org>; Thu,  7 May 2020 05:08:50 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id l18so6073925wrn.6
        for <linux-pm@vger.kernel.org>; Thu, 07 May 2020 05:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cU4Z779oiZ5X1KtL6o+GfgpTVjAX9hDbWnPU6sq2sRo=;
        b=jhaavaRP0OgpViv0SFakoHbHfHJQ2+BF9Bw9ycjm7Dg2HSQSq/8xbwRXy53r/H2B73
         dF3VeQ1DxWgL5AcoGDvK5me3OkdxwturoaKT8VRL79ZDfzmPNki3xUOhaG/VZlrc/NCu
         4zihjNlAuF34vmVoPDSrfq7SYo4lk//qveC3wlG0PmqInrUid2TkF6Q1pxzkVaqA9UpB
         KMcgL86SkX0+JhcGPEjv6CnKY6Oh48Hnbq+N47hB8x9ohbisDnzL6tqI4UTi7iRIsbNx
         hj/WdKPYjbTH2SlnKgYjcccZu6vwORWuPu+hNhgjtDH6AbMmq6as/tP9YAfimmavYWDH
         MptA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cU4Z779oiZ5X1KtL6o+GfgpTVjAX9hDbWnPU6sq2sRo=;
        b=KbQyBp6z2P+HAaSmbmySMWFNFa3KpkTlmUKxeLUrr+b3qGpLHEZwb4K498QT8J9Asr
         FOJ+zTKcgmKuiui9O0y4iNojGcehjQsWiLxHn210lqmI44MwwCC0wlQXx2IxooiW7Czq
         tBdHnpI6DDRVb/0knHF8l8dF3JhED6Mp/x9fIcsNc4B7QgeVYIncZ7LtRZic6D5hGQXa
         Reisd0IFHtCbzSFp2fQ9Qzu9M+edRL3bRfTvPm1//5BooZQIvIwqSabtFrJokeji0Ekn
         dsL+CHYc/znRZuqD4dd+rOJjNHoaaFXcvHQ+gVrvts5HekJSB1kIuuCkLzmLUUdwzROA
         7fww==
X-Gm-Message-State: AGi0PubZCzzO7abkGyw5VUvNfgLkllP8tsjnpO7KxjqMir17KW4PJ00t
        zEBYDZXeVH+66W6gL4+6NVWePsXoh/Y=
X-Google-Smtp-Source: APiQypIXn6rC140NZSrR3FyAareqVrgqZulNikJP/mOTFiNeikQMLpljvv2MgS3DJTGXJbCUvDzfaQ==
X-Received: by 2002:adf:e9d2:: with SMTP id l18mr14969416wrn.34.1588853328684;
        Thu, 07 May 2020 05:08:48 -0700 (PDT)
Received: from localhost.localdomain ([87.120.218.65])
        by smtp.googlemail.com with ESMTPSA id 1sm7874605wmz.13.2020.05.07.05.08.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2020 05:08:46 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     evgreen@chromium.org, bjorn.andersson@linaro.org, mka@chromium.org,
        akashast@codeaurora.org, linux-kernel@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH v2] interconnect: Add helpers for enabling/disabling a path
Date:   Thu,  7 May 2020 15:08:46 +0300
Message-Id: <20200507120846.8354-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is a repeated pattern in multiple drivers where they want to switch
the bandwidth between zero and some other value. This is happening often
in the suspend/resume callbacks. Let's add helper functions to enable and
disable the path, so that callers don't have to take care of remembering
the bandwidth values and handle this in the framework instead.

With this patch the users can call icc_disable() and icc_enable() to lower
their bandwidth request to zero and then restore it back to it's previous
value.

Suggested-by: Evan Green <evgreen@chromium.org>
Suggested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
v2: https://lore.kernel.org/r/20200428091650.27669-1-georgi.djakov@linaro.org/
* Extract the common code into __icc_enable() (Matthias)


 drivers/interconnect/core.c     | 39 ++++++++++++++++++++++++++++++++-
 drivers/interconnect/internal.h |  2 ++
 include/linux/interconnect.h    | 12 ++++++++++
 3 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index f5699ed34e43..d5e0f93c942d 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -158,6 +158,7 @@ static struct icc_path *path_init(struct device *dev, struct icc_node *dst,
 		hlist_add_head(&path->reqs[i].req_node, &node->req_list);
 		path->reqs[i].node = node;
 		path->reqs[i].dev = dev;
+		path->reqs[i].enabled = true;
 		/* reference to previous node was saved during path traversal */
 		node = node->reverse;
 	}
@@ -249,9 +250,12 @@ static int aggregate_requests(struct icc_node *node)
 	if (p->pre_aggregate)
 		p->pre_aggregate(node);
 
-	hlist_for_each_entry(r, &node->req_list, req_node)
+	hlist_for_each_entry(r, &node->req_list, req_node) {
+		if (!r->enabled)
+			continue;
 		p->aggregate(node, r->tag, r->avg_bw, r->peak_bw,
 			     &node->avg_bw, &node->peak_bw);
+	}
 
 	return 0;
 }
@@ -571,6 +575,39 @@ int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
 }
 EXPORT_SYMBOL_GPL(icc_set_bw);
 
+static int __icc_enable(struct icc_path *path, bool enable)
+{
+	int i;
+
+	if (!path)
+		return 0;
+
+	if (WARN_ON(IS_ERR(path) || !path->num_nodes))
+		return -EINVAL;
+
+	mutex_lock(&icc_lock);
+
+	for (i = 0; i < path->num_nodes; i++)
+		path->reqs[i].enabled = enable;
+
+	mutex_unlock(&icc_lock);
+
+	return icc_set_bw(path, path->reqs[0].avg_bw,
+			  path->reqs[0].peak_bw);
+}
+
+int icc_disable(struct icc_path *path)
+{
+	return __icc_enable(path, false);
+}
+EXPORT_SYMBOL_GPL(icc_disable);
+
+int icc_enable(struct icc_path *path)
+{
+	return __icc_enable(path, true);
+}
+EXPORT_SYMBOL_GPL(icc_enable);
+
 /**
  * icc_get() - return a handle for path between two endpoints
  * @dev: the device requesting the path
diff --git a/drivers/interconnect/internal.h b/drivers/interconnect/internal.h
index bf18cb7239df..f5f82a5c939e 100644
--- a/drivers/interconnect/internal.h
+++ b/drivers/interconnect/internal.h
@@ -14,6 +14,7 @@
  * @req_node: entry in list of requests for the particular @node
  * @node: the interconnect node to which this constraint applies
  * @dev: reference to the device that sets the constraints
+ * @enabled: indicates whether the path with this request is enabled
  * @tag: path tag (optional)
  * @avg_bw: an integer describing the average bandwidth in kBps
  * @peak_bw: an integer describing the peak bandwidth in kBps
@@ -22,6 +23,7 @@ struct icc_req {
 	struct hlist_node req_node;
 	struct icc_node *node;
 	struct device *dev;
+	bool enabled;
 	u32 tag;
 	u32 avg_bw;
 	u32 peak_bw;
diff --git a/include/linux/interconnect.h b/include/linux/interconnect.h
index 770692421f4c..2b7b331c9354 100644
--- a/include/linux/interconnect.h
+++ b/include/linux/interconnect.h
@@ -30,6 +30,8 @@ struct icc_path *icc_get(struct device *dev, const int src_id,
 struct icc_path *of_icc_get(struct device *dev, const char *name);
 struct icc_path *devm_of_icc_get(struct device *dev, const char *name);
 void icc_put(struct icc_path *path);
+int icc_disable(struct icc_path *path);
+int icc_enable(struct icc_path *path);
 int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw);
 void icc_set_tag(struct icc_path *path, u32 tag);
 
@@ -57,6 +59,16 @@ static inline void icc_put(struct icc_path *path)
 {
 }
 
+static inline int icc_disable(struct icc_path *path)
+{
+	return 0;
+}
+
+static inline int icc_enable(struct icc_path *path)
+{
+	return 0;
+}
+
 static inline int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
 {
 	return 0;
