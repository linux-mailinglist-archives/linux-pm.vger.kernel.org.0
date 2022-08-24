Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B80559F385
	for <lists+linux-pm@lfdr.de>; Wed, 24 Aug 2022 08:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234918AbiHXGOf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Aug 2022 02:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234151AbiHXGOe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Aug 2022 02:14:34 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF60422E5
        for <linux-pm@vger.kernel.org>; Tue, 23 Aug 2022 23:14:33 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 67so7359258pfv.2
        for <linux-pm@vger.kernel.org>; Tue, 23 Aug 2022 23:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=CjJMb0ctnOLwj9iUG3KhJktoMTTHhxkNc2qawsTbo9k=;
        b=ieYW1Wd6QOqL/MnmJeFWCyL0p1lXyrOHLwuH71l8qfWT9iesn8OGFHHH1tAIPBJL9v
         2CEOodhNAgn9h9xLFiWxnViTfukWsiDo4NGugRMCYLbGDyMpLuEO0MBu+JQ0zRKzQtni
         Oj69sTP+l/EwqMbazqXdDgByh9HYvWMyb5EizDMon8LDfHdQizYXz8KU6PMMU+NVHcKW
         1+9cwkq+C/qL0bv7lmXE/4jtw+JhMKuSb5ZxFhu37cM3ZPk6z97JePGxe3MFZYxu2UM/
         nQRxJH8wFLwpums479bwSRd8JZFCM7sDwkd6G9M5Ka7cl/v++i9ZSwk1g7K8pIkL6Eji
         +d2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=CjJMb0ctnOLwj9iUG3KhJktoMTTHhxkNc2qawsTbo9k=;
        b=hvkbTY9mWlfIlQLVv+vkzbljefisItRW43lPVFgLxQZhAI8D/oazb8BbDyTlrEaRHG
         mCgOXFufBGrs6N1AABEpCpDfaq01DQpA5q6a1dfvOtAIzb+D45wVV3b/vlJFtlbbd7ls
         Gmhu0xKbkYB0KUODegyMNkv3x1Tq0rB7k6tPwKchaZyE3tEk7AcvSPOhWaFiPtxQBmIg
         GzKG8s8YAhbDbqvtYUJNsIxjc9C/w/C1oKrds8RKXQ3e9kGAe+GjlkzBTXzz+8ZDoO6d
         F9PJVJXYLoc0AHbq65GxT/AokKSjq0mBlj/nnnHa4SFOonKfC7WuXTU7nvjOZ8Wmk8Pe
         ID2Q==
X-Gm-Message-State: ACgBeo0+2Al8bdnrLbhE7MYsQ6E/6wuHH8sw5PSYaMUcUtIj5nsVGh3N
        4iYvh650aEzdz6oeXwVeX8mQ0Q==
X-Google-Smtp-Source: AA6agR4pvtNJ75UoJkMpWI3IsFgB1dnMm19YX1VY6HCtoKhEoOaQD331h+hsdCwBm2MOm/I5kKc0+w==
X-Received: by 2002:a05:6a00:2308:b0:52f:8ae9:9465 with SMTP id h8-20020a056a00230800b0052f8ae99465mr27898070pfh.77.1661321673095;
        Tue, 23 Aug 2022 23:14:33 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id m1-20020a170902db0100b0016bf9437766sm3374901plx.261.2022.08.23.23.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 23:14:32 -0700 (PDT)
Date:   Wed, 24 Aug 2022 11:44:30 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.or, lenb@kernel.org,
        robert.moore@intel.com, punit.agrawal@bytedance.com,
        lukasz.luba@arm.com, ionela.voinescu@arm.com,
        pierre.gondois@arm.com, linux-kernel@vger.kernel.org,
        devel@acpica.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 2/2] cpufreq: CPPC: Change FIE default
Message-ID: <20220824061430.3aflygc4gno5j47y@vireshk-i7>
References: <20220818211619.4193362-1-jeremy.linton@arm.com>
 <20220818211619.4193362-3-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818211619.4193362-3-jeremy.linton@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18-08-22, 16:16, Jeremy Linton wrote:
> FIE is mostly implemented as PCC mailboxes on arm machines.  This was
> enabled by default without any data suggesting that it does anything
> but hurt system performance. Lets change the default to 'n' until
> hardware appears which clearly benefits.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  drivers/cpufreq/Kconfig.arm | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 954749afb5fe..ad66d8f15db0 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -22,7 +22,7 @@ config ACPI_CPPC_CPUFREQ
>  config ACPI_CPPC_CPUFREQ_FIE
>  	bool "Frequency Invariance support for CPPC cpufreq driver"
>  	depends on ACPI_CPPC_CPUFREQ && GENERIC_ARCH_TOPOLOGY
> -	default y
> +	default n
>  	help
>  	  This extends frequency invariance support in the CPPC cpufreq driver,
>  	  by using CPPC delivered and reference performance counters.

Why is this required after we have the first patch in ?

-- 
viresh
