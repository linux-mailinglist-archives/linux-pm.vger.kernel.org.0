Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF25A714BF6
	for <lists+linux-pm@lfdr.de>; Mon, 29 May 2023 16:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjE2OZN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 May 2023 10:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjE2OZM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 May 2023 10:25:12 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54CCA0;
        Mon, 29 May 2023 07:25:10 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-53f04fdd77dso1604203a12.3;
        Mon, 29 May 2023 07:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685370310; x=1687962310;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=orDUenRNzVU+ubj1gufGe2wfcJd11DQOinKFj2BgI2Y=;
        b=QSCnD2hSWTzxINu7KBy/VnvDhdIbzLbWQ96VXsAi7W8BBovEz+pn1nQLyDWNlOpbSd
         /11LShyK1beUgefGta9WPx7jecVvtQg298EP8zGR975TPNHuuo2ag2e6g+JWv2wpPFi3
         SCDekm5/UWDAWtwFkdUAR7Aq0/pMo0bjJOPIwRV6LH5yF5hTPYkn/fkG9c/tOt1syzJf
         fhJ2VZX01Dae8eeMAk5Gp6Zoe+Wa88ULXpZcTPfnUeL39pxkvigsaN46EGmgq3CFC0TD
         zqQ1wME15bb/vBO4EXTcwimDI5GxpEwNFlvBOli8+0Zt4zza5PC1ROPQr405NEyXkR+Z
         /84A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685370310; x=1687962310;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=orDUenRNzVU+ubj1gufGe2wfcJd11DQOinKFj2BgI2Y=;
        b=NbWx3DQBanChQ2/wkKpFvViyN9TzA3rzuvxCeHwxPbD7Z4/A7Gn9bQztJry4DvBQc3
         dXD60KoR4fLnJpkmKZxExJttDcc4biYM1MBaglysex9BecvI40nVGgO1rU2L4ImqqGez
         B33SD0ybzkppJBasmKaqlQ6E7k0EcH3MBkCEwcWRedMFVDxT5ymUidXfE0q/yCETPNPU
         MOINrZRjKxjflqS8ZvtZ7pXm46bQXHD3mEg2+zGwcJQWUlTvU/lOyQnvh4UlYydNbCun
         aQ21jfXXfm3AV3ykoFaYVtsXqHerDW6giK2cr/MuE2o2JY/FpS8FQZ3yVw3UOIyCjbTX
         33WQ==
X-Gm-Message-State: AC+VfDywE3e9WsA+ocFyk6nygaI5tT5V7cjMgOsimeMDH7dsctOhpNVS
        OBKd0fLp/ovAk8sokrxTDxc=
X-Google-Smtp-Source: ACHHUZ4UlUSb1GMRStKeVjpCvJ3bWJPfc862kJAiNejRrmZFRDFlYiCx+7FIgSNUbenPBCt6YyJSrA==
X-Received: by 2002:a17:902:f551:b0:1ae:e84:268d with SMTP id h17-20020a170902f55100b001ae0e84268dmr13868646plf.25.1685370310246;
        Mon, 29 May 2023 07:25:10 -0700 (PDT)
Received: from [172.30.1.35] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id p18-20020a170902e75200b001b00fd3cf5bsm6445318plf.297.2023.05.29.07.25.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 07:25:08 -0700 (PDT)
Message-ID: <b2d8f6e6-689a-be77-fddf-673b08f4d993@gmail.com>
Date:   Mon, 29 May 2023 23:25:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] PM / devfreq: exynos: add Exynos PPMU as a soft module
 dependency
Content-Language: en-US
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
References: <CGME20230518074416eucas1p1dfd47a3438f2252211cf7daa82e2ac1e@eucas1p1.samsung.com>
 <20230518074403.2894799-1-m.szyprowski@samsung.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20230518074403.2894799-1-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23. 5. 18. 16:44, Marek Szyprowski wrote:
> Commit adf8238ef403 ("ARM: dts: exynos: move exynos-bus nodes out of soc
> in Exynos4412") changed the order of the exynos-bus nodes, what results
> in different probe order of the Exynos Bus devices. Although the driver
> properly handles the deferred probe and all devices seems to be finally
> properly registered, this change revealed some kind of a bug related to
> PPMU counters registration and passive governor operation. Usually in 1
> of 10 boots this results in complete board freeze during loading of the
> kernel modules.
> 
> To avoid that freeze, ensure that the Exynos PPMU driver is already
> loaded before the Exynos Bus driver starts probing.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> This is a follow-up of the following discussion:
> https://lore.kernel.org/all/d287ca9f-b056-d39a-aa93-b0e2cb279f73@linaro.org/
> ---
>  drivers/devfreq/exynos-bus.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
> index 88414445adf3..245898f1a88e 100644
> --- a/drivers/devfreq/exynos-bus.c
> +++ b/drivers/devfreq/exynos-bus.c
> @@ -518,6 +518,7 @@ static struct platform_driver exynos_bus_platdrv = {
>  };
>  module_platform_driver(exynos_bus_platdrv);
>  
> +MODULE_SOFTDEP("pre: exynos_ppmu");
>  MODULE_DESCRIPTION("Generic Exynos Bus frequency driver");
>  MODULE_AUTHOR("Chanwoo Choi <cw00.choi@samsung.com>");
>  MODULE_LICENSE("GPL v2");

Applied it. Thanks.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

