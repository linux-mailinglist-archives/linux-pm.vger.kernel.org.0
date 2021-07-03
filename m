Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 150153BA9C6
	for <lists+linux-pm@lfdr.de>; Sat,  3 Jul 2021 19:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbhGCRZR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 3 Jul 2021 13:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhGCRZR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 3 Jul 2021 13:25:17 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D77C061762;
        Sat,  3 Jul 2021 10:22:42 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id r16so18120421ljk.9;
        Sat, 03 Jul 2021 10:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GkqlghX39ZQMv0VL5XMqearbdcMjcK0zkdFdKOtJnZE=;
        b=JPznIM0Ow6NR7CkKU2r2nhwUcgQydZM7A1VNBFp+isDWXxuevJXSfv8RQkurrGQL2k
         WPQI59y6D3Tsnx8EwwRGVJArttxiRuNmrmX1DG58hyG/SDRlYihmk353i+llBl2zLCjg
         fSfnVH9lD/Rjs5dJf9p75JWWl84pxuczO6ZuoD1hB9/JVLPHUnTQgeKPUkfLS/dmG/qs
         mu7ImVMZ3anXjv9croyzuBMSReWpgtRDi5WnHEFhqT59Iw0O6HEU7d/z8JGkWoGPo/Fb
         73S7EShfF1P5P9sxmGyFsvelgFUCsky2sQDBx8HSB7pWnbs6tI/NdFzBJAIfzggsLDFP
         PnUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GkqlghX39ZQMv0VL5XMqearbdcMjcK0zkdFdKOtJnZE=;
        b=GeCZbNj+hh0yyo7eYN02DKa4NLy1JaEjUhANj7AAm63LXNTdpYng27AjUrraamfinE
         RpsHUKymFlmZtoPrQ7/iwnDOLFt+yoFTK1lOgKxsGMMtxcRjqhSdS1WDy3ybieZJgXDV
         tj8eX8c3Do5ZLor2biOE5D012gN3nQCovPtQLkgJKqaZtAuRKnxA75EcevcNWpLJeuc0
         uGyO4Oq/L+ZGRo+GW6hTdWCrDcSUt7jEBMIXcQgrvMmcskmq67P9eEEThEnSW/Lnt01v
         H3fxRZT3EsVD04DlGUFBcWhLwmodp4L3NidcF1FfKQpFQ8V9s1uY6L3P3x5GJE5RgUWm
         a2uQ==
X-Gm-Message-State: AOAM532P/42N91FIo73btN+xMXlfihmTk/OKv73jlcFeWzleWR3ziOgm
        4hofPYh2lBOlWCclEBA9PqPYrFhtjsQ=
X-Google-Smtp-Source: ABdhPJz99JpS1s9M1J2vPLOFyo50q0z+BC5l0L+5Y8kLjHwHDWH3mZKaBsEFzY7LPxfB6iP5MWp3FQ==
X-Received: by 2002:a05:651c:504:: with SMTP id o4mr4090359ljp.357.1625332960228;
        Sat, 03 Jul 2021 10:22:40 -0700 (PDT)
Received: from [192.168.2.145] (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.googlemail.com with ESMTPSA id x3sm749371ljm.43.2021.07.03.10.22.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Jul 2021 10:22:39 -0700 (PDT)
Subject: Re: [PATCH v2 05/12] usb: otg-fsm: Fix hrtimer list corruption
To:     Peter Chen <peter.chen@kernel.org>
Cc:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        David Heidelberg <david@ixit.cz>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20210701234317.26393-1-digetx@gmail.com>
 <20210701234317.26393-6-digetx@gmail.com> <20210703110809.GA4289@Peter>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <29476aa3-c34e-8bf0-5eab-f7def493f329@gmail.com>
Date:   Sat, 3 Jul 2021 20:22:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210703110809.GA4289@Peter>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

03.07.2021 14:08, Peter Chen пишет:
> On 21-07-02 02:43:10, Dmitry Osipenko wrote:
>> The HNP work can be re-scheduled while it's still in-fly. This results in
>> re-initialization of the busy work, resetting the hrtimer's list node of
>> the work and crashing kernel with null dereference within kernel/timer
>> once work's timer is expired. It's very easy to trigger this problem by
>> re-plugging USB cable quickly. Initialize HNP work only once to fix this
>> trouble.
> 
> Fully OTG compliance support has not maintained for years, what's the use case you
> still want to use?

I don't have any use case for it, but I had CONFIG_USB_OTG_FSM=y and it
was crashing kernel badly. The OTG works perfectly fine without the FSM.
