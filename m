Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69B0BF2525
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2019 03:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbfKGCRt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Nov 2019 21:17:49 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38308 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727916AbfKGCRt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Nov 2019 21:17:49 -0500
Received: by mail-pl1-f195.google.com with SMTP id w8so370918plq.5
        for <linux-pm@vger.kernel.org>; Wed, 06 Nov 2019 18:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oLHacKzHZgLKnqhODOuVZZmKs7VqKNsx/Wfl9Bp8UT4=;
        b=Q6R5oVPeoRd+8FoBsFbh1RivV42+kqXhKnanJ30m9Lw+4UOKDWBXB/nvZYSwvc7XjR
         5y771pBX0NB/xL5w+IV6MVEq/2eRRDP/E6B3ba8uVGK+6320NghXrJAYKFFmc4fHE9zl
         354HjJhREdiy50aIg0wW6lf9l1WUf/vuEpCO4eqV7IhsdfDpdsBI5h7BGrZJJdEn7y6/
         r9PL0yfE5DnxTRdldPmDA+zQWwAp/fEF6OmcaccwO90k1frgwaibwtkFTEkale92Dg20
         Yj3FrFKqZjDDx3U5wCWdRhds3iHpX0ChKEh9NKJSs1t3byYNfj1NAWJbQBvXW67AO/Pm
         AoUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oLHacKzHZgLKnqhODOuVZZmKs7VqKNsx/Wfl9Bp8UT4=;
        b=Mj5Y6UfhQNF6RcGAdX8iqrHR9YxFD4mhKICaf+O6T9CIa1pbGLhExiSWbExr8qKZ3q
         w4SEpn7etPro94Rlo84ieByWJ/4ZgFVYf3+1wTJ7ozUdAC4UFd+mr05doRyTV0ismGuN
         SXoD0yVxWXJC5fSxCsDkdfKu5u2NlmnZWX3oIjD4hwKLnnd8G3artPIpBhy6XWCXf9dw
         g8rI1B3g8niZOS3h627YJdyDHeFFeLe235nGk5zHqewyVm/7QXi6CpJLbO1k5ZoexLm2
         NM+CmegqDBNvibMdDg9UsRBLVLU/eFgjZM8w4SgCwXUWQdT5+QpK8V1nmXF9jfl7QHzE
         5fmw==
X-Gm-Message-State: APjAAAVE+nuAtYgJ3jflSmgohhTozDRC2lyt3m4dI9FZQBzkUyiiHXuA
        AwuGkf4IpHV4orzhWjrHH67eDw==
X-Google-Smtp-Source: APXvYqzc2k8FZkL3QrNjSraGFW2bpWoq0BWE60OPxSquL/rQp8ShcARdG8pmcvsB+0ZAHtAhWNx+2A==
X-Received: by 2002:a17:902:6946:: with SMTP id k6mr1048328plt.60.1573093068142;
        Wed, 06 Nov 2019 18:17:48 -0800 (PST)
Received: from localhost ([122.171.110.253])
        by smtp.gmail.com with ESMTPSA id y144sm319420pfb.188.2019.11.06.18.17.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 18:17:47 -0800 (PST)
Date:   Thu, 7 Nov 2019 07:47:44 +0530
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
Subject: Re: [PATCH 04/11] thermal: devfreq_cooling: Appease the kernel-doc
 deity
Message-ID: <20191107021744.xfhuzvzggojnbpwg@vireshk-i7>
References: <cover.1573046440.git.amit.kucheria@linaro.org>
 <fbaad8b0854e8127624e6b7bd5f1272eaf8aee85.1573046440.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbaad8b0854e8127624e6b7bd5f1272eaf8aee85.1573046440.git.amit.kucheria@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06-11-19, 18:58, Amit Kucheria wrote:
> Fix up the following warnings with make W=1:
> 
> linux.git/drivers/thermal/devfreq_cooling.c:593: warning: Function
> parameter or member 'cdev' not described in 'devfreq_cooling_unregister'
> linux.git/drivers/thermal/devfreq_cooling.c:593: warning: Excess
> function parameter 'dfc' description in 'devfreq_cooling_unregister'
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/thermal/devfreq_cooling.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
> index ef59256887ff6..a87d4fa031c87 100644
> --- a/drivers/thermal/devfreq_cooling.c
> +++ b/drivers/thermal/devfreq_cooling.c
> @@ -53,6 +53,7 @@ static DEFINE_IDA(devfreq_ida);
>   *		'utilization' (which is	'busy_time / 'total_time').
>   *		The 'res_util' range is from 100 to (power_table[state] * 100)
>   *		for the corresponding 'state'.
> + * @capped_state:	index to cooling state with in dynamic power budget

Should there be space instead of tab after : ?

And warning in $subject doesn't talk about this change.

>   */
>  struct devfreq_cooling_device {
>  	int id;
> @@ -587,7 +588,7 @@ EXPORT_SYMBOL_GPL(devfreq_cooling_register);
>  
>  /**
>   * devfreq_cooling_unregister() - Unregister devfreq cooling device.
> - * @dfc: Pointer to devfreq cooling device to unregister.
> + * @cdev: Pointer to devfreq cooling device to unregister.
>   */
>  void devfreq_cooling_unregister(struct thermal_cooling_device *cdev)
>  {
> -- 
> 2.17.1

-- 
viresh
