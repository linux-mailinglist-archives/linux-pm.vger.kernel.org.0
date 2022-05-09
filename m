Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029E251F8B2
	for <lists+linux-pm@lfdr.de>; Mon,  9 May 2022 11:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236058AbiEIJsf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 May 2022 05:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238282AbiEIJfn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 May 2022 05:35:43 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2163D1A0AC5
        for <linux-pm@vger.kernel.org>; Mon,  9 May 2022 02:31:49 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id s16so1453422pgs.3
        for <linux-pm@vger.kernel.org>; Mon, 09 May 2022 02:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JpCRaDNZYevpLkY4KOz+K7YSl/uzka5d9oakp3W77tc=;
        b=HCmVcQ84A1B0mzXMIys8FhK9PENXHAKemAfPPPxoXKFdSh1QQXAzaPKVIqUEZLBs3/
         H3pOb5uEAcuA5+F3hsUEogfhE/lRjNABeErSGu86+1ArNxEujpz8rVgWRX6v8tqEHwvx
         0Xqpg/6Ry0GYJyosH55MLUfXrVeFOeBbGMK0uDInQXOaKGgdh2bcfZdABop9RngLLwa+
         byDloH8cGSO4Dgs0GAKgT2GGWD3uNvjIr77nTWojR1RPoerG/QTxBZopGJZ/enkgNXjI
         JKPl1sWprQahCNAmvlKDtaIJKpENBTMrQIA16/z2HPN40vin7eLoO7VkkbrQPSCVNvLk
         7pew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JpCRaDNZYevpLkY4KOz+K7YSl/uzka5d9oakp3W77tc=;
        b=Dc4FvLP7URHfm+OTcyEOh4ZFYecIHGYoBykIjYSShJzkZTPwOhGw926hk/jNKb/+Dp
         kI5EgV4uuHXrYzJntD3459Xj1PFb+Rel5D8bfdfjd+NgfEarBo7w+OiyJQE3FCgcXgcN
         pob70v7I96dV7ACsJmzPaP1q5mtK6zy3lqA3ASEKWxZiJ6WlTOEN0fJr20imhFhyICCr
         tvQn2UJoMz2pW/tdPkode7gaFU40pkRoXOf2w1rO6S4p8QoF1mjfvhVpZLHq+7OKts3Q
         EpMxcxqxdTM3fQyCtnEDRRhKd9ggQmiNd5KV4wrmmMNV/fhrDEkIyWQo/HQ3L2DqQn2Z
         wuYA==
X-Gm-Message-State: AOAM530eb2eUnhe4oSFwUBOExJ9dt4UOCtLnnS8Jh5wzl6oMyZuITw7s
        hTvCxsKcY4cmoBjUMNN6xREspg==
X-Google-Smtp-Source: ABdhPJxdD04mCtOjOZoG59KlHgaCvKklPPxlk10wG2ZHb2KCQ4qNWZv9oKioDl7bTyyCDTPNP632lQ==
X-Received: by 2002:a63:ad0c:0:b0:374:50b4:c955 with SMTP id g12-20020a63ad0c000000b0037450b4c955mr12237883pgf.530.1652088692871;
        Mon, 09 May 2022 02:31:32 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id n28-20020a056a000d5c00b0050dc7628148sm8110335pfv.34.2022.05.09.02.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 02:31:32 -0700 (PDT)
Date:   Mon, 9 May 2022 15:01:30 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     qianfanguijin@163.com, linux-sunxi@lists.linux.dev,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1] drivers: cpufreq: sun8i-r40: Add cpufreq support
Message-ID: <20220509093130.jegqpe6m7xtbouqa@vireshk-i7>
References: <20220509084853.17068-1-qianfanguijin@163.com>
 <20220509091125.tps3zwaq276jlgh3@vireshk-i7>
 <20220509092306.22ttfunrislztbvh@houat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509092306.22ttfunrislztbvh@houat>
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

On 09-05-22, 11:23, Maxime Ripard wrote:
> Hi,
> 
> On Mon, May 09, 2022 at 02:41:25PM +0530, Viresh Kumar wrote:
> > On 09-05-22, 16:48, qianfanguijin@163.com wrote:
> > > From: qianfan Zhao <qianfanguijin@163.com>
> > > 
> > > OPP table value is get from allwinner lichee 3.10 kernel.
> > > 
> > > Signed-off-by: qianfan Zhao <qianfanguijin@163.com>
> > > ---
> > >  arch/arm/boot/dts/sun8i-r40.dtsi     | 47 ++++++++++++++++++++++++++++
> > >  drivers/cpufreq/cpufreq-dt-platdev.c |  1 +
> > >  2 files changed, 48 insertions(+)
> > 
> > Applied. Thanks.
> 
> Shouldn't you wait for the maintainers feedback for the DT bits at least?

I should have, will drop it.

-- 
viresh
