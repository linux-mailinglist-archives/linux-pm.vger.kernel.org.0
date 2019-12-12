Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2507611C6BA
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2019 08:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbfLLHxz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Dec 2019 02:53:55 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43629 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbfLLHxh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Dec 2019 02:53:37 -0500
Received: by mail-wr1-f66.google.com with SMTP id d16so1570581wre.10
        for <linux-pm@vger.kernel.org>; Wed, 11 Dec 2019 23:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y0w6MnW3oZvs4i15UPLA0/120XiFldb3t4/pTdGFLw0=;
        b=E6CVo+lYFHxy1yyahd2inU7r/9j3l2DqXTlgipfrVkba/Jl2TfefTcPbRpdk8V0joZ
         RrByorq//rGjnAx9dl6Ds8d1hVHQMVMJhvfdTct0nw8PWLMrJaKjYptNvapLIHAVomiz
         htwxe3N2JqfqGEKKiwiKorD6j6mdVm2KOQ0LcE2wIhLBC95mCMriqAdgeqfUuFHLYPRG
         W2nGPHGhJftyqpmKGwVDVn2lyCd5W+kjHCKKGS2g/LmLrLlb6lKDCxtXaXGsTF1cPYXR
         Yf9L/yBYDWcK+0GKQScCuQCENTeoDQoNRHAP1miPGeCYcuScpp8xi3XL/JJ+p+ctcJ0W
         z9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y0w6MnW3oZvs4i15UPLA0/120XiFldb3t4/pTdGFLw0=;
        b=WpFIwKfgazpiO6cJElscunKCwEgyrGJe3G8f8MrCBLJDUNSoRfQzd4nwoaPadH/oE4
         V9vJ3vjDAkcYcht1m/8Et7mzTBPcr5Cub6AJT2t0j96ieSXzmnbAyII3nDUTIRn8+ZRh
         9YB2lz/dNKkAOBS26dSuwuqiT4TwTtmNwMghIop+tpUfKNOhvHOtnvFC4HFZEu6st2Rn
         z3z1kpij9rl1H1tWydXHITeFbijn/85YDtKS4HnszTqQ50fP9qBFO23Vqvro8m5nbywO
         GaKR49jN3sSGG9GZktLTFZV9MH9a+cmmdkn8XZP/joZCxea2bzFbhM56N8CHlceGBLEg
         Ft4A==
X-Gm-Message-State: APjAAAVNlaVO7jvZEIHzpTx5GpoY8K+aSj5ckh2W5HZaq/aRdyZluT6Y
        xrmKiggBhLTL2xy3sOqlcDqXgg==
X-Google-Smtp-Source: APXvYqwytfBf126ULinW5oFqdBQeWvCz2VVUAU2XhFKvinoMG4AvjJx0JLgTIa8YEq6lsKANcL889Q==
X-Received: by 2002:a5d:5708:: with SMTP id a8mr4838423wrv.79.1576137215643;
        Wed, 11 Dec 2019 23:53:35 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id x6sm5636742wmi.44.2019.12.11.23.53.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Dec 2019 23:53:35 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH 2/4] interconnect: qcom: sdm845: Walk the list safely on node removal
Date:   Thu, 12 Dec 2019 09:53:30 +0200
Message-Id: <20191212075332.16202-3-georgi.djakov@linaro.org>
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

Fixes: b5d2f741077a ("interconnect: qcom: Add sdm845 interconnect provider driver")
Reported-by: Dmitry Osipenko <digetx@gmail.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
Cc: <stable@vger.kernel.org> # v5.3+
---
 drivers/interconnect/qcom/sdm845.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
index 502a6c22b41e..387267ee9648 100644
--- a/drivers/interconnect/qcom/sdm845.c
+++ b/drivers/interconnect/qcom/sdm845.c
@@ -868,9 +868,9 @@ static int qnoc_remove(struct platform_device *pdev)
 {
 	struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
 	struct icc_provider *provider = &qp->provider;
-	struct icc_node *n;
+	struct icc_node *n, *tmp;
 
-	list_for_each_entry(n, &provider->nodes, node_list) {
+	list_for_each_entry_safe(n, tmp, &provider->nodes, node_list) {
 		icc_node_del(n);
 		icc_node_destroy(n->id);
 	}
