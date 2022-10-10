Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47CB5F97F7
	for <lists+linux-pm@lfdr.de>; Mon, 10 Oct 2022 07:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbiJJFzm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Oct 2022 01:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbiJJFzi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Oct 2022 01:55:38 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78021CB24
        for <linux-pm@vger.kernel.org>; Sun,  9 Oct 2022 22:55:33 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id f140so9934325pfa.1
        for <linux-pm@vger.kernel.org>; Sun, 09 Oct 2022 22:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KuJs/6I+cN8TE2/6QkPMYCE4khGiwZOavYjTwbehxuU=;
        b=oJQSUhOY41s4B4a5RIRgnQyLQDX5ZdWQabFA8tjd157D0kcEfoz+mrJb02795fSz1U
         v/8YOvuNw/4ZwwhOGH0rnT97Hzbeu2OUgEC0eZNRVtrHeXAjlxc9WVOcxeALpumO4Swi
         yTuk7U3DJQop54GqVbmbHnmKkFSw/aBhpucDHzb5d9IjKGnX3LUSzqhgSkvWLdggFpei
         wiFIAH+ABO7JL6Sr+ALGdUFC15iNsx2qYJJsV0dZqp4L3OrbJEmGPjgZV1+4eBBQFnoN
         TcEk0KNUxWAMX1SBlHLKN7gybqOQPMReYefd+Sgo/QTTQx/Nn2idmjhXLmzbkmZSaxNL
         nWew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KuJs/6I+cN8TE2/6QkPMYCE4khGiwZOavYjTwbehxuU=;
        b=ubqv6L9u0lGiQBgEIti6hz2JxSd//zLcnVbJhUphqYXH3mA1kh7L7rpf22WcfKmmCI
         tJQnP9umn98/8OE1DDatRR0gGdzjuOCsOlInIT1tzHXW2EinwPLmH122LoqblZqcgf/h
         M4skFQdYp6dddXXzw31G5vEkAgh8Zk81Gz55BpNiyXWyPux/0kP0GRwk3UcGlX8nnwyk
         zRbUTWrzHgIEKQdnd4ikjGEuDdLlM98oQCpXYZghpcaL7z5IalWwUB0HjB3HP+fyqQ8X
         yf+v8A06lDR6Be9XLW4XDbzaaMZfRAcPtF37Cuc+3009dG9FcyCUrxsAG+sbMa3bgkXR
         JzzQ==
X-Gm-Message-State: ACrzQf3c7PupvZYUR1mxQoDYDbAciJkrKvOGpzorAD8bfqKm1LqADXO5
        Z85YM3fQNw5MqcPTKok3sik82Q==
X-Google-Smtp-Source: AMsMyM5SRJNrvGYj1V4EedkIj4QZPS8xER6LRPxu2Ofd5vGxJrAifc97ZTOl/4hKrZ38fLgluMrqgw==
X-Received: by 2002:a05:6a00:1814:b0:563:6bd7:f9e0 with SMTP id y20-20020a056a00181400b005636bd7f9e0mr2553668pfa.33.1665381333058;
        Sun, 09 Oct 2022 22:55:33 -0700 (PDT)
Received: from localhost ([122.172.86.128])
        by smtp.gmail.com with ESMTPSA id a29-20020a631a1d000000b0045c5a749a8fsm5410093pga.61.2022.10.09.22.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 22:55:32 -0700 (PDT)
Date:   Mon, 10 Oct 2022 11:25:30 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Fabien Parent <fabien.parent@linaro.org>
Cc:     ilia.lin@kernel.org, agross@kernel.org, bjorn.andersson@linaro.org,
        rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] cpufreq: qcom: fix memory leak in error path
Message-ID: <20221010055530.2mf6lq4mn6zfdkzt@vireshk-i7>
References: <20221001171027.2101923-1-fabien.parent@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221001171027.2101923-1-fabien.parent@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01-10-22, 19:10, Fabien Parent wrote:
> If for some reason the speedbin length is incorrect, then there is a
> memory leak in the error path because we never free the speedbin buffer.
> This commit fixes the error path to always free the speedbin buffer.
> 
> Signed-off-by: Fabien Parent <fabien.parent@linaro.org>
> ---
>  drivers/cpufreq/qcom-cpufreq-nvmem.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> index 863548f59c3e..3bd38acde4b9 100644
> --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> @@ -213,6 +213,7 @@ static int qcom_cpufreq_krait_name_version(struct device *cpu_dev,
>  	int speed = 0, pvs = 0, pvs_ver = 0;
>  	u8 *speedbin;
>  	size_t len;
> +	int ret = 0;
>  
>  	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
>  
> @@ -230,7 +231,8 @@ static int qcom_cpufreq_krait_name_version(struct device *cpu_dev,
>  		break;
>  	default:
>  		dev_err(cpu_dev, "Unable to read nvmem data. Defaulting to 0!\n");
> -		return -ENODEV;
> +		ret = -ENODEV;
> +		goto len_error;
>  	}
>  
>  	snprintf(*pvs_name, sizeof("speedXX-pvsXX-vXX"), "speed%d-pvs%d-v%d",
> @@ -238,8 +240,9 @@ static int qcom_cpufreq_krait_name_version(struct device *cpu_dev,
>  
>  	drv->versions = (1 << speed);
>  
> +len_error:
>  	kfree(speedbin);
> -	return 0;
> +	return ret;
>  }
>  
>  static const struct qcom_cpufreq_match_data match_data_kryo = {

Applied. Thanks.

-- 
viresh
