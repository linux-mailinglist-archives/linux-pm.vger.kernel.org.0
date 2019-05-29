Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF082E0D0
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2019 17:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfE2PP2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 May 2019 11:15:28 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34560 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfE2PP1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 May 2019 11:15:27 -0400
Received: by mail-pg1-f196.google.com with SMTP id h2so102196pgg.1
        for <linux-pm@vger.kernel.org>; Wed, 29 May 2019 08:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YD7/cBxw7LRkLxwmM6m3DiNi5eK8EJjOnQqrabni5wk=;
        b=efpl+pqxTpk6uynjucmLrNO3wU6NZdCAYsaH9wfZPcLJVOOiq+ayHuE6J54vBfMiCo
         qqa7VcvNl+1mvkcvR+Aq85iYmvLzpZZbfIb9S0mXCE/T4MI+QefqusFehJSCL30Pu3TY
         dIJ1Jlju3gBiDnE+mL9ITtuc0p4pbqWXS/5JDBx1VCLk3pEIq7i7ZH1ecA8sVuQKyUhE
         Qcs9WaGq5K+6riaAjsIvtUlyn9fIT/ounEOskphzeWrv/w+MsQRIDGQiLUMyIwca/YqH
         mie0L5OkbLbDEeI6oi5sONcPQoqYi/1em161Kn5UHWUghi48tVjHxx3i11zLAB/IqRiO
         291Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YD7/cBxw7LRkLxwmM6m3DiNi5eK8EJjOnQqrabni5wk=;
        b=SR98SDPJN1Ja7NUzBb7WeEzVSL5uLejf5tw1Hd9Q+ZLATpgFgl5Sr2rA5cFEenZMyZ
         QSYGT4R2BVDcUYmxUxq9QOcofrZYTyH0AlLjovaZIHXyPFBwHwrWvX+UKF2vhgOfJNns
         xUWF3K/8fdtmZEDS3oECN57trcBS560qv9TLo19AyHmai8xkCZPtcdp8e+oQH28u+53c
         yYpgQQEBwQjuDF4JV5i9BFGA/tz/5ViV02qkKseRK0WViCMwuXXxFoevlGDXDnIgZlv5
         nNP5+u1WBjMqC6KjCiSOYNCyqBaYrdnx10aVrQZlVWINZK2U9nOxMZ1he2Ra1bW1k0KM
         jKwQ==
X-Gm-Message-State: APjAAAUrlYxbxNPXuF8Xe7rGbElomy8uKBnLhoFcBlsSJ2tCAuAsoYn6
        Uga8H9CoX6jc6QNKv3zVJGM=
X-Google-Smtp-Source: APXvYqxTAteT8bJiOMJQ3vOkzrcMeUZij7aykBblSbtFWouj2KzpS4lZAaa3owSARvcjlUPUbykn+w==
X-Received: by 2002:a63:6e48:: with SMTP id j69mr22160682pgc.34.1559142922147;
        Wed, 29 May 2019 08:15:22 -0700 (PDT)
Received: from localhost ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id y12sm4486572pgi.10.2019.05.29.08.15.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 08:15:21 -0700 (PDT)
Date:   Thu, 30 May 2019 00:15:18 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     linux-nvme@lists.infradead.org, linux-pm@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Kenneth Heitke <kenneth.heitke@intel.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH v3 2/3] nvme: add thermal zone devices
Message-ID: <20190529151517.GC28274@minwooim-desktop>
References: <1558888143-5121-1-git-send-email-akinobu.mita@gmail.com>
 <1558888143-5121-3-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1558888143-5121-3-git-send-email-akinobu.mita@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> +/**
> + * nvme_thermal_zones_register() - register nvme thermal zone devices
> + * @ctrl: controller instance
> + *
> + * This function creates up to nine thermal zone devices for all implemented
> + * temperature sensors including the composite temperature.
> + * Each thermal zone device provides a single trip point temperature that is
> + * associated with an over temperature threshold.
> + */
> +static int nvme_thermal_zones_register(struct nvme_ctrl *ctrl)
> +{
> +	struct nvme_smart_log *log;
> +	int ret;
> +	int i;
> +
> +	log = kzalloc(sizeof(*log), GFP_KERNEL);
> +	if (!log)
> +		return 0; /* non-fatal error */

Do we need to print something like warning here? If kzalloc() fails, it
would be good to be distinguished between the nvme failure and internal
failure like this.

> +
> +	ret = nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_SMART, 0,
> +			   log, sizeof(*log), 0);
> +	if (ret) {
> +		dev_err(ctrl->device, "Failed to get SMART log: %d\n", ret);
> +		/* If the device provided a response, then it's non-fatal */
> +		if (ret > 0)
> +			ret = 0;

It seems like that nvme_init_identify() is just check the internal error
which is in negative value now as you have posted.  Why don't we just
return the value of "ret" itself without updating it to 0 ?

> +		goto free_log;
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(ctrl->tzdev); i++) {
> +		struct thermal_zone_device *tzdev;
> +		int temp;
> +
> +		if (i)
> +			temp = le16_to_cpu(log->temp_sensor[i - 1]);
> +		else
> +			temp = get_unaligned_le16(log->temperature);
> +
> +		/*
> +		 * All implemented temperature sensors report a non-zero value
> +		 * in temperature sensor fields in the smart log page.
> +		 */
> +		if (!temp)
> +			continue;
> +		if (ctrl->tzdev[i])
> +			continue;
> +
> +		tzdev = nvme_thermal_zone_register(ctrl, i);
> +		if (!IS_ERR(tzdev))
> +			ctrl->tzdev[i] = tzdev;
> +	}
> +
> +free_log:
> +	kfree(log);
> +
> +	return ret;
> +}
> +
> +/**
> + * nvme_thermal_zones_unregister() - unregister nvme thermal zone devices
> + * @ctrl: controller instance
> + *
> + * This function removes the registered thermal zone devices and symlinks.
> + */
> +static void nvme_thermal_zones_unregister(struct nvme_ctrl *ctrl)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(ctrl->tzdev); i++) {
> +		struct thermal_zone_device *tzdev = ctrl->tzdev[i];
> +		char name[20];

Simple query here :)

If we are not going to allow the name of link exceed the length of its
own device name like nvmeX_tempY, then can we THERMAL_NAME_LENGTH macro
here?  If the name of link is not exactly about the device name itself,
then it's fine.  What do you think about it ?
