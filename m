Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4793D87FD
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2019 07:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbfJPFSI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 01:18:08 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43065 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbfJPFSI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2019 01:18:08 -0400
Received: by mail-pf1-f194.google.com with SMTP id a2so13920952pfo.10
        for <linux-pm@vger.kernel.org>; Tue, 15 Oct 2019 22:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w5jeTAUu2dH6eGAGHgWEVYzVkyO/taLa8UG7PTgaHwM=;
        b=lsfUVd6lfFzRxgUM1e6spyrH2erNtW01SmzxvvBajKsw0oHxA6MS9+Z5qae8eQsVt0
         FxCgEsf12c5Bff/Bk1m2wgcz3razz6j/knebeJkEjP0q/TE+7BCiAKbzmXGiacNOhRNH
         TcILPGhc1VP+9J/LpEly0hgLXFmaAkYPkWS/NjL8w2tEgKOVJU4kZ+k2bzstrQAoKUD9
         fxPHtdIO0pxxClysn5INWq5XdfspoFfGGCF/mWBRNj3JARrUY6e+zIq7rXPD3M15B0qe
         eveBJjXQimtRcXKPwtZ/m3gc+DLcOxJi23y+E1WpBjJsi2Ak3sv5/20dkhXbEtnOb1Ff
         UjnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w5jeTAUu2dH6eGAGHgWEVYzVkyO/taLa8UG7PTgaHwM=;
        b=JTMEwwqFGxJddeLVhTkIdOI4x5+K4XdT6YsKtHo2KIPO7rTZA7+OuEe/QFq73CXbsu
         Tpha8ohu4YhKHcXwS87HLKknE4cq+evJ+as7d6y3Z5ai+kMtOP4RlE2vzZwbwL/Ovkp8
         7vWCd59vBGYjTK0fM5j+JxALxyY3/JSuyiEWLTH7rVPkUuw2ESQA5cuoMMP/0i3EZr8b
         kS+iTEiwDtxepnwI7AYVpE6LAykMuqn+JueWgJnw4ydvF1OFJTsz4tr1CRoA8THpyxso
         RTjMq1NaQYqluXEYDeEyGDR7+SdJBtfciTVgWgdK7VrtkSmFRkxdk7FG1TveBvB5twTh
         9h1g==
X-Gm-Message-State: APjAAAUM5eqRPJXMQG+UjhxpHQgyVk/VIU49aL/fW6JKk/MfYtW22/HT
        amB6+9d4/KBwbEsAVJyUaZev1tpj3BE=
X-Google-Smtp-Source: APXvYqwZd98KfNQiPy1wPqFgM+lyEQ66XIK1EdhyW1Uau66q2f9IzajjqN3rjHJYvgacazg4RXji5w==
X-Received: by 2002:a17:90a:b391:: with SMTP id e17mr2746680pjr.132.1571203087074;
        Tue, 15 Oct 2019 22:18:07 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id ev20sm1018738pjb.19.2019.10.15.22.18.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 22:18:05 -0700 (PDT)
Date:   Wed, 16 Oct 2019 10:48:02 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 07/17] cpufreq: tegra20: Use generic cpufreq-dt driver
 (Tegra30 supported now)
Message-ID: <20191016051802.rrxv56vtvxfm6qqe@vireshk-i7>
References: <20191015211618.20758-1-digetx@gmail.com>
 <20191015211618.20758-8-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015211618.20758-8-digetx@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16-10-19, 00:16, Dmitry Osipenko wrote:
> Re-parenting to intermediate clock is supported now by the clock driver
> and thus there is no need in a customized CPUFreq driver, all that code
> is common for both Tegra20 and Tegra30. The available CPU freqs are now
> specified in device-tree in a form of OPPs, all users should update their
> device-trees.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/cpufreq/Kconfig.arm          |   4 +-
>  drivers/cpufreq/cpufreq-dt-platdev.c |   2 +
>  drivers/cpufreq/tegra20-cpufreq.c    | 236 ++++++---------------------
>  3 files changed, 55 insertions(+), 187 deletions(-)
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index a905796f7f85..2118c45d0acd 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -301,8 +301,8 @@ config ARM_TANGO_CPUFREQ
>  	default y
>  
>  config ARM_TEGRA20_CPUFREQ
> -	tristate "Tegra20 CPUFreq support"
> -	depends on ARCH_TEGRA
> +	bool "Tegra20 CPUFreq support"

Google is currently working on the GKI (generic kernel image) project where they
want to use a single kernel image with modules for all kind of android devices.
And for that they need all such drivers to be built as module. Since this is
already an module, I would ask you to keep it as is instead of moving it to bool
here. Else some google guy will switch it back as module later on.

LGTM otherwise. Nice work. Thanks.

-- 
viresh
