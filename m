Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95BD569284
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2019 16:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404427AbfGOOhU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Jul 2019 10:37:20 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34704 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404000AbfGOOhS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jul 2019 10:37:18 -0400
Received: by mail-pg1-f195.google.com with SMTP id n9so1589212pgc.1
        for <linux-pm@vger.kernel.org>; Mon, 15 Jul 2019 07:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=peLCyvMnb6GAqXrVywa8AT70STEJ77uX6TkkVXJzQ/M=;
        b=QjihkdzO56EyWdL1UBrowr4J0diPIpjeawlNo5eUXRlutEI+PMdDLg/2ovhGCm9dB1
         am3dJfpAJ98Tx9IokTbTDJI/QLnhNHnLoi+VI/95oP5fp/RwwQCZGPG9aCEKUlUpO/1N
         atHPVJ+wXVzYcfg26NNOs6IX7iznL6Gp2AAwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=peLCyvMnb6GAqXrVywa8AT70STEJ77uX6TkkVXJzQ/M=;
        b=afrX+cLZmSu+s8WR6M8WG2t+E1ofNVlDyhvhibEtCtFiitQBp8kwfgqVOvd8Oka86B
         nZEi95+/WLHvDP+ppzGtn3yOSx52drqtpmi/Tih5YS9hM5e89OHMqTNcoxK2cQS+NfpH
         XjFfLxAW97DmLhG+Af/9Ktup2IXPvwXNvjZ3UiphRUOmwkq6fgBpLK/+E40AHyP4QDlS
         L/xzfuR5wtA9K7M9cSlZMnt9DhD2F2l+tsGUXwMwGoLhGL9AeJGQNePqrSAS9uNf4dsu
         R6j9uqiWrP23G8ky06PSR4utoscb26gIlXRuvL3w40BlP6N/P9TUPrnf+GqC8PdCBMlM
         LJlQ==
X-Gm-Message-State: APjAAAUEkjlfPURK+kRCyHejtMlcjEy5wwYWVZnvJL89t5elXaNROx89
        amJWt/KtQgLSu5HwYT0hiW4=
X-Google-Smtp-Source: APXvYqzmK9tD8rYXtIru39NtpVyI6dVamC0JOl/Vm3L4KkimM24dL0CBqeO9C1zAEuPYG8wK9FgMFA==
X-Received: by 2002:a65:6281:: with SMTP id f1mr25763664pgv.400.1563201437978;
        Mon, 15 Jul 2019 07:37:17 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id s66sm18381852pfs.8.2019.07.15.07.37.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 07:37:17 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Borislav Petkov <bp@alien8.de>, c0d1n61at3@gmail.com,
        "David S. Miller" <davem@davemloft.net>, edumazet@google.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>, keescook@chromium.org,
        kernel-hardening@lists.openwall.com, kernel-team@android.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        neilb@suse.com, netdev@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Pavel Machek <pavel@ucw.cz>, peterz@infradead.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, will@kernel.org,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Subject: [PATCH 1/9] rcu/update: Remove useless check for debug_locks (v1)
Date:   Mon, 15 Jul 2019 10:36:57 -0400
Message-Id: <20190715143705.117908-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
In-Reply-To: <20190715143705.117908-1-joel@joelfernandes.org>
References: <20190715143705.117908-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In rcu_read_lock_sched_held(), debug_locks can never be true at the
point we check it because we already check debug_locks in
debug_lockdep_rcu_enabled() in the beginning. Remove the check.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/update.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 61df2bf08563..9dd5aeef6e70 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -93,17 +93,13 @@ module_param(rcu_normal_after_boot, int, 0);
  */
 int rcu_read_lock_sched_held(void)
 {
-	int lockdep_opinion = 0;
-
 	if (!debug_lockdep_rcu_enabled())
 		return 1;
 	if (!rcu_is_watching())
 		return 0;
 	if (!rcu_lockdep_current_cpu_online())
 		return 0;
-	if (debug_locks)
-		lockdep_opinion = lock_is_held(&rcu_sched_lock_map);
-	return lockdep_opinion || !preemptible();
+	return lock_is_held(&rcu_sched_lock_map) || !preemptible();
 }
 EXPORT_SYMBOL(rcu_read_lock_sched_held);
 #endif
-- 
2.22.0.510.g264f2c817a-goog

