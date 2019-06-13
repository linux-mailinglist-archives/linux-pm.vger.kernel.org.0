Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84C9443A73
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2019 17:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732104AbfFMPVP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Jun 2019 11:21:15 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38486 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732078AbfFMPUz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Jun 2019 11:20:55 -0400
Received: by mail-pf1-f193.google.com with SMTP id a186so12049472pfa.5
        for <linux-pm@vger.kernel.org>; Thu, 13 Jun 2019 08:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8OmPO/eHJbUrIaHIx1TwZNS7VwjUu85zkfJ8NN4LaHM=;
        b=P45WYDk7n3DFpbQgGzihriYhk5YcQjHctVcI0423tKzzQWQ4jf978jTWyrzeA2jaWW
         Od+JF5SIbrsEIQYT7cDVrNO9vGIVyNKHCAiMA0XX6dLf/OjMBJ/kBtNIbqlwNCTDXmWg
         vZOHQtSMmuPRZR0ubqReoIt6QBiZ/L3fIiRmsdwDQclDODQCYtbWro3iLSws4yfW/CW0
         5lnEQTKAnCajC2t8e9rrVq1YIAN+wHen6gy0DSNYOG11Fcbeng3xxuqgTqORjrHECETw
         Hb9BlG53+XXgAkDBv43Dp97+F5StNj5KQ29XWpv49QuEV+SLYsgtZWAfLeaXWZTwYTbd
         zFlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8OmPO/eHJbUrIaHIx1TwZNS7VwjUu85zkfJ8NN4LaHM=;
        b=lQBLybRsAhSQh/s7sBCOAYlXsS+k8KGvx6RawmhD3pi6wQpWw2W4HF+nzAuHpViPDG
         yZ4EsHwYcUWHUe6NKtHMAyvqI/rp0sFeLLboqEebt7TjSukIF9ZfYMW05Q8AmpRWQstb
         OyS0DY+DuWFj53ptvCgWcgBa8sxvQBWVPZ6Bfbo7xS8PFsjG2/ZGA1g5wmWmW3FD3OGU
         HwEm74ayxM9+RtBNpa1EVnVcVSTl8TvLLSHrLf9GESWJ2uXddvPLgxfbSOYdZf/mhOd4
         UGUuw2KptazWgN4Oj3L74SLcJEzL47OF1CF0uAmnFOHhzD4VhD2Sq7x+EAmaKN0q5Md1
         7G9g==
X-Gm-Message-State: APjAAAXBnh0GiztG6pDM4wbGGhQG60ffVN1OHGiJ5mE8bvvVUI4Zvrsl
        Hw8ohIWxfpUiHtnpUfUl4QE=
X-Google-Smtp-Source: APXvYqyFOyby9WANnjddgrH7WxB0cc/U4wmWWqqDVIhsFKKlhiCMshhDja9qc0wLnc/+V2OTxZAmdQ==
X-Received: by 2002:a17:90a:a397:: with SMTP id x23mr6302485pjp.118.1560439255098;
        Thu, 13 Jun 2019 08:20:55 -0700 (PDT)
Received: from mita-MS-7A45.lan ([240f:34:212d:1:1b24:991b:df50:ea3f])
        by smtp.gmail.com with ESMTPSA id n66sm40988pfn.52.2019.06.13.08.20.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Jun 2019 08:20:54 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-nvme@lists.infradead.org, linux-pm@vger.kernel.org
Cc:     Keith Busch <keith.busch@intel.com>,
        Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH v4 1/3] nvme: Export get and set features
Date:   Fri, 14 Jun 2019 00:20:36 +0900
Message-Id: <1560439238-4054-2-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560439238-4054-1-git-send-email-akinobu.mita@gmail.com>
References: <1560439238-4054-1-git-send-email-akinobu.mita@gmail.com>
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
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 drivers/nvme/host/core.c | 24 +++++++++++++++++++++---
 drivers/nvme/host/nvme.h |  6 ++++++
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 120fb59..7e3c786 100644
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
index 55553d2..038b893 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -459,6 +459,12 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
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

