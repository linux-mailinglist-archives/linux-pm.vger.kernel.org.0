Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96EB72FE89A
	for <lists+linux-pm@lfdr.de>; Thu, 21 Jan 2021 12:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbhAULUn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Jan 2021 06:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbhAULUk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jan 2021 06:20:40 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72923C0613D6
        for <linux-pm@vger.kernel.org>; Thu, 21 Jan 2021 03:18:45 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id p18so1137020pgm.11
        for <linux-pm@vger.kernel.org>; Thu, 21 Jan 2021 03:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DAtjI7/BPs0IoV2iaS54lmWpFTE0HbF0Es/G22rWt3g=;
        b=ZpmS5LN1rts74B7Ode0O1RTIMsoc8Gi0J/g/qdh4T4B+Pl5+6gDcpGtwEy3pxwaa1n
         KJMIk8ywsFR4wtEZeD3cynSaQbttOpg++x8NwKSnz5NE2yMDL+xniSZ2kjT0faYRi5pL
         M+Ww1NxEYcW6YGEkuuNHvtUhb0dRL8IgsIE9SQlSprdhSHMaSGscj1dOZ0pc7bkhMeRY
         40VDRsunRhdrZp8VxhHfj0mrnlOz/vOMk0C1DUU9eLTtmhKiclL+GWz1UIm6g+zTmw1Y
         u2QUTm7Kird1vwS6WBpw7kK7Uo1YQ75ztHo2FgLS8AEfwPTzQ4+ugUeRvnqx9lyoBgi/
         jm/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DAtjI7/BPs0IoV2iaS54lmWpFTE0HbF0Es/G22rWt3g=;
        b=ijPQyDlKQjPRtAGZnzgIeTPIuozm6GO4mI2J9X92BkLIDdDdLlzCOaQ6BQWi7cWXzC
         XNM3ZTqQGBZClAXRtbHLn1e+RLpIp9I9jAdCuBhZxcMUTrJoNJVevwHrRKtc63jDFblX
         AZ3+5O2Ae+lVVgzePcdtngyTsbw7EkSyLalYupFUioKU0VC1voNQOGwVpGF9V/3WQC4/
         DekORWZbNus3CI4Ltw81qQnDzBctCQ3GPaUE0zWOSku5QgGv58iF1OUvsw1h/XQzBdzp
         rLcQko8dXEAP8G6bQsi/J96VbZJtY/v/439ek1n+0GMtpmWniEY9RV6g6CDeXQPtihCx
         0Grw==
X-Gm-Message-State: AOAM531zfKpP3XsKZDc9Wl5WHKSftf8HQEX507m5bfbNRHycRqkPEJ60
        ECxgRBIy9J65IAoHShmcBu4Arg==
X-Google-Smtp-Source: ABdhPJyts296w7aWmAZLnK+2Ns297gN4vfmOwF34Q5MA6SM/rmkzGZINgd1d7pMVUGniT2QI9Kk1mQ==
X-Received: by 2002:a05:6a00:a8d:b029:1ba:71d1:fe3c with SMTP id b13-20020a056a000a8db02901ba71d1fe3cmr9122927pfl.51.1611227909301;
        Thu, 21 Jan 2021 03:18:29 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id u1sm5595280pjr.51.2021.01.21.03.18.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jan 2021 03:18:28 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 01/13] opp: Rename _opp_set_rate_zero()
Date:   Thu, 21 Jan 2021 16:47:41 +0530
Message-Id: <b55e4579ef70d47ceeec8e4b96108e8f3e0f1b81.1611227342.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1611227342.git.viresh.kumar@linaro.org>
References: <cover.1611227342.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This routine has nothing to do with frequency, it just disables all the
resources previously enabled. Rename it to match its purpose.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index aea0b9d7203c..9ec8e42981d0 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -943,7 +943,7 @@ int dev_pm_opp_set_bw(struct device *dev, struct dev_pm_opp *opp)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_set_bw);
 
-static int _opp_set_rate_zero(struct device *dev, struct opp_table *opp_table)
+static int _disable_opp_table(struct device *dev, struct opp_table *opp_table)
 {
 	int ret;
 
@@ -997,7 +997,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 	}
 
 	if (unlikely(!target_freq)) {
-		ret = _opp_set_rate_zero(dev, opp_table);
+		ret = _disable_opp_table(dev, opp_table);
 		goto put_opp_table;
 	}
 
-- 
2.25.0.rc1.19.g042ed3e048af

