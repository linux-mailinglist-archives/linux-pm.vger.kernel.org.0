Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49B2CF2545
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2019 03:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732916AbfKGCWX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Nov 2019 21:22:23 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36528 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732847AbfKGCWW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Nov 2019 21:22:22 -0500
Received: by mail-pf1-f194.google.com with SMTP id v19so1153212pfm.3
        for <linux-pm@vger.kernel.org>; Wed, 06 Nov 2019 18:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0Dwg4nKN26FTiz3kUQPPImpGsNBhOzcTkcdPORnJLCU=;
        b=dUnfjWKT55TBryM45O4ZQx3XbW/rctfANSlGJkwmKfWyFpMd6/ERRFv1RqpxsjC9sN
         iKqoJMRqSRKsWOcZ5lDMh594AgBhFYSoDO/ROBA+8peEFIJJNUAWz6ZjTNcTCPiQVun6
         IvyxnKJyZCQLggi+j/1UGxoPpmYPxzdJmyOKOpeMElynMpJndl2vvRzcIoFZKboHPVaz
         liWSc+Gq8LdhDEyHMdjULMp3bPF9g/qz8Nu8tct8ME6rUjzDHbM844Q7T3NCHG+5NCIQ
         qJp8mX1abIhCqhvY2IBV7epdx+ZdUxnokVEkcyAZWvQ7UReSZTzb1Ana+Ni0sI6heBqe
         iITQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0Dwg4nKN26FTiz3kUQPPImpGsNBhOzcTkcdPORnJLCU=;
        b=R+Z2B1qzocv1CZmj0teRPF2AxcFiD9X5DPSwGFzXvBPoF44+ElBNfhfR3c/myJ2WJn
         S+y9Nl9gmAVwj8ZKJLfESSwCNp9SMzxCNC2fvUn3+jpJycS4y7Q81i4A5h121gDYCUBM
         8PzpMI9atJPTt8zbyFnGbcMZdUE6g7bAY4oEjyTfJKp9WexwZBApzOGGq1Tz4Blyic0F
         iS9+/2pjQnGyoGiCusx/gLlm/BPSwz7CNJtrwA15PKeYM733Z1zaz2oWHtUgTuRXiaEA
         Sx0OJpMcNoyTvIAtQAcyyheFqCk8iKWlsNoxHbIYKsvItM/n3ktjjmcUN0hQ/L6gG961
         fw9g==
X-Gm-Message-State: APjAAAXb1vKG5owRJ38oyGSS5aJ7TM+L/sX5zvsbY3f/rACSruxzFk8i
        GQr4cNzIQx+08z58mQ2mffKxrw==
X-Google-Smtp-Source: APXvYqx6sPgPssAsJK6MK3EweF+OP9VsrDLjnKNnBoMpc6WKMKwCRX0ayTFftLjmp1KSHStUzMzYUA==
X-Received: by 2002:a17:90a:cb8b:: with SMTP id a11mr1570656pju.79.1573093340492;
        Wed, 06 Nov 2019 18:22:20 -0800 (PST)
Received: from localhost ([122.171.110.253])
        by smtp.gmail.com with ESMTPSA id f8sm400297pgd.64.2019.11.06.18.22.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 18:22:19 -0800 (PST)
Date:   Thu, 7 Nov 2019 07:52:16 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, edubezval@gmail.com,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Guillaume La Roque <glaroque@baylibre.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Javi Merino <javi.merino@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jun Nie <jun.nie@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 10/11] thermal: amlogic: Appease the kernel-doc deity
Message-ID: <20191107022216.prhwyxvxpabpbuej@vireshk-i7>
References: <cover.1573046440.git.amit.kucheria@linaro.org>
 <2fbace543c7a45799f29f87d9aee82f2ed1a7dbe.1573046440.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fbace543c7a45799f29f87d9aee82f2ed1a7dbe.1573046440.git.amit.kucheria@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06-11-19, 18:58, Amit Kucheria wrote:
> Fix up the following warning when compiled with make W=1:
> 
> linux.git/drivers/thermal/amlogic_thermal.c:78: warning: Function parameter or member 'A' not described in 'amlogic_thermal_soc_calib_data'
> linux.git/drivers/thermal/amlogic_thermal.c:78: warning: Function parameter or member 'B' not described in 'amlogic_thermal_soc_calib_data'
> linux.git/drivers/thermal/amlogic_thermal.c:78: warning: Function parameter or member 'm' not described in 'amlogic_thermal_soc_calib_data'
> linux.git/drivers/thermal/amlogic_thermal.c:78: warning: Function parameter or member 'n' not described in 'amlogic_thermal_soc_calib_data'
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/thermal/amlogic_thermal.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/amlogic_thermal.c b/drivers/thermal/amlogic_thermal.c
> index 8a9e9bc421c68..ccb1fe18e9931 100644
> --- a/drivers/thermal/amlogic_thermal.c
> +++ b/drivers/thermal/amlogic_thermal.c
> @@ -67,7 +67,11 @@
>  
>  /**
>   * struct amlogic_thermal_soc_calib_data
> - * @A, B, m, n: calibration parameters
> + * @A: calibration parameters
> + * @B: calibration parameters
> + * @m: calibration parameters
> + * @n: calibration parameters
> + *
>   * This structure is required for configuration of amlogic thermal driver.
>   */
>  struct amlogic_thermal_soc_calib_data {

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
