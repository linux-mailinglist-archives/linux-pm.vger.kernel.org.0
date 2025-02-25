Return-Path: <linux-pm+bounces-22881-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5CDA43DF7
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 12:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECF0D17D0B3
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 11:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580CA267B81;
	Tue, 25 Feb 2025 11:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IpGofq2A"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3020C267B18;
	Tue, 25 Feb 2025 11:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740483712; cv=none; b=Nav2+kKz4oDR8Rprj2NdqknFraPQt2EenkCnw8pPo/4TsfTLOrGdiXUOU3n/8i/cfP8se/urt2vYOGnM8NXkPnN+5xobVbZ8SrioMs/cIc9x2Tdp18YLNw58lGRMhEO7T1kn+YSEo53IWMOCuJzYik1R6csvYttLKWb4/n7fhy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740483712; c=relaxed/simple;
	bh=h+T2raKsJQ4RIjg6WeCVYCV+c6BCAPildkAWxCUIX/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cP6z0ugy3KekUlfq4rvJwMIZfPndVPc392t95Bmax7Dpc1VM+Q4wCTD0QQp97SQ6QkW59U4JJRJiipFlsKxQa+xunqLed15UAChjw+VpRENGD9x2BD17sOu/acQMWAJAGz+D6I3X3ud8tB82zhAqCz/qXeBG2Qw1LfMuAD8gZAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IpGofq2A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF78C4CEE8;
	Tue, 25 Feb 2025 11:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740483711;
	bh=h+T2raKsJQ4RIjg6WeCVYCV+c6BCAPildkAWxCUIX/w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IpGofq2AcmbR4vt31xCxO64zinsSFkZJJ5nItKx3Fhmd6tieLHJOJo/x0GC6o8UGu
	 RlAYCEc7aH/Lu6ACM2g+MsmNEFKgkliPGyY/o9nt+PinIP8GLtXrlq8pyfHSSn3eYA
	 2MWw7xQrPyXNPjcPmtNy2aD0OBQIfThDEze8tfeHdOX5sBgg3ihlW7E2hA/y263Ab6
	 fSPmRg6lKJc374JGY9CxoDLFdKHxanRBeoVinvZYx+9iCtU2MS/D6oLKCLB1c/ulNl
	 wDZoqsusxBCqxRi4Xj0hXOtj13e6SlncTreuJ6IdHoKLRe9OmLyk6gDd6PoGrIdN2i
	 kSJLDED4XtNmA==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2a9ef75a20dso322559fac.2;
        Tue, 25 Feb 2025 03:41:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXC/fbdzrMxUSSN2GP1yNIj0F06r7i8UJz6lvAggbM7H4i8rK6Uhu3dV0lMMc9rn+yrByWT/gk+Fw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+7QH1WQArnVfwHKcEdW2yIhalvG0oZDnIvShzUF83QjEcElfi
	zzW95cqJrlhEiwwvV7yR5G96JpJhZl1LnNEzY72OyKLejEUry0YnbDC2nFoViHFv4Gu+OByzCQ5
	BZFA5BOUJeLTw5hzegPXLWjhKGZg=
X-Google-Smtp-Source: AGHT+IESOKAn6/6SxHhIFWP1AFVhPJkMLAgNGXvllYRSJo64sMAw0+x+uc3N5W3CH98SANCjk/yMzlu76qtnIH5ufa0=
X-Received: by 2002:a05:6871:a0c7:b0:2b8:3c87:f36 with SMTP id
 586e51a60fabf-2c10f25d68dmr1773131fac.13.1740483711039; Tue, 25 Feb 2025
 03:41:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12621866.O9o76ZdvQC@rjwysocki.net>
In-Reply-To: <12621866.O9o76ZdvQC@rjwysocki.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 25 Feb 2025 12:41:39 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0goH0unRRuQNCKC8WYRndsSenJaVJOYU64COYHocVE7ig@mail.gmail.com>
X-Gm-Features: AWEUYZk3UVbVtstv3dpzo5EDIv7DprcgjKQT6sFuqRWhkPgtXZR1G4XYFGJhHPk
Message-ID: <CAJZ5v0goH0unRRuQNCKC8WYRndsSenJaVJOYU64COYHocVE7ig@mail.gmail.com>
Subject: Re: [PATCH v2] cpuidle: intel_idle: Update MAINTAINERS
To: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 9:11=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysocki.ne=
t> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Update the intel_idle record in MAINTAINERS to reflect the current
> state of affairs.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> v1 -> v2:
>    * Add an alternative address for Artem and change his role to M.
>    * Change the development git tree link.

I am assuming no objections.

> ---
>  MAINTAINERS |    8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11669,12 +11669,14 @@
>  F:     drivers/crypto/intel/iaa/*
>
>  INTEL IDLE DRIVER
> -M:     Jacob Pan <jacob.jun.pan@linux.intel.com>
> -M:     Len Brown <lenb@kernel.org>
> +M:     Rafael J. Wysocki <rafael@kernel.org>
> +M:     Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> +M:     Artem Bityutskiy <dedekind1@gmail.com>
> +R:     Len Brown <lenb@kernel.org>
>  L:     linux-pm@vger.kernel.org
>  S:     Supported
>  B:     https://bugzilla.kernel.org
> -T:     git git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git
> +T:     git git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
>  F:     drivers/idle/intel_idle.c
>
>  INTEL IDXD DRIVER
>
>
>
>

