Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEE83E4F26
	for <lists+linux-pm@lfdr.de>; Tue, 10 Aug 2021 00:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236657AbhHIW1M (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Aug 2021 18:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233660AbhHIW1L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Aug 2021 18:27:11 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08D9C0613D3;
        Mon,  9 Aug 2021 15:26:50 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id p38so9658318lfa.0;
        Mon, 09 Aug 2021 15:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N/whK2ArPuahMrM2cd5J1XOG8XcsWkVdPG8JL6J/dco=;
        b=OQQoY9JTkgZ+eeE84IsXtazaykY74v6n1xmcL8OKEj6ywKOp1zCdL5ab06V8pH3GIh
         cHQELYZ6wlJsgt9bd+gql97JS+8HVdCFGID1ifmYnQP2W/dkpPFA4OT6fImuO9oSrYEs
         S3zEIJ5svweqcwgIkTOivpU7EptcUYX5DOpDAGVrojxHAomUD18vfM1TY/nWsSn3pp6k
         aKu8UA+vHPop+LyuB0GMrwotbuke9Vu7uM6eq91K8+kbgegPrJ5AIHuV3uDola7Jy1Zl
         ZvZ64p7hco2iUsaInMBfwHXUOaHpOSRZ+K6zpw0b724Wi9bj9vvMvOVDQss3DBGs/bFy
         AykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N/whK2ArPuahMrM2cd5J1XOG8XcsWkVdPG8JL6J/dco=;
        b=DW0W1w/UdchvZulvSrxoqZMkjOJT/QY7a08Bx7RqI0nAaL/SQbUP7ckLIcOQNdy3L6
         pUfBk0Qc2HcF3wRc5TJcfDconfGGjnaOFyAKahJG8ebtnyQpeS3GyxvGIA9AZiu8laLC
         1U6MiFF17tptvH88ucLmm+uUxZvRJ/hmjMLy6XQxqg6s7cuuh3S2shltkN6eSPF7q29y
         8U8DB+lLU27hR5adcd9AkfgWOdMI8qefkSSNJr0NuSj6NBVQzJJMwda8JDRiUE9+r/dr
         SrYqTRY9iwILNxsIrrO3+nadvlsSYwviQ/ZNqmK4gnHklI3hXlNGvR/gzK0lD3xzGQN7
         UTrA==
X-Gm-Message-State: AOAM530W6Nl0lZX95sfpUjiNnyBiU8m1k69gW8GT+tra9FA3Yaicx4L0
        ifzRnLnoXeSsdxqh8FMFXH/zsZI+9YY=
X-Google-Smtp-Source: ABdhPJxTvlD8j92g4+drEBzsM/F8WCazuqFL8+afwB97ArNej7RnaTkv8ZpdSztaBssc0qOsbQWPFA==
X-Received: by 2002:a05:6512:1281:: with SMTP id u1mr19456096lfs.136.1628548009126;
        Mon, 09 Aug 2021 15:26:49 -0700 (PDT)
Received: from [192.168.2.145] (46-138-117-53.dynamic.spd-mgts.ru. [46.138.117.53])
        by smtp.googlemail.com with ESMTPSA id g5sm1706297ljn.78.2021.08.09.15.26.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 15:26:48 -0700 (PDT)
Subject: Re: [PATCH v6 1/2] PM / Domains: Add support for 'required-opps' to
 set default perf state
To:     Rajendra Nayak <rnayak@codeaurora.org>, ulf.hansson@linaro.org,
        bjorn.andersson@linaro.org, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, rojay@codeaurora.org, stephan@gerhold.net
References: <1628074696-7979-1-git-send-email-rnayak@codeaurora.org>
 <1628074696-7979-2-git-send-email-rnayak@codeaurora.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <f58e631d-67a7-4981-ce59-6a4772b44564@gmail.com>
Date:   Tue, 10 Aug 2021 01:26:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1628074696-7979-2-git-send-email-rnayak@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

04.08.2021 13:58, Rajendra Nayak пишет:
> @@ -2637,6 +2643,8 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
>  {
>  	struct of_phandle_args pd_args;
>  	struct generic_pm_domain *pd;
> +	struct device_node *np;
> +	int pstate;
>  	int ret;
>  
>  	ret = of_parse_phandle_with_args(dev->of_node, "power-domains",
> @@ -2675,10 +2683,26 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
>  		genpd_unlock(pd);
>  	}
>  
> -	if (ret)
> +	if (ret) {
>  		genpd_remove_device(pd, dev);
> +		return -EPROBE_DEFER;
> +	}
> +
> +	/* Set the default performance state */
> +	np = dev->of_node;
> +	if (of_parse_phandle(np, "required-opps", index)) {
> +		pstate = of_get_required_opp_performance_state(np, index);
> +		if (pstate < 0) {
> +			ret = pstate;
> +			dev_err(dev, "failed to set required performance state for power-domain %s: %d\n",
> +				pd->name, ret);
> +		} else {
> +			dev_pm_genpd_set_performance_state(dev, pstate);
> +			dev_gpd_data(dev)->default_pstate = pstate;
> +		}
> +	}

Why performance state is set after genpd_power_on()?
