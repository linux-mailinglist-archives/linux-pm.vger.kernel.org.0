Return-Path: <linux-pm+bounces-39977-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E86CE523A
	for <lists+linux-pm@lfdr.de>; Sun, 28 Dec 2025 16:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 710DF300183E
	for <lists+linux-pm@lfdr.de>; Sun, 28 Dec 2025 15:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63572D2397;
	Sun, 28 Dec 2025 15:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XfJMb5eS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4142D3ECF
	for <linux-pm@vger.kernel.org>; Sun, 28 Dec 2025 15:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766937127; cv=none; b=uQNMpUFTRYW8WfrmYMgHi/NwOsGLxFu7pU1KbjlpGdu0WtmO4/wmuKCSBYQTVV13T7phqJMDzRnOl6IPVWpWEdv6vKsTQ1q8ZGObJ1zqo05Qj7tdQFzs5CcKXuKUnMsy61ocGZQt5jsVZO874d3wWYhI5obU7ufTLI64Q/SBJXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766937127; c=relaxed/simple;
	bh=V66pYSRi4A1St60uNsQQJZZVJDEc2XRLg87YUH4BafE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fi06Mbuxvo3l8nV5xBHH92a7UEtWrVQld9OLHgBrk1qhJBstFdFMu+1H1BDMzcTo6KDOO3OeHR2TWxbnWb02uYMOpsYPKzON8aqKeAKoYkXxxJGKvgOtjq5n96CAtqTg/D5inFHYLB/uJEJ0K/i1zPzWtGPSen5JkaWzAdct/A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XfJMb5eS; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-594270ec7f9so9381279e87.3
        for <linux-pm@vger.kernel.org>; Sun, 28 Dec 2025 07:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766937123; x=1767541923; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qAheLyw1k9qY+mz/MVoVF7TVeH1WUkty9nHXwVJPAT8=;
        b=XfJMb5eSAalfMvidnL4FZJuL3S8XnhorguMdSyvXcDZZ82bfl4HcLy5w4nBwW/5Blr
         ZmB1ymHElggpqLJKB1Dcu3dERWiLpr8q03SJsrCXCdC7gjenXP6g4YJBumtZ2MncNVcU
         wXD2DzfVCSYksjaWeIDQyXZBAozp1EM4661B3JWUO4QrttX4LqKA7kMIheB0GLcJkRz0
         FyMJu4pfBm90u6A8RYRdhRsF1tqT9/NP+lLoHHCpD9blveuCaByLJfNpceBXCtguMyzt
         Fa2chFupkH64UQ/WsMRm6P2aVndflcxsuzmziwaFV/2XndoQaXRvD06XTgARUKE2Hj94
         H4dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766937123; x=1767541923;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qAheLyw1k9qY+mz/MVoVF7TVeH1WUkty9nHXwVJPAT8=;
        b=NeC4Ik29ehRyb0S3p7WlgfqJkFTQy3zqZqj3H3/YHvf/NCG9KINGoZrvAPdAzgonrz
         fiTIjLzEaOz9Wus9PaC3dQNj49ZnI3nWurxX3mY1Jx+xHPC+BEurwL3NYVEU79BVkfJo
         dZ6/eZzyfANuXQMF/QBuX04n2VhzMv4uMlgS21A1hXjABQNjc1aa4rROAzWzMzndIcK3
         A+oav3qTeKGO5S+BiL8jeh9X0+JORDIrcAld5Oe+6NONQ9fKspVPq8jm5Dtsh4yQU2Yt
         OfIJwhq5zEx1YLq0w3AD/ISFNlv+pDqWdBT1sF35RC9OIh4UPK4pH1vYXaPA61Hu/qEN
         GAng==
X-Gm-Message-State: AOJu0Ywn1eJVqThgkzSV1Hfdzfcp6s2m+Qet9GH9M+Usw7+yTPpVFMDJ
	a6TjMe1rDS/dQ9sSGKH+/hwsOwWQPV9juFNu35kNhKhVygFa8tl6Bn/fYeGawgVTbLhWpDEttnP
	po6w5tigQAuBfq7qupv+CdQPK0tVw3CrJorE37SmdgQ==
X-Gm-Gg: AY/fxX5Q15xz3zgwr8XsikUSwZ5gI3+UxY8xjHwtdyRgwL18aAHxO6lbLhn6vDvU0P5
	3L6x4mMARIUbPschfDashfsczDCqb/9Td7Ur0V1HRDK0gr5G1TLDmidaAfAY0ernJIQMK0y5j5Q
	TPmZ13fjpEqUrVmsp6BXZ3X7M8N+4GlNABPCCKcmomb02u1cYWlPbzx6rLNIm7Ep4XfqvsMDF7l
	dWde5/TmIhxj3gYVwkfu3/SSv6krKnqoOODAV80cI6Q14e7dhD2o3O+SsKt616lpxQ3YxAPAtEH
	RQ5jA/c=
X-Google-Smtp-Source: AGHT+IHDXYiOjycsrIKZ7zOp2mbTEo2Zm5sublU20unZSOVOyEDUtBbKhYfhPO49TVyqnesEU9CtfO6gW6oj2nEpfho=
X-Received: by 2002:a05:651c:111b:b0:37a:3768:3b20 with SMTP id
 38308e7fff4ca-38121689bd2mr77622181fa.39.1766937122775; Sun, 28 Dec 2025
 07:52:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6245770.lOV4Wx5bFT@rafael.j.wysocki> <15658107.tv2OnDr8pf@rafael.j.wysocki>
In-Reply-To: <15658107.tv2OnDr8pf@rafael.j.wysocki>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Sun, 28 Dec 2025 16:51:26 +0100
X-Gm-Features: AQt7F2q_cycC7hMecsrMvd9LXqesqMPWAqlcKFduTzmro2KUI5Ojv_wP0hLSjhg
Message-ID: <CAPDyKFrgXG5X-y0teE-wVvqaeNepStMN3=0M4zkZs8Kb88U22A@mail.gmail.com>
Subject: Re: [PATCH v1 19/23] pmdomain: imx: gpcv2: Discard pm_runtime_put()
 return value
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Brian Norris <briannorris@chromium.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Dec 2025 at 21:37, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Passing pm_runtime_put() return value to the callers is not particularly
> useful.
>
> Returning an error code from pm_runtime_put() merely means that it has
> not queued up a work item to check whether or not the device can be
> suspended and there are many perfectly valid situations in which that
> can happen, like after writing "on" to the devices' runtime PM "control"
> attribute in sysfs for one example.
>
> Accordingly, update imx_pgc_domain_suspend() to simply discard the
> return value of pm_runtime_put() and always return success to the
> caller.
>
> This will facilitate a planned change of the pm_runtime_put() return
> type to void in the future.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> This patch is part of a series, but it doesn't depend on anything else
> in that series.  The last patch in the series depends on it.
>
> It can be applied by itself and if you decide to do so, please let me
> know.
>
> Otherwise, an ACK or equivalent will be appreciated, but also the lack
> of specific criticism will be eventually regarded as consent.
>
> ---
>  drivers/pmdomain/imx/gpcv2.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> --- a/drivers/pmdomain/imx/gpcv2.c
> +++ b/drivers/pmdomain/imx/gpcv2.c
> @@ -1420,7 +1420,9 @@ static int imx_pgc_domain_suspend(struct
>
>  static int imx_pgc_domain_resume(struct device *dev)
>  {
> -       return pm_runtime_put(dev);
> +       pm_runtime_put(dev);
> +
> +       return 0;
>  }
>  #endif
>
>
>
>

