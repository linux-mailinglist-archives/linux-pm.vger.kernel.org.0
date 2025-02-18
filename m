Return-Path: <linux-pm+bounces-22308-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF752A39C91
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 13:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9F003A84AC
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 12:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E8825A643;
	Tue, 18 Feb 2025 12:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xjmHC7aY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19711DDE9
	for <linux-pm@vger.kernel.org>; Tue, 18 Feb 2025 12:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739883322; cv=none; b=LNGPGr1/VZjNhT3IxCXMAuBnNIvhGG551QjwFK1OE1ozrV3soFx+S6mvlsu5fPSLJ9MKSvY3Xbav1Nko81MZKpjO1nviWHEIJ4liJGl9P9V4YwpG4H7P1nhlB8U80Hcp8p2nsv80PROcu8/mw+3YJbFj4zLiq3LFssCRmb8ZoAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739883322; c=relaxed/simple;
	bh=fAkWF5NGE22B9x/eQFJgw5Q4IlMRLRI9uy2c5Qbi6y8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dl/qosegEbfHul3hffs3ERrhLvAV9LhRDNSM47+WfGUsryW0CZtWjnja1Wy9cZdKxOB4lGNitPV65hgeYqY2baj8QwXBO9lP5WX4o0oB+ulaz4RWaioP8A+A+zPLZ0qA3jZ3HgecQFr6SsGhPeMqasWvdVvMYe71JKpbPoNeq7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xjmHC7aY; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e3978c00a5aso4019302276.1
        for <linux-pm@vger.kernel.org>; Tue, 18 Feb 2025 04:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739883320; x=1740488120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XKP0fSYcRydlhHwC4VSz6cV+PfN3f0BcpYNYU9tHcGI=;
        b=xjmHC7aYrf6M8SPb9+IIM9aYlMNPt4+njn1XHSEEM6L9gc+a+6W4XnFeUn07X1A7ku
         h08pQQaLCOaWHh6frmySvgUDKRLwozmxM1nd7d7baQKmA23UlPjXuqf4OR+RoDDp23EA
         dOa+vjmSq7t8eB5AGb4+g8oE/QT4PPSKKKcVCn1DfQuY2pGUR0YfJw2YSsilb872QQY3
         niHxPqL+jkcOYuiD+mr1QctLmVqwQ6ANAz09eHTrg8OCZBaYsXaji73s/1ZLuL/qDYsN
         8wNTEdLPGvvkP922+Bwaty0bX5ADdJ+c/sllhmN1/slKuecDO/QlkqyWOWq0lnubfqzN
         aZ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739883320; x=1740488120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XKP0fSYcRydlhHwC4VSz6cV+PfN3f0BcpYNYU9tHcGI=;
        b=rlRsds9exJYCj8an+zdtixgih1iLcRZfdNT5+5/djTYCrGikU5rxyX7SF3YNNWBK22
         2b0aWutOFThwLPteXD1QtMyaeKVePRWG+0XqsFsbx4qG+lsfSot5Inr7wqB1GGaxmn0T
         w5BLlV17+JsZ6nsU3QxYjVeLoX8JNzGIzWuVRwkrghWgx6ZCoguEKrq0iLIUWvvMbwGN
         CVBnSERdA9Ptu02d2ezWApsjThZngUpAnviQ8vkz7duTMaBHIxSKpkcnWAHM6jsfoW/1
         0FEgGcnJDy70LJCmA9Mf1n1IKQxGyWuXYT8m8IXvhpppyixtgfXbYgEW5h1Oc1881o82
         nZBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxGy2v1QEnOxHBUjAq5ELCsohbZPSzbVvklU35ap3sRR/eSqnZ4jc6De0921sQ1DswtUhVm+nH3w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLf+6k0i74BIrYo9uquL8L5JMK0HWD16RBWvyCw27gL2EE8clC
	pcA0OMponoNS9WhxoQaHAcSk5EOMWy7vQStQpgSbUkl8cHuyvC82eaXHkyi16G1kRZ1NuIXmexO
	6aiIUtAGsvtwJB2jOriU+ap7MRuZRIVFq34aepg==
X-Gm-Gg: ASbGnct9q47qpMzzbuP0bWfOyzTfxEUr9MPGH721pvy2cJU0gor50tmLMtfJ08ZPF8I
	9xTQ6DNlgvCCthOdQfGGVPqt4jxWu6DpaGPVWHGGn1yU/D2M1SjPbMzmnY5PlFS/9eDXLjmul6Q
	==
X-Google-Smtp-Source: AGHT+IGqWa+YTDuo/jIeuuse8zv3M2XdO5Dzh8lkFtkue0oKd3y7Sr4YadCsNIUJp3SxZ4H9b90Z6MNHcCka61iZ7fo=
X-Received: by 2002:a05:6902:3387:b0:e5d:b2c4:7cb7 with SMTP id
 3f1490d57ef6-e5dc9047e37mr11320156276.12.1739883319875; Tue, 18 Feb 2025
 04:55:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217140145.117086-1-ulf.hansson@linaro.org> <CAJZ5v0hi=zCuhmVRf2HVRWkR53U7xqxC3oQDs8-JN-cyQ+ZX1w@mail.gmail.com>
In-Reply-To: <CAJZ5v0hi=zCuhmVRf2HVRWkR53U7xqxC3oQDs8-JN-cyQ+ZX1w@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 18 Feb 2025 13:54:44 +0100
X-Gm-Features: AWEUYZkPUdp4exJ6jSmob_1efkRW1I1YA2HXT-xMpcoDiySdNuxCrLPd8wp93yY
Message-ID: <CAPDyKFq1w7Ez+6GSKDeCpeQ=Xm4c3U9BMu3G8q+v2MXk1TdwKw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update section for cpuidle-psci
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
	linux-pm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 18 Feb 2025 at 13:48, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Feb 17, 2025 at 3:01=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
> >
> > Add myself as a co-maintainer for the cpuidle-psci driver and the
> > corresponding git-tree, which I am already using for this.
>
> Lorenzo, Sudeep, any objections?
>
> Ulf, do you want me to pick this up?

I can take it via my pmdomain tree, but thanks anyway! Let's also
leave some more time for Sudeep/Lorenzo to comment.

Kind regards
Uffe

>
> > Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  MAINTAINERS | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 25c86f47353d..f2be70dec4ee 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -6087,9 +6087,11 @@ F:       include/linux/platform_data/cpuidle-exy=
nos.h
> >  CPUIDLE DRIVER - ARM PSCI
> >  M:     Lorenzo Pieralisi <lpieralisi@kernel.org>
> >  M:     Sudeep Holla <sudeep.holla@arm.com>
> > +M:     Ulf Hansson <ulf.hansson@linaro.org>
> >  L:     linux-pm@vger.kernel.org
> >  L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscri=
bers)
> >  S:     Supported
> > +T:     git git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm=
.git
> >  F:     drivers/cpuidle/cpuidle-psci.c
> >
> >  CPUIDLE DRIVER - ARM PSCI PM DOMAIN
> > --
> > 2.43.0
> >

