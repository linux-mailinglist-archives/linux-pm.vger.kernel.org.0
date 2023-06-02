Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B29571F926
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jun 2023 06:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbjFBEMj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Jun 2023 00:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233184AbjFBEMi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Jun 2023 00:12:38 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDDB132
        for <linux-pm@vger.kernel.org>; Thu,  1 Jun 2023 21:12:37 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-652a45266dfso461831b3a.2
        for <linux-pm@vger.kernel.org>; Thu, 01 Jun 2023 21:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685679156; x=1688271156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eb+4QTrum6u3laOCC4chpSy2X8fQPYWr/n4Wparj6q0=;
        b=M35OtoSrfBiRZ0xmZ6cjYaWOCfSBBE48Nre4yAPoGRb+d1kYbPZucMu5NQu4bDcOak
         S9Pn2wfs7adVu2De/K03KLRBnvAUcK5YZXHZ6w9BHnxuCRKx2wtckBxiTLdFGDt9rOfB
         aYX6iEhgiJlTKlOpU1QHHri3Cbw7aU75zpD+VIuLTg964N4opcIdvlrwknWvkZqTMgZs
         19oeEmzJGzPsHbermS1g7pcC+cQKJP22mYKrd7/JSROSV2/ubiAHrbip814JLyxmsBUx
         rmmU7QfgChfRsUcxCTqftS8fgWD93+zUuKQquII7mSK2xb+ckafve3OcMs4s74MkA4TL
         12tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685679156; x=1688271156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eb+4QTrum6u3laOCC4chpSy2X8fQPYWr/n4Wparj6q0=;
        b=Y3sfGI9vIkXB52TOuZxQFTsWfVbRBWHfx/w+HQwhswXmGo/pQtNgCkdu03W7MhSB5U
         YiUcNqIKpoKoniJ5hcnEUVMYXasLUyjNi5t+0+6GQZrEbUkRH3yNdQVT/UyawUDnnan9
         y6a1wO791NV6OvXDWON7DnrJdpUea0Hj6+esRFOrh82m2EvmpM3P3ysFBgN/2vfJ1vdj
         IqFmJxozey2JFCJbYd7oas7F9lYqI5K5fH5W/4WL17CkGYQACgKyupDSnSR/cw1QDB9g
         xTy4w8PHlrGXTM6my99AIcv10JY2YOWo+/2VlCFSskAHCroIqd5zBnyHUl6zPrCLzvnH
         LE9Q==
X-Gm-Message-State: AC+VfDwICz5fMC9PwNkaJTDS95OA76IDaeR65tZGz1ZYxyGV5iMlnKSU
        AXzpCDH0Oaut9qxibrj1qQfhcw==
X-Google-Smtp-Source: ACHHUZ6JRpEW0H2b8f3O/zmPBsFaFOSng23/i7raVXThjx2ODWlDyZiZrERoWczrti+ZkwxjKOX9hw==
X-Received: by 2002:a05:6a20:8421:b0:10b:97c8:2e16 with SMTP id c33-20020a056a20842100b0010b97c82e16mr9845806pzd.29.1685679156687;
        Thu, 01 Jun 2023 21:12:36 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id q3-20020a17090311c300b001b0295de9acsm194205plh.179.2023.06.01.21.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 21:12:36 -0700 (PDT)
Date:   Fri, 2 Jun 2023 09:42:34 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Zhipeng Wang <zhipeng.wang_1@nxp.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cpufreq: dt-platdev: Add MODULE_LICENSE
Message-ID: <20230602041234.sb77clozdjqorz3j@vireshk-i7>
References: <20230524153417.2738448-1-zhipeng.wang_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524153417.2738448-1-zhipeng.wang_1@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24-05-23, 15:34, Zhipeng Wang wrote:
> Add MODULE_LICENSE to support building as module.
> 
> Signed-off-by: Zhipeng Wang <zhipeng.wang_1@nxp.com>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 338cf6cc6596..54529aa16d53 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -214,3 +214,4 @@ static int __init cpufreq_dt_platdev_init(void)
>  			       sizeof(struct cpufreq_dt_platform_data)));
>  }
>  core_initcall(cpufreq_dt_platdev_init);
> +MODULE_LICENSE("GPL");

Merged both patches and applied. Thanks.

-- 
viresh
