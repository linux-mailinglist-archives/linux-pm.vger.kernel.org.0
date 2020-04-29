Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F38861BE947
	for <lists+linux-pm@lfdr.de>; Wed, 29 Apr 2020 22:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgD2U6e (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Apr 2020 16:58:34 -0400
Received: from mail-oo1-f67.google.com ([209.85.161.67]:38293 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgD2U6d (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Apr 2020 16:58:33 -0400
Received: by mail-oo1-f67.google.com with SMTP id i9so760486ool.5;
        Wed, 29 Apr 2020 13:58:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fvDZPYS6H9HDGHwxJM3nkwWID3WCQsyjXK3Xs8Lgdrk=;
        b=aXxrIfe0b3Iyr0yqI4Iwf//euiHI8q0gf1hVQ055ZY4e4SE1DaSclmEA8WiHVigPVo
         JTpNElj0kt+BGd2AAS+J5f+UUplHsUT+2MnnEs9YUNtDD04BZLfgtflQgsLyW+QZWGiB
         ZfsJhilbqcvVMkVxLs+vFN+7q2b69II/t4Ysb+/2IRYZp+jK/AnN1Syn8iXa2BKx015t
         1NnFJJ5Bt183oHVDbdKvDrhXD0HejsDXREVQlX+/QKNcA7wY+ygRqeBp4JJ/7hKXD7k7
         d4YoO6xLcZnO/e8jMyf7ltChbuPgCbYk5iAkWaYFTlGCuOfx04PwfsxI0at5xqa0MtUP
         YVvw==
X-Gm-Message-State: AGi0PubKHj7enNE7mm1MK+gWxjLld+jniBH26m20NPpdZ8DGrdAfhRsP
        iAyK0dt8CRWUYM8ZtMqbWA==
X-Google-Smtp-Source: APiQypLli0R0MaoqAgHiLNWiKMhf+xW515Euvb/NrzLKICWLWGqC2Ukck1Jb9yu3tupivtQoI9YbHw==
X-Received: by 2002:a4a:2fd3:: with SMTP id p202mr28859228oop.33.1588193912719;
        Wed, 29 Apr 2020 13:58:32 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id z13sm653162oth.10.2020.04.29.13.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 13:58:31 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, John Stultz <john.stultz@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH v2 03/16] amba: Retry adding deferred devices at late_initcall
Date:   Wed, 29 Apr 2020 15:58:12 -0500
Message-Id: <20200429205825.10604-4-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200429205825.10604-1-robh@kernel.org>
References: <20200429205825.10604-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

If amba bus devices defer when adding, the amba bus code simply retries
adding the devices every 5 seconds. This doesn't work well as it
completely unsynchronized with starting the init process which can
happen in less than 5 secs. Add a retry during late_initcall. If the
amba devices are added, then deferred probe takes over. If the
dependencies have not probed at this point, then there's no improvement
over previous behavior. To completely solve this, we'd need to retry
after every successful probe as deferred probe does.

The list_empty() check now happens outside the mutex, but the mutex
wasn't necessary in the first place.

This needed to use deferred probe instead of fragile initcall ordering
on 32-bit VExpress systems where the apb_pclk has a number of probe
dependencies (vexpress-sysregs, vexpress-config).

Cc: John Stultz <john.stultz@linaro.org>
Cc: Saravana Kannan <saravanak@google.com>
Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Russell King <linux@armlinux.org.uk>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Tested-by: Sudeep Holla <sudeep.holla@arm.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/amba/bus.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index fe1523664816..e797995fc65b 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -505,7 +505,7 @@ static DECLARE_DELAYED_WORK(deferred_retry_work, amba_deferred_retry_func);

 #define DEFERRED_DEVICE_TIMEOUT (msecs_to_jiffies(5 * 1000))

-static void amba_deferred_retry_func(struct work_struct *dummy)
+static int amba_deferred_retry(void)
 {
 	struct deferred_device *ddev, *tmp;

@@ -521,11 +521,19 @@ static void amba_deferred_retry_func(struct work_struct *dummy)
 		kfree(ddev);
 	}

+	mutex_unlock(&deferred_devices_lock);
+
+	return 0;
+}
+late_initcall(amba_deferred_retry);
+
+static void amba_deferred_retry_func(struct work_struct *dummy)
+{
+	amba_deferred_retry();
+
 	if (!list_empty(&deferred_devices))
 		schedule_delayed_work(&deferred_retry_work,
 				      DEFERRED_DEVICE_TIMEOUT);
-
-	mutex_unlock(&deferred_devices_lock);
 }

 /**
--
2.20.1
