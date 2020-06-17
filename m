Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B660A1FC569
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jun 2020 06:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgFQEww (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Jun 2020 00:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbgFQEwu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jun 2020 00:52:50 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFACC0613ED
        for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2020 21:52:50 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id g12so360609pll.10
        for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2020 21:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h0vhA/U1QaPFJFPPSjv2ooCi1yzJ6bifslhy6/ILfNA=;
        b=qqIvT076Ge1qMBfJZRudD6kJOw7/2aACm4VFEGmTFxFn+fCQL61SzYuS80vLfgU0EO
         1arc/y+G8q/3e4CymS8UeG6vnphqJUxbkEX9ScUZ9sskxZa5SyNwTR6p51GO3N4XLJ8Y
         CpOdAaHvmQgc3foOQzxQDusX6yi6ARQogN6GxF6/ZZvu2dTxQNvTkoxtZPcEI45AjFku
         znd+4BS7UNWJ3KPwSGmrwyp0c39/7x5UkacWCK/fcA+yUIUQJYTWbWxX2mDZtkHRPzH6
         CiHPsaN+s9EVhHoAeYUMPxQqhZHqk8ptbYyNQqHdCH0TfckHERqD1a75k2FQOhfuhHgs
         MLJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h0vhA/U1QaPFJFPPSjv2ooCi1yzJ6bifslhy6/ILfNA=;
        b=o4+HKXQKzroZurHacVlSE3K4ZP4y6n10adBgw4hx+dggOzWbwDAAE7WkddvkK8g4yI
         zxzLxjAqFQ/Y9wp/nbegLyBAjY95f8R5JsfwXaoN7MH+VkJbpwDjpQSWI2w+3MJKVbcq
         6evEcxhMYW3vEjJbj5k+vHkSjnn643153XoZ9cv4s11A6YrIPRW+Fqpnl06aad/zwGSh
         uf0g06GT/SSGkpqpl+Eg7lGE1SVbO8MWS5RfizgpsgI7z7XTFl6QDog0Luxly4cvgAwL
         vprBeTrpHwl/3ljrC8eHJXWvOpUlBhHEFndhyucihouaZ/OdavOi9ku2KAUL814Fwrdk
         8ZIg==
X-Gm-Message-State: AOAM533VciKsL1t0Qtn47llNDi0zEFAOSBJCsDCnIcCq72mmyPNaZmDf
        IOhWKx5YYBQnafotlwgfTyIMZQ==
X-Google-Smtp-Source: ABdhPJzUPNYD737LZ9mvXjpLQCfZmh5Gx+UdS29xXQW9wm49nYfnbVwYV0zTgJAUSgpio21zZQQuuQ==
X-Received: by 2002:a17:90a:930c:: with SMTP id p12mr6662433pjo.2.1592369570118;
        Tue, 16 Jun 2020 21:52:50 -0700 (PDT)
Received: from localhost ([122.172.119.132])
        by smtp.gmail.com with ESMTPSA id h17sm18753333pfo.168.2020.06.16.21.52.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jun 2020 21:52:49 -0700 (PDT)
Date:   Wed, 17 Jun 2020 10:22:47 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Sibi Sankar <sibis@codeaurora.org>, sboyd@kernel.org,
        georgi.djakov@linaro.org, saravanak@google.com, nm@ti.com,
        bjorn.andersson@linaro.org, agross@kernel.org, rjw@rjwysocki.net,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org,
        vincent.guittot@linaro.org, amit.kucheria@linaro.org,
        lukasz.luba@arm.com, sudeep.holla@arm.com, smasetty@codeaurora.org,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH v6 4/5] cpufreq: qcom: Update the bandwidth levels on
 frequency change
Message-ID: <20200617045247.zet624tyloxzj5fx@vireshk-i7>
References: <20200605213332.609-1-sibis@codeaurora.org>
 <20200605213332.609-5-sibis@codeaurora.org>
 <20200615172553.GU4525@google.com>
 <e21f85d64d72ec637c10dae93e8323bb@codeaurora.org>
 <20200616221157.GA4525@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616221157.GA4525@google.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16-06-20, 15:11, Matthias Kaehlcke wrote:
> Hi Sibi,
> 
> after doing the review I noticed that Viresh replied on the cover letter
> that he picked the series up for v5.9, so I'm not sure if it makes sense
> to send a v7.

Its okay, you can send a new version and I will apply that instead.

-- 
viresh
