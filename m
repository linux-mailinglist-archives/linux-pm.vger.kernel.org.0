Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2B17E28AB
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2019 05:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390922AbfJXDNp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Oct 2019 23:13:45 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42577 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390541AbfJXDNo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Oct 2019 23:13:44 -0400
Received: by mail-pg1-f195.google.com with SMTP id f14so13310727pgi.9
        for <linux-pm@vger.kernel.org>; Wed, 23 Oct 2019 20:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/FvSWUTwb3VLZA0Xf0z7RcCEXwmqXYbk21bOLI6Ind8=;
        b=sKQkrmUmxlXGiYByd2i7MTXHlCBZpoduhmNKTn2b+4WTlEd9sqJxIlyZ+kwj6qCQt6
         4BIQumt//PtptZYr9DJp8O83ejzzIWb9zwkVqmB0Bf2/fPyoyBokiTWczNosOTRJQ5OY
         TLsGSWJWUIqamq4uD2ohoSqBavspu6j21L7o1rk5kyPzqVK/v/sq46u+fuxiWDYmaZ4u
         AU0XcEHw1+rfCDqi9jXvViNv+pLj3EIXq/XhytlYWlx5bJCiOL1x2+v0vl7i5PZFoOwt
         92BmIjiD3QDTfjY55Bk/GHBfFrBfes9X4OtcC3occLA7hH0pVPFddwHx3uWXMfnirMB3
         pcLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/FvSWUTwb3VLZA0Xf0z7RcCEXwmqXYbk21bOLI6Ind8=;
        b=fQ2x52yR/XEeUtGDRemulM0OHUFQifDHCrWGqoUWjYWA/MRtqeavkN2Zk8td/Ynfl4
         dWQ9VIMpow8Ij7x2K2+qLqdG0T2OvYmzBQDOmDxlOXXCb6x1tMcDW4cseM/3SMFnQHSk
         nO5YI5W+70B0VUXN3UQMZoagSgn2p47qmELCUeKfThH4KA4TNThNpBFEBPizht2CwBEl
         /8Ed5uoSUW7ay0Jhn6acydwep9Wr500NMlAFzpU2j3a8Irc8+HyOvsaN6Sm1eRatFPAG
         NyYOGnqnV82ksl+ORPMPY1ams1vvyYlrmk9n1nv0ORj2eihdFsSqeOvt0S+klmX6UuHA
         s57g==
X-Gm-Message-State: APjAAAUp6IP70XhsCy7Tc14cN32hxWRzOY4EJZc0nzirlpi8cyKEprSa
        oeoUuE1tg00ESJ+kLHv/HeeH0Q==
X-Google-Smtp-Source: APXvYqydSOmNxbN/vYtkU1iPjd1cVFUew/aXCub1UINvWE/D7AIfNj9Kf6waQGQolR3SBvI3HEafpw==
X-Received: by 2002:a63:1b59:: with SMTP id b25mr13990872pgm.267.1571886823938;
        Wed, 23 Oct 2019 20:13:43 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id x12sm23593463pfm.130.2019.10.23.20.13.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 20:13:43 -0700 (PDT)
Date:   Thu, 24 Oct 2019 08:43:39 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] cpufreq: s3c64xx: Remove pointless NULL check in
 s3c64xx_cpufreq_driver_init
Message-ID: <20191024031339.qaoh3p5efmaawslq@vireshk-i7>
References: <20191023000906.14374-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023000906.14374-1-natechancellor@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22-10-19, 17:09, Nathan Chancellor wrote:
> When building with Clang + -Wtautological-pointer-compare:
> 
> drivers/cpufreq/s3c64xx-cpufreq.c:152:6: warning: comparison of array
> 's3c64xx_freq_table' equal to a null pointer is always false
> [-Wtautological-pointer-compare]
>         if (s3c64xx_freq_table == NULL) {
>             ^~~~~~~~~~~~~~~~~~    ~~~~
> 1 warning generated.
> 
> The definition of s3c64xx_freq_table is surrounded by an ifdef
> directive for CONFIG_CPU_S3C6410, which is always true for this driver
> because it depends on it in drivers/cpufreq/Kconfig.arm (and if it
> weren't, there would be a build error because s3c64xx_freq_table would
> not be a defined symbol).
> 
> Resolve this warning by removing the unnecessary NULL check because it
> is always false as Clang notes. While we are at it, remove the
> unnecessary ifdef conditional because it is always true.
> 
> Fixes: b3748ddd8056 ("[ARM] S3C64XX: Initial support for DVFS")
> Link: https://github.com/ClangBuiltLinux/linux/issues/748
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/cpufreq/s3c64xx-cpufreq.c | 7 -------
>  1 file changed, 7 deletions(-)

Applied. Thanks.

-- 
viresh
