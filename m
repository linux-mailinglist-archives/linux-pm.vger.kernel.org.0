Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D25C3460BE
	for <lists+linux-pm@lfdr.de>; Tue, 23 Mar 2021 15:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbhCWN72 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Mar 2021 09:59:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39564 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232109AbhCWN7N (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Mar 2021 09:59:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616507952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vT1yNxmkmcZVpSr3XtHB0s0CJlrtl85HnVXkoFwDxhM=;
        b=CGZDHgXfcM9ZRnNOpE7ACxjrcpQ7a9Vj87CJ555HDfGsnCq3S4WwCdwxj7Aj9RaiF12HDw
        dWmIvI0jy8lzkpW/ff1pV6wLARgWAY7u3TorM6YRKxv73abZ91EUqjsgltC4rOKy9+VU70
        +tVwglk7r/TVbolYSdk7IZURhsySjkw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-5Zhw3Jh2NGuwmRU0tBPMMQ-1; Tue, 23 Mar 2021 09:59:09 -0400
X-MC-Unique: 5Zhw3Jh2NGuwmRU0tBPMMQ-1
Received: by mail-ed1-f71.google.com with SMTP id h2so992522edw.10
        for <linux-pm@vger.kernel.org>; Tue, 23 Mar 2021 06:59:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vT1yNxmkmcZVpSr3XtHB0s0CJlrtl85HnVXkoFwDxhM=;
        b=uRhefjdzAIMOt4qjDgOv4Yz2BlM5jajDZHmlaBbuMGcPh/cNmYyb7ZLzi88rDiF91i
         WZA4O4uS9BCxh2fKPqEsqvngEqfHXPYPRF7ZiE/FOa+9zvBREotivih0zYE1QV3Ae7uk
         Jv/yEw9pUdv2DTbQpF+nwGVtiHxZx4Cp3xpkmcHYUqf5VUox7Sc6rqYad6VSsDi2tXBX
         CsjGXvbwn6CU+jOqGnMLQm6z6o2EzLEUEWzXOKFyxrDxPX11H+mU1XoiCKBpIfRg6cih
         O2flg2M5Wl36U4MdgQOS1LLmBb+frxkdvKcWLKcdlFrFXRgSc+w5fKHZewEdWDZLbjnf
         WgsA==
X-Gm-Message-State: AOAM530aASFPWmjmVuieulZkdbsgCf5xypE2EhypG4gyUS3khEk20YK9
        RsE8FEfq/KCMoKi/fvDQOeHKt59bql5Hddt6SSovPOjgRvWLont1QtkHcMmbqALkDGK4hOEcdgk
        caVnciMr/AHuClWV2R88=
X-Received: by 2002:a17:906:a86:: with SMTP id y6mr5238057ejf.354.1616507947879;
        Tue, 23 Mar 2021 06:59:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx5e5Lv8g8gT+AoapzTbrPKEj7SomvuFErCKCzbWGS+YzN+9oV03Ltn6UZHLigD5WR0I5Mibw==
X-Received: by 2002:a17:906:a86:: with SMTP id y6mr5238050ejf.354.1616507947718;
        Tue, 23 Mar 2021 06:59:07 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id u13sm11189851ejy.31.2021.03.23.06.59.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 06:59:07 -0700 (PDT)
Subject: Re: [PATCH v3 1/8] workqueue: Add resource managed version of delayed
 work init
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Gross <mgross@linux.intel.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-hwmon@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-watchdog@vger.kernel.org
References: <cover.1616506559.git.matti.vaittinen@fi.rohmeurope.com>
 <51769ea4668198deb798fe47fcfb5f5288d61586.1616506559.git.matti.vaittinen@fi.rohmeurope.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <90d2d9ab-f668-d819-4ca3-d893961ea19a@redhat.com>
Date:   Tue, 23 Mar 2021 14:59:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <51769ea4668198deb798fe47fcfb5f5288d61586.1616506559.git.matti.vaittinen@fi.rohmeurope.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 3/23/21 2:56 PM, Matti Vaittinen wrote:
> A few drivers which need a delayed work-queue must cancel work at driver
> detach. Some of those implement remove() solely for this purpose. Help
> drivers to avoid unnecessary remove and error-branch implementation by
> adding managed verision of delayed work initialization. This will also
> help drivers to avoid mixing manual and devm based unwinding when other
> resources are handled by devm.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
> Changelog from RFCv2:
>  - RFC dropped. No functional changes.
> 
>  include/linux/devm-helpers.h | 53 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 include/linux/devm-helpers.h
> 
> diff --git a/include/linux/devm-helpers.h b/include/linux/devm-helpers.h
> new file mode 100644
> index 000000000000..f64e0c9f3763
> --- /dev/null
> +++ b/include/linux/devm-helpers.h
> @@ -0,0 +1,53 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef __LINUX_DEVM_HELPERS_H
> +#define __LINUX_DEVM_HELPERS_H
> +
> +/*
> + * Functions which do automatically cancel operations or release resources upon
> + * driver detach.
> + *
> + * These should be helpful to avoid mixing the manual and devm-based resource
> + * management which can be source of annoying, rarely occurring,
> + * hard-to-reproduce bugs.
> + *
> + * Please take into account that devm based cancellation may be performed some
> + * time after the remove() is ran.
> + *
> + * Thus mixing devm and manual resource management can easily cause problems
> + * when unwinding operations with dependencies. IRQ scheduling a work in a queue
> + * is typical example where IRQs are often devm-managed and WQs are manually
> + * cleaned at remove(). If IRQs are not manually freed at remove() (and this is
> + * often the case when we use devm for IRQs) we have a period of time after
> + * remove() - and before devm managed IRQs are freed - where new IRQ may fire
> + * and schedule a work item which won't be cancelled because remove() was
> + * already ran.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/workqueue.h>
> +
> +static inline void devm_delayed_work_drop(void *res)
> +{
> +	cancel_delayed_work_sync(res);
> +}
> +
> +/**
> + * devm_delayed_work_autocancel - Resource-managed work allocation
> + * @dev: Device which lifetime work is bound to
> + * @pdata: work to be cancelled when driver is detached
> + *
> + * Initialize work which is automatically cancelled when driver is detached.
> + * A few drivers need delayed work which must be cancelled before driver
> + * is detached to avoid accessing removed resources.
> + * devm_delayed_work_autocancel() can be used to omit the explicit
> + * cancelleation when driver is detached.
> + */
> +static inline int devm_delayed_work_autocancel(struct device *dev,
> +					       struct delayed_work *w,
> +					       work_func_t worker)
> +{
> +	INIT_DELAYED_WORK(w, worker);
> +	return devm_add_action(dev, devm_delayed_work_drop, w);
> +}
> +
> +#endif
> 

