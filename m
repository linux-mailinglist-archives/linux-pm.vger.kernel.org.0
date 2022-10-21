Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845C4607E52
	for <lists+linux-pm@lfdr.de>; Fri, 21 Oct 2022 20:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiJUSds (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Oct 2022 14:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiJUSdq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Oct 2022 14:33:46 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DB0286CBA
        for <linux-pm@vger.kernel.org>; Fri, 21 Oct 2022 11:33:45 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id z97so9068834ede.8
        for <linux-pm@vger.kernel.org>; Fri, 21 Oct 2022 11:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MNS/Xzv51DcFaEv1wkxo1BDU5sd5eff+DnDRv83bAU0=;
        b=CjYUP4coYcJAzuKjAxRNbwUiy0V10PtLSTDPWERzTCg4RLHC7C2t0GzfY01PHrhR0f
         KaHA8YyzXdWb88g6sdklQBcLbYerh1CZ/3LGjPHxrTjKBMPFwLcc9aibqdH+UWqesAzf
         JwDJz7K1Tx8TlGmrCvOnQ4QlFho7Is/NN2Y51jnCXf0TH3DXXeAXa9VQ8Nk5Jw3m3xle
         tk7/bguOt+6oTsNWWsunLJnuQn5iml9zwJ40fMiYp4wLAYHBeg08V2SQo5T4zV1ibhaW
         IOftKei6a2JnCsjweCJL4vThiLn3TNS1vL3ezwDCcyQ0cEz6Fo2O1HND+z6C3/IkccAw
         Zz5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MNS/Xzv51DcFaEv1wkxo1BDU5sd5eff+DnDRv83bAU0=;
        b=S0xB+pM9h+tGl2Zz5q5v6WlIPqU6UTaKVEgCya03+sH+UxRipjGptPEp7Eh6VSCiTK
         9Ckam3YWgZ8y4z7ZX0AC9JWNB1VCITdg+K95nYt7mQuHbBZVhSSsFh4TmJSBeso9ttCB
         umZkqSxOT1U5QcsaxzFOA08WTkd8pRzngPqCRDqwHDXrSOFeg0O7cpFwK7Q+sm/+TdYb
         pGvvsW0ucFpTEaXPLSAnKW37JuYWBiWws4Hh2eiw+vsUv8O+q4pTiY9X8u4PPQQRlKkb
         qfcFuUveyBvy8PgXap30hlsJKzNgLs+vlKR38NF3oYhzhBPIN18p+eSaVYikMc1UEPIf
         NdZw==
X-Gm-Message-State: ACrzQf3MFm5+3Cvz6yVwDfzeNQIewxQkuCptDIVyhZqbvObdoxbq2fex
        HF2DI+BvwluTSFviSqgW11iiRQ==
X-Google-Smtp-Source: AMsMyM7lsIaiLnPNZ8zDmOJFv/eV1ZwypvFv0lN3TApj6rpYOoUmigqvWZaVyzAvkUhD5ZQ+xFqpkA==
X-Received: by 2002:a05:6402:220b:b0:460:f0a1:c4ed with SMTP id cq11-20020a056402220b00b00460f0a1c4edmr8140121edb.318.1666377223707;
        Fri, 21 Oct 2022 11:33:43 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:25b:e73e:85eb:ae6e? ([2a05:6e02:1041:c10:25b:e73e:85eb:ae6e])
        by smtp.googlemail.com with ESMTPSA id n9-20020a05640206c900b0045bd257b307sm13978605edy.22.2022.10.21.11.33.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 11:33:43 -0700 (PDT)
Message-ID: <f1e9b309-ba98-bba2-8d12-9f13ac34587d@linaro.org>
Date:   Fri, 21 Oct 2022 20:33:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RESEND PATCH 2/2] thermal: qcom: tsens: simplify debugfs init
 function
Content-Language: en-US
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thara Gopinath <thara.gopinath@linaro.org>
References: <20221021181906.16647-1-ansuelsmth@gmail.com>
 <20221021181906.16647-2-ansuelsmth@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20221021181906.16647-2-ansuelsmth@gmail.com>
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

On 21/10/2022 20:19, Christian Marangi wrote:
> Simplify debugfs init function.
> - Add check for existing dev directory.
> - Fix wrong version in dbg_version_show (with version 0.0.0, 0.1.0 was
>    incorrectly reported)
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Reviewed-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>   drivers/thermal/qcom/tsens.c | 14 +++++---------
>   1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index cc2965b8d409..ff82626cecef 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -692,7 +692,7 @@ static int dbg_version_show(struct seq_file *s, void *data)
>   			return ret;
>   		seq_printf(s, "%d.%d.%d\n", maj_ver, min_ver, step_ver);
>   	} else {
> -		seq_puts(s, "0.1.0\n");
> +		seq_printf(s, "0.%d.0\n", priv->feat->ver_major);
>   	}
>   
>   	return 0;
> @@ -704,21 +704,17 @@ DEFINE_SHOW_ATTRIBUTE(dbg_sensors);
>   static void tsens_debug_init(struct platform_device *pdev)
>   {
>   	struct tsens_priv *priv = platform_get_drvdata(pdev);
> -	struct dentry *root, *file;
>   
> -	root = debugfs_lookup("tsens", NULL);
> -	if (!root)
> +	priv->debug_root = debugfs_lookup("tsens", NULL);
> +	if (!priv->debug_root)
>   		priv->debug_root = debugfs_create_dir("tsens", NULL);
> -	else
> -		priv->debug_root = root;
>   
> -	file = debugfs_lookup("version", priv->debug_root);
> -	if (!file)
> +	if (!debugfs_lookup("version", priv->debug_root))
>   		debugfs_create_file("version", 0444, priv->debug_root,
>   				    pdev, &dbg_version_fops);
>   
>   	/* A directory for each instance of the TSENS IP */
> -	priv->debug = debugfs_create_dir(dev_name(&pdev->dev), priv->debug_root);
> +	priv->debug = debugfs_lookup(dev_name(&pdev->dev), priv->debug_root);

Why the directory creation is replaced by the lookup ?

>   	debugfs_create_file("sensors", 0444, priv->debug, pdev, &dbg_sensors_fops);
>   }
>   #else


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
