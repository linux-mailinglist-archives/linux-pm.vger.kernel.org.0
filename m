Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77F65879A0
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2019 14:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406724AbfHIMRb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Aug 2019 08:17:31 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34327 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbfHIMRa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Aug 2019 08:17:30 -0400
Received: by mail-lj1-f194.google.com with SMTP id p17so91933287ljg.1;
        Fri, 09 Aug 2019 05:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2Y6cibe++jUg1MqhLsa4ocC0OGOAItgbasTPZNkc7eI=;
        b=Es6Xtux7P3VZubYU24Nu2MzcD53Hn5+4l+jctyBOlss37Ut6Fr35RRHB7rum14F/YO
         im/2vEWM/Mbwk86IrmWCV3j2JqQfZ18hNsJZtpnwc6KVv37RoYQuXP2le7U5Z90Pp7Tm
         UOrCh9NsBbBwrn1YVlm9icOVMh5XrQ0dbVE4/ZOcOrL866nFG/cDYJKlV59WH+SHYNSG
         h1SY+AmpqR6S1ouoiDNZ/6TbGvvZzCkAv6/ctDWfYBQvHxEbOFqvUsu7970eJZDtw+Oo
         yANlaSFTAl1ZaM5Nta13wmxvh1Z7/P6Py7s5kfj/2IKExjMyvVSdB6O4TNR+WSYavIun
         VitQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2Y6cibe++jUg1MqhLsa4ocC0OGOAItgbasTPZNkc7eI=;
        b=ttJsX8OESu7QANCrHv3lItf+z85Jh+j1qBRJxoCaZI8zLinz1ufMl+mV65Loi/JxaU
         MI0W+Nv7y2RlfwUbQC2JuR13Km4NxF8b3Vamt6T5pgQkdW23XhbOUQls+WWVntOn5cJO
         WRDCao7fLEO1pwL7CvJrEY6IT0lOcp1C7UdlGyMWL+/cx8Vl7LVXidafkxnq1izf7MBL
         AsHA63XsG2I52MvHm4HjkxfkaWnvlA20JYt3WpszBPzRNHUnkzbfBtLSy2+YNfReRrWi
         OkNb3+jm+Uu+YBxKHA5g7c9EtGl8bOC5VdLqdAM9JdNnlKdE8AGo93OxDdFqIQU2hwYs
         8S3A==
X-Gm-Message-State: APjAAAXfuR9FSRrPbHOQS4XOE7mXfEqeS6PTpHMKqafWY6ErY9DN51jg
        yNSgD6W+JBHoHJlHhum7M7QKuZr/
X-Google-Smtp-Source: APXvYqzCXqbF8YtE4fLH2dz9U0bvhopDeKHat7TwKL2v5Op5k+Prytgbyv6O6tgSJkzGbUcN7TNCCg==
X-Received: by 2002:a2e:93cc:: with SMTP id p12mr5978706ljh.11.1565353047460;
        Fri, 09 Aug 2019 05:17:27 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.34.218])
        by smtp.googlemail.com with ESMTPSA id g5sm19606366ljj.69.2019.08.09.05.17.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 05:17:26 -0700 (PDT)
Subject: Re: [PATCH v8 10/21] clk: tegra: clk-super: Add restore-context
 support
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
 <1565308020-31952-11-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <4e33bad9-8d5a-dcd7-c75e-db5843c9be4a@gmail.com>
Date:   Fri, 9 Aug 2019 15:17:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1565308020-31952-11-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

09.08.2019 2:46, Sowjanya Komatineni пишет:
> This patch implements restore_context for clk_super_mux and clk_super.
> 
> During system supend, core power goes off the and context of Tegra
> CAR registers is lost.
> 
> So on system resume, context of super clock registers are restored
> to have them in same state as before suspend.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/clk/tegra/clk-super.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/clk/tegra/clk-super.c b/drivers/clk/tegra/clk-super.c
> index e2a1e95a8db7..74c9e913e41c 100644
> --- a/drivers/clk/tegra/clk-super.c
> +++ b/drivers/clk/tegra/clk-super.c
> @@ -124,9 +124,18 @@ static int clk_super_set_parent(struct clk_hw *hw, u8 index)
>  	return err;
>  }
>  
> +static void clk_super_mux_restore_context(struct clk_hw *hw)
> +{
> +	struct clk_hw *parent = clk_hw_get_parent(hw);
> +	int parent_id = clk_hw_get_parent_index(hw, parent);
> +
> +	clk_super_set_parent(hw, parent_id);

All Super clocks have a divider, including the "MUX". Thus I'm wondering
if there is a chance that divider's configuration may differ on resume
from what it was on suspend.

> +}
> +
>  static const struct clk_ops tegra_clk_super_mux_ops = {
>  	.get_parent = clk_super_get_parent,
>  	.set_parent = clk_super_set_parent,
> +	.restore_context = clk_super_mux_restore_context,
>  };
>  
>  static long clk_super_round_rate(struct clk_hw *hw, unsigned long rate,
> @@ -162,12 +171,24 @@ static int clk_super_set_rate(struct clk_hw *hw, unsigned long rate,
>  	return super->div_ops->set_rate(div_hw, rate, parent_rate);
>  }
>  
> +static void clk_super_restore_context(struct clk_hw *hw)
> +{
> +	struct tegra_clk_super_mux *super = to_clk_super_mux(hw);
> +	struct clk_hw *div_hw = &super->frac_div.hw;
> +	struct clk_hw *parent = clk_hw_get_parent(hw);
> +	int parent_id = clk_hw_get_parent_index(hw, parent);
> +
> +	super->div_ops->restore_context(div_hw);
> +	clk_super_set_parent(hw, parent_id);
> +}
> +
>  const struct clk_ops tegra_clk_super_ops = {
>  	.get_parent = clk_super_get_parent,
>  	.set_parent = clk_super_set_parent,
>  	.set_rate = clk_super_set_rate,
>  	.round_rate = clk_super_round_rate,
>  	.recalc_rate = clk_super_recalc_rate,
> +	.restore_context = clk_super_restore_context,
>  };
>  
>  struct clk *tegra_clk_register_super_mux(const char *name,
> 

