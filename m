Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9F1E3BC89D
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jul 2021 11:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbhGFJrt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Jul 2021 05:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbhGFJrt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Jul 2021 05:47:49 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1802C06175F
        for <linux-pm@vger.kernel.org>; Tue,  6 Jul 2021 02:45:10 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id r9so8033930ual.7
        for <linux-pm@vger.kernel.org>; Tue, 06 Jul 2021 02:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BjBbfi2RNmcVVx+OZjQ54kvRjLU5Sn+0qOW7CMLxHks=;
        b=E9AuMGH8zkpgvvBARuyS0SNkn9TceuHekMom7egR70mJazxyIcBXV5+p0dzBRy9MGT
         JTNu3bFJgtZMi/LfxNC3X0aug/bgyICdLAXS2z2y731TbhdGLvvNqhRMHCKLFSI67W4n
         N0jyxo4q612Jyim4w/+t7Zhkvw4A0UscCVsDdufiEgON6TX7Nnfovo+/ihsjTPNUnB3j
         jqp1tIF4Z8tle7rQ6k6xwy2N5NWZpbci0fnsTnZ+skwURrYAcTbPEQgAkv5kArkUKOPh
         8/kuvt/IYDMBOktvdXTJnqxovXgtGKcTOEYdSBD7Z36fGeLEiD2WXYUX33I8eON4VnWY
         YKUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BjBbfi2RNmcVVx+OZjQ54kvRjLU5Sn+0qOW7CMLxHks=;
        b=CL5Uoz29e4PB1uPEoAdGg42UWpdF3ZghyUEImAj64/SrulVfUgzRfjNeACB549EyPp
         73F0AY8CEERp2bD7rOXg9Qd9hX7gcDxSJ6NVCdxRQusyrVBKK9LAAKKfCgGI9us04ieB
         3I/BDRigEUO/hYJtCYLpdEu3MYKsPy5STHwUR7Nm2utFIJg3S9xqG9kj9Ypc7C1YfLMt
         M0AykNF86FdvolLV7yNniuu/ysUxdfrpQr4Ah3Pu3hYgHnaJxB2oIKCn716Us7Hbvtmt
         BOuAC2Nq6yNh8skGPtDgzEmW+6Cwq7Q0F40xv3bHcONoxW+En+Z+k8m/RzeebzVbn6hx
         IV+A==
X-Gm-Message-State: AOAM533PsV1hNkJRM6qVzzuZFgNKBNjSwkFCPIl9KmiVg+yKrCksZq4F
        1ThrDIyCT4GUei90FgD/OoQsZAb/vrKuLEHrNz6PLy8rlNrPIXRy
X-Google-Smtp-Source: ABdhPJwYGhvDLu4e0EvpWOaU+dmg5k2mTYYcaweMuUIzw5yZ1neAn9aHVzSc6AEGAdE2Hb++mqLQGalI6cPHlDFfjmM=
X-Received: by 2002:ab0:76d0:: with SMTP id w16mr5916892uaq.15.1625564709056;
 Tue, 06 Jul 2021 02:45:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210706100519.13851-1-peng.fan@oss.nxp.com>
In-Reply-To: <20210706100519.13851-1-peng.fan@oss.nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 6 Jul 2021 11:44:32 +0200
Message-ID: <CAPDyKFo-r0b1+wwoAyi8VRQpeAbXaxnDeFXGrjZV-zaqWZ7ojQ@mail.gmail.com>
Subject: Re: [PATCH] PM: domains: not update genpd status when power on fail
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 6 Jul 2021 at 11:31, <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> When _genpd_power_on fail, the generic power domain status
> should not be changed to GENPD_STATE_ON.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/base/power/domain.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index ab0b740cc0f1..754a5d384479 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1101,6 +1101,7 @@ static void genpd_sync_power_on(struct generic_pm_domain *genpd, bool use_lock,
>                                 unsigned int depth)
>  {
>         struct gpd_link *link;
> +       int ret;
>
>         if (genpd_status_on(genpd))
>                 return;
> @@ -1117,8 +1118,9 @@ static void genpd_sync_power_on(struct generic_pm_domain *genpd, bool use_lock,
>                         genpd_unlock(link->parent);
>         }
>
> -       _genpd_power_on(genpd, false);
> -       genpd->status = GENPD_STATE_ON;
> +       ret = _genpd_power_on(genpd, false);
> +       if (!ret)

To support this error path, a lot more code needs to be added. Just
have a look at the callers of genpd_sync_power_on() and compare it
with genpd_power_on().

In my opinion, supporting this error path isn't really worth it, at
least until someone comes with a valid use case. Do you have one - or
did you send the $subject patch based solely on code inspection?

> +               genpd->status = GENPD_STATE_ON;
>  }
>
>  /**
> --
> 2.30.0
>

Kind regards
Uffe
