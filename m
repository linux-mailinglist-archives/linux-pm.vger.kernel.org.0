Return-Path: <linux-pm+bounces-16769-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0463C9B6D9D
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 21:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A39FF1F22186
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 20:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5792141B4;
	Wed, 30 Oct 2024 20:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LxhEv9OV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DC420CCE9
	for <linux-pm@vger.kernel.org>; Wed, 30 Oct 2024 20:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730319932; cv=none; b=CoNzVtHs747WqC48NUWS5Idd188r5NCw+HPiXgOnAn/w1Fjbb89MeBDqb4uiQXg212fTmtUTw4xelJEfVoRuLIFvXDHDORH/0m4sP8p4llfDMfQUxTlx3CkHDp2yBrUBbcl9htWZTYgOnSMYV7GWpPeZjlFLD8RSST7djVlhFko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730319932; c=relaxed/simple;
	bh=QY++2T5Pmvk5qxvLJOnmGVWyC+H/BZK5a9m+PghPWtY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JBAI9gtbX6pMwo2ehgeUgHpR2UqyOWiBX/kx+rulYqISPvjPLoXRee2j4gejAa4ydvuJu4eegBxHn+N4Y/S0esRGS8cY41hAhnokQG25NlzuqhgE+NjnR/QLQuROQwhPXfqlWb7cGbfzqJm8EaMGXA7dWHyzC3T+CG7MKKhlW+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LxhEv9OV; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20cb47387ceso2588965ad.1
        for <linux-pm@vger.kernel.org>; Wed, 30 Oct 2024 13:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730319930; x=1730924730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hf9QiAwNrV2BP9liwrqvOCTzPddJpArs0uDNj2mNkZU=;
        b=LxhEv9OVLhfmWk3gji/6qFJVJQxOceqt/tnJPC3kvjEdoOo7WrGYVx36fGSL4e6c6N
         Om5m6X8Tma2Q5rsTL5u9RY07BThu4pde0sv/qTYqvRBhUP/58aQ6zxG92/xP/IFlr5fD
         XvunsxubPMK4V10ZSMWzFJaqyXMhMw8SJZVTcLfzTbpxlt8YjGnsz7Crnh+f1+x5ntbL
         I/XmZo6sZqR+KYcBGF66WBKxyxxg9LGv83vMbIa1KJWuiRAWqzeyND8rl655sTKA/8uQ
         eZTg6nzIU7/WCeZ6/3ZE3XS/WkuIAynz4oF8eQUtKgvoudajFvCNCCa5VIinnkcH5cwl
         UKVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730319930; x=1730924730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hf9QiAwNrV2BP9liwrqvOCTzPddJpArs0uDNj2mNkZU=;
        b=ok/a0PXTDTNV0+E/QF57Ig0sO9VIiiKszQbWBCMjq08pFF89n0hxi2rTZhH8eeq/YD
         tqpPGXrMpii3b7Lht5q2w5KT5fFh0L4IqhySXoTfP9qLX1xvj8jQB69gyte6m5DWAsFv
         lOy8sxID7OmdNWHnS5GLNs/MZdGi7gzqxev1UKS5u+vnIGN18AvdJVId5sAA+rZkXWwn
         LX2+3P4+mQXpiaDjNbgSLxJx6BN5TV1/JNXUx71ADik+dMXc0HWBj1qh+VTNuGJjm+vb
         uU92anfVLBePKcLM8AlsaZgeQUsBO2hQ1c/eCyXAFFJFwC/AY7ZXveY9PwKmvedUz/Uo
         YMFQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3xcWJXZFIOy73iXIUGbzjs523IQLMqeyyGVDUwRHzk3m40jc7uJbtz7VihrQry+Ub7FHXoCGFYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJNUOC2Cu/Lu74g6IuYXMkTIzOlrywg8VQFWKZfSyU/54cwYAp
	hujXd6//3CXlrcab+MGsk6UCV4mSxQUvWv9g8Z8fWm55dK3Ok9GzRu9af/oEw7S6cjtsgCYJP08
	QVGIpCeZi4p8fn3Sh625GmQnKQdvhbxlOqIDB
X-Google-Smtp-Source: AGHT+IFcyE/KPe7uayYNSJipFWHsVewf9X2YceDhvbkhjs8fCYkrVXSd7t9GwXHmvjDuSYHx2yHuNwmPaxSxhZDWSbY=
X-Received: by 2002:a17:90a:b111:b0:2e2:d16e:8769 with SMTP id
 98e67ed59e1d1-2e8f106926emr18302577a91.15.1730319930212; Wed, 30 Oct 2024
 13:25:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240919000837.1004642-1-davidai@google.com> <20241029063626.haz6b77vbw6pp756@vireshk-i7>
In-Reply-To: <20241029063626.haz6b77vbw6pp756@vireshk-i7>
From: Saravana Kannan <saravanak@google.com>
Date: Wed, 30 Oct 2024 13:24:50 -0700
Message-ID: <CAGETcx_vZkA8sCBFJ=wJPbTaTKKMg0DEPox5aoED1iVewqBkXA@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] Improve VM CPUfreq and task placement behavior
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: David Dai <davidai@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sudeep Holla <sudeep.holla@arm.com>, Quentin Perret <qperret@google.com>, 
	Masami Hiramatsu <mhiramat@google.com>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Pavan Kondeti <quic_pkondeti@quicinc.com>, 
	Gupta Pankaj <pankaj.gupta@amd.com>, Mel Gorman <mgorman@suse.de>, kernel-team@android.com, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 11:36=E2=80=AFPM Viresh Kumar <viresh.kumar@linaro.=
org> wrote:
>
> On 18-09-24, 17:08, David Dai wrote:
> > v6 -> v7:
> > -Updated .exit and .remove function type from int to void to match
> >  required types
> > -Added Reviewed-by tag from Rob on dt-bindings patch
> > -Dropped "depends on OF" as the driver doesn't depend on it
>
> > David Dai (2):
> >   dt-bindings: cpufreq: add virtual cpufreq device
> >   cpufreq: add virtual-cpufreq driver
> >
> >  .../cpufreq/qemu,virtual-cpufreq.yaml         |  48 +++
> >  drivers/cpufreq/Kconfig                       |  14 +
> >  drivers/cpufreq/Makefile                      |   1 +
> >  drivers/cpufreq/virtual-cpufreq.c             | 333 ++++++++++++++++++
> >  include/linux/arch_topology.h                 |   1 +
> >  5 files changed, 397 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/cpufreq/qemu,virt=
ual-cpufreq.yaml
> >  create mode 100644 drivers/cpufreq/virtual-cpufreq.c
>
> Applied for v6.13. Thanks.

Thanks!

-Saravana

