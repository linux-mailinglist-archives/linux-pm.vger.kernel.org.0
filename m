Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6087D3F25
	for <lists+linux-pm@lfdr.de>; Mon, 23 Oct 2023 20:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjJWSX7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Oct 2023 14:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233704AbjJWSX5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Oct 2023 14:23:57 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F7D9B
        for <linux-pm@vger.kernel.org>; Mon, 23 Oct 2023 11:23:54 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c523ac38fbso53296321fa.0
        for <linux-pm@vger.kernel.org>; Mon, 23 Oct 2023 11:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698085432; x=1698690232; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jH+xgTdGBybTpfmszxd0jH64ej1Z8AlGRUmXL3RZD+E=;
        b=TfLYPjNTO5DE3b2oOAeEdyXA6CjpxzFgEVtoXNy3TaUkCjIUIbI8KMANDCl+iK3hqv
         tI3PbDj5gYEXZN9dJ5cuJnBmE+xCXOllS/ddUX4zUNTuDOVtCwSwHhEJ+qee61F5fvEK
         ytSTfwad+RnSCxbmxIw8n+ZvgFomeML0+EzukGUZ9F5D3NcYEQMAQEjKKitPJlBcb37V
         FmtN9/CnpakyiOMdo1EGQWkygA67yK1SQTaGj24tbXGK8BBR5g24dGo8Qtu8gYpADxvL
         iYIAfTyGeFklyPyg2Z58tsmp6xgjpn/p6rey/dO23jtAOozZmbcNnw5G/j2QhUSC9ND8
         odnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698085432; x=1698690232;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jH+xgTdGBybTpfmszxd0jH64ej1Z8AlGRUmXL3RZD+E=;
        b=gGk1J6hU9G7J7R4mJgLLYHRoihLnX9nRJQ/XgFnI4PThIBHwR7mCEJaj2Ib2Vj2kmy
         04iZxaE6YK9P7ZU6jO/yrrBiY2CXMh94UotSknp5mZxJJ3tGo3UFlciMD3LliTHeFsAW
         jkCBGWF79mBvrEhcaqLtaxonIoiwkCNo1Qs03LHVRVQd7cVSLc7NXVirDYI4et13XWOi
         w9qeai0CsLxWOjwucwr+mbAzdLCbpe48ROXdpUhojItQWabWjfJ1v0V6EsYrp5zVUQMt
         7qapmb4JN1EppIEcZmYFRVZG6V2byy41geG4/+nQR1Z/d0k2JxelNI4KH33ovCdUK4Hy
         Y9RQ==
X-Gm-Message-State: AOJu0YxaI7rO9M3TuqA4ZUVZJ2rHkn7xfo6J5XdFepuX1/baf9MZ0Gzx
        iWIVT66VnRHQ9H41xiK/nTfg7w==
X-Google-Smtp-Source: AGHT+IEB5Xq1aY5x1xCr3qk4yDLLwsgqiYTB5BdIH+raasp//KeLJvmiD97BLkXk5ja6clWVenuP/A==
X-Received: by 2002:a2e:b00d:0:b0:2c5:260:1026 with SMTP id y13-20020a2eb00d000000b002c502601026mr6726112ljk.12.1698085432161;
        Mon, 23 Oct 2023 11:23:52 -0700 (PDT)
Received: from [192.168.198.23] ([37.166.19.143])
        by smtp.googlemail.com with ESMTPSA id m15-20020a7bcb8f000000b0040523bef620sm5242731wmi.0.2023.10.23.11.23.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 11:23:51 -0700 (PDT)
Message-ID: <3a70280b-8cc4-9f22-92b7-088fa9cb45df@linaro.org>
Date:   Mon, 23 Oct 2023 20:23:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 06/18] PM: EM: Check if the get_cost() callback is
 present in em_compute_costs()
Content-Language: en-US
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rafael@kernel.org
Cc:     dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        viresh.kumar@linaro.org, len.brown@intel.com, pavel@ucw.cz,
        mhiramat@kernel.org, qyousef@layalina.io, wvw@google.com
References: <20230925081139.1305766-1-lukasz.luba@arm.com>
 <20230925081139.1305766-7-lukasz.luba@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230925081139.1305766-7-lukasz.luba@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25/09/2023 10:11, Lukasz Luba wrote:
> The em_compute_cost() is going to be re-used in runtime modified EM
> code path. Thus, make sure that this common code is safe and won't
> try to use the NULL pointer. The former em_compute_cost() didn't have to
> care about runtime modification code path. The upcoming changes introduce
> such option, but with different callback. Those two paths which use
> get_cost() (during first EM registration) or update_power() (during
> runtime modification) need to be safely handled in em_compute_costs().
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>   kernel/power/energy_model.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index 7ea882401833..35e07933b34a 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -116,7 +116,7 @@ static int em_compute_costs(struct device *dev, struct em_perf_state *table,
>   	for (i = nr_states - 1; i >= 0; i--) {
>   		unsigned long power_res, cost;
>   
> -		if (flags & EM_PERF_DOMAIN_ARTIFICIAL) {
> +		if (flags & EM_PERF_DOMAIN_ARTIFICIAL && cb->get_cost) {
>   			ret = cb->get_cost(dev, table[i].frequency, &cost);
>   			if (ret || !cost || cost > EM_MAX_POWER) {
>   				dev_err(dev, "EM: invalid cost %lu %d\n",

I do believe & operator has lower precedence than && operator, thus the 
test is actually:

	(flags & (EM_PERF_DOMAIN_ARTIFICIAL && cb->get_cost))

but it should be

	((flags & EM_PERF_DOMAIN_ARTIFICIAL) && cb->get_cost)

Right ?

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

