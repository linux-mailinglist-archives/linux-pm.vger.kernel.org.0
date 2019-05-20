Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF825231C8
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2019 12:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731317AbfETKv4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 May 2019 06:51:56 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36270 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730549AbfETKv4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 May 2019 06:51:56 -0400
Received: by mail-pl1-f193.google.com with SMTP id d21so6562323plr.3
        for <linux-pm@vger.kernel.org>; Mon, 20 May 2019 03:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1YuRtghB95O7LhcsLf1/GyzlG0H9oHKpVmg43qxycAc=;
        b=kYY51UqLfQVqkc2pUGOEqHYiVJK7aLiK83xI/QmKPQ83rVUHjubs4HhY3WgnjPV8Ph
         +p6tCG9P+dJnHcchn3HiDctSF0yQA26bk8LSB219E644Gsm0Z1FLqUnsS3+r6pJNU7JM
         F9fLagHSp3Mz6H1zX6oNBvGJ6baL05JXajQShS4uasI188DbB4upGMpFgPkkW+o5f/bL
         ZE36aahLuXDGd9PJjztiqIChzQIpcJ3YH/cNwgrxJTR7413qQpHk/qUWWIKNe90WjxM9
         DRjIBj6m38yHeJnptCfjNj2CpXQpeb1y+/vPkFdyv5gLFdczZtBRPIChvp1j2Pp2eUc4
         ZEUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1YuRtghB95O7LhcsLf1/GyzlG0H9oHKpVmg43qxycAc=;
        b=Nzk02jP1LPAv+FHoOBh4IEPXfN6qC+TMiXZhUowGPekPsainKHXjpPMpnhf07FQJpz
         4SksJmOx2GpaldzNg1ydY+aauZCP68KgqGmKPY1zVhJ//Z7ezftB+v3/wOxSiUNzFCKo
         XZI/ODU5216Hk/p7mIpHhsAubvrPhuj5B+qcaalUlCFCD1uWDN3fuyf+H+JHAN4N6Dvi
         CD65ZSaQbLC0NMQ1d8tBvwtdA8CA5KM3m5yJS792EPhic67iQaboK9E62o0vEg/u8gPV
         gwJfYoFXTdWW0Y6ExcvLCMNPOwZTykBL+SNbbzcYTlWuSubpvEcU3Mbv8DKsM0zJJrDW
         kSEg==
X-Gm-Message-State: APjAAAVlPp+n18lR0o8kzRA5lMSof4LGZW/eWWfrKi8MlZ2YVN3/Qwa0
        OO2zpCn3KwFWXiY4dAh9uGzgQKhKeBo=
X-Google-Smtp-Source: APXvYqx2xIC25FoDnT5f3U0WxisE/vb00p1qHkPCPrdQV39EMhcy4uT+6FeiH4ZP+MSjumuKX4Eyww==
X-Received: by 2002:a17:902:f20b:: with SMTP id gn11mr75087490plb.126.1558349515329;
        Mon, 20 May 2019 03:51:55 -0700 (PDT)
Received: from localhost ([122.172.118.99])
        by smtp.gmail.com with ESMTPSA id k9sm20248370pfa.180.2019.05.20.03.51.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 03:51:54 -0700 (PDT)
Date:   Mon, 20 May 2019 16:21:53 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     stefan.wahren@i2se.com, devicetree@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        mbrugger@suse.de, rjw@rjwysocki.net, sboyd@kernel.org,
        eric@anholt.net, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, ptesarik@suse.com,
        ssuloev@orpaltech.com, linux-clk@vger.kernel.org,
        mturquette@baylibre.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 0/5] cpufreq support for the Raspberry Pi
Message-ID: <20190520105153.ftlnjx7ocr2qkxhd@vireshk-i7>
References: <20190520104708.11980-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520104708.11980-1-nsaenzjulienne@suse.de>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20-05-19, 12:47, Nicolas Saenz Julienne wrote:
> Hi all,
> as some of you may recall I've been spending some time looking into
> providing 'cpufreq' support for the Raspberry Pi platform[1]. I think
> I'm close to something workable, so I'd love for you to comment on it.
> 
> There has been some design changes since the last version. Namely the
> fact that I now make sure *only* the CPU frequency is updated. The
> firmware API we use has two modes, with or without turbo. Enabling turbo
> implies not only scaling the CPU clock but also the VPU and other
> peripheral related clocks.  This is problematic as some of them are not
> prepared for this kind frequency changes. I spent some time adapting the
> peripheral drivers, but the result was disappointing as they poorly
> support live frequency changes (which most other chips accept, think for
> instance I2C and clock stretching) but also turned out hard to integrate
> into the kernel. As we were planning to use 'clk_notifiers' which turns
> out not to be such a good idea as it's prone to deadlocks and not
> recommended by the clock maintainers[2]. It's also worth mentioning that
> the foundation kernel doesn't support VPU frequency scaling either.
> 
> With this in mind, and as suggested by clock maintainers[2], I've
> decided to integrate the firmware clock interface into the bcm2835 clock
> driver. This, in my opinion, provides the least friction with the
> firmware and lets us write very simple and portable higher level
> drivers. As I did with the 'cpufreq' driver which simply queries the max
> and min frequencies available, which are configurable in the firmware,
> to then trigger the generic 'cpufreq-dt'.
> 
> In the future we could further integrate other firmware dependent clocks
> into the main driver. For instance to be able to scale the VPU clock,
> which should be operated through a 'devfreq' driver.
> 
> This was tested on a RPi3b+ and if the series is well received I'll test
> it further on all platforms I own.

Please always supply version history on what has changed from V1. And
why do you keep sending it as RFC ? Just keep the default PATCH thing,
the patches are in good shape I would say.

-- 
viresh
