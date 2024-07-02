Return-Path: <linux-pm+bounces-10372-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C75BB9246C0
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 19:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 299931F23CEB
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 17:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C391C0061;
	Tue,  2 Jul 2024 17:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+t98ELf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32343D978;
	Tue,  2 Jul 2024 17:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719943010; cv=none; b=KsF32L7XA5B5VvK1P9+MAWFAO45JO7snNrLTm1D2+NJxITqMnyx7RaloZ4ZlXN1a3j9KduG65YjBQVcEOBtvJYkQnIcyS3zzpbyGpmDclpZ7NNcmEA87ow7zgaWFhVkt6oq2MlPTy4FB/tbPWRBenkyPq2vHPlpLvssPXokNvFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719943010; c=relaxed/simple;
	bh=hJiz5bF6LptMBCcGXuEZWDSZAYXfPxjSOCB9LLx/iI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ie3pGlz50QimJyx/PdCEI41+NWz40NAuJPehKEUincXJ8QL8ASVdzRK+kfSZa2lqEYkzeY/aVrJaM842PGHZICBygVb4yAA6VNjZQCPYfuTpz7qvwYqnsSF4GG82It/fAZbVcwkx7V6TJHK5J3nDitrT4IaMCxamWaNrIapUFR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+t98ELf; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-706b539fcaeso3984981b3a.0;
        Tue, 02 Jul 2024 10:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719943008; x=1720547808; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H/QWmxb4w+FBWrySZiVH7y9gg+E8h5e3o09iq702lTY=;
        b=A+t98ELfkLN0oHJzyAkbM40TlDu7f8Hi6MHu1ftKWiddl/P4pR5y4sgBD2Rflk1BVc
         XGZSE2BOgTAptIEN1KoFlM6Bw+G4iTQhi/fVy0aFyH+y61Ahx25lPDNzb2CPyL5cIS7a
         EMcXn8GxpkuHYC8Rzj5AMXbRBqmJ3cZW4z9piWrPLLYh/+u70Q6nfw8f1hCC6NPQkC72
         POpBklaeC9Np01tHpjG9ATEFCQZ5MCrR+KCENxNrQM6djFgItoqy4BnjQbjT2kqW+6wc
         xKn6OCrGNPUzoSotiJblyl4YMK2WxbTI5lTgeZkiY3nMoCqMOxhzOCZ8GBjpwSSXsEzK
         FBOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719943008; x=1720547808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H/QWmxb4w+FBWrySZiVH7y9gg+E8h5e3o09iq702lTY=;
        b=LOK3JE01ebQsbiaV1vVyCv9l5SUUcQ93zcSwSNCTPrDK4MdGdotKKjj1kWj8l/bi69
         qEwjgGHwsMyOXR+iotISc7Mx0zBrOPLdwuKLUXN3sM5xR/JIwvP6ZGkRZ/Qe1yRRhhtj
         SeRw4BMI3frBPsCCEZi4DAL1nGStqfvutddfnqWo+JP9GX/dXKq9PfGzxmXK9HkJLeiR
         yiZe0KFEwMaYV9dRtzuo+06cWC4QGGGcxx5UpMkMtWmtH7pib+u9G3N11vUrJRfU2IQQ
         RH0XPQDozuDCuot/sKab11VD9aFP5PYcuXIYQya86z5SKrhCnK2tklmwmL9zNV9iCUWC
         2pdQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4Yo4ywgL+M2PEkQoMh4ZJjLYiyE3IR6adC6VNcp2jEtSfDhYz53/qAx7nYEhJwoOcXfPvERZNU0AHxEAVeZ4KQtXyE4m7YIU0nQapGrsBiBRjYYUhEF+XAo91gRZsvpQLxfcYRfQ=
X-Gm-Message-State: AOJu0YwNQdhKkCjfEF7T/WNIiQnjmfbRnQWl7xRqlE3To1m0h1lYYoHG
	ckyx2zi+BOZxkQUOLheMEnOZfjOuMbWh/loFy+dexnsBypn4q3qDk2hY0w==
X-Google-Smtp-Source: AGHT+IFxgUsrVN4r6qPYH5ewxQ1y6uYo9/TV+KG1C/eVZqsHn5GZ4wxHBlNFH/gq7bCgiTzSPGT78w==
X-Received: by 2002:a05:6a20:1586:b0:1be:c166:6445 with SMTP id adf61e73a8af0-1bef610d040mr15286970637.4.1719943007920;
        Tue, 02 Jul 2024 10:56:47 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70802959452sm9056729b3a.90.2024.07.02.10.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 10:56:47 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 2 Jul 2024 07:56:46 -1000
From: Tejun Heo <tj@kernel.org>
To: Hongyan Xia <hongyan.xia2@arm.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
	void@manifault.com, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, mingo@redhat.com, peterz@infradead.org,
	David Vernet <dvernet@meta.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 2/2] sched_ext: Add cpuperf support
Message-ID: <ZoQ_XuXn1Y2Kp3Ba@slm.duckdns.org>
References: <20240619031250.2936087-1-tj@kernel.org>
 <20240619031250.2936087-3-tj@kernel.org>
 <63c76af4-6451-4d6a-8aeb-0bc4812c4101@arm.com>
 <ZoQs384bAMuaeDEs@slm.duckdns.org>
 <940a41d0-2660-4a7a-ad07-581b3ac24cca@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <940a41d0-2660-4a7a-ad07-581b3ac24cca@arm.com>

Hello,

So, maybe something like this. It's not the prettiest but avoids adding
indirect calls to fair and rt while allowing sched_ext to report what the
BPF scheduler wants. Only compile tested. Would something like this work for
the use cases you have on mind?

Thanks.

Index: work/kernel/sched/core.c
===================================================================
--- work.orig/kernel/sched/core.c
+++ work/kernel/sched/core.c
@@ -1671,6 +1671,20 @@ static inline void uclamp_rq_dec_id(stru
 	}
 }
 
+bool sched_uclamp_enabled(void)
+{
+	return true;
+}
+
+static bool class_supports_uclamp(const struct sched_class *class)
+{
+	if (likely(class->uclamp_enabled == sched_uclamp_enabled))
+		return true;
+	if (!class->uclamp_enabled)
+		return false;
+	return class->uclamp_enabled();
+}
+
 static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
 {
 	enum uclamp_id clamp_id;
@@ -1684,7 +1698,7 @@ static inline void uclamp_rq_inc(struct
 	if (!static_branch_unlikely(&sched_uclamp_used))
 		return;
 
-	if (unlikely(!p->sched_class->uclamp_enabled))
+	if (class_supports_uclamp(p->sched_class))
 		return;
 
 	for_each_clamp_id(clamp_id)
@@ -1708,7 +1722,7 @@ static inline void uclamp_rq_dec(struct
 	if (!static_branch_unlikely(&sched_uclamp_used))
 		return;
 
-	if (unlikely(!p->sched_class->uclamp_enabled))
+	if (class_supports_uclamp(p->sched_class))
 		return;
 
 	for_each_clamp_id(clamp_id)
Index: work/kernel/sched/ext.c
===================================================================
--- work.orig/kernel/sched/ext.c
+++ work/kernel/sched/ext.c
@@ -116,10 +116,17 @@ enum scx_ops_flags {
 	 */
 	SCX_OPS_SWITCH_PARTIAL	= 1LLU << 3,
 
+	/*
+	 * Disable built-in uclamp support. Can be useful when the BPF scheduler
+	 * wants to implement custom uclamp support.
+	 */
+	SCX_OPS_DISABLE_UCLAMP	= 1LLU << 4,
+
 	SCX_OPS_ALL_FLAGS	= SCX_OPS_KEEP_BUILTIN_IDLE |
 				  SCX_OPS_ENQ_LAST |
 				  SCX_OPS_ENQ_EXITING |
-				  SCX_OPS_SWITCH_PARTIAL,
+				  SCX_OPS_SWITCH_PARTIAL |
+				  SCX_OPS_DISABLE_UCLAMP,
 };
 
 /* argument container for ops.init_task() */
@@ -3437,6 +3444,13 @@ static void switched_from_scx(struct rq
 static void wakeup_preempt_scx(struct rq *rq, struct task_struct *p,int wake_flags) {}
 static void switched_to_scx(struct rq *rq, struct task_struct *p) {}
 
+#ifdef CONFIG_UCLAMP_TASK
+static bool uclamp_enabled_scx(void)
+{
+	return !(scx_ops.flags & SCX_OPS_DISABLE_UCLAMP);
+}
+#endif
+
 int scx_check_setscheduler(struct task_struct *p, int policy)
 {
 	lockdep_assert_rq_held(task_rq(p));
@@ -3522,7 +3536,7 @@ DEFINE_SCHED_CLASS(ext) = {
 	.update_curr		= update_curr_scx,
 
 #ifdef CONFIG_UCLAMP_TASK
-	.uclamp_enabled		= 1,
+	.uclamp_enabled		= uclamp_enabled_scx,
 #endif
 };
 
Index: work/kernel/sched/fair.c
===================================================================
--- work.orig/kernel/sched/fair.c
+++ work/kernel/sched/fair.c
@@ -13228,9 +13228,7 @@ DEFINE_SCHED_CLASS(fair) = {
 	.task_is_throttled	= task_is_throttled_fair,
 #endif
 
-#ifdef CONFIG_UCLAMP_TASK
-	.uclamp_enabled		= 1,
-#endif
+	SCHED_CLASS_UCLAMP_ENABLED
 };
 
 #ifdef CONFIG_SCHED_DEBUG
Index: work/kernel/sched/rt.c
===================================================================
--- work.orig/kernel/sched/rt.c
+++ work/kernel/sched/rt.c
@@ -2681,9 +2681,7 @@ DEFINE_SCHED_CLASS(rt) = {
 	.task_is_throttled	= task_is_throttled_rt,
 #endif
 
-#ifdef CONFIG_UCLAMP_TASK
-	.uclamp_enabled		= 1,
-#endif
+	SCHED_CLASS_UCLAMP_ENABLED
 };
 
 #ifdef CONFIG_RT_GROUP_SCHED
Index: work/kernel/sched/sched.h
===================================================================
--- work.orig/kernel/sched/sched.h
+++ work/kernel/sched/sched.h
@@ -2339,11 +2339,6 @@ struct affinity_context {
 extern s64 update_curr_common(struct rq *rq);
 
 struct sched_class {
-
-#ifdef CONFIG_UCLAMP_TASK
-	int uclamp_enabled;
-#endif
-
 	void (*enqueue_task) (struct rq *rq, struct task_struct *p, int flags);
 	void (*dequeue_task) (struct rq *rq, struct task_struct *p, int flags);
 	void (*yield_task)   (struct rq *rq);
@@ -2405,8 +2400,21 @@ struct sched_class {
 #ifdef CONFIG_SCHED_CORE
 	int (*task_is_throttled)(struct task_struct *p, int cpu);
 #endif
+
+#ifdef CONFIG_UCLAMP_TASK
+	bool (*uclamp_enabled)(void);
+#endif
 };
 
+#ifdef CONFIG_UCLAMP_TASK
+bool sched_uclamp_enabled(void);
+
+#define SCHED_CLASS_UCLAMP_ENABLED	\
+	.uclamp_enabled = sched_uclamp_enabled,
+#else
+#define SCHED_CLASS_UCLAMP_ENABLED
+#endif
+
 static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
 {
 	WARN_ON_ONCE(rq->curr != prev);

