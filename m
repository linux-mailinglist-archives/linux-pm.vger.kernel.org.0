Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD0121F560
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jul 2020 16:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbgGNOvG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jul 2020 10:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbgGNOvB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2020 10:51:01 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451EBC061755
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 07:51:01 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f18so22197871wrs.0
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 07:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=87fYCk78HvnEcHEWI8252kKdAErne/JGHZaNtIMV4DM=;
        b=oan2KmRnlmziHA33dlWeKxYSz99uymPx4Upt4DdPZqzkE7Pn6aNbVFcS4EqijPPT1b
         epm+Z0+gabomO1htq+2nGq7mfGaa4AQjVGvinv2W7rG4Yf4zrX1lLQEsQqp/IxzwJsZK
         KsU3lyQE4BSuu7m+y0e17j3xQipWcaeFlmiHFAjUhm+t5oiOf17IImiudspjVz2Gr4Np
         +3ggtvvQ+Y0p36Roz5hpma2QxOSlmCwdpxC50LPbuzXaY/z9L0dMBVjNrKdi9Dd18Pfz
         bjl9EDQ3qx3ytSsCNXEZ3bn0ERkPJPoJyn67O07VbJKTig+xN3S9JouZaVPvYAKfp92V
         EHyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=87fYCk78HvnEcHEWI8252kKdAErne/JGHZaNtIMV4DM=;
        b=uobfP77obTiAzQel5NnDjZXHrtMBOSirUmxCCnDfIleK4x1fOvsvA/titnHBcYy/ND
         5+cJdXzYjnpECTyIrttS/PlrcYkQkW2ycAJbqSu/y5f0x21cMeHpn1GG+QezBKh7LYN7
         goHpfRT9nq1eHSvypwAcquYEe7V8y27RRlqtmGUX3xFCj+pzlVWYGZpukQM0ZhsvMQjF
         /PtviW+wTgZ5Fms6oEjTh9wf5RHiOZ4QVwpr1+kK5BUJuMoShSSpnG1myBwRdp30xEyi
         9YNZ8j9Q4P2soVKTAd0SMVlsZo4rGLVEAYt4kzdvpNOgAGalnXls8VdV25/kQ16CMEf8
         WofQ==
X-Gm-Message-State: AOAM530aia33S48nheiia5uzvFytgL//qJUgWD3Xsxvm8dhpimx68s/T
        bVpvHZzwhfFfPZqoqXuRyAxIIg==
X-Google-Smtp-Source: ABdhPJyholUMWz/5/8DrxA2fX1xTdZCmREnCcugfLGT0R3+RARPOD0BiRca7mzrYbDfRATUmPfhpCg==
X-Received: by 2002:a5d:6990:: with SMTP id g16mr6060756wru.131.1594738259994;
        Tue, 14 Jul 2020 07:50:59 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id a84sm4653305wmh.47.2020.07.14.07.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 07:50:59 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 07/13] cpufreq: powernv-cpufreq: Fix a bunch of kerneldoc related issues
Date:   Tue, 14 Jul 2020 15:50:43 +0100
Message-Id: <20200714145049.2496163-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714145049.2496163-1-lee.jones@linaro.org>
References: <20200714145049.2496163-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Repair problems with formatting and missing attributes/parameters, and
demote header comments which do not meet the required standards
applicable to kerneldoc.

Fixes the following W=1 kernel build warning(s):

 drivers/cpufreq/powernv-cpufreq.c:84: warning: Function parameter or member 'last_lpstate_idx' not described in 'global_pstate_info'
 drivers/cpufreq/powernv-cpufreq.c:84: warning: Function parameter or member 'last_gpstate_idx' not described in 'global_pstate_info'
 drivers/cpufreq/powernv-cpufreq.c:84: warning: Function parameter or member 'policy' not described in 'global_pstate_info'
 drivers/cpufreq/powernv-cpufreq.c:182: warning: Function parameter or member 'i' not described in 'idx_to_pstate'
 drivers/cpufreq/powernv-cpufreq.c:201: warning: Function parameter or member 'pstate' not described in 'pstate_to_idx'
 drivers/cpufreq/powernv-cpufreq.c:670: warning: Function parameter or member 't' not described in 'gpstate_timer_handler'
 drivers/cpufreq/powernv-cpufreq.c:670: warning: Excess function parameter 'data' description in 'gpstate_timer_handler'

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/cpufreq/powernv-cpufreq.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 068cc53abe320..2e5a8b8a4abaa 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -64,13 +64,14 @@
  *				highest_lpstate_idx
  * @last_sampled_time:		Time from boot in ms when global pstates were
  *				last set
- * @last_lpstate_idx,		Last set value of local pstate and global
- * last_gpstate_idx		pstate in terms of cpufreq table index
+ * @last_lpstate_idx:		Last set value of local pstate and global
+ * @last_gpstate_idx:		pstate in terms of cpufreq table index
  * @timer:			Is used for ramping down if cpu goes idle for
  *				a long time with global pstate held high
  * @gpstate_lock:		A spinlock to maintain synchronization between
  *				routines called by the timer handler and
  *				governer's target_index calls
+ * @policy:			Associated CPUFreq policy
  */
 struct global_pstate_info {
 	int highest_lpstate_idx;
@@ -170,7 +171,7 @@ static inline u8 extract_pstate(u64 pmsr_val, unsigned int shift)
 
 /* Use following functions for conversions between pstate_id and index */
 
-/**
+/*
  * idx_to_pstate : Returns the pstate id corresponding to the
  *		   frequency in the cpufreq frequency table
  *		   powernv_freqs indexed by @i.
@@ -188,7 +189,7 @@ static inline u8 idx_to_pstate(unsigned int i)
 	return powernv_freqs[i].driver_data;
 }
 
-/**
+/*
  * pstate_to_idx : Returns the index in the cpufreq frequencytable
  *		   powernv_freqs for the frequency whose corresponding
  *		   pstate id is @pstate.
@@ -660,7 +661,7 @@ static inline void  queue_gpstate_timer(struct global_pstate_info *gpstates)
 /**
  * gpstate_timer_handler
  *
- * @data: pointer to cpufreq_policy on which timer was queued
+ * @t: Timer context used to fetch global pstate info struct
  *
  * This handler brings down the global pstate closer to the local pstate
  * according quadratic equation. Queues a new timer if it is still not equal
-- 
2.25.1

