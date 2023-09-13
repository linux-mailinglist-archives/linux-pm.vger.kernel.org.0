Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C789879DCF7
	for <lists+linux-pm@lfdr.de>; Wed, 13 Sep 2023 02:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236963AbjIMAH1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Sep 2023 20:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235846AbjIMAH0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Sep 2023 20:07:26 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C5B1708
        for <linux-pm@vger.kernel.org>; Tue, 12 Sep 2023 17:07:22 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58fc448ee4fso68011837b3.2
        for <linux-pm@vger.kernel.org>; Tue, 12 Sep 2023 17:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694563642; x=1695168442; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rS41v4+xCLukMHjrW3MQeGbkMoVH4JjPq9tKkeyfYe0=;
        b=r/ms0MahvvLg1nsm9lhDohSbOVvs1L7d74dODp2hppTOQ/vw9bEW0QyMN/JiWDaFEk
         29nLDqYTg/nGjJqyEj7+fTr/jVsRNLhbZR+brsIbzh5wdg7LlhxtDbtSGHVeCAJYIovc
         c542UyNxiJixMZ0XRRGna+q/kdEA5vysSLkERBDF3BM/5i/P9wbynsJf8FKRXaWNSpTf
         2cM2SI1pUNyAxTIurK3nPFahSpTgDs+ZqZmT0z8a+FeLdcYVEKEHZKKfzkw79n7zh/DB
         5vewTu+5WTTaThk4ZsdPR62caPvKiUwGWDQXOHWwC7v4+HMJHgfUHZ/KiYZ0gV+EO6K0
         mZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694563642; x=1695168442;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rS41v4+xCLukMHjrW3MQeGbkMoVH4JjPq9tKkeyfYe0=;
        b=uaBr04JT+7H1+vJf+kK4HghNjoSOHiue/F+f2zEEyi1sc+CUr/BfZdtxZrKUgl0oQ5
         oVKpQaRWvIMo+I3qTq6vYTdtlYBqBDb7mqwetR8ym9E2JSTSQJAVP31U9Oz81+cht1D/
         7ETJ4LGTaZMkofxhshioHLAqPra+XyLu7uidOBT2GoZ5ySFIu84amgx8ajNXZTaz2zKk
         9Z9h8XKHg53RshnGSaIhLMH2UrGQ9gvfcl3mKHdYe98KROq3iblkElgD/2sOOnTGOdeS
         vFmHkbndg0WhbDpR/TA9/59wNXuBznTQedI0kt79ptd3t4wJ5m3MCWZROHE0tLAgob5K
         G81Q==
X-Gm-Message-State: AOJu0YwJ9ft5oWchPJ15yyCHfp04KMeavE6/mQlU8o2IS7DV7gGgijMX
        m1Q9w9G0RlPt6wfOlc6yUQep6X2ZcbwqCatv4g==
X-Google-Smtp-Source: AGHT+IHIVm0Y6CAUhP6pTC/2mO7JZoleKN3YbmYHQgE9jlZqdE0XdYPULc48BnN1X81SSWxwtvxK4rrqznD65lYe/w==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:c708:0:b0:d47:4b58:a19e with SMTP
 id w8-20020a25c708000000b00d474b58a19emr23433ybe.11.1694563642045; Tue, 12
 Sep 2023 17:07:22 -0700 (PDT)
Date:   Wed, 13 Sep 2023 00:07:21 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIADj9AGUC/0WNMQ6DMAwAv4I815ITkIB+pepQEgNe0tQuqAjxd
 6IuTKdb7nYwVmGDe7WD8iom71TE3SoI8ytNjBKLgydfU+882ldTyBtGlZXVMORlVP5cRBc7Imq agaiF0snKo/z+j8fzOE45Cw4wcwAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694563641; l=1848;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=d3eQRnRSox3gQAlO9beeck6HgLvQ+IwgKHU5fYXPsic=; b=jGth39PpsB/iSIfhy+Tf1rrdgm6kZNr+Tn0YEGuIUABXOvuFXngcCGXpB1DsuuWOFHCV0K07J
 SXvBj9oQFzDAQ3vAMxAu789ZhsgNqJwmeEHaN9k4hPqccCKoOLw2uBa
X-Mailer: b4 0.12.3
Message-ID: <20230913-strncpy-drivers-cpufreq-cpufreq-c-v1-1-f1608bfeff63@google.com>
Subject: [PATCH] cpufreq: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

We should prefer more robust and less ambiguous string interfaces.

Both `policy->last_governor` and `default_governor` are expected to be
NUL-terminated which is shown by their heavy usage with other string
apis like `strcmp`.

A suitable replacement is `strscpy` [2] due to the fact that it guarantees
NUL-termination on the destination buffer.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested
---
 drivers/cpufreq/cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 50bbc969ffe5..3eb851a03fce 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1607,7 +1607,7 @@ static void __cpufreq_offline(unsigned int cpu, struct cpufreq_policy *policy)
 	}
 
 	if (has_target())
-		strncpy(policy->last_governor, policy->governor->name,
+		strscpy(policy->last_governor, policy->governor->name,
 			CPUFREQ_NAME_LEN);
 	else
 		policy->last_policy = policy->policy;
@@ -2951,7 +2951,7 @@ static int __init cpufreq_core_init(void)
 	BUG_ON(!cpufreq_global_kobject);
 
 	if (!strlen(default_governor))
-		strncpy(default_governor, gov->name, CPUFREQ_NAME_LEN);
+		strscpy(default_governor, gov->name, CPUFREQ_NAME_LEN);
 
 	return 0;
 }

---
base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
change-id: 20230912-strncpy-drivers-cpufreq-cpufreq-c-1d800044b007

Best regards,
--
Justin Stitt <justinstitt@google.com>

