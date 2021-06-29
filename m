Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6057C3B6C9F
	for <lists+linux-pm@lfdr.de>; Tue, 29 Jun 2021 04:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbhF2Ctv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Jun 2021 22:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbhF2Ctu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Jun 2021 22:49:50 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA43BC061760
        for <linux-pm@vger.kernel.org>; Mon, 28 Jun 2021 19:47:22 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id j24so1927940pfi.12
        for <linux-pm@vger.kernel.org>; Mon, 28 Jun 2021 19:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7XkSm09MKTlM+5bwgXywqiRc/y2ECGYZ1RMaAnCDj3I=;
        b=MXBSx4F3iU6Y+Ma58riJet5owe0RIF1IMqpaH6s9GQuTTRHroBGiaGJtyp+fGPdv6w
         UGvv9406FQKnaM3b7NIOfd5D6pJpat9cBR12XDVC5Z9OnCzEO8xvntTqolhgXhMrlL/5
         wVxzeyUl2QIJFHK233jyO7dpM1mNTqVUNSvBSPxl28/Y2Dv9MNoWjgL3EIUzIzJcuxYC
         5yPHvfwnjgH5sHdZjl4dhhTdesHE5ro3XJ6HbstXzSEaF9z1QC82bHEwSYIlnfg+q3CV
         W6mEy3dCOADQQ58WMbCXdXe2HIbtCRkWIpNtKdvisDYsSq3wM464fLebA92I7Vf72Lv5
         iI8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7XkSm09MKTlM+5bwgXywqiRc/y2ECGYZ1RMaAnCDj3I=;
        b=D2W2FmeU1F1fI18+xjbk0LOVBGPw4T3cm2ugeb+jAsAaz9kgOO+x0LKavsypWd0sJZ
         hMvdAclVzmtI2mucrqCmb/R7IgZjrLnLNkv4hoP/OS7Za4CUOv6q6beahWxq7dw6qDeX
         IVvv2xjetDlx+wwL8Oj3uoZOBsvhXreBzuI8K8DSX+jrbn2tFqpxnsFwmU+JpgH+RIlZ
         ghZPsE5IrNaNbVS4hVk8dvEnNthkIGggixCU6dBKSZyD0dKlBfEk4Sb6diLHnDyIcZrn
         YoVA7BsdPodNtQIBZnIFCJfEPKw1jl4/VlLEgwnA149BY5gWu4sWXodmfQQBzhuJjFrs
         dM4w==
X-Gm-Message-State: AOAM533AEqWr6nPUXVirb7CcLw1grKQcvph2mp5f2G1aJ3+U3HjE0/yD
        CB7X/PQtCYA1VM7CAI5Y/g/83Q==
X-Google-Smtp-Source: ABdhPJzBbHxrQoJIVh4lFxHUalObQTAP2E8pdUf5xARTxUNTgGWy1WTe62ZdZ9+VZxPTS6POT5Yn6Q==
X-Received: by 2002:aa7:82cb:0:b029:2e6:f397:d248 with SMTP id f11-20020aa782cb0000b02902e6f397d248mr28195726pfn.52.1624934842154;
        Mon, 28 Jun 2021 19:47:22 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id i18sm4132270pfa.37.2021.06.28.19.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 19:47:21 -0700 (PDT)
Date:   Tue, 29 Jun 2021 08:17:19 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Hector Yuan <hector.yuan@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, wsd_upstream@mediatek.com
Subject: Re: [PATCH v12 1/2] cpufreq: mediatek-hw: Add support for CPUFREQ HW
Message-ID: <20210629024719.nmcygaigtx5wn7g5@vireshk-i7>
References: <1622307153-3639-1-git-send-email-hector.yuan@mediatek.com>
 <1622307153-3639-2-git-send-email-hector.yuan@mediatek.com>
 <20210614104058.jdwb7godqzhf7rgd@vireshk-i7>
 <1624781848.1958.16.camel@mtkswgap22>
 <20210628072641.amqk5d3svwolvhic@vireshk-i7>
 <20210628090956.uwkrozdqvawsm3xp@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628090956.uwkrozdqvawsm3xp@bogus>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28-06-21, 10:09, Sudeep Holla wrote:
> Probably in driver/cpufreq or some related headers if it needs to access
> related_cpus and is more cpufreq related in that way ?

It just needs to set a mask, so doesn't really depend on cpufreq. I
was wondering if drivers/opp/of.c may be used for this, and I am not
sure.

> Orthogonal to that, I prefer to make the generic function take list_name
> and cells_name as generic. I see we can reuse that qcom-cpufreq-hw.c
> with "qcom,freq-domain" and "#freq-domain-cells".

Yes.

-- 
viresh
