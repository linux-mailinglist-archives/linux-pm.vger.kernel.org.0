Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAF5A1C98F8
	for <lists+linux-pm@lfdr.de>; Thu,  7 May 2020 20:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgEGSLB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 May 2020 14:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728466AbgEGSKm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2020 14:10:42 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB58C05BD43
        for <linux-pm@vger.kernel.org>; Thu,  7 May 2020 11:10:41 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id n200so3378472ybg.0
        for <linux-pm@vger.kernel.org>; Thu, 07 May 2020 11:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=N7kuzoZFHLJw/s8kvulTGF06U3TOQxKeXMcbVwjE4XY=;
        b=IlMzfBoiBzByCTT8SvOpeFbpTRaCvxNWjvMZljPGk5OoeTwjsb1wsaeDG4gxHKaVQZ
         lzdyVKLAOhNQTDY9GjBd/yhOypV8xr6JkGrIdiIkOmuHYIEXWQlMLj/DbmLtNbgfFD9Q
         SCG7OJOOpIk03XjGXpiKFMyfX8aoQ3Xrqx3iegD2s+PpWCE+7K6lsm/S9bpA6HqJbgaR
         jMeJZirp1krHSjr5CW2MkZm66dBPji19T3oVp8Np6ywJUg8EpRdIfa2xNK2By97AoJkF
         MC053TSntRx44lPdMaRbtpYv7DwCxcWdZbSZKNuXslPDRHTEvdqxBA1WsqkBobm/WIUG
         gRLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=N7kuzoZFHLJw/s8kvulTGF06U3TOQxKeXMcbVwjE4XY=;
        b=dNcxxWx5M8v0KP+71HF4Ynh5RAxO8o5fOmgWHV33Jf8n3NcLH67eFpnRZUcRyarmu3
         yG/KWSBJ07UeIOZu+D/bPOH/KsRSYHrL40bj1v+Wv+Qn0Egt+9F4vsptBtiIWOnRfKla
         1aINEOoYWvxHRJrwrW8G/RmqWZf78eQIPcPau4Z7D2g/22jsfKwfu+ZTKGo8dqW62LkF
         fwVlrOJk+3Tlrf2YlpahGbO/EfuTdccBwhgsMOIiZotmjRUszsMIYjmHpvnkznY9CEl/
         wZTlaZD4SmrMHAc8hQadaPgEWsC+tOPPPeokyIAu35ebJy9SKx73GGtAfNljh1m+8+LZ
         SVPg==
X-Gm-Message-State: AGi0PubBvm9pCxDX+pCKfBljxdduHrh+6BnZkBOrnF+SAn1nO+joAnBp
        M14IOjmMgeaPSnaW3QVzWX1kbaw5+zcD
X-Google-Smtp-Source: APiQypJcn3oiy3Y8e0vbxO3XAex1LsJMYs5+fQTWEg+rN6GSDT89BK+2wbCqxMf6Oy2xk1QtZGIOh5nUJOcy
X-Received: by 2002:a25:d2d8:: with SMTP id j207mr16831345ybg.517.1588875040927;
 Thu, 07 May 2020 11:10:40 -0700 (PDT)
Date:   Thu,  7 May 2020 19:10:10 +0100
In-Reply-To: <20200507181012.29791-1-qperret@google.com>
Message-Id: <20200507181012.29791-13-qperret@google.com>
Mime-Version: 1.0
References: <20200507181012.29791-1-qperret@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH 12/14] x86: Export arch_scale_freq_key
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
 arch/x86/kernel/smpboot.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 8c89e4d9ad28..a8ccd69ba5ff 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1804,6 +1804,7 @@ void native_play_dead(void)
  */
 
 DEFINE_STATIC_KEY_FALSE(arch_scale_freq_key);
+EXPORT_SYMBOL_GPL(arch_scale_freq_key);
 
 static DEFINE_PER_CPU(u64, arch_prev_aperf);
 static DEFINE_PER_CPU(u64, arch_prev_mperf);
-- 
2.26.2.526.g744177e7f7-goog

