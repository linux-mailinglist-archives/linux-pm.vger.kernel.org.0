Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8654F2527
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2019 03:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733038AbfKGCSE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Nov 2019 21:18:04 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40358 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727916AbfKGCSE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Nov 2019 21:18:04 -0500
Received: by mail-pf1-f196.google.com with SMTP id r4so1119419pfl.7
        for <linux-pm@vger.kernel.org>; Wed, 06 Nov 2019 18:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5UgTpssgbascxLsTXhAGYH7ppzbWmgnvcWThiivs4Fo=;
        b=FDKOnNsNLRRwgoLm8pQIP4G0qLnIMMfp0oaI7+B3QE87qNjrPFh18A5gUeaxMgngtK
         CDMvyDedb667oeYvnXFhK0VBLJotDbK0Pffc8PwKpYyH2kN41w6OFrnOKvT0LpE8pXHo
         jOAgZDf7bzCDw5QKuuQcRxEY0LL5YU8lAfMiuNmhtVpKglgn2ZHxUh1CD+7An0RmNzOi
         84iwaX/80dC6kA5ruH2Z+3mKGQD3FgkEfFhCuGXkuQTFfy5zOK5vADFf4WxKrQnQeBtH
         nq1gv8uiz58d8B1d7rnSgzsGLwJyKWLwtEfiNf8pkSWuDB/2/4O9UGJOIJCf/UKPa1WV
         WatQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5UgTpssgbascxLsTXhAGYH7ppzbWmgnvcWThiivs4Fo=;
        b=bnd2sh/smVR+nkmOcu/wIn3Qw41MAOYMlniHqeZupG/mRov8MJQHznX/Gqu/UsuoAm
         R1kiCQHSN4N+MvNAfz7PMZi0FBEpdL74bO56o357zLfmpAkP2A7QcB61kzagV5DeL77M
         RbIUNTyCe7fN9yjdKvZcz9pP3IdEKtg0C9I0h8XUwCteVmtkjKfqVjLeuSRsXN1Qo8TO
         iP8XG98C5fP0zsMkBEG6tVlQ9c0xRfuqRoyDGGaYwcnQqBra5TROaj1uaeZSfMsLgqYh
         ACHYht5OhzKnLXuLmZmWRTwxzXXdjBubpmG/QyW0yQAadqWInMXTquNE6S1ErmwtNODk
         pFvw==
X-Gm-Message-State: APjAAAWEhzAYY1gVU04AvedLk3bdkkqzmwt26xdhuvMRi/h0JsSqV6f6
        TdD274IcRDAk0Q6QguiDhA5FMw==
X-Google-Smtp-Source: APXvYqxoOaojLpWevR53u4uCD4aAxNz+Q1mfzjc+2soq3oWQ262TC1IST8EcwAZssX9PWuxgL6GDlQ==
X-Received: by 2002:a62:1ac6:: with SMTP id a189mr763343pfa.96.1573093083020;
        Wed, 06 Nov 2019 18:18:03 -0800 (PST)
Received: from localhost ([122.171.110.253])
        by smtp.gmail.com with ESMTPSA id 1sm383697pgp.88.2019.11.06.18.18.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 18:18:02 -0800 (PST)
Date:   Thu, 7 Nov 2019 07:47:58 +0530
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
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 05/11] thermal: max77620: Appease the kernel-doc deity
Message-ID: <20191107021758.at6ungoa36j2jcof@vireshk-i7>
References: <cover.1573046440.git.amit.kucheria@linaro.org>
 <09609109359054d2a1f7e0456402ebabad1e315f.1573046440.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09609109359054d2a1f7e0456402ebabad1e315f.1573046440.git.amit.kucheria@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06-11-19, 18:58, Amit Kucheria wrote:
> Fix up the following warning when compiled with make W=1:
> 
> linux.git/drivers/thermal/max77620_thermal.c:48: warning: Function
> parameter or member 'temp' not described in 'max77620_thermal_read_temp'
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/thermal/max77620_thermal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/max77620_thermal.c b/drivers/thermal/max77620_thermal.c
> index 88fd0fbe0cfac..82d06c7411eb3 100644
> --- a/drivers/thermal/max77620_thermal.c
> +++ b/drivers/thermal/max77620_thermal.c
> @@ -33,7 +33,7 @@ struct max77620_therm_info {
>  /**
>   * max77620_thermal_read_temp: Read PMIC die temperatue.
>   * @data:	Device specific data.
> - * temp:	Temperature in millidegrees Celsius
> + * @temp:	Temperature in millidegrees Celsius
>   *
>   * The actual temperature of PMIC die is not available from PMIC.
>   * PMIC only tells the status if it has crossed or not the threshold level

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
