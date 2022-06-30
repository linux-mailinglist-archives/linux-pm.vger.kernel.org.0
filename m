Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D661561A57
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jun 2022 14:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234222AbiF3McR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jun 2022 08:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233892AbiF3McQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jun 2022 08:32:16 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D854326D9
        for <linux-pm@vger.kernel.org>; Thu, 30 Jun 2022 05:32:15 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id z19so26296111edb.11
        for <linux-pm@vger.kernel.org>; Thu, 30 Jun 2022 05:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FH1dmQ709R2VSf2mvnu7DYhWX6Oar21XDZg9aQoTr74=;
        b=XGrUAX67r0UekoSEO8au/eqLvUD7116WgXJVOJ68fosqgMpw22F5WEvWujyUwVN76i
         r41E5mZbTh6Ly2NtxN3pa0EjX2s3IRU+CYPTfZN7+YvG30gCIDXi691JoM3WRr366fhP
         uQxcGSvPjZjA5Cn3JO/w/SBP9iQQbAafTUPswmv6se7LIBkXse7V+EOcguioNkaVhvh5
         PWhM6s8uXVkAxjSeWGdB+xMXhhElLPvc+l7B+YVz3FI4zJ7+WxxUND5Pyohuj347bkpj
         gwSNSMpQsDVPomGT2KrbI/RdtSyN52op5rv+OitgD8BuHXWKzV3hMhQoE3seTCQ/mNoh
         1OnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FH1dmQ709R2VSf2mvnu7DYhWX6Oar21XDZg9aQoTr74=;
        b=EgHoYFv+O0M1bZuQCUnlveUR/D3QjLIStgJabuyHcroUINLoNvhPS/T+bOlLQ1auSk
         NUXcXnH7AG4QKXqoIK9635YSVA6PZn3gA0P1k9g4pi8A2zmZfw3SA1LwjGjuQdFcbJyy
         9GKrTKTDKk0WUAGEnDna7gelVxMcCmAeaNVEGAEblaPrhi3HgUHN1MkTTCfWlT6tK67x
         BAy5GdWr/zofcuNzFGiHi0U9aDWKUxBS8+Zqms90uqH7QTGV7rtIFk3iKjPurnug4pbk
         NPDl9u7eHruYFNb+BfwXxjMIueh+FkZzZmZj77TvkW3JXGQ76b+OwmFY8k84w3dlmx0+
         5d2g==
X-Gm-Message-State: AJIora/ET8HegGy5vCxRrQ4LRaUtm76HDBU07rtmaj/KRm2ONE+WLKwB
        9S6AMqF/dnBVJ4qZwVZoWbbgPQ==
X-Google-Smtp-Source: AGRyM1tI2/+psZwC1mnT57Fie9c6NBf1xj0pZ536rIxb8B61E3Mgfynh8feDBZl+v+8a0VqZVz0euw==
X-Received: by 2002:a05:6402:84a:b0:423:fe99:8c53 with SMTP id b10-20020a056402084a00b00423fe998c53mr11596963edz.195.1656592333868;
        Thu, 30 Jun 2022 05:32:13 -0700 (PDT)
Received: from [192.168.0.189] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id ch25-20020a0564021bd900b00437e027fad9sm1984174edb.48.2022.06.30.05.32.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 05:32:13 -0700 (PDT)
Message-ID: <de13cca4-3a33-6482-7b02-f89796f45325@linaro.org>
Date:   Thu, 30 Jun 2022 14:32:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 5/8] OPP: Allow multiple clocks for a device
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
References: <cover.1654849214.git.viresh.kumar@linaro.org>
 <8b29fa207024dc295639f9ba52c28e45782e3baa.1654849214.git.viresh.kumar@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <8b29fa207024dc295639f9ba52c28e45782e3baa.1654849214.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/06/2022 10:20, Viresh Kumar wrote:
> This patch adds support to allow multiple clocks for a device.
> 
> The design is pretty much similar to how this is done for regulators,
> and platforms can supply their own version of the config_clks() callback
> if they have multiple clocks for their device. The core manages the
> calls via opp_table->config_clks() eventually.
> 
> We have kept both "clk" and "clks" fields in the OPP table structure and
> the reason is provided as a comment in _opp_set_clknames(). The same
> isn't done for "rates" though and we use rates[0] at most of the places
> now.
> 
> Co-developed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

(...)

> +	rates = kmalloc_array(count, sizeof(*rates), GFP_KERNEL);
> +	if (!rates)
> +		return -ENOMEM;
> +
> +	ret = of_property_read_u64_array(np, "opp-hz", rates, count);
> +	if (ret) {
> +		pr_err("%s: Error parsing opp-hz: %d\n", __func__, ret);
> +	} else {
> +		/*
> +		 * Rate is defined as an unsigned long in clk API, and so
> +		 * casting explicitly to its type. Must be fixed once rate is 64
> +		 * bit guaranteed in clk API.
> +		 */
> +		for (i = 0; i < count; i++) {
> +			new_opp->rates[i] = (unsigned long)rates[i];
> +
> +			/* This will happen for frequencies > 4.29 GHz */
> +			WARN_ON(new_opp->rates[i] != rates[i]);
> +		}
> +	}
> +
> +	kfree(rates);
> +
> +	return ret;
> +}
> +
>  static int _read_bw(struct dev_pm_opp *new_opp, struct opp_table *opp_table,
>  		    struct device_node *np, bool peak)
>  {
> @@ -812,19 +859,13 @@ static int _read_opp_key(struct dev_pm_opp *new_opp,
>  			 struct opp_table *opp_table, struct device_node *np)
>  {
>  	bool found = false;
> -	u64 rate;
>  	int ret;
>  
> -	ret = of_property_read_u64(np, "opp-hz", &rate);
> -	if (!ret) {
> -		/*
> -		 * Rate is defined as an unsigned long in clk API, and so
> -		 * casting explicitly to its type. Must be fixed once rate is 64
> -		 * bit guaranteed in clk API.
> -		 */
> -		new_opp->rate = (unsigned long)rate;
> +	ret = _read_rate(new_opp, opp_table, np);
> +	if (ret)
> +		return ret;
> +	else if (opp_table->clk_count == 1)

Shouldn't this be >=1? I got several clocks and this one fails.



Best regards,
Krzysztof
