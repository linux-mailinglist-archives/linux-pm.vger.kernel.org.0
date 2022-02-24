Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C574C275C
	for <lists+linux-pm@lfdr.de>; Thu, 24 Feb 2022 10:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbiBXJBy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Feb 2022 04:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbiBXJBw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Feb 2022 04:01:52 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA6D166A45
        for <linux-pm@vger.kernel.org>; Thu, 24 Feb 2022 01:01:23 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id m11so1128665pls.5
        for <linux-pm@vger.kernel.org>; Thu, 24 Feb 2022 01:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5Kq93s+crgPmi5HFKoDt6O2SRLg0Bv4SYhTGG/8f70Q=;
        b=jQpiBmXHb65yJkFfhy+Uv828XJpt/ddjUiCQKP8tQwKxLfjFv3cJ3YH6ctRVCFYMcQ
         zTQCA76puhqUgXhZWMdR78cnHzYoZV/pgKC3T5k87Vwr3fzuC3XFzNx3JpKMygHXtqEk
         kWgcSFcdSnJnErQHtcjbTWifNyG+aaSmItNBTmViGXVRLV9V7OhXA8g06jH5e3iA3CPd
         IOI1ginB89pYJKI41uyKNLOR07KH44Deb7ip7s0ViBx0b1UsbcMZIgoMAhRT4xSiiCRt
         yPOSzEUt98l2aEfJCBLgLO8FJVdR4/FzapNaeC1rLGBuRpKGvznkX1cNk6712W8mFZHj
         n75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5Kq93s+crgPmi5HFKoDt6O2SRLg0Bv4SYhTGG/8f70Q=;
        b=T8Cvaa6a/ad1cqivxQDi1Mu6cvkv31kXdMfBCu9pLaXeSmL2zz34olrcZ6PFuMkJat
         Ao2RpjamsMzd5DCeHrQoWD0tXWlOtenqe/jS/P8iyKdZVOav7Dot1uZ+tibCW9VaGmUZ
         VFFSP0BtpRQSKcN6zS1eBWyzHjH3tR3k29yCJJ7MgPcUWGA4A4i2ouhFD/YNggVQtRe4
         IiK0iP6wft9EUWOBupEbCWwosGl7asrqGsmHZcvT4aDtO/51z3/07Fu6wg+M5YmVIMT9
         sz/a9jdVCGsEmB1msdVI/BsRL0YaRq4bkYosG9JAT7mw7K9cgLNe7Y0LG+KQd6jfcPM8
         T/aw==
X-Gm-Message-State: AOAM533eKWS4R8Xq0sWRyqTzgR2yuXEfinGLfG9hKbBjEhmE865NHlJm
        7LEXc1jr9dkfZFvNQNAuekg1dg==
X-Google-Smtp-Source: ABdhPJzX1tY94b0sAG2sX2RGAzRFfSeylY1Gk2jypLzwQfDetLBeL47um2gOgg+XifX6naoVdPdpMQ==
X-Received: by 2002:a17:902:f64e:b0:14d:20db:8478 with SMTP id m14-20020a170902f64e00b0014d20db8478mr1687926plg.158.1645693282736;
        Thu, 24 Feb 2022 01:01:22 -0800 (PST)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id me14sm2221672pjb.41.2022.02.24.01.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 01:01:22 -0800 (PST)
Date:   Thu, 24 Feb 2022 14:31:20 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, nm@ti.com,
        sboyd@kernel.org, mka@chromium.org, dianders@chromium.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: opp: Add "opp-microwatt" entry in
 the OPP
Message-ID: <20220224090120.3f7sp23hism3wd36@vireshk-i7>
References: <20220224081131.27282-1-lukasz.luba@arm.com>
 <20220224081131.27282-2-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224081131.27282-2-lukasz.luba@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24-02-22, 08:11, Lukasz Luba wrote:
> Add new entry for the OPP which provides information about power
> expressed in micro-Watts. It is useful for the Energy Model framework.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  .../devicetree/bindings/opp/opp-v2-base.yaml      | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

Also need to update patternProperties section I think.

-- 
viresh
