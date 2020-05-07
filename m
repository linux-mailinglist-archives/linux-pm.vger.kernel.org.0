Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 267341C98FF
	for <lists+linux-pm@lfdr.de>; Thu,  7 May 2020 20:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgEGSLO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 May 2020 14:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728289AbgEGSK3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2020 14:10:29 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD65C05BD43
        for <linux-pm@vger.kernel.org>; Thu,  7 May 2020 11:10:29 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id r14so7935864ybk.21
        for <linux-pm@vger.kernel.org>; Thu, 07 May 2020 11:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8H2cxWc0TJkFq1FwnzU8BhlMDlLROEsVn8jQ63PO1YA=;
        b=e0B6HuDQFhjEiqKogDpB4FKzUc+1Dc5yC/vswLYEcVtDTUxUF+EebiB+Cc9J824OQs
         RHMC3zH1dbpw8rXc96BMLodYXjsjhq/iL6S9yrv9krOI2qjgV8bkOqbR5k6Y3nkMqEca
         zMbpy+PyilGMtP3Mexgi9bk3qNVRPHlEDtwyw+broZ/rkGpWZsFi+KhpXcTyOiir4g3e
         cKMsSunv87LNlGijr/lhKEAstYnvmmaTSOHAGEC3FRDPWnxqIu2U79KpfZJRjjtRTYHr
         sPQhmCCM9dUl6ZppLJLe8CKNIZE+or72DPVnWjlqbzcNapTLTPMNJim0aCsiIzNRDOTE
         hKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8H2cxWc0TJkFq1FwnzU8BhlMDlLROEsVn8jQ63PO1YA=;
        b=NLwbZkqAXIfRkb3tUoirQh+CQ2qaG+GgdrY4UYD2FZBKwQJb9qCTTEQCQSCB4GkKdR
         RR/NqU4dagfGSr1wQlodzdBu57lJ1pfs96s8yF+jfuduCRR89tI+RjpEdAwbdjnKNPO0
         GymzHb7+wKTvqee38XQpdfvIL8uwlSCiwFUx5tqwQCq0WY+VS1Ti4wLYZ7a3x1bIHZmJ
         pgDAzwubDoDRfZSqKpu8zOjPPFjKINCiPhwpBlCSaKUDAH6HQ7jMapxoGDAjqNck46o5
         I97L3J1jE1j+GHIrpnqyeH102qkyGbPsXNNWTFrTidwreobaxu7uZ6b0UJjQeX9tnCNl
         kAqQ==
X-Gm-Message-State: AGi0PuYjSZb26my9S4zUhIRudk3Q6hNOdzOg2Yre/2ZRiSfA25Dy3dWK
        IGZVnsn97kpPvssDYYC+nww9kDZim5H2
X-Google-Smtp-Source: APiQypL5FceGu1rlwwmqFHesyQwSxJJabs9h5OpeREfdyyMJo/uIVD6Sh4CrmCFa5su+iSIK8etzgG3RTlxV
X-Received: by 2002:a25:d80f:: with SMTP id p15mr24245303ybg.379.1588875028303;
 Thu, 07 May 2020 11:10:28 -0700 (PDT)
Date:   Thu,  7 May 2020 19:10:04 +0100
In-Reply-To: <20200507181012.29791-1-qperret@google.com>
Message-Id: <20200507181012.29791-7-qperret@google.com>
Mime-Version: 1.0
References: <20200507181012.29791-1-qperret@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH 06/14] arch_topology: Export cpu_scale per-cpu array
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
 drivers/base/arch_topology.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 4d0a0038b476..b1f0c272da67 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -48,6 +48,7 @@ void arch_set_freq_scale(struct cpumask *cpus, unsigned long cur_freq,
 }
 
 DEFINE_PER_CPU(unsigned long, cpu_scale) = SCHED_CAPACITY_SCALE;
+EXPORT_SYMBOL_GPL(cpu_scale);
 
 void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity)
 {
-- 
2.26.2.526.g744177e7f7-goog

