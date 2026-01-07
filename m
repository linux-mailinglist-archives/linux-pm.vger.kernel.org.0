Return-Path: <linux-pm+bounces-40399-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E06CFFF20
	for <lists+linux-pm@lfdr.de>; Wed, 07 Jan 2026 21:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DF75030019CA
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jan 2026 20:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7163358CE;
	Wed,  7 Jan 2026 20:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jw8pNcJc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C102EACEE
	for <linux-pm@vger.kernel.org>; Wed,  7 Jan 2026 20:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767816764; cv=none; b=jOyqnDs9JqZvRkTt+UnRmypbhbwjhm5SxnqtxLXEhBMiHTcJFa2OHzF+d4dMJUGVuBHX9O7xTKmBXhjy+l6qcxRuFIvJ3Yiml301y60o5+CoYHkuBv+f0K82GFzvudMgWNGULVpJT+G0rvnuh/tTy8x8273B+UMN7pvm+7gsXv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767816764; c=relaxed/simple;
	bh=OaXuH1WjBYWbyYdYYQ/QkjlMCSgkmVSbEMcmxnhL6bA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AVPurOWTLJNj0s16OOMHR0/PMzxO9o95zGr6CyBVclP6f3Hs1hkeuV5EqL6PXCOSb4mIFjgoHa8S7hteWJB0Bn3HXRY2bZ601WSvE7gfiAA74y6PknPqBQ0lAyvm4xy+0qxqrB0rq4pfqEDY0xePwAv/TM9qndIQ9ievQWtbVLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jw8pNcJc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC126C16AAE
	for <linux-pm@vger.kernel.org>; Wed,  7 Jan 2026 20:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767816763;
	bh=OaXuH1WjBYWbyYdYYQ/QkjlMCSgkmVSbEMcmxnhL6bA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Jw8pNcJcXh++2Zj+BKiU0pFYJxI6K1vb1YjQwZg1aWktd+L+sl7oX4FdT4Z4TS6Co
	 LlZE+ANYMnplDRJt6daHD+OSyd5KCe+sZFdP/N5Y274ux9zEM+HqZHRid/xscwvJCW
	 xqdlbMC/5Tt9jJgyBsgmacDG6VHUNdvfrgfbxJMqYh2CowmRBRO5di9MACRE78EC+q
	 pjjbi9XNgkI/ybr4TI2yWK/W0kMUJbsClvLkMyquujX5LxT62rCQrlWrDgVrSVZceo
	 xm3NI0yYm0L6KTjLYvUq6Be0zXPTOG0S4W8VzygFX+cMtQlTV36zn3UBtG4vZPmSO0
	 simG8vFC8zIww==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-65b855fba0fso1082825eaf.2
        for <linux-pm@vger.kernel.org>; Wed, 07 Jan 2026 12:12:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXIqnD+6a9vdj8Hw70k260etzFnA3hITfrfwS4+IkU5yYs4EmbDIcIXo8LCpfaos93sMyWCWL++Ng==@vger.kernel.org
X-Gm-Message-State: AOJu0YyTaavMKdQHUcd7eagaXpBJxi272OBpQwGW3WffzokH+LrlhPOn
	t/QsJMVKivmHe25Ppphgmhq+Ik1yv24/WWd4bTzfO1nn17/zc+xWbDk37jiBRElSSvc1HbvKkOI
	gnHcZey7CBTsR3wW5R+fWBHzril42nek=
X-Google-Smtp-Source: AGHT+IGQCNdHG0scmteBwwa6Vk5PNI4gTgKRhmTITD/cEUX7Eu21kLGyxGi04gS+1EhU457YwPe9UHzBrhYWINchg4Y=
X-Received: by 2002:a4a:d118:0:b0:65f:5bc2:844d with SMTP id
 006d021491bc7-65f5bc28accmr444453eaf.62.1767816762960; Wed, 07 Jan 2026
 12:12:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215111229.132705-1-dedekind1@gmail.com>
In-Reply-To: <20251215111229.132705-1-dedekind1@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 7 Jan 2026 21:12:31 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gM3_za6e_F7o5gLnaFWMc_tOQN7Rqkp5S1WGMps2moZQ@mail.gmail.com>
X-Gm-Features: AQt7F2qh94zus5BfcIDhYWD-Vf44z4CBhImdWNCIT0Hjcxgyt39f2rgFSbT7U6E
Message-ID: <CAJZ5v0gM3_za6e_F7o5gLnaFWMc_tOQN7Rqkp5S1WGMps2moZQ@mail.gmail.com>
Subject: Re: [PATCH resend 1] intel_idle: Remove unused driver version constant
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM Mailing List <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 12:12=E2=80=AFPM Artem Bityutskiy <dedekind1@gmail.=
com> wrote:
>
> From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
>
> The INTEL_IDLE_VERSION constant has not been updated since 2020 and serve=
s
> no useful purpose. The driver version is implicitly defined by the kernel
> version, making this constant redundant.
>
> Remove the constant to eliminate potential confusion about version
> tracking.
>
> Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> ---
>  drivers/idle/intel_idle.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> Re-sending, for some reason the first submission did not arrive to the li=
nux-pm
> mailing list, I cannot find it in the archives.
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index 9ba83954c2555..aa44b3c2cb2c4 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -63,8 +63,6 @@
>  #include <asm/fpu/api.h>
>  #include <asm/smp.h>
>
> -#define INTEL_IDLE_VERSION "0.5.1"
> -
>  static struct cpuidle_driver intel_idle_driver =3D {
>         .name =3D "intel_idle",
>         .owner =3D THIS_MODULE,
> @@ -2478,9 +2476,6 @@ static int __init intel_idle_init(void)
>                 return -ENODEV;
>         }
>
> -       pr_debug("v" INTEL_IDLE_VERSION " model 0x%X\n",
> -                boot_cpu_data.x86_model);
> -
>         intel_idle_cpuidle_devices =3D alloc_percpu(struct cpuidle_device=
);
>         if (!intel_idle_cpuidle_devices)
>                 return -ENOMEM;
> --

Applied as 6.20 material, thanks!

