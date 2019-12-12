Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFC511C6B5
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2019 08:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbfLLHxl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Dec 2019 02:53:41 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38224 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728202AbfLLHxj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Dec 2019 02:53:39 -0500
Received: by mail-wr1-f65.google.com with SMTP id y17so1604106wrh.5
        for <linux-pm@vger.kernel.org>; Wed, 11 Dec 2019 23:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L7tBmXs8szR5coP2QPrIYVtp6Vuz4hm1y2XfuDFevyM=;
        b=Kr+KUFJNBXKZ6arLp7UE3PERZN82b7n76/zlZDLkUpneYqY1PlQefWZYnLdmknkRl9
         HoH8gkaIpCmD33VV4YTrIflwwLBELrHVheSzqqa3J/PWyeLNzGzVGQPqU9HRUPP7QC2O
         Fr4dwQfTrmWSmrX+OuF3XbJUOUO7OJt0ANf+89QLKhqt5huFkZnT0vF0Qgn2Sa5B1bf9
         pqMhCG/4EanSoyZpSC5X/H2FLj6SPEeyBlBGBctaWcXeKOhGOiEy8dR74wZbsciAEQLW
         bNka3AnfcEA+razqnulyyZDR9SLHWBVDWbjBqegStGryfu/Km6BBERbAp1Wpj0YWk7Nn
         fmAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L7tBmXs8szR5coP2QPrIYVtp6Vuz4hm1y2XfuDFevyM=;
        b=KtjXbWTQGt5Ui1HevFth9vKpgqK2FfxH6Rs9FBWqYFR72jbqhj6myaqNpEeHngzLus
         /d6eoNoDMNHGk6QuTF/FdXkIp860Ua9dAhN66X0+N/014pYVvvsEv6D+mSJ4VWtzda3S
         eCQ6fmOz2kJMLwvyk6NsvYVRnAqsLuGNNYhMtq3+V4eyMJ8Q4Kj8trVX99dc5G46vB8G
         +TwBAwi4mV8QrPrkAi1qpn27Hj5xofRJtFxtQWujUt8EHIuaqTHlTskEUUrZGtgJASrg
         /wMj90+GQ5WMmQF1FvbCZNQU08GsHLnvxFM552/2UOu7aVFHEMXnyy2877Jvl0E+ztf+
         9Ckg==
X-Gm-Message-State: APjAAAVueRnU0oMsPzaAquc42aWxddR0yOwd629+2dNSFIHLDOB+NwuF
        Mlb6ZWLXOJoNQNarZ0iWznELXw==
X-Google-Smtp-Source: APXvYqwUcXHovOEUWwZs2zVMXRBYn/LxMi6Qcnji64Gr+n8eHVr8u6yV+0K7vpOXoZ6kWZzhfYl3Sw==
X-Received: by 2002:a5d:53d1:: with SMTP id a17mr4430038wrw.327.1576137217821;
        Wed, 11 Dec 2019 23:53:37 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id x6sm5636742wmi.44.2019.12.11.23.53.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Dec 2019 23:53:37 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 4/4] interconnect: qcom: msm8974: Walk the list safely on node removal
Date:   Thu, 12 Dec 2019 09:53:32 +0200
Message-Id: <20191212075332.16202-5-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191212075332.16202-1-georgi.djakov@linaro.org>
References: <20191212075332.16202-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

As we will remove items off the list using list_del(), we need to use the
safe version of list_for_each_entry().

Fixes: 4e60a9568dc6 ("interconnect: qcom: add msm8974 driver")
Reported-by: Dmitry Osipenko <digetx@gmail.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/qcom/msm8974.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/interconnect/qcom/msm8974.c b/drivers/interconnect/qcom/msm8974.c
index ce599a0c83d9..bf8bd1aee358 100644
--- a/drivers/interconnect/qcom/msm8974.c
+++ b/drivers/interconnect/qcom/msm8974.c
@@ -652,7 +652,7 @@ static int msm8974_icc_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct icc_onecell_data *data;
 	struct icc_provider *provider;
-	struct icc_node *node;
+	struct icc_node *node, *tmp;
 	size_t num_nodes, i;
 	int ret;
 
@@ -732,7 +732,7 @@ static int msm8974_icc_probe(struct platform_device *pdev)
 	return 0;
 
 err_del_icc:
-	list_for_each_entry(node, &provider->nodes, node_list) {
+	list_for_each_entry_safe(node, tmp, &provider->nodes, node_list) {
 		icc_node_del(node);
 		icc_node_destroy(node->id);
 	}
@@ -748,9 +748,9 @@ static int msm8974_icc_remove(struct platform_device *pdev)
 {
 	struct msm8974_icc_provider *qp = platform_get_drvdata(pdev);
 	struct icc_provider *provider = &qp->provider;
-	struct icc_node *n;
+	struct icc_node *n, *tmp;
 
-	list_for_each_entry(n, &provider->nodes, node_list) {
+	list_for_each_entry_safe(n, tmp, &provider->nodes, node_list) {
 		icc_node_del(n);
 		icc_node_destroy(n->id);
 	}
