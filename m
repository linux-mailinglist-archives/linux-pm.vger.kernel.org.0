Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1C91673B2
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2019 19:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbfGLRAw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Jul 2019 13:00:52 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36272 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727486AbfGLRAv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Jul 2019 13:00:51 -0400
Received: by mail-pg1-f195.google.com with SMTP id l21so4799656pgm.3
        for <linux-pm@vger.kernel.org>; Fri, 12 Jul 2019 10:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T5MSBvyW+UnMIf1PMXwWQpclTkJPOBVtLcNCxIfokXY=;
        b=W4pcI9yzebCS/ajeXGrdH4WDZbUsJndTMc7qtATG156f3ffkoMMnM+27/wia2nKDJk
         8+5mV67a7LLoP3HBFS64qyErr1wWta5bAaSdftnGrTPpiVb4PMfGdj4gRSASKJrtE/bk
         y6MZeHXSPOQSGLoKr4GkENL9AUyzztzIy9lqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T5MSBvyW+UnMIf1PMXwWQpclTkJPOBVtLcNCxIfokXY=;
        b=k2CtREAlLIHR5W4uTJq3YvKRN0KD0q6/uYer9hgQ/7k8MXoTsGM5/rYgLGJpJAZFak
         yBrSrRP5OdkZPGQhKGxQQoEyP5ym1Ta3a0OE+yRNTqw7UmpZV7w/XQo/BjbpBeylFLyS
         OPubmRqokIHCmk6mM1bFEvkB2usmBuCN1uB1+qLsCNhtHIyrPVo2/dJqVy7CEQ3KspO/
         FQ0RHuWKnVKdbDF/QQbIl4sIlx+qZstx/ewvK4x+nXuU0XyWhXuFtzdeCGsQa3qDz5kP
         mszhE7e5X2g2sRYWaHcqj3OyucLrx96xt4yMuD4SDLaaWOOogkxN9CnFUlTf9dy/NfeP
         SFeQ==
X-Gm-Message-State: APjAAAV3tlwX2UIwFNCToIe0EBbq2MoQ5Ob/BaVNux0mGpDa/n7SOdq/
        weqnwV1SclFxppLz9Vf6lRk=
X-Google-Smtp-Source: APXvYqzuhVtiWBYlZH/aw0dkC1YS/lLyobD9k2bBGXEKSZ5NHGo/6vz/hQ+QEQLkxRGkEG+1756i7A==
X-Received: by 2002:a65:4489:: with SMTP id l9mr12246140pgq.207.1562950850333;
        Fri, 12 Jul 2019 10:00:50 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id a15sm7127385pgw.3.2019.07.12.10.00.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Jul 2019 10:00:49 -0700 (PDT)
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
Subject: [PATCH v2 4/9] ipv4: add lockdep condition to fix for_each_entry
Date:   Fri, 12 Jul 2019 13:00:19 -0400
Message-Id: <20190712170024.111093-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
In-Reply-To: <20190712170024.111093-1-joel@joelfernandes.org>
References: <20190712170024.111093-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 net/ipv4/fib_frontend.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index b298255f6fdb..ef7c9f8e8682 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -127,7 +127,8 @@ struct fib_table *fib_get_table(struct net *net, u32 id)
 	h = id & (FIB_TABLE_HASHSZ - 1);
 
 	head = &net->ipv4.fib_table_hash[h];
-	hlist_for_each_entry_rcu(tb, head, tb_hlist) {
+	hlist_for_each_entry_rcu(tb, head, tb_hlist,
+				 lockdep_rtnl_is_held()) {
 		if (tb->tb_id == id)
 			return tb;
 	}
-- 
2.22.0.510.g264f2c817a-goog

