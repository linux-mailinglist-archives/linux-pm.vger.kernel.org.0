Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D24424D03
	for <lists+linux-pm@lfdr.de>; Thu,  7 Oct 2021 08:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240198AbhJGGGN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Oct 2021 02:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236269AbhJGGGM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Oct 2021 02:06:12 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518E4C061746;
        Wed,  6 Oct 2021 23:04:19 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id t63so233341qkf.1;
        Wed, 06 Oct 2021 23:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v5unlXCCWgJvBuiCzfmTWdVp+0Woi4JIlep2S0jg/Jg=;
        b=djDZ3VVzEuq+g6PpAWrSfzJ66Vx0pTytlQ/lS7gK+I/nLTSev9ao73O87hbf2SMHoI
         xSPsh4G8whRRQZcd6BKdPWe+RuSRNLhg4pDJdeCc6Azevb1Gm0E/TZ6hl5HyPlv0Hj+0
         53CosM1BI5ZLS4Sy7Mllt7qheBmETj9wCoYU+eBRD0MXRgMx+nuQSVze1bw3Uu4W31fJ
         FhLIC0dbLA43JEMKPU6nVnYetM+3fNrsZsHcTjbPU/wniBnFtyl33MtN79xlG72lToJW
         XfqLfaRD/OeCZxO619jrc0kzZdd5cI1DINmftTs3dkGXz9si+ZtPOzEsO10+nv6N0BMf
         7GMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v5unlXCCWgJvBuiCzfmTWdVp+0Woi4JIlep2S0jg/Jg=;
        b=uS0er/Nkq5DVyrA8Is4LC1KxQC7yQ7QVFArFVWBLfaE8i5KA00Owe+/vk21GsdTldh
         J7prNaeUku0UviUsuY6b6Fo9/ubYSM+Pi1EGRQQhWc5UJUdX0zV7wYQfy60z5yRfVUna
         JQBukPZl4BTsr5odQisg58wnoEuJekLXQwT39oDgFQnSjGx0FupiK1s8PClldaqwCWvA
         HhY6xqJSZo89tASRgApc4feK0ir/SPGJc6qHwHRvF9zz1NSGWvosGLVOOeCzgPBt6mOz
         bNSZ9yzseSlF3nfPhJpKz7H3YS7k77ocV3T0Pv2Z4KL8UFQEN7zZ/ZmRsijTBocZpOX6
         6WCA==
X-Gm-Message-State: AOAM533mx9s1ysotpERk2FrEKUVkdjzJugvGO3HQ1h8yCSML6m9Am1Zu
        1smtloY3AYu5sG6mWQu/0VQ=
X-Google-Smtp-Source: ABdhPJw++YRw2AnjUldzLepuhyAXxTxqpKrn6q7pDcxn4xqZTAndK6khEp4qEXUbFjcj+97I7NN9zA==
X-Received: by 2002:a37:4658:: with SMTP id t85mr1793774qka.195.1633586658472;
        Wed, 06 Oct 2021 23:04:18 -0700 (PDT)
Received: from localhost.localdomain (79-139-163-57.dynamic.spd-mgts.ru. [79.139.163.57])
        by smtp.gmail.com with ESMTPSA id x79sm13235042qkb.65.2021.10.06.23.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 23:04:18 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v1 2/6] kernel: Add power off handler call chain API
Date:   Thu,  7 Oct 2021 09:02:49 +0300
Message-Id: <20211007060253.17049-3-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211007060253.17049-1-digetx@gmail.com>
References: <20211007060253.17049-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SoC platforms often have multiple options for performing system's
power off. Meanwhile kernel is limited to a single option. Add power off
handler call chain API, which is inspired by the restart API. The old
pm_power_off method will be kept around till all drivers are converted
to the new API.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 include/linux/reboot.h |   5 ++
 kernel/reboot.c        | 111 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 115 insertions(+), 1 deletion(-)

diff --git a/include/linux/reboot.h b/include/linux/reboot.h
index af907a3d68d1..f72fb8729608 100644
--- a/include/linux/reboot.h
+++ b/include/linux/reboot.h
@@ -49,6 +49,11 @@ extern int register_restart_handler(struct notifier_block *);
 extern int unregister_restart_handler(struct notifier_block *);
 extern void do_kernel_restart(char *cmd);
 
+extern int register_poweroff_handler(struct notifier_block *);
+extern int unregister_poweroff_handler(struct notifier_block *);
+
+extern int devm_register_poweroff_handler(struct device *, struct notifier_block *);
+
 /*
  * Architecture-specific implementations of sys_reboot commands.
  */
diff --git a/kernel/reboot.c b/kernel/reboot.c
index f7440c0c7e43..6e90afec2bb8 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -280,6 +280,113 @@ void kernel_halt(void)
 }
 EXPORT_SYMBOL_GPL(kernel_halt);
 
+/*
+ *	Notifier list for kernel code which wants to be called
+ *	to power off the system.
+ */
+static BLOCKING_NOTIFIER_HEAD(poweroff_handler_list);
+
+/**
+ *	register_poweroff_handler - Register function to be called to power off
+ *				    the system
+ *	@nb: Info about handler function to be called
+ *	@nb->priority:	Handler priority. Handlers should follow the
+ *			following guidelines for setting priorities.
+ *			0:	Poweroff handler of last resort,
+ *				with limited poweroff capabilities
+ *			128:	Default poweroff handler; use if no other
+ *				poweroff handler is expected to be available,
+ *				and/or if poweroff functionality is
+ *				sufficient to poweroff the entire system
+ *			255:	Highest priority poweroff handler, will
+ *				preempt all other poweroff handlers
+ *
+ *	Registers a function with code to be called to power off the
+ *	system.
+ *
+ *	Registered functions will be called as last step of the poweroff
+ *	sequence.
+ *
+ *	Registered functions are expected to power off the system immediately.
+ *	If more than one function is registered, the poweroff handler priority
+ *	selects which function will be called first.
+ *
+ *	Poweroff handlers are expected to be registered from non-architecture
+ *	code, typically from drivers. A typical use case would be a system
+ *	where poweroff functionality is provided through a PMIC. Multiple
+ *	poweroff handlers may exist; for example, one poweroff handler might
+ *	turn off the entire system, while another only turns off part of
+ *	system. In such cases, the poweroff handler which only disables part
+ *	of the hardware is expected to register with low priority to ensure
+ *	that it only runs if no other means to power off the system is
+ *	available.
+ *
+ *	Currently always returns zero, as blocking_notifier_chain_register()
+ *	always returns zero.
+ */
+int register_poweroff_handler(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&poweroff_handler_list, nb);
+}
+EXPORT_SYMBOL(register_poweroff_handler);
+
+/**
+ *	unregister_poweroff_handler - Unregister previously registered
+ *				      poweroff handler
+ *	@nb: Hook to be unregistered
+ *
+ *	Unregisters a previously registered poweroff handler function.
+ *
+ *	Returns zero on success, or %-ENOENT on failure.
+ */
+int unregister_poweroff_handler(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&poweroff_handler_list, nb);
+}
+EXPORT_SYMBOL(unregister_poweroff_handler);
+
+static void devm_unregister_poweroff_handler(struct device *dev, void *res)
+{
+	WARN_ON(unregister_poweroff_handler(*(struct notifier_block **)res));
+}
+
+int devm_register_poweroff_handler(struct device *dev, struct notifier_block *nb)
+{
+	struct notifier_block **rcnb;
+	int ret;
+
+	rcnb = devres_alloc(devm_unregister_poweroff_handler,
+			    sizeof(*rcnb), GFP_KERNEL);
+	if (!rcnb)
+		return -ENOMEM;
+
+	ret = register_poweroff_handler(nb);
+	if (!ret) {
+		*rcnb = nb;
+		devres_add(dev, rcnb);
+	} else {
+		devres_free(rcnb);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(devm_register_poweroff_handler);
+
+/**
+ *	do_kernel_power_off - Execute kernel poweroff handler call chain
+ *
+ *	Calls functions registered with register_poweroff_handler.
+ *
+ *	Expected to be called as last step of the poweroff sequence.
+ *
+ *	Powers off the system immediately if a poweroff handler function has
+ *	been registered. Otherwise does nothing.
+ */
+static void do_kernel_power_off(void)
+{
+	blocking_notifier_call_chain(&poweroff_handler_list, 0, NULL);
+}
+
 /**
  *	kernel_power_off - power_off the system
  *
@@ -295,6 +402,7 @@ void kernel_power_off(void)
 	pr_emerg("Power down\n");
 	kmsg_dump(KMSG_DUMP_SHUTDOWN);
 	machine_power_off();
+	do_kernel_power_off();
 }
 EXPORT_SYMBOL_GPL(kernel_power_off);
 
@@ -339,7 +447,8 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
 	/* Instead of trying to make the power_off code look like
 	 * halt when pm_power_off is not set do it the easy way.
 	 */
-	if ((cmd == LINUX_REBOOT_CMD_POWER_OFF) && !pm_power_off)
+	if ((cmd == LINUX_REBOOT_CMD_POWER_OFF) && !pm_power_off &&
+	    blocking_notifier_call_chain_empty(&poweroff_handler_list))
 		cmd = LINUX_REBOOT_CMD_HALT;
 
 	mutex_lock(&system_transition_mutex);
-- 
2.32.0

