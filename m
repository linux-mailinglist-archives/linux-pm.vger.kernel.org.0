Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EECF6332BC5
	for <lists+linux-pm@lfdr.de>; Tue,  9 Mar 2021 17:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbhCIQUk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Mar 2021 11:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbhCIQUZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Mar 2021 11:20:25 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2861EC06174A;
        Tue,  9 Mar 2021 08:20:25 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id kr3-20020a17090b4903b02900c096fc01deso5466649pjb.4;
        Tue, 09 Mar 2021 08:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WgrGh57osqWHsh+n9g0qjzJok3lMbDzItuhcBevpbd4=;
        b=YgRrrgCJ/qusSAHXcTwLZ1vFJR/5R9BL6Q2KG5xloEesaNyaOoabMp4/uwVf8KaMO3
         6NhSZKinB7aBec5HuHQz1h/00uKo4MKYswLcDIrKx4kqmrTQzpEo4t2Jim1QgYlDTwV5
         +NDk1aI1z0+eFxVGKh3n0fcAI5OfbvmKT2IaDT2Vlgd5A1UrPnO9+QrUGCS6SwDcxMYl
         ukzhl9qT0eQIi4iKt7nCeWboSsWL/f0S7gmLOFkUvjo1OfdsDDFaVhk2lWm4N34Y2jHc
         V+qzHEAiMm4NHWwhaqNC7qPEHijL0yowwEI423vT0NO0rO00N/iMFyf6PrKEgAJUUknt
         C22Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WgrGh57osqWHsh+n9g0qjzJok3lMbDzItuhcBevpbd4=;
        b=e8bivAbl60yPuV8xYtX41SLf/glGT59QcvC/bggYJXUAXG5aHLyI72kfeTmLdoTHtv
         z0xQTqEEq6EcKP+ezN2a0p2/C5TbbdySKg+KBEOzRQz9pTPLhlcMuZsUW3/u3QIes3oU
         nRRUZCxEuS9TbAQ7Y0nZX23qrc1V+Q6Tt/ASbLd49zuak9CPLIywVmjAzcErpomXhUL/
         KNX8FUPCpRTERl8vZcHHqm/AMIJGDAR9lbTX1k/HFJLU4da1ZdWuF9B4H/zTRzTjDFse
         ETRY7vMfcqysCe60JIsTZM7AWlXvDKoMdRkFYnr/CPIhtD6kwCphRgd4kn/05LyxAmKH
         WwRA==
X-Gm-Message-State: AOAM533TiCAxWp6FE66BPzr4VjVlo0Z+65P4uTkug3HRwHJVLFhP2Jd7
        cGEz9aVFbBWmtSsmTyumxng=
X-Google-Smtp-Source: ABdhPJwCoIr6XFd4uEWpJCIcqsJ93yGswQ67+USwpdzNTIRbWzvpdzW4nQEc98JhyJMb7/OzbTCGZg==
X-Received: by 2002:a17:90a:cca:: with SMTP id 10mr5377993pjt.103.1615306824658;
        Tue, 09 Mar 2021 08:20:24 -0800 (PST)
Received: from [172.30.1.19] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id w84sm8279705pfc.142.2021.03.09.08.20.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 08:20:24 -0800 (PST)
Subject: Re: [PATCH 08/11] PM / devfreq: check get_dev_status in
 devfreq_update_stats
To:     Dong Aisheng <aisheng.dong@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     dongas86@gmail.com, kernel@pengutronix.de, shawnguo@kernel.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, abel.vesa@nxp.com
References: <1615294733-22761-1-git-send-email-aisheng.dong@nxp.com>
 <1615294733-22761-9-git-send-email-aisheng.dong@nxp.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Message-ID: <0b6ceb75-040f-8e1c-73ea-9d60344b9918@gmail.com>
Date:   Wed, 10 Mar 2021 01:20:12 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1615294733-22761-9-git-send-email-aisheng.dong@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21. 3. 9. 오후 9:58, Dong Aisheng wrote:
> Check .get_dev_status() in devfreq_update_stats in case it's abused
> when a device does not provide it.
> 
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>   drivers/devfreq/governor.h | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
> index 31af6d072a10..67a6dbdd5d23 100644
> --- a/drivers/devfreq/governor.h
> +++ b/drivers/devfreq/governor.h
> @@ -89,6 +89,9 @@ int devfreq_update_target(struct devfreq *devfreq, unsigned long freq);
>   
>   static inline int devfreq_update_stats(struct devfreq *df)
>   {
> +	if (!df->profile->get_dev_status)
> +		return -EINVAL;
> +

I'm considering the following method instead of returning the error
when .get_dev_status is NULL.

	if (!df->profile->get_dev_status) {
		df->last_status.total_time = 0;
		df->last_status.busy_time = 0;
		df->last_status.current_frequency = 0;
		return 0;	
	}	

>   	return df->profile->get_dev_status(df->dev.parent, &df->last_status);
>   }
>   #endif /* _GOVERNOR_H */
> 


-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
