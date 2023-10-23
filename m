Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF117D3DF2
	for <lists+linux-pm@lfdr.de>; Mon, 23 Oct 2023 19:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbjJWRj4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Oct 2023 13:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjJWRj4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Oct 2023 13:39:56 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6736394
        for <linux-pm@vger.kernel.org>; Mon, 23 Oct 2023 10:39:53 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c50906f941so54395601fa.2
        for <linux-pm@vger.kernel.org>; Mon, 23 Oct 2023 10:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698082791; x=1698687591; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kNQwyaGuIu7F+p1B5DfVkuQ0+sVIXi1xDTFxBww6HMA=;
        b=xtjytsbA95msPyo7nVmtcboi3OOTLSfzrYxFRMTxtVpcEL0GBIw9mX4CfxOpuGTRbW
         Jsn3+jBGAt4NYgMezVRzt2O7N+PuwfgdqKqe/GQkIc7DV+Or24kl08aO3OEYJmAMW16/
         ITDI/WrA1hc3cCbuH4doBxDj5ID8NcHQZvcJcUmXaRHMx0JsDf43PtJ+VOIaMW5ovZFP
         H2G/hFAhgxzlc6kMWOzY90OSQNxflXGvkm+ycUV8MJVCTc7jIG2lHGG4BIq50u2h7mHG
         T0ENJRHq3mQymexePM34nrbXaxaWn6OgWmIml/edi1lYD67etNMxT/CfFm5TH8Mas8eX
         3U+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698082791; x=1698687591;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kNQwyaGuIu7F+p1B5DfVkuQ0+sVIXi1xDTFxBww6HMA=;
        b=kJm9QHGZ4jUcdlQM45BNnqfieOh+tp26pAxsDcHbfkbukVVAbYx6sDP2iiDeHtc5Dn
         TOsqhTSyppeHCASfxNDSKFEYg3lE6251pwR5hkgQmlUfa7VVOL2cFsFkUvumXsgR+eX6
         h4Q/Il976iziQjFLrQVUpC5YvLCCrHjpk/daspfod3LpG0X7YzDVAZwbvnYY8zloXzEb
         XFbPA4uYLciP44/PsoMrAWOCbFtxfnMhfO6dukHLnVPBBQAOHH2Zf9l5QAwIKN5BIx2o
         tPE81B9QeumwLU0/F0UBLyZ32R8cjupEUdXPk/U/pYGyz6g9IaTd5w9Wb9qasK35p1oj
         q+vw==
X-Gm-Message-State: AOJu0Yx0VHEEz8dRXAIcOF+ms1mt+mFtkTcbe3yilymQjph7Vs/HjEQY
        c7FN0ubaezFvE6XBywUBQ9PPYw==
X-Google-Smtp-Source: AGHT+IE2Gp3uEgKdpVzP2c8Nh09UF311aX6kJy+WK6Ue579tldWifxjRJ+DxmRdC5cBR70cy9iTb6w==
X-Received: by 2002:a2e:7a0d:0:b0:2c5:40a:5d92 with SMTP id v13-20020a2e7a0d000000b002c5040a5d92mr6557526ljc.28.1698082791553;
        Mon, 23 Oct 2023 10:39:51 -0700 (PDT)
Received: from [192.168.198.23] ([37.166.25.68])
        by smtp.googlemail.com with ESMTPSA id n35-20020a05600c3ba300b003fef5e76f2csm4485092wms.0.2023.10.23.10.39.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 10:39:51 -0700 (PDT)
Message-ID: <6786c91e-12ce-a9dd-12fe-bc02c6d782b8@linaro.org>
Date:   Mon, 23 Oct 2023 19:39:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 04/18] PM: EM: Refactor em_pd_get_efficient_state() to
 be more flexible
Content-Language: en-US
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rafael@kernel.org
Cc:     dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        viresh.kumar@linaro.org, len.brown@intel.com, pavel@ucw.cz,
        mhiramat@kernel.org, qyousef@layalina.io, wvw@google.com
References: <20230925081139.1305766-1-lukasz.luba@arm.com>
 <20230925081139.1305766-5-lukasz.luba@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230925081139.1305766-5-lukasz.luba@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25/09/2023 10:11, Lukasz Luba wrote:
> The Energy Model (EM) is going to support runtime modification. There
> are going to be 2 EM tables which store information. This patch aims
> to prepare the code to be generic and use one of the tables. The function
> will no longer get a pointer to 'struct em_perf_domain' (the EM) but
> instead a pointer to 'struct em_perf_state' (which is one of the EM's
> tables).
> 
> Prepare em_pd_get_efficient_state() for the upcoming changes and
> make it possible to re-use. Return an index for the best performance
> state for a given EM table. The function arguments that are introduced
> should allow to work on different performance state arrays. The caller of
> em_pd_get_efficient_state() should be able to use the index either
> on the default or the modifiable EM table.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---

[ ... ]

> @@ -251,7 +253,9 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
>   	 * Find the lowest performance state of the Energy Model above the
>   	 * requested frequency.
>   	 */
> -	ps = em_pd_get_efficient_state(pd, freq);
> +	i = em_pd_get_efficient_state(pd->table, pd->nr_perf_states, freq,
> +				      pd->flags);

nitpicking but s/i/state/

Other than that:

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>


> +	ps = &pd->table[i];
>   
>   	/*
>   	 * The capacity of a CPU in the domain at the performance state (ps)

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

