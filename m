Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0100C878DD
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2019 13:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406609AbfHILjh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Aug 2019 07:39:37 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43345 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbfHILjg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Aug 2019 07:39:36 -0400
Received: by mail-lj1-f193.google.com with SMTP id y17so67246712ljk.10;
        Fri, 09 Aug 2019 04:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AQJyB8h4B7rOWZbk5WXfwukwf2zyCOzcC9K/huoManI=;
        b=H0Xa35QGHgBqAsebCDW9Dn/N5OmODk95lSH57TnY2TIdEZ6gE2Drtibg07AxHtpsHP
         RxdKMCD0dtERN5sFIBQRIzyZg3Ki0c2joQ7IdkgpH2IBBykAANExfqkZIClV8rzCG0JR
         M6Hgzgh1pGOXCcDTySVShrotrCoM9Xk5z75EBeFIwYqpVDw18ZLnLZ0eBpC8DExWsX2E
         JFwiyd2R6Xy5Pjn1h+BURTU86IqXxmYbcn1TbV4uI77VngstOxlZCdMaYWigNfUUsckf
         30ru51gn541989iet0WsUqIM8FFdOXVBEQ6KDASRmvNS9g5y1jCqAopYdJX3g5HmiLWJ
         ypAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AQJyB8h4B7rOWZbk5WXfwukwf2zyCOzcC9K/huoManI=;
        b=glu8pKjIHHXyO1mZV4y21JEiRXP8cb6A2IrlbLXDcE5BH7wxg/Lze5zN6BNAI/nHkn
         9GK6oXgsyTjHjQJFD8rO3Bu2qdalVq9ODqA8NtZtFuiEhXN634YtvsTQEzCuhKUHh9JQ
         NzrKTWIYDHr6vidFItOQ2KFnb1P4Vb3N+icTZAkgTw5jF7R2BJ6v9am4kyHdBRP312j0
         iWKyq4s3/nHePhVZeikOKRluipAij12HUpnet46bR59lCA9kFbD4sCurpbn1wE3IO63p
         rX2nFTG4S3JuNkB3QaI8pNFiR5iG1DG6K7BHKEajLGGWcmzZ/vnMzC/H2nNfkxn7b+D4
         8eVA==
X-Gm-Message-State: APjAAAU2v6gZyzrvZydyfpXYW7V5y3osCyilV22H5+6aAhHMmm3LaLDh
        //e4A0b7CGHFsa3zksODbHPAJGJH
X-Google-Smtp-Source: APXvYqysTFs3vR72El2ESsAVoDjXGL13f7YH0IhJmCSoNL/XhcpTMUDHfPKD3pLu3UIlhqnr2Cg68A==
X-Received: by 2002:a2e:93c8:: with SMTP id p8mr10954071ljh.6.1565350773511;
        Fri, 09 Aug 2019 04:39:33 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.34.218])
        by smtp.googlemail.com with ESMTPSA id 141sm450768ljf.32.2019.08.09.04.39.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 04:39:32 -0700 (PDT)
Subject: Re: [PATCH v8 02/21] pinctrl: tegra: Add write barrier after all
 pinctrl register writes
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
 <1565308020-31952-3-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <c71faafa-51db-f11a-1e56-c4b79a7468d1@gmail.com>
Date:   Fri, 9 Aug 2019 14:39:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1565308020-31952-3-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

09.08.2019 2:46, Sowjanya Komatineni пишет:
> This patch adds write barrier after all pinctrl register writes
> during resume to make sure all pinctrl changes are complete.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/pinctrl/tegra/pinctrl-tegra.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pinctrl/tegra/pinctrl-tegra.c b/drivers/pinctrl/tegra/pinctrl-tegra.c
> index 982ee634b3b1..f49fe29fb6df 100644
> --- a/drivers/pinctrl/tegra/pinctrl-tegra.c
> +++ b/drivers/pinctrl/tegra/pinctrl-tegra.c
> @@ -677,6 +677,8 @@ static int tegra_pinctrl_resume(struct device *dev)
>  			writel_relaxed(*backup_regs++, regs++);
>  	}
>  
> +	/* make sure all the pinmux register writes are complete */
> +	wmb();
>  	return 0;
>  }
>  
> 

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
