Return-Path: <linux-pm+bounces-18939-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7189EB9B1
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 19:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72E53280994
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 18:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CE21A01B0;
	Tue, 10 Dec 2024 18:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9mBDgZx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9830323ED41;
	Tue, 10 Dec 2024 18:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733856937; cv=none; b=mXi5H6Z9WrnQcPiuPBRqQu/SECHzg68BEdZy3GekpVAbzzXJgQdkTUBKv6VYOPIKyCWo0PkzYbrsMMwfMnqaVJ7OyAFXtD0bg8LnPpNDuhvg1s/VbtPEVyhRos7tvXSCTIdQuWsR2H8g3Uclb6YidjcVVtxqBVusxfJ84GFZntU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733856937; c=relaxed/simple;
	bh=Kd+e021LK4yd0D9+Rum9XT5qFFk22kB4JCc5aJmJpZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dRKP+iwliDcXvCMurLJoyu5jZtJYWywjwMJjLcVUosV4HRauHgnwInNnl7R30GPkyY1ayYt7Pd86L0Lmy0Lu/AWNgy3ba/bFErC2cc1fVOltpEYbA7ItisQusYdLTGbw4KnaLMA+M/UnoXfDDPM2dZ/Q40TT9Hzoyl0S4P0ScfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9mBDgZx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE04C4CEE1;
	Tue, 10 Dec 2024 18:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733856937;
	bh=Kd+e021LK4yd0D9+Rum9XT5qFFk22kB4JCc5aJmJpZ8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=e9mBDgZxxZmlo0u7VGb4Uqmm0ekMvx+2Bzm/fgHCbs5kl2C4GXjNae81aGXXtu8XF
	 VUt5WFgMoBsLfo4Dn78rnkIhioc1f/wEzpZ0RDXf6v58jbzDzpuTxM8lD0fX6XmzvL
	 J7f53STZ+c/O+L4naLu5ZymSB0V2EFaPZIhbX3k6O76nkvI4XChU5rY54mpI+wMPZU
	 tVsIaDdG4nocZR6JTrqnuPXNauDIgBbTP8FlHFtNub1ar4kVAieKXv/YMTnJWUygqZ
	 REqnBcDeIc1b4TK3ar1B31v17eH1lkFwWuskutZJYneQO2TEFaJGZ0vTHxARM3DHX4
	 JhHqk+TYaFOOw==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5f2abc195f3so1223811eaf.0;
        Tue, 10 Dec 2024 10:55:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVFItgzLPK2wkgGQ5RNBLtK2xJjYhoPwDLECZ6jGTdbMs0JWHSE2FU8BYA8wzsqfuyLMR7pFTtlxw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7XiQ+WH7q18cDNYpFzYqpRjRbq6WYzZUWV23jx33yogz/eurv
	enFkQ4mbr5QtOea3M+hgHKDKrlQ/XPJ2R5PD7s6vP1j5ivKoTkxMuWJqIymUO8pSn7F/EsCM3cm
	eCZlF187aAU3tixpIVZA8ISW2Nsc=
X-Google-Smtp-Source: AGHT+IH45EhjFO2CmSd7uTuJxJOCv/ldjGFHF3AlvubEv/20uUyVcuIHcdujmzmfY6mTf3h4zsAy8ERc301Pns7vDfg=
X-Received: by 2002:a05:6820:1896:b0:5f2:af90:e90 with SMTP id
 006d021491bc7-5f2da0c2491mr37933eaf.3.1733856936548; Tue, 10 Dec 2024
 10:55:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241129045750.456251-1-rdunlap@infradead.org>
In-Reply-To: <20241129045750.456251-1-rdunlap@infradead.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 10 Dec 2024 19:55:25 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gnsFM7YcBqO8Mbkr72ipQxT8nJ=i94z74Q0XM1csnTYw@mail.gmail.com>
Message-ID: <CAJZ5v0gnsFM7YcBqO8Mbkr72ipQxT8nJ=i94z74Q0XM1csnTYw@mail.gmail.com>
Subject: Re: [PATCH] kernel.h: add comments for system_states
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2024 at 5:57=E2=80=AFAM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> Provide some basic comments about the system_states and what they imply.
> Also convert the comments to kernel-doc format.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Len Brown <len.brown@intel.com>
> Cc: linux-pm@vger.kernel.org
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>

Fine by me.

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  include/linux/kernel.h |   14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> --- linux-next-20241125.orig/include/linux/kernel.h
> +++ linux-next-20241125/include/linux/kernel.h
> @@ -176,9 +176,19 @@ extern int root_mountflags;
>
>  extern bool early_boot_irqs_disabled;
>
> -/*
> - * Values used for system_state. Ordering of the states must not be chan=
ged
> +/**
> + * enum system_states - Values used for system_state.
> + * Ordering of the states must not be changed
>   * as code checks for <, <=3D, >, >=3D STATE.
> + *
> + * @SYSTEM_BOOTING:    %0, no init needed
> + * @SYSTEM_SCHEDULING: system is ready for scheduling; OK to use RCU
> + * @SYSTEM_FREEING_INITMEM: system is freeing all of initmem; almost run=
ning
> + * @SYSTEM_RUNNING:    system is up and running
> + * @SYSTEM_HALT:       system entered clean system halt state
> + * @SYSTEM_POWER_OFF:  system entered shutdown/clean power off state
> + * @SYSTEM_RESTART:    system entered emergency power off or normal rest=
art
> + * @SYSTEM_SUSPEND:    system entered suspend or hibernate state
>   */
>  extern enum system_states {
>         SYSTEM_BOOTING,
>

