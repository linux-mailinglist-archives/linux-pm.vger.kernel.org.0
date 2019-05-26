Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 134FA2AB2B
	for <lists+linux-pm@lfdr.de>; Sun, 26 May 2019 18:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbfEZQ3g (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 26 May 2019 12:29:36 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39125 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbfEZQ3f (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 26 May 2019 12:29:35 -0400
Received: by mail-pl1-f194.google.com with SMTP id g9so6057548plm.6
        for <linux-pm@vger.kernel.org>; Sun, 26 May 2019 09:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1BqvJJeVVCvs0h+j3cS25Wx+bnAq+ov/vIwl8l2RLms=;
        b=BNLmADcNmNIb0xyZY4640jC68/vGLSOFkKRCsEnldzfXm8AvSwFH1rlc3vR88myTKT
         llk+6ct4c930HK0KJZ/jJH9epqKx46Oc4tKmEXN6XCAjM5OGwT3G4871cMVuGn+eXlHX
         JJK2CTcG9vo/If7fPsbwHngHLGuoRrQq7yuaKdPH7nUGR7q3YFGytJCkrjlLdpPkKuM6
         M+55b4KOSyZSmzyRTTx+vntGakn2p6MumwMnLDar7YM+ywS3pYNzrUUJlfunY6ZfK1V+
         20bUuxYk6H7PMNXfEW+2rmJpXR8xCIAhaTeXP2ydt2b/ftXXCVPUllWsC9OUWqmka15U
         ciug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1BqvJJeVVCvs0h+j3cS25Wx+bnAq+ov/vIwl8l2RLms=;
        b=Fvch4sZjtkvZtXQe8VQCLGiFT6tAi1DzpmPdQ7tdvomgdQYfb+QhVpuJsLKC8Wpzrt
         K7rhpB78cSXut0QnAZcg/Eh3RLYLq+rVClpS0gngnboKTevF5Ae68IZxmjEx7jM9787h
         t4Sbu+Aj4I+SdVQnrPAo4WzVBbdTvDzrGMk6HVbySmbZfBH+h0pVKIoeIuIWXAzcEo0i
         ZK59+HdRisHGKZv3Dcmx5zowULE/og+4JPoomy7ZzlrULQQdYQJPAU9DAf+hdkjf9/LL
         XRRarrhuC62TVMmYlW1E/eGL4r3fvccenfX/vSYnjE3LpzCa/5ek9NrX2SLTa1wsk/4t
         gJEw==
X-Gm-Message-State: APjAAAWKIMH25DzPCbfFhRvnQ7BfK021psHy8Wq9rLF6LqAazJjjGrAz
        9wi9LQsDji2tPSoX7dAQ1WGXdcXfbBk=
X-Google-Smtp-Source: APXvYqwcMnR13bWuM/qj//SA6dYy9/isqc4TFI68/tH71VAeSbjJ7Qdub2NSgkNp6mEoef7NjCATUA==
X-Received: by 2002:a17:902:4906:: with SMTP id u6mr22258670pld.220.1558888175361;
        Sun, 26 May 2019 09:29:35 -0700 (PDT)
Received: from mita-MS-7A45.lan ([240f:34:212d:1:3427:8c7f:94e8:c445])
        by smtp.gmail.com with ESMTPSA id a11sm8671107pff.128.2019.05.26.09.29.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 26 May 2019 09:29:34 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-nvme@lists.infradead.org, linux-pm@vger.kernel.org
Cc:     Keith Busch <keith.busch@intel.com>,
        Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH v3 1/3] nvme: Export get and set features
Date:   Mon, 27 May 2019 01:29:01 +0900
Message-Id: <1558888143-5121-2-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558888143-5121-1-git-send-email-akinobu.mita@gmail.com>
References: <1558888143-5121-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Keith Busch <keith.busch@intel.com>

Future use intends to make use of both, so export these functions. And
since their implementation is identical except for the opcode, provide a
new function that implement both.

[akinobu.mita@gmail.com>: fix line over 80 characters]
Signed-off-by: Keith Busch <keith.busch@intel.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 drivers/nvme/host/core.c | 24 +++++++++++++++++++++---
 drivers/nvme/host/nvme.h |  6 ++++++
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c6a29a3..c950916 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1113,15 +1113,15 @@ static struct nvme_id_ns *nvme_identify_ns(struct nvme_ctrl *ctrl,
 	return id;
 }
 
-static int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsigned dword11,
-		      void *buffer, size_t buflen, u32 *result)
+static int nvme_features(struct nvme_ctrl *dev, u8 op, unsigned int fid,
+		unsigned int dword11, void *buffer, size_t buflen, u32 *result)
 {
 	struct nvme_command c;
 	union nvme_result res;
 	int ret;
 
 	memset(&c, 0, sizeof(c));
-	c.features.opcode = nvme_admin_set_features;
+	c.features.opcode = op;
 	c.features.fid = cpu_to_le32(fid);
 	c.features.dword11 = cpu_to_le32(dword11);
 
@@ -1132,6 +1132,24 @@ static int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsigned dword
 	return ret;
 }
 
+int nvme_set_features(struct nvme_ctrl *dev, unsigned int fid,
+		      unsigned int dword11, void *buffer, size_t buflen,
+		      u32 *result)
+{
+	return nvme_features(dev, nvme_admin_set_features, fid, dword11, buffer,
+			     buflen, result);
+}
+EXPORT_SYMBOL_GPL(nvme_set_features);
+
+int nvme_get_features(struct nvme_ctrl *dev, unsigned int fid,
+		      unsigned int dword11, void *buffer, size_t buflen,
+		      u32 *result)
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
index de624ec..802aa19 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -460,6 +460,12 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		union nvme_result *result, void *buffer, unsigned bufflen,
 		unsigned timeout, int qid, int at_head,
 		blk_mq_req_flags_t flags, bool poll);
+int nvme_set_features(struct nvme_ctrl *dev, unsigned int fid,
+		      unsigned int dword11, void *buffer, size_t buflen,
+		      u32 *result);
+int nvme_get_features(struct nvme_ctrl *dev, unsigned int fid,
+		      unsigned int dword11, void *buffer, size_t buflen,
+		      u32 *result);
 int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count);
 void nvme_stop_keep_alive(struct nvme_ctrl *ctrl);
 int nvme_reset_ctrl(struct nvme_ctrl *ctrl);
-- 
2.7.4

