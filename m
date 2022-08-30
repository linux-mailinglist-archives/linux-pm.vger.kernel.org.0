Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C6D5A5DEE
	for <lists+linux-pm@lfdr.de>; Tue, 30 Aug 2022 10:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbiH3ITv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Aug 2022 04:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiH3ITu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Aug 2022 04:19:50 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317C7CCA
        for <linux-pm@vger.kernel.org>; Tue, 30 Aug 2022 01:19:47 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id q63so10001619pga.9
        for <linux-pm@vger.kernel.org>; Tue, 30 Aug 2022 01:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=QxBXKW0/XKDN64zFE8stGLfg4txiFm1hlJ7EPPxbZMo=;
        b=Ph3tweaWDl4jWQN/HRO/GvMnFdgnFw6WdWbiKkuodzAFPA3Z3c9+ZdLw4UYc1s92sw
         qjXPtQbNXuHofaQyCnxaPPdK/D2YfsIjckfOR6p7XQZDY1FMML7GEP92AfbtYRkLTDAm
         sVdomS1iWaiojM3P5sYwNXW8V82pBXMb4KQ0pcjUhN+tmbW2Qx3Ovvtc6eELdgH8h/Vc
         vOW6wmnRefPRQM+C6dewzjLeYuiEbZRMfjj4R1oGwk/zV5CkPVkjEPyu2ng/VIZqDASI
         M3daLCdlawny275bQ0kXmV8QU6C8HzMv3DizBqlSG1AFOMyTg+qfhuqnp1wz+t0pfJtB
         46Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=QxBXKW0/XKDN64zFE8stGLfg4txiFm1hlJ7EPPxbZMo=;
        b=wd4cZA1o/I4YJG8RDPdejFzk+ZmJ6bRfM6t1vJ+yXpCrwpmzD3UWnfWjKNmgWh9PLg
         UG8ujD/59eUqtk0qCd26j8knfOrgW9Pd18kSEFIADxSgjKivOjEo58HNcSDMwbftOh1P
         CYrCFHKTgnJCZ0eMRhtuATZcNatTbXSbB3RkiN1Jeajz+bPhiKA5aJb57yiJs6AoEBez
         eluV4xr0Rkq+NmTTn5lKtBMdkCcOfddJjEkbeQwKQJuzYVG7E6c77UAJVSbVp0SBirZY
         /00RrQ/xPSDUpxnKxkbid2anQEL43b8NPMbMZ/AG+l4bUKmSqeJWHD2I+u3B6aYgHLM5
         tdww==
X-Gm-Message-State: ACgBeo10S0yXDZgdAjUBR7IH8HjOeSGGm0YasmuHsHVKKWiph3En6pvq
        SC+Hl4ouvb0NAviglJpQrYEEhA==
X-Google-Smtp-Source: AA6agR4uLb8CnwM+BgpZcEUsuDMI8Cdu/C6h/swRZqMNG/mp14w2OPpGAnWKSJ33+Wi9GZM2bxDxPQ==
X-Received: by 2002:a63:d00a:0:b0:42a:3d80:10a with SMTP id z10-20020a63d00a000000b0042a3d80010amr16721865pgf.288.1661847586735;
        Tue, 30 Aug 2022 01:19:46 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id z1-20020a63c041000000b0041a67913d5bsm1043388pgi.71.2022.08.30.01.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 01:19:46 -0700 (PDT)
Date:   Tue, 30 Aug 2022 13:49:39 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Zhang Jianhua <chris.zjh@huawei.com>
Cc:     mmayer@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v2] cpufreq: bmips-cpufreq: Use module_init and add
 module_exit
Message-ID: <20220830081939.ui23hwr4hlir6lym@vireshk-i7>
References: <20220830080732.3600988-1-chris.zjh@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830080732.3600988-1-chris.zjh@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30-08-22, 16:07, Zhang Jianhua wrote:
> - Use module_init instead of device_initcall.
> - Add a function for module_exit to unregister driver.
> 
> Signed-off-by: Zhang Jianhua <chris.zjh@huawei.com>
> ---
> v2:
> - add semicolon after module_exit to keep the format consistent
> ---
>  drivers/cpufreq/bmips-cpufreq.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/bmips-cpufreq.c b/drivers/cpufreq/bmips-cpufreq.c
> index f7c23fa468f0..39221a9a187a 100644
> --- a/drivers/cpufreq/bmips-cpufreq.c
> +++ b/drivers/cpufreq/bmips-cpufreq.c
> @@ -156,7 +156,7 @@ static struct cpufreq_driver bmips_cpufreq_driver = {
>  	.name		= BMIPS_CPUFREQ_PREFIX,
>  };
>  
> -static int __init bmips_cpufreq_probe(void)
> +static int __init bmips_cpufreq_driver_init(void)
>  {
>  	struct cpufreq_compat *cc;
>  	struct device_node *np;
> @@ -176,7 +176,13 @@ static int __init bmips_cpufreq_probe(void)
>  
>  	return cpufreq_register_driver(&bmips_cpufreq_driver);
>  }
> -device_initcall(bmips_cpufreq_probe);
> +module_init(bmips_cpufreq_driver_init);
> +
> +static void __exit bmips_cpufreq_driver_exit(void)
> +{
> +	cpufreq_unregister_driver(&bmips_cpufreq_driver);
> +}
> +module_exit(bmips_cpufreq_driver_exit);
>  
>  MODULE_AUTHOR("Markus Mayer <mmayer@broadcom.com>");
>  MODULE_DESCRIPTION("CPUfreq driver for Broadcom BMIPS SoCs");

Applied. Thanks.

-- 
viresh
