Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3206191D03
	for <lists+linux-pm@lfdr.de>; Tue, 24 Mar 2020 23:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbgCXWpn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Mar 2020 18:45:43 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34808 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728428AbgCXWpm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Mar 2020 18:45:42 -0400
Received: by mail-lj1-f195.google.com with SMTP id p10so232467ljn.1;
        Tue, 24 Mar 2020 15:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nZnryKytso1ZYRkSpMtMSAQGQFfGmBLvG2yuSqscEJw=;
        b=gLuEIvUmPczlzxnWAp0Rql4/wGU4KU+CC7ROBviiX4S4CwdI6K/KMwJe9oik7yTw14
         KDY/kUFSjLQCupaLkF5wkeFrhtfY8DCLN+xej1yj9jP5nNH2iRVSEvIM61kOEHkhW6VF
         BcMaCJh6rVwKiMTB0LVqkDdBokDXPO9HoxRDUZH48rsQKrVlh/UpEwjZAprPkRA9qaNv
         Zfzj16jqNhfEdidnPyrk9B/3LJi2rv5Bo62+Mg6m55L29iNE7tbYjVg1fefl9dg7LnYK
         d5/hVcPdFoGRrOpSsWYvIatqzOXSOGxN2t7QmEI9uX8vF9EIiPLRGXso9C0FSfdd5xWn
         kmIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nZnryKytso1ZYRkSpMtMSAQGQFfGmBLvG2yuSqscEJw=;
        b=S6hyqSXs1dQC3YiVtR49sAngZrffCocVMF0qejrh2Z32KQkuclneUhfvLKkBP1XCMU
         Og25C6lhZgexx+cinadyv/8ZA6p3Ce1LDZFJqHuI9ZkU5UltG97SR9TJy5AEfUSJQvoZ
         GBq8RkSye+lLSQXKBbZSkE0Q+WNyK1B8huRhULPmDVfBYBeRwcKjlujhyJLMIuJTXkQa
         4Zy6lzYXspgWVZrQLDP/RgF0syga97aABn8hQufCtYenlNB0Rxmmf4Qj8Jhc4bTAxT4S
         PFYbwETrp/WmYJYMUWIkm4csnvPUbO89I0M8k1vMFzWAJ0856SUrkUoF86PvO8WeW/my
         +HHA==
X-Gm-Message-State: AGi0PuY4MqiGzn+cT1IBJ8tChXQMKSEn6ptQX0pS2ffk3IL8VoBZUuhE
        zg7gl3/0jAYdUl4vEsD4CCP5ZiKy
X-Google-Smtp-Source: APiQypJ8wQXTKirLKDTVstbN6/k+c8vXzM+qdDOvQd2IoLzp7nwIH82W8GtePSWRJfdjhfsAoYQ+xw==
X-Received: by 2002:a2e:80cd:: with SMTP id r13mr28124ljg.224.1585089939928;
        Tue, 24 Mar 2020 15:45:39 -0700 (PDT)
Received: from localhost.localdomain (94-29-39-224.dynamic.spd-mgts.ru. [94.29.39.224])
        by smtp.gmail.com with ESMTPSA id d4sm10534279lfa.75.2020.03.24.15.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 15:45:39 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Jasper Korten <jja2000@gmail.com>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/3] ARM: tegra: Initialize r0 register for firmware wake-up
Date:   Wed, 25 Mar 2020 01:43:33 +0300
Message-Id: <20200324224335.5825-2-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200324224335.5825-1-digetx@gmail.com>
References: <20200324224335.5825-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Downstream kernel of ASUS TF300T sets r0 to #3. There is no explanation in
downstream code whether this is really needed and some of T30 downstream
kernels have and explicit comment telling that all arguments are ignored
by firmware. Let's take a safe side by replicating behavior of the TF300T
downstream kernel. This change works fine on Ouya and Nexus 7 devices.

Tested-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Tested-by: Jasper Korten <jja2000@gmail.com>
Tested-by: David Heidelberg <david@ixit.cz>
Tested-by: Peter Geis <pgwipeout@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/reset-handler.S | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S
index 53123ae4ac3b..06ca44b09381 100644
--- a/arch/arm/mach-tegra/reset-handler.S
+++ b/arch/arm/mach-tegra/reset-handler.S
@@ -98,7 +98,12 @@ ENTRY(tegra_resume_trusted_foundations)
 	reteq	lr
 
  .arch_extension sec
-	/* First call after suspend wakes firmware. No arguments required. */
+	/*
+	 * First call after suspend wakes firmware. No arguments required
+	 * for some firmware versions. Downstream kernel of ASUS TF300T uses
+	 * r0=3 for the wake-up notification.
+	 */
+	mov	r0, #3
 	smc	#0
 
 	b	cpu_resume
-- 
2.25.1

