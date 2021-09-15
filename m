Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F21C40CCA8
	for <lists+linux-pm@lfdr.de>; Wed, 15 Sep 2021 20:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhIOSiz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Sep 2021 14:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229466AbhIOSiy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Sep 2021 14:38:54 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFEDC061574;
        Wed, 15 Sep 2021 11:37:35 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id y8so3478721pfa.7;
        Wed, 15 Sep 2021 11:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cV94EzHynqxjz8HFcaX2Gl0eMBtC8KjOsD+tryLOOkU=;
        b=Qi3QTMdec7SQPTswOpe8M8UWEo+ojCn/hpzaJwx0AenrBsm3CB5n7xZY38iFgIog4x
         5IaTMxs68SQC2h028ddJNL10sdifkyjNSIN+VabUMQ9tVghvprofe+tDq06jKmpkumeB
         ImfO5SsQbfh+ymvVkjhAbiSly2ksc6QNedg/fhWButV6jai3fHmQ2Y93EAbvqdV1DIqR
         vgQBq70te9042XRaFfjuv0vX6wMSMhGj7dclZ94dh9KhXXJjfYfcpw5s2ZwX8wJTA3gk
         Ct7NGCMfzIWDi9Mv8ZZRNGaqYrIr8O/IsrPpjYIb8YcUJF6DOh1XQlK057gD8HwM7r5F
         CIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cV94EzHynqxjz8HFcaX2Gl0eMBtC8KjOsD+tryLOOkU=;
        b=Vfqk+5e8p+PyrJgXppJ4PvA80dLbTJItzfhgl7QMzDh2SwjgZ96jRu/qlMPY5sqc3v
         ECyDLazTP2GZ+EeL0Iwt+knNnBDGhLDMfoZ2lQVNQwO8LnflGc0qAJbSJCYL1jKW0SQZ
         6Y5Fovsc9ldsQDy24jAIWikbJeOl/iaE+C329Y1Jmu43Oy8mUkPl3dIbVIiAtX2rNoa+
         AYNndKH9L/GOrVDxmtZanjc8WfpnYiiC04sFbH/Jnw5l4fV6LBLH/Ydkqvindgn0/eF8
         wYdtCKfGBtfY/+uYqFTLCzeRCy9UFiAVN5n57oKWawXQB5DMsmjfEIWeezrlJhVyPQfm
         1I3w==
X-Gm-Message-State: AOAM5337CeXERxCauC8XK0XBxxZSBvAhqOHPV94F14AxX7+L03oRyLux
        GfNI5OOw6FsowoJ4+xhLAddGoVQaW5hCYQ==
X-Google-Smtp-Source: ABdhPJxmgDJz4BtqQ1Vw+9YEdTOg3KxZV1Tg9Wt9YYbwjDlqS6f+WsElvlB+ZWG3uClUyMHuYb0EAw==
X-Received: by 2002:a63:cf44:: with SMTP id b4mr1077978pgj.215.1631731054811;
        Wed, 15 Sep 2021 11:37:34 -0700 (PDT)
Received: from [172.30.1.2] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id j123sm561153pgc.77.2021.09.15.11.37.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 11:37:34 -0700 (PDT)
Subject: Re: [PATCH v1 2/4] PM / devfreq: Add devm_devfreq_add_governor()
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20210912184458.17995-1-digetx@gmail.com>
 <20210912184458.17995-3-digetx@gmail.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Message-ID: <329a691d-010f-ca2a-22ef-929fb4495ce7@gmail.com>
Date:   Thu, 16 Sep 2021 03:37:29 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210912184458.17995-3-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

There is ordering dependency between devfreq device and devfreq
governor. Theoretically, devfreq governor must be released after
released of devfreq device.

devm_* support the release ordering by the sequence of registration
in probe()?

On 21. 9. 13. 오전 3:44, Dmitry Osipenko wrote:
> Add resource-managed variant of devfreq_add_governor().
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>   drivers/devfreq/devfreq.c  | 26 ++++++++++++++++++++++++++
>   drivers/devfreq/governor.h |  3 +++
>   2 files changed, 29 insertions(+)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 85faa7a5c7d1..d3af000ec290 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -1301,6 +1301,32 @@ int devfreq_add_governor(struct devfreq_governor *governor)
>   }
>   EXPORT_SYMBOL(devfreq_add_governor);
>   
> +static void devm_devfreq_remove_governor(void *governor)
> +{
> +	devfreq_remove_governor(governor);
> +}
> +
> +/**
> + * devm_devfreq_add_governor() - Add devfreq governor
> + * @dev:	device which adds devfreq governor
> + * @governor:	the devfreq governor to be added
> + *
> + * This is a resource-managed variant of devfreq_add_governor().
> + */
> +int devm_devfreq_add_governor(struct device *dev,
> +			      struct devfreq_governor *governor)
> +{
> +	int err;
> +
> +	err = devfreq_add_governor(governor);
> +	if (err)
> +		return err;
> +
> +	return devm_add_action_or_reset(dev, devm_devfreq_remove_governor,
> +					governor);
> +}
> +EXPORT_SYMBOL(devm_devfreq_add_governor);
> +
>   /**
>    * devfreq_remove_governor() - Remove devfreq feature from a device.
>    * @governor:	the devfreq governor to be removed
> diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
> index 2d69a0ce6291..0d70a9ad951e 100644
> --- a/drivers/devfreq/governor.h
> +++ b/drivers/devfreq/governor.h
> @@ -94,4 +94,7 @@ static inline int devfreq_update_stats(struct devfreq *df)
>   
>   	return df->profile->get_dev_status(df->dev.parent, &df->last_status);
>   }
> +
> +int devm_devfreq_add_governor(struct device *dev,
> +			      struct devfreq_governor *governor);
>   #endif /* _GOVERNOR_H */
> 


-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
