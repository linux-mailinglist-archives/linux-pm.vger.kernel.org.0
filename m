Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFEF641DE6
	for <lists+linux-pm@lfdr.de>; Sun,  4 Dec 2022 17:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiLDQaU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Dec 2022 11:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiLDQaT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Dec 2022 11:30:19 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5A510FDF
        for <linux-pm@vger.kernel.org>; Sun,  4 Dec 2022 08:30:18 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id y16so15307803wrm.2
        for <linux-pm@vger.kernel.org>; Sun, 04 Dec 2022 08:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gd6xlk0AzdtO6fVepPWbasCUVikDRLJKo87U3nnnfAY=;
        b=X/n9meftm1bOCbPshY2mJNHMO249wdWAAl7xVqEN9E2IoHNwlQ3Mec19MnmB1fifcK
         MJFlFJQbP4CKs84yOEEAGSfo1H9EljwiL0092QaHICynf5DHqwK9LRVwG3Y/2gQgGSGe
         sEcscYwYGbYEGYMl6NNV4viaX6bRsYFq+EQ/0oERsVbsH5esFo830b6Mch6D14aaliq+
         y4Mn88v357KoFtB/S0uWxY4EFGRluk62EpIdU0HerZ4Xe9srb4qq3OsGFhIV5eDnYZZX
         vIZkjk87wwH3RG3GYynUREb28qCkkgmKFyZBedJY23Ogr3NVXY0b9/vPIvgx/ZSyyBIw
         oLAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gd6xlk0AzdtO6fVepPWbasCUVikDRLJKo87U3nnnfAY=;
        b=ivhR3Hcx+43HosGJ2nqEF/bPNj+BQo9JxfeEh66Q4A6GF+Po/6JbQD9OVNwK3FrWRx
         f+y7OM8q8LOaoaqq8iQ7UrNJ7tHY7oIVSIs9GPtmFnfo0iF5AnMWUD9NPC+NwKokJq53
         71Yt+XnmepuXMMa7PZTqMW4x5y28KxdG75KCZxsY6NVDoN64QWxqkJC8OpJ6WIjsMMRd
         bEYdvUNS7lU6uN63heceMgN6Zr+9qShom+KyGFwkgdWtTOmS5KfhlpikraM2T+GX1DQ4
         T6oihipVUIYzyyy4VxoY6wnqUEmHn3bi35v71NfId9pIa5LwGju7M4lpeuLYkrzwPWRq
         nZlA==
X-Gm-Message-State: ANoB5pn4mCuIkxrtyc0A6jhHYwss09sIap57ISH6QKQeO808X1balx1z
        Z6u/gw6OeIO7WjTePe82N44H7Q==
X-Google-Smtp-Source: AA0mqf6QpWXjGm//fr5A4yjBuLavlGGryTq+y6p1sDRmgWEXfE7VCLXHuwMpAWKODjQN+zwv54Pakw==
X-Received: by 2002:a5d:6b46:0:b0:236:56a6:823e with SMTP id x6-20020a5d6b46000000b0023656a6823emr48005339wrw.495.1670171416813;
        Sun, 04 Dec 2022 08:30:16 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id o18-20020a05600c4fd200b003cff309807esm20374921wmq.23.2022.12.04.08.30.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Dec 2022 08:30:16 -0800 (PST)
Message-ID: <bcab394a-75b0-995b-96f0-608880c80b50@linaro.org>
Date:   Sun, 4 Dec 2022 17:30:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH resend] thermal: ti-soc-thermal: Drop comma after SoC
 match table sentinel
Content-Language: en-US
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1d6de2a80b919cb11199e56ac06ad21c273ebe57.1669045586.git.geert+renesas@glider.be>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <1d6de2a80b919cb11199e56ac06ad21c273ebe57.1669045586.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21/11/2022 16:47, Geert Uytterhoeven wrote:
> It does not make sense to have a comma after a sentinel, as any new
> elements must be added before the sentinel.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

