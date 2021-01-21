Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 570792FE92F
	for <lists+linux-pm@lfdr.de>; Thu, 21 Jan 2021 12:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730147AbhAULr2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Jan 2021 06:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730076AbhAULVX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jan 2021 06:21:23 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27548C06179F
        for <linux-pm@vger.kernel.org>; Thu, 21 Jan 2021 03:19:04 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id c132so1166535pga.3
        for <linux-pm@vger.kernel.org>; Thu, 21 Jan 2021 03:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CYbzCFVCi3fEgZJohV5hqu59RAY6Et7w7QbAOId9XrY=;
        b=lMZb9UiNz5IoKRjlVfTRbe5AbsFjgYug6+3rBQBORQMTS2UMUtLozNugVAnuXzVu8y
         EYEMj8NSmofsA6xXlvjPMTlIYrPcpAfABG+1v1OmZz7r9X5YWSkh16Cxrsokim45C5sJ
         tUjvk+6bmsgYppq/z+2OjYh9iv2r6nSz0qXHsQ+GHP9yy0kYl4kID2DhPeeyCjK4vjlb
         Icdu8T9ko+aqp872q9wMRgxdPOSbnY8xrtxNYrFWzjrxlAklUobL0Gl0pA9p1ggkdKGE
         zQrS52KKBl/kFz3wQD/xWCCxYLYBNGWJvjbTLdPsvcwnxS60d3h0uiITwge2NEyNxN4s
         6jvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CYbzCFVCi3fEgZJohV5hqu59RAY6Et7w7QbAOId9XrY=;
        b=RHsda/T8lVJigRUInunsCkeUMXJUn7ZFF74HgfK5rsN109Rq7bJow6ncggTvJivUC7
         3XQWEllzlvhDxSXVHbUEewv+D6q44aw7anUR08X5nDL/chyhTr7ScymTmzNh6z0OTVid
         6qlXo+Xlc6YCbTQODulPhCbH++zYDN3jqD5Nr+zQLx2TQTQB34E3UmIwVcgi0gisOyre
         1y1ksTDeHbIkaK2PHq6Jet33FgM7zz2e0kGQtt7j3W/He/Uw0L+2Px7UyPHAQRjUaU+A
         ESXd+sbElp35wkpyW7ytsBfcP73uF1mNS6TEgI/duus2T+JC7hPZcWvEiZoMzJ7TDO7o
         Og3A==
X-Gm-Message-State: AOAM532Hnr8pK8+QpUn4C245P9iw9E7Zcsvsz0lN6ZMHd3P1M40+jUww
        txpbeRW/JZeu+3JZdiGQPWZoJQ==
X-Google-Smtp-Source: ABdhPJyEgpWlB1DXX6+xj9reAgkGRUJ/18nmuXm2a77WwY0rHW9XG4b7O5gR3XoNa+V5ylK4UmmqzA==
X-Received: by 2002:a63:d42:: with SMTP id 2mr8226764pgn.236.1611227943683;
        Thu, 21 Jan 2021 03:19:03 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id w21sm4497087pff.220.2021.01.21.03.19.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jan 2021 03:19:03 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 07/13] opp: Allow _generic_set_opp_clk_only() to work for non-freq devices
Date:   Thu, 21 Jan 2021 16:47:47 +0530
Message-Id: <1585f6c21ea8aee64fe4da0bf72b36ea4d74a779.1611227342.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1611227342.git.viresh.kumar@linaro.org>
References: <cover.1611227342.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In order to avoid conditional statements at the caller site, this patch
updates _generic_set_opp_clk_only() to work for devices that don't
change frequency (like power domains, etc.). Return 0 if the clk pointer
passed to this routine is not valid.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index a96ffd9051b1..6b09d468d37a 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -726,6 +726,10 @@ static inline int _generic_set_opp_clk_only(struct device *dev, struct clk *clk,
 {
 	int ret;
 
+	/* We may reach here for devices which don't change frequency */
+	if (unlikely(!clk))
+		return 0;
+
 	ret = clk_set_rate(clk, freq);
 	if (ret) {
 		dev_err(dev, "%s: failed to set clock rate: %d\n", __func__,
-- 
2.25.0.rc1.19.g042ed3e048af

