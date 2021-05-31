Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A903F39558B
	for <lists+linux-pm@lfdr.de>; Mon, 31 May 2021 08:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhEaGo0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 May 2021 02:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbhEaGoZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 May 2021 02:44:25 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6510DC061574
        for <linux-pm@vger.kernel.org>; Sun, 30 May 2021 23:42:45 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id e15so4732383plh.1
        for <linux-pm@vger.kernel.org>; Sun, 30 May 2021 23:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jjLDL0V4iB+8RoRx8yCBMqP6SSlXWLls2K+sYcjzMFs=;
        b=bty2l2T8qqwNlCqZjJ8Nhb7xnuNlLXCeZbnRWM4cdoSqhP+LK5iP34PEfN8YwKobDi
         WPtKFCrGgt5cEwSgWFM0YOFpWm44IBNjUvs/SgCevtsx4YE9mZRK1+M9U5xMHQYvLqrZ
         d6VLKZ5dmOJcmTwuzUg+FDyT3OznOy+nfcRWw1hkatE4e6Wcgout3vZPDjHsmSLwWqKX
         dthuYAYzCA89AlMV/wxDEAhvI7xdRcvdkccgOuq5NVclEn1SCHflveYr4l9l/mG0QmJc
         WbcytEhXabVcLPPePnSXyNrUqc23zd4+aNdCXhoVtAU3dBs8X0F131IXc4NCoUHTV1QU
         IzIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jjLDL0V4iB+8RoRx8yCBMqP6SSlXWLls2K+sYcjzMFs=;
        b=OOc1Pf6B4jy/JCRGoffFPodb1rZnyhuTBDxQGb2NceFIbgYBAoZCwuNAFL9Veoe9qD
         4duUhNRa/GeYnGFEaepcIvJI59XUxoRChqHK7RZuQzUuROegChZdLK3/UnHlmZ/fFUul
         W6Lv6C7mczkv2E09RI2Y5+05Zegehu/VdVxOAJWG1K3eeG/GyFN86Dsm4rSFiN0lPwWd
         9k/0Z7GWUiP2tbLJ8iMy28cEReprlXIzqze5j6P9LUxW4UTzzN194RvW1Hx+r4KgGB0l
         7jt5luCrFQKXUAIg0GSCg4/U71vIAfMO/7Dyi/kkRvhH4HAhBGs49D1w857Zz47OfFGX
         Dxhw==
X-Gm-Message-State: AOAM532qARe5JnFgK923Z/cI+/bK0TKadaeEW7OY6He1Nx1hIqrqGEWt
        nYs2qyvgy7A1FKZk718kvlTZ48SKPkNoHw==
X-Google-Smtp-Source: ABdhPJxfZk41sYsWhSqclaviD/NDpwvhYC2b+K+Rt1KsIQ2KkgK6CFa/Oh/70VOSSXZtwTsWygJj5Q==
X-Received: by 2002:a17:902:9f93:b029:104:9bae:f56a with SMTP id g19-20020a1709029f93b02901049baef56amr4611672plq.75.1622443364922;
        Sun, 30 May 2021 23:42:44 -0700 (PDT)
Received: from localhost ([136.185.154.93])
        by smtp.gmail.com with ESMTPSA id z5sm8416314pfb.114.2021.05.30.23.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 May 2021 23:42:44 -0700 (PDT)
Date:   Mon, 31 May 2021 12:12:42 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Pankaj Vinodrao Joshi <Pankaj.VJ@exaleapsemi.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: Dynamic power management
Message-ID: <20210531064242.zrnftt3pwzxlyyoh@vireshk-i7>
References: <BMXPR01MB2870D9D1E222FFF4BE1FC3C1EE229@BMXPR01MB2870.INDPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BMXPR01MB2870D9D1E222FFF4BE1FC3C1EE229@BMXPR01MB2870.INDPRD01.PROD.OUTLOOK.COM>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28-05-21, 10:17, Pankaj  Vinodrao Joshi wrote:
> Hi,
> 
> I am working with the new architecture which is new in the market and is not
> fully mature with respect to the dynamic PM. I believe following are the
> frameworks available with dynamic power management but currently i am using
> cpufreq framework only

It isn't all about architectures but the eventual platforms as well and if they
need these parts.

> CPUfreq, Devfreq

This is for scaling the frequency of the devices, like CPUs, GPUs, etc. If you
want/need that or not is for you to decide.

> OPP

This is only a way of passing the valid frequency-voltage pairs to the other
frameworks via device tree, like cpufreq. Again if you need to use them.

> Genpd

This is an important part for runtime PM, this enables disables power to various
parts of the platform/SoC (or group of IPs). You need to have this kind of
architecture and registers to enable/disable power to certain parts of the SoC.

> Runtime PM

This eventually enables/disables genpd/regulators/clocks only, need driver
specific hooks.

> Clocks

This is for enabling/disabling clock to IPs.

> Regulators

to control voltage regulators, change their levels and enable/disable them.

> Can someone guide me if i want support for all above framework what and all
> support i should have ? What is SoC side and kernel side dependency implement
> above frameworks?? Kindly help.

Just look at them one by one, you will see plenty of examples of platforms doing
it. There may not be a lot of architecure specific stuff here, but platform
specific.

-- 
viresh
