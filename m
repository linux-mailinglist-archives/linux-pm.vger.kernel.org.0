Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 192E522AAC7
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jul 2020 10:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbgGWIhk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Jul 2020 04:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbgGWIhj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jul 2020 04:37:39 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EF8C0619DC
        for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2020 01:37:39 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id q5so4313383wru.6
        for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2020 01:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h/yM4jsYCAifUDfs6hudfcj/emQNOmj9c2iS2RlrIxw=;
        b=Xpie9hxHzBq4jxqHPSf9F7wibwb3a9HP3clbkUc00eoy8pjV/W4Mf0LSEbRjtqH3bP
         dqPWckK3wfcmpHLj9Zw7KsVNCOWjFzwvairARL4+0e1ygnFpI7pNK/izhnUhBYEC2IYC
         HDgmGON72x4lKUZYVIferkCFvxag4hPQDBnJeXuFLjKJkJLOmHxi2MqnnPCcD4AbDdVP
         akwbkWbNQq0UeQtVH2kRjdzcRFBbGU3SGXGwopU3tp94lDumwBCLk4+zKOhqTwrTeBPH
         4Nx6D0VvaN8qHKyrcz1kCfel3ZNl5mMRqMx/ML11FX0CmmSjpSzYceyucs6iBKTYVO7K
         JA3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h/yM4jsYCAifUDfs6hudfcj/emQNOmj9c2iS2RlrIxw=;
        b=P/EJoJKBVUfFh6yPBzdGAAFXJ0QKb2yNOS+HU7Ttm9YkWCaT8rXDMR80bnH75dZbGA
         DEJHBfEMi6nT0YZJSb5lXgDFg/Pc2wqvBbp9lOPymQfKcO+3/ygZBmf0aS/iFRNCvrvM
         /BpBnO1lywQHauBodo+pGpny8/vfsU0I6imIKDy8R+saadHSQZgQb7Vx6+vAI2y6dod6
         GrzfPFg2TrX523Orr41ReJpuv4WhcYvJKnBXbyc7urrJPLtycIRJVUEXTBbW3Kz0Eq+c
         EIoaGGbtBx3xk6Cx2h8NxV6uoQiJ2gPlDl5fvjE5MPHJCDZz+KlO5WnFD/PddFY4OGiA
         u91A==
X-Gm-Message-State: AOAM533rLbHsh7EreuOHgcR3r1MzHI0DNwzBRcSXiCy2ler+AijbWs2w
        yn1ZPiLHmSuXxgd0JtctU4dUUTfla7M=
X-Google-Smtp-Source: ABdhPJz5TYIUOxOdMwwJ3R4WMNEjfODtAaiBr6SLeg0J5aER+9hW7ruo9M0zHJkynOvH+TQpUGelig==
X-Received: by 2002:adf:d1b2:: with SMTP id w18mr8808wrc.235.1595493457671;
        Thu, 23 Jul 2020 01:37:37 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id h11sm3105039wrb.68.2020.07.23.01.37.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jul 2020 01:37:37 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        georgi.djakov@linaro.org, Atul Dhudase <adhudase@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH 1/2] interconnect: Do not skip aggregation for disabled paths
Date:   Thu, 23 Jul 2020 11:37:34 +0300
Message-Id: <20200723083735.5616-2-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200723083735.5616-1-georgi.djakov@linaro.org>
References: <20200723083735.5616-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When an interconnect path is being disabled, currently we don't aggregate
the requests for it afterwards. But the re-aggregation step shouldn't be
skipped, as it may leave the nodes with outdated bandwidth data. This
outdated data may actually keep the path still enabled and prevent the
device from going into lower power states.

Reported-by: Atul Dhudase <adhudase@codeaurora.org>
Fixes: 7d374b209083 ("interconnect: Add helpers for enabling/disabling a path")
Reviewed-by: Sibi Sankar <sibis@codeaurora.org>
Tested-by: Atul Dhudase <adhudase@codeaurora.org>
Reviewed-by: Atul Dhudase <adhudase@codeaurora.org>
Link: https://lore.kernel.org/r/20200721120740.3436-1-georgi.djakov@linaro.org
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/core.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index e5f998744501..9e1ab701785c 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -243,6 +243,7 @@ static int aggregate_requests(struct icc_node *node)
 {
 	struct icc_provider *p = node->provider;
 	struct icc_req *r;
+	u32 avg_bw, peak_bw;
 
 	node->avg_bw = 0;
 	node->peak_bw = 0;
@@ -251,9 +252,14 @@ static int aggregate_requests(struct icc_node *node)
 		p->pre_aggregate(node);
 
 	hlist_for_each_entry(r, &node->req_list, req_node) {
-		if (!r->enabled)
-			continue;
-		p->aggregate(node, r->tag, r->avg_bw, r->peak_bw,
+		if (r->enabled) {
+			avg_bw = r->avg_bw;
+			peak_bw = r->peak_bw;
+		} else {
+			avg_bw = 0;
+			peak_bw = 0;
+		}
+		p->aggregate(node, r->tag, avg_bw, peak_bw,
 			     &node->avg_bw, &node->peak_bw);
 	}
 
