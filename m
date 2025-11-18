Return-Path: <linux-pm+bounces-38180-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F87C6A15F
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 15:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id E65452FFDA
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 14:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861AB320CD3;
	Tue, 18 Nov 2025 14:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JX09/2LT"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6075A221277
	for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 14:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763476387; cv=none; b=FKrbVpGYAPmMmxF/ls7u8Yd1XDBg7NBf9JhWETHKzpFVWP1Vov0dEQ/QjG5XJRf2LnxDL14nGsxK6Ub2uyt7i1Ls5tECtRXoMbj/EgfBGAliKrAkL2tOP86g/pyMdN6pJZXNOeYOiX5Joz+Z+t+qnxpiZyqLXn4g0HYbjPXgs5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763476387; c=relaxed/simple;
	bh=hWYPrsy521PjmUw2WvFDQSgNAgr1OVgHhT998eHN5xU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lojzx624byRjXXJpixcBFiVHuaWH7zTaE+3GYjoSr4wV9NxK6HmK+NTaG25tesxSkID0Uj8rqfFBjyb7nKLPNXbni4pfDucUpX+UzKpnGPi1VMJxU5XUH6jM94dMQqbnIRUQ1s2CKrrai1ZhIZLHRUqNZQf4RtLOGR3bbbAKKgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JX09/2LT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8FAFC2BC87
	for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 14:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763476385;
	bh=hWYPrsy521PjmUw2WvFDQSgNAgr1OVgHhT998eHN5xU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JX09/2LTjtRMJMLQEFklNXik/OX1ajsOEpVVjRMACSLmEMBLuNBMOtzHTfxLB2k8J
	 l4F7h8b7TgyJEirdCj50lPV1+rfWoiLCc8zClawCPb0GN7StpJmq9838Upo4PgADYE
	 OzwlTlLGBf0lX1KkZo7/5gor1KOYMwgIyAUdTXD4Mi/ebmo5vID10/gGR8w2UQmVwF
	 94wUwJzA2U2Sm6oQKv061Roapsv98vwKgIMIimNl1oGctY8y7UzisWhCN0uW4reJxW
	 lW0gOovxpY3SgQrHm3O/V85xx3VitXEKUcSyMyY/aRGTSggW7JYBqy5wBgIo2uKFMp
	 1PucKLiF8uvFQ==
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7c7503c73b4so1777644a34.3
        for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 06:33:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUGjnxYjt9BTmpa09t1MuEM+sx+hQWVmELBANm9OmR2QZv+AdpUPIkO5T02SPfMEpqqIfv3wgUGkQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3ofUwbTGmjLun4xAX9BzIVdJeoerbgTK/aYN6Dq3+i/zkIN3/
	X0dq1DyuIOkbWFYGG6m4vlgheDN1IVxgNIj6z6pCxWpGwYwZwfTSl+iyxdsXJtGO7509nMJlbup
	4XtxUQqsqluAv1FzNeCW6W7duLeMBHPU=
X-Google-Smtp-Source: AGHT+IFZImUE4ClctgLg7NCQ+JMkthc4+K0fj9UiXUQNMPjeVaA96ti8vw7VQosUzSnTZ7AeFN9k44ZG3DzRLUTkBYM=
X-Received: by 2002:a05:6808:2748:b0:450:b947:1d8a with SMTP id
 5614622812f47-450b94725a1mr3404916b6e.7.1763476385174; Tue, 18 Nov 2025
 06:33:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117161317.2426787-1-kaushlendra.kumar@intel.com>
In-Reply-To: <20251117161317.2426787-1-kaushlendra.kumar@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 18 Nov 2025 15:32:54 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jojkOBXDxGkxMuctSr8opAq5edotwxqM-MnFOpDg_5kA@mail.gmail.com>
X-Gm-Features: AWmQ_bmJnZ-Xx7wNskUxHkTincodPtCy85fHcBdVmG-nN78T9xXMcCElgpCBp-A
Message-ID: <CAJZ5v0jojkOBXDxGkxMuctSr8opAq5edotwxqM-MnFOpDg_5kA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: ACPI: Replace udelay() with usleep_range()
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 5:15=E2=80=AFPM Kaushlendra Kumar
<kaushlendra.kumar@intel.com> wrote:
>
> Replace udelay() with usleep_range() in check_freqs() to allow
> CPU scheduling during frequency verification polling. This
> improves system responsiveness and avoides busy-waiting during

avoids

> frequency change verification.
>
> The 10=CE=BCs delay is non-critical timing where scheduling
> overhead is acceptable, making usleep_range() more
> appropriate than busy-waiting.

I'm not sure what exactly you wanted to say here.  Care to explain?

> Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
> ---
>  drivers/cpufreq/acpi-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufre=
q.c
> index 083d8369a591..bf511ab675ba 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -395,7 +395,7 @@ static unsigned int check_freqs(struct cpufreq_policy=
 *policy,
>                 cur_freq =3D extract_freq(policy, get_cur_val(mask, data)=
);
>                 if (cur_freq =3D=3D freq)
>                         return 1;
> -               udelay(10);
> +               usleep_range(10, 20);

In principle this should be fine, but it potentially increases the
maximum time taken by this loop from 1 ms to 2 ms.

>         }
>         return 0;
>  }
> --

