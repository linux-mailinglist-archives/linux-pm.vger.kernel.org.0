Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 720C7251DC0
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 19:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgHYRCc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Aug 2020 13:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbgHYRB5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Aug 2020 13:01:57 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77DDC061786
        for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2020 10:01:56 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id b17so12707723wru.2
        for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2020 10:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QNXnwR9p0uhARPXD5IdPdhRimuwkBpCRHZXkkYzIxeQ=;
        b=meuU0Zkwwy7TRrTbdm6LUcRa5e3YU5RgQBubXJ47ZT+Lsi5779G+F1X6eYeme2O5ZK
         p2YXUVA6EPBOQJ8xCp+iAq2xzLrx7ZKTIVrya5CPfG16nKyhpqBoYZgvIxvm/5K6Z2r+
         78/DCncRswMvj1HScNrlpYXIKlojHDrvV4lbdROLjNgQmsOqTzU7CCGF1OeJzpJauMJw
         dyqSZ/VXsQS0r5Nd4I+aB01EtTbUVdKSOe9ikHjB4+c1fu583F6SwzIn8WMgR0rZ95Hl
         QJdygPc1CUeEDPE9zxO72ecB2l+o4UkJTKXeXJT1vAMzMMn/x/zn5KC51P70XrXvFdPP
         r45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QNXnwR9p0uhARPXD5IdPdhRimuwkBpCRHZXkkYzIxeQ=;
        b=L50vz/mFqKaI0QbgxEKjMhVJkpIGif5CJEh5kAuhkb0ZvR5UNyR7Tlqt1jQNGMB64v
         +wYFFfB1SBktEM/wY8CS6lwwvtEPr8Y6eEUuP14jBNXTIbPRtpI14yn3WFj17uObFR27
         +KOTVqZLH6dMUrxU5aSYhpfFsD43/wla0LaTRcyVVfrhhuRzglARDsdwt0f9n+DQbPHD
         lgjjgInvyCnNIXy0I4/aiK6rOhLABGJetl5FPl62So1WfFtvT0LvD8nj/fYoSri6Y/EG
         LShf3qwGPz3nT6caSj2rgTB0pQ1akTPY4yVsXqFRfmB7xmvR3n3CiCuBPqvypFHvM0Mg
         TqHg==
X-Gm-Message-State: AOAM530cdxdVcNkoB4bVBRpbLy89bYMtw/M7EGYsJmr49VYqS6olxeNO
        T/QscEODiN4+YEgu1A1ASueGEJvqg1meXA==
X-Google-Smtp-Source: ABdhPJygtIjUoGytXl0pS2x7kihR5qpo/+T9Ab3cspeev/uMhVEEZfjD6nvOU54rZeDnoPpVpNhnRA==
X-Received: by 2002:adf:e78e:: with SMTP id n14mr10900629wrm.357.1598374915151;
        Tue, 25 Aug 2020 10:01:55 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id y17sm6669008wma.17.2020.08.25.10.01.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Aug 2020 10:01:54 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     saravanak@google.com, mdtipton@codeaurora.org,
        okukatla@codeaurora.org, bjorn.andersson@linaro.org,
        vincent.guittot@linaro.org, akashast@codeaurora.org,
        georgi.djakov@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] interconnect: Add get_bw() callback
Date:   Tue, 25 Aug 2020 20:01:50 +0300
Message-Id: <20200825170152.6434-2-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200825170152.6434-1-georgi.djakov@linaro.org>
References: <20200825170152.6434-1-georgi.djakov@linaro.org>
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
 include/linux/interconnect-provider.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/interconnect-provider.h b/include/linux/interconnect-provider.h
index 4735518de515..520f70fe5a31 100644
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
@@ -51,6 +52,7 @@ struct icc_provider {
 	int (*aggregate)(struct icc_node *node, u32 tag, u32 avg_bw,
 			 u32 peak_bw, u32 *agg_avg, u32 *agg_peak);
 	void (*pre_aggregate)(struct icc_node *node);
+	int (*get_bw)(struct icc_node *node, u32 *avg, u32 *peak);
 	struct icc_node* (*xlate)(struct of_phandle_args *spec, void *data);
 	struct device		*dev;
 	int			users;
