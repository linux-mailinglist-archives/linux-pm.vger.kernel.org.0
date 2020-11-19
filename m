Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B57032B8A86
	for <lists+linux-pm@lfdr.de>; Thu, 19 Nov 2020 04:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgKSDyL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Nov 2020 22:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgKSDyL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Nov 2020 22:54:11 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD90C0613D4
        for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2020 19:54:11 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id a18so3162795pfl.3
        for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2020 19:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bY60GSlLO2ruttlt3lBiygVojLgvG+1tKw+aonD1tf0=;
        b=h6kuLugVduO0z7Xd8KjXshQXwF+7cCZ/s8v0IpbJBLsbwPtH+Bho3MjUlGoIWscJWK
         9Libw0oeW+hmns3gEO77TcqRwoJMyWy4Y1/1zZSYQZXJNtPeXlB6HYzOiZItNHbAjCpj
         vam4TOEMrk+QzscnEX5rVE+0icMt/v35orHJX9Rhoa4UqovnIcyKNzm8P09h6YhctRNy
         fManwRfftei/2FeVlR/CPhZDIIu1zngGJfJZO9FzJOSycpZdgh+GjXT1N3zyThEv6nBH
         c1gLzsLpLMgK7t0T0TKF+qtKw7pP20hGr8C9LNYxpNHU50ofNOHdwlVe1HDEmi0mTpGx
         7BHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bY60GSlLO2ruttlt3lBiygVojLgvG+1tKw+aonD1tf0=;
        b=iliiA3dj8vVGljvgtYVSxXJZjpKyOI6MkfSqR4w4Z7nzpUEeuUfLqYaS4bEj0hDYOk
         3+keMOK/DV3j4vB8rcJPdh3ARUSPl7OtjDeQdAKckJ36QdXAXDMnAw8qAhKTkl7cB1b1
         JG4coiTC0vCUSrlsC1PFM0Aww7vIe/B+FuYPOMycIt98/sf+Ooai2Nn67OwDCAg2mwlb
         5QMFOBxMP1PeHtvGOj4ErfWDcgiGwWsn/M9n4RXNrC2MCGkdtZJIshzlI9EUVHviuQjN
         XTDAg321zs8jl37xCq9zFz9W99Bwy7ehJJuEYNUtQHcTAirUGP3hr5nyAx/Rud9QUksn
         +bow==
X-Gm-Message-State: AOAM531g2EpyeAbscJVMFvREYTXTeDEfsLLZfgMnmFmRYjUEckhpGeXE
        l/4Vr92BlS6bxnuK0UMVj0a8Ju6AQw5GDA==
X-Google-Smtp-Source: ABdhPJw7Q5wDrq3TOZXxcS6uKnHTtzi5cscSt8Li1bmeaRhm2cmkFkWS0/mUHfAIfKKkoY52aKvHVQ==
X-Received: by 2002:a17:90a:e2d4:: with SMTP id fr20mr1591639pjb.202.1605758050468;
        Wed, 18 Nov 2020 19:54:10 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id s15sm18796282pfd.33.2020.11.18.19.54.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Nov 2020 19:54:09 -0800 (PST)
Date:   Thu, 19 Nov 2020 09:24:07 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: Fix up several kerneldoc comments
Message-ID: <20201119035407.4mamgendovnmypj4@vireshk-i7>
References: <1739462.uCgn0Xls2p@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1739462.uCgn0Xls2p@kreacher>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18-11-20, 20:02, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Fix up the remaining kerneldoc comments that don't adhere to the
> expected format and clarify some of them a bit.
> 
> No functional changes.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c |   72 +++++++++++++++++++++++-----------------------
>  1 file changed, 36 insertions(+), 36 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
