Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCA3C3020AF
	for <lists+linux-pm@lfdr.de>; Mon, 25 Jan 2021 04:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbhAYDNU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 24 Jan 2021 22:13:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbhAYDNO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 24 Jan 2021 22:13:14 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12396C061573
        for <linux-pm@vger.kernel.org>; Sun, 24 Jan 2021 19:12:34 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id f63so7576542pfa.13
        for <linux-pm@vger.kernel.org>; Sun, 24 Jan 2021 19:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=urJs6HyiGePGW36OxGzHF9HD4lDBm01oVgmZ3FzjjN8=;
        b=wq5LV1NSa4zvkXCRKeEch78k1Isx5I3ys5QgrLmB/yKm0wuExPfrByc5l1bnFJ9AWI
         cY5Y05W+sdINMR/VRK1NCOD2Ltt8ETv68f/DSDHlT7F+4tvk93oGQOeYryVdkIlEqARs
         fE663ePh32Enyfwm0aIb9HqehH3DWUHokQTEwUDR5qasqDefCvP2FITWE2bLEUMyfJbx
         xagORdWSP7W3DiJPFdyDCCPatXnigJPX+vphSUA6W1Gh6gWg56rPFOsZRbhnN7AKjy+I
         uiB7F+Kwh5+4suMxFt11Zo2DdvcNzB0cKXMcoAIFgP4ytL1oM5rk6Zv94N28WLCDYs68
         G9MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=urJs6HyiGePGW36OxGzHF9HD4lDBm01oVgmZ3FzjjN8=;
        b=JjD7BV1UZRGDRJCV/L+GpLZsNEJmBVG/B+ExEiQAbV1seaAcpHTaU3mAqJTkPEyM1U
         nSUN2uwnUE02DjDVVGQzBlCZzxW82ITPJWXSSN3U/ec7+6fcfdhKx6q9wb1qzJhLgcrt
         wzwUwIPly+t9kXkorZ482OFDscCz2qiMU/S0yAO+uBmIVc9wEnkwRNDtaww0S8C3UdCP
         fGj8+pQxGIA106562cEg5smj0mwmd+x1r5rGdWg3tSlQISUZZ5zv8RyN/+ICQtKfa8A4
         ib6i6vrGsJTUm7qhD8i1vlhpNBWuUW6VOzzTPdJxAxfvW63mGISKPqSuUyXpurYdZoic
         baDw==
X-Gm-Message-State: AOAM533eTtogYKFDllGKtf5xFzqnyve4Y5AhO3urPdxGmAbv44+S5wPq
        wnUMtA0xZUoUV2pibV8Q0PYyIwF40p3prQ==
X-Google-Smtp-Source: ABdhPJyIgKLkBEtpBKoSzlAdFlIpt+usudr4M22M5kUkO2jZJTYTry2HYschwCElOMBa38EfuuSXew==
X-Received: by 2002:a65:4542:: with SMTP id x2mr8503202pgr.90.1611544353610;
        Sun, 24 Jan 2021 19:12:33 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id e20sm1273051pgr.48.2021.01.24.19.12.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jan 2021 19:12:31 -0800 (PST)
Date:   Mon, 25 Jan 2021 08:42:29 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 03/13] opp: Keep track of currently programmed OPP
Message-ID: <20210125031229.adthgnbzlcpt4btj@vireshk-i7>
References: <cover.1611227342.git.viresh.kumar@linaro.org>
 <96b57316a2a307a5cc5ff7302b3cd0084123a2ed.1611227342.git.viresh.kumar@linaro.org>
 <b634343a-8005-fc35-e38b-bfeaa7310a70@gmail.com>
 <20210122044532.pc7cpcgy3kjbqmls@vireshk-i7>
 <8af5abe4-fc3f-8ce4-ff14-542754f0275d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8af5abe4-fc3f-8ce4-ff14-542754f0275d@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22-01-21, 17:31, Dmitry Osipenko wrote:
> This may not be true for all kinds of hardware, a display controller is
> one example. If display's pixclock is raised before the memory bandwidth
> of the display's memory client, then display controller may get a memory
> underflow since it won't be able to fetch memory fast enough and it's
> not possible to pause data transmission to display panel, hence display
> panel may get out of sync and a full hardware reset will be needed in
> order to recover. At least this is the case for NVIDIA Tegra SoCs.

Hmm, but I expected that the request for more data will only come after the
opp-set-rate has finished and not in between. May be I am wrong. There is
nothing wrong in doing it the regulator way if required.

> I guess it's not a real problem for any of OPP API users right now, but
> this is something to keep in mind.

Sure, I am not against it. Just that we thought it isn't worth the code.

-- 
viresh
