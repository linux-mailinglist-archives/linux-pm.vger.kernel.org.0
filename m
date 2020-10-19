Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93C172920C8
	for <lists+linux-pm@lfdr.de>; Mon, 19 Oct 2020 02:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgJSA5Z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 18 Oct 2020 20:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbgJSA5Y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 18 Oct 2020 20:57:24 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2DAC061755;
        Sun, 18 Oct 2020 17:57:24 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id c21so10080850ljj.0;
        Sun, 18 Oct 2020 17:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sq/fKrB7mG48ri9jjuKCMbdKq/hUy3mDsrWp2NWD4FI=;
        b=HOu9dnEUMSvBwwEDFflgztbLkdZREqSdWavTEIDtuHSX8s2Hjp1sw/XWojB/TYvdGB
         qqdgEG0WSzQdz+9aKx/hC6bUCA6F7VPhQADm6kkEYjvIR/MaUwfO99i/EPyMfp3zus6e
         41H0kDD90PmflO5C9fqW79xiRLAW3UMespDMv+GCwqTABfx+JcSEGK0cmn9yLzkQ/rdJ
         YqYhYnWTf/dAeUyy98xLE9UZHbZ0QCeAhQexYaJl855imtggi9tYQWImBbvygqB22WGU
         jvgNjRCLZZSoyRHM2ov/3+HenE9WiSDxHEPYjqEZFlYDvpQZph3G+YcuSMakzksMWUdX
         IQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sq/fKrB7mG48ri9jjuKCMbdKq/hUy3mDsrWp2NWD4FI=;
        b=m9Q9g5ifcIkCzkNE/MMBaxbJYn0E2WjvSbeoOuKPPue2HcUiTqUefeWb00sbcDCEbG
         Wlf7vfhE9/6cp5AkTnJ4Q1nk3Az/ZdrTQUYn5UnH1JSN0FcLvB3ECYGvfx7cc2es/h9g
         qP1N7KT8CU941AuZUclC5VRupIpBPQxSA9UOOMyVEhp5m/riZfxEeRxVfP33+63eWkJx
         8yL0JbSYAZjjUdRTeBRyuBpJ8G7imlcRDMxeBzcEH2Ea6LTAV+tlm7gxwhHiYSJHTH9M
         LWrnDFW2Vi9vXqY85jBryW/xrH0JAVwSgQsHtrvvVbVnj+Ghn2eM7easCU0xlrdRhwig
         TsNQ==
X-Gm-Message-State: AOAM532wdOTuBVSawTBxoxBqZL+iXrcQYbYH9mEBCFbW8Yb036wnK+bb
        n1/pvJLYCJYEhi5nMARn5T0=
X-Google-Smtp-Source: ABdhPJyK8mSOtak89RU8lRlRZ78DRh+qQB6CLZw71ATAXOw9lpLzBNtL/IBgKKlGwlOmbsJ7CvYCyA==
X-Received: by 2002:a2e:9847:: with SMTP id e7mr2797266ljj.46.1603069042955;
        Sun, 18 Oct 2020 17:57:22 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.googlemail.com with ESMTPSA id h20sm2990253lfc.264.2020.10.18.17.57.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Oct 2020 17:57:22 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] PM / devfreq: Add governor feature flag
To:     Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Cc:     leonard.crestez@nxp.com, lukasz.luba@arm.com,
        enric.balletbo@collabora.com, hl@rock-chips.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, abel.vesa@nxp.com,
        k.konieczny@samsung.com, b.zolnierkie@samsung.com,
        chanwoo@kernel.org, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com
References: <20201007050703.20759-1-cw00.choi@samsung.com>
 <CGME20201007045340epcas1p4e63955385b1841f44e7a07e2d5d962c4@epcas1p4.samsung.com>
 <20201007050703.20759-2-cw00.choi@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <83b952ab-a25e-8984-8804-1dd990eec835@gmail.com>
Date:   Mon, 19 Oct 2020 03:57:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201007050703.20759-2-cw00.choi@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

07.10.2020 08:07, Chanwoo Choi пишет:
> The devfreq governor is able to have the specific flag as follows
> in order to implement the specific feature. For example, devfreq allows
> user to change the governors on runtime via sysfs interface.
> But, if devfreq device uses 'passive' governor, don't allow user to change
> the governor. For this case, define the DEVFREQ_GOV_FLAT_IMMUTABLE

s/DEVFREQ_GOV_FLAT/DEVFREQ_GOV_FLAG/

...
>  /**
>   * struct devfreq_governor - Devfreq policy governor
>   * @node:		list node - contains registered devfreq governors
>   * @name:		Governor's name
> - * @immutable:		Immutable flag for governor. If the value is 1,
> - *			this governor is never changeable to other governor.
> - * @interrupt_driven:	Devfreq core won't schedule polling work for this
> - *			governor if value is set to 1.
> + * @flag:		Governor's feature flag
>   * @get_target_freq:	Returns desired operating frequency for the device.
>   *			Basically, get_target_freq will run
>   *			devfreq_dev_profile.get_dev_status() to get the
> @@ -50,8 +57,7 @@ struct devfreq_governor {
>  	struct list_head node;
>  
>  	const char name[DEVFREQ_NAME_LEN];
> -	const unsigned int immutable;
> -	const unsigned int interrupt_driven;
> +	const u64 flag;
A plural form of flag(s) is more common, IMO.

It's also possible to use a single bit:1 for the struct members. Thus,
could you please explain what are the benefits of the "flag"?
