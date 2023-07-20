Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E6A75AC10
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jul 2023 12:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjGTKdG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Jul 2023 06:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbjGTKc6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Jul 2023 06:32:58 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3806271D
        for <linux-pm@vger.kernel.org>; Thu, 20 Jul 2023 03:32:40 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-668711086f4so453277b3a.1
        for <linux-pm@vger.kernel.org>; Thu, 20 Jul 2023 03:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689849158; x=1690453958;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xKYUhMR1McdxFbQ4Jo6vuraMtMWIn8Z/zfmypgVmrcY=;
        b=tsOv8B+/t6cC16KWe9C2LxhDAI52NK3+hCr2mhHy5psUUZT826eCwd0faElZmDomg0
         0/Y+6a0X0EEP9f65G9w8lUZ4z1aJnul16vxYroSnBn3wp0JL6VoO/O4+YaAIlTZh7ykD
         sKWBQlvf+BfY7AjSscbM+8n0s4UNALx9dAaJcpE+L7a3LJ6lgUCGJFAAITJ4SRbGpLui
         yG/8PMQ5m5cUfX8a74aBl7ael2RjuPY8gZc1IGHKmtdSoLfDPfjqL8Mv7huSICRu2CBF
         lQGvwGcwQXhtPUHuei6DelkyV1gyZGQQx+CBv3g/dLxOn8uWkiUMOhW4HCCrSLLejbOP
         NFiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689849158; x=1690453958;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xKYUhMR1McdxFbQ4Jo6vuraMtMWIn8Z/zfmypgVmrcY=;
        b=JzRYuzBVBgNd2PeCWRzlY/JVlfa0aXUtkNpUdeX4PZozx1msQHsZutM/GiZABwrer8
         XuYs4s6VuL+QtYkudq5dK9IUS82xT3Lv31cqJWbBcxRheOUMvw2s0H78Kzsudt/m1shm
         afKVaS7M4VSDHlvql/v/G/niPKmv/PjsGW2mt80Fzhv8Q9iA2n3WFIQFJ3kQmAaHTT4v
         /PdL8tFvZt/++6ZRTfFUzuHdpdfg7ZklcvXI2LS1bFHPY68IyYSUU3IMwNPkea+QUiUf
         pBoIHrxWHhRBRKCz+kRna97REARr/fwFK6Ewlq7A4FK9csAhd/JPc/SFf7pUllWkQ9QP
         iQZw==
X-Gm-Message-State: ABy/qLYP5+AlysRkzZTYe8971ka3zrnvin36Z5jFY5+GnQLj5Zle9FnM
        wDSIsUXhSIYca8tRSKaIQrZWeQ==
X-Google-Smtp-Source: APBJJlFPGHydCjtzxTJZnytC6CyFKFv8hJWClYfqDJkKXIBvrrDMTEHas0e4QsNhT7++H33b2LhJ3g==
X-Received: by 2002:a05:6a21:3291:b0:132:7d91:aadb with SMTP id yt17-20020a056a21329100b001327d91aadbmr6219794pzb.6.1689849157754;
        Thu, 20 Jul 2023 03:32:37 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id m7-20020aa79007000000b006636c4f57a6sm861335pfo.27.2023.07.20.03.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 03:32:37 -0700 (PDT)
Date:   Thu, 20 Jul 2023 16:02:35 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/19] cpufreq: sun50i: Convert to platform remove
 callback returning void
Message-ID: <20230720103235.ao3664ibqjksun5u@vireshk-i7>
References: <20230712093322.37322-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230712093322.37322-1-frank.li@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12-07-23, 17:33, Yangtao Li wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Cc: Uwe Kleine-K�nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  drivers/cpufreq/sun50i-cpufreq-nvmem.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Applied all the patches. Thanks.

-- 
viresh
