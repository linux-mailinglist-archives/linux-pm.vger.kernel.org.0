Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E755219ECC
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jul 2020 13:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgGILHQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jul 2020 07:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727798AbgGILHO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jul 2020 07:07:14 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B40C08C5DC
        for <linux-pm@vger.kernel.org>; Thu,  9 Jul 2020 04:07:13 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f2so1879863wrp.7
        for <linux-pm@vger.kernel.org>; Thu, 09 Jul 2020 04:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QO3JZKihtso+39nMH2ykv6IniQvYNe/2WheGTzYpPuE=;
        b=miAQ6xvFBcDyc81YMANaoJ8Vj2T+Y6Y4oRgP4DbaKNUZ60jc3Qw5eTnj/8OtFHT9Fw
         uUD2LrGi6v1GF4Ec9zvV9DwiO0ym1tgQmXcJancBs4W3QengAkduEuW2v+fTrFqqgsge
         G84AfYwE3GEp4Tx18wngoP8y20BwEbFYuJX6g5vqabGW7kTrWJGHebcQr6b1w3zwCWep
         ibchTQ4ucOuKtxwNWcEd/nHpzH5hUsk+hz3y1WIx/0veCqUpm7l3n3lcnj7ArlyPkBOx
         U0XpHZsh+Z1vVze0HNdaJH4fut7gQ6KAUayCYYNsTzUIPEGZmyb8kVfeD9wmZ5EWCoYD
         MaFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QO3JZKihtso+39nMH2ykv6IniQvYNe/2WheGTzYpPuE=;
        b=RVO02XQxVb1U70LY2kcwvnGkkZOLl+MKdhrOGT48UfUAboHibrL6AQR0m35UQPGHmu
         6FIyPJ0M+bpVQ7HGShNKILCJHOAPV8utz2IMEnJPvQkzfMOh+VtXvEuD5MvyTpw3iRpT
         Qo3GuKEYkMeZLwEpQ1cKw+9U5eXtSBToqKSz6E054adhB0zvKskh3eCgxeUJRqa9CZ7H
         8zoIVXpflrJCtsY6DRIITgD+WV3pQLQv538jtbLLqs/2GnjzPcu6fW90syqIN1yr/65V
         FaYVb4a4mTA0u0B41+JzR+p5SfnpbG1zW/mpZxKl3c0EVnapMcWu057PliZNqtHwSHFW
         TeyA==
X-Gm-Message-State: AOAM531wFtMpzRTufpUoWXXH6FhiDB1RTPe/9vL2v6u2svu1aYzqfqN9
        6sYkhVri9gqTG/4OlHwKPmmwdElILg4=
X-Google-Smtp-Source: ABdhPJycuHP4XE2SNs40fwWrwO9C5q8Tgb1PQeOiKtcis5BE5sARpF1cQMXUcm3zUnHxLMZQhSYXig==
X-Received: by 2002:adf:e944:: with SMTP id m4mr64207464wrn.252.1594292832314;
        Thu, 09 Jul 2020 04:07:12 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id q7sm5375578wrs.27.2020.07.09.04.07.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jul 2020 04:07:11 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     saravanak@google.com, mdtipton@codeaurora.org,
        okukatla@codeaurora.org, bjorn.andersson@linaro.org,
        vincent.guittot@linaro.org, georgi.djakov@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] interconnect: Add get_bw() callback
Date:   Thu,  9 Jul 2020 14:07:03 +0300
Message-Id: <20200709110705.30359-3-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200709110705.30359-1-georgi.djakov@linaro.org>
References: <20200709110705.30359-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The interconnect controller hardware may support querying the current
bandwidth settings, so add a callback for providers to implement this
functionality if supported.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/core.c           | 3 ++-
 include/linux/interconnect-provider.h | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index e53adfee1ee3..edbfe8380e83 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -926,7 +926,8 @@ void icc_node_add(struct icc_node *node, struct icc_provider *provider)
 	list_add_tail(&node->node_list, &provider->nodes);
 
 	/* get the bandwidth value and sync it with the hardware */
-	if (node->init_bw && provider->set) {
+	if (provider->get_bw && provider->set) {
+		provider->get_bw(node, &node->init_bw);
 		node->peak_bw = node->init_bw;
 		provider->set(node, node);
 	}
diff --git a/include/linux/interconnect-provider.h b/include/linux/interconnect-provider.h
index 153fb7616f96..329eccb19f58 100644
--- a/include/linux/interconnect-provider.h
+++ b/include/linux/interconnect-provider.h
@@ -38,6 +38,7 @@ struct icc_node *of_icc_xlate_onecell(struct of_phandle_args *spec,
  * @aggregate: pointer to device specific aggregate operation function
  * @pre_aggregate: pointer to device specific function that is called
  *		   before the aggregation begins (optional)
+ * @get_bw: pointer to device specific function to get current bandwidth
  * @xlate: provider-specific callback for mapping nodes from phandle arguments
  * @dev: the device this interconnect provider belongs to
  * @users: count of active users
@@ -50,6 +51,7 @@ struct icc_provider {
 	int (*aggregate)(struct icc_node *node, u32 tag, u32 avg_bw,
 			 u32 peak_bw, u32 *agg_avg, u32 *agg_peak);
 	void (*pre_aggregate)(struct icc_node *node);
+	int (*get_bw)(struct icc_node *node, u32 *bw);
 	struct icc_node* (*xlate)(struct of_phandle_args *spec, void *data);
 	struct device		*dev;
 	int			users;
