Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7C39497189
	for <lists+linux-pm@lfdr.de>; Sun, 23 Jan 2022 13:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236344AbiAWMtu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 Jan 2022 07:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbiAWMts (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 Jan 2022 07:49:48 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B9DC06173B
        for <linux-pm@vger.kernel.org>; Sun, 23 Jan 2022 04:49:48 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id d15-20020a17090a110f00b001b4e7d27474so13746650pja.2
        for <linux-pm@vger.kernel.org>; Sun, 23 Jan 2022 04:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4IJ116pTULrMfInhOwgQ7Wa1AIt7I4SXgaAAbmFElZU=;
        b=ZzN+AzMWBu61AjVgzA6AnEsv6bAx4+LF7/yiAqd2nOIqpWJjWpKE9bDKu2s4wGGdpz
         WRfUlQZBRMST+hB3I30TZYsNOu5DVoZ0FZcx1QbKlBYJrTNskJtIfkagkGpQT5BioL8H
         Xfjq0WpSBuuwzZoG2uPpU1WqXA/4D2DuuZBQ8fMx2bp/CZYjyGz5TwuY+ASzGjvxW5bo
         qq/NpZoq6R1NGX5PbiheHnv7reRz0o1NsEtTCwJGpArNZiluDgblNAopaOn68fI9JXgG
         9txnBPWjX9Nk4WICZvwyC2i2zO7VxoWfq4il2DbKHVeAVpMLPyCqDVcs1Ux+L5Nqk1XM
         Ugug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4IJ116pTULrMfInhOwgQ7Wa1AIt7I4SXgaAAbmFElZU=;
        b=UV/6+MES8l8RRAis72UxUPjymiOQ89FNg0ulxEzBLr+TC+U2Cz/ZGGcFz+F0t8UTYX
         o4wvlbrHHORSwnGVHwOEPMT10F1/IKr4NIBci+9kKZimyLEFS+tR5BhL5MRj/OnFkKIe
         h++VIQM1ZUUeiLueyIJ4UDM+bNHYANi0EPWSPhxS0THa9t/Wu9KQWkfUNCKsTmqvy7fG
         if2+HGR1LgaGvU0ywP34vtmj/U6/ubyTqr9MJHM7qYj9E6cybSy4j50zNCr9VstM1PuA
         oO1AdOuWsE1UYd2Ye43Gdy+6L258m2XoO+Ww8BK7mUr5gv1OzkKJTJblTKOOvBD68IrD
         B18Q==
X-Gm-Message-State: AOAM530owyheulZxf3CD6282ceunuHeI/d3cgzgY2bTUGvdxCmr354ka
        0FzxkGAbe1bUA74s1VC8Bul639fbr38+cg==
X-Google-Smtp-Source: ABdhPJxuWwN1cxy7n/uXuhPEUGXOZTxg7cQyr/G9lyYK/d3YEWtQHtL6zE4Ue00Q+Hj86h6DvO1+KA==
X-Received: by 2002:a17:902:b947:b0:14a:a6aa:4fa6 with SMTP id h7-20020a170902b94700b0014aa6aa4fa6mr10932738pls.149.1642942188145;
        Sun, 23 Jan 2022 04:49:48 -0800 (PST)
Received: from pek-lpggp6.wrs.com (unknown-105-123.windriver.com. [147.11.105.123])
        by smtp.gmail.com with ESMTPSA id om6sm9765972pjb.24.2022.01.23.04.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 04:49:47 -0800 (PST)
From:   Kevin Hao <haokexin@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 2/3] cpufreq: schedutil: Use to_gov_attr_set() to get the gov_attr_set
Date:   Sun, 23 Jan 2022 20:45:07 +0800
Message-Id: <20220123124508.463305-2-haokexin@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220123124508.463305-1-haokexin@gmail.com>
References: <20220123124508.463305-1-haokexin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The to_gov_attr_set() has been moved to the cpufreq.h, so use it to get
the gov_attr_set.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 kernel/sched/cpufreq_schedutil.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 26778884d9ab..cffcd08f4ec8 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -539,7 +539,7 @@ ATTRIBUTE_GROUPS(sugov);
 
 static void sugov_tunables_free(struct kobject *kobj)
 {
-	struct gov_attr_set *attr_set = container_of(kobj, struct gov_attr_set, kobj);
+	struct gov_attr_set *attr_set = to_gov_attr_set(kobj);
 
 	kfree(to_sugov_tunables(attr_set));
 }
-- 
2.31.1

