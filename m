Return-Path: <linux-pm+bounces-20991-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2523A2037F
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jan 2025 05:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ED4F3A6EDE
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jan 2025 04:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629D8199E84;
	Tue, 28 Jan 2025 04:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pw7ahbTG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7792198A06
	for <linux-pm@vger.kernel.org>; Tue, 28 Jan 2025 04:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738038291; cv=none; b=a/KQm2VHe/5AWxKojKp3ThK5L8qQ81jzKDcR21tQxwKRiwJzJQjuOKZCQDZX3BqgMXev8aY9kJwu7bdfXW9zN0th1nxhtPwThKo3xcKa++2nrpuUCvDdlUPcmvLYUNLjhCZdAWHnn2Pa/gDshbZ0EmP2ok71IXgS5eYeabTNdvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738038291; c=relaxed/simple;
	bh=9pPScUxaXH3Noy9LJrFwGVwB6nP+al9S0wDXhxf+xAQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tp95klLsrlfMKZzEFhemYO6Zehps3sLR1mn4nfTazigPqpR+WEwxebdYRQG4XXyN5thkkkzLYD1duMysx2/2F0ZWt8hURQJiv/iVKyDIBCFyo5F+/e2UYmM7NbstnNBLnsO45UgVnwc/gR1nlQplwEfN1kO0sKdCy3mkz3sUT1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--keyz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pw7ahbTG; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--keyz.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2162f80040aso93601585ad.1
        for <linux-pm@vger.kernel.org>; Mon, 27 Jan 2025 20:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738038289; x=1738643089; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bu3J2SiM3EvMSMPeW7x/ZDWaOfsREkmMvF5jvQ/561M=;
        b=Pw7ahbTGR630FyMpAYrlY3ig8IVWIgyuG97Du5UPqNut3wZdPpZP6qzEft7trncaTK
         dlfFxoJBMTc5QZ/w49NLhBY6leDXjyuUYVOuD2+imsvjV4cXPDpluS8cJPymBkuW0qTg
         B0bkS8w593O9w+vW7OUMtXgz2o9diJzP7qJIyB+j/BC/S46/saQjV5+hlrlj+X60Z6bS
         /Hc3wZJYPBlVQGy55rJt00tMUTcgrUe1it2n5XAJzAIlnYM+4kiOuE15BbeqezHusfCY
         pzoKzpdUN8/TiU9U96L09UZumuPdGUmSejXxhyq88XBmG+J3cVCl5qc4rd/68nZv2HzB
         b+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738038289; x=1738643089;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bu3J2SiM3EvMSMPeW7x/ZDWaOfsREkmMvF5jvQ/561M=;
        b=I+2OQtJCg29p44UkCZs/NaSCaaiLG7OAyLblsBRRBLyN+uBJrsLkcCwrrD9CkeBovk
         FJ2bO4+vpzp+gswXTk3qLq0QyHlOVHyB0gQ/9JEt6SnDxWTV6iKj1/LR1zUblQ3p3cbq
         WhnmaL06B1wQECc4dLYpLKBPZKTyGUUe7c750SD9LJDstAVGy/ATWjHSIU1vVXhE0NRe
         97eNOS7luGcYKBiN1NK8TIyi+OwwRLkFydanGrF11CrCHd0nHNsmbbiQ6o5hIcfm0gbF
         Rwwxcu5jdovWKNJKKfpP9ZOiHCzkz1Fd3BUd02KxjMLp5wRPtiNj1hbKGUex8Gn5Cs/9
         8LDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCqGg54ORDZOled3fjxgikrjdp/FXZe3NGR5ZGBtmgqe6fS/IJWgxxwPCBbhwx+p4/8Z2SUVozzA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwtGGLQyCpPW8z+GsQWn64MHBvkfpKSCo62a0jRJP4KW/SGhqHF
	6wn22zm4ElUoNQB88Hmv5eFUPhL067UxsMonAPvYaPYmiVpByB9nk8gQML3RwxMkLfLAdQ==
X-Google-Smtp-Source: AGHT+IHFqSoHXLdhNPrTC3YRwuLwCUJpWxmu6MnWjbEB7WtYAER1cmeowowTeLs3ri7TD8slgqXM1sxX
X-Received: from plhv17.prod.google.com ([2002:a17:903:2391:b0:216:eefe:2c35])
 (user=keyz job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d48a:b0:212:67a5:ab2d
 with SMTP id d9443c01a7336-21c35604a08mr795458485ad.44.1738038289058; Mon, 27
 Jan 2025 20:24:49 -0800 (PST)
Date: Tue, 28 Jan 2025 12:24:44 +0800
In-Reply-To: <31dd8c5d-0bc4-4d84-9ac9-7ca248e952cf@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <31dd8c5d-0bc4-4d84-9ac9-7ca248e952cf@arm.com>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Message-ID: <20250128042445.24920-1-keyz@google.com>
Subject: Re: [PATCH v2] cpuidle: psci: Add trace for PSCI domain idle
From: Keita Morisaki <keyz@google.com>
To: christian.loehle@arm.com
Cc: aarontian@google.com, daniel.lezcano@linaro.org, keyz@google.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, lpieralisi@kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rafael@kernel.org, 
	rostedt@goodmis.org, sudeep.holla@arm.com, yimingtseng@google.com
Content-Type: text/plain; charset="UTF-8"

> > The trace event cpu_idle provides insufficient information for debugging
> > PSCI requests due to lacking access to determined PSCI domain idle
> > states. The cpu_idle usually only shows -1, 0, or 1 regardless how many
> > idle states the power domain has.
> >
> > Add new trace events namely psci_domain_idle_enter and
> > psci_domain_idle_exit to trace enter and exit events with a determined
> > idle state.
> >
> > These new trace events will help developers debug CPUidle issues on ARM
> > systems using PSCI by providing more detailed information about the
> > requested idle states.
> >
> > Signed-off-by: Keita Morisaki <keyz@google.com>
> > ---
> > v1->v2: Split the ftrace event into two (psci_domain_idle_(enter|exit))
> > 		and rephrase the commit message accordingly. Rebased onto the latest.
> Which makes it different to cpu_idle event FWIW.

Yes, psci_domain_idle_(enter|exit) are not meant to replace cpu_idle nor a
variant of it. It's new and different events that provide finer=grained info.

> >  drivers/cpuidle/cpuidle-psci.c |  3 +++
> >  include/trace/events/power.h   | 37 ++++++++++++++++++++++++++++++++++
> >  2 files changed, 40 insertions(+)
> >
> > diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> > index 2562dc001fc1..dd8d776d6e39 100644
> > --- a/drivers/cpuidle/cpuidle-psci.c
> > +++ b/drivers/cpuidle/cpuidle-psci.c
> > @@ -25,6 +25,7 @@
> >  #include <linux/syscore_ops.h>
> >
> >  #include <asm/cpuidle.h>
> > +#include <trace/events/power.h>
> >
> >  #include "cpuidle-psci.h"
> >  #include "dt_idle_states.h"
> > @@ -74,7 +75,9 @@ static __cpuidle int __psci_enter_domain_idle_state(struct cpuidle_device *dev,
> >  	if (!state)
> >  		state = states[idx];
> >
> > +	trace_psci_domain_idle_enter(dev->cpu, state, s2idle);
> >  	ret = psci_cpu_suspend_enter(state) ? -1 : idx;
> > +	trace_psci_domain_idle_exit(dev->cpu, state, s2idle);
> Not tracking ret seems odd, is that fine?

I think it's fine not to track ret here.
__psci_enter_domain_idle_state does not seems to care the return value of
psci_cpu_suspend_enter to me because it just proceeds with executing subsequent
functions regardless of ret, and returns ret to the higher function. If the
value should be traced, it should probably be done in a lower layer or a higher
layer.

Another small small reason I'm not interested in adding ret to the
trace_psci_domain_idle_exit's arguments is that
trace_psci_domain_idle_(enter|exit) currently share the same trace event
(i.e. same set of arguments) and it makes the trace events simple.

