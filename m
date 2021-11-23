Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2622C4599DF
	for <lists+linux-pm@lfdr.de>; Tue, 23 Nov 2021 02:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbhKWBz7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Nov 2021 20:55:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbhKWBzz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Nov 2021 20:55:55 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D742C061759
        for <linux-pm@vger.kernel.org>; Mon, 22 Nov 2021 17:52:48 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id p23so25920364iod.7
        for <linux-pm@vger.kernel.org>; Mon, 22 Nov 2021 17:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7Oi7YYe6mXZ9qFhiItC3cT+zBCj+1FGQIOXFSu9z5Og=;
        b=EMJHfp61byAPVM0d+YSPglX9cQhq+7ayPyr9zRTzuSPcvvgnxyLMG1ltK8vjfaD0FU
         tlPYxbO7NtBZeDgMPNcJJoHVx+Je8+bWQnN+DVWW1NrLrqmC5gQjAph9/LWH4uiuxcYY
         wd41pmLNfefVdVvVpoPO9twaon39sVO4IspOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7Oi7YYe6mXZ9qFhiItC3cT+zBCj+1FGQIOXFSu9z5Og=;
        b=2yUgjqqmg05s+VjEDMco1xOILjxIuMuxmMdevdoT+El1y5+Yk5rteRnHGe1H7sn/rz
         2ZKD267PJC7D2Eg12/oPcKjrnde0oGVJwlcXEV4RkNoEC+/Icj/GW3txDfqlk31R/awd
         u+p3VNlPsiiPY6SUaMH6LxgY0fwlZAwoYywxLCNmlAlIBMerVzEecilz9zzXASXMByRG
         uK6PqITzPqOC2SNDG30OWUYaiapbDl48KQb+nVVOwlUT2Gs97z2EuY39bZHmS41u8mMi
         J8/VppEAjvGxeqH3TrOmzatg/vod2GMZL2+3p46cy3tBHGQy0rec7wJ/iTh/2+koRdxD
         FtpQ==
X-Gm-Message-State: AOAM530R23Sp3u4yRzcTNC2Lr1DrdmSntwJwM96mXl8xPx0P4i9l9yP8
        Kb1g5F/JPNoMqjRiToiG517cCA==
X-Google-Smtp-Source: ABdhPJwFYEXqq9O3YpMuHp49czIlbhiXDJHljcLoM+vErOaDm/O2cJ+JlOI+DmxoJkJ4K5f7Ve5+nA==
X-Received: by 2002:a05:6638:14ca:: with SMTP id l10mr1120728jak.107.1637632367373;
        Mon, 22 Nov 2021 17:52:47 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id d137sm6102931iof.16.2021.11.22.17.52.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Nov 2021 17:52:47 -0800 (PST)
Message-ID: <5936f811-fa48-33e9-2a1a-66c68f74aa5e@ieee.org>
Date:   Mon, 22 Nov 2021 19:52:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 01/17] bitfield: Add non-constant field_{prep,get}()
 helpers
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Paul Walmsley <paul@pwsan.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Tero Kristo <kristo@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Benoit Parrot <bparrot@ti.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        alsa-devel@alsa-project.org
References: <cover.1637592133.git.geert+renesas@glider.be>
 <3a54a6703879d10f08cf0275a2a69297ebd2b1d4.1637592133.git.geert+renesas@glider.be>
 <01b44b38c087c151171f8d45a2090474c2559306.camel@sipsolutions.net>
From:   Alex Elder <elder@ieee.org>
In-Reply-To: <01b44b38c087c151171f8d45a2090474c2559306.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/22/21 10:32 AM, Johannes Berg wrote:
> On Mon, 2021-11-22 at 16:53 +0100, Geert Uytterhoeven wrote:
>> The existing FIELD_{GET,PREP}() macros are limited to compile-time
>> constants.  However, it is very common to prepare or extract bitfield
>> elements where the bitfield mask is not a compile-time constant.
>>
> 
> I'm not sure it's really a good idea to add a third API here?
> 
> We have the upper-case (constant) versions, and already
> {u32,...}_get_bits()/etc.

I've used these a lot (and personally prefer the lower-case ones).

Your new macros don't do anything to ensure the field mask is
of the right form, which is basically:  (2 ^ width - 1) << shift

I really like the property that the field mask must be constant.

That being said, I've had to use some strange coding patterns
in order to adhere to the "const only" rule in a few cases.
So if you can come up with a satisfactory naming scheme I'm
all for it.

					-Alex



> Also, you're using __ffs(), which doesn't work for 64-bit on 32-bit
> architectures (afaict), so that seems a bit awkward.
> 
> Maybe we can make {u32,...}_get_bits() be doing compile-time only checks
> if it is indeed a constant? The __field_overflow() usage is already only
> done if __builtin_constant_p(v), so I guess we can do the same with
> __bad_mask()?
> 
> johannes
> 

