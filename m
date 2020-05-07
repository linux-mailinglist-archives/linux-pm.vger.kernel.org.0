Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA3F61C98ED
	for <lists+linux-pm@lfdr.de>; Thu,  7 May 2020 20:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbgEGSKm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 May 2020 14:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727117AbgEGSKl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2020 14:10:41 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B61C05BD43
        for <linux-pm@vger.kernel.org>; Thu,  7 May 2020 11:10:39 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id g8so8148945qtq.2
        for <linux-pm@vger.kernel.org>; Thu, 07 May 2020 11:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zZWvTUfx/wRuyyDcQxDeif3qbH8vMyyGM38ys5fdFsY=;
        b=Hsq7csMm3aKxHXFy3vU5SjedQTdFGmje4EFFn7pUNQI+7Tt5gipsk3gojrKeqv0oZA
         zKJmEc4qjOnoV2Poo1wux8oWp7druRmTRThDjQx0nXRmvka5WsF9eIK05U+G5BZ5kwA9
         7QtfLulqPmZBLYbI0vKZu/6D5HO6i4g2a6I7enOxrKuX3hdzh9btnYC61l0lBlUK9g6G
         nIOYbvEzOurFENmE7JQ0pSeNgQ5IUaGVHwya8NGk1H3C8O8Gh3pvyYFCxt45XHtnr/q4
         xHM22KlaIb+SQa38QzZsQOlVjsp4CDU+E/SvPDegyt/YmQrsmOX/1Q6cfHLV37HoscxQ
         DBqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zZWvTUfx/wRuyyDcQxDeif3qbH8vMyyGM38ys5fdFsY=;
        b=hRTUNlQyTSUqIMx4bZ79d23KgqeinRXb8eOE7UuN1AoF3WJuHYADk5zpK6466jz+9j
         FEsDi+RI6ajpJQ1X2NuQnj+dlaXgSkwwrCaSh0+iUhKcVE/nuxLnAtiTqnmBSAhEYyrO
         a549GaDsiqKqvAFf7jqXM6z6eEwXdN2v+ZEA90TjFyMCbvZt3psauqGE9oKKHRFtwcix
         JI7zwW0/+aJs+ecAl7hojaIpfm3Rz0LdvuRmOSXaWeimukpcG7YLT8u5g5KCcDui87QF
         XMH9+DjgZmVqnkKYYyxgHLyKY24HYOUG42lBzLx00C6PO4I/ovN7NqLj+ldFUjZedwBq
         PxPQ==
X-Gm-Message-State: AGi0PuYIMEsYtaAXEu31NkqiQj5O6XZqxOpRu71i48kEKGwt6SuKQ65f
        4jVKGCSxupjfJzu2UHqAgzgBxWgvyENe
X-Google-Smtp-Source: APiQypLtVxYcoBCGLT2opMHxryNuYGnQnZvm1aIxlatafdQirXZzAlFCc71e959iGzwoL9cFGjpKT/1CxlGY
X-Received: by 2002:a0c:facb:: with SMTP id p11mr14758771qvo.17.1588875038848;
 Thu, 07 May 2020 11:10:38 -0700 (PDT)
Date:   Thu,  7 May 2020 19:10:09 +0100
In-Reply-To: <20200507181012.29791-1-qperret@google.com>
Message-Id: <20200507181012.29791-12-qperret@google.com>
Mime-Version: 1.0
References: <20200507181012.29791-1-qperret@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH 11/14] tick/sched: Export tick_nohz_get_idle_calls_cpu
From:   Quentin Perret <qperret@google.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, sudeep.holla@arm.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, viresh.kumar@linaro.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, mcgrof@kernel.org, keescook@chromium.org,
        yzaikin@google.com, fweisbec@gmail.com, tkjos@google.com,
        kernel-team@android.com, qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It will be needed by schedutil once modularized, export it.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 kernel/time/tick-sched.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 3e2dc9b8858c..3b1050cabb58 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1122,6 +1122,7 @@ unsigned long tick_nohz_get_idle_calls_cpu(int cpu)
 
 	return ts->idle_calls;
 }
+EXPORT_SYMBOL_GPL(tick_nohz_get_idle_calls_cpu);
 
 /**
  * tick_nohz_get_idle_calls - return the current idle calls counter value
-- 
2.26.2.526.g744177e7f7-goog

