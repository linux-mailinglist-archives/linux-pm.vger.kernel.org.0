Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD0770AC1A
	for <lists+linux-pm@lfdr.de>; Sun, 21 May 2023 05:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjEUDCt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 20 May 2023 23:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjEUDCr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 20 May 2023 23:02:47 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFD4109
        for <linux-pm@vger.kernel.org>; Sat, 20 May 2023 20:02:45 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-64d5b4c3ffeso260189b3a.2
        for <linux-pm@vger.kernel.org>; Sat, 20 May 2023 20:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684638165; x=1687230165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7g84B3mr3usI2oVl+buXh02EIlQZwo5NjaPeZttACvI=;
        b=aQzA0m09RT43Eva55n41oDx8ZCpb2Thuchm3kl7WO866WJG8CLaOxnOLS8FA3tJ/75
         xbNvM0MtUvlEVBjJ9DtaTAoGgOr786vlpElQeiZfR8gUqN068IGdz4qHJEEPlTQ+i7SC
         EeKzWDzyjwOwlYOAlMi/jcuhE31FI3IkNeMLXVXSicMOTbu+KHoYlc5UcLrGg9DTqWvz
         IW9qweg19wJRqqLJQfUxu385Fl33uwLiGwp9dhc0r6k3YHL6fSEx16BFn/vWYByeiw0g
         hVPA3uUqXc5nyqbujhNzPfHlxkUglIcEOfoCIYtBLNuqQHfcakkDvMkhwB46oQ9oUKq8
         MwBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684638165; x=1687230165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7g84B3mr3usI2oVl+buXh02EIlQZwo5NjaPeZttACvI=;
        b=Ta2Sv/Zi3NBrL7jbVLPpBzhqDXJOximvdnX0c8zDY48mCy/XqnHFwKQxq1U5mpVszA
         8oKbhqAiVRqfb6Zy42QmgvfG88yFPPnd56PmpVRUBrsCXQRbibUeeFy41dRfMPu5KqkQ
         qb7WTru4QMClm8ECc6EQAP1c/rtPQD92tWN+sQtIQWV3ZYyxLtCEwQFyjl67t9gZ51cM
         cD6ObK7BSDUaeQQC3U0PSZs1XugWD2fROk5y9c09LLwlBMZQL/2NMrFnfM2TxNwt4rWS
         KlYBx7PeQeYF/Nak1N9pctKvH8iad/eNyxrt1d5OBQOPKJEm+1NuBImiFVtOKJ1Mo9l9
         JXmQ==
X-Gm-Message-State: AC+VfDya3OsseK+ojR5r2tNcAvIZeBJT59NSMJDPSkvCGwElA53Rd0eg
        ni6WZf1y5o8BqXYO/bY34RJk7g==
X-Google-Smtp-Source: ACHHUZ74oBPYKYuyVilmB3FZF4Qu//BkEdov+ILROh547TvXdfhxwV+xSUzbsvXZ7dqZg5Dgxs4lPg==
X-Received: by 2002:a05:6a00:a21:b0:64b:50:2410 with SMTP id p33-20020a056a000a2100b0064b00502410mr9414263pfh.19.1684638165128;
        Sat, 20 May 2023 20:02:45 -0700 (PDT)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id t23-20020aa79397000000b0064d4d11b8bfsm1547140pfe.59.2023.05.20.20.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 20:02:43 -0700 (PDT)
Date:   Sun, 21 May 2023 11:02:32 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] interconnect: icc-clk: fix modular build
Message-ID: <20230521030232.GA539244@dragon>
References: <20230519230122.3958816-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519230122.3958816-1-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, May 20, 2023 at 02:01:22AM +0300, Dmitry Baryshkov wrote:
> Fix building interconnect-clk as a module:
> - Add EXPORT_SYMBOL_GPL to the exported functions
> - Add MODULE_DESCRIPTION/_LICENSE/_AUTHOR
> 
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Shawn Guo <shawn.guo@linaro.org>

> ---
>  drivers/interconnect/icc-clk.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/interconnect/icc-clk.c b/drivers/interconnect/icc-clk.c
> index 0db3b654548b..4d43ebff4257 100644
> --- a/drivers/interconnect/icc-clk.c
> +++ b/drivers/interconnect/icc-clk.c
> @@ -146,6 +146,7 @@ struct icc_provider *icc_clk_register(struct device *dev,
>  
>  	return ERR_PTR(ret);
>  }
> +EXPORT_SYMBOL_GPL(icc_clk_register);
>  
>  /**
>   * icc_clk_unregister() - unregister a previously registered clk interconnect provider
> @@ -166,3 +167,8 @@ void icc_clk_unregister(struct icc_provider *provider)
>  			clk_disable_unprepare(qn->clk);
>  	}
>  }
> +EXPORT_SYMBOL_GPL(icc_clk_unregister);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Interconnect wrapper for clocks");
> +MODULE_AUTHOR("Dmitry Baryshkov <dmitry.baryshkov@linaro.org>");
> -- 
> 2.39.2
> 
