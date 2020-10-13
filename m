Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96B3E28CFA6
	for <lists+linux-pm@lfdr.de>; Tue, 13 Oct 2020 15:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388132AbgJMN7O (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Oct 2020 09:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387819AbgJMN7O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Oct 2020 09:59:14 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C935C0613D2
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2020 06:59:14 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id a72so23696wme.5
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2020 06:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xYqWuTW/0Vb6gGlVF7Mqhv2moxO3xlTQ1hwvFz7tpn0=;
        b=T0Lbzn5xsQq5ohWfhjLZa15Y2tTnWUX4qvT414oZujmvMxJo0+sBsDhdPtjbxgPZ9W
         wz0JOI3pw+Z3affCaTtFQvUQvEtByaCYO8yuH/nfIGKpioMewNxKLWrQwtokcaUyGC6G
         8L2NKfLyN0J8Q5JITaulmvha9GwPTCPqkKizm42ET85yAes2eo3+7/F8XzYcOoSYjqxQ
         MTa/FQmT9gB0Dn6CNedEDebc6QFPc7nqQcFCSUeQr2OLi8qL391+dlVpOHpqHbulKAWh
         I6CGA21MWIHW6P31zpAzghqvcjAaqMlFDV4R8F2DdcJUmlXdOLT4wrnxht3qhb2EPSYl
         NU3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xYqWuTW/0Vb6gGlVF7Mqhv2moxO3xlTQ1hwvFz7tpn0=;
        b=bg0kDNBvxhvzD3JKQwREW/IS66i+bChaPLzygXCbw6R6ZsxeLD1zxI2rkgYeXigWW5
         q/YN0wRm23NNWGMFsgEjtFC9BjCHJ9Ka6KYGlAccJ7JRE6RAVldC5T5WZ99S6V9a65st
         QDddP0OM6lIripR1H84KG81S5VfdsAvHsRm3Y6g0NAwcp7v3A8gdZzoCR/hthUVch5/I
         C1AyTZWV4HDhm9PyzkWxJK4Kq21tGu2scMa1DskebTizI6t9cmGtiwSkpEaLYlA/iOWO
         EQ+6I2ptT8yIu4UjIno3xEYpA9kMVYhSDghYKTSfiVFJJuH38LASx2SXXvrOg51dAirF
         87Mw==
X-Gm-Message-State: AOAM5327o0ya0YPwAPzDfXKaMZe/8f0ypYsRCT07CrpJM6Ea2EEbtbgl
        wEPAN9JNpXsRF5dqWHjvFobIe3tRjBpPVg==
X-Google-Smtp-Source: ABdhPJxhjDWYCCReMk52XDj/uJUpC3UL0DI10mjq49N44EKAuYAhZl162evpZLmnK9N44Jw+wXmgwg==
X-Received: by 2002:a7b:cc17:: with SMTP id f23mr58713wmh.166.1602597552536;
        Tue, 13 Oct 2020 06:59:12 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id a199sm17785wmd.8.2020.10.13.06.59.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Oct 2020 06:59:11 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     mdtipton@codeaurora.org, okukatla@codeaurora.org,
        sibis@codeaurora.org, saravanak@google.com,
        bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org,
        Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH 1/3] interconnect: Aggregate before setting initial bandwidth
Date:   Tue, 13 Oct 2020 16:59:11 +0300
Message-Id: <20201013135913.29059-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When setting the initial bandwidth, make sure to call the aggregate()
function (if such is implemented for the current provider), to handle
cases when data needs to be aggregated first.

Fixes: b1d681d8d324 ("interconnect: Add sync state support")
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index eea47b4c84aa..974a66725d09 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -971,6 +971,9 @@ void icc_node_add(struct icc_node *node, struct icc_provider *provider)
 	}
 	node->avg_bw = node->init_avg;
 	node->peak_bw = node->init_peak;
+	if (provider->aggregate)
+		provider->aggregate(node, 0, node->init_avg, node->init_peak,
+				    &node->avg_bw, &node->peak_bw);
 	provider->set(node, node);
 	node->avg_bw = 0;
 	node->peak_bw = 0;
