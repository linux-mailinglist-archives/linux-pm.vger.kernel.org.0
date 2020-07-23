Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9874122B003
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jul 2020 15:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbgGWNJw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Jul 2020 09:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729049AbgGWNJv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jul 2020 09:09:51 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8ECC0619E3
        for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2020 06:09:50 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id j18so4902177wmi.3
        for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2020 06:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7y9euSqb4UGhv5UE5N0M42WZpX+QG1MkkSdfq84u7II=;
        b=LnqX/B+IKmVX2RArreUfFVmrhFZbjMs43s5s/Re0yMQin/P7W7DMXO5aQqvpdNLc25
         D+eouaQzVbL38f7M7n1PTxjkg7eerQo5VDUPEk4MfCaTXKaudatcACmgt7CZuGJnyj2a
         zTmT38T4D9GCe34bm+EiW+LHAHd/jzfCH42D1aowE1FzS9Sj4CaNeV08jgh5fkDM7rhh
         VgHrikYgqxAYY4v/8dG/lR+LVMKd6keNykp3pYdE/hEb+bucctOOIxbG/j/o2SGMu4S0
         M2nZB69lADpVWpyXj1sCVMGOCQ2sKU9SPVMBi2ZZ4YtfpX34MsHF77GFh2LJ5NxtPb6w
         T33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7y9euSqb4UGhv5UE5N0M42WZpX+QG1MkkSdfq84u7II=;
        b=ZVSe00r7Di36/KI8L59P08gfmuXGdgNTpjQinIj+ssbch18d1L9rPBILU77RJLiaMi
         +vsZya2f9wyI6rcVtCuodWI0CLsmluEGjXswO3RxBZF+jir6fsyNU510Xt06LC9O4RJf
         HUQQoV0CITjoCq84nmRk0zDttOpOTxjBO/Ui4yjaoSOsZJu/tH25OidP2mpcgUxNNIZd
         PG2KJN2P+XCAAOECtePJcEpWrGP5/Y+DBjXXFW9Nl3L2pFlghFcj/eIZjw7MAJAMeXSC
         ID0jxUFAjfgGTiBuiGKKgObEEJdlKTKuaWAeG9Ut8DJOqytsODe1BEdS680ma0qGbuWS
         Bx9A==
X-Gm-Message-State: AOAM531cJd3Jmotu+ELDht1DdH+Gs6mtnbgWC728fK1iiNxtTCdGnr4x
        qAeWmEj3BOiDdG85mSprZlLdvLVAF0g=
X-Google-Smtp-Source: ABdhPJws1JRS1xbOTd3gpqfPFZSxS071Z+dp2hlmrwJ8beTF4BZPvFsrO0Z0JrnTCmdqM6cCEKt0UQ==
X-Received: by 2002:a1c:7d81:: with SMTP id y123mr1735724wmc.87.1595509788745;
        Thu, 23 Jul 2020 06:09:48 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id w7sm3594632wmc.32.2020.07.23.06.09.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jul 2020 06:09:48 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        sibis@codeaurora.org, mka@chromium.org, dianders@chromium.org,
        georgi.djakov@linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] interconnect: qcom: sc7180: Replace xlate with xlate_extended
Date:   Thu, 23 Jul 2020 16:09:41 +0300
Message-Id: <20200723130942.28491-6-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200723130942.28491-1-georgi.djakov@linaro.org>
References: <20200723130942.28491-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Sibi Sankar <sibis@codeaurora.org>

Use the qcom_icc_xlate_extended() in order to parse tags, that are
specified as an additional arguments to the path endpoints in DT.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/qcom/sc7180.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/sc7180.c b/drivers/interconnect/qcom/sc7180.c
index dcf493d07928..a6f119f363b1 100644
--- a/drivers/interconnect/qcom/sc7180.c
+++ b/drivers/interconnect/qcom/sc7180.c
@@ -535,7 +535,7 @@ static int qnoc_probe(struct platform_device *pdev)
 	provider->set = qcom_icc_set;
 	provider->pre_aggregate = qcom_icc_pre_aggregate;
 	provider->aggregate = qcom_icc_aggregate;
-	provider->xlate = of_icc_xlate_onecell;
+	provider->xlate_extended = qcom_icc_xlate_extended;
 	INIT_LIST_HEAD(&provider->nodes);
 	provider->data = data;
 
