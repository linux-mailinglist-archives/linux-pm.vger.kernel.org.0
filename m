Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80CDD44000F
	for <lists+linux-pm@lfdr.de>; Fri, 29 Oct 2021 18:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbhJ2QLa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Oct 2021 12:11:30 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:34802 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbhJ2QL1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Oct 2021 12:11:27 -0400
Received: by mail-oi1-f178.google.com with SMTP id w193so14075655oie.1;
        Fri, 29 Oct 2021 09:08:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yd9yTVl0mzMu8CxNtY/NSg2Fd5BmOwS2ev++cNAViEI=;
        b=UfVyve/AcWDCDtHCG3v/7H5+l2pevJufm0Zf9AxbY86e/vG4WtdXkKP4Wh8M2zpcjM
         CtZGfxr9dU5aoon8ZGgBO2wowHhd7FUhKqepJws06IX6VV+3Yx9dlmAd/EQ6SDUmCsL2
         Zo0gbvZNbuUr3pq071ThkvTelh9o3MAqyQQw1SjglwDICsMxeRvViTsru/2jWq9JtHkN
         8EiBdFccF6CB7Ip96WtHuaM1RE1xcTsgT99SS402xs3TKr6ELjdBtsWj4yk2suKRAWIo
         IuZeCiVRJVYdIgcPpv065vArP18a+mEaX+jdlIrq6l3zViAd40vS3XD/sKmrDETtOwFB
         8sfQ==
X-Gm-Message-State: AOAM531LRU81WkJCi2nSFXL33SAlPO1wbflrCbXFTo4IqK+uTeaD+t6M
        Gz2JuTRkUrdHMbfOi1Qy3Pzb74C6M5EjwfdcD1A=
X-Google-Smtp-Source: ABdhPJxt4MrRv0+zcRik2HyFB0+2oqvoK0S6Fa/NvTCUMdlq5bduCS7QsLm/TXBu76wwyRLDWsktYueSaNNKTJ5sLoo=
X-Received: by 2002:a05:6808:e90:: with SMTP id k16mr8544666oil.166.1635523739007;
 Fri, 29 Oct 2021 09:08:59 -0700 (PDT)
MIME-Version: 1.0
References: <1635391292-2879179-1-git-send-email-jiasheng@iscas.ac.cn>
In-Reply-To: <1635391292-2879179-1-git-send-email-jiasheng@iscas.ac.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 29 Oct 2021 18:08:48 +0200
Message-ID: <CAJZ5v0iGmVRjwDTUPvfWcf_3t=NHLT_t-dN_4TX2N3-LxJX_Kg@mail.gmail.com>
Subject: Re: [PATCH] thermal: Fix implicit type conversion
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     "Zhang, Rui" <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 28, 2021 at 5:22 AM Jiasheng Jiang <jiasheng@iscas.ac.cn> wrote:
>
> The parameter 'cpu' is defined as unsigned int.
> However in the cpumask_next() it is implicitly type conversed
> to int.
> It is universally accepted that the implicit type conversion is
> terrible.
> Also, having the good programming custom will set an example for
> others.
> Thus, it might be better to change the type of 'cpu' from
> unsigned int to int.
>
> Fixes: 3e8c4d3 ("drivers: thermal: Move various drivers for intel platforms into a subdir")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  drivers/thermal/intel/intel_powerclamp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
> index b0eb5ec..ed46b5e 100644
> --- a/drivers/thermal/intel/intel_powerclamp.c
> +++ b/drivers/thermal/intel/intel_powerclamp.c
> @@ -578,7 +578,7 @@ static int powerclamp_cpu_online(unsigned int cpu)
>         return 0;
>  }
>
> -static int powerclamp_cpu_predown(unsigned int cpu)
> +static int powerclamp_cpu_predown(int cpu)
>  {
>         if (clamping == false)
>                 return 0;
> --

I'm not going to consider any patches of this type, because IMO they
are not improvements.

Thanks!
