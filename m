Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62B8C1ADF22
	for <lists+linux-pm@lfdr.de>; Fri, 17 Apr 2020 16:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730922AbgDQOFM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Apr 2020 10:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730865AbgDQOE6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Apr 2020 10:04:58 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21273C061A0C;
        Fri, 17 Apr 2020 07:04:58 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id k21so2174013ljh.2;
        Fri, 17 Apr 2020 07:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MvB7E+fkHBWgxJAx2lFY2q5a2NQT0tGN1gYVdKIfgks=;
        b=Gh5UVTH061Dw7U8EczAHCOJ8b8h8MCrVJ2gX6r0m0HkdPnkma27G30r4eD+/2ORR9Z
         CcsAhwutLzqMFkA+H83jOhF3FEsbTaUQK/ZY+urTo3efKEIAHGZbBjO73oFOWBMY2ZBv
         Qk50KSMfQdcwdCclem4MqzYJ+SLdVNJwlDsy2k6kQC24cEPCCw2qLad3GcJQXEWG9RBD
         t30WY+EYMUKGsAj0wOEKeKjVU7CdgDyXkHKYHto8KaubXzvSgqkteeIW1Zjs/C47T2PV
         M0iXTmbku/V8nbLD2ZO+ZKbD5KljCI3VowxLjlvWEM3u0QUuA5vpHJ2GJRdU8fIvtda7
         5OKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MvB7E+fkHBWgxJAx2lFY2q5a2NQT0tGN1gYVdKIfgks=;
        b=rqFFjQWYR0MqF7lOK8nGqPqR4OX4g5+x51SI4xVKRDgXeqdXArVrgiDuYH9MIysqCz
         2qGeNmMKRxqs1QilCatVExejv4M0LfBXzf3rVNgag7pbLjBMSQEYAf3lUVX/H9IS/9r7
         M6EuAr0Y8UjEOk3sksZU7J+CQomihDsUIZRYoYQbNLMdx50gsxNczPfOce+vzqGM0syc
         ei8lDv8Hwzk1qCx0hxEkSzkhkqTeMS5/cq0P616ItX1pa4UeOCIMF6/jTtTIr5ad6dKG
         pYwqmxhxra1sxp3YJX/tLTQUEgebZlhsQVjxaoditDWAoxnxSthFWUHd7su5F/FCjj/R
         sMKw==
X-Gm-Message-State: AGi0Pua2BxneylezUWzoahIIXWZPh4T7tguvS7UwiIIwy3axlZ9WzPVM
        NNkrLbBQ/pLLik9D2/CHAf1VKtUR
X-Google-Smtp-Source: APiQypLmN2ntcwfQEPno8AODZXXC7nUvrT6i9PGmxYkRjyMWjXCDbqAk7plyEVOWui5/rYOR1fLt0Q==
X-Received: by 2002:a2e:953:: with SMTP id 80mr2269187ljj.276.1587132296192;
        Fri, 17 Apr 2020 07:04:56 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id t19sm17816956lfl.53.2020.04.17.07.04.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2020 07:04:55 -0700 (PDT)
Subject: Re: [PATCH RE-SEND v1] PM / devfreq: Replace strncpy with strscpy
From:   Dmitry Osipenko <digetx@gmail.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200227170854.9949-1-digetx@gmail.com>
Message-ID: <09712864-01a5-e2f9-b55f-e822169d30fc@gmail.com>
Date:   Fri, 17 Apr 2020 17:04:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200227170854.9949-1-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

27.02.2020 20:08, Dmitry Osipenko пишет:
> GCC produces this warning when kernel compiled using `make W=1`:
> 
>   warning: ‘strncpy’ specified bound 16 equals destination size [-Wstringop-truncation]
>   772 |  strncpy(devfreq->governor_name, governor_name, DEVFREQ_NAME_LEN);
> 
> The strncpy doesn't take care of NULL-termination of the destination
> buffer, while the strscpy does.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/devfreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 8494c5f05a73..2011f64bfa3a 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -769,7 +769,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  	devfreq->dev.release = devfreq_dev_release;
>  	INIT_LIST_HEAD(&devfreq->node);
>  	devfreq->profile = profile;
> -	strncpy(devfreq->governor_name, governor_name, DEVFREQ_NAME_LEN);
> +	strscpy(devfreq->governor_name, governor_name, DEVFREQ_NAME_LEN);
>  	devfreq->previous_freq = profile->initial_freq;
>  	devfreq->last_status.current_frequency = profile->initial_freq;
>  	devfreq->data = data;
> 

Hello Chanwoo,

Do you have any objections to this patch?
