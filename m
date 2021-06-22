Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5043F3B0CFC
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jun 2021 20:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbhFVSiI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Jun 2021 14:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbhFVSiH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Jun 2021 14:38:07 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A791BC061756
        for <linux-pm@vger.kernel.org>; Tue, 22 Jun 2021 11:35:51 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id c7-20020a17090ad907b029016faeeab0ccso2243668pjv.4
        for <linux-pm@vger.kernel.org>; Tue, 22 Jun 2021 11:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ote9UxpI2eVW5qYip4aisFOa5GQyaDapZllhen4xxmE=;
        b=dfU0xP1FlBWqUCrDJvTf1hWReFmZ2KvKjbuupJt//XFkBOFDK7rspyDLPHvasPpviM
         73g6NymRK0kTlMyONUldEr/bNDWzOV4v9gzK4Dq64tk63XGPF4hZr9cfP3JZ9ERNDRmG
         z/PQkdpMmZl1PgQCdBzQqKsqBDpoJ9M/gfY4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ote9UxpI2eVW5qYip4aisFOa5GQyaDapZllhen4xxmE=;
        b=P4wQpeaWmAV+RFjsg8OeYN6mxVbI5JuCzJ8qaCzLNONX1uC+B1r4IfSScDDE3Vz9Ui
         yy+hyH3/JjD/MzsaRYtFgH9NBKslQG8Vc1MVgcJ0E5yODtJV5bCzxriK9VANrwIX2VWf
         hvhvB3KS64i4Sg8MqMKkwl9vO7Kku++3jpm6QKiEnIWUQiDHSGA4KxsZXLSMqtbxVS+2
         r3Tjt5+WB5TK/kL0ucxhKfiMYEwRT3O9O+PmBqr7iq1EZqy5vr1v4DQxERVKyitvSyFW
         I89yItsTBaXb58Obju7g/5c8NRUCZf34jBRHYHAKFY+4Cm/EF/jdnyXyTMDukCTmq7jt
         oFDw==
X-Gm-Message-State: AOAM532a/cuIBw8MLTN5MqWudJquGS1Cz4m0Hijr9wS3frAceBthOtRB
        IzxWWM7SrUM5/J4EhwFY4yZC7w==
X-Google-Smtp-Source: ABdhPJxMfjDCHbCpfzuSdBF4vacIDJdzKiwAopPiGiUEGDj0w0oiBYRKo8Gkmxb79AtTCf6PqlHW/w==
X-Received: by 2002:a17:902:c1cc:b029:122:52b4:3855 with SMTP id c12-20020a170902c1ccb029012252b43855mr19208503plc.10.1624386951230;
        Tue, 22 Jun 2021 11:35:51 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:dc21:8b6f:f8cd:9070])
        by smtp.gmail.com with UTF8SMTPSA id lt14sm2928812pjb.47.2021.06.22.11.35.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 11:35:50 -0700 (PDT)
Date:   Tue, 22 Jun 2021 11:35:48 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     andrew-sh.cheng@mediatek.com, hsinyi@chromium.org,
        sibis@codeaurora.org, saravanak@google.com,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        chanwoo@kernel.org, cwchoi00@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] PM / devfreq: passive: Reduce duplicate code when
 passive_devfreq case
Message-ID: <YNIthEVkS8OK19pm@google.com>
References: <20210617060546.26933-1-cw00.choi@samsung.com>
 <CGME20210617054647epcas1p41cd87f03bc6f5b44b6f2d7a3e5924860@epcas1p4.samsung.com>
 <20210617060546.26933-5-cw00.choi@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210617060546.26933-5-cw00.choi@samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jun 17, 2021 at 03:05:46PM +0900, Chanwoo Choi wrote:
> In order to keep the consistent coding style between passive_devfreq
> and passive_cpufreq, use common code for handling required opp property.
> Also remove the unneed conditional statement and unify the comment
> of both passive_devfreq and passive_cpufreq when getting the target frequency.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/devfreq/governor_passive.c | 80 ++++++------------------------
>  1 file changed, 15 insertions(+), 65 deletions(-)
> 
> diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
> index 07e864509b7e..7102cb7eb30d 100644
> --- a/drivers/devfreq/governor_passive.c
> +++ b/drivers/devfreq/governor_passive.c
> @@ -91,66 +91,17 @@ static int get_target_freq_with_devfreq(struct devfreq *devfreq,
>  	struct devfreq_passive_data *p_data
>  			= (struct devfreq_passive_data *)devfreq->data;
>  	struct devfreq *parent_devfreq = (struct devfreq *)p_data->parent;
> -	unsigned long child_freq = ULONG_MAX;
> -	struct dev_pm_opp *opp, *p_opp;
> -	int i, count;
> -
> -	/*
> -	 * If the devfreq device with passive governor has the specific method
> -	 * to determine the next frequency, should use the get_target_freq()
> -	 * of struct devfreq_passive_data.
> -	 */
> -	if (p_data->get_target_freq)
> -		return p_data->get_target_freq(devfreq, freq);
> -
> -	/*
> -	 * If the parent and passive devfreq device uses the OPP table,
> -	 * get the next frequency by using the OPP table.
> -	 */
> -
> -	/*
> -	 * - parent devfreq device uses the governors except for passive.
> -	 * - passive devfreq device uses the passive governor.
> -	 *
> -	 * Each devfreq has the OPP table. After deciding the new frequency
> -	 * from the governor of parent devfreq device, the passive governor
> -	 * need to get the index of new frequency on OPP table of parent
> -	 * device. And then the index is used for getting the suitable
> -	 * new frequency for passive devfreq device.
> -	 */
> -	if (!devfreq->profile || !devfreq->profile->freq_table
> -		|| devfreq->profile->max_state <= 0)
> -		return -EINVAL;
> -
> -	/*
> -	 * The passive governor have to get the correct frequency from OPP
> -	 * list of parent device. Because in this case, *freq is temporary
> -	 * value which is decided by ondemand governor.
> -	 */
> -	if (devfreq->opp_table && parent_devfreq->opp_table) {
> -		p_opp = devfreq_recommended_opp(parent_devfreq->dev.parent,
> -						freq, 0);
> -		if (IS_ERR(p_opp))
> -			return PTR_ERR(p_opp);
> -
> -		opp = dev_pm_opp_xlate_required_opp(parent_devfreq->opp_table,
> -						    devfreq->opp_table, p_opp);
> -		dev_pm_opp_put(p_opp);
> -
> -		if (IS_ERR(opp))
> -			goto no_required_opp;
> -
> -		*freq = dev_pm_opp_get_freq(opp);
> -		dev_pm_opp_put(opp);
> -
> -		return 0;
> -	}
> +	unsigned long target_freq;
> +	int i;
> +
> +	/* Get target freq via required opps */
> +	target_freq = get_taget_freq_by_required_opp(parent_devfreq->dev.parent,
> +						parent_devfreq->opp_table,
> +						devfreq->opp_table, *freq);

s/get_taget_freq_by_required_opp/get_target_freq_by_required_opp/

Also need to be fixed in "[3/4] PM / devfreq: Add cpu based scaling
support to passive governor".

> +	if (target_freq)
> +		goto out;
>  
> -no_required_opp:
> -	/*
> -	 * Get the OPP table's index of decided frequency by governor
> -	 * of parent device.
> -	 */
> +	/* Use Interpolation if required opps is not available */

s/Interpolation/interpolation/

>  	for (i = 0; i < parent_devfreq->profile->max_state; i++)
>  		if (parent_devfreq->profile->freq_table[i] == *freq)
>  			break;
> @@ -158,16 +109,15 @@ static int get_target_freq_with_devfreq(struct devfreq *devfreq,
>  	if (i == parent_devfreq->profile->max_state)
>  		return -EINVAL;
>  
> -	/* Get the suitable frequency by using index of parent device. */
>  	if (i < devfreq->profile->max_state) {
> -		child_freq = devfreq->profile->freq_table[i];
> +		target_freq = devfreq->profile->freq_table[i];
>  	} else {
> -		count = devfreq->profile->max_state;
> -		child_freq = devfreq->profile->freq_table[count - 1];
> +		i = devfreq->profile->max_state;
> +		target_freq = devfreq->profile->freq_table[i - 1];
>  	}
>  
> -	/* Return the suitable frequency for passive device. */
> -	*freq = child_freq;
> +out:
> +	*freq = target_freq;

You might want to split the child_freq => target_freq and commentary change into
a separate patch, since it is not directly related with the switch to
get_target_freq_by_required_opp().
