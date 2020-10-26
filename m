Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEAF29954D
	for <lists+linux-pm@lfdr.de>; Mon, 26 Oct 2020 19:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1784690AbgJZS2i (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Oct 2020 14:28:38 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34822 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1789754AbgJZS2i (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Oct 2020 14:28:38 -0400
Received: by mail-wr1-f66.google.com with SMTP id n15so13847377wrq.2
        for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2020 11:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=mb+VsFHRngfApGddoi/2+L16aEwwHQwxUiOwMEFXlgs=;
        b=RGM1glykpkt4WTtU0NYkRbCZ3MHwai/Vlg0W0CaowGOLq+YfJ6TaONum9cShrZq706
         JupbzNebx8SPwrqG+raIETfojDxCv9RakiErxnhOl5BcZvhZ2T2bVnFEzGvJhcHafkpE
         ayeayZio7irAins7HIVjUWJbVNhAdlpj7tnxKJ2bdB2CdzfMBa62FpflEQEwp2/ZGhL9
         Tawj33jgUZ/6IRz4p9U+sf66NfGKLepJ/TvBM1IM1qwufnh8u8RDNjs8rVfN9+RhBEJ8
         fO1O9CGJwTz0zuGkD4eHAUlJu+MDT4o3VTuZcYmqYMEvx0jngzQYw2vO5fINgjW2J7in
         IB9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mb+VsFHRngfApGddoi/2+L16aEwwHQwxUiOwMEFXlgs=;
        b=YN0n54Lcy//aWSr2e99kb8MOc8ZBYnauRYSV5KHs8DbMbB3E0SVrgD1+60l0qZ/sFz
         TBaz+O+4732r3lo4gF9lgtloeS7riY7iOxVDsOMKqfkozTvwjuth/ZNcfGZbQ0U1Hqn3
         cNCNBjwOAs22p2NkKn6V31q+JUJI1XcV5AS+yKko8IDFKKIGc0QGaVEFHct6yXaIV5Y5
         phHFdx3JUo+n9QNCl7WUfePN2RzzWARP03CX7VsPLL7KhsVer4rP5xPV8fsyHlegbm9Q
         WTuzXRbm2s1g1qDymm3abOFSuFvTR+DpoMUjV2828VDu8As42CWG6tGZN++flQ44zfzt
         Pnng==
X-Gm-Message-State: AOAM531/PE5l2v+A8SgIEoPobm5tE0TwG8MxnTlvZm8FC56ln/qfF+8W
        oVlF/H/PcfDi3SLpW3K10T40Eg==
X-Google-Smtp-Source: ABdhPJww28uZ2Nkj3wMRpn4zzf7WBx9d4uAn0PaVp+B407u7eD0AreOrs1BqGAazN7DcEVl/f/cNRw==
X-Received: by 2002:a5d:4802:: with SMTP id l2mr18697933wrq.282.1603736915868;
        Mon, 26 Oct 2020 11:28:35 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:54a1:359e:38ca:6e1? ([2a01:e34:ed2f:f020:54a1:359e:38ca:6e1])
        by smtp.googlemail.com with ESMTPSA id r1sm25662056wro.18.2020.10.26.11.28.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2020 11:28:35 -0700 (PDT)
Subject: Re: [PATCH] thermal: replace spin_lock_irqsave by spin_lock in hard
 IRQ
To:     Tian Tao <tiantao6@hisilicon.com>, niklas.soderlund@ragnatech.se,
        rui.zhang@intel.com, amitk@kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1603249530-25218-1-git-send-email-tiantao6@hisilicon.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <f8a32e99-c26f-ef93-1a6d-3b2e6b5ced29@linaro.org>
Date:   Mon, 26 Oct 2020 19:28:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1603249530-25218-1-git-send-email-tiantao6@hisilicon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21/10/2020 05:05, Tian Tao wrote:
> The code has been in a irq-disabled context since it is hard IRQ. There
> is no necessity to do it again.
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> ---

Whe resending with the log improved, please fix the subject:

thermal: rcar: Replace ...

Thanks

  -- Daniel

>  drivers/thermal/rcar_thermal.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
> index 5c2a13b..6ae757d 100644
> --- a/drivers/thermal/rcar_thermal.c
> +++ b/drivers/thermal/rcar_thermal.c
> @@ -409,16 +409,15 @@ static irqreturn_t rcar_thermal_irq(int irq, void *data)
>  {
>  	struct rcar_thermal_common *common = data;
>  	struct rcar_thermal_priv *priv;
> -	unsigned long flags;
>  	u32 status, mask;
>  
> -	spin_lock_irqsave(&common->lock, flags);
> +	spin_lock(&common->lock);
>  
>  	mask	= rcar_thermal_common_read(common, INTMSK);
>  	status	= rcar_thermal_common_read(common, STR);
>  	rcar_thermal_common_write(common, STR, 0x000F0F0F & mask);
>  
> -	spin_unlock_irqrestore(&common->lock, flags);
> +	spin_unlock(&common->lock);
>  
>  	status = status & ~mask;
>  
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
