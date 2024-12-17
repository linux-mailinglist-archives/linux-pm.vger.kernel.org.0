Return-Path: <linux-pm+bounces-19399-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E656E9F5807
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 21:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BF2D7A5E38
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 20:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53EE1FA143;
	Tue, 17 Dec 2024 20:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lW0MCHjP"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4921F9F79;
	Tue, 17 Dec 2024 20:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734468356; cv=none; b=VHh2Or3fKeR2KHbukZN3OBcHDFy9IB6pO/exDyF46zUsJpCiSH+2lZBZikZsGXiu8sswKhuSeJny2HwuRvmlBcgSw+cT/5nTsTdhzdz4XPuz3sTJTxoYkG/ycKvtmCujlKAZmfFl6pLh3+kJm6PKuc5RjPoGI2v8w+p9gvWQAhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734468356; c=relaxed/simple;
	bh=AfNs+aRaImOqqFmUUmohbMCBZ0wyMR7R2ImxXHGvlLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eapzBSSq8WpQv/V/XHkvG0nL2T2ohx+QZq9df7ZDKVWnjIcn32UeA1kQLciy9hUnMwaO+l+lp5ZnG+QEDOxFmtCNc8dOcU3FG0eczpnG99Cq/Uu1P2ht9V7rZcZo7oshN8Wr21R+5TmEyrefIYHwsM/qz+h/sHACSs0vkWFdAWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lW0MCHjP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B45C4AF09;
	Tue, 17 Dec 2024 20:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734468356;
	bh=AfNs+aRaImOqqFmUUmohbMCBZ0wyMR7R2ImxXHGvlLE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lW0MCHjPaX8cg4kiValaSMnigYb6c998+tiRy+NY+3bP511KWoz6Mag7TsArQhkFo
	 XVV+6YmmOgWF6DkOybDAn6jmNT8o1cd4uvg+M/SeDnQUT6CXCQ4szhG2FMbChQ2syo
	 SXllpNb2wKd4SIBI66P4GxZDINE/EV0Y9JjEvwtnnLpXwkCMmham7qIwY1I/RPpXjA
	 twA+8gAmM3m2ZHEe+miz/11e6EZyJpPaj7eHhSPDi9950AfWVXj9wvdlTwBhM0lpyC
	 GFGJ0pAl+TMLp8Oiq3/fgyJUTkUxWnl3soyO6fhGW+XBfekRmns7bRcbD09NDfqLgB
	 nNpQpZxKlyy/Q==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3eb7e725aa0so2678074b6e.0;
        Tue, 17 Dec 2024 12:45:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU+epsR5hrINboheLbw3uDHvhzNFhH40YtveW0sfyflS84W/dF6DLObFQGqM9eaAY2IqwOG7M8mfuVmvF4=@vger.kernel.org, AJvYcCUjJcLrnxfqSEjQ7XuQ9BenPn35ru5rVTk1n5YQFtR1H9HmM9u9W+9H/4FCznnu/tXi1K7ngXJ1ygQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzpv4pIfTr4Tqsrqy97C1Bjtq0QlY7eLm4uaopr0+T/j32dkSK
	3s0GPSiQhujkJ/+9sj31tnKizfPEJArxEL3JFCKLghokIf1jzTmYUvziMhSNYPfs/Jh0P9+Zt0P
	bxsk6aqLPdCOR1EV0OiZKEtcZ5Ro=
X-Google-Smtp-Source: AGHT+IFLSMWjQPcteOW/I2xvn220NQPZSr1gUKmQJePYhYNKLftQ8O7ii7jOEPxDQ65slkY5nL6eUiCd+0E+NPTA2Pk=
X-Received: by 2002:a05:6808:2110:b0:3e6:19a9:4718 with SMTP id
 5614622812f47-3eccc0b837dmr325889b6e.40.1734468355555; Tue, 17 Dec 2024
 12:45:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241129182232.14987-1-patryk.wlazlyn@linux.intel.com>
 <20241129182232.14987-2-patryk.wlazlyn@linux.intel.com> <CAJZ5v0jhK51+pkf=Amr=qXWzK3e1xC_tdt0iqQXxVfeE4pcFJQ@mail.gmail.com>
 <2320a952-334d-4d52-a15a-669a5670df7d@linux.intel.com>
In-Reply-To: <2320a952-334d-4d52-a15a-669a5670df7d@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 17 Dec 2024 21:45:44 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i=_wNubB8_yQtBZYLYJ+f==c9OVMpxbtYHfFCJR+nsng@mail.gmail.com>
Message-ID: <CAJZ5v0i=_wNubB8_yQtBZYLYJ+f==c9OVMpxbtYHfFCJR+nsng@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] x86/smp: Allow calling mwait_play_dead with an
 arbitrary hint
To: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, peterz@infradead.org, 
	dave.hansen@linux.intel.com, gautham.shenoy@amd.com, tglx@linutronix.de, 
	len.brown@intel.com, artem.bityutskiy@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 9:09=E2=80=AFPM Patryk Wlazlyn
<patryk.wlazlyn@linux.intel.com> wrote:
>
> > And honestly I'm wondering why adding a parameter to mwait_play_dead()
> > is better than introducing mwait_play_dead_with_hint(), in analogy
> > with the existing mwait_idle_with_hints()?
> >
> > The latter option would allow you to avoid introducing a function that
> > is deleted in the same patch series (in patch 4).
>
> We need to be able to call part of the old mwait_play_dead() code,
> but without the hint calculation.
>
> mwait_idle_with_hints() doesn't have the "kexec hack" logic.

Well, "in analogy" doesn't mean to use mwait_idle_with_hints() instead
of the new function.

Just the name of the new function could be similar to
mwait_idle_with_hints() (which is the name of an existing function),
that is mwait_play_dead_with_hint().

> We also need to leave the old code working and on top of that introduce
> the acpi_idle and intel_idle patches that use the new API.

Sure.  If the name of the new function is mwait_play_dead_with_hint(),
that will still work.

