Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A73CA23DF8C
	for <lists+linux-pm@lfdr.de>; Thu,  6 Aug 2020 19:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgHFQe0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Aug 2020 12:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727990AbgHFQcl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Aug 2020 12:32:41 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047D0C02B8CB
        for <linux-pm@vger.kernel.org>; Thu,  6 Aug 2020 09:31:40 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k20so10269098wmi.5
        for <linux-pm@vger.kernel.org>; Thu, 06 Aug 2020 09:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dKzq9Wd5pDbV7/549EiQnkURmwLmMM//csWdIgiebW8=;
        b=EsdDtrFjKUuP/BZmW1CY5RL5QUtFRm/t/YE3QvhQTdrk+YOX9tnzBC0latfyhTZ9qs
         8KVYxu0ZlruiLUWI7IrSEYLEbcvX+H/yQUkSk56XHjCmwPye4lptZc3A7zxEL3YVLafU
         OItNjT8dnLBMs0XhcMFYcZq0GiyQomjZYUiQo48M2GPS2efmgAiiNfAYw12pXJAJJ96X
         2tCA1N8q8YLHEMMZIlbGu516lKAlTucgsDZIpq8USikP4h2IQNYQSF7mBkp9UXgGBJbe
         6wIk2DN0bfrxIP8fSAAqEcW/aCl+LyJurk/yEfc9Mup+DUwPz5A9aJpNxU1+fE54GMHT
         T+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dKzq9Wd5pDbV7/549EiQnkURmwLmMM//csWdIgiebW8=;
        b=Pa0B5FdvWBzKaH1sLJ3XJr1c6PcWsa9JQWSKPAYT0ugi1wGPApz5QbGYwANeEKqbjZ
         5iTyWnKO3sHOYRdYCcI9F948cdeEx1vw6Lxkz/vb6JbdPCNQrNsfiSKbdoDfkhwmgQR8
         7FLdhy0f0cnPHS94nrLDCqRl+hmDO30surS7XkMpn+iPMA87oEgyTIfguoAS3lh4kDGy
         X6H7qI+Hc8PbhXZRLK0POsWhg94F5tl7O0AIEbea2MyVzOBmxwyP9qACbUp8ALC+QIWV
         4ZHYAVlQ1mNIXGg2jRj0iey042t+/RKhpr1cQl/Xruck0Qy/jG9MpBOBwZwGbiKIuIyM
         tSkg==
X-Gm-Message-State: AOAM531BzQW2JnTYqH+EezL8CBvaB9gEwmpgp2xEko7X65WCdoy56FCX
        RgwcDK1YMaty6xCG3l8/5XShhUNNpUs=
X-Google-Smtp-Source: ABdhPJxZbZm/odYmDQ8DR2AOCKo6562W7Nk3ONEMqBOj1UV79/ieFMlhXi0Nu7sq8tAmdAKGm7E9jg==
X-Received: by 2002:a1c:18b:: with SMTP id 133mr8721197wmb.178.1596731498457;
        Thu, 06 Aug 2020 09:31:38 -0700 (PDT)
Received: from localhost.localdomain ([87.120.218.65])
        by smtp.googlemail.com with ESMTPSA id i66sm7468537wma.35.2020.08.06.09.31.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Aug 2020 09:31:37 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org, bjorn.andersson@linaro.org,
        sibis@codeaurora.org, mka@chromium.org, dianders@chromium.org,
        georgi.djakov@linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/7] interconnect: qcom: sc7180: Replace xlate with xlate_extended
Date:   Thu,  6 Aug 2020 19:31:25 +0300
Message-Id: <20200806163126.22667-7-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200806163126.22667-1-georgi.djakov@linaro.org>
References: <20200806163126.22667-1-georgi.djakov@linaro.org>
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
Tested-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
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
 
