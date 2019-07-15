Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF04E693C1
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2019 16:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732552AbfGOOoy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Jul 2019 10:44:54 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38453 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404547AbfGOOh1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jul 2019 10:37:27 -0400
Received: by mail-pl1-f193.google.com with SMTP id az7so8391509plb.5
        for <linux-pm@vger.kernel.org>; Mon, 15 Jul 2019 07:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z+lAujGo7GrSG40jkK2/203/pKxvTLE13nrgeKcOwgI=;
        b=AUubZl4ETLIsW/m5dgXLBulJXDHc0BCosX1eCwyxi+94m0Nn+UMJmqa85ypsCsZq1j
         xz0LM9usgNKyVFOetyi7Bh0t5cemvEnRKdil/TVdpWNJXsluRFLQGvr0RhdUuQJTVlAU
         AAiUQF4zYjdlsdkxFoX9G9U8IN3eAZ1c3LtuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z+lAujGo7GrSG40jkK2/203/pKxvTLE13nrgeKcOwgI=;
        b=nei5SJNxjizwZ8jn2ui6EAX9YEuwcsSIOnUuZfaicRkyPwJTXs0N53ymljxjb1B9He
         KPho58ayW0RpvTyYvI8gwEvuJ+/Hw0EkP3EIGzfu/viBc4s6MI5bUgLaqo/QWT8Cf4XZ
         7Sv1hVKB9Pn1qClid9QYdshSMO4Lb2tvSsEAsO6KcqEHnEoAS4fbjI2XYaCIyrM3NLvQ
         FpolZ/PW93RTHzb+g7daUquKWFXvyQO/WYDfyKk5S6rxfm3kq8ssRM30sYGoi2ND4Fzk
         OE9NZxx8ue4f/vYslq8Sv62oXJL0HKf7NDL/hV4DAm4IC1M65RXu947k0hKPFe+BHd1k
         I+HA==
X-Gm-Message-State: APjAAAX7V+tpHJ2OCTu93uPiaGJxq7+AOncScpino9GH91AP64MGuPFv
        CpfqgYYx0QCS2WaDKetuRmO8advK
X-Google-Smtp-Source: APXvYqyfIIGoLXgS2oKcW7Wk3sDCdph3kdkFQYwRHA7oKCzkGjxEv3JlpE2AZDMyjbjqgNcrkFD7WQ==
X-Received: by 2002:a17:902:8649:: with SMTP id y9mr28192780plt.289.1563201446297;
        Mon, 15 Jul 2019 07:37:26 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id s66sm18381852pfs.8.2019.07.15.07.37.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 07:37:25 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Oleg Nesterov <oleg@redhat.com>,
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
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Pavel Machek <pavel@ucw.cz>, peterz@infradead.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, will@kernel.org,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Subject: [PATCH 3/9] rcu/sync: Remove custom check for reader-section (v2)
Date:   Mon, 15 Jul 2019 10:36:59 -0400
Message-Id: <20190715143705.117908-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
In-Reply-To: <20190715143705.117908-1-joel@joelfernandes.org>
References: <20190715143705.117908-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The rcu/sync code was doing its own check whether we are in a reader
section. With RCU consolidating flavors and the generic helper added in
this series, this is no longer need. We can just use the generic helper
and it results in a nice cleanup.

Cc: Oleg Nesterov <oleg@redhat.com>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/rcu_sync.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/rcu_sync.h b/include/linux/rcu_sync.h
index 9b83865d24f9..0027d4c8087c 100644
--- a/include/linux/rcu_sync.h
+++ b/include/linux/rcu_sync.h
@@ -31,9 +31,7 @@ struct rcu_sync {
  */
 static inline bool rcu_sync_is_idle(struct rcu_sync *rsp)
 {
-	RCU_LOCKDEP_WARN(!rcu_read_lock_held() &&
-			 !rcu_read_lock_bh_held() &&
-			 !rcu_read_lock_sched_held(),
+	RCU_LOCKDEP_WARN(!rcu_read_lock_any_held(),
 			 "suspicious rcu_sync_is_idle() usage");
 	return !READ_ONCE(rsp->gp_state); /* GP_IDLE */
 }
-- 
2.22.0.510.g264f2c817a-goog

