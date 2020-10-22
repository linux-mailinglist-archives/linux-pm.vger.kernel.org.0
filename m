Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 734BF295665
	for <lists+linux-pm@lfdr.de>; Thu, 22 Oct 2020 04:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895058AbgJVCaY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Oct 2020 22:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2894988AbgJVCaX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Oct 2020 22:30:23 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B669C0613CE;
        Wed, 21 Oct 2020 19:30:23 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id 23so266468ljv.7;
        Wed, 21 Oct 2020 19:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=23JIzalfv0ggVkyqjQr+BuKWg31TSczrM+Eba30Wc8g=;
        b=YEt9sG/Ha7WLxkLoBsF/QQl3yasCICjyFATWnguGX/BIQc0yp6wl8x4Zdv1jULxk/l
         5Hxy6OBpz+T3sBNCATpXyFs4DMqb+W2Zzq6ToT2P3dFR2EVVc+6ifIXCC4oNOt28dwDY
         W4Nsb7T8MIcKiwUCjkMT6U3sWiWgZuG72opuVgT9OjVsuUrfh/cPwF2EaH5jZt3Wqeoh
         Kl7nJ7CBPKFHjpgGsJOoC4Ko43u62tbPgakRNbVIgGgiIq89MBLs7I3MlsPuKVUxlRee
         9M98k6+1FA4weR3LKdOSpTcJCvhHXgr4mWP4LeKS4Z8uvJc7SwzpGod+kCGUVeVBoMbN
         qemA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=23JIzalfv0ggVkyqjQr+BuKWg31TSczrM+Eba30Wc8g=;
        b=K4EadbLSpK94HKu8/+/ph+BqNd6cefUTExpXaeJiaVbpVtEK8WfyEf/U5LqHrVrW2v
         0sgf4XIt9YYPMu8zjljiF9WriOcr2nXumLXQu6B2N1f34P3ufSOQ/aH6leSU7gcN9o1y
         dMyAavlyHYz2cmGv5l3Ri6muRVlM0UGNJJnt86LptcGT5DNegIh8WLeOXjQnjTlz7sd7
         HuLfX+xVa5V3WvbIozubHn3P/0VWHptmUe046578KAw3Niih+xB0yEzHfP9z6m1wbWgR
         y3ixSV4++Oc4kkPI2V4jN37/KGQbTp7komXIXyG6YK75NYUPgT6ICce7yAyPSeVTY1Qy
         i8FA==
X-Gm-Message-State: AOAM533+nlNvyGNbrQDH27wD7E+M7qQIvS8kSy9875MclI/jVhU9VleQ
        Hru8e0MTtUWy38JziTmwPQyUBOrEJYw=
X-Google-Smtp-Source: ABdhPJxmmjN99e7flZQNN/wYzTYz3Ija2Zvb3PiDoUHb09bt7Yq0O8q2RMZNfi09dB25zlMvrWL00Q==
X-Received: by 2002:a2e:87d2:: with SMTP id v18mr144983ljj.371.1603333821560;
        Wed, 21 Oct 2020 19:30:21 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.googlemail.com with ESMTPSA id x17sm21425lfc.33.2020.10.21.19.30.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2020 19:30:20 -0700 (PDT)
Subject: Re: [PATCH v4 2/2] PM / devfreq: Add governor attribute flag for
 specifc sysfs nodes
To:     Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Cc:     lukasz.luba@arm.com, enric.balletbo@collabora.com,
        hl@rock-chips.com, thierry.reding@gmail.com, jonathanh@nvidia.com,
        abel.vesa@nxp.com, k.konieczny@samsung.com,
        b.zolnierkie@samsung.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
References: <20201020030407.21047-1-cw00.choi@samsung.com>
 <CGME20201020025045epcas1p4b26b6f23e2896c2d661b2cfa93505e21@epcas1p4.samsung.com>
 <20201020030407.21047-3-cw00.choi@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <bee3ef10-ddec-5ad4-9daa-79d9b01651d9@gmail.com>
Date:   Thu, 22 Oct 2020 05:30:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201020030407.21047-3-cw00.choi@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Chanwoo,

20.10.2020 06:04, Chanwoo Choi пишет:
> @@ -1354,55 +1365,71 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>  	struct devfreq *df = to_devfreq(dev);
>  	int ret;
>  	char str_governor[DEVFREQ_NAME_LEN + 1];
> -	const struct devfreq_governor *governor, *prev_governor;
> +	const struct devfreq_governor *new_governor, *prev_governor;
>  
>  	if (!df->governor)
>  		return -EINVAL;
> +	prev_governor = df->governor;
>  
>  	ret = sscanf(buf, "%" __stringify(DEVFREQ_NAME_LEN) "s", str_governor);
>  	if (ret != 1)
>  		return -EINVAL;
>  
>  	mutex_lock(&devfreq_list_lock);
> -	governor = try_then_request_governor(str_governor);
> -	if (IS_ERR(governor)) {
> -		ret = PTR_ERR(governor);
> +	new_governor = try_then_request_governor(str_governor);
> +	if (IS_ERR(new_governor)) {
> +		ret = PTR_ERR(new_governor);
>  		goto out;
>  	}
> -	if (df->governor == governor) {
> +	if (prev_governor == new_governor) {
>  		ret = 0;
>  		goto out;
> -	} else if (IS_SUPPORTED_FLAG(df->governor->flags, IMMUTABLE)
> -		|| IS_SUPPORTED_FLAG(governor->flags, IMMUTABLE)) {
> +	} else if (IS_SUPPORTED_FLAG(prev_governor->flags, IMMUTABLE)
> +		|| IS_SUPPORTED_FLAG(new_governor->flags, IMMUTABLE)) {
>  		ret = -EINVAL;
>  		goto out;
>  	}
>  
> -	ret = df->governor->event_handler(df, DEVFREQ_GOV_STOP, NULL);
> +	/*
> +	 * Stop the previous governor and remove the specific sysfs files
> +	 * which depend on previous governor.
> +	 */
> +	ret = prev_governor->event_handler(df, DEVFREQ_GOV_STOP, NULL);
>  	if (ret) {
>  		dev_warn(dev, "%s: Governor %s not stopped(%d)\n",
> -			 __func__, df->governor->name, ret);
> +			 __func__, prev_governor->name, ret);
>  		goto out;
>  	}
>  
> -	prev_governor = df->governor;
> -	df->governor = governor;
> -	strncpy(df->governor_name, governor->name, DEVFREQ_NAME_LEN);
> -	ret = df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
> +	remove_sysfs_files(df, prev_governor);
> +
> +	/*
> +	 * Start the new governor and create the specific sysfs files
> +	 * which depend on new governor.
> +	 */
> +	strncpy(df->governor_name, new_governor->name, DEVFREQ_NAME_LEN);
> +	ret = new_governor->event_handler(df, DEVFREQ_GOV_START, NULL);

The "df->governor = new_governor" needs to be set before invocation of
the event_handler(GOV_START) because governors like a
performance-governor need to have the df->governor being set before the
GOV_START callback, otherwise performance governor will use
devfreq->prev_governor->get_target_freq() in devfreq_update_target(),
thus setting a wrong (non-max) freq.

>  	if (ret) {
>  		dev_warn(dev, "%s: Governor %s not started(%d)\n",
> -			 __func__, df->governor->name, ret);
> -		df->governor = prev_governor;
> +			 __func__, new_governor->name, ret);
>  		strncpy(df->governor_name, prev_governor->name,
>  			DEVFREQ_NAME_LEN);
> -		ret = df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);

Same here.
