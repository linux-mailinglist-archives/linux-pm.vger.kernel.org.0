Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EECFD7784A6
	for <lists+linux-pm@lfdr.de>; Fri, 11 Aug 2023 02:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbjHKApy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Aug 2023 20:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbjHKApu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Aug 2023 20:45:50 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868C02D62
        for <linux-pm@vger.kernel.org>; Thu, 10 Aug 2023 17:45:48 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-268030e1be7so924061a91.3
        for <linux-pm@vger.kernel.org>; Thu, 10 Aug 2023 17:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691714748; x=1692319548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hN0C8RZhlNl5Im8CUD21G9MoVGTEckrSYOi51AO54JI=;
        b=z0G502ieEKLfw4NxCmJW/ByenMdnGZnj1JtLTkLaSZP/xtH18aU4hVwBi0JRbrJa6s
         ovscaFg5OYsBK35wNFL2EoFKZxaigQOZC3MFDHCOxo/ZfLYsomTFVlbHzsBNTUIjtBq4
         ZRP15uVE9Z3sv4bR7Sog45Wxk3KxMhKBVNYJOf/9ZWrAhkZ5+eCKRQVrF+WQQ0aZinXm
         fMwelxnMoW/uYiK08O5LwZ6UyzX61YWxHGcGF/h9b9t4Us9L2R3b4c0AJk1NOlkSgm3M
         apWOENr8WrdgwsOpA156J20+0PmTp623uSuo8zP2+tKuuf47nWJ0s7BNj+EMJfuCelLw
         mSTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691714748; x=1692319548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hN0C8RZhlNl5Im8CUD21G9MoVGTEckrSYOi51AO54JI=;
        b=fSUt+vEZPt+bA75qLKOBRY7zfOs2SjBcX16b2EtMZe7tOEz2ffAN0hwgyuUEVQPmkf
         hc8mlykUgLpIYoWW+R5bsb7egNG8au+vV1tbKVBI2SNWIlo4lVKGgOl42NQ3fs5AFF1n
         W+J6MPlnrO38jx39MtNLjGzm7xoxjjW5VxlO3T6IHR1kSX6SeDtHNXsKkZ+kCGrPY8sb
         6+3NornmgilGnZLddeVYxGIrDkRA1BdQLEyDFhh7EYdD5jpPapw43RL0BW1Jy+d3+EzW
         57DcDbgHq5JZ6zRlybbP8PSChUTG1UUuu3IBjraa+lgC+DrJNyQ5/lgA087dGKYICma9
         0iEA==
X-Gm-Message-State: AOJu0YyAY/3kgZlA3ZG1EVNlCv/jErV83xPedL/U5jea3F/M32KDt8Lb
        D3cMw2aEHBTvfDeQwtg1xsSkoQ==
X-Google-Smtp-Source: AGHT+IFyCGjHHsJUOnPRbxJsciSKygnHwkBnNMD52LoSvwsX/eTKtMEnIehB5fZgiiy5jZYXOmht7A==
X-Received: by 2002:a17:90b:70a:b0:268:ce03:e17e with SMTP id s10-20020a17090b070a00b00268ce03e17emr160210pjz.47.1691714747966;
        Thu, 10 Aug 2023 17:45:47 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id hx11-20020a17090b440b00b00263dee538b1sm2119638pjb.25.2023.08.10.17.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 17:45:47 -0700 (PDT)
Date:   Fri, 11 Aug 2023 06:15:43 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] cpufreq: mediatek-hw: Remove unused define
Message-ID: <20230811004543.dzc2ebhjurrsjz57@vireshk-i7>
References: <20230810-topic-mtk_fixup-v1-1-88022eaea0ac@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810-topic-mtk_fixup-v1-1-88022eaea0ac@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10-08-23, 20:12, Konrad Dybcio wrote:
> DYNAMIC_POWER does not seem to be used anywhere in the tree, remove it.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/cpufreq/mediatek-cpufreq.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> index fef68cb2b38f..a0a61919bc4c 100644
> --- a/drivers/cpufreq/mediatek-cpufreq.c
> +++ b/drivers/cpufreq/mediatek-cpufreq.c
> @@ -313,8 +313,6 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
>  	return ret;
>  }
>  
> -#define DYNAMIC_POWER "dynamic-power-coefficient"
> -
>  static int mtk_cpufreq_opp_notifier(struct notifier_block *nb,
>  				    unsigned long event, void *data)
>  {

Applied. Thanks.

-- 
viresh
