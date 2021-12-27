Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B15447FA11
	for <lists+linux-pm@lfdr.de>; Mon, 27 Dec 2021 05:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbhL0EPg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 26 Dec 2021 23:15:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235184AbhL0EPf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 26 Dec 2021 23:15:35 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C1AC06173E
        for <linux-pm@vger.kernel.org>; Sun, 26 Dec 2021 20:15:34 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 200so12630125pgg.3
        for <linux-pm@vger.kernel.org>; Sun, 26 Dec 2021 20:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dZHrX8TEd1s1Rvq7azrt0NBXkVOb5WFezTF0/TFNa/E=;
        b=CmnCQPPWTzj+M0BTCCL947qVsPfzWjH3Pl606mcz9a2S5Bxtez5W7iqDw2ZQN+yLUR
         RQXdeIg9rqH1ROQYts0zkZHAPEq8tsbFRH0WtkeTvTB6+oQQAI6OCkZc4HEIVMUIajvG
         mo/Td2ueAp7Ay8a41BAO79BigDIkTnhCR9RcheSGFCBohp5Wbosa1oRXtt3PBiPXJTN9
         taJU9hdO5yRyzUMhVRMKXXcKnNt4duYCVynwMa9cxFuhvlLdYN9mSn+cviQrbjC9LaiU
         s54fTFde9PX2uJz88Zs0SGnAHq1TUTYoYFqKE1bfeQVKAwLmgz/OBiTQ+XoxCYiwyzUY
         qg3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dZHrX8TEd1s1Rvq7azrt0NBXkVOb5WFezTF0/TFNa/E=;
        b=Cnc7Fb3IWAu8RelmECajr7pYS7ws2BmBl/qAVMr1qx8Dgp9x/DNKKhgKmUWRRWoerD
         jo84RpoX7n667zsWqbpqaUlTKyGRJdBwYqjFmvM4OoR409+Jx1AVa+hNkTTZRLFmxoua
         oFxBWknNZTwSIkJrZdy1Ar+xAHvYPdK1cJmiPxlDxXrZuZ+byF4mYZb65C9TEnG8Pnid
         i8eo6i2hEiEk10jOC2VOSTouLvmOzPN7WncDBNdG7GUIl5dNHiTj1HECaU9D9285lLu3
         Ucin9uqDT8jM6kKtMP3Aa7PcwqDpSTrURpNTD5A6tSCxwADoRX2ho3ZYmkH1EGLAlzKs
         AEeg==
X-Gm-Message-State: AOAM531UI0b1ofnKzqL+D38goNGyOSdHBScpv/bINngiPAVynFJciES2
        aFARQFCrPKs6L51OUxb7eAAX2A==
X-Google-Smtp-Source: ABdhPJzz/7eIXRXYn/RgMkdl62Ozc24gm2sKtZeKxBbyT2flMNofiYyzcfQjK+wvgEeGVQVlly1E3Q==
X-Received: by 2002:a05:6a00:14d3:b0:4ba:8ccb:73f1 with SMTP id w19-20020a056a0014d300b004ba8ccb73f1mr16105452pfu.65.1640578533460;
        Sun, 26 Dec 2021 20:15:33 -0800 (PST)
Received: from localhost ([106.201.42.111])
        by smtp.gmail.com with ESMTPSA id g5sm16502101pfj.143.2021.12.26.20.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Dec 2021 20:15:32 -0800 (PST)
Date:   Mon, 27 Dec 2021 09:45:31 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Hector Yuan <hector.yuan@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, wsd_upstream@mediatek.com
Subject: Re: [PATCH v1 1/1] cpufreq: mediatek-hw: Fix double devm_remap in
 hotplug case
Message-ID: <20211227041531.5w5lhrk4a7jzz64x@vireshk-i7>
References: <1635507743-17919-1-git-send-email-hector.yuan@mediatek.com>
 <1635507743-17919-2-git-send-email-hector.yuan@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1635507743-17919-2-git-send-email-hector.yuan@mediatek.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 29-10-21, 19:42, Hector Yuan wrote:
> From: "Hector.Yuan" <hector.yuan@mediatek.com>
> 
> When hotpluging policy cpu, cpu policy init will be called multiple times.
> Unplug CPU7 -> CPU6 -> CPU5 -> CPU4, then plug CPU4 again.
> In this case, devm_remap will double remap and resource allocate fail.
> So replace devm_remap to ioremap and release resources in cpu policy exit.
> 
> Signed-off-by: Hector.Yuan <hector.yuan@mediatek.com>
> ---
>  drivers/cpufreq/mediatek-cpufreq-hw.c |   33 ++++++++++++++++++++++++++++++---
>  1 file changed, 30 insertions(+), 3 deletions(-)

Applied. Thanks.

-- 
viresh
