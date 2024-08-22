Return-Path: <linux-pm+bounces-12763-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 053B395BE7F
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 20:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2B131F242D9
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 18:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28DC1CFEBC;
	Thu, 22 Aug 2024 18:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+T48JN3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97D313A3E6;
	Thu, 22 Aug 2024 18:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724352771; cv=none; b=gdft6D5oB2TFpbPpT4S7KyPKYaF+LunaeoZzPyU/DVuXfXL8Tv/to/y9HUSnWLNTaRNO90+oFxfF0SrDiIvH6rhV7M7Fj+DZUWJNHYS4AYxwMNpQoRqOpBIf9fTITWE1J+rF/B52TN5t2IQC7w6JAHontkuat8qeNJ3BjsBxU50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724352771; c=relaxed/simple;
	bh=OKwFHMJIvAhoOLrSK9sioiiEHkoLe95swoRfv3Th8c4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bPH0FPtV12dxQ86zpzC34rpx4jSGD4DwRTxS3A8JgrajrW1B6baZo72Li4ZouOWM+FQkGKoHJbNi5tTkokPA4kpldkPxMGtgzeupmD35K05Z2I7nFyF26CuRzanl6bMBcTM2S9DcrV1Qpms00XG+PBxcWkcUGzXbwktMSr+5MbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+T48JN3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DC6CC4AF11;
	Thu, 22 Aug 2024 18:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724352771;
	bh=OKwFHMJIvAhoOLrSK9sioiiEHkoLe95swoRfv3Th8c4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=B+T48JN3k0zgyAntFwr4zISPAbYisubr1XSuHnqKuLa4/YYkDG+/GO1Yo4/+b2or5
	 6acC83oNMP1P4uJpQIMJPPP2K1/JWmMaSpeh3760+cS/8sb2L9UZ5p1PR52kGiAB3D
	 q9qFN5wWswn198rFjGl7NA+iFl2L+kMKdcQK8/GgTxH7JBqUoUTCgqsgE7VQXo8/Jm
	 tYqPzOJ7pfbbrwmsB8Zre2YXvar30WJ04h4oTMN/OUzjs6Lw0j6rnJmVDXaZRACAOj
	 2v64nzma8nYgRGzNZc6FcG388rSxvvUfySLNRIVkWU21Fwb3Ps0pgdsbtZ1W14DNWM
	 xrfzoefXBVoOw==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-26808290f43so1285414fac.0;
        Thu, 22 Aug 2024 11:52:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWyWjhbdITN399zN60S4RYhDPI2NXtwkw4vIZzwgKmZGaTN09DIr/QbBtomqh41Hrh475rrms93tO3DXHc=@vger.kernel.org, AJvYcCXo6NHq04i+SPmKYU9HYDoXkOSCKVi30gA9kZ0Df9tMVYlPaTI1fMwAHBZLr3L/jPCBs3eHZ5UgCTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAgTf6PxmWLvrTZQtKTbLYhlZa0waHgi5tB4GVhxiooCwtCDuh
	Y4Yr5/6aIXPIJ+fWiQC3y+g2b6RXKq4M2H6QJWRPYbzjAxEUro/TnCUZx8M+e5P+zA+Jli34NGD
	0FRvsNj5a0o0WiNw95n3uCBNmIQw=
X-Google-Smtp-Source: AGHT+IEeEUP8MTqGM6SLXJasiJDkYE7buzp/JeX3XzY5Ua6A45XPJGIbMykjhSyWg9J6kJf+0dUkBwISu4HfHZhBHl4=
X-Received: by 2002:a05:6870:a44b:b0:26c:5763:e6ab with SMTP id
 586e51a60fabf-273c8e04af7mr1629304fac.14.1724352770626; Thu, 22 Aug 2024
 11:52:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822033913.1240040-1-11162571@vivo.com>
In-Reply-To: <20240822033913.1240040-1-11162571@vivo.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 22 Aug 2024 20:52:39 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gfEfWX0jQHcvSuWagtd1rhyvizU+4PErY81yVRMG-bZw@mail.gmail.com>
Message-ID: <CAJZ5v0gfEfWX0jQHcvSuWagtd1rhyvizU+4PErY81yVRMG-bZw@mail.gmail.com>
Subject: Re: [PATCH v1] drivers:testing:Handle possible memory leaks
To: Yang Ruibin <11162571@vivo.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 5:39=E2=80=AFAM Yang Ruibin <11162571@vivo.com> wro=
te:
>
> When copy_from_user() fails, -EFAULT is returned without
> releasing the memory previously allocated by kmalloc().
>
> Signed-off-by: Yang Ruibin <11162571@vivo.com>
> ---
>  drivers/thermal/testing/command.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/testing/command.c b/drivers/thermal/testing/=
command.c
> index 7868caee3..b95bcb94e 100644
> --- a/drivers/thermal/testing/command.c
> +++ b/drivers/thermal/testing/command.c
> @@ -150,9 +150,10 @@ static ssize_t tt_command_process(struct dentry *den=
try, const char __user *user
>         if (!buf)
>                 return -ENOMEM;
>
> -       if (copy_from_user(buf, user_buf, count))
> +       if (copy_from_user(buf, user_buf, count)) {
> +               kfree(buf);
>                 return -EFAULT;
> +       }
>
>         buf[count] =3D '\0';
>         strim(buf);
> --

Have you missed the __free() annotation on "buf"?

