Return-Path: <linux-pm+bounces-8624-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 633068FC872
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 11:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 877321C222CD
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 09:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A412B190060;
	Wed,  5 Jun 2024 09:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pg2ZQQSu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC6A19006D
	for <linux-pm@vger.kernel.org>; Wed,  5 Jun 2024 09:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717581490; cv=none; b=eF454mRZEpEGzNGIWcVSHLcJJOw2Jzz+UMQuaWnXslvlqL4oPV5Hbo64IuomGAP4fE18rJdt0CoXb+DFrXgKNt/hKTGaKLVTSKQX1XpACBMrs+usjE38s5Fd4wHxL2dMvHPKxd8qm89yNg5nUsm51hDhduY5w+cKMaSLcKOshOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717581490; c=relaxed/simple;
	bh=Tt2tgNpkn2du7bsn/n2t2j3ArXn3CGab9XDkz5yvA9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VlY4ozzE86rZZ/tSvrZWZ5f9UI9xi8oU8vnxdonI4yqQeDu35OSKCCGWIB9oPxmsdwzm805PHUjFzWzBZO24YAknxTjlr2N8ilU/A0uKuT8LgAIeUGY3JGurV6vBtRqQsohou+qWT4f4ylr78g4jeES/hX9rdn2T4RHETsBnCCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Pg2ZQQSu; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dfa5b9274feso7183894276.2
        for <linux-pm@vger.kernel.org>; Wed, 05 Jun 2024 02:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717581487; x=1718186287; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r+9F1BCoR5KjTer6dWZ2JEeUxzIQo5D1fqe1jFxzvAI=;
        b=Pg2ZQQSuycMcnB8D01ksAVgStixy+YthwF147zECK4WXB8CJc2oCjy6MWXD46IYCOk
         Z3+Zxd+Eg2+houXco8J63wZbDoLdzl4etzZU3dLtjfJ/c7Enku+JrFFT4WQEFOiIGVh7
         L736I0NE9N5W5iCupffZ99LNAMdrp4+q5Fy6AoNFByF4DoqXL5N1RaBhygMtcHsd9SnC
         DaTFEnGqGUl0BzpdFhuUQ+BkNsoVly+H3lDBpI/QxHiTL1CBTv4rEkTe8YVaXRWgaLS9
         NBhOm0EUO8p6LZYprnEf4HuE5ZneGi5bJCPb1hyCfyI6ey7QOV3hSkLIwPynkWrHSmbV
         bqgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717581487; x=1718186287;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r+9F1BCoR5KjTer6dWZ2JEeUxzIQo5D1fqe1jFxzvAI=;
        b=GQuoMZ+MD8LeRvuI1dI1ZWWVtSsSL64+nr+SG/H3Evqt8VlZW5uy6MD3HEGwiYZSRv
         sPWT5JtwH5uUs0kl2G8YIw8sQ1QduBchTILeOYJFr81myw6e4Hyd644c048+k/9gnGhm
         noW2mZP3BHYHBD+I47z27SjoVr2784y4nyYawTrMnMyG3NUYlFKn4iDn4Pt/8181f/zn
         I4xruxpl/co6i7ty5JQ0ERhdAPilwthIaaLrrH9tiGSQyuGL1QW1NdjV3N9o8PKf+5dr
         11L9v5Xt/ALTVbL9y3Mk9q5VaJ3jIDh3OHBG8r26+1BR8owE9Sip4laPKaOYINO4mm3W
         b5mA==
X-Forwarded-Encrypted: i=1; AJvYcCVzj3tMPKCM7bxf8kBKIHpJRdZI4Eta9cikMbf9jU8QZoVcdtPrjugf+TjMsipMbeZlIcNo0B6IcAwMoqlw/YuDefGCX1Q0cuU=
X-Gm-Message-State: AOJu0YxSamJbGyp5bMIRq0KaT2+r52T/1zB7Ip9/AVqBhDUqmAlir35r
	tkIdjWlSUMJVwvnVkBllRSW6dIHaVw0jL1uyY10OA+xqL3KotpHgag7IW0/t/aoMEuclyzWezWF
	/ox5197DV+IGNppKq0SRryXOuEHTIBvL1kbf4Hw==
X-Google-Smtp-Source: AGHT+IE16F2JSKPh/JoHkBR3fjToIQEuSas1q7YcIfL6CuxcxUsrv2g6I96PRBF563ZyDJHB85oUxFS990MWpkQ8Y8k=
X-Received: by 2002:a25:868d:0:b0:dfa:c66c:e2e with SMTP id
 3f1490d57ef6-dfacab2c785mr1891853276.5.1717581486811; Wed, 05 Jun 2024
 02:58:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3cd8131b4f1284bdffa23a2b6a9a1e92fd17973e.1716973951.git.geert+renesas@glider.be>
In-Reply-To: <3cd8131b4f1284bdffa23a2b6a9a1e92fd17973e.1716973951.git.geert+renesas@glider.be>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 5 Jun 2024 11:57:30 +0200
Message-ID: <CAPDyKFq+gJXrR6xTWzzoDgkwrgg9XL7+ugDA=zjS1pEr5-xATg@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: core: Use genpd_is_irq_safe() helper
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lina Iyer <lina.iyer@linaro.org>, linux-pm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 May 2024 at 11:19, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> Use the genpd_is_irq_safe() helper instead of open-coding the same
> operation.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index 1eae7b2317897f0b..01cf17789621a04f 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -2082,7 +2082,7 @@ static void genpd_free_data(struct generic_pm_domain *genpd)
>
>  static void genpd_lock_init(struct generic_pm_domain *genpd)
>  {
> -       if (genpd->flags & GENPD_FLAG_IRQ_SAFE) {
> +       if (genpd_is_irq_safe(genpd)) {
>                 spin_lock_init(&genpd->slock);
>                 genpd->lock_ops = &genpd_spin_ops;
>         } else {
> --
> 2.34.1
>

