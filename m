Return-Path: <linux-pm+bounces-27226-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE0DAB975C
	for <lists+linux-pm@lfdr.de>; Fri, 16 May 2025 10:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 406CA502F10
	for <lists+linux-pm@lfdr.de>; Fri, 16 May 2025 08:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D886522F767;
	Fri, 16 May 2025 08:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxrb4wbX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD33B22F755;
	Fri, 16 May 2025 08:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747383407; cv=none; b=Bx9ALWG+XdI/rf87S28j7DOR8bJihEsqR9xg9FF/CbGHliDEyj0hamFd8MAYc35/YUa8Tb5s5dihfdSBQ2T91SXXkPxZbkS8dGcHy2pRJ6ck+iK1N0suM2KXdr/ASqgJgI0DjpbUqqIwrIK43/9h6sSKleOgJP4vgRirVlTVzFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747383407; c=relaxed/simple;
	bh=YuSWZZOXW5nwd8/g09UEEj9ynyi/7FJ4AUQZG0YjXnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UlyQTbdZfVVas4KfCk6XTwxwpBxAifBZTLuE+gZ4XTSofXHuAjsP0KjwsnNKkv0hJKPh0z8y0fNA99UCN35PhVOeIvS5GVntkfQa2RwvA4bKi94gTAmwo41xIXUk0WhWxOs8TLA6BbYJAyMFm5aBe4TFC54rh5R3TLahVOeLd4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxrb4wbX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C4EC4CEED;
	Fri, 16 May 2025 08:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747383407;
	bh=YuSWZZOXW5nwd8/g09UEEj9ynyi/7FJ4AUQZG0YjXnI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jxrb4wbXeLX097lBe0l2yOJTNQo2ooPu5/TSmGK7tmIuGhqM8fHy3ds8jbqolhTTr
	 y/86K1hu8J2+a2l45RfrlOaXYE4r1hRKqcXGwI8nqeBKZ5ZKGhlA8a73OHtLzrlGKb
	 2mma5fNJGL734qDO6vSCoVTzjT1eIHDLx843c94dGgyvJC/B2Ovn0GkgQfdUki/Nmt
	 7Pjbvh2OqHcmzkk4TRgvB/33dwJnWhUWRF3U2i1XGM/TVE33LUbR5IpbMsjlt5Blaf
	 sTOo/bpQMki0CIkLkNTrCp3R7uYYpF2u/+5IndcvXZjwWow0Jxbr+bFyUTDPaE5zT7
	 5Bnrn0z3lSxlw==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-606477d77easo1387935eaf.1;
        Fri, 16 May 2025 01:16:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUqIiBqBf9XdJUA8j6TMWHopgHdse4tNkx+rIPdaKse0w+zx2981NWhSqSqA6L/mVfgzfkpcQz8+qI=@vger.kernel.org, AJvYcCXUM2Np5ZnkI+onkJxBPuQifPWb+Wp2f2biF+KS6nLHMUr8FDPYioz/5yqlXnYpY69V99zgH1mkSmhRjNY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0qjL8md8sDkOtajbyzEKkZYwWUHCBaCVSQHIOES2rVhW/dyJi
	au3CEHfnIUMCeLAvMFiNGmxyBFkIvHwqnOnnsdUV0OWpBaUgA08Q/rBygUa0W/LXlM35iFwCU5n
	iG57vSVn+CDRGUB4BmgzEmKIAxUBKQJY=
X-Google-Smtp-Source: AGHT+IGU+OiYk/HmnmOf9Q8Pyet01k8RnxHx/UB263Imk66HeNojsQ+LIV2yskkJsnuPr7z7SR5fhsvdDicaifDwhBw=
X-Received: by 2002:a05:6820:1792:b0:606:3abb:1934 with SMTP id
 006d021491bc7-609f3876c16mr1325324eaf.2.1747383406351; Fri, 16 May 2025
 01:16:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250516034643.22355-1-tuhaowen@uniontech.com>
In-Reply-To: <20250516034643.22355-1-tuhaowen@uniontech.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 16 May 2025 10:16:34 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gOa8H-yABSepfy-WyOKJqRjCMhYPdbAHox3qUVmOXS6w@mail.gmail.com>
X-Gm-Features: AX0GCFvkwebfrY7vYOfseAbGgrzcABf6FBWoSGyrSz7apM0MdLxFDsazrF_I740
Message-ID: <CAJZ5v0gOa8H-yABSepfy-WyOKJqRjCMhYPdbAHox3qUVmOXS6w@mail.gmail.com>
Subject: Re: [PATCH] PM/console: Fix the black screen issue
To: tuhaowen <tuhaowen@uniontech.com>
Cc: pavel@kernel.org, len.brown@intel.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, huangbibo@uniontech.com, wangyuli@uniontech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 5:47=E2=80=AFAM tuhaowen <tuhaowen@uniontech.com> w=
rote:
>
> When the computer enters sleep status without a monitor
> connected, the system switches the console to the virtual
> terminal tty63(SUSPEND_CONSOLE).
>
> If a monitor is subsequently connected before waking up,
> the system skips the required VT restoration process
> during wake-up, leaving the console on tty63 instead of
> switching back to tty1.

Please add some information here on how exactly the issue is being
fixed.  Reverse-engineering code changes is hard.

> Signed-off-by: tuhaowen <tuhaowen@uniontech.com>
> ---
>  kernel/power/console.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/power/console.c b/kernel/power/console.c
> index fcdf0e14a47d..832e04bf5439 100644
> --- a/kernel/power/console.c
> +++ b/kernel/power/console.c
> @@ -16,6 +16,7 @@
>  #define SUSPEND_CONSOLE        (MAX_NR_CONSOLES-1)
>
>  static int orig_fgconsole, orig_kmsg;
> +static int vt_switch_done;
>
>  static DEFINE_MUTEX(vt_switch_mutex);
>
> @@ -136,15 +137,19 @@ void pm_prepare_console(void)
>         if (orig_fgconsole < 0)
>                 return;
>
> +       vt_switch_done =3D 1;
> +
>         orig_kmsg =3D vt_kmsg_redirect(SUSPEND_CONSOLE);
>         return;
>  }
>
>  void pm_restore_console(void)
>  {
> -       if (!pm_vt_switch())
> +       if (!pm_vt_switch() && !vt_switch_done)
>                 return;
>
> +       vt_switch_done =3D 0;
> +
>         if (orig_fgconsole >=3D 0) {
>                 vt_move_to_console(orig_fgconsole, 0);
>                 vt_kmsg_redirect(orig_kmsg);
> --

