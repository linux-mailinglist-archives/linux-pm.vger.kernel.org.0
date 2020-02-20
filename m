Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D938A165684
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2020 06:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgBTFFH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Feb 2020 00:05:07 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43084 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbgBTFFG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Feb 2020 00:05:06 -0500
Received: by mail-pg1-f194.google.com with SMTP id u12so1285534pgb.10
        for <linux-pm@vger.kernel.org>; Wed, 19 Feb 2020 21:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wOHv+QxDznql2h/B9QPBonJ8+Ax46oQhAeGgxF/JNeY=;
        b=LH5XyaX9GkiXyqpCmh8o/RmVlUzm/wMIM4fbcM8puY7zZs3tkeCMoWyQvz1qRH9rB4
         i+GNjONvTcEEgSua8Qg0qqz+ExgOjFXX0Zz280K+I6tcAeU2WJazEtGW2fESRdpvRMo0
         SJquQgprFLgJJuJkbwYI06B7EzImZphVYtWdVcjSnGXh0xGPCyrnYzrOGJmYtS507qjq
         nmlxqkwq6rJCyydRmqB3PaFDprIyfqwvuK+REsrevHVvba+3784IwzSHng/r1IMUu+CH
         8CRYOzTUlXmR8o9JOtoGocZDJEzk5+a7ipJP43AYUpOJlHCLgVBmw4ibGtoGvcMIsAjV
         peUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wOHv+QxDznql2h/B9QPBonJ8+Ax46oQhAeGgxF/JNeY=;
        b=s9W6vS2lhaHE/8mrWFL/1x5o2yreJu4lhTbCt1IydpdcnT0BrlDUqtFzcEC/5yMf9L
         aYUCKs53Jnt7ktAPKOyFoa2gaDjA3mQH83liYwjVnZgyOaJQMuVrhG18z7OviiW+i1pv
         lz82ZOnxEaPzvn1l96Y21GUTiuE2HEA6yEsaPcxbCr8X0LqV+NmF8hlNqucS/PL0S8WV
         Q10smPztmrAbqg+yB8Gna6GBo3FI9dg0nNv4zN/G4YuKKICZFvmyxWVIzh3V27CW5wQ0
         izKd+9ZMHJW9UPUKrpFqTHCaIBpGFWXPgIlMMFMfDBtj5R/4P5iIoMtMiMgkJCwsFpSi
         ZjAA==
X-Gm-Message-State: APjAAAUZhY/XdpACNeR9fvwYGBvyH9iO4XiHxJkZz+ClaWGhS5wmGkUS
        RXzVUB25z1WVk2wY1ex+C9OL9w==
X-Google-Smtp-Source: APXvYqzDQ6HAmjnhvjQifECUMimuCSlgupkPtgBhcHq5XHZ8TdmewbwVVAsZffG/RJMKQi2upxnz0A==
X-Received: by 2002:aa7:9aa5:: with SMTP id x5mr30831744pfi.131.1582175104812;
        Wed, 19 Feb 2020 21:05:04 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id z4sm1400847pfn.42.2020.02.19.21.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 21:05:04 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Todd Kjos <tkjos@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH v4 3/6] pinctrl: Remove use of driver_deferred_probe_check_state_continue()
Date:   Thu, 20 Feb 2020 05:04:37 +0000
Message-Id: <20200220050440.45878-4-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200220050440.45878-1-john.stultz@linaro.org>
References: <20200220050440.45878-1-john.stultz@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

With the earlier sanity fixes to
driver_deferred_probe_check_state() it should be usable for the
pinctrl logic here.

So tweak the logic to use driver_deferred_probe_check_state()
instead of driver_deferred_probe_check_state_continue()

Cc: Rob Herring <robh@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>
Cc: Todd Kjos <tkjos@google.com>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
Change-Id: If72682e0a7641b33edf56f188fc067c68bbc571e
---
 drivers/pinctrl/devicetree.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/devicetree.c b/drivers/pinctrl/devicetree.c
index 9357f7c46cf3..1ed20ac2243f 100644
--- a/drivers/pinctrl/devicetree.c
+++ b/drivers/pinctrl/devicetree.c
@@ -127,11 +127,12 @@ static int dt_to_map_one_config(struct pinctrl *p,
 		np_pctldev = of_get_next_parent(np_pctldev);
 		if (!np_pctldev || of_node_is_root(np_pctldev)) {
 			of_node_put(np_pctldev);
+			ret = driver_deferred_probe_check_state(p->dev);
 			/* keep deferring if modules are enabled unless we've timed out */
-			if (IS_ENABLED(CONFIG_MODULES) && !allow_default)
-				return driver_deferred_probe_check_state_continue(p->dev);
-
-			return driver_deferred_probe_check_state(p->dev);
+			if (IS_ENABLED(CONFIG_MODULES) && !allow_default &&
+			    (ret == -ENODEV))
+				ret = -EPROBE_DEFER;
+			return ret;
 		}
 		/* If we're creating a hog we can use the passed pctldev */
 		if (hog_pctldev && (np_pctldev == p->dev->of_node)) {
-- 
2.17.1

