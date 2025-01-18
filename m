Return-Path: <linux-pm+bounces-20647-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 723A0A15BBD
	for <lists+linux-pm@lfdr.de>; Sat, 18 Jan 2025 08:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C54803A9226
	for <lists+linux-pm@lfdr.de>; Sat, 18 Jan 2025 07:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7BC14A09A;
	Sat, 18 Jan 2025 07:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E1DgqX9V"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343A2A32
	for <linux-pm@vger.kernel.org>; Sat, 18 Jan 2025 07:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737185084; cv=none; b=FAgZzPz+nrvMtHycC3mU4juF+UsyYkPhDWNQnue9e9lOaZZL4ZXm6k2wJHh2g/UZv/H8L0zW6p1/+XWhoidQFPSLugQJLEmSu2pdlLo54mp/hgNcDGZLaCfD66pljYOTCmCv3aHmPak/JrAoFaRKNXIZfYHwfH9c5AJ3F1Jw5E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737185084; c=relaxed/simple;
	bh=KhUjOsUtKjZxVWEAfpaUIwtDFofgniDpgtWv9gaFW9k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PyQvjhYsd4yTbmy6iG0SBW+q8gXc3629EG2qcQbMDBqwddd/Q/sxnvXG1VpLhjUAZ93t3P+N3nVv57HYUgJ/KKNU/sh0LRId9LkXwKnkYbndOrwkPPtvcFOAHcNrYGHciMMg5nnxXwOYBO5jzDmDn6q0g/yXzTMPUFAV9yQ5fUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--keyz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E1DgqX9V; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--keyz.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-21655569152so55806815ad.2
        for <linux-pm@vger.kernel.org>; Fri, 17 Jan 2025 23:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737185082; x=1737789882; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=940iCcxpvzyGM4mZVRnuDDdVwqFoEWjVZnkzqluQF6M=;
        b=E1DgqX9VJM+cBK61JImc+P+ytlAmeu6p1geXMRMle6+IXrt7rjhnf6XPoKkHKw5sSc
         OGQlvBsxa0w9cC7jdSPKM0m1xc6UzzDLmiwo294/zkQzC5prsYxQQ8UD/Nu5+VuXXUoz
         2FwcGnmDQbx3vuvQz3oIO3srbl2PU1dm3U/dDayNudZJV4tq7ur5fkilttYHdy6IPm53
         /LvNcmgItHrr78d6sgfHyGx7oTobTvifdiuc5LqSaFpMOqaQfYKFfu8eYn7UB2aeAMCJ
         J2rEx6/RE2ZZ+A+AU1eWSJEdzf+U0OVhzchpbUMDoug0+Uxj0qv5ovO0wteyIYkkvzEk
         9zCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737185082; x=1737789882;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=940iCcxpvzyGM4mZVRnuDDdVwqFoEWjVZnkzqluQF6M=;
        b=uFrqw2ywCsIZd+YHe6bZZ5f3zOR89+xuhYuhAQP9rAvSopNjMmtp9cBJihKyipVGFC
         Wko3q4dYGcgo5Bv0sSPyzxaZIqYlALfRmtmxCAl9e/U84hAjxYE4vmaZFq9hoCUtXKQz
         9eHUFgYmEFtyjaV0ER8a/ZiuT/Dmn2X+34cZtv+tLTdl4dhe+a2YSBNEi7g9bL0B9U0O
         HpOyN6AOmt2fcUZs360lYlmuK2SNZAGWKRk/5t+j9XEUyxZmJoBrzFNZLDFwTJlKlQOE
         yjw5t9fYMP8yi8nLgfW18+TnOrYLHBtAKSka/NL1WIPQY1VqpYj6ticDaQv5inXj3AXE
         DE5w==
X-Forwarded-Encrypted: i=1; AJvYcCWsM568gdNsjTgZ7doJ5ABU4cR0HTvpQ8tsoIjta9cwUJl8M/BZjGI79JvOpMfEA1dO7p1qnesDUg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzxKfjIr6UitcqyjtWXhH4E+IcKN8kl6OJV1SuvYdZS0T3giuzK
	GrtyybYl5Qwl1oC31UstIiexWSz3eEdrBM0akFsTShHoxE1z7q3jp7tqrDORG1ae+EZKZg==
X-Google-Smtp-Source: AGHT+IEIBAeQmO6MGQcNwnYFn8SkrDPGzn+XCE5f7u+ZLY2Fni10ILvoUB2qzb6E+YF/skiDhuyrjNMG
X-Received: from pgbcs4.prod.google.com ([2002:a05:6a02:4184:b0:801:cdbd:2727])
 (user=keyz job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:f29:b0:1e3:e77d:1431
 with SMTP id adf61e73a8af0-1eb214da830mr6276082637.23.1737185082483; Fri, 17
 Jan 2025 23:24:42 -0800 (PST)
Date: Sat, 18 Jan 2025 15:24:38 +0800
In-Reply-To: <20250117105132.4122940b@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250117105132.4122940b@gandalf.local.home>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Message-ID: <20250118072438.3647805-1-keyz@google.com>
Subject: Re: [PATCH] cpuidle: psci: Add trace for PSCI domain idle
From: Keita Morisaki <keyz@google.com>
To: rostedt@goodmis.org
Cc: aarontian@google.com, daniel.lezcano@linaro.org, keyz@google.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, lpieralisi@kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rafael@kernel.org, 
	sudeep.holla@arm.com, yimingtseng@google.com
Content-Type: text/plain; charset="UTF-8"

Thank you for the review!

> Why not make that into two different events:

> +	trace_psci_domain_idle_enter(dev->cpu, state, s2idle);
> 	ret = psci_cpu_suspend_enter(state) ? -1 : idx;
> +	trace_psci_domain_idle_exit(dev->cpu, state, s2idle);

> Then make the above into a DECLARE_EVENT_CLASS:

> DECLARE_EVENT_CLASS(psci_domain_idle_template,

> 	TP_PROTO(unsigned int cpu_id, unsigned int state, bool s2idle),

> 	TP_ARGS(cpu_id, state, s2idle),

> 	TP_STRUCT__entry(
> 		__field(u32,		cpu_id)
> 		__field(u32,		state)
> 		__field(bool,		s2idle)
> 	),

> 	TP_fast_assign(
> 		__entry->cpu_id = cpu_id;
> 		__entry->state = state;
> 		__entry->s2idle = s2idle;
> 	),

> 	TP_printk("cpu_id=%lu state=0x%lx type=%s, is_s2idle=%s",
> 		  (unsigned long)__entry->cpu_id, (unsigned long)__entry->state,
> 		  (__entry->s2idle)?"yes":"no")
> );


> DEFINE_EVENT(psci_domain_idle_template, psci_domain_idle_enter,

> 	TP_PROTO(unsigned int cpu_id, unsigned int state, bool s2idle),

> 	TP_ARGS(cpu_id, state, s2idle),
> );

> DEFINE_EVENT(psci_domain_idle_template, psci_domain_idle_exit,

> 	TP_PROTO(unsigned int cpu_id, unsigned int state, bool s2idle),

> 	TP_ARGS(cpu_id, state, s2idle),
> );

Looks good. Let me apply this change in v2.

Thanks,
Keita

