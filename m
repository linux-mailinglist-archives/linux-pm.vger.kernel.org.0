Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61CD5A133C
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2019 10:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbfH2IHf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Aug 2019 04:07:35 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46978 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfH2IHf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Aug 2019 04:07:35 -0400
Received: by mail-pl1-f196.google.com with SMTP id o3so1192250plb.13
        for <linux-pm@vger.kernel.org>; Thu, 29 Aug 2019 01:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nq8To/7J1PSl3z5Lxbp7yzGH/kF9sw7bMQzb25E4PoY=;
        b=Iy0ht6TDTmGshmaHrPiBh24TX0AOyLc+aZTieNTwrNKdltnBow1I+wT9how0xATzcy
         T8TdaugNXk89y2QVrWB796cybqqB4Dikq5iXUtErxvtwGNX7tSit17FeRbUsp3NRs+XB
         kLuHjobpjXTEZUFzCJRlDt5rNF6mo6brysZcwCcfPefgcXv73TJZVhykZXQHH6LMB4ZJ
         zKwzC5lHD5weE9RZ8BP5IclarFlphjIqZ1UiVrzies2f0YDEk7uWIFKe2s/27GDnQ8pS
         LnzbkLLv1Zr4UFJThGWzARqALmWXqEkX6oWv+rdR4zpDv7gRNVjTy1tJrvjcoPRsDNCX
         uGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nq8To/7J1PSl3z5Lxbp7yzGH/kF9sw7bMQzb25E4PoY=;
        b=RyFH3p3xcTJJ+WlJ7ILICVXf202a4xV/bVxUO+rQucLyDwjQ9yIiy1eNAGD0IJqKFw
         Z2yCNXre3nx3dTMkIl+snOIC+tQ11CBavIlH2bPl5StKCyjHZY0FmOIxao0lGLcR9MTW
         QKL1HlK4Do+tZLaM+IjCb1CHxrDKoVwZu1srFU+Nnhtc76vqrQ2P/pwK/DP4fv1c+mC+
         djAZc3WmIr90pcOr9GTt4oTLlRtLqk6ysfU1f0RZfGEQLYK7c6d9kqz9tLIqRys1e8oq
         HRaWuQ5qTs6o5YXkbmitZFQcVg7wDSZo8KHWJvoe7g5wtYjrSh5dsq0XQjk3GuRSLIMb
         p/Pw==
X-Gm-Message-State: APjAAAXbj/Kt2Ri37TANNBbwFhiA6/Hbmu6tWcEwLvGzgg1o8OPr3o97
        eF/mYUJbAmMoj0WIJBVTlVaas6AspGw=
X-Google-Smtp-Source: APXvYqwn8T2RbaqO4fQu08EiX8JEtixGnDXWzaiwBIkDe0YYnJRJnI5T0eem+sevwzX7ANjUv7sTyA==
X-Received: by 2002:a17:902:8f85:: with SMTP id z5mr8752168plo.328.1567066054551;
        Thu, 29 Aug 2019 01:07:34 -0700 (PDT)
Received: from localhost ([122.167.132.221])
        by smtp.gmail.com with ESMTPSA id p2sm2637128pfb.122.2019.08.29.01.07.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 01:07:33 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] interconnect: Disallow interconnect core to be built as a module
Date:   Thu, 29 Aug 2019 13:37:29 +0530
Message-Id: <b789cce388dd1f2906492f307dea6780c398bc6a.1567065991.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Building individual drivers as modules is fine but allowing a core
framework to be built as a module makes it really complex and should be
avoided.

Whatever uses the interconnect core APIs must also be built as a module
if interconnect core is built as module, else we will see compilation
failures.

If another core framework (like cpufreq, clk, etc), that can't be built
as module, needs to use interconnect APIs then we will start seeing
compilation failures with allmodconfig configurations as the symbols
(like of_icc_get()) used in other frameworks will not be available in
the built-in image.

Disallow the interconnect core to be built as a module to avoid all
these issues.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/interconnect/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/Kconfig b/drivers/interconnect/Kconfig
index bfa4ca3ab7a9..b6ea8f0a6122 100644
--- a/drivers/interconnect/Kconfig
+++ b/drivers/interconnect/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menuconfig INTERCONNECT
-	tristate "On-Chip Interconnect management support"
+	bool "On-Chip Interconnect management support"
 	help
 	  Support for management of the on-chip interconnects.
 
-- 
2.21.0.rc0.269.g1a574e7a288b

