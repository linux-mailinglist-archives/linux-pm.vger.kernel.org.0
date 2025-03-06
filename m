Return-Path: <linux-pm+bounces-23561-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D79A549C6
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 12:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1E481899397
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 11:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B823C212FBC;
	Thu,  6 Mar 2025 11:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="luYK1E9E"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B3A211A26
	for <linux-pm@vger.kernel.org>; Thu,  6 Mar 2025 11:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741260965; cv=none; b=illxAOXqZkd+dvs+h3GQCcfik+HhgCPmVm4JkDyPZoLwNiowJwaEIc2yEAQypbhFTOnVkKP722UKF893FTxp6LiZ8RM3Dfi/vTX0i18h41GLhXo7G+B0IiwUO3+2wiwtVH3X9DY2o/Qyqt+zR675jEXMIzHqOdPU85apm3QQXec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741260965; c=relaxed/simple;
	bh=3nZQ7e6h+YacqRMgx/Xd4BzDtN/zr2bOXSyLefmucUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FoGf8GH2yFeAo7slsePmXp+tgqGtaJAlTfuAPw5mIHXF1Fc4CQVPWw0S6ZaNjkmKygQQauaQtlrWo9E+s+fF9Ryu1V7wF+nPEFur9DLtA7mVlMkzIZpn8A58AyoUgefdYucB0agYD3h9/Fnh7RCRQvmpkierK1WVdvpDS06mCjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=luYK1E9E; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5496078888eso658524e87.0
        for <linux-pm@vger.kernel.org>; Thu, 06 Mar 2025 03:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741260960; x=1741865760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+AyyFlWHkvIaDbzkVyONzVVHpZRnmhFgeQIexgdJRs=;
        b=luYK1E9EukrklF3Da1KFaE0zJUWoZdADjqhPeXYS+0O9GuXlY5uTN7f1xhHA657OYe
         SG45t1qH0WR057Kr9mpStJ6YCQSKsL74uLHBwggf9x2jns3PuFKk8tU9YKeLF1M+70o9
         r0R09n9+avzwVtdzoHFPpyPRx3EOlyM+kc/syvduKQrrT99kq2705JtGPG9PPgKITT5o
         qo3dy1E2/d5tiQJZgJPkV3w8sZvSpHjbkDNBHNzck40P76XdzN6gkGwVWXUURte+6Iwp
         rjRC1cAsz/WC/t0VNO3gEeLQxLcBrEmYemsanmVyyLn9fNXPJRLHutS63xrqnIi+Q1V5
         Xnhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741260960; x=1741865760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s+AyyFlWHkvIaDbzkVyONzVVHpZRnmhFgeQIexgdJRs=;
        b=gx1cJGmbjGnaKN9EL6ZDivgq1SXVOLvRAeLRM4soTBBCO7PGQhN9oKL+fEqTX427ML
         EUJpHv36cCLPcIjXM9kAyVCQgyuiikhw5uRdrBvvYmEJf2PNDQuZiprbNlNFigY7xQCV
         xcuvOlPwaQnHYpPfbPqq82BXJpZsPkYCcRSF+zqW/F+JYPzP2BwcV3zfCa5l9VIIgQJk
         13/kzdol7hseJSJGRRBtjHf45fZdqmj4HutK8qfNg/vTKsBo9IWiNUFGzu6SQj4Y5P5v
         HbZWPlCX05hYSlw/lNTeLhK/jyK2UuSCeiIiNdl7bU3fFPUjBfd0e3MddTy/Vi1YvduF
         YC/g==
X-Forwarded-Encrypted: i=1; AJvYcCVsymJb3PPpQfvpMA9ZFU7yIHM/IG3TrmebEZtjQzyzGJkeGYwNSR18DOSCJoX95HyFDPC7jyyk4g==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk5gcDed2IquUwTJSCdsJUeS7S2jeGPSpDb8zGfLhIO9N9Ls2Q
	qjWZJKVKg8+N3SeEDReJYRGH9Eu1u6y0r3VqFRgb9XJFzlarTh/MmIrKgZK7UXg=
X-Gm-Gg: ASbGncs2k6MR7P4YSEJoNMigzenQizYj+XTz4gbLVQewlUsjQVzMVecND4z2lFW7izV
	do0+fZ0Km5+Fafjvwowo4PXoI4/xdI4M0HsNhF3Sn65u8ec6eVlVseKhX83dnQ720eo0KOtfpwx
	0qDQOBxhZ6xrtBa4MVnklymvbuqo8naZhZOwi5GzXzHZNfCVTyOwaCHXhaSEJWV7FzBsjGp0Wz/
	6dyxj0kD62edZdF4NZe0EAlPXKGLQpn9NPDcaviBLj4gXQXEryuhBOWq5QPt27eUO+BINS7gr99
	eRue7dRsEMYpkr7vSn9OWK49o+5loeBr0FM97D1CQqZzYzcxOi5UzvB7lFMQyShXyZKe7TZp6fs
	hNB+wgMiXOvK29+tndo4=
X-Google-Smtp-Source: AGHT+IGdluhAdfmeE1f9+qi3DVUdsCzNksoJolzcqmbX6FS/jk4/mksaZKHzfgsja4/EHr4gkuoFrg==
X-Received: by 2002:a05:6512:b1f:b0:549:4ac4:a464 with SMTP id 2adb3069b0e04-5497d33215dmr2277928e87.2.1741260960489;
        Thu, 06 Mar 2025 03:36:00 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30be9918086sm1809511fa.54.2025.03.06.03.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 03:36:00 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] PM: s2idle: Avoid holding the s2idle_lock when calling pm_wakeup_pending()
Date: Thu,  6 Mar 2025 12:35:41 +0100
Message-ID: <20250306113549.796524-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306113549.796524-1-ulf.hansson@linaro.org>
References: <20250306113549.796524-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's no reason to hold the s2idle_lock longer than necessary. Let's
instead acquire it when really needed in s2idle_enter().

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 kernel/power/suspend.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index e7aca4e40561..ca09f26cbf4e 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -91,10 +91,10 @@ static void s2idle_enter(void)
 {
 	trace_suspend_resume(TPS("machine_suspend"), PM_SUSPEND_TO_IDLE, true);
 
-	raw_spin_lock_irq(&s2idle_lock);
 	if (pm_wakeup_pending())
 		goto out;
 
+	raw_spin_lock_irq(&s2idle_lock);
 	s2idle_state = S2IDLE_STATE_ENTER;
 	raw_spin_unlock_irq(&s2idle_lock);
 
@@ -111,11 +111,10 @@ static void s2idle_enter(void)
 	wake_up_all_idle_cpus();
 
 	raw_spin_lock_irq(&s2idle_lock);
-
- out:
 	s2idle_state = S2IDLE_STATE_NONE;
 	raw_spin_unlock_irq(&s2idle_lock);
 
+ out:
 	trace_suspend_resume(TPS("machine_suspend"), PM_SUSPEND_TO_IDLE, false);
 }
 
-- 
2.43.0


