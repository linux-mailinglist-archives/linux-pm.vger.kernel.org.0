Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB2B306DFA
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jan 2021 08:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbhA1G6s (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jan 2021 01:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbhA1G6p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jan 2021 01:58:45 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9175EC0613D6
        for <linux-pm@vger.kernel.org>; Wed, 27 Jan 2021 22:58:05 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id o20so3411925pfu.0
        for <linux-pm@vger.kernel.org>; Wed, 27 Jan 2021 22:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2gJpFkK5TmW5EOcLua8dRT08KePDv15G0fJENxu9Phs=;
        b=Ti6oOUz8rg0O96Ii9pV7IYBgjnHKK9Q+09y+Rmds4gHWkxFXgRKvHr1Y+J2MKn8Fz3
         XkL7/gYQ1pH7VfoA9F07IVE4S8K17vDEHvCYSkoxrBIAR0bE290KygzoUT95gDc47X1T
         0QqARhBv01Q0PBr64uYEtcblKclmzu9rNKNzgxU4Rx/Rn6FJC1wm3bw/2GxXHCTn5cEL
         sE74oQJ4iMPb8DLeH/xqAkcoBVUr/Eep+oFtQdpxix83RWfKCvdgVTF8y3NXXbjJ+zEL
         Iks/gI2mwPRphMiQDtMFMXhUL5fgkIQ1flkYBOwhmRLI3FqG2p0vxVcdm/FFtrxeh4cw
         s3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2gJpFkK5TmW5EOcLua8dRT08KePDv15G0fJENxu9Phs=;
        b=P60WuK92dajsKD7HkmVfOX0g0dAWrxtMsS/iTJ1mVpn2mNyvygQ/b+rLt6wKUXszX8
         kzAsfRSV4mQ5En361PHH9MgO3O8M6tnvukuSWmoGO01kKXDjAHsWK7swNeP3Pwg3UTdl
         6zBHWLwc8WExiRTC46VRAoAxzR6E/+P8PdVW2esf0jK7pnTgJU5fhRWpD789Zw1n95xG
         YD76jY2ZCxv1egZFqCBZKHUwrCh7KqdzIAfvuPUd+Nap6SbVtvNXuUIHrWI0HRQWv+5k
         RPcHpJ0QLSzUsorJt3+MkmwLiIyvqQswGlezXKkTzEtIzXXqVLQv/bm1bHTuryyfapXO
         ++pA==
X-Gm-Message-State: AOAM532FUZcRA7gTYkuyMMpyrlq+kJVXPfOR6bwmHkmWF+R9/Cz1lVRE
        Her6hwho4j16nG8Vq6VKIhu02w==
X-Google-Smtp-Source: ABdhPJy1k6ZQbOA9EeAeCdvN1uayI3cmHdyr8G6/NLxEL62v/JzP49XUvHFJ9fD6IMgzhvLqUmlHVw==
X-Received: by 2002:a65:4203:: with SMTP id c3mr15098898pgq.65.1611817085039;
        Wed, 27 Jan 2021 22:58:05 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id j15sm4608977pfn.180.2021.01.27.22.58.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jan 2021 22:58:04 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] opp: Staticize _add_opp_table()
Date:   Thu, 28 Jan 2021 12:28:00 +0530
Message-Id: <f65f77ed2e17da87b5ff7878f6dd95c94c8a3744.1611817064.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

_add_opp_table() isn't used outside of core.c, mark it static.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 2 +-
 drivers/opp/opp.h  | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 253bc87b5695..dc7a298f3611 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1193,7 +1193,7 @@ struct opp_table *_add_opp_table_indexed(struct device *dev, int index)
 	return opp_table;
 }
 
-struct opp_table *_add_opp_table(struct device *dev)
+static struct opp_table *_add_opp_table(struct device *dev)
 {
 	return _add_opp_table_indexed(dev, 0);
 }
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 4ced7ffa8158..ee2593afae0c 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -223,7 +223,6 @@ int _opp_compare_key(struct dev_pm_opp *opp1, struct dev_pm_opp *opp2);
 int _opp_add(struct device *dev, struct dev_pm_opp *new_opp, struct opp_table *opp_table, bool rate_not_available);
 int _opp_add_v1(struct opp_table *opp_table, struct device *dev, unsigned long freq, long u_volt, bool dynamic);
 void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask, int last_cpu);
-struct opp_table *_add_opp_table(struct device *dev);
 struct opp_table *_add_opp_table_indexed(struct device *dev, int index);
 void _put_opp_list_kref(struct opp_table *opp_table);
 
-- 
2.25.0.rc1.19.g042ed3e048af

