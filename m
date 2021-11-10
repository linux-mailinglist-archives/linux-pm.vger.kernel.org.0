Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B80444C0CF
	for <lists+linux-pm@lfdr.de>; Wed, 10 Nov 2021 13:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbhKJMK3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Nov 2021 07:10:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbhKJMK2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Nov 2021 07:10:28 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A53C0613F5
        for <linux-pm@vger.kernel.org>; Wed, 10 Nov 2021 04:07:40 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id gx15-20020a17090b124f00b001a695f3734aso1498633pjb.0
        for <linux-pm@vger.kernel.org>; Wed, 10 Nov 2021 04:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vrS5M6DytZl+EPmdclSiBMyMOC/Af23DduwHTH7/9D0=;
        b=Rwk1udxw2fKYWYWZ1wXnFxsUS/uO0F4zBtFNYea4OotNOmg0CE4M977FPQoGlHjD9U
         J/+hQmAd6MrCHRgJFpsFvU39/97sv51bHnSNT0L13TkoQIWpUfdP2hYNLlZtqabHblqa
         eLkoSH079GXwnZ9qEOosnTR4nsMncBCsovP3jZbi1rjs+79vcphzhnQ1lqtDI/UGtvEK
         Ng7cKJC9VtZr+rg51SnLY4MnX3ls8C+5SvacO5PmyGicwjVdDbjdjIplA83AH6Wq2naL
         j1maXQRphKH6In8Py+++5KX+W8IboP2HMSvxCB9Gi2ghcD8RNotrxpQyzqJr+3VAJ07g
         g+6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vrS5M6DytZl+EPmdclSiBMyMOC/Af23DduwHTH7/9D0=;
        b=o1ID7h3rqkD05BDR5SW/JbAjB1F7+VZe6Itb9sm6lL9wgQSvGe6YvezRoSIHNm5ABf
         2uR36YFP25fzYDQTcr3k/Qc7e9QgFc9oJqGoNA+GZVAsqdqVLmqE+5IpWbBn0BZaJTGV
         Z4d729WqjVXu+x60Nr54Lf29A0nwxoMQqMWXq4wb2qQIa/lIs732/3U9D+OWvbOOV6Vc
         +5nV0t15GiWl+FBHGWkQsfqNqo5lpDxFCDA+YLWKQ1ZMuyzyEduiP2xyqi7s9XDKw5Qe
         yuuosCZ0Nad4SWvHRaEAFFFAceXY6zWl16xc1zEKpVgP951OoaEkQts3C7GQRnY4v+rR
         ialQ==
X-Gm-Message-State: AOAM532c0LaESWWHRjrAsbpOeq7VSul5hknbvglWcjRevaAJ3osvrKrB
        M0Uu4T9oN4tnPOmTsvfrGmZ02Q==
X-Google-Smtp-Source: ABdhPJyZbM/zwgPDkjROMNaQpjYIu6UKjDq6TTuDH8OCporRm7EezlYQsZvQipqcgthMJm9irK4B7Q==
X-Received: by 2002:a17:90b:3d3:: with SMTP id go19mr16403914pjb.23.1636546060335;
        Wed, 10 Nov 2021 04:07:40 -0800 (PST)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id g9sm8377914pfc.182.2021.11.10.04.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 04:07:40 -0800 (PST)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 1/6] interconnect: icc-rpm: Use NOC_QOS_MODE_INVALID for qos_mode check
Date:   Wed, 10 Nov 2021 20:07:11 +0800
Message-Id: <20211110120716.6401-2-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211110120716.6401-1-shawn.guo@linaro.org>
References: <20211110120716.6401-1-shawn.guo@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use NOC_QOS_MODE_INVALID for invalid qos_mode check to improve the
readability.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index ef7999a08c8b..35888721a690 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -76,7 +76,7 @@ static int qcom_icc_set_bimc_qos(struct icc_node *src, u64 max_bw)
 	provider = src->provider;
 	qp = to_qcom_provider(provider);
 
-	if (qn->qos.qos_mode != -1)
+	if (qn->qos.qos_mode != NOC_QOS_MODE_INVALID)
 		mode = qn->qos.qos_mode;
 
 	/* QoS Priority: The QoS Health parameters are getting considered
@@ -137,7 +137,7 @@ static int qcom_icc_set_noc_qos(struct icc_node *src, u64 max_bw)
 		return 0;
 	}
 
-	if (qn->qos.qos_mode != -1)
+	if (qn->qos.qos_mode != NOC_QOS_MODE_INVALID)
 		mode = qn->qos.qos_mode;
 
 	if (mode == NOC_QOS_MODE_FIXED) {
-- 
2.17.1

