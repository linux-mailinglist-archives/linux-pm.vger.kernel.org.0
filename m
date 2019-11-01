Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4A6ECA93
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2019 22:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfKAV6U (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Nov 2019 17:58:20 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:44587 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbfKAV6U (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 1 Nov 2019 17:58:20 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 474bc51Vfpz45;
        Fri,  1 Nov 2019 22:56:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1572645365; bh=E3NPr1GUIURuD9u8S6KPgRqpcDcat2o8UxiTeGXZ2EA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N65pH6hTJ6wTubXk8CBMLdBL/dpc/5UZ29k5P09zjNnYDVMd1lya88h1jgGN4+N2P
         Ug0LFqKkA/d+LRC9M8Fcj0BOrAQQX3VxGPD8i8yfYC7YNWUeZAtrxiBqXoVmQhUgcF
         ODJ42um/dPrfujG0Daj85iq2IT2s4KbWyhOilQQeOzh/V6yCSEabFietlN/iquqERY
         ccY9IP30gXH/TMZhEVFe04B5CsRDe61U9rfXgUTP4nZYwovY8FtrA53THAQh0sJy5S
         +FVWxFiJKFedDovDxgWqRTKJV/e5b1OTjXBhwuBbcY7u8XLZDuISWJs6OnUiywi9qx
         Fzr53UBP5DQTw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.4 at mail
Date:   Fri, 1 Nov 2019 22:58:16 +0100
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Peter Geis <pgwipeout@gmail.com>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 17/19] PM / devfreq: tegra30: Support variable polling
 interval
Message-ID: <20191101215816.GB8724@qmqm.qmqm.pl>
References: <20191029220019.26773-1-digetx@gmail.com>
 <20191029220019.26773-18-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191029220019.26773-18-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 30, 2019 at 01:00:17AM +0300, Dmitry Osipenko wrote:
> The ACTMON governor is interrupt-driven and currently hardware's polling
> interval is fixed to 16ms in the driver. Devfreq supports variable polling
> interval by the generic governors, let's re-use the generic interface for
> changing of the polling interval. Now the polling interval can be changed
> dynamically via /sys/class/devfreq/devfreq0/polling_interval.
[...]
> @@ -308,7 +308,7 @@ static unsigned long actmon_device_target_freq(struct tegra_devfreq *tegra,
>  	unsigned int avg_sustain_coef;
>  	unsigned long target_freq;
>  
> -	target_freq = dev->avg_count / ACTMON_SAMPLING_PERIOD;
> +	target_freq = dev->avg_count / tegra->devfreq->profile->polling_ms;
>  	avg_sustain_coef = 100 * 100 / dev->config->boost_up_threshold;
>  	target_freq = do_percent(target_freq, avg_sustain_coef);
>  	target_freq += dev->boost_freq;

Noting a comment in patch 13, if this is hot path you could try reciprocal_divide().

Best Regards,
Micha³ Miros³aw
