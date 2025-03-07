Return-Path: <linux-pm+bounces-23621-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1718FA565A5
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 11:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F0243ADF1E
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 10:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B49F20E302;
	Fri,  7 Mar 2025 10:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AbrUSoQk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4991A239E
	for <linux-pm@vger.kernel.org>; Fri,  7 Mar 2025 10:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741344145; cv=none; b=ZELGOhup3W5wC/YK2Lf4j3Z4OaVRGUGdjY5Yi3Deoq7oqX57QH0JgFOXxnvbJQcdx4anmSCyZndc52mAjUT/15RGGJ+e+hrHAtLwQMpikb2xsy1lIeTiw3XAPp9dm68hV7eX/7N80Tg05opq/o52xyfhLqob6FgVl6KpCxYP28I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741344145; c=relaxed/simple;
	bh=lsavoPaGmfl7xBe3eGeyegwuQTehNQkXPIt3HPhhJAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nYU0Ra4BYBR/ozRgAi8ReUrpwndu/1cUqK/TYZfIAMVWY2aUb9EQcQPmHIQxPDypQm5ZSsuAPr5nyvZMnNKTUFt1UFyucW21WMAASY71difSrf24nKaZNMrWSAJZBlHVVrfIeQxHDK23KABBEAVZQPEQ9YQ8ULTvzAja/INWDz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AbrUSoQk; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6fd6f7f8df9so14454077b3.1
        for <linux-pm@vger.kernel.org>; Fri, 07 Mar 2025 02:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741344142; x=1741948942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rT9XBL4gaIH5wTfFP7ZDqQbyPhjMUoycaEEEpfHomFE=;
        b=AbrUSoQk6nhlWFqO4asokVbEHik6sxhxTXBMehcD48PPi+kiZ+QoMj89UqyX7uGJqn
         rox/zaobznu8VGNUgQi8tX6lzq87JapVbrrWnYIpiUeq3DeNNmRy4rPbXtKk1stnx7/D
         lhol3BWGiEoTAW8u+58noZaHj3mP5ogjQ6/orsrCyR44hr28qd+7ay6ZffuRBMGpkteN
         TMrMU10f2+/CfUMCMQagngKpeN3BUixY3A6QIVGxvPOGNp4Ue6wJRJmZ9loaf8zPxQUo
         jTI2Cy0+qzSTynAPbIDpXqrQt9A2XV9xF8LbItcFpCbjdlj0skD37bgLAhgUNK3ZyGKQ
         fFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741344142; x=1741948942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rT9XBL4gaIH5wTfFP7ZDqQbyPhjMUoycaEEEpfHomFE=;
        b=e6BIkY6j67YAreyqStwuHbHuHQaJIyBF2IVEMwFY5PPd1fubXF7jFRvgRgXqrlc2FR
         PcEv6DTaiHTDQK90E3CeBlTn2pHJiwdR5j4AK/IYFVQN06ETGJXbsIlZtdkRwgrEzKSJ
         5fwH1kwRYxrvQegIa17Jj3EXdedM7Wrz+JqDSp7Ufo0CF5zpBvmpa+gkQgiowQIb3JzQ
         LAf+gSj3JMacMMc08ArsfVIz67EkzpB+LdVX46AqlkaAFFdatqMnv2LESSjBGr8eHz7y
         zS6Duni1lfNzeeyIYE+Lpd+YWUM3p3QnUel4VuJP2pETWabrikga/AFU6CN3F/hkKJu/
         OG2w==
X-Gm-Message-State: AOJu0YxX5XhSlDnm6/xVsnxisiAXL7HICg4go//noa+lSH/LGPRoCeKe
	SjFppVorpqzdGHeOxF8J51ATFV/SJlq7u/6BAAuJnDPNGVhkBTyT0jyvGeyvrBYnqkUK85M2OuK
	QI/71npxIFbMFX3cNlQWgY65GaCAxDKGwNvolz19Ifn+y4XdV
X-Gm-Gg: ASbGncvHyjIh7cM2Ii2MA4XlNLc6ZSRfmxBGJGGBJXH/9ZsrSG+3RVKgZJHFNYr0wxb
	oSxIdg1wmc5ImF9nSVFDiyeqK0fG7bOjz1eBf3P86uJ2PYzTB7+ksBdoQqkgpb0N0GV+Dls3GY0
	U0GFvXLYK0meD3+USpYkgSLl3SYQ==
X-Google-Smtp-Source: AGHT+IHXG/0/hShmRUvQAKC9AHfln9CojQ/qyZWB4omLmQIq0J2ete1izlY+85xW6NmBXSV/D95xXORrnvizdPCA3uM=
X-Received: by 2002:a05:690c:b15:b0:6f7:9f95:d916 with SMTP id
 00721157ae682-6febea564cfmr43081107b3.16.1741344142511; Fri, 07 Mar 2025
 02:42:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306113549.796524-1-ulf.hansson@linaro.org>
 <20250306113549.796524-3-ulf.hansson@linaro.org> <CAJZ5v0hF_am9DsuwEUmmgpUp=1ZuAG8fdjYfQ5XxFmS_Y1pMog@mail.gmail.com>
In-Reply-To: <CAJZ5v0hF_am9DsuwEUmmgpUp=1ZuAG8fdjYfQ5XxFmS_Y1pMog@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 7 Mar 2025 11:41:46 +0100
X-Gm-Features: AQ5f1JqZoOcwKfjkiNxmTrOdstASOHx5S-JbLRg16VovAosUluf6_t-OvA7HKso
Message-ID: <CAPDyKFphQS4x68f-rHHkhG8w7b6UJcE32v0u-XApicn1pPARXw@mail.gmail.com>
Subject: Re: [PATCH 2/2] PM: s2idle: Avoid holding the s2idle_lock when
 calling pm_wakeup_pending()
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, 
	Pavel Machek <pavel@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 6 Mar 2025 at 14:18, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Mar 6, 2025 at 12:36=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
> >
> > There's no reason to hold the s2idle_lock longer than necessary. Let's
> > instead acquire it when really needed in s2idle_enter().
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  kernel/power/suspend.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> > index e7aca4e40561..ca09f26cbf4e 100644
> > --- a/kernel/power/suspend.c
> > +++ b/kernel/power/suspend.c
> > @@ -91,10 +91,10 @@ static void s2idle_enter(void)
> >  {
> >         trace_suspend_resume(TPS("machine_suspend"), PM_SUSPEND_TO_IDLE=
, true);
> >
> > -       raw_spin_lock_irq(&s2idle_lock);
>
> This is to prevent missing a wakeup event when pm_system_wakeup() runs
> at this point on a different CPU.
>
> If you move the locking, it may run as a whole between the
> pm_wakeup_pending() check below and the s2idle_state update, so the
> wakeup event will be missed.

Of course, you are right! Thanks for clarifying!

>
> With the locking in place, the pm_abort_suspend update in
> pm_system_wakeup() may still happen at any time, but the code under
> the lock in s2idle_wake() after it can only run before the lock is
> acquired above or after it is released.
>
> If s2idle_wake() in pm_system_wakeup() runs before the
> raw_spin_lock_irq() above, the pm_wakeup_pending() check below will
> notice the pm_abort_suspend set and return true, so the suspend will
> be aborted (and the pm_abort_suspend update in pm_system_wakeup()
> cannot be reordered entirely after the s2idle_wake() call because of
> the locking there).
>
> Now, if s2idle_wake() in pm_system_wakeup() runs after the
> raw_spin_unlock_irq() below, it will notice the s2idle_state change
> and it will update it to S2IDLE_STATE_WAKE, so the suspend will be
> aborted.
>
> I guess it would have helped if there had been a comment describing this =
...

Yes, I can send a patch adding a small comment about it, if you think
it makes sense?

[...]

Kind regards
Uffe

