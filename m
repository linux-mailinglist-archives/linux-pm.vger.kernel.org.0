Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB21673E5
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2019 19:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfGLRBp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Jul 2019 13:01:45 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46435 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727370AbfGLRAi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Jul 2019 13:00:38 -0400
Received: by mail-pf1-f195.google.com with SMTP id c73so4544587pfb.13
        for <linux-pm@vger.kernel.org>; Fri, 12 Jul 2019 10:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HcJl4MkrcKZUWVrbOFfh0nnEc2FkI1NyULrXND4C1ok=;
        b=r+S4YTbrFLXAaoxGT4GzejGKAZshIM9bV3jcdcbEAdv0c619zHSqLN4ei3n7OXVNx6
         n8Mkpq4NMeAreqKp6CxwsDaUWLUdSJGaBd+a1NpA03X4d2w8pRoRmAK3YM7By8+HEacE
         0fDSDMaBiifV8te0r9UChxgacvAyvBEzMCd4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HcJl4MkrcKZUWVrbOFfh0nnEc2FkI1NyULrXND4C1ok=;
        b=jeB9ZYwdlQSGbaAs5K35me99BjO/wlcll3Mdg9aR9I9j+SV76Hof1LuRq0I9yRjGiA
         lEpHZ/arPlkTLYrrKEUDslUngqKvOeJDMaWGVGvorTxCmsJG1dVPbfo/Fs8N/4VmLkN7
         w4WLLvBpUlBfQWQI/jKfgQlKmogDJL+agQKWCc6MTEGXkxMaVHN5AJVHWdFoID9+0MXt
         6kdIao2cpNIF7x2L6LDeOLkscAS8FD56deHatHCd+1ReteQCTS912fwDwtSC9Sem5+Cr
         tbofrLBWJvaUqTigwCYaOtli3UJmkbDvlsSIW0RGP1Nsyjz9HKszzk9/6wQzXkUQLkUf
         KiZA==
X-Gm-Message-State: APjAAAXRNMtezQR103DbJBML/+POZQHAVkYUjeyTQJTLssVf1LMyTRcP
        MK+15LV99sUJ92V6k7jAuJo=
X-Google-Smtp-Source: APXvYqz15AQfC5v0dP6hN1pCpPQdyBrMqETAncc2VKUY67QfxtlC3x1zPGrp7KZtSsMpaH2x5QNcdQ==
X-Received: by 2002:a17:90b:8c8:: with SMTP id ds8mr13144837pjb.89.1562950837630;
        Fri, 12 Jul 2019 10:00:37 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id a15sm7127385pgw.3.2019.07.12.10.00.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Jul 2019 10:00:36 -0700 (PDT)
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
Subject: [PATCH v2 1/9] rcu/update: Remove useless check for debug_locks
Date:   Fri, 12 Jul 2019 13:00:16 -0400
Message-Id: <20190712170024.111093-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
In-Reply-To: <20190712170024.111093-1-joel@joelfernandes.org>
References: <20190712170024.111093-1-joel@joelfernandes.org>
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
index c3bf44ba42e5..bb961cd89e76 100644
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

