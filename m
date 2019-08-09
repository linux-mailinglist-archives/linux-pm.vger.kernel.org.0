Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B49B687907
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2019 13:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406619AbfHILt3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Aug 2019 07:49:29 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45770 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405957AbfHILt3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Aug 2019 07:49:29 -0400
Received: by mail-lj1-f195.google.com with SMTP id t3so3281000ljj.12;
        Fri, 09 Aug 2019 04:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VCBhyo06VOEmixGYfFHSZZpvZroq28bWEJWhtoz6O4c=;
        b=dWfaV7hT+05xAtJIMVdIRiiOWSBqn+pUID6YcdCnSkYfiWa9pfF+VRmL570WdzqI84
         4YMkakT3NShSK+hqI7g6H4tmJLDAV1FR+jHwD9W209TXjix/x3HYK2zo1zkQrLv3iH1Z
         +u2GVS8Z4ESe7dUcj0sCzV9ctgDHXN2mPZh9UXNYMdkBZBdM1cQKnPYrM3I80AuDuufk
         kg3JP2HMfBslYiOEU0xqJKoDliBCVesm/zSdMuyd5ZHI7pLS+V6x58EuPj9ujmgSy589
         bgLkWSVYJ7XEmedVKeAKQIpZUVVbHPRlaz3hHP6nxefxcgiV0ENffdf436t9z64z1Xeb
         k/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VCBhyo06VOEmixGYfFHSZZpvZroq28bWEJWhtoz6O4c=;
        b=t4mBfzYptIGzolhBeRcktJXY1gQ5Y+4bBFAc3aERVLBHQkqRI/F1NqMDsESiMihVGa
         hUrW7+nKRN1RHlBE9To6+0chIjTEVv/0TxsOplxwHN2WvA+TBUQ2nJpy6ImeslKJfDvo
         KZrHjTCaPQ6PNLkthJwvIHNEWwng6lvq73rXDekp+2kaxF/4dx1LB+vz9z4UB3WjCQ1k
         3fu3AQwGy22k+OXIuG5bV+cwgd/sDQTg/sWHZ/WdKof2Ox7jmc7cdMYKDxF8mig2xkZU
         aMrH3E6IcgzMQLWRMTaNf17mqvJu45AUE41tnx5XyZ+Yy4czaQieuYSZi2Cz2W/jFY+S
         bnuw==
X-Gm-Message-State: APjAAAVWVds/czT0IS/r7/2pxRD+cMrQ2lRL3BT+EcEk5GkVoXoGMaB6
        YPhb+guoti0ZiKK3KCVV8/fgHKQf
X-Google-Smtp-Source: APXvYqwkvYftBGirDTu4du8iCwpltNlXO8U3J3ep5fExPc/o5Bhi52YocxePkxKNb4/qCn3O54NU2A==
X-Received: by 2002:a2e:8945:: with SMTP id b5mr10815467ljk.93.1565351366420;
        Fri, 09 Aug 2019 04:49:26 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.34.218])
        by smtp.googlemail.com with ESMTPSA id k27sm19148767lfm.90.2019.08.09.04.49.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 04:49:25 -0700 (PDT)
Subject: Re: [PATCH v8 07/21] clk: Add API to get index of the clock parent
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
 <1565308020-31952-8-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <311faac9-1dcc-19ee-4662-017d8d9c5918@gmail.com>
Date:   Fri, 9 Aug 2019 14:49:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1565308020-31952-8-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

09.08.2019 2:46, Sowjanya Komatineni пишет:
> This patch adds an API clk_hw_get_parent_index to get index of the
> clock parent to use during the clock restore operations on system
> resume.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/clk/clk.c            | 17 +++++++++++++++++
>  include/linux/clk-provider.h |  1 +
>  2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index c0990703ce54..f26252e48f73 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -1643,6 +1643,23 @@ static int clk_fetch_parent_index(struct clk_core *core,
>  	return i;
>  }
>  
> +/**
> + * clk_hw_get_parent_index - return the index of parent clock
> + * @hw: clk_hw associated with the clk being consumed
> + * @parent_hw: clk_hw associated with the parent of clk
> + *
> + * Fetches and returns the index of parent clock.
> + * if hw or parent_hw is NULL, returns -EINVAL.
> + */
> +int clk_hw_get_parent_index(struct clk_hw *hw, struct clk_hw *parent_hw)
> +{
> +	if (!hw || !parent_hw)
> +		return -EINVAL;
> +
> +	return clk_fetch_parent_index(hw->core, parent_hw->core);
> +}
> +EXPORT_SYMBOL_GPL(clk_hw_get_parent_index);
> +
>  /*
>   * Update the orphan status of @core and all its children.
>   */
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 2ae7604783dd..477112946dd2 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -817,6 +817,7 @@ unsigned int clk_hw_get_num_parents(const struct clk_hw *hw);
>  struct clk_hw *clk_hw_get_parent(const struct clk_hw *hw);
>  struct clk_hw *clk_hw_get_parent_by_index(const struct clk_hw *hw,
>  					  unsigned int index);
> +int clk_hw_get_parent_index(struct clk_hw *hw, struct clk_hw *parent_hw);
>  unsigned int __clk_get_enable_count(struct clk *clk);
>  unsigned long clk_hw_get_rate(const struct clk_hw *hw);
>  unsigned long __clk_get_flags(struct clk *clk);
> 

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
