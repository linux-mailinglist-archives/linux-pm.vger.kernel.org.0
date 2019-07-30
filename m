Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9F27A59F
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 12:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbfG3KIk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jul 2019 06:08:40 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42667 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725209AbfG3KIj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2019 06:08:39 -0400
Received: by mail-pf1-f196.google.com with SMTP id q10so29567938pff.9
        for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2019 03:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LQCA6i6rXgxvYuqCVmBQ2KwLJIicpnzF/Z5UgCXxX00=;
        b=oFiZI5uaOB/rTJdap8KPycEOnBBvgKRnHZKIjMj4SWM9cTkRNhsm16Ta7Nke2W0l9t
         qRpRjSc+eTyie1NTzylWW4DIAUFYVAWCQbVpZd7BzL/Z5CdHDbgj5C4/EZCc3+Jf0q4V
         1yJ1IFUL8+1DjXXXsZPVhUS/fQ4XV1iYzxORKjr4fcFZ5b33TBsdK5Dzy5Le//dxga1D
         KZxSdZTjU7mVsT+fvTPYS+crlEp4IZG+AXBoMtYiz1Y4SWpZ+uJc9dLv52F6KoIqMtjr
         M7W1Ol3ZBu+Y77oOnb5dzrk7g6RVGJuciTdxyf+rix4mQJJQ447MohMLVUmwC3vhVm/S
         9FPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LQCA6i6rXgxvYuqCVmBQ2KwLJIicpnzF/Z5UgCXxX00=;
        b=m0+WnfSS0FBMBsxx6kavr0QMzon/VdWxGTgAUls9hH4uLIlLkT1Qbjg0JmYnZ47HbV
         60xqxWOrRZFUvqsBdtnu/V+k+RXaH9G2KT4JP5gwvCxozqOhsHovDXWIPfbwmZRmhz6/
         DMZw0qSYWEBr0CrafJ6c72llNYpWb9/JQZPceQjr5CK8WJO0gPs4wShHvlPQhD9wZpTS
         GwcA2GfP8w3SJWaJNJOWSPiGEKc5R8qDNvkTN/YsRHMBqpr1gUHLMiN1Y1BMrzfnvPmL
         Vi2Sz/DUATc0U9plCy67gpl0UW/ydxw9nE/c4yDt1oZsAFJvhzhbh8AlHbh0AiGBsfhX
         4NGA==
X-Gm-Message-State: APjAAAX8WpweNPGXPc3CQEjqRhdy+97GSBwzyk2WYAqB7oqBhNymITf/
        mV64dnFGks5+FVV1fxrujD7Uc3bn
X-Google-Smtp-Source: APXvYqx6TOGzYhioaOqC9ERD6lFLDCBPTCn1NKc7zrhg+pXnX5yaLtbz4DNYzjn4G3slOhKt/r91rw==
X-Received: by 2002:a63:ff0c:: with SMTP id k12mr66266420pgi.186.1564481318243;
        Tue, 30 Jul 2019 03:08:38 -0700 (PDT)
Received: from huyue2.ccdomain.com ([218.189.10.173])
        by smtp.gmail.com with ESMTPSA id q22sm58983311pgh.49.2019.07.30.03.08.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 03:08:37 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com
Cc:     linux-pm@vger.kernel.org, huyue2@yulong.com
Subject: [PATCH] PM / devfreq: Drop the name check to request module in try_then_request_governor()
Date:   Tue, 30 Jul 2019 18:08:19 +0800
Message-Id: <20190730100819.8056-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1.windows.2
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

No need to check specific governor name of `simple_ondemand` to request
module, let's change the name string to `simpleondemand` to keep the
consistency on loading module if needed.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 drivers/devfreq/devfreq.c | 6 +-----
 include/linux/devfreq.h   | 2 +-
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 784c08e..baff682 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -246,11 +246,7 @@ static struct devfreq_governor *try_then_request_governor(const char *name)
 	if (IS_ERR(governor)) {
 		mutex_unlock(&devfreq_list_lock);
 
-		if (!strncmp(name, DEVFREQ_GOV_SIMPLE_ONDEMAND,
-			     DEVFREQ_NAME_LEN))
-			err = request_module("governor_%s", "simpleondemand");
-		else
-			err = request_module("governor_%s", name);
+		err = request_module("governor_%s", name);
 		/* Restore previous state before return */
 		mutex_lock(&devfreq_list_lock);
 		if (err)
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 2bae9ed..41e8792 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -17,7 +17,7 @@
 #define DEVFREQ_NAME_LEN 16
 
 /* DEVFREQ governor name */
-#define DEVFREQ_GOV_SIMPLE_ONDEMAND	"simple_ondemand"
+#define DEVFREQ_GOV_SIMPLE_ONDEMAND	"simpleondemand"
 #define DEVFREQ_GOV_PERFORMANCE		"performance"
 #define DEVFREQ_GOV_POWERSAVE		"powersave"
 #define DEVFREQ_GOV_USERSPACE		"userspace"
-- 
1.9.1

