Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6078138E326
	for <lists+linux-pm@lfdr.de>; Mon, 24 May 2021 11:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbhEXJUS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 May 2021 05:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbhEXJUR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 May 2021 05:20:17 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1296C06138A
        for <linux-pm@vger.kernel.org>; Mon, 24 May 2021 02:18:48 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id m124so19635891pgm.13
        for <linux-pm@vger.kernel.org>; Mon, 24 May 2021 02:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0c5Qxjp+4tL19l2WuaML9jbCExKjLNfzcff3PqhK+VE=;
        b=h6aeeuYGuMndMeWE+tDnkHaFLWogpyi0c/FjQoc8wSMIdgESd1urJM9QEg454F/5qA
         nsK+XL02e94ks6Ow+C3qCU1cWazB1c/RcK0eL7zt0ZG7THaIUM+tII/H6fGBmKVIxzA5
         ze6RcWJrILiN3M0ZBwYrxZ9N6gMBkmTtwaSYTIKk9wpW24qmqR6gUmQSwLfKktktNO/k
         1Kpa1iQnqx7w0JEOSJ4UY/A+OyqY+hFMUGAGIN8XUHQ7wg+a6tXpFTUyhsOWijG+v/i4
         CJyeIlRdWYUHHfZATciNR2WziCr3Zw1l/vOQvzR6zegUblt31P5bNzTFUa7sIgw1wxQd
         MSqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0c5Qxjp+4tL19l2WuaML9jbCExKjLNfzcff3PqhK+VE=;
        b=rebqHkX+ea5O1GNKTPvV+a7cVm8LCLKm1WhhqiwJYlufz6kpBHQR5fx8D7y4kDXIli
         PyLwH9tX40gTJgZcFFoaQ9TnShDcQqMMVkkmdXGxygX4agkmD9QeyybSKECtagl2DFK8
         l1SYXEMjCC2XzHMODIIYGYqaCT7681Ki6kPSngHmDNJDF80t+6+sxGvVNN5KctzNQ/Mj
         Yx7fAx6vHKRglaq+XFopCSW9thZGIuu7PkQNZ1GODg+rEEizRQaBODNI29sOXHM1kllY
         cbjmfFu00pOoCsgOWzZuzspYkQ8U/2GIcx8wFBuFCcwQtg5VRISIah68wxtWDAa3jkMa
         lhVw==
X-Gm-Message-State: AOAM5334kOw3qXUvQCc3m3TYG+WhiGK6aHXRc1iPbi4niS0uFzznDK+p
        TGx6aEirR331T1Q8nhCVeOnGPw==
X-Google-Smtp-Source: ABdhPJzP2RUqZymnC2lnFHYSor1AieszJZmgrX4DEQ4so867X8K+jZMC2gm2x7if1QXdo4oFdo6teQ==
X-Received: by 2002:a63:8f15:: with SMTP id n21mr12327462pgd.366.1621847928173;
        Mon, 24 May 2021 02:18:48 -0700 (PDT)
Received: from localhost ([136.185.154.93])
        by smtp.gmail.com with ESMTPSA id p8sm10169150pfw.165.2021.05.24.02.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 02:18:47 -0700 (PDT)
Date:   Mon, 24 May 2021 14:48:45 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Hector Yuan <hector.yuan@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, wsd_upstream@mediatek.com
Subject: Re: [PATCH v10] cpufreq: mediatek-hw: Add support for Mediatek
 cpufreq HW driver
Message-ID: <20210524091845.wlikxun3x2qou7zs@vireshk-i7>
References: <1609222629-2979-1-git-send-email-hector.yuan@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1609222629-2979-1-git-send-email-hector.yuan@mediatek.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 29-12-20, 14:17, Hector Yuan wrote:
> The CPUfreq HW present in some Mediatek chipsets offloads the steps necessary for changing the frequency of CPUs. 
> The driver implements the cpufreq driver interface for this hardware engine. 
> This patch depends on MT6779 DTS patchset[1] submitted by Hanks Chen.
> 
> >From v8 to v9, there are three more modifications.
> 1. Based on patchset[2], align binding with scmi for performance domain.
> 2. Add the CPUFREQ fast switch function support and define DVFS latency.
> 3. Based on patchser[3], add energy model API parameter for mW.

Hi Hector,

You can refresh this series based on the patch from Sudeep:

https://lore.kernel.org/linux-devicetree/20210517155458.1016707-1-sudeep.holla@arm.com/

-- 
viresh
