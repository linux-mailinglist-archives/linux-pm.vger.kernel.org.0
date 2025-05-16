Return-Path: <linux-pm+bounces-27250-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A057ABA478
	for <lists+linux-pm@lfdr.de>; Fri, 16 May 2025 22:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45A7E7B1DB7
	for <lists+linux-pm@lfdr.de>; Fri, 16 May 2025 20:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E60622A817;
	Fri, 16 May 2025 20:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uyDg+Dgg"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4550B220F49;
	Fri, 16 May 2025 20:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747426030; cv=none; b=CubwdHEU4PfFzqlcX7vpbhFC3iSElF11MO0gYODj7YqDC0Y67AentcDP75Bvx046ZHpppQfVj8l1ejI9mgA0E8EpQ0Kygyty8DQPwp7hWHuhMF8sZ/an4TCGanRQJ+NRU/EtN+27s+feP2l+/VwNNeWyNWEkQHvntzGnaAquO+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747426030; c=relaxed/simple;
	bh=mJ0jGMRRfQLSjL05gzAIpx7jKSG441CNbIHD+fUxi6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AV3e2bJ4vnn6sDGeVPgMh20t0eMOdraIyVphAM74pjOo1pV7WhjqUT3+zhs22MitzTik/i5QhcWuy+GSlgVYbQrUobjFuYBubWdzrVlK8szlpNfBtVPUY/5lX7uz9kwJ6RhzNQ1anygP/39dpEiQp7pGE8W9aM9plf+eJzz2NTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uyDg+Dgg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3AEEC4CEF0;
	Fri, 16 May 2025 20:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747426029;
	bh=mJ0jGMRRfQLSjL05gzAIpx7jKSG441CNbIHD+fUxi6k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uyDg+DggCTrKMvhCdqiFCu3MFGO97g4JN+kjFbEkkl/jmSiDre2VgkDcMOU/sTxG+
	 FGkLBaC8PoZDKIDKveWiTZGNohR9gIqahbdErLKgE/o8ltugkvQoTOr+skdKlzC11O
	 TDUVC381vRMcycclDIdZoZzqcEaJxE4lxsnvQVabTk6NGaCAfERq/3X2mErk5ZKmNU
	 S9/CdOXid8mLvhwpF9ICrWkjTwIdLJlUGkbD26D9C1vfcFA8wY+NHiqBYrCW/E6LKC
	 T5iHSu6RYqNYZK/884zEsqbazafN9g5vR8w/zpqU1UlNIpVP11CJAntkKLYn/yjJXc
	 Y54pnVCLLHQaA==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2c2504fa876so261902fac.0;
        Fri, 16 May 2025 13:07:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV951Mm9sGj0zpmPjmKOgNJD40AOH9DnGRgd4K8ncp7h+XWywCnv9W+JJEy3xsU5FA8WUHNqzerf3g=@vger.kernel.org, AJvYcCVVHQ8xlJiLEIL51WY5dlZKaKUTr0OQWrS90YTLas1UaFEDb8hi6oqpajODlZSAAGKBrwiriKv3lU/i0b0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8s7enDPwXWHY4KengjDyXV7Av2sPDvU6nG4+nnHLinIICbVfP
	T0ro1lfnFzrlvb6WzbWNWwJuKjOfvN9rHv8Q1v9H20CfgZUg/b0m98Zc7DXp5wmSg7LwB4zSdHv
	GrUNMRNM4ontfyRPXCjFyvDTPsljfE8Q=
X-Google-Smtp-Source: AGHT+IGRsaxMTafd+2mpU+XSFPuqtflvQKkXM1GGBKQd8EG+vvj6lKcksJFbKtLG6ZgdLeLBVZ9UNSg9Q+4i8XBTTN0=
X-Received: by 2002:a05:6871:2201:b0:2c2:5270:f182 with SMTP id
 586e51a60fabf-2e3c85ed542mr2385964fac.39.1747426028943; Fri, 16 May 2025
 13:07:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515064125.1211561-1-quic_charante@quicinc.com>
In-Reply-To: <20250515064125.1211561-1-quic_charante@quicinc.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 16 May 2025 22:06:58 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hanp631h_VGijY5Joj=tQn=sENnzu5AZDuqWsMiOi+mw@mail.gmail.com>
X-Gm-Features: AX0GCFvtwiLFNpmp1Gi1PmfAJyyHjOq80flQRIGep8vIhNIZkR1Wf1ga2xdi8jM
Message-ID: <CAJZ5v0hanp631h_VGijY5Joj=tQn=sENnzu5AZDuqWsMiOi+mw@mail.gmail.com>
Subject: Re: [PATCH] PM-runtime: fix denying of auto suspend in pm_suspend_timer_fn
To: Charan Teja Kalla <quic_charante@quicinc.com>
Cc: rafael@kernel.org, len.brown@intel.com, pavel@kernel.org, 
	gregkh@linuxfoundation.org, dakr@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Patrick Daly <quic_pdaly@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 8:42=E2=80=AFAM Charan Teja Kalla
<quic_charante@quicinc.com> wrote:
>
> pm_runtime_put_autosuspend() schedules a hrtimer to expire at
> "dev->power.timer_expires". If the hrtimer's callback -
> pm_suspend_timer_fn - observes that the current time equals
> "dev->power.timer_expires", it unexpectedly bails out instead of
> proceeding with runtime suspend.
>
> pm_suspend_timer_fn():
> if (expires > 0 && expires < ktime_get_mono_fast_ns()) {
>         dev->power.timer_expires =3D 0;
>         rpm_suspend(..)
> }
>
> Additionally, as ->timer_expires is not cleared, all the future auto
> suspend requests will not schedule hrtimer to perform auto suspend.
>
> rpm_suspend():
> if ((rpmflags & RPM_AUTO) &&...) {
>      if (!(dev->power.timer_expires && ...) { <-- this will fail.
>         hrtimer_start_range_ns(&dev->power.suspend_timer,...);
>   }
> }
>
> Fix this by aswell checking if current time reaches the set expiration.
>
> Co-developed-by: Patrick Daly <quic_pdaly@quicinc.com>
> Signed-off-by: Patrick Daly <quic_pdaly@quicinc.com>
> Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
> ---
>  drivers/base/power/runtime.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 205a4f8828b0..c55a7c70bc1a 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1011,7 +1011,7 @@ static enum hrtimer_restart  pm_suspend_timer_fn(st=
ruct hrtimer *timer)
>          * If 'expires' is after the current time, we've been called
>          * too early.
>          */
> -       if (expires > 0 && expires < ktime_get_mono_fast_ns()) {
> +       if (expires > 0 && expires <=3D ktime_get_mono_fast_ns()) {
>                 dev->power.timer_expires =3D 0;
>                 rpm_suspend(dev, dev->power.timer_autosuspends ?
>                     (RPM_ASYNC | RPM_AUTO) : RPM_ASYNC);
> --

Applied as 6.16 material, thanks!

