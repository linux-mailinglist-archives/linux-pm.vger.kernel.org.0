Return-Path: <linux-pm+bounces-22693-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D684EA40067
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 21:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FD3B4237F3
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 20:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185EC20DD63;
	Fri, 21 Feb 2025 20:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tc58lxRe"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E244E1D5173;
	Fri, 21 Feb 2025 20:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740168492; cv=none; b=VDw/tFEQiANwkGdra//EB/bH/b/ULp6GHFvZ/016JZvlkjjbMtFGuKGU7vToGfol66c7tIFMGEUUOxUPOo6xQuNimayHhtrClp+3iujPL0G4uFcLSZC8p52WoZZCmnPErinhjXERdRCrPbguy6RaeNzSfkoFktW9o6a8hofbtQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740168492; c=relaxed/simple;
	bh=Gm+4xFa7KkdiFVlFBYWqO24vT7+jbVfw8VcidVSE2n4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tNEOiYydpMapb2HZ9oANf3jKwUpEMzvYpGSAK9g6uKQ1VT+cyhUGZxhiUpQ7FycODks/MbF2jrnf9KlPqwI1BWBCKbGSq/f9BKpWmLNa9eCQm68BQ+8+yFzFy33ny34Zcvm1q60L70xA9Mhfp9oW4jY2TR89sD8n2UYRO+l0hM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tc58lxRe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 608A6C4CEE7;
	Fri, 21 Feb 2025 20:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740168491;
	bh=Gm+4xFa7KkdiFVlFBYWqO24vT7+jbVfw8VcidVSE2n4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tc58lxRed8uamUIfbTSBMBHL98ZaBXJzhN1ADvixXSJ9j6o0NXT4WXyiLQy4eQmlz
	 d7xbJmYWR6aMXN4be8aUZ1LqizSxqGYuEG60HhrR/g+slnImGvRBod1Sca5GK+UD4e
	 lH6K9G3m6XaROeUnJwTrgtTSzbC760Fr9OGOzzUw3lmun1Y0e6J/iT7tCLC8oYfalz
	 XquVChLorBqyObMHgOj8tKkTNTUWv/aLT7g1A3QbWLxSB4Cpn7s2lES/2k8qxlOjwU
	 4IRIuAnP2Z8Fa8gVtmhKJR8dxmUrVC/ZgzWNxlElVATX35sFzPSCI8gw+KdDc87F4L
	 2xJX4xCV+8mGA==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5fcf21d7235so886336eaf.0;
        Fri, 21 Feb 2025 12:08:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX5dml9RHqWQBZHxfz8khlXbMb8MI/ejp3fNrhAjTom6mNMhwgGVv4nc0PIpNpLToUXBj2yy5G/QlA=@vger.kernel.org, AJvYcCXVAaAlwLTREkqFDEzlahoC89+pIfevNNC4nbHzZzdAEHrsgMmCnfjlxN8/AhixwLmoe4C6jLzrGFZpDPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwE8r+O4QA6w3Lih32NCVsy5DyYQdPk7kQt3nowz5ghY/4rkfm
	pH2VscADBWyHXhbhiCJbuzxUtR5qohq3HTWLScf7Cw5E9VPaRwr8r8MMbHiKSxuvVIyhtMzKsci
	Z/Sh0VtNRUKSFX0d0jsLL27k2tsY=
X-Google-Smtp-Source: AGHT+IEuERQjCgClekDrKOshdDxtp7HRtOnIM+funBYPZRyRmxWui4PTyEGZ8/fnhSnxgFN6UXyB56d99tTLkkrmA68=
X-Received: by 2002:a05:6820:1b86:b0:5fd:7c4:e9ec with SMTP id
 006d021491bc7-5fd1a9af44fmr2594117eaf.6.1740168490633; Fri, 21 Feb 2025
 12:08:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0h38FRwpYeTgw0VKqKVT=RDSrLnSt+31E6i=XOAoCor9w@mail.gmail.com>
 <20250221123536.2946377-1-lizhi.xu@windriver.com>
In-Reply-To: <20250221123536.2946377-1-lizhi.xu@windriver.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 21 Feb 2025 21:07:59 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hu=Gi82zS27MwKj-uhEciuD6JN8cZLd+75J3VKY796wg@mail.gmail.com>
X-Gm-Features: AWEUYZnLLOMc3l8VcpaVAp8trSHpB59NIwlFt5SrgWeznsAsbItqxygllooENFc
Message-ID: <CAJZ5v0hu=Gi82zS27MwKj-uhEciuD6JN8cZLd+75J3VKY796wg@mail.gmail.com>
Subject: Re: [PATCH V2] module: replace the mutex lock acquisition method
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: rafael@kernel.org, len.brown@intel.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, pavel@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 1:35=E2=80=AFPM Lizhi Xu <lizhi.xu@windriver.com> w=
rote:
>
> syzbot reported a deadlock in lock_system_sleep. [1]
>
> The write operation to "/sys/module/hibernate/parameters/compressor"
> conflicts with the registration of ieee80211 device, resulting in a deadl=
ock
> in the lock param_lock.
>
> Since the conflict cannot be avoided, the way to obtain param_lock is cha=
nged
> to trylock to avoid deadlock.

An alternative way to avoid the deadlock would be to replace
lock_system_sleep() in hibernate_compressor_param_set() with
mutex_trylock(&system_transition_mutex) (and analogously for the
unlock operation).  Why have you not done that?

It is arguably better to fail a write to the module param with -EBUSY
than to fail ieee80211_register_hw() IMV.

