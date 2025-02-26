Return-Path: <linux-pm+bounces-23017-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3046A4678D
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 18:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4CE17A071A
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 17:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9065F224894;
	Wed, 26 Feb 2025 17:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqpsOcO5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A08223322;
	Wed, 26 Feb 2025 17:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740589924; cv=none; b=LLAYeot0F827h1Dad2wOhqTCiaKQTBbYYMija95P1UW8YtrwNuMPQl8gCCFMEJfGFNwZdXPQsm6+bLOUsHY3Rb7YBvE6F8pqIS0TiDfCDC/rUvo7vACdVRcvy71u5S15sCQdK4Ni9Q8Q18J5iHaBWi8Kus4EsaDIbkumqwZioeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740589924; c=relaxed/simple;
	bh=8d7pXk0HpTU5re5dKZEsqJdCrpujp2MZ3eVVBvSdbjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F9oRffYyvWL7Nka7F8YEJEwx3LJPBblYzHj3ZoMjNFf441wGQmlhGuQkJMtQ9lU5e9QzXqTm0r+ZzSkXKUaDH+88J2wTwKBBQOHQpjw9WtZHSOTAfQgCDY1QFGO+xEp0Gvu6oVSKj14CWZXx3ZT6+3WFgRyu3ZJVADXqMeIvy4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqpsOcO5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB6DBC4CED6;
	Wed, 26 Feb 2025 17:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740589924;
	bh=8d7pXk0HpTU5re5dKZEsqJdCrpujp2MZ3eVVBvSdbjI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eqpsOcO5oqpd8lH/7QEMfPwcdcJxYGS6cu657fLeNsUdHVzOxhHyfPqpUDlI7gbUf
	 0y/j4ETvmrgw18OwF7LnEDBJAbmDedh7O3r/7MOIYEdAZKUNbLiPkC0GeR1+UqRIiy
	 pD4XyfKlY202it9sMWHs8X4cDYo1ezMKj02I6Vztro/59VPyF9OmIlJOCbSiP/BgWS
	 mpwhaCWSP+pmxVi0Wur2haI2UpTS9RAxWnl2HvNICvr5vNesi8Vt8W0hR6Q+URalQr
	 nNvfuaERZG7YT1fykhunx13FXfvh0bWjPRFrTOcuzS2RfqETxhBlOrwxCXNmUO5uAu
	 7rwWbLtVKjzCQ==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2bcc0c6c149so71477fac.1;
        Wed, 26 Feb 2025 09:12:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWciMELQq4aZeesZbR9YYXvJnkMpVLgXV7SEt/Fwnubd/eDVhxzOk8LsBoloRiExn0tTOTN0e8zbHg=@vger.kernel.org, AJvYcCXp1nxK6/mJ8x2FtPAy+sMBBm1aoUrbqJ4rlb4ySWbnjHVG10BOLAh9/MDw1JQjMXcmTk2MOgY3nN4iuYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvKmEoQ9xEezucNgaoufFwkeNfD14IxCzDySNESL1Oi00EJ02S
	lZMnPjkP1oXFWLTK7nMv5BYxrJs1CHdNoEOdW5NSMt00tklWGLBWw3LU0OVhGggNb0Xmet20+a3
	Yjo4TpHwb09WVd2jh6omomOUkVvk=
X-Google-Smtp-Source: AGHT+IGOQtG4imaWtjVB36oHGBnn0kzMUBu9ZK/Gy0K7WNz0tTlaMPCL2RgMqVmIroVqs3HfGgr1FS+6QCLMZ/W+QWA=
X-Received: by 2002:a05:6871:e08b:b0:2b8:e6f2:ba7e with SMTP id
 586e51a60fabf-2c1303173fdmr2424681fac.12.1740589923331; Wed, 26 Feb 2025
 09:12:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CF154B5C3C8E7E64+20250224074357.673094-1-wangyuli@uniontech.com>
In-Reply-To: <CF154B5C3C8E7E64+20250224074357.673094-1-wangyuli@uniontech.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 26 Feb 2025 18:11:51 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iigAB97mGBe6Uvr0v0spjqDKan-0O9XGObt5b4ZBvM7A@mail.gmail.com>
X-Gm-Features: AQ5f1JrDsoEUFo51jxqs59N5d6ysIgoT6Y8CZSdjEJ4moStcIKIu27NHo6HnpkQ
Message-ID: <CAJZ5v0iigAB97mGBe6Uvr0v0spjqDKan-0O9XGObt5b4ZBvM7A@mail.gmail.com>
Subject: Re: [RFC PATCH] x86 / hibernate: Eliminate the redundant
 smp_ops.play_dead assignment
To: WangYuli <wangyuli@uniontech.com>
Cc: rafael@kernel.org, pavel@kernel.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, zhanjun@uniontech.com, 
	niecheng1@uniontech.com, chenlinxuan@uniontech.com, 
	Huacai Chen <chenhuacai@loongson.cn>, Wentao Guan <guanwentao@uniontech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 8:45=E2=80=AFAM WangYuli <wangyuli@uniontech.com> w=
rote:
>
> It's unnecessary to re-initialize smp_ops.play_dead to play_dead as
> it naturally goes back to play_dead in the freshly booted kernel upon
> device resume.

Is it really?

And what if freeze_secondary_cpus() returns an error, for one example?

> Suggested-by: Huacai Chen <chenhuacai@loongson.cn>
> Co-developed-by: Wentao Guan <guanwentao@uniontech.com>
> Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
> Signed-off-by: WangYuli <wangyuli@uniontech.com>
> ---
>  arch/x86/power/cpu.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
> index 63230ff8cf4f..023cf9421467 100644
> --- a/arch/x86/power/cpu.c
> +++ b/arch/x86/power/cpu.c
> @@ -297,9 +297,6 @@ static void __noreturn resume_play_dead(void)
>
>  int hibernate_resume_nonboot_cpu_disable(void)
>  {
> -       void (*play_dead)(void) =3D smp_ops.play_dead;
> -       int ret;
> -
>         /*
>          * Ensure that MONITOR/MWAIT will not be used in the "play dead" =
loop
>          * during hibernate image restoration, because it is likely that =
the
> @@ -316,13 +313,11 @@ int hibernate_resume_nonboot_cpu_disable(void)
>          * resume) sleep afterwards, and the resumed kernel will decide i=
tself
>          * what to do with them.
>          */
> -       ret =3D cpuhp_smt_enable();
> +       int ret =3D cpuhp_smt_enable();
>         if (ret)
>                 return ret;
>         smp_ops.play_dead =3D resume_play_dead;
> -       ret =3D freeze_secondary_cpus(0);
> -       smp_ops.play_dead =3D play_dead;
> -       return ret;
> +       return freeze_secondary_cpus(0);
>  }
>  #endif
>
> --
> 2.47.2
>

