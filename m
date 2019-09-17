Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31297B4906
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2019 10:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfIQIRq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Sep 2019 04:17:46 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43618 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfIQIRp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Sep 2019 04:17:45 -0400
Received: by mail-pl1-f194.google.com with SMTP id 4so1161639pld.10
        for <linux-pm@vger.kernel.org>; Tue, 17 Sep 2019 01:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F3boCEtfwUpsy+Na7nfCDYv10SwPrOANTgsbZ4pSMzw=;
        b=TlQkcOwi2+E1c+r1OTWiG7zaOtqqzZVufSex8xZHdMLjcFNzuaW4lsje52kYV6qIMN
         9gEK8DHoldXJl/rgBAy4hG53QlG0R1QMuWga/x/bK9NMAhJsPohFPA1hPZbytSUgCNyG
         NSS0P+JEWJyG9WbY/5bHTg0bl0pv2qUImVpDu7uzKGGD3AQT6tKWx+xnloG5ThMrRpS1
         GSJuzzJXjnbr8iRbjD52JSfyZrM89keJv3jaQwrzYHEENG4Dyedjv/s7qJXkDu/BGiSD
         sdVdy1eagfTScozKu0veaB/E8YNnfgEYLLvXiXvyWiFxp/vPAoytN6LQNU+ZGzHv2UsA
         mVew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F3boCEtfwUpsy+Na7nfCDYv10SwPrOANTgsbZ4pSMzw=;
        b=F9W0n7xZ7Cc6qnpNdMp0fayD69yWENu5FIlShiqf+N8QRYdzuJfDuqOGBEgc9VQgUN
         kclZiJnRjIZXVhq8i+tq6qycvKtqVHBv4gjbeRLjhSpTninKXu7VV+pcpuwKs0tK7n24
         zRrd5kYHpHWXaO3D78zwTdBQzCvb4rfBo+lw/tk+XIu3qH/qbp7NTJ5fq+cJH7fUXagv
         j84B3GyarEk++8D06tuotB8SKagGd4XMrSb7JR21f8GqDJ0Ym1HnkAJPhCm3SwrUIWwI
         fr7SkDX1Vv9KfcHd/NhXo3tpaKhIETk8gZH7zsjJHFcr7M32gbY3TSfLYrLRqP6+f3un
         sL3w==
X-Gm-Message-State: APjAAAWTiupbbPfXWtaysHT4b2XMHWBe0BYx86Ta12VboAFm0317D8GF
        LcxzREAfL/mAtgS8OHaz+QWcjg==
X-Google-Smtp-Source: APXvYqwNaqny1OEDhX1NcIm1yReLAq5ctcXj8dcflq9EEMy5Ef0nOc5/fpAELtYRznjciNeXmlD/dw==
X-Received: by 2002:a17:902:9001:: with SMTP id a1mr2450812plp.148.1568708265107;
        Tue, 17 Sep 2019 01:17:45 -0700 (PDT)
Received: from localhost ([122.172.73.172])
        by smtp.gmail.com with ESMTPSA id f12sm1428941pfn.73.2019.09.17.01.17.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Sep 2019 01:17:44 -0700 (PDT)
Date:   Tue, 17 Sep 2019 09:17:42 +0100
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        tdas@codeaurora.org, swboyd@chromium.org, ilina@codeaurora.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 5/5] cpufreq: qcom-hw: Move driver initialisation earlier
Message-ID: <20190917081742.fwoytnx4mzslcan7@vireshk-mac-ubuntu>
References: <cover.1568240476.git.amit.kucheria@linaro.org>
 <b731b713d8738239c26361ece7f5cadea035b353.1568240476.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b731b713d8738239c26361ece7f5cadea035b353.1568240476.git.amit.kucheria@linaro.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12-09-19, 04:02, Amit Kucheria wrote:
> Allow qcom-hw driver to initialise right after the cpufreq and thermal
> subsystems are initialised in core_initcall so we get earlier access to
> thermal mitigation.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index 4b0b50403901..04676cc82ba6 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -327,7 +327,7 @@ static int __init qcom_cpufreq_hw_init(void)
>  {
>  	return platform_driver_register(&qcom_cpufreq_hw_driver);
>  }
> -device_initcall(qcom_cpufreq_hw_init);
> +postcore_initcall(qcom_cpufreq_hw_init);

Even core_initcall should work just fine because of the ordering in
the Makefile in cpufreq directory.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
