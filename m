Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78EA4C9375
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2019 23:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbfJBVYl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Oct 2019 17:24:41 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39981 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728220AbfJBVYk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Oct 2019 17:24:40 -0400
Received: by mail-pl1-f195.google.com with SMTP id d22so437187pll.7
        for <linux-pm@vger.kernel.org>; Wed, 02 Oct 2019 14:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BTX2GSqsV6kTV3Pvc2Q5r/mtwfFtpL/CWWCZhRetRTs=;
        b=e+mqSw6IJR/B8mgIbtZx5sXFHlfRMudyijdRdZcL/hU1q1tmLM2a1dbNTj/hXPA32A
         R4lmEhkE/aB2z9ocxsZI3htEOlWQ3VoY4WfURw82rbWl32W10jRyLe+LM9cxvTQH2MPP
         Pwl87v9ABp4brXG9bQLv8pR5o2qTMabu8321Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BTX2GSqsV6kTV3Pvc2Q5r/mtwfFtpL/CWWCZhRetRTs=;
        b=Cjtt/fy7kuoIAY0qWcB17IJ6CUYqqd68jusuiHT/V/Ai8msx0utK1e1bdFgiY9XN4U
         Ir5mQnApPEx9WlQ+RhcnTZlzXWYa8r9VYrZAfTcYbSw7+1qUCfoLMZ+3LveNDJu9RBGO
         EKIoS/P6oFzVezwgZqVMYIdir2ePwTDbUIWZEli6bJ2HprNrKTUldOV5RqUz8Hz1LcAy
         Ny7FeVt3StuzyvQuzek/N+tCDbXGNTNQ12GeS546YMhqXrkPSdxrAAK9agRAu/kgxjQH
         xlzHnBJWxZ67gA5BvpgGrVWw0tEVcJ1eT0yi10FpOW+pqncOdfDuIYSNotqdh/yVTNob
         9H/Q==
X-Gm-Message-State: APjAAAVPX2R2++ZdDcaq/uUylWiQm01edIeLJykgoQwp2A0MqgjN32U7
        2vJgv/z130IP3apdepXdpKwXGQ==
X-Google-Smtp-Source: APXvYqzbfa2TsOro/cQ8MOAqKaucPW2GW2LTOZyN9kOeBft1PqNo4OgVbQ2Q5v33eGeomCew+95xYQ==
X-Received: by 2002:a17:902:680d:: with SMTP id h13mr6026330plk.300.1570051480042;
        Wed, 02 Oct 2019 14:24:40 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id y10sm369518pfe.148.2019.10.02.14.24.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2019 14:24:39 -0700 (PDT)
Date:   Wed, 2 Oct 2019 14:24:37 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Artur =?utf-8?B?xZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 2/8] PM / devfreq: Fix devfreq_notifier_call returning
 errno
Message-ID: <20191002212437.GF87296@google.com>
References: <cover.1570044052.git.leonard.crestez@nxp.com>
 <10b1e5f93e7594852aa5cbfe1309bf486f70ecbb.1570044052.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <10b1e5f93e7594852aa5cbfe1309bf486f70ecbb.1570044052.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 02, 2019 at 10:25:05PM +0300, Leonard Crestez wrote:
> Notifier callbacks shouldn't return negative errno but one of the
> NOTIFY_OK/DONE/BAD values.
> 
> The OPP core will ignore return values from notifiers but returning a
> value that matches NOTIFY_STOP_MASK will stop the notification chain.
> 
> Fix by always returning NOTIFY_OK.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/devfreq/devfreq.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 7dc899da1172..32bbf6e80380 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -548,30 +548,32 @@ EXPORT_SYMBOL(devfreq_interval_update);
>   */
>  static int devfreq_notifier_call(struct notifier_block *nb, unsigned long type,
>  				 void *devp)
>  {
>  	struct devfreq *devfreq = container_of(nb, struct devfreq, nb);
> -	int ret;
> +	int err = -EINVAL;
>  
>  	mutex_lock(&devfreq->lock);
>  
>  	devfreq->scaling_min_freq = find_available_min_freq(devfreq);
> -	if (!devfreq->scaling_min_freq) {
> -		mutex_unlock(&devfreq->lock);
> -		return -EINVAL;
> -	}
> +	if (!devfreq->scaling_min_freq)
> +		goto out;
>  
>  	devfreq->scaling_max_freq = find_available_max_freq(devfreq);
> -	if (!devfreq->scaling_max_freq) {
> -		mutex_unlock(&devfreq->lock);
> -		return -EINVAL;
> -	}
> +	if (!devfreq->scaling_max_freq)
> +		goto out;
> +
> +	err = update_devfreq(devfreq);
>  
> -	ret = update_devfreq(devfreq);
> +out:
>  	mutex_unlock(&devfreq->lock);
> +	if (err)
> +		dev_err(devfreq->dev.parent,
> +			"failed to update frequency from OPP notifier (%d)\n",
> +			err);

In case an OPP freq can't be found the log doesn't provide clues
about what the problem could be. I couldn't find a clearly superior
errno value though, so I guess this is as good as it gets, unless
you want to have a dedicated message for those errors. Should be a
rare exception anyway, and previously there was no log at all.

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
