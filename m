Return-Path: <linux-pm+bounces-8405-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F65B8D46D7
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2024 10:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C97E1F22B30
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2024 08:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE67914D45A;
	Thu, 30 May 2024 08:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RgZ26U17"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85F7DDA1
	for <linux-pm@vger.kernel.org>; Thu, 30 May 2024 08:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717056957; cv=none; b=A9Yld5GiOwei82MKs9l9EkUblFASrbZpfodRTs8SGEI7JPoV7LS7XhWU5BgVPTEUnTJn82EOXMdvGMSG68rWWcyUm2l77X4hzq91ZOLZ0EAuYXG4eFvye7bhD1rYfT83/u3XmjtduDh2bgXcmlLuIbYcHGVRtIBDIT/9ucth/fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717056957; c=relaxed/simple;
	bh=R/6+LIm49u8oTIwIKRyzFjXZG4HUwTDHPLWkBzXDelo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=evU0RPvnLmEfbwJNQg9mLLOBdLAk6d1LfxgsEoqM8AD1XkXMXzh7hDsny7fHtkjVe9mK8v3kUXY4pv7kBx43Yi/qV8kMmr0/qhshlpmOk/OXJMS57U3hjiptvuY8JBEXozbQ9hL/9xlmg1xdZpJavBwQCmIIrN1ZoKNDtk83+jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RgZ26U17; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-62a0809c805so6688937b3.0
        for <linux-pm@vger.kernel.org>; Thu, 30 May 2024 01:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717056954; x=1717661754; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k20/mggq32MX0XT5cSqtsxqcJ+lwttdw4RIhMsw0RBg=;
        b=RgZ26U17jWa2sN5I0bOLewkXd305iNTW/U0lwcOT/FbvLEFne0px3CE4ByU7jaO9rH
         vVM9Kzh1eBfG31xDr0dq2r7JKLcrUJNIEMgWmbrdU5FHuRNObUKDt8eDcpmnsjLNnJ3j
         Lm2dZ4rRLbz0fqig3Fakqdtc/P6XG7KFMjuyBSCCwsswEbNh5WGHCtz8Rsx29YQbaVGq
         cQ+eWaTZdPA3m4tsV+tMfkPSqnKLESGD0Siba9Gm7ZL/v9FcC9Yt443UjGY9I/fwKAGD
         9kywt8P0JBlXiTxZTOIh1pW6kv5pMQMmgjFYnRZ5IA5jo5SnkkiezfZnvXeXFi/aZMo2
         w+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717056954; x=1717661754;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k20/mggq32MX0XT5cSqtsxqcJ+lwttdw4RIhMsw0RBg=;
        b=VnA20W8RCrgtMEeP0ANmA9ruPBLW2v6JLc697F1nNU6D6eHBlfdx2QGFaeoMLs00bz
         chMwIeVlk+91FkVfMQ3lY5nznRCa9XzzmnvdjDizz14Vesa510TZJproJsZEj5H8SIJ4
         Qp26249VTS5lLau8IbkUQQMYM8ZAjm7Io9m+MneWcsLUeFGuC+Fq7zkJ++VY/qGghjCz
         w9j6VmIiAnVeweNMXprIe1qow8siZUQ14c9z1UQiOH1tNQWHKCHnmIkzby8UjhQHf9bm
         GEw7qyTDE34ctgYRDteGTnHQpdijS4lkO9HY/uZ847t8c6l5BTykb1Xj9duSPoQGuT/+
         B6EA==
X-Forwarded-Encrypted: i=1; AJvYcCXLzJ61Kp2tBvpWkIdZX5PwMEFcyZrIetHECNczZNv7fweHiwycC7dTTAcytKAbqHqFvR0LDXgDIIEPsES9O61spZwJzTYG000=
X-Gm-Message-State: AOJu0YzIK83dytVggJOY0biN6eeFIedFW2OhAT0UjaCMGeemFKS6FFAt
	gTQgiviEOf/Vd/LW8dFKXvblzvA/9aMcuaL2JXWqSEtoikKq42QfQVnEbQr/JpZSjrJZlUMoyCa
	Qo0Fou/OK+KZLVNjuRt6jvrL6d4J4L0ttEdmt/mJN6rS36gk8x3g=
X-Google-Smtp-Source: AGHT+IFONaJRLFLyyUuBmDyblLsckMpdUUsrv4sxy/G30tTT+g+cVd3FIJtEM2RvUpHMWBlC+lY7cA5GEvsw+laVk1I=
X-Received: by 2002:a81:80c2:0:b0:61b:e871:9115 with SMTP id
 00721157ae682-62c6bc3e020mr10625537b3.17.1717056953560; Thu, 30 May 2024
 01:15:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527142557.321610-1-ulf.hansson@linaro.org>
 <20240527142557.321610-2-ulf.hansson@linaro.org> <52dce8d3-acfa-4f2c-92d0-c25aa59d6526@quicinc.com>
In-Reply-To: <52dce8d3-acfa-4f2c-92d0-c25aa59d6526@quicinc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 30 May 2024 10:15:13 +0200
Message-ID: <CAPDyKFq0V9ke30zYAGzS1aU0yq49DdfDkfYzxkLBZuaVGsyGDA@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] pmdomain: core: Enable s2idle for CPU PM domains
 on PREEMPT_RT
To: Nikunj Kela <quic_nkela@quicinc.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org, 
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Nikunj Kela <nkela@quicinc.com>, 
	Prasad Sodagudi <psodagud@quicinc.com>, Maulik Shah <quic_mkshah@quicinc.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, linux-rt-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 May 2024 at 21:56, Nikunj Kela <quic_nkela@quicinc.com> wrote:
>
>
> On 5/27/2024 7:25 AM, Ulf Hansson wrote:
> > To allow a genpd provider for a CPU PM domain to enter a domain-idle-state
> > during s2idle on a PREEMPT_RT based configuration, we can't use the regular
> > spinlock, as they are turned into sleepable locks on PREEMPT_RT.
> >
> > To address this problem, let's convert into using the raw spinlock, but
> > only for genpd providers that have the GENPD_FLAG_CPU_DOMAIN bit set. In
> > this way, the lock can still be acquired/released in atomic context, which
> > is needed in the idle-path for PREEMPT_RT.
> >
> > Do note that the genpd power-on/off notifiers may also be fired during
> > s2idle, but these are already prepared for PREEMPT_RT as they are based on
> > the raw notifiers. However, consumers of them may need to adopt accordingly
> > to work properly on PREEMPT_RT.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >
> > Changes in v2:
> >       - None.
> >
> > ---
> >  drivers/pmdomain/core.c   | 47 ++++++++++++++++++++++++++++++++++++++-
> >  include/linux/pm_domain.h |  5 ++++-
> >  2 files changed, 50 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> > index 623d15b68707..072e6bdb6ee6 100644
> > --- a/drivers/pmdomain/core.c
> > +++ b/drivers/pmdomain/core.c
> > @@ -117,6 +117,48 @@ static const struct genpd_lock_ops genpd_spin_ops = {
> >       .unlock = genpd_unlock_spin,
> >  };
> >
> > +static void genpd_lock_raw_spin(struct generic_pm_domain *genpd)
> > +     __acquires(&genpd->raw_slock)
> > +{
> > +     unsigned long flags;
> > +
> > +     raw_spin_lock_irqsave(&genpd->raw_slock, flags);
> > +     genpd->raw_lock_flags = flags;
> > +}
> > +
> > +static void genpd_lock_nested_raw_spin(struct generic_pm_domain *genpd,
> > +                                     int depth)
> > +     __acquires(&genpd->raw_slock)
> > +{
> > +     unsigned long flags;
> > +
> > +     raw_spin_lock_irqsave_nested(&genpd->raw_slock, flags, depth);
> > +     genpd->raw_lock_flags = flags;
> > +}
> > +
> > +static int genpd_lock_interruptible_raw_spin(struct generic_pm_domain *genpd)
> > +     __acquires(&genpd->raw_slock)
> > +{
> > +     unsigned long flags;
> > +
> > +     raw_spin_lock_irqsave(&genpd->raw_slock, flags);
> > +     genpd->raw_lock_flags = flags;
> > +     return 0;
> > +}
> > +
> > +static void genpd_unlock_raw_spin(struct generic_pm_domain *genpd)
> > +     __releases(&genpd->raw_slock)
> > +{
> > +     raw_spin_unlock_irqrestore(&genpd->raw_slock, genpd->raw_lock_flags);
> > +}
> > +
> > +static const struct genpd_lock_ops genpd_raw_spin_ops = {
> > +     .lock = genpd_lock_raw_spin,
> > +     .lock_nested = genpd_lock_nested_raw_spin,
> > +     .lock_interruptible = genpd_lock_interruptible_raw_spin,
> > +     .unlock = genpd_unlock_raw_spin,
> > +};
> > +
> >  #define genpd_lock(p)                        p->lock_ops->lock(p)
> >  #define genpd_lock_nested(p, d)              p->lock_ops->lock_nested(p, d)
> >  #define genpd_lock_interruptible(p)  p->lock_ops->lock_interruptible(p)
> > @@ -2079,7 +2121,10 @@ static void genpd_free_data(struct generic_pm_domain *genpd)
> >
> >  static void genpd_lock_init(struct generic_pm_domain *genpd)
> >  {
> > -     if (genpd->flags & GENPD_FLAG_IRQ_SAFE) {
> > +     if (genpd->flags & GENPD_FLAG_CPU_DOMAIN) {
> > +             raw_spin_lock_init(&genpd->raw_slock);
> > +             genpd->lock_ops = &genpd_raw_spin_ops;
> > +     } else if (genpd->flags & GENPD_FLAG_IRQ_SAFE) {
>
> Hi Ulf, though you are targeting only CPU domains for now, I wonder if
> FLAG_IRQ_SAFE will be a better choice?  The description of the flag says
> it is safe for atomic context which won't be the case for PREEMPT_RT?

You have a point!

However, we also need to limit the use of raw spinlocks, from
PREEMPT_RT point of view. In other words, just because a genpd
provider is capable of executing its callbacks in atomic context,
doesn't always mean that it should use raw spinlocks too.

[...]

Kind regards
Uffe

