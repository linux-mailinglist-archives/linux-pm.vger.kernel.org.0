Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0EC173A89
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2020 16:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgB1O7u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Feb 2020 09:59:50 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52318 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbgB1O7u (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Feb 2020 09:59:50 -0500
Received: by mail-wm1-f66.google.com with SMTP id p9so3513068wmc.2
        for <linux-pm@vger.kernel.org>; Fri, 28 Feb 2020 06:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M5EizECLIpIUfC0QN1DsU3CZsuQMZC0Kr0ghGHK94gY=;
        b=dM53bfJArZO9qb5NtLhcf9fc9MxXTPGgqO3tpgopcYReBgUho5eqi1N4rMXS9hsPIO
         bbkpxg0yo51Fvf4BwzAb4CfC2sD63X2WtvYWPLv7cWyQJCSog1KpwF/phVOuKjfH99JJ
         si+flQaseTvCB76w9gaIft838bkEKFINaKQPDPUJqbRvPBdgdGK4dq3u9k7rwTn2eefk
         +8h1z3G9nTC219sIi3SczvSOuhixetoUyuZS3is+6yOodcVIRq0cvQOlyKQkOqHjExts
         cesC9CkNqVWYffLyDEpvK9r+ytutG+WzBm0nWlZm9LOR53/lp5I+OvPt7g2WJhONK3WZ
         i+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M5EizECLIpIUfC0QN1DsU3CZsuQMZC0Kr0ghGHK94gY=;
        b=l0MmjjS7snp/chSQaLz73l/oQZ/5lm2lhZz8AgsDA4U8uVhdCqhRe2iC8fsq0eTw+2
         Tcs8+V7VvVqjwQjLLPNO/rqpR8jjSGYerAkve74cGg6N+egUJksvX6zQSNxj4o33RBLE
         BiQiFf82K2eO6jharnNa3mweC47fTXjUEiXAASSvcN3pZmG1dlVBnD2sZS7jHmOahqfh
         lFG+O8uhKbDx5sMYWP8zjlwcSfmqezIq0ol0VfUMWNk/fJUFGE6RUXOje0agUbes0hVe
         fLUYtpn2uv7KeyEaXKHkwMOl8hUUIEoaKfIKjlJggFIi+/o0mmNcDtof09/DN9/eYhoa
         ySrQ==
X-Gm-Message-State: APjAAAU6zgsPr9HwVyOuT5z2xC4dsZXzugBKK9XyFdLuv3+JdcZ1YE01
        QlWIpqk67YA/WRKEHlpPRiR0MhZ4OcQ=
X-Google-Smtp-Source: APXvYqxjbt3ytt/Dr/1YIZdifDKh3nOAVB9e7+Uemwzlc/bYGS1B9wcC4muJfMkxNQXqLI4fVgr6sA==
X-Received: by 2002:a1c:1d06:: with SMTP id d6mr4888765wmd.99.1582901988027;
        Fri, 28 Feb 2020 06:59:48 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id n3sm2659348wmc.27.2020.02.28.06.59.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 28 Feb 2020 06:59:47 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, georgi.djakov@linaro.org,
        evgreen@chromium.org, bjorn.andersson@linaro.org
Subject: [PATCH] interconnect: Mark all dummy functions as static inline
Date:   Fri, 28 Feb 2020 16:59:45 +0200
Message-Id: <20200228145945.13579-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There are a few dummy stub functions that are not marked as static inline
yet. Currently this header file is not included in any other file outside
of drivers/interconnect/, but that might not be the case in the future.
If this file gets included and the framework is disabled, we will be see
warnings. Let's fix this in advance.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 include/linux/interconnect-provider.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/interconnect-provider.h b/include/linux/interconnect-provider.h
index 0c494534b4d3..5b64e267bfb3 100644
--- a/include/linux/interconnect-provider.h
+++ b/include/linux/interconnect-provider.h
@@ -117,7 +117,7 @@ static inline struct icc_node *icc_node_create(int id)
 	return ERR_PTR(-ENOTSUPP);
 }
 
-void icc_node_destroy(int id)
+static inline void icc_node_destroy(int id)
 {
 }
 
@@ -126,16 +126,16 @@ static inline int icc_link_create(struct icc_node *node, const int dst_id)
 	return -ENOTSUPP;
 }
 
-int icc_link_destroy(struct icc_node *src, struct icc_node *dst)
+static inline int icc_link_destroy(struct icc_node *src, struct icc_node *dst)
 {
 	return -ENOTSUPP;
 }
 
-void icc_node_add(struct icc_node *node, struct icc_provider *provider)
+static inline void icc_node_add(struct icc_node *node, struct icc_provider *provider)
 {
 }
 
-void icc_node_del(struct icc_node *node)
+static inline void icc_node_del(struct icc_node *node)
 {
 }
 
