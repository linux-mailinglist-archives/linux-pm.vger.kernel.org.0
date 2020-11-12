Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8D92B03DF
	for <lists+linux-pm@lfdr.de>; Thu, 12 Nov 2020 12:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbgKLLbt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Nov 2020 06:31:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbgKLLbW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Nov 2020 06:31:22 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CDEC0613D1
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2020 03:31:21 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id b8so5650585wrn.0
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2020 03:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3hFMOP1kaxx+iv9jwczEH0E7M8oIpI0wqn8jI0YaIqg=;
        b=KWiedg5B8zn8+OwTMdiLZ4n5EMt3C6INPsBizaMz8ELeM8BUQGUIavGDdB9r4HTo4c
         F+vGtgQu+WQ8/iG623+aYr8VF4o38HJZKpHY3uBooBfaPRBfKoO815KlHlLJ9aTzUsJ2
         pIuVq3+JI/A3T2nqK9xNMJD/bNOHF0DZS2eU9qF1DmJF8KVRier9cXpnFPvjx/Aoh+9e
         eEGLoeo3uTbbnZqUv3f0qXPHbzP8Cm8GwGmerb3VVxsh5s4P/YWB90B0BIyk+dyYQCeu
         YT0IVs71kpfrQl9SS1js/LmN7m5h4Woad3ZvPGpozgJfiVbyPj32xJlt7g85l5CyVkBU
         olQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3hFMOP1kaxx+iv9jwczEH0E7M8oIpI0wqn8jI0YaIqg=;
        b=FFMCTLpP2TtxMHg6qjytuPnygX/fRyc8CeHZHMditO8OaVuqCIWGFNmi7cRPM2hjLV
         u5KvpDKJ1lF1dKvqpDM4cZs2vq5mmVV/HEaJRekZ+K3OhEFo5/Z9ymTlJU2FmQlwHXh4
         MDoLGd5UnUKjtE2HXBP4N2UlJvq8s9pcQjjzts/Xh6gR88Rhg7eT1ES+cbixiou93SYI
         pPWhMqPP7ycbWS4OhIOFtg704EGTZrzBDyZGgM7sG5JPG3ogDC8TyPcQEGrq4DGv4wzU
         07UHM8pEMEbtzNuqUDshxKpxRCuUWpyAzUKezF54Oycafj0H+aEfmtPaXbUq6I1jwXgh
         Lxkg==
X-Gm-Message-State: AOAM533V2FJMLLKI4iNbOLlV1693g6HEZVlxZsvgG1sMdjytiDu3fAXV
        BlIFLYwewUtn3pMY7otKpS0OCg==
X-Google-Smtp-Source: ABdhPJxJS6tYcViiFkrzHimtT5xX5JSJCBovTbYGDgIf8pM3wALfxQu5oLVoNrcxEt8jioJWJdBHuQ==
X-Received: by 2002:adf:82cc:: with SMTP id 70mr34276916wrc.74.1605180680484;
        Thu, 12 Nov 2020 03:31:20 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:6971:b700:3764:fa96? ([2a01:e34:ed2f:f020:6971:b700:3764:fa96])
        by smtp.googlemail.com with ESMTPSA id a18sm5854108wmm.22.2020.11.12.03.31.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2020 03:31:19 -0800 (PST)
Subject: Re: [PATCH] thermal: ti-soc-thermal: Disable the CPU PM notifier for
 OMAP4430
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tony Lindgren <tony@atomide.com>
Cc:     edubezval@gmail.com, j-keerthy@ti.com, aford173@gmail.com,
        linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        andreas@kemnade.info
References: <20201029100335.27665-1-peter.ujfalusi@ti.com>
 <20201029105125.GJ5639@atomide.com>
 <b05f4bae-c285-828b-d5f1-fbf8613b4ca4@ti.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <77940e9a-0e1a-f389-645a-071db5e1fcb5@linaro.org>
Date:   Thu, 12 Nov 2020 12:31:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b05f4bae-c285-828b-d5f1-fbf8613b4ca4@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03/11/2020 07:42, Peter Ujfalusi wrote:
> Eduardo, Keerthy,
> 
> On 29/10/2020 12.51, Tony Lindgren wrote:
>> * Peter Ujfalusi <peter.ujfalusi@ti.com> [201029 10:03]:
>>> Disabling the notifier fixes the random shutdowns on OMAP4430 (ES2.0 and ES2.1)
>>> but it does not cause any issues on OMAP4460 (PandaES) or OMAP3630 (BeagleXM).
>>> Tony's duovero with OMAP4430 ES2.3 did not ninja-shutdown, but he also have
>>> constant and steady stream of:
>>> thermal thermal_zone0: failed to read out thermal zone (-5)
>>
>> Works for me and I've verified duovero still keeps hitting core ret idle:
> 
> Can you pick this one up for 5.10 to make omap4430-sdp to be usable (to
> not shut down randomly).
> The regression was introduced in 5.10-rc1.
> 
>> Tested-by: Tony Lindgren <tony@atomide.com>

Applied as a fix for v5.10-rc



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
