Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3453B2611E9
	for <lists+linux-pm@lfdr.de>; Tue,  8 Sep 2020 15:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730064AbgIHNOx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Sep 2020 09:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729960AbgIHLS0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Sep 2020 07:18:26 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63266C061757
        for <linux-pm@vger.kernel.org>; Tue,  8 Sep 2020 04:18:22 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id gf14so7863139pjb.5
        for <linux-pm@vger.kernel.org>; Tue, 08 Sep 2020 04:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+yj7E7wqvb/129I+Etr+MWEdaS4FH4xTeleftUlUtU0=;
        b=Hb/Gwn9Q/dtKSqnvZ8CsNoSc8NYoacrOTGentUWFuYZ//RBTfJZCyLOSWy3EEoxKDI
         kixhwhlBZq4YpgWNwSiOzuMXgKVLUOLMjGvMRPGjYqGRxnWKHaGVDLaCsE9kqTH6JBd+
         CuypC+LI0FACS3fjyRl0huAdpR6fGhldDovl5EgHkRYh7NIgDwklkaOAadhL4w5awKqb
         fcKc0Kiya8KXN3Cxvi6DMeoXYx8qwSxIZ0PfNEE/pF1dh/himAYdEWSCv7Y3g8rCm5yk
         3Kcm+ukMRsqtYIyJ+oujORqhgEAEFP3B/s1Y/ZjiSMZLek8wYEcmOzDzWT2TrLnC8jgU
         ykuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+yj7E7wqvb/129I+Etr+MWEdaS4FH4xTeleftUlUtU0=;
        b=MGXCe3sjHRWPO47v8hVubQbyqIGxj+WJJ4JXY9P8zLzk0pN5SzqajH57E1F2B/5/7W
         I4d+LY+3XadO0QQbYNevU8XHnwZiMMvSo6wpMNKoo2l9CxOhCKPOooQpQUhqAojI+Yc1
         g2qof8YYg/5GaDZemtsxlVLUkPt5+BwQSvH5MP/rDU+07MIbCE72WVsknRwTaaO/KeHm
         2bNfc17mzSxeJE3nlPyVwuYQNPopmCg6F1qe8lDFeYts2K60EAaAQSyBate+sXrye6DJ
         wwSLS+Ji+/dvk6gtUvNrX7uYMo4gjOngHNIwmV/aekX4JzP3XYWbbKihg1MK70cidOli
         ChMg==
X-Gm-Message-State: AOAM5321xszY2ylwzchjuAqLLWVUThMRxXtA61lTpq8aY7LSjf5VGPWe
        lvFS/NGHGPsCh25QuPYgolyj8Q==
X-Google-Smtp-Source: ABdhPJw9bzz24JCxWhsSf3D3RLPNqdC6upw7cihvDBWKSthLxWatIl456zfxZ+IDAO52Lkc38DGmHQ==
X-Received: by 2002:a17:90a:2e0f:: with SMTP id q15mr3551524pjd.49.1599563901563;
        Tue, 08 Sep 2020 04:18:21 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id ie13sm16070458pjb.5.2020.09.08.04.18.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Sep 2020 04:18:20 -0700 (PDT)
Date:   Tue, 8 Sep 2020 16:48:13 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     rjw@rjwysocki.net, robh+dt@kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, amitk@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dmitry.baryshkov@linaro.org, tdas@codeaurora.org
Subject: Re: [PATCH 5/7] cpufreq: qcom-hw: Use regmap for accessing hardware
 registers
Message-ID: <20200908111813.bbgfxo5v7qt6ujpc@vireshk-i7>
References: <20200908075716.30357-1-manivannan.sadhasivam@linaro.org>
 <20200908075716.30357-6-manivannan.sadhasivam@linaro.org>
 <20200908103444.5e526uawa45om6lt@vireshk-i7>
 <20200908111141.GB23095@mani>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908111141.GB23095@mani>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08-09-20, 16:41, Manivannan Sadhasivam wrote:
> On 0908, Viresh Kumar wrote:
> > On 08-09-20, 13:27, Manivannan Sadhasivam wrote:
> > > Use regmap for accessing cpufreq registers in hardware.
> > 
> > Why ? Please mention why a change is required in the log.
> > 
> 
> Only because it is recommended to use regmap for abstracting the hw access.

Yes it can be very useful in abstracting the hw access in case of
busses like SPI/I2C, others, but in this case there is only one way of
doing it with the exact same registers. I am not sure it is worth it
here. FWIW, I have never played with regmaps personally, and so every
chance I can be wrong here.

> Moreover it handles the proper locking for us in the core (spinlock vs mutex).

What locking do you need here ?

> I've seen many subsystem maintainers prefer regmap over plain readl/writel
> calls. I'll add the reason in commit log.

I am not sure if it is worth it here.

-- 
viresh
