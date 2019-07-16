Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2896A12F
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 06:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfGPEH5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 00:07:57 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36993 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbfGPEH5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2019 00:07:57 -0400
Received: by mail-pf1-f196.google.com with SMTP id 19so8427367pfa.4
        for <linux-pm@vger.kernel.org>; Mon, 15 Jul 2019 21:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rmC6wxi5sfJ1hgZ1T5d4GnYkV6yYjgLN1LSLJD9G/N4=;
        b=Kq0teeTexfzjIuo8X5x7eq1y/4O5B2Bmjf3Fma8qxHKz570TnWd5F41ARTOX+ZB9o5
         ZrA8d8qX6imHshG3/BIhlS9G3/USuQssQxWSRVgYqXyJ69AtXg6PA4i/A/poj8yG+f0m
         jjDlhK3uHe61XmDCNPq7CEmNnt62VWeTQWFEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rmC6wxi5sfJ1hgZ1T5d4GnYkV6yYjgLN1LSLJD9G/N4=;
        b=KxHpAu6EHT0q5vhD9NlSYRrlJU38ILt7ez3Erf+EnqrIdzuvnR7qBCB2yXeTL2bC1i
         X39pGUtRkPOAvEP8IAcQ6RxXpw3NNvUtahOuXEIY1J/gW7U0DviyI1Syw4yyA21tzd2I
         Y75pEeeaj86RdDXwu+fFnvsKSstvhBSv3/qg9WmKQ2tKSFk8NlM0pQ+/IPNwByA3wsa8
         klIlpQKlo6EkkthDBpYBa2LPa2a1cJcY3GgGGVq62SgVNCHZEQQLgw9AA68R//SczQZH
         vVjFACHwxkXP07VYSRHxk44OHh6ygOzu92ipvLdamb8ZGkptA4D0zciI3lf8De04w4pK
         KmBw==
X-Gm-Message-State: APjAAAXLR8vKwQRIVaL93aNuJZ8T2mjBtSq2Yl5e40uo0Wxhk+OzKfr9
        Q6JWxF251fc4ARCx8qprjSc=
X-Google-Smtp-Source: APXvYqzgpmFKYjtDybWIlQwIoYF/PfoRh5ad2Zk33yjjz2GZk9FWUyWvHOfYTa/TTjzB9GZPuRionw==
X-Received: by 2002:a63:9249:: with SMTP id s9mr29860119pgn.356.1563250076442;
        Mon, 15 Jul 2019 21:07:56 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id f14sm17867883pfn.53.2019.07.15.21.07.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 21:07:55 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
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
Subject: [PATCH] rculist: Add build check for single optional list argument
Date:   Tue, 16 Jul 2019 00:07:43 -0400
Message-Id: <20190716040743.78343-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In a previous patch series [1], we added an optional lockdep expression
argument to list_for_each_entry_rcu() and the hlist equivalent. This
also meant more than one optional argument can be passed to them with
that error going unnoticed. To fix this, let us force a compiler error
more than one optional argument is passed.

[1] https://lore.kernel.org/patchwork/project/lkml/list/?series=402150

Suggested-by: Paul McKenney <paulmck@linux.vnet.ibm.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/rculist.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/rculist.h b/include/linux/rculist.h
index 1048160625bb..86659f6d72dc 100644
--- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -44,14 +44,18 @@ static inline void INIT_LIST_HEAD_RCU(struct list_head *list)
  * Check during list traversal that we are within an RCU reader
  */
 
+#define check_arg_count_one(dummy)
+
 #ifdef CONFIG_PROVE_RCU_LIST
-#define __list_check_rcu(dummy, cond, ...)				\
+#define __list_check_rcu(dummy, cond, extra...)				\
 	({								\
+	check_arg_count_one(extra);					\
 	RCU_LOCKDEP_WARN(!cond && !rcu_read_lock_any_held(),		\
 			 "RCU-list traversed in non-reader section!");	\
 	 })
 #else
-#define __list_check_rcu(dummy, cond, ...) ({})
+#define __list_check_rcu(dummy, cond, extra...)				\
+	({ check_arg_count_one(extra); })
 #endif
 
 /*
-- 
2.22.0.510.g264f2c817a-goog

