Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A992C3A7BC7
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jun 2021 12:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbhFOK2j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Jun 2021 06:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbhFOK2f (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Jun 2021 06:28:35 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB096C061767
        for <linux-pm@vger.kernel.org>; Tue, 15 Jun 2021 03:26:29 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 22-20020a17090a0c16b0290164a5354ad0so1517300pjs.2
        for <linux-pm@vger.kernel.org>; Tue, 15 Jun 2021 03:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G2yVLxb/hh2n7LVacW4I67omTPuI6DZTKOpd97sxzgk=;
        b=UddeYs/ZaZLMXG7VO8mM72zRL7J8s2mLRPM4eCQInzGejwyWg0GYW9LjKRunr1FBl0
         urxf4gwj+HXDQslXdPFlmk7pXQYoAB8NnDws3aNnDBSZX6iiCkLGtjNu2YJ0tVP/9aMB
         MBkmVO1JQ09/iBVPAy8QVjILsEngWxRZcdSE12mNacqStj0OL0lwNzHmdnGCpCQ3OaTR
         u2tNoTLh8WLvQluCqHUP/qGSAZjm19PKMoIFHqF3qSFQeu/YULhL0HHJtiAWgjNZAXzQ
         VLl1ObTwiKW/HckINHeRbqXLAhH6TTp4u7HW2kvRdtqfEASj1A74apJ7Fe1NsxaR73Mp
         MmwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G2yVLxb/hh2n7LVacW4I67omTPuI6DZTKOpd97sxzgk=;
        b=J0Ie9m4Yaouv9qBrnWlLX8pkII/s6TeE2InA/UNNp+7bRQehewfriPDfVDNOGO0FLh
         fhF8SDiF3cuHrnkp08Lq1kQOdP4S/PMiktHy8sF8Cx0W2Rv8B1T/vr/dqrLvHBnxMjLT
         NvfTeGeq0TKsCcwMf/AoEZ9YXmI8lZtVaAPeF0hTFM9mqtSxdxHSj/YxFn6jXql9LR9Y
         no1VrBrJ+QrWtXu9o+ltvQrvOijMU3kjDe2YzCZybF7b2vK4ApTTw9EbLspbZ7rY/ZWK
         gATDCQbANyj+vJGiZwyBg63p2lVPPzwL42YhZEdt7s1E77Mp618v3ayPOstiAk1Qni85
         3mgA==
X-Gm-Message-State: AOAM531che3AfUVRCWKXI6QF9bHLu+2wKsTsUQPOeDwDOgXp7kfyU/CU
        +TzrvjFpPqwOtctrTojEfFcLOQ==
X-Google-Smtp-Source: ABdhPJwDJvRyByWxHEqHEa7YHl6PWJ3ExPhL/hLqTNx/h7R8ACllZfqoqiW95kH7DAIkGWwwf0IJlQ==
X-Received: by 2002:a17:902:ea0f:b029:10d:6029:780f with SMTP id s15-20020a170902ea0fb029010d6029780fmr3558504plg.66.1623752789333;
        Tue, 15 Jun 2021 03:26:29 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id q4sm15285410pfg.3.2021.06.15.03.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 03:26:28 -0700 (PDT)
Date:   Tue, 15 Jun 2021 15:56:26 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andreas Westman Dorcsak <hedmoo@yahoo.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Ihor Didenko <tailormoon@rambler.ru>,
        Ion Agorria <ion@agorria.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 4/7] thermal/drivers/tegra: Add driver for Tegra30
 thermal sensor
Message-ID: <20210615102626.dja3agclwzxv2sj4@vireshk-i7>
References: <20210529170955.32574-1-digetx@gmail.com>
 <20210529170955.32574-5-digetx@gmail.com>
 <6f2b6290-095a-bd39-c160-1616a0ff89b1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f2b6290-095a-bd39-c160-1616a0ff89b1@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15-06-21, 12:03, Daniel Lezcano wrote:
> 
> [Cc Viresh]
> 
> On 29/05/2021 19:09, Dmitry Osipenko wrote:
> > All NVIDIA Tegra30 SoCs have a two-channel on-chip sensor unit which
> > monitors temperature and voltage of the SoC. Sensors control CPU frequency
> > throttling, which is activated by hardware once preprogrammed temperature
> > level is breached, they also send signal to Power Management controller to
> > perform emergency shutdown on a critical overheat of the SoC die. Add
> > driver for the Tegra30 TSENSOR module, exposing it as a thermal sensor
> > and a cooling device.
> 
> IMO it does not make sense to expose the hardware throttling mechanism
> as a cooling device because it is not usable anywhere from the thermal
> framework.
> 
> Moreover, that will collide with the thermal / cpufreq framework
> mitigation (hardware sets the frequency but the software thinks the freq
> is different), right ?

I am not even sure what the cooling device is doing here:

tegra_tsensor_set_cur_state() is not implemented and it says hardware
changed it by itself. What is the benefit you are getting out of the
cooling device here ?

> The hardware limiter should let know the cpufreq framework about the
> frequency change.
> 
> 	https://lkml.org/lkml/2021/6/8/1792
> 
> May be post the sensor without the hw limiter for now and address that
> in a separate series ?

-- 
viresh
