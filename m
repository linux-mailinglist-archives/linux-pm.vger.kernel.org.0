Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2489E278069
	for <lists+linux-pm@lfdr.de>; Fri, 25 Sep 2020 08:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbgIYGPv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Sep 2020 02:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbgIYGPv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Sep 2020 02:15:51 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E05C0613D3
        for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2020 23:15:50 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id k8so2187990pfk.2
        for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2020 23:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sFDqhTWwq0aXbG+fWoeTT2wJdl6mRz17hLrTzSVAK+8=;
        b=WTIVIGAF8OuXN7pfm1xe0I3K+SU7Q8sUkg5Vex08vfqC+KKp92yK0Uxe3SaT97bMWi
         qvK6AHoegm7OPPTjLaJmZDHLHLjg0DplxVTXor8kynxX9WTzKdq/VXEOHA7dUW3hD3O9
         4ktDnP01VzHZslBWMpJlU5ef0raOz135iKFjEy/hrcfIrQ2rg0YqmkHPVHddlCe4zqsj
         1ukeQdXUTvcU8B1Wt/Ae7Svtaux4DpHl9gzQkQQmbplPJxeIjOTtFJmTDzwJ3CkKmSyZ
         5jzpWdI/OTghnqcxouBUNla4KuWi+GKh4t3M0Nf1F9ayUk3Zic5s0tk3xX+pVpG7H6qe
         3yHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sFDqhTWwq0aXbG+fWoeTT2wJdl6mRz17hLrTzSVAK+8=;
        b=YrtvBOPLrk7Q9fpWMgYFZhqrrl9zFp5RbRUvch53dNQ5xlsxgx8Gi4TMEMe2tWTNR2
         pvVRA7F/2rkkEuWVQ2PmtDnRPGxM4SCkO3zR1YAckDYlqUtya7SwlE8GFLAj+6rV9DMD
         UyhG4vKc9t7XJOWK3yUC8975+BcNLCG6PG1yXvBK21TWioXZYLD9bDaIjeh3fHP9NJ0a
         ew1BurEn35zi7ol2jI+l0hgw7ReWaLcc7wDbyQvRaUMwcos031b2Wa7XeY0OPkVmLWYf
         n2a9FLeYX6rVMenCJRPT9bAYctOvV4AuWZGBrJ8MglFcAVq4zPfeCndpd5ahdVibFzj7
         BXIQ==
X-Gm-Message-State: AOAM533jQ5kiYhpAsZwbjTehZR2EJ8y77AYaMw2+PKH2tXSufIiWtpKp
        /YSxccRja9BRQJJBpSLIp3nhnA==
X-Google-Smtp-Source: ABdhPJwLTkRlOrK4LFHv28M0c20AUtX5UgY6Rg7+xHPiT/uw8gq2AOfK8YUc1BXr+ogR2OkzhZVJhw==
X-Received: by 2002:a62:7fcf:0:b029:151:15e0:ab82 with SMTP id a198-20020a627fcf0000b029015115e0ab82mr2726264pfd.80.1601014550164;
        Thu, 24 Sep 2020 23:15:50 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id t3sm1001649pje.43.2020.09.24.23.15.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Sep 2020 23:15:49 -0700 (PDT)
Date:   Fri, 25 Sep 2020 11:45:43 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Hector Yuan <hector.yuan@mediatek.com>
Cc:     Rob Herring <robh@kernel.org>, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, wsd_upstream@mediatek.com
Subject: Re: [PATCH v7 2/2] dt-bindings: cpufreq: add bindings for MediaTek
 cpufreq HW
Message-ID: <20200925061543.5hxs3ija2y53gzea@vireshk-i7>
References: <1599712262-8819-1-git-send-email-hector.yuan@mediatek.com>
 <1599712262-8819-3-git-send-email-hector.yuan@mediatek.com>
 <20200922202852.GA3134161@bogus>
 <1600866614.21446.18.camel@mtkswgap22>
 <1601000847.21446.34.camel@mtkswgap22>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1601000847.21446.34.camel@mtkswgap22>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25-09-20, 10:27, Hector Yuan wrote:
> Hi, Viresh & Rob Sir:
> 
> I will change frequency domain to below and define it in cpufreq_hw
> schema rather than cpu node.
> 
> mediatek,freq-domain-0 = <&cpu0>, <&cpu1>;

I think it would be better to do it the standard way we have done it elsewhere.
i.e. follow Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt, that
is similar to what you did earlier.

-- 
viresh
