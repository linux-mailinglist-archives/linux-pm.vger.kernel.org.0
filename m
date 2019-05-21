Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10E2D254CE
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2019 18:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfEUQEa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 May 2019 12:04:30 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33256 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbfEUQEa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 May 2019 12:04:30 -0400
Received: by mail-pg1-f194.google.com with SMTP id h17so8829079pgv.0
        for <linux-pm@vger.kernel.org>; Tue, 21 May 2019 09:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6dlMq3dpaZqEx6RvkbThMUhOu6jgvPwAdvzh6RwJDA0=;
        b=UXbb6DZCMg+n2Zx4oEbLKC8bmid3+/k3Q2MXADkFHbjAjtQDs68vUSqOkHxpLdQQvj
         IdSCqNvmOTIJNEcjROZ73h3Vsfwb4gEpftRpcfjlCDKuv/HjhEmSfPKkVGB0Jef0u37Y
         IcThgB2sa6uYiQJu/yqord6qk3e6N8MUhRdo4zLDNInQ75oXXcKiaXUO1iW0yxYcuQWA
         N/YRhhWvRJoEAynJcR2lGQRXhNQu3i/ICwOMRizqN5PedpjyfhYlxG+MAFzt8Sxdpl/B
         bfMwNdRr2GmgENA2xPAEYuTbDXgZdO+2Q7TDQHESah0Juvy/BFdw+lnlTf60RLKJJYpX
         zSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6dlMq3dpaZqEx6RvkbThMUhOu6jgvPwAdvzh6RwJDA0=;
        b=SRT00aom+J9x9ZLqXxV+se7rDH7kqCLj/ALowZBRhyvMMfkGNX8Jut4NB6SqyPI9Ld
         dW6oH+cCyeycssX14ACRMlFiazsARYZCszfbbSqf8Utr2N+H7p2JRgOZlxLJ83cCRxgH
         4xvAGpFQZ9NYvSB4ZugmmNDJQMOYFcZFWGzrAtM6gn1/+84TfqGU1W1lcoCoKdx1v7X/
         mVqbDqDj9s3Lo2/A1UdFI10ucPMl33YaY6Pp34zF3BHyk6igxxDBuoL9+hm1qoVkYzuw
         5FfP6JtbWk4lBB+mNwU4MXtfyjMeAqnz4nCYdqfKDhkEE6yMEp7kxtAYLP5NCmftPJSr
         FY4Q==
X-Gm-Message-State: APjAAAVKwucaYx6sStbWjJxSMUEWh1u7Wlgq8K4T+UK3x+738dXDCnVU
        jonYt2rialw3JH1XNkhPGcc=
X-Google-Smtp-Source: APXvYqyUUrUZ+4NnabA9Wx9gAGu/svtfuvfgqSe7HwMr/XlguJFBuG5TdL72j8yys3dc1aV5Up1BAA==
X-Received: by 2002:a62:ac0c:: with SMTP id v12mr5965733pfe.59.1558454669807;
        Tue, 21 May 2019 09:04:29 -0700 (PDT)
Received: from mita-MS-7A45.lan ([240f:34:212d:1:9cd0:73e8:b74a:624e])
        by smtp.gmail.com with ESMTPSA id j5sm28954786pfa.15.2019.05.21.09.04.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 May 2019 09:04:29 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-nvme@lists.infradead.org, linux-pm@vger.kernel.org
Cc:     Keith Busch <keith.busch@intel.com>
Subject: [PATCH v2 1/4] nvme: Export get and set features
Date:   Wed, 22 May 2019 01:04:06 +0900
Message-Id: <1558454649-28783-2-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558454649-28783-1-git-send-email-akinobu.mita@gmail.com>
References: <1558454649-28783-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Keith Busch <keith.busch@intel.com>

Future use intends to make use of features, so export these functions. And
since their implementation is identical except for the opcode, provide
a new convenience function that implement each.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/nvme/host/core.c | 22 +++++++++++++++++++---
 drivers/nvme/host/nvme.h |  4 ++++
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d352145..c04df80 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1113,15 +1113,15 @@ static struct nvme_id_ns *nvme_identify_ns(struct nvme_ctrl *ctrl,
 	return id;
 }
 
-static int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsigned dword11,
-		      void *buffer, size_t buflen, u32 *result)
+static int nvme_features(struct nvme_ctrl *dev, u8 op, unsigned fid,
+		unsigned dword11, void *buffer, size_t buflen, u32 *result)
 {
 	struct nvme_command c;
 	union nvme_result res;
 	int ret;
 
 	memset(&c, 0, sizeof(c));
-	c.features.opcode = nvme_admin_set_features;
+	c.features.opcode = op;
 	c.features.fid = cpu_to_le32(fid);
 	c.features.dword11 = cpu_to_le32(dword11);
 
@@ -1132,6 +1132,22 @@ static int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsigned dword
 	return ret;
 }
 
+int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsigned dword11,
+		      void *buffer, size_t buflen, u32 *result)
+{
+	return nvme_features(dev, nvme_admin_set_features, fid, dword11, buffer,
+			     buflen, result);
+}
+EXPORT_SYMBOL_GPL(nvme_set_features);
+
+int nvme_get_features(struct nvme_ctrl *dev, unsigned fid, unsigned dword11,
+		      void *buffer, size_t buflen, u32 *result)
+{
+	return nvme_features(dev, nvme_admin_get_features, fid, dword11, buffer,
+			     buflen, result);
+}
+EXPORT_SYMBOL_GPL(nvme_get_features);
+
 int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count)
 {
 	u32 q_count = (*count - 1) | ((*count - 1) << 16);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 56bba7a..bb673b8 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -459,6 +459,10 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		union nvme_result *result, void *buffer, unsigned bufflen,
 		unsigned timeout, int qid, int at_head,
 		blk_mq_req_flags_t flags, bool poll);
+int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsigned dword11,
+		      void *buffer, size_t buflen, u32 *result);
+int nvme_get_features(struct nvme_ctrl *dev, unsigned fid, unsigned dword11,
+		      void *buffer, size_t buflen, u32 *result);
 int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count);
 void nvme_stop_keep_alive(struct nvme_ctrl *ctrl);
 int nvme_reset_ctrl(struct nvme_ctrl *ctrl);
-- 
2.7.4

