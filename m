Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23FC23E6E1
	for <lists+linux-pm@lfdr.de>; Fri,  7 Aug 2020 06:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725805AbgHGEyo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Aug 2020 00:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbgHGEyn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Aug 2020 00:54:43 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93A9C061574
        for <linux-pm@vger.kernel.org>; Thu,  6 Aug 2020 21:54:43 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id u185so370021pfu.1
        for <linux-pm@vger.kernel.org>; Thu, 06 Aug 2020 21:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Uw+hzHkkFQHpKKttBQnfQJy4eV1x+mEGfbQUFATKQ5o=;
        b=lqEZ9A/sLBE1dxCtyaaFdylpUwfG+ecetWBLdSWxJKfm/3ZqWSvRiYSlWMci3zYJOk
         larrrdPz5aE3fmGeE2b9BG/zphuVufLWJNP7RpYOa+bKIXgPntq4xKaFNajbj2S8y15n
         nsNd6F7jo6qfSc5j7KYJ3fhW75F8Qs2qicNfIlyTuzz94a0TSzbjgKVozaf/FmfKPTdX
         6PBOb2gVFj66mtHewKfR1RwdVpyP78vPZfHbQBMdv1WVDoTFyfFR/XKTCdG9ZAoH90QY
         AwwcBfB+Br8ZXzlQVy0uLdruT7fz45KrcsR4Hv0FiCoEdE5WI17QleyMfscJadW3avLX
         KgCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Uw+hzHkkFQHpKKttBQnfQJy4eV1x+mEGfbQUFATKQ5o=;
        b=XqbYhz3Mu2lRcSMP/rHDknEObj4yRLpbxxeldhwblVBuSCw9dVfrszA9k/+l6jtxwJ
         D9p2ss7kzpvTNDFXW9SbuRm/GrknXiV2iCdjBHWUcU5m9Uu+llN4rJRh7Z1cjKePwLVo
         gY9uXkNK6wfxkSioZO6StgrvULqFdxb+z6v8wguYa9lRPv7PjxtaBJpHu6A76Bws0JUz
         4Z9grlR5N3hnQYrdZhT06fnbmsO/IytqU9Qyrw1Ow/B1DNdkIAEu0LI3h5B6ayRQmiTG
         QImT21Qq+hJHk+hOlhy7I4VcS4TrAoeWaE8IubG3n49xCCqwemL0RqmlqsXtr+1zblgb
         fVOw==
X-Gm-Message-State: AOAM530L9VL/wDXeN+I7vyUaElX87Duhp71Zwsmzetwm+xDvVBGWnsGb
        pzNSrejdCAFnOtCxTsOUIUVFTA==
X-Google-Smtp-Source: ABdhPJxzEGct9GafiVQIRxPUdzuAW68/6ub98vgg/4bs88pQQ5Y01QiyZQGfAIlFu7w/7t8F0tWvYQ==
X-Received: by 2002:a63:954c:: with SMTP id t12mr9852650pgn.387.1596776083077;
        Thu, 06 Aug 2020 21:54:43 -0700 (PDT)
Received: from localhost ([223.190.59.99])
        by smtp.gmail.com with ESMTPSA id h63sm9182699pjb.29.2020.08.06.21.54.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Aug 2020 21:54:42 -0700 (PDT)
Date:   Fri, 7 Aug 2020 10:24:36 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kukjin Kim <kgene@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v2 34/41] cpufreq: s3c24xx: split out registers
Message-ID: <20200807045436.m3fsaew4632l36u7@vireshk-mac-ubuntu>
References: <20200806181932.2253-1-krzk@kernel.org>
 <20200806182059.2431-34-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200806182059.2431-34-krzk@kernel.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06-08-20, 20:20, Krzysztof Kozlowski wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Each of the cpufreq drivers uses a fixed set of register
> bits, copy those definitions into the drivers to avoid
> including mach/regs-clock.h.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> [krzk: Fix build by copying also S3C2410_LOCKTIME]
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
