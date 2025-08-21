Return-Path: <linux-pm+bounces-32837-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF164B3034B
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 22:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 403BD1BC85D2
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 20:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F0434DCDD;
	Thu, 21 Aug 2025 20:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PpXsKD7h"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE633375A7;
	Thu, 21 Aug 2025 20:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806405; cv=none; b=R6fLmqqn7DrZtAuLJ13GoBu3AwMhbk3og/cNwnsWIPzXhVCUjZV97SPW7HbRyOPOQevULYWVHLwjdyF9e/+qKe8eIYawETzvV1SQxJJhrY1iRVSki3kABYbvCe1sfH8ppF/wa9L7pVKT2dxz9LUkJ8/uubSpadRw65KsCNIB1KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806405; c=relaxed/simple;
	bh=1gmXguBkQ8JkuLf60p+nfBttSChWiMPwrCt34O3w7hM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BpNZOoKQhMjCiEriCmRTyNi8FYEdcs9qXowatQCn6atnAV0l5ddjw1eaoyZFxQSMmbHOQkNBnZ4RtaekrzwNDQmF9uMMreRf/G3Y4UKzPG89yH/6MHWG2OXyHeSZprxcv8rWQYORabubFo9odLpjw5qlVxYsO0nDrS9eIXTAIOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PpXsKD7h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 869C4C4CEF4;
	Thu, 21 Aug 2025 20:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755806404;
	bh=1gmXguBkQ8JkuLf60p+nfBttSChWiMPwrCt34O3w7hM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PpXsKD7hBq+g4msjUEKpvBs1CZwqD70A87JDLbqhum3yQTV7A2suKpCV+NRR6wgxl
	 CuPima0dBTEaXEH3UckIgU5PR1dwpb6oMhHXcGSBZu7gh9thGgO1P7xF2SrmSPvGxk
	 s26FBG8I6pdNFBaYR2lRpLfoEuDj8DOF1Eu4DgW81/SdpbnvjqtD92aOVPicjKZl+J
	 5M0vvXJ+UxVvJlWYrrpRXzieWvhCT1DRPxBqC8vFNZmOq8T2dm/CkzKd7kNooZUThG
	 cIBdUFUTHaAEJs25ACLF6k8BXv90qrmRoEV4oG/SqQr55RrUTAY/DeYPOBaGsOjGT7
	 NpdWS6oupy0qw==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-61bd4e14054so646223eaf.2;
        Thu, 21 Aug 2025 13:00:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU3w1Tlllcg2+rH4qn7aM8ACvexl9A8ONfbOI7HjArhZr26+uYp32Q+H1s6zXxk9ReBV7u7j8Qx868=@vger.kernel.org, AJvYcCUDb+lEgD+WMirKoyFSzLam/tjZ/hfZTz50U4iwsQLjWhbjv5zSuqdJpnTRdIp7S3X1cOLV9Xk82MB6GUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YySLjlkyFK8fUcUV1Ne04MK97pPe2wK1BEb/mCiAGxqbUf80I5i
	xWL1r6XfMDEMvn/y+3ZZgdp9cps2xUgDpnr8sSEqyKw3A52ZiHId8NKXO9Sc7AmKHt6T6DeWzo5
	oHAo6A024IFnFBXjuiEcY5EB6Kpx5p5Y=
X-Google-Smtp-Source: AGHT+IEoDXHyO2qFJ7qPARFnmGcro6nNWlDh/Glk0d3cVoCrxe08tWlmzXBrx5YjteL6zSi87n+aPqQXSnHcjkroCO8=
X-Received: by 2002:a05:6870:708c:b0:314:b6a6:6897 with SMTP id
 586e51a60fabf-314dce417bfmr210631fac.43.1755806403667; Thu, 21 Aug 2025
 13:00:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813075433.464786-1-zhao.xichao@vivo.com>
In-Reply-To: <20250813075433.464786-1-zhao.xichao@vivo.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 21 Aug 2025 21:59:50 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jcEX=sxK9kEo-jTX-e1cGi6RqLTG6OjmGdaqWNNwV_4w@mail.gmail.com>
X-Gm-Features: Ac12FXxg8bx_bgqiTf4CKVc6UqbSWHJBrAXrQ_wBEUpnqFSa4ucPXhUhhXhU5cA
Message-ID: <CAJZ5v0jcEX=sxK9kEo-jTX-e1cGi6RqLTG6OjmGdaqWNNwV_4w@mail.gmail.com>
Subject: Re: [PATCH] powercap: use us_to_ktime() where appropriate
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 9:54=E2=80=AFAM Xichao Zhao <zhao.xichao@vivo.com> =
wrote:
>
> The duration_us, idle_duration_us, and run_duration_us are more suitable
> for using the us_to_ktime() function. This can make the code more concise
> and enhance readability.
>
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
> ---
>  drivers/powercap/idle_inject.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_injec=
t.c
> index 5ad7cc438068..a25eb2018acd 100644
> --- a/drivers/powercap/idle_inject.c
> +++ b/drivers/powercap/idle_inject.c
> @@ -133,7 +133,7 @@ static enum hrtimer_restart idle_inject_timer_fn(stru=
ct hrtimer *timer)
>         duration_us =3D READ_ONCE(ii_dev->run_duration_us);
>         duration_us +=3D READ_ONCE(ii_dev->idle_duration_us);
>
> -       hrtimer_forward_now(timer, ns_to_ktime(duration_us * NSEC_PER_USE=
C));
> +       hrtimer_forward_now(timer, us_to_ktime(duration_us));
>
>         return HRTIMER_RESTART;
>  }
> @@ -232,8 +232,7 @@ int idle_inject_start(struct idle_inject_device *ii_d=
ev)
>         idle_inject_wakeup(ii_dev);
>
>         hrtimer_start(&ii_dev->timer,
> -                     ns_to_ktime((idle_duration_us + run_duration_us) *
> -                                 NSEC_PER_USEC),
> +                     us_to_ktime(idle_duration_us + run_duration_us),
>                       HRTIMER_MODE_REL);
>
>         return 0;
> --

Applied as 6.18 material with adjusted subject and changelog, thanks!

