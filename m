Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B34FA1C98FC
	for <lists+linux-pm@lfdr.de>; Thu,  7 May 2020 20:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbgEGSKe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 May 2020 14:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728245AbgEGSKb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2020 14:10:31 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47460C05BD43
        for <linux-pm@vger.kernel.org>; Thu,  7 May 2020 11:10:31 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id j21so8100485qtq.8
        for <linux-pm@vger.kernel.org>; Thu, 07 May 2020 11:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AcjgyLDbLfuRPfYfCs3xX2tel3iqkqWZ6prN5gsFA74=;
        b=V1WGo7FkR2BTf224rUb5QRFlyVtAEb490hVPQiagqofLxb2Un7HOf/lJzDMWR4dBaY
         goSk91EGW+FQMdpAJVpp9BCL7bztPmvctr4uif/kvn093HQ1ShZjG8EoS9jdhGl1/BZ8
         uyafHnGr31hJEL3BWu0hNXUT3C479EPil+Q8kJAZ3VEgj4geeN+bZbgCvZQe5VG6NeXQ
         bK+RLFa3yo67keVKT6lXDjTpR9KIQRlqqx9MLvbeVPhoU3ibYvltd9C1qD3ffqxlY15X
         18R22J/ldn5X2iJ7Qdm3RAQAavLDC0ea0wQ0O8QHDdIYStFzIstAlLdBGpV3e+H8Yjfe
         GxUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AcjgyLDbLfuRPfYfCs3xX2tel3iqkqWZ6prN5gsFA74=;
        b=RmmoO46Tda73F+2hcPjJSEAlTbIUuX6DazpiDAf1Tg9qhWAZc3ib69TGun4rw0ksrt
         cuPUmJjzhTMrGf+rw2abhbuiyMEpRnAQdi28nn8NYVRhyeIpzVecAFrgyNf1Gl+GjTeR
         4+JN+0f6Ap2Zc8Ad+2mZdNE8jdksh8d/2IneMEbTKEFpDntEBdrkrUo2/lqI/9rW4eXm
         47TdfljgY5sueDBpNxDkUhJO0WQDtx2sYN5mhd8gBQd50uMVgif+5yiZpXzWJLfWRdj0
         OsKVYB1OVFh4pWV/6tsbuQBIoGehAb0Ygkp6uCOIGVUR7WbwUV1+jP0/745Zd8m1j6D0
         LA2g==
X-Gm-Message-State: AGi0PuaydxVkOZncoGCKxwng7x/4GWvY5ZYWDm0TeiDPs5UkVTppfTDA
        zPKlG0oo/fGESylWynLgMqvt304xOkm1
X-Google-Smtp-Source: APiQypIeezwk8wKH5NFbxB1HRYZCWpSgPZOxn7vsJyIsBC8u1e/b/PRaJxwmopqEIxBGP+Ma+iemjLuU+rJg
X-Received: by 2002:a0c:c28b:: with SMTP id b11mr14000646qvi.112.1588875030512;
 Thu, 07 May 2020 11:10:30 -0700 (PDT)
Date:   Thu,  7 May 2020 19:10:05 +0100
In-Reply-To: <20200507181012.29791-1-qperret@google.com>
Message-Id: <20200507181012.29791-8-qperret@google.com>
Mime-Version: 1.0
References: <20200507181012.29791-1-qperret@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH 07/14] kthread: Export kthread_bind_mask()
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
 kernel/kthread.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index bfbfa481be3a..c0d84e1fbec2 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -430,6 +430,7 @@ void kthread_bind_mask(struct task_struct *p, const struct cpumask *mask)
 {
 	__kthread_bind_mask(p, mask, TASK_UNINTERRUPTIBLE);
 }
+EXPORT_SYMBOL_GPL(kthread_bind_mask);
 
 /**
  * kthread_bind - bind a just-created kthread to a cpu.
-- 
2.26.2.526.g744177e7f7-goog

