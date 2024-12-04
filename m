Return-Path: <linux-pm+bounces-18529-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBB59E3A69
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 13:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C518416555B
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 12:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E36A1BBBE4;
	Wed,  4 Dec 2024 12:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1RkJDXr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541061B414D;
	Wed,  4 Dec 2024 12:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733316828; cv=none; b=HRKGcp4QbnDpd0PqBqfOK80sbgT3RuM2cWtHMckOoDpN1aP48WPf3zLQp2xDRnU1pz552RLQpp3utT2wv8q3UJXeAK/9F5eab427K0uP2xBT+cMgzzRckUzQYkwTx0A4oWe7M4hChSc8uVmo4YfY/3kwO1ra7xG2Ogskzu/DFwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733316828; c=relaxed/simple;
	bh=oEO4RDbiJAB3b6nfe/PZkZK9xDFRKh94CQJ7ErxhGQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eG4M6Uz6M0NOtEr9d8wI7tmGWNVjdTZ4Pb3LTYtngkxxQHNLzVQRMQuSeJKYGkfpRLcsI6dHdyauem0Zo+AmaOumSHmDDLLH3yQYccFNcQHwprB5jRpP2c/wAOcdD78dY/YkprqqFbRnHTevmNwoYwBSGe9u/UOnLDOApxjOsko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1RkJDXr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D26E6C4AF0C;
	Wed,  4 Dec 2024 12:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733316827;
	bh=oEO4RDbiJAB3b6nfe/PZkZK9xDFRKh94CQJ7ErxhGQQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=k1RkJDXrL1aHiJBXLPi5Nr7HcBHMd0Glytdy47JBJJIf0nC3BT6Ir+ohJpLhgz30P
	 EI2JpCfEocrAZSeOFTJwcUK9IQCT0x+l7iGh897NqbLcKwYAycYX4NMw9BochAq9li
	 DdSB6BdkftSOc878k/zPugEZ3DZac6lA0jmysVve0UQihNWwCGifJRiZMmQO8arQ3Y
	 Xrpm27BxMFqDr0pnatB7ujqCu9yEbkDiDwRA392fk77bFU5QVjax+SYr1wnXq6Ug7w
	 BliA6hETaqYK9jhh/ojpWHDTgNhzBc6zKf8HCO+dkR9uTmvXm8fP0hLK8VYtyyyBfX
	 T/XNZe/QwVYpQ==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-29e842cb9b4so1420880fac.2;
        Wed, 04 Dec 2024 04:53:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVM7TlRJDUa+zFcBC+HbFgWyZhA+Ye2jjiC5+7DKDzVlQ/17PVUSY7/JzRr2VLeanYa/DsQvG0s1tZ0Nsw=@vger.kernel.org, AJvYcCWWtv4iEEioCjEEInxfqYP7AywCst2Jr3fwSggIyEvWvW36rUkp5kLst2W989Cj4Y3fuZOZozgEc6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU24e7Aa/12oYnmtj+HzcBLfU5KrEkVhggoupdhSBRLPy09pQn
	nCyfmUwQakg9CMGA/zrydDcU4qnm+W1hOyjVc15M7N08O6QsUY5ycD7SrfFoM/ksK7Lw7ehdNx+
	RllMYlrlNcZ/gXDXVs2tIeXBNH3M=
X-Google-Smtp-Source: AGHT+IFnwtEvxI5AB8DYMsjKvZo4g8APN9r0qLnARkZSQLDhVQEAdpw7mxNBTkWOhpaBe0MRz6LFjx1sprRSYtn7h3s=
X-Received: by 2002:a05:6870:e2cb:b0:29e:5c94:5afd with SMTP id
 586e51a60fabf-29e885a949fmr6209762fac.1.1733316827098; Wed, 04 Dec 2024
 04:53:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114220921.2529905-1-saravanak@google.com> <20241114220921.2529905-2-saravanak@google.com>
In-Reply-To: <20241114220921.2529905-2-saravanak@google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 4 Dec 2024 13:53:36 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0grG7eSJ7_c73i9-bXaFhm5rfE2WmxtR6yLB-MGkd7sVg@mail.gmail.com>
Message-ID: <CAJZ5v0grG7eSJ7_c73i9-bXaFhm5rfE2WmxtR6yLB-MGkd7sVg@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] PM: sleep: Fix runtime PM issue in dpm_resume()
To: Saravana Kannan <saravanak@google.com>
Cc: Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ben Segall <bsegall@google.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Trim CC list.

On Thu, Nov 14, 2024 at 11:09=E2=80=AFPM Saravana Kannan <saravanak@google.=
com> wrote:
>
> Some devices might have their is_suspended flag set to false. In these
> cases, dpm_resume() should skip doing anything for those devices.

Not really.  This is particularly untrue for devices with
power.direct_complete set that have power.is_suspended clear.

> However, runtime PM enable and a few others steps are done before
> checking for this flag. Fix it so that we do things in the right order.

I don't see the bug this is fixing, but I can see bugs introduced by it.

I think that you want power.is_suspended to be checked before waiting
for the superiors.  Fair enough, since for devices with
power.is_suspended clear, there should be no superiors to wait for, so
the two checks can be done in any order and checking
power.is_suspended first would be less overhead.  And that's it
AFAICS.

> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/base/power/main.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 4a67e83300e1..86e51b9fefab 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -913,6 +913,9 @@ static void device_resume(struct device *dev, pm_mess=
age_t state, bool async)
>         if (dev->power.syscore)
>                 goto Complete;
>
> +       if (!dev->power.is_suspended)
> +               goto Unlock;
> +
>         if (dev->power.direct_complete) {
>                 /* Match the pm_runtime_disable() in __device_suspend(). =
*/
>                 pm_runtime_enable(dev);
> @@ -931,9 +934,6 @@ static void device_resume(struct device *dev, pm_mess=
age_t state, bool async)
>          */
>         dev->power.is_prepared =3D false;
>
> -       if (!dev->power.is_suspended)
> -               goto Unlock;
> -
>         if (dev->pm_domain) {
>                 info =3D "power domain ";
>                 callback =3D pm_op(&dev->pm_domain->ops, state);
> --
> 2.47.0.338.g60cca15819-goog
>

