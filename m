Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA8465AB88
	for <lists+linux-pm@lfdr.de>; Sun,  1 Jan 2023 21:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjAAUY6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Jan 2023 15:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjAAUY5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Jan 2023 15:24:57 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3269E2668
        for <linux-pm@vger.kernel.org>; Sun,  1 Jan 2023 12:24:54 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id t17so62606967eju.1
        for <linux-pm@vger.kernel.org>; Sun, 01 Jan 2023 12:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HPJMzApKUEgomZ6Z914OrX4ob+ppzNbrVaTxN/F0SUs=;
        b=ae6mqkKwWVDxEzvCRJR2NBJsLQ+OHI8UhlSOmMwaxQ9zoVQkJyW/4j5kXg5c7qrHyr
         +OC5ynw1ob8aAOe7whJhJDI2g2QLKwz5xcabhxz+W1GmKJq2Way9tdI3kyZzuxWDaXws
         5WY6WwvwBKY55XUYpZkNe7D4JYaDxmYhdLxQXRPuP0Az/r83mJ1nIA+UD1NqXmgZ3bdN
         j73BpjrG3mJ+FpJE6zwtS/tK+ldgzto+jzi9BJq3Q9ZvYGxSC42uUQ0hQjXwi7KLQvOG
         KeK/AV9WuZN4up6XvuYZOSNTjMu+JHiWpPsX8CraqXYIe9PjKSIgfFKthFVyXclJ68qe
         bCqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HPJMzApKUEgomZ6Z914OrX4ob+ppzNbrVaTxN/F0SUs=;
        b=1+bv8Pq3yjQ7iig2meMZgeUlwldgiOT2Sj7fdlj96j03E9/sFx9IQNxwXOhNOskCk5
         FYp+0OTGttYZ7KyvtLZz73Z+60Z5Ie68HZ2NxKxr0PfGHcaogLw8BzHuCSXV7q6h07E3
         cUUUEdJJmNzfyNg7zdZFuEkC6BUm9BOH5edE6Pz0MFTIuDjwjvJQsdoGm/PI+aHHODvY
         lJS+qjm5X74URsfPxTX+/8Kuc1Bk+F3/UjFthiwIqzRIvGTcSzbpDt1Nb7k0U9bypbMn
         QPqqGHV6tRZutw6uuBWSiJPsbITHfHc6aS27ZFrMuNKSR8+aub7wROujBW0twS1YQuac
         M5Ng==
X-Gm-Message-State: AFqh2kpay4btOZnnnOFdXcNfUQZKbIS/8IwtHZOoUWsPbv5dWoA40/69
        Hplo0SqVGMTDgua82KYuG8leaA==
X-Google-Smtp-Source: AMrXdXtdDHy2b41X1oJ5eRemgM9ibCP4cPMKgNFCYHhUukXlDZFDO1bOObisZ9ylCn7CD3bzT83lsQ==
X-Received: by 2002:a17:906:490a:b0:7c1:1444:da2e with SMTP id b10-20020a170906490a00b007c11444da2emr34090160ejq.63.1672604692822;
        Sun, 01 Jan 2023 12:24:52 -0800 (PST)
Received: from ?IPV6:2001:1c06:2302:5600:5825:7f8d:c381:cef4? (2001-1c06-2302-5600-5825-7f8d-c381-cef4.cable.dynamic.v6.ziggo.nl. [2001:1c06:2302:5600:5825:7f8d:c381:cef4])
        by smtp.gmail.com with ESMTPSA id z25-20020a170906945900b007c1633cea13sm12402630ejx.12.2023.01.01.12.24.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Jan 2023 12:24:52 -0800 (PST)
Message-ID: <7298fd96-14ec-c82b-8005-bb5dd912a055@linaro.org>
Date:   Sun, 1 Jan 2023 20:24:51 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v6 07/20] thermal/drivers/tsens: fix slope values for
 msm8939
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Shawn Guo <shawn.guo@linaro.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
References: <20230101194034.831222-1-dmitry.baryshkov@linaro.org>
 <20230101194034.831222-8-dmitry.baryshkov@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230101194034.831222-8-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01/01/2023 19:40, Dmitry Baryshkov wrote:
> +static int __init init_8939(struct tsens_priv *priv) {
> +	priv->sensor[0].slope = 2911;
> +	priv->sensor[1].slope = 2789;
> +	priv->sensor[2].slope = 2906;
> +	priv->sensor[3].slope = 2763;
> +	priv->sensor[4].slope = 2922;
> +	priv->sensor[5].slope = 2867;
> +	priv->sensor[6].slope = 2833;
> +	priv->sensor[7].slope = 2838;
> +	priv->sensor[8].slope = 2840;
> +	priv->sensor[9].slope = 2852;

How are you coming up with the last value here ?

https://github.com/android-linux-stable/msm-3.18/blob/60a8d8af3751b9dc22894fe68b3964ea94ae7888/arch/arm/boot/dts/qcom/msm8939-common.dtsi#L525

---
bod
