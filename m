Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41AAD57498C
	for <lists+linux-pm@lfdr.de>; Thu, 14 Jul 2022 11:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237743AbiGNJth (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Jul 2022 05:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237979AbiGNJtN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Jul 2022 05:49:13 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B48D54C97
        for <linux-pm@vger.kernel.org>; Thu, 14 Jul 2022 02:47:13 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id d16so1782192wrv.10
        for <linux-pm@vger.kernel.org>; Thu, 14 Jul 2022 02:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hz+S9gbmjTBRbI9IGEo00yr8q6U8gYAIZkZve+s14sI=;
        b=jGRWumBYRWsPFRAHiNOF9bcUJ5TNxCTJ10BCXYBR6dF5XY8QP1BaD0ju5ijzduBadz
         M7fhdhDNh9X474nV6zPJ7e1R/z8AAJRizIr/3CpUbGzGKBc7QY0JT2IoCubdKhUsVB2D
         Fo9X7Qexd9TDha4225wY5GnXsVw+Qq4igsIWi7ZGskKx65onGrtT5A4Eai7F7A/5TU5q
         ehpk/JuiqKYzmvo58fp5IXfwHX6D2oDhRs4pu5dG34iaFTJb/8kDr/vljaafddvSmTQt
         FofPVS5NrtArjBlTl0domfLu4V5bkUAzCbxcFxSi14WPEKaNDZDAnaRvllsVTcVTH+E8
         GmTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hz+S9gbmjTBRbI9IGEo00yr8q6U8gYAIZkZve+s14sI=;
        b=uKgJJXE0xryMs84PG3LsEp+2MFJWgwBfeI9vWh7Kz2p+7ZenlQqlUN9MIdZBMzR6bc
         fKcshEq+Lh0JOyeF1a6UvX4JCNJ3MQzJWao1WHJ4tikObm4FwOe0k83w4eAjR+HY0AIs
         tjMDbY0tytaMklI1RmVHnI9GdaAjFZ8sZXbJUU3H2klNzs/zlVKl5MZ9EYwtRakYaqIA
         1drbKxCGuMCwVj4ETtYWCZ8AEzPBWvDufezfVeTaEc0TwplU2PROi4Vqs6J9GiLjsyOT
         mno7zsiyHbUhd8NoNtu6TsDSsyJ9rvcIyAdFVjThLTvsRYas6EUKqDfdcTHtgQqZv4j1
         FWOw==
X-Gm-Message-State: AJIora+YI8Bz84B26JsTmASGXoUYPCJfZW37AdowWD66F2w2VhWPXZb8
        c6kY3PGrWs+KkqH88FZiuAljMg==
X-Google-Smtp-Source: AGRyM1vnaGqcjfiDi9IGxZuq03hn9M2jXCQvULWiEOP+eJIxh4bgzvMgPaE9Bz5dtGUwBLz/VP+cVQ==
X-Received: by 2002:a05:6000:12c8:b0:21d:6913:89af with SMTP id l8-20020a05600012c800b0021d691389afmr7419194wrx.546.1657792031934;
        Thu, 14 Jul 2022 02:47:11 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id bg10-20020a05600c3c8a00b003a0323463absm1456168wmb.45.2022.07.14.02.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 02:47:11 -0700 (PDT)
Date:   Thu, 14 Jul 2022 10:47:09 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     ChiaEn Wu <peterwu.pub@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        Helge Deller <deller@gmx.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Alice Chen <alice_chen@richtek.com>,
        cy_huang <cy_huang@richtek.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        szuni chen <szunichen@gmail.com>
Subject: Re: [PATCH v4 13/13] video: backlight: mt6370: Add Mediatek MT6370
 support
Message-ID: <20220714094709.6ekfnfcf5sktiegi@maple.lan>
References: <20220704053901.728-1-peterwu.pub@gmail.com>
 <20220704053901.728-14-peterwu.pub@gmail.com>
 <CAHp75VdwEc9AW1w8ejsxkw+sBTF1dumd99QyzTY9BZaXiViRWQ@mail.gmail.com>
 <CABtFH5K-2+2hbpvpq2nPE5AsznkQxZF2r3MVC64Q39DJhVuUtA@mail.gmail.com>
 <CAHp75VevDwdAKLYEWJgnMDvzuPuFibLuVqH-GKazEOT76wM6_A@mail.gmail.com>
 <CABtFH5LT1Ct_9-B_XRrGwYFmL5kGS6KHR7dNVyUO5z4sTy_6oA@mail.gmail.com>
 <CAHp75VcU_9Ao2CoqiUDZHqhVOjEMZor+hctPp3YYP4HOjYLDUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VcU_9Ao2CoqiUDZHqhVOjEMZor+hctPp3YYP4HOjYLDUg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jul 14, 2022 at 11:27:07AM +0200, Andy Shevchenko wrote:
> On Thu, Jul 14, 2022 at 9:13 AM ChiaEn Wu <peterwu.pub@gmail.com> wrote:
> > I have tried two methods so far, as follows
> > -------------------------------------------------------------
> > /*
> >  * prop_val =  1      -->  1 steps --> b'00
> >  * prop_val =  2 ~  4 -->  4 steps --> b'01
> >  * prop_val =  5 ~ 16 --> 16 steps --> b'10
> >  * prop_val = 17 ~ 64 --> 64 steps --> b'11
> > */
>
> So, for 1 --> 0, for 2 --> 1, for 5 --> 2, and for 17 --> 3.
> Now, consider x - 1:
> 0  ( 0 ) --> 0
> 1  (2^0) --> 1
> 4  (2^2) --> 2
> 16 (2^4) --> 3
> 64 (2^6) --> ? (but let's consider that the range has been checked already)
>
> Since we take the lower limit, it means ffs():
>
>   y = (ffs(x - 1) + 1) / 2;
>
> Does it work for you?

To be honest, for this tiny table, writing code that *doesn't* require intricate
deciphering together with a huge comment saying what is does would probably be
better:

		prop_val = (prop_val <=  1 ? 0 :
		            prop_val <=  4 ? 1 :
			    prop_val <= 16 ? 2 :
			                     3);

This would be "obviously correct" and require no comment.


Daniel.
