Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFC3F320E6
	for <lists+linux-pm@lfdr.de>; Sun,  2 Jun 2019 00:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbfFAW1y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 1 Jun 2019 18:27:54 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44251 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbfFAW1y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 1 Jun 2019 18:27:54 -0400
Received: by mail-pf1-f196.google.com with SMTP id x3so2825169pff.11
        for <linux-pm@vger.kernel.org>; Sat, 01 Jun 2019 15:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D3sdCrSta+1LinDxkJqXRJ9YdXWa10ctUItDBKvA25M=;
        b=gHAEz0W9Uu6qrM4ChuzLYGhD2n+4olfOU6qtJoOTBMe07a7Pc4Kg4feW7OCrB0FNOD
         pQJX/g4h2kdJiFQw/ZIM4s5GiPaQM2j5/cGGfHCrCR2g/GZ5h0YzW+8SpyH7GWKKIGYX
         JsyoEKMQELkCHYwUEweS6UvTXF7q7XQ+nsWJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D3sdCrSta+1LinDxkJqXRJ9YdXWa10ctUItDBKvA25M=;
        b=j25aQT9+tT5HZnrswkog0FBPl+KNCvH3JNqKcZInH1+leL1PTgwLeNLPIulm63g+5i
         HpWkU68b3c6bVCyzQ/Nk7ULa49DEgZ+9riJAKl6maLg1ZSFuS15OvzFGuxHJ5R90xwKa
         BX5IXPXfR/NGiN36h7dptrnhW8/g2+mNfNpTpqFnBmeZMHP/BHO+6rblqYtKHzcHnRhk
         B/P6XybTiPS+BCCrH/7ixAZNQ0aVoCYEDf/AsWGHaRuzfH+Xg+rMmr0rVoiZ3oARDUQa
         FTDulFYly5LDY5hXLBeoNx2sRhpUtVVxGsSoW/7TvnmUJDQuWgB3W1uQ8oucKmNPk2Qn
         Cmzg==
X-Gm-Message-State: APjAAAX57hkmuOk4KJkhY1lw4qsJeIaq1vngn7cZrRrzBHq7kSp8qnuD
        ti/YppUMFhFYSvnT5wA7vwzGpg==
X-Google-Smtp-Source: APXvYqyzFAgWiq9Zmv6qgFmEjp82uhykmH3iEDVhVPdvKHGIbsKdjW+zFeDMBpdGsYU3yEg7JY6LEQ==
X-Received: by 2002:a62:a511:: with SMTP id v17mr19913167pfm.129.1559428073227;
        Sat, 01 Jun 2019 15:27:53 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id t33sm9908018pjb.1.2019.06.01.15.27.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 01 Jun 2019 15:27:52 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>, edumazet@google.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>, keescook@chromium.org,
        kernel-hardening@lists.openwall.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        neilb@suse.com, netdev@vger.kernel.org, oleg@redhat.com,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Pavel Machek <pavel@ucw.cz>, peterz@infradead.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Subject: [RFC 2/6] ipv4: add lockdep condition to fix for_each_entry
Date:   Sat,  1 Jun 2019 18:27:34 -0400
Message-Id: <20190601222738.6856-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
In-Reply-To: <20190601222738.6856-1-joel@joelfernandes.org>
References: <20190601222738.6856-1-joel@joelfernandes.org>
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
2.22.0.rc1.311.g5d7573a151-goog

