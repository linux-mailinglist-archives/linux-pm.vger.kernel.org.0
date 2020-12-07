Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFF42D0AF9
	for <lists+linux-pm@lfdr.de>; Mon,  7 Dec 2020 08:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbgLGHNw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Dec 2020 02:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgLGHNw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Dec 2020 02:13:52 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6ADC0613D2
        for <linux-pm@vger.kernel.org>; Sun,  6 Dec 2020 23:13:12 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id l23so6911294pjg.1
        for <linux-pm@vger.kernel.org>; Sun, 06 Dec 2020 23:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0P69RlC+wFTK1l6Xn78C2+H2ceKvYT96/4BZt7YYSB8=;
        b=M1b9mPSG7DA1dn5MiDxVa7ojKZJtfgy5Lhcik29McJSDSx+hJOCUshC5VK54nPDUVP
         8SFjbLwJDeMS0nK5lqWgq5x3L4GI0/oiwSPzg2iHFbjxlTxykvR85iCMSaPUzY3yoHpO
         VT8GdqDMuPCwBsqFUD3GhZgKLEiEHu0WhYszLf1Bhd5XcgE3geywcjpyy02RFNzdZGmw
         4WTAgGEdRb9A2REFV+9E7oOl8vfc/5C3q/LIIWwC3qeZr0luk7vueaCH/iTxjQU1nVK8
         nA6z6UOfbrEMstb/HiTTELr438n8gRlgdoqG++2YPcR4mwQbPBBM6YpYR2gSYLJC3vAm
         I1FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0P69RlC+wFTK1l6Xn78C2+H2ceKvYT96/4BZt7YYSB8=;
        b=U+JxxS5CHEf87qJGt048MxjVAszTDN/5f1qwuB5TqLLrdxNhSQ/049B5V/q/HNsTor
         /7izoK0I/W4mPnOr+jnwa9uLGNW7ZkDicJ/dFdT6lU4vbctBjQ/PZxpDDfU4gftLHvNx
         7FgSud6DhERqsHtT5y5DSgPhQUYGT+gDNybbiNaqA8Vk84EmZTE7A2rz/08/5Q/yQs6W
         jxJRTrHJezA+4XDQoq00mQ6UMitVqMO1FB23S6VHRMesw+yrYQ0G3c1vbm5ce/oweq87
         xzV1i0K/c5VcMzFWZVPqo/dv4YuvtxmR6blP2iu+BpgbndRX3by61dYzFx3sW7qydcDe
         2SfQ==
X-Gm-Message-State: AOAM532J/7QDr1IksSYDnp4cWcsXsmBs4A8HdJy/fv+wZsgMzLuFvDxF
        lmThN0W70sOlyRM5W8+zHBAXtQ==
X-Google-Smtp-Source: ABdhPJyQAE9XBxV0i5UjikzoveQKKwdcFLGbwaZxFNXLy5tqKjeCrohdouaEQwinppAyJ4k04MfiZg==
X-Received: by 2002:a17:90a:d086:: with SMTP id k6mr15503571pju.141.1607325191770;
        Sun, 06 Dec 2020 23:13:11 -0800 (PST)
Received: from localhost ([122.172.136.109])
        by smtp.gmail.com with ESMTPSA id 65sm12761092pfd.184.2020.12.06.23.13.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Dec 2020 23:13:10 -0800 (PST)
Date:   Mon, 7 Dec 2020 12:43:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        Dietmar.Eggemann@arm.com, cristian.marussi@arm.com,
        morten.rasmussen@arm.com, rafael@kernel.org
Subject: Re: [PATCH 0/2] SCMI performance protocol power scale interface
Message-ID: <20201207071308.rm7x6ro7i4qtmm7h@vireshk-i7>
References: <20201124104346.27167-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124104346.27167-1-lukasz.luba@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24-11-20, 10:43, Lukasz Luba wrote:
> Hi all,
> 
> The Energy Model (EM) supports power values expressed in an abstract scale
> via new API. The SCMI performance protocol provides the information about
> power scale. This patch set implements the needed interface and updates
> cpufreq driver to set the right scale in the EM.
> 
> It is based on top of patch series adding milli-Watts flag in EM [1]
> (next-20201124 was used as a base).
> 
> Regards,
> Lukasz
> 
> [1] https://lore.kernel.org/linux-pm/20201103090600.29053-1-lukasz.luba@arm.com/
> 
> Lukasz Luba (2):
>   firmware: arm_scmi: Add power_scale_mw_get() interface
>   cpufreq: arm_scmi: Discover the power scale in performance protocol
> 
>  drivers/cpufreq/scmi-cpufreq.c   | 4 +++-
>  drivers/firmware/arm_scmi/perf.c | 8 ++++++++
>  include/linux/scmi_protocol.h    | 1 +
>  3 files changed, 12 insertions(+), 1 deletion(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
