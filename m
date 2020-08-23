Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB8F824EF79
	for <lists+linux-pm@lfdr.de>; Sun, 23 Aug 2020 21:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgHWTbl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 Aug 2020 15:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgHWTbk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 Aug 2020 15:31:40 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403FFC061573;
        Sun, 23 Aug 2020 12:31:40 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id g6so7233730ljn.11;
        Sun, 23 Aug 2020 12:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+n9yQYKjNKE6Ca5NdW7hAYXe/4MN1OyfmeKRWcj2nLQ=;
        b=nFwncRAwcg7lEz1gqxGOT+hUpbJF33iNu7dBhVovyvQulCyOTWsdw3Hmu1sKJMdLFE
         o9C83qJkT4lw6wfu8JtaIu4Aj+vLBiIQxYuThHq84gxfodfLXde/z/yCcs1GDCvdE7a0
         lY56kOJjEeD2TkjY0QDuXr0DtHwoEe+1doYHYjvYqFGKNoBL8b4W6O01W6t7gHqTwnSS
         lx0mkB8BfILuliwOlDh/VTeru9bjF47rViihzwPipXKUsvfeCIrE63x/Ci/atV8FRFhn
         vlv1ik5WyQvLWsfL/ON/R/zoc1Tga63rHrPEZ6nqZABEE0jUTOJL1ftt/3pIkBapy9ar
         lfvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+n9yQYKjNKE6Ca5NdW7hAYXe/4MN1OyfmeKRWcj2nLQ=;
        b=fqOi1NoHywgQ/rV6/wpi2aJDY+PM6hE93syMHsgc6dhPzG6zPQubt7+Of917HQk+SQ
         qWccZbzXpZ4u5aTrj8PaTgbrIFVEHB4/I3L7HimwNO9epMJ1Nyz447IDeykTbNCwkFMm
         8jOHCoYbmJxAAnHXLucnuyrvIzoiSPdB7mkggXTEek65Re9wRMwqAUPPvrZnKgHBQQd/
         vPUqLMfkqgySlsfSvcatLcpxSWU9vbRzjPTnZwo88p7E8U0ZpXaajeKiHsxAd+PmIr8b
         5q+CIHslNrze944QoI22YqqOm+8jKuwuj8m1gWKyA9hI57s6CEHZ13Gvl+8ueROja7nd
         mtvg==
X-Gm-Message-State: AOAM532nAXNtrZ94U0ejyNai7PU+WyKzqIvR1LY+pZUPtUiMYLUq/GFK
        YuWHLDLaQ3G3SAQInxbaRPe3cqg5z4M=
X-Google-Smtp-Source: ABdhPJwizHK3fmafWUkJXb8pYyXEcwK3lwpXVnJ1jVspMSTddzWJoCB2o2siEF8Vikk+5Yn0MZyYDQ==
X-Received: by 2002:a2e:9843:: with SMTP id e3mr1160500ljj.57.1598211098526;
        Sun, 23 Aug 2020 12:31:38 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id t16sm1790954ljo.27.2020.08.23.12.31.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Aug 2020 12:31:37 -0700 (PDT)
Subject: Re: [PATCH v1 4/6] dt-bindings: mfd: ene-kb3930: Add compatibles for
 KB930 and Acer A500
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200823140846.19299-1-digetx@gmail.com>
 <20200823140846.19299-5-digetx@gmail.com>
 <20200823182050.GA210632@demiurge.local>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <b91b96d2-89e1-feb7-a4d0-6fd19a173ab4@gmail.com>
Date:   Sun, 23 Aug 2020 22:31:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200823182050.GA210632@demiurge.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

23.08.2020 21:20, Lubomir Rintel пишет:
> On Sun, Aug 23, 2020 at 05:08:44PM +0300, Dmitry Osipenko wrote:
>> The ENE KB930 hardware is compatible with KB3930.
>>
>> Acer A500 Iconia Tab is Android tablet device, it has KB930 controller
>> that is running firmware specifically customized for the needs of the
>> Acer A500 hardware. This means that firmware interface isn't re-usable
>> by other non-Acer devices. Some akin models of Acer tablets should be
>> able to re-use the FW interface of A500 model, like A200 for example.
>>
>> This patch adds the new compatibles to the binding.
> 
> I've responded to patch 5/6 with what should've been said here [1].
> Sorry for the confusion.
> 
> In any case please consider adding a new binding file instead of
> modifying the kb3930 binding doc. It would also remove a dependency on
> my patch set which should have slipped out of maintainers' radar.
> 
> [1] https://lore.kernel.org/lkml/20200823180041.GB209852@demiurge.local/

Hello, Lubomir! I was doing some research about the differences of
KB3930 and KB930 before created this patch and my understanding is that
the controllers are mostly identical. I've seen posts from people who
replaced KB3930 with KB930 (and vice versa) on various notebooks and it
worked, although not always.

It's a very common practice to re-use binding in a case of a sibling
hardware. Do you know what are the exact differences between KB3930 and
KB930 which could justify having separate bindings?

The firmware implementation varies a lot from device to device, and
thus, each device needs to have its own driver in order to talk to the
firmware, but hardware description (i.e. DT binding) should be common
for all devices.
