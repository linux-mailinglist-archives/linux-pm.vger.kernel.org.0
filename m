Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE785246F7
	for <lists+linux-pm@lfdr.de>; Thu, 12 May 2022 09:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350972AbiELH30 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 May 2022 03:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351013AbiELH3Y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 May 2022 03:29:24 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D9313C095
        for <linux-pm@vger.kernel.org>; Thu, 12 May 2022 00:29:22 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id c9so4116879plh.2
        for <linux-pm@vger.kernel.org>; Thu, 12 May 2022 00:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P5HUXEPOvBMLE8fEsuwCBiB+Q1qgQLDGbaTHhCwoMe8=;
        b=o5Z5fV0XV36DZH9ayGrfnl8qVxiWuzspeT5gnxwUrHidCaa+tEthe7DF0xG8IhHRnH
         jbDAxfFA+vFhlKs8TliSi7SNZQNw2cTItQSYVMabTBsOE6/aN6wtu6u+mpUqn1RUfgFS
         979KmVpZazbdbBvOVinimrA1IoyyO+lowJnL5WpIoDN5cmF9z5vmc7Jz2eFRtDEzfp1t
         L6pxr8VVt02arwTG33X8AwuJImwvj+620Bi8T9JcN48MEr0bxM6TEj/nyvTI7cyJECCb
         HGuduVAUgYq1F7DQagX3YRgMoRXkXQdgYIQV7Tk+BeX4HJfnPiCxdaRg2lMuW7zN3U8C
         Sl5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P5HUXEPOvBMLE8fEsuwCBiB+Q1qgQLDGbaTHhCwoMe8=;
        b=SKyCjCa7ksCtxsRw1EabTqJ+GpLuwOhH21WURDAZXEbTpgveCTLo19POmV1wBRwO9f
         g8mZpm7r20VyjEAWvAg0rWlfCHft81dMqH9X79UPerJUAba2hYkAcFlaImT9J0jEWnyw
         vqrrQknG2E++AFhOzWP8LVyA/9HNw93ARAuzPfMk00UGFGjG0tK7/LUPI2SIY2nU6QI1
         SnhFygmrZvZX9t/Us9MaLJ4J9yFDPpS/VdGa4BogAW/Dcg5kwOMCi5idX+IZbFiPh2gx
         O8Xq+mqxx9fWdvuihM7BxkdYDb8t1eAEKL11WmkN/J1ZUwatcB9jT1diod05r71DmrLd
         sb5Q==
X-Gm-Message-State: AOAM533eDRTTmH9DhFsgxq2nWb4tbmiyBA9s9jHqoT51BbJ3Cb8vRpCd
        2Uoe8AhlCwAzXxiuOAuckjTSJg==
X-Google-Smtp-Source: ABdhPJypLn7YyngE6rmboJLB85iyymD1k6g9lMwHwVnR3EpfOxbp8POTUSTQMDHng1V/ia/kWWRoKA==
X-Received: by 2002:a17:902:b189:b0:15f:3f5e:b61 with SMTP id s9-20020a170902b18900b0015f3f5e0b61mr3417397plr.49.1652340562190;
        Thu, 12 May 2022 00:29:22 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id w6-20020a170902d3c600b0015e8d4eb2b0sm3139958plb.250.2022.05.12.00.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 00:29:21 -0700 (PDT)
Date:   Thu, 12 May 2022 12:59:19 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     qianfanguijin@163.com
Cc:     linux-sunxi@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 1/2] ARM: dts: sun8i-r40: add opp table for cpu
Message-ID: <20220512072919.hkggxbqmovebdych@vireshk-i7>
References: <20220512071858.10805-1-qianfanguijin@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512071858.10805-1-qianfanguijin@163.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12-05-22, 15:18, qianfanguijin@163.com wrote:
> From: qianfan Zhao <qianfanguijin@163.com>
> 
> OPP table value is get from allwinner lichee linux-3.10 kernel driver
> 
> Signed-off-by: qianfan Zhao <qianfanguijin@163.com>
> ---
> Changes in v3:
> - remove "allwinner-r40" compatible from allowlist.
> - split dts in two part.
> 
>  arch/arm/boot/dts/sun8i-r40.dtsi | 47 ++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)

Both the patches can go via SoC tree now. I will not pick them. Thanks.

-- 
viresh
