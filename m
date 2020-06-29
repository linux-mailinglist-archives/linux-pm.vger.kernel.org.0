Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5F1420E09F
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jun 2020 23:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbgF2UsK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jun 2020 16:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731538AbgF2TNw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jun 2020 15:13:52 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630CFC00864B
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2020 03:04:45 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id j4so6915979plk.3
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2020 03:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ly6GQY518rugBZBKaypUfjaHtOs18Gvlz/xTQcFP+uo=;
        b=FwlutL/Q/eEKYRihTTqlzWcZE7NzatpA+2aRZl4vnE+PQ+Ig5lMtw6ZACAqglZLEfo
         yuSIol4GzaOVt6nQHLF+YD63riXx/XSOQIrc68BaP0Cw9GDXvs/1/072SiY/Mbv+WIG7
         6ED9NmAMHgEzeBjHu2WzoZYxF6I/QKzrgiFapmGeIgP5UTs17yv0rEDiliHlkQLqDhen
         fLrb6m/PGZD87Yiw5zsGWeyZfeW11GjUaK/4QedXpAeknQRRdB7gfHi6NyaQmOXa0e/t
         7xpM8idGeiC4zW2IWrvgnrXun960Lkyd/5OgqGfu/0iUjZHRNyvbtFXO0RVv5BxHJCMl
         iM7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ly6GQY518rugBZBKaypUfjaHtOs18Gvlz/xTQcFP+uo=;
        b=eK78qOg3dd3u0090Ampdy/N6/O9rRkBsMjWnQqX/Jls/mXQxY389EE7lW4lAqpeaej
         nyLwX5+7kBBA6hcXuVM1JFmPBeeRMFaaSkHFHgnbWpClX4OqpGD8HGKiIlfkZzTIrOI7
         isMu6glOrWl1Ors/zw7dboXZqUAzT3bh7fsoAM/XYYw9bhlkt5BYquXSrbPzVb0yZhHg
         JSqUKl/cYCGkPaErIur5M+m5DWV0NYUvPuXMaVXDGmTzCiba7Ny68g4asb7pRgH1fqty
         sx+5tXqc8wknxY/Jz8TUlR2jkRw1o81Xo/whMSxG+J5aOOa2PlNu5NdCaYRjNN7Mshxw
         AmhQ==
X-Gm-Message-State: AOAM531WR40meQddqCA0D6CHu6/o2bsXCoNy+wGIBBm7hFHV7APwUrKf
        aZf8s3JsTzh3tlqdYWDsW3ICqQ==
X-Google-Smtp-Source: ABdhPJzxTl5fVMfp7OZOK/Cxx7y/SkzGumBhYNEPOdMQyPBf1+rzq55IntET0rwpKp6rrizLK7fToA==
X-Received: by 2002:a17:902:7483:: with SMTP id h3mr9067587pll.114.1593425084898;
        Mon, 29 Jun 2020 03:04:44 -0700 (PDT)
Received: from localhost ([122.172.127.76])
        by smtp.gmail.com with ESMTPSA id z9sm25088302pgh.94.2020.06.29.03.04.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jun 2020 03:04:44 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Quentin Perret <qperret@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: Remove the weakly defined cpufreq_default_governor()
Date:   Mon, 29 Jun 2020 15:34:40 +0530
Message-Id: <2f00a5847708547a57920e24a2ec5e76b265cde9.1593425047.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The default cpufreq governor is chosen with the help of a "choice"
option in the Kconfig which will always end up selecting one of the
governors and so the weakly defined definition of
cpufreq_default_governor() will never get called.

Moreover, this makes us skip the checking of the return value of that
routine as it will always be non NULL.

If the Kconfig option changes in future, then we will start getting a
link error instead (and it won't go unnoticed as in the case of the weak
definition).

Suggested-by: Quentin Perret <qperret@google.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Based over the following series:
- [PATCH V4 0/3] cpufreq: Allow default governor on cmdline and fix
  locking issues

 drivers/cpufreq/cpufreq.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index ad94b1d47ddb..036f4cc42ede 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1056,11 +1056,6 @@ static int cpufreq_add_dev_interface(struct cpufreq_policy *policy)
 	return 0;
 }
 
-__weak struct cpufreq_governor *cpufreq_default_governor(void)
-{
-	return NULL;
-}
-
 static int cpufreq_init_policy(struct cpufreq_policy *policy)
 {
 	struct cpufreq_governor *gov = NULL;
@@ -1079,8 +1074,6 @@ static int cpufreq_init_policy(struct cpufreq_policy *policy)
 
 		if (!gov) {
 			gov = cpufreq_default_governor();
-			if (!gov)
-				return -ENODATA;
 			__module_get(gov->owner);
 		}
 
-- 
2.25.0.rc1.19.g042ed3e048af

