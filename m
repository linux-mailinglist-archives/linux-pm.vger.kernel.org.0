Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7178D607568
	for <lists+linux-pm@lfdr.de>; Fri, 21 Oct 2022 12:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiJUKva (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Oct 2022 06:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiJUKv2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Oct 2022 06:51:28 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2589D5B9F0
        for <linux-pm@vger.kernel.org>; Fri, 21 Oct 2022 03:51:12 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id m15so4228128edb.13
        for <linux-pm@vger.kernel.org>; Fri, 21 Oct 2022 03:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eyUNYNqvcjzZxAcssIhx0A4Bt7QnnizE7AOFgTYFdn4=;
        b=iaUQvCV+xLcU0xVeGi4RUAQPmzJDmNBqPOti0IotisinCWEAhnyuJxu8iQ+0Q8jZ92
         bOsoSZ/4Rmel/7yoIy6VnRx4m2ekdOBmop4fgbOlpW3QD3tNEQbJ3G1Yg/MOwqqjggUU
         tTItoIm2P1dnsYuo8FN47f+cF8f6YMz8I4RX4YmnPVbnvI0VX7E9CPmjkJHJJlcRvj37
         kDoy7LaC0FK77eOO3XOpdY3bR4Nhoom8MRMvWTwmDll4brDYkFWiPdP6WLu4eq1Cf5HB
         3t4/RNYWh/rEdlKMpuDB2TG554jv/bb1dnThxgxuKat680ZKTLNJM3l3H7b+Cyg6bO9f
         0JNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eyUNYNqvcjzZxAcssIhx0A4Bt7QnnizE7AOFgTYFdn4=;
        b=8OhmWggF7Uf7kiIc/WjSI1n2whsziKyxBdfzHE/9Kclx2dkkw55EIwjgrFS0P3+ibN
         k7DO/+fEiQRuArvWMwc6ttFEu6YrQblxez0c+h7Md8wmDfhPBnmJlE9aouEmM7k1W/9L
         o5Xuha48M+aBfRHw7rKcd7enTEkl/xkWSpwUPR22KpVRNOp2Bio/eMZngTYDqdixK9Q0
         nYzPXWDOEq63TrR4ZVv7VaEw0DKryZtlB0eqrz7gH3Zn/Ohs4rEQcEB0/a/xlqgs+/bz
         E2ZXNJ1oip31AYbaD+1yn+ZFy0jbbyyoJ58wu56v6PcKw0bvOYTHr7IDGUmJEgy3oZlZ
         ZhMA==
X-Gm-Message-State: ACrzQf1kFo2m9T1SEWSRpq7OlOhlscNKAG5P4hnvAqyev8+0A4I2xH+J
        e1YMEzrNdM0zsPtn9Jwyf43O5w==
X-Google-Smtp-Source: AMsMyM7faC5zd2bDtnfWDWC4vx2GyqaIV7BAwFfNvtKXBu67cdd/k/88+UENkWIspAC19hvv+N1fNw==
X-Received: by 2002:a17:907:3da2:b0:78d:3b45:11d9 with SMTP id he34-20020a1709073da200b0078d3b4511d9mr15047865ejc.87.1666349470384;
        Fri, 21 Oct 2022 03:51:10 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:25b:e73e:85eb:ae6e? ([2a05:6e02:1041:c10:25b:e73e:85eb:ae6e])
        by smtp.googlemail.com with ESMTPSA id 17-20020a170906219100b0078dce9984afsm11541653eju.220.2022.10.21.03.51.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 03:51:09 -0700 (PDT)
Message-ID: <101b2547-817a-f222-68b5-83f929831965@linaro.org>
Date:   Fri, 21 Oct 2022 12:51:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] thermal/of: Fix memory leak on thermal_of_zone_register()
 failure
Content-Language: en-US
To:     Ido Schimmel <idosch@nvidia.com>, linux-pm@vger.kernel.org
Cc:     rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        vadimp@nvidia.com, mlxsw@nvidia.com
References: <20221020103658.802457-1-idosch@nvidia.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20221020103658.802457-1-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20/10/2022 12:36, Ido Schimmel wrote:
> The function does not free 'of_ops' upon failure, leading to a memory
> leak [1].
> 
> Fix by freeing 'of_ops' in the error path.
> 
> [1]
> unreferenced object 0xffff8ee846198c80 (size 128):
>    comm "swapper/0", pid 1, jiffies 4294699704 (age 70.076s)
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>      d0 3f 6e 8c ff ff ff ff 00 00 00 00 00 00 00 00  .?n.............
>    backtrace:
>      [<00000000d136f562>] __kmalloc_node_track_caller+0x42/0x120
>      [<0000000063f31678>] kmemdup+0x1d/0x40
>      [<00000000e6d24096>] thermal_of_zone_register+0x49/0x520
>      [<000000005e78c755>] devm_thermal_of_zone_register+0x54/0x90
>      [<00000000ee6b209e>] pmbus_add_sensor+0x1b4/0x1d0
>      [<00000000896105e3>] pmbus_add_sensor_attrs_one+0x123/0x440
>      [<0000000049e990a6>] pmbus_add_sensor_attrs+0xfe/0x1d0
>      [<00000000466b5440>] pmbus_do_probe+0x66b/0x14e0
>      [<0000000084d42285>] i2c_device_probe+0x13b/0x2f0
>      [<0000000029e2ae74>] really_probe+0xce/0x2c0
>      [<00000000692df15c>] driver_probe_device+0x19/0xd0
>      [<00000000547d9cce>] __device_attach_driver+0x6f/0x100
>      [<0000000020abd24b>] bus_for_each_drv+0x76/0xc0
>      [<00000000665d9563>] __device_attach+0xfc/0x180
>      [<000000008ddd4d6a>] bus_probe_device+0x82/0xa0
>      [<000000009e61132b>] device_add+0x3fe/0x920
> 
> Fixes: 3fd6d6e2b4e8 ("thermal/of: Rework the thermal device tree initialization")
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
