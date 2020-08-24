Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96AB424FBAC
	for <lists+linux-pm@lfdr.de>; Mon, 24 Aug 2020 12:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbgHXKlQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 06:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbgHXKlB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2020 06:41:01 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C37C061573
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2020 03:41:01 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id kr4so4076007pjb.2
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2020 03:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XgbO9mR4mVK+VLe98mmxfWqoTjzntsorurnkGUqDaCQ=;
        b=ZQ+VblBjWGeESG4rusKo+1JZYRqRf6bSGcqBa0n7UR7OlQN91evh6PFcWm7y0cwdAl
         GoZGJDpLTdUtIPVhtpMg6jPckeHsuPgbiO1OBgN7vhQD6K241KUnVouI9K17/SmA6MZ7
         +dD9bsFPu01qj6HGGtRvTb5caKNSv/Z0B5egaB4dCbgeyMKmYvaPAyK7U3FTIOG97G/u
         ANP4lhMCYbhFlVxhdM/OoH45tmA6gmP0vfz4PoiBGXw8z13OtUmds+tSOcfv/3bWFlSn
         Wcx8GVsAakX8MCe1A8jTmjba7cT9q74/knHOzlGiek+AEA9vZ1v2970dJC3rTZ0Q2sLU
         xQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XgbO9mR4mVK+VLe98mmxfWqoTjzntsorurnkGUqDaCQ=;
        b=PLS8jmeISR6ob5nm744L/GZgTLCUyn7EK+nQ18Hn7DO7FsopiBAodcfWCguLJtkeZ5
         BqKOgLj8KEDh7RX1idcn+A+OpVeq9x5xEQqJecFCzD1M5vhv5hA0vsd8gLzxVBCSA4pZ
         UlC76HuxmzC/RFQf0I0zLxeYSpMTaIhOPnuRnBb2+3Iy947FkURUMKgtOPJ8jLBsDMzS
         O/rBG1FZpdN4fojy2QCpPUYy8PHmbk41PWmZF4+nmrjFuEWlm1WsjtzPS0p/my3/JpLU
         2aJD0TVk8cerIwZNoUltBrxReKsL+LUjfNguS7jtyhvyx/e8CMso63rW6piGNJWVwuWm
         xt6A==
X-Gm-Message-State: AOAM530Zj+NGL9sGjeMBHyeKSeaKyJSKnpI/k0NI3sWGyj7drO2NY9Lh
        E9nt2PO5J1eSsKk7CZonjt6gnQ==
X-Google-Smtp-Source: ABdhPJzHp5qGiAawE2z0LljcaMUrf104gCiqxPBac1WAVL6UMn9NdE5K7a2ZqlOVIeg4Fersn7deiw==
X-Received: by 2002:a17:902:7585:: with SMTP id j5mr3553270pll.168.1598265661050;
        Mon, 24 Aug 2020 03:41:01 -0700 (PDT)
Received: from localhost ([122.172.43.13])
        by smtp.gmail.com with ESMTPSA id na16sm9040302pjb.30.2020.08.24.03.41.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Aug 2020 03:41:00 -0700 (PDT)
Date:   Mon, 24 Aug 2020 16:10:53 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>, vincent.guittot@linaro.org,
        saravanak@google.com, sibis@codeaurora.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3 0/2] Add Krait Cache Scaling support
Message-ID: <20200824104053.kpjpwzl2iw3lpg2m@vireshk-i7>
References: <20200821140026.19643-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821140026.19643-1-ansuelsmth@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

+Vincent/Saravana/Sibi

On 21-08-20, 16:00, Ansuel Smith wrote:
> This adds Krait Cache scaling support using the cpufreq notifier.
> I have some doubt about where this should be actually placed (clk or cpufreq)?
> Also the original idea was to create a dedicated cpufreq driver (like it's done in
> the codeaurora qcom repo) by copying the cpufreq-dt driver and adding the cache
> scaling logic but i still don't know what is better. Have a very similar driver or
> add a dedicated driver only for the cache using the cpufreq notifier and do the
> scale on every freq transition.
> Thanks to everyone who will review or answer these questions.

Saravana was doing something with devfreq to solve such issues if I
wasn't mistaken.

Sibi ?

-- 
viresh
