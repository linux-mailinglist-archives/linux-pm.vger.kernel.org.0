Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4753710ED0D
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2019 17:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbfLBQWA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Dec 2019 11:22:00 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37677 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727555AbfLBQVi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Dec 2019 11:21:38 -0500
Received: by mail-wr1-f65.google.com with SMTP id w15so14102509wru.4
        for <linux-pm@vger.kernel.org>; Mon, 02 Dec 2019 08:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i3hce8rncscuvP/l1ZHZTtieB5MS4JyYpc/T2PE+Kxk=;
        b=BE1Rz6vNXRg7sd9D4JsqoBEe+a6i+xNVBv+xt5suxCeM/F5EH1GxIAP5zZ8GnNiX8e
         SDyYr7SH0N/I5WLB8b3Z0n7DI7l62lJN3psAJGsLawlizXLVRQjLEYAVuI/uA/eGwosu
         4Y+oO0D1Ymr8GhkMET7OvboWgv9L7A+MWQEgSKOTv9OLFNNBX1DlgunxhAowoP1gbAhO
         OIQ9RJ+oaW67J5IzFVih/bd/+X8h2yJx/5lQFKxzOC4OVLi8NomZj03ZFGq9ob8p82Rt
         D8aa46nTbH5GZszd7+KPwWdSSS3jgclFK55df+IYNRP3jzdd8HAz7vfUGHRh7Ag/2wb0
         wFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i3hce8rncscuvP/l1ZHZTtieB5MS4JyYpc/T2PE+Kxk=;
        b=HasPuRbnrS0P+JaY8m4Cl5Sy4gA8MSdKLnWyR3tjda6WmkpIMqkWkTo/BDO3P7MdbP
         eyGO2RqU4783TLJ2HbcnPorWHhc78pueDDbH72qThZsEIl5FfOIro0kB1NPaPwqoJKHq
         iObW7rmh9cpb9f7q68CFWEkBUs9grWtWiXYxfitTar2ZTocLzMT4OtRswm7W51sfjHcl
         9dbHEsboty5whsF+Ps1ekBPhEfLfqmPNW1ZIIU1yQGfS3Q8fLKAubN5VOzzcYT1DxWYo
         fKaJ4ayr8LN3EEuBtka1x/A0VDMLtEqEuSxCk3Q7dt1q/Bx9Vh+dLMPH35vy7W+t1mbW
         VaVg==
X-Gm-Message-State: APjAAAXXR5DenTYzw1F+/fwbA00ewgFakfcQ8xe/uvCiKbMvvDOT3NFK
        qIHCJ5Uai5/aiwsQjkO1U/snUZr+gqc=
X-Google-Smtp-Source: APXvYqwca+igLoFKmAl2TQAB5hPhndZpQ1iKhmD5Qq2qjfwBwaXa2POHL77PR9uX+Zd/EezhjWLc5Q==
X-Received: by 2002:adf:b19a:: with SMTP id q26mr25103318wra.79.1575303696450;
        Mon, 02 Dec 2019 08:21:36 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id i9sm39204516wrb.2.2019.12.02.08.21.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Dec 2019 08:21:35 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org, digetx@gmail.com,
        evgreen@chromium.org, daidavid1@codeaurora.org,
        masneyb@onstation.org, sibis@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH v2 1/5] interconnect: qcom: sdm845: Walk the list safely on node removal
Date:   Mon,  2 Dec 2019 18:21:29 +0200
Message-Id: <20191202162133.7089-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.24.0
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
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
v2:
- Fix the number of parameters that got messed up. (Bjorn)

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
