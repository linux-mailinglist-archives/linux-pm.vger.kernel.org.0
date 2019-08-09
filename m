Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAB8878D5
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2019 13:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406582AbfHILjA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Aug 2019 07:39:00 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33227 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406550AbfHILjA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Aug 2019 07:39:00 -0400
Received: by mail-lj1-f194.google.com with SMTP id z17so3349911ljz.0;
        Fri, 09 Aug 2019 04:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jDJVABbE7QjcU+mBIQ+zrFhm3muZXA8d67yINbJkGx8=;
        b=qY8quRX6czxpIVO/UyLxGGZxaQxcDuNfImzT7mKj5EEf7dtKCPAlhw4QZ1gRU97LqO
         Aq26UYW1ci/IT1NLCkTagrzp1XQ0G9yPy1jywrqCW7bfA5UoD1FVW+EBor6mFyducJRg
         pabqx3tAly+6FzqF96+FPxXi/sQV2/jq6dbtJX4FjgyAsypRZNGAnpGEgI30TtuIpG9+
         BNFKhI/KHqFE52/6iX/5Iv+fWDoTH+Ou4f5IKd7+Yj4wFhcvsmyD/HRwWM4wGhCpQhEV
         r1nML0hToW+TlD0tTnZloGMvxypGq4Kz+kuFGfZlGfVQw5m0XggX5g3vFgRHNFWjsj00
         Yh1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jDJVABbE7QjcU+mBIQ+zrFhm3muZXA8d67yINbJkGx8=;
        b=T4GZ+p9XOdre4ODk3Ho97IEW99JVnZ9ueU/hnvEQ/pVX8Pu/HhgFd7lQreCk6hesC8
         T8z4wcRoWjYAlT51DrBitplY3RvabCHXuGWrtjEsgRamz6PEaeNgClOQztgxZZi6VJ4b
         +S9RBr9xIxY2QvwNlX0/fUVVYhFv1lC/tzTrmUL+8Jw9hF0LgQIFQcLzrzk5fRYi2/Pp
         bo9pHHL1qKld5pPyqwnOl6Pq4lUglRtH8o3dQMwx/aNPXz7ehcJJQ6O1NPfORYl9op1x
         1L9uv60ZgttNqw7S8aX1C615N9POeIw41qbOEd9/2zLbAlaINWL90JO+eXpRUsl7hJh9
         uOcw==
X-Gm-Message-State: APjAAAXWAp/P4OwNir5nwtp7qXg3RiE+AEixXaPsOtu3jAD45B6p/ZJd
        UOGSqRX8nJMhaphSbgpN+dQpnqk+
X-Google-Smtp-Source: APXvYqw6zmnGz5vd8ob1ec0PDqYiDbVvdlAz8Fsv1WOfJtP26F/bP23KtXAyMEoNf26u0xdAfwFW5Q==
X-Received: by 2002:a2e:5b94:: with SMTP id m20mr10895600lje.7.1565350736887;
        Fri, 09 Aug 2019 04:38:56 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.34.218])
        by smtp.googlemail.com with ESMTPSA id g12sm3320968lfc.96.2019.08.09.04.38.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 04:38:56 -0700 (PDT)
Subject: Re: [PATCH v8 01/21] pinctrl: tegra: Fix write barrier placement in
 pmx_writel
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com, tglx@linutronix.de,
        jason@lakedaemon.net, marc.zyngier@arm.com,
        linus.walleij@linaro.org, stefan@agner.ch, mark.rutland@arm.com
Cc:     pdeschrijver@nvidia.com, pgaikwad@nvidia.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        jckuo@nvidia.com, josephl@nvidia.com, talho@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        mperttunen@nvidia.com, spatra@nvidia.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, linux-pm@vger.kernel.org
References: <1565308020-31952-1-git-send-email-skomatineni@nvidia.com>
 <1565308020-31952-2-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <a8b0c979-de6f-16d0-5e46-436a1a6ced8c@gmail.com>
Date:   Fri, 9 Aug 2019 14:38:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1565308020-31952-2-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

09.08.2019 2:46, Sowjanya Komatineni пишет:
> pmx_writel uses writel which inserts write barrier before the
> register write rather.
> 
> This patch has fix to replace writel with writel_relaxed followed
> by a write barrier to ensure write operation before the barrier
> is completed for successful pinctrl change.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/pinctrl/tegra/pinctrl-tegra.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/tegra/pinctrl-tegra.c b/drivers/pinctrl/tegra/pinctrl-tegra.c
> index e3a237534281..982ee634b3b1 100644
> --- a/drivers/pinctrl/tegra/pinctrl-tegra.c
> +++ b/drivers/pinctrl/tegra/pinctrl-tegra.c
> @@ -32,7 +32,9 @@ static inline u32 pmx_readl(struct tegra_pmx *pmx, u32 bank, u32 reg)
>  
>  static inline void pmx_writel(struct tegra_pmx *pmx, u32 val, u32 bank, u32 reg)
>  {
> -	writel(val, pmx->regs[bank] + reg);
> +	writel_relaxed(val, pmx->regs[bank] + reg);
> +	/* make sure pinmux register write completed */
> +	wmb();
>  }
>  
>  static int tegra_pinctrl_get_groups_count(struct pinctrl_dev *pctldev)
> 

But this only ensures that CPU have sent the write to the APB BUS and
not that the write actually taken into effect? I'm a bit paranoid when
it comes to a cross-domain synchronization things.

Any ways it looks better than it was before.

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
