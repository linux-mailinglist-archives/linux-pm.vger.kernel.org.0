Return-Path: <linux-pm+bounces-38233-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C04DBC711F3
	for <lists+linux-pm@lfdr.de>; Wed, 19 Nov 2025 22:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7E6D24E05E1
	for <lists+linux-pm@lfdr.de>; Wed, 19 Nov 2025 21:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52ABC2F363C;
	Wed, 19 Nov 2025 21:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+wgvreV"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD0A2F12C8
	for <linux-pm@vger.kernel.org>; Wed, 19 Nov 2025 21:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763586847; cv=none; b=Y7a+qqf4h3KUaNtkCdtCsZi/0M8/v0UMIGB8K1B2S/I8nhQmg1GFsz06IKM25FCA2cHpjIcASizv0DB7yFGuQzl3FvXaz3hi5wAUvdJGYgQRfF4prEkVrjIIHdlHrLw6w9TVa+ELnKEHEr9cjUPRxn/gSkq3DJNTLUKBOE21jWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763586847; c=relaxed/simple;
	bh=TxfeFlgF/8R1bJ0k+hL6THoIGitUAHNLr6VBvzvIHw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n+JBZQlrNsywNtdZPrBQenV2Jn1tNvZsXjcEqWELHNy89Grwx1/xv3sct87iCx78B5qXwTWnsu4jMvImvhoHZHNgn+l5j7aLxvSpVAhYb/OHd7R/EPt4eFHqGZ5j5CXOxpRnJcZd2LA6vCEYrp9xy/b2aUosLXSRDYUV3170das=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+wgvreV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAFE9C4CEF5
	for <linux-pm@vger.kernel.org>; Wed, 19 Nov 2025 21:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763586846;
	bh=TxfeFlgF/8R1bJ0k+hL6THoIGitUAHNLr6VBvzvIHw4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=o+wgvreVUM8B3yk0OYMVNNgZBAs4Xni2ZWHDZYlYk42Yh8eJd6DoQrp1cklL1uCOn
	 51RvocnGmcLvPj+h1LEmfHLIm9MV04G99nom49xQvosoy+W2BIyGEn+QEHFqMhnpy5
	 lW4JxVWqTCvCJ4djuYo/jLiHzzdYzmmJ07i+47goubmpK/CG3fTQgaqckouDptk2nT
	 /fmquH/cjgef1Iu87u1pSnu4Dv7fGq1ckBoBUSrM/zd290D1ctpB80By2B7telIOTT
	 VUhyq49y6GQljpfZ9GxqHXGaEO1LCu4Omk7VHfCTmGgOjhtvoQTVlLhY3sXrOrPsVd
	 t3ZeRHPjR5R5g==
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7c6da5e3353so116862a34.3
        for <linux-pm@vger.kernel.org>; Wed, 19 Nov 2025 13:14:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWPc7CJUsWNdM23NEWOpLcvT3ndggCkUUoYl9jbUQjDKZqqyVr2axm1+zLs4iRTbBn0bTfkVDw46w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFHa8TIsVr1vsl3VZ4r9udzUHGc1RQlVi0BhGTI0iJ0QOID4Wr
	AzpAXbFdYqjMoLLltn7ctiBrEfHOKwxQ9fVttoc2/E0HNnAYYVhKS0J3sEAkJ9pXuIIATPB9tdV
	59PfPpwZuHLt80nsGv889uQucKv+GaCg=
X-Google-Smtp-Source: AGHT+IGCxxtWaMj1sPWjdcfpjPmTiQ0IYL6aB5vi2gYNf185/UM2XvmQz+bJpIN+Rc7i2xlLJWfGj7J57RmyOlQoAQc=
X-Received: by 2002:a05:6808:c1ab:b0:450:d471:dce5 with SMTP id
 5614622812f47-450ff22e4cemr347332b6e.6.1763586846127; Wed, 19 Nov 2025
 13:14:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12810244.O9o76ZdvQC@rafael.j.wysocki> <2418792.ElGaqSPkdT@rafael.j.wysocki>
In-Reply-To: <2418792.ElGaqSPkdT@rafael.j.wysocki>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 19 Nov 2025 22:13:55 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jpaNcTyzviv2qSNUT5nvDV2wjw9OC4ZAUtUz8YJFhkKg@mail.gmail.com>
X-Gm-Features: AWmQ_bkt7UYKs_Yjp0mXXbLQMcp8QAKPoPTIagd5E3l2wbE6c83CQZPuF89Saz0
Message-ID: <CAJZ5v0jpaNcTyzviv2qSNUT5nvDV2wjw9OC4ZAUtUz8YJFhkKg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] cpuidle: governors: teo: Simplify intercepts-based
 state lookup
To: Christian Loehle <christian.loehle@arm.com>, Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 16, 2025 at 1:35=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Simplify the loop looking up a candidate idle state in the case when an
> intercept is likely to occur by adding a search for the state index limit
> if the tick is stopped before it.
>
> First, call tick_nohz_tick_stopped() just once and if it returns true,
> look for the shallowest state index below the current candidate one with
> target residency at least equal to the tick period length.
>
> Next, simply look for a state that is not shallower than the one found
> in the previous step and, ideally, satisfies the intercepts majority
> condition.
>
> Since teo_state_ok() has no callers any more after the above changes,
> drop it.
>
> No intentional functional impact.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpuidle/governors/teo.c |   62 ++++++++++-----------------------=
-------
>  1 file changed, 16 insertions(+), 46 deletions(-)
>
> --- a/drivers/cpuidle/governors/teo.c
> +++ b/drivers/cpuidle/governors/teo.c
> @@ -256,12 +256,6 @@ static void teo_update(struct cpuidle_dr
>         }
>  }
>
> -static bool teo_state_ok(int i, struct cpuidle_driver *drv)
> -{
> -       return !tick_nohz_tick_stopped() ||
> -               drv->states[i].target_residency_ns >=3D TICK_NSEC;
> -}
> -
>  /**
>   * teo_find_shallower_state - Find shallower idle state matching given d=
uration.
>   * @drv: cpuidle driver containing state data.
> @@ -383,7 +377,18 @@ static int teo_select(struct cpuidle_dri
>          * better choice.
>          */
>         if (2 * idx_intercept_sum > cpu_data->total - idx_hit_sum) {
> -               int first_suitable_idx =3D idx;
> +               int min_idx =3D idx0;
> +
> +               if (tick_nohz_tick_stopped()) {
> +                       /*
> +                        * Look for the shallowest idle state below the c=
urrent
> +                        * candidate one whose target residency is not be=
low the
> +                        * tick period length.
> +                        */
> +                       while (min_idx < idx &&
> +                              drv->states[min_idx].target_residency_ns <=
 TICK_NSEC)
> +                               min_idx++;
> +               }
>
>                 /*
>                  * Look for the deepest idle state whose target residency=
 had
> @@ -393,49 +398,14 @@ static int teo_select(struct cpuidle_dri
>                  * Take the possible duration limitation present if the t=
ick
>                  * has been stopped already into account.
>                  */
> -               intercept_sum =3D 0;
> -
> -               for (i =3D idx - 1; i >=3D 0; i--) {
> -                       struct teo_bin *bin =3D &cpu_data->state_bins[i];
> -
> -                       intercept_sum +=3D bin->intercepts;
> -
> -                       if (2 * intercept_sum > idx_intercept_sum) {
> -                               /*
> -                                * Use the current state unless it is too
> -                                * shallow or disabled, in which case tak=
e the
> -                                * first enabled state that is deep enoug=
h.
> -                                */
> -                               if (teo_state_ok(i, drv) &&
> -                                   !dev->states_usage[i].disable) {
> -                                       idx =3D i;
> -                                       break;
> -                               }
> -                               idx =3D first_suitable_idx;
> -                               break;
> -                       }
> +               for (i =3D idx - 1, intercept_sum =3D 0; i >=3D min_idx; =
i--) {
> +                       intercept_sum +=3D cpu_data->state_bins[i].interc=
epts;
>
>                         if (dev->states_usage[i].disable)
>                                 continue;
>
> -                       if (teo_state_ok(i, drv)) {
> -                               /*
> -                                * The current state is deep enough, but =
still
> -                                * there may be a better one.
> -                                */
> -                               first_suitable_idx =3D i;
> -                               continue;
> -                       }
> -
> -                       /*
> -                        * The current state is too shallow, so if no sui=
table
> -                        * states other than the initial candidate have b=
een
> -                        * found, give up (the remaining states to check =
are
> -                        * shallower still), but otherwise the first suit=
able
> -                        * state other than the initial candidate may tur=
n out
> -                        * to be preferable.
> -                        */
> -                       if (first_suitable_idx =3D=3D idx)
> +                       idx =3D i;
> +                       if (2 * intercept_sum > idx_intercept_sum)
>                                 break;
>                 }
>         }

I'd appreciate feedback on this one.

I regard it as a significant improvement even though it is not
expected to change functionality.

