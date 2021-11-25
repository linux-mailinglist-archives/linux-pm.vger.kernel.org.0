Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 720D345D4FE
	for <lists+linux-pm@lfdr.de>; Thu, 25 Nov 2021 07:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347154AbhKYG4l (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Nov 2021 01:56:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350498AbhKYGyk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Nov 2021 01:54:40 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B7FC0613F6
        for <linux-pm@vger.kernel.org>; Wed, 24 Nov 2021 22:50:18 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id np3so4472634pjb.4
        for <linux-pm@vger.kernel.org>; Wed, 24 Nov 2021 22:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aLZTzdqAHN4njzqIicuAT3Ic+Y2XtUxhcUjJQMOb7xs=;
        b=Oe/lr717vm9ZmunvbrWUJEHX1jGZvSJbm3Y05EH9Rhle3p07RjPuGDyL1eUzHS+TQH
         Br7MfMZK4yoFD7yxQHBxKwjVcViyJhhnuRn3R1dTPbEuNGtwUcsuaSTNHp5vV6sxuzZe
         LyyySc4RfViFjrPbn7zYCOfy03OhuDDOVqdV0/P4768viANopPp3Tj06bUjngyt59rIV
         sJ+z6rzgZbh04cspJL2ZwpKbue3Ik9Pe4ZMFTddlEaQAHHR3AvLgItFMIWYmjHapvqEC
         JwR0FDv2w2XJ0cXz5gXLKt1Mhks2DcagQMgGk8ydf0srGGbm2T9jkVZt3FxHhKC9vjur
         TMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aLZTzdqAHN4njzqIicuAT3Ic+Y2XtUxhcUjJQMOb7xs=;
        b=ZQq9h7JqEaCeyLN2KS/4j/5jb8ZiX27ykhHENWx1CjDpgXvcu8mcI4OEQty70/VS+1
         51GPShNRSaCTYKI2bew9+XKOBaBQ2ia7OsAiUZzg5YghzJ/LMqrkN1oQJOvim2aGmeYl
         486GpOyhhdC+3oVJ2rlZ4GKqp/UXoc21G5PbZvkOy8zUw9uEKPE5IJgwnk1x4WoTbK66
         8Y/oM2MQ7ekgZ+jsRfRRkiNHRk11TxJfLmpb6eUHHMa5/CfGJCvp+OgjvB+Kmq5eb6Kx
         jKu9yanood2+Wpy6bwIK+LGrBA4nfd+twZvSVgAD+Uda7WRvsATF1hE1wAaVSJvzZ6be
         zucg==
X-Gm-Message-State: AOAM531U8jHMKnFSXJF4r54MSI1NnP84shtQ4FB6wQ1lSWwilgVZkVuB
        ueM9grraa9DFa4k6vENw5Axn9Q==
X-Google-Smtp-Source: ABdhPJwUQbsuqcx0cjo2BNSLjskMS4com6gMFeSOWFH+slwNWFckXWeCVRDPV0yGUjpDLtzxQKmEsw==
X-Received: by 2002:a17:902:e547:b0:141:ddbc:a8d6 with SMTP id n7-20020a170902e54700b00141ddbca8d6mr26876899plf.27.1637823017721;
        Wed, 24 Nov 2021 22:50:17 -0800 (PST)
Received: from localhost ([122.181.57.99])
        by smtp.gmail.com with ESMTPSA id q17sm2154062pfu.117.2021.11.24.22.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 22:50:17 -0800 (PST)
Date:   Thu, 25 Nov 2021 12:20:14 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 0/3] cpufreq: qcom-hw: a few fixes in qcom cpufreq driver
Message-ID: <20211125065014.phkfugo2wptosrgv@vireshk-i7>
References: <20211111154808.2024808-1-vladimir.zapolskiy@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211111154808.2024808-1-vladimir.zapolskiy@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11-11-21, 17:48, Vladimir Zapolskiy wrote:
> I find it essential to resend a fix from Ard and also add two more
> lesser fixes to the set, review and comments are more than welcome.
> 
> Ard Biesheuvel (1):
>   cpufreq: qcom-cpufreq-hw: Avoid stack buffer for IRQ name
> 
> Vladimir Zapolskiy (2):
>   cpufreq: qcom-hw: Fix probable nested interrupt handling
>   cpufreq: qcom-hw: Set CPU affinity of dcvsh interrupts
> 
>  drivers/cpufreq/qcom-cpufreq-hw.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)

Applied. Thanks.

-- 
viresh
