Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEF36332991
	for <lists+linux-pm@lfdr.de>; Tue,  9 Mar 2021 16:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbhCIPCt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Mar 2021 10:02:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbhCIPCY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Mar 2021 10:02:24 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEEEC06174A;
        Tue,  9 Mar 2021 07:02:24 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id t26so8936301pgv.3;
        Tue, 09 Mar 2021 07:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qwojpGqH1mYXH3RBXLlIpKaJqGztkkGelysn19yz+W0=;
        b=EpNlX9oomJ4yB0MFbGVhvXl1DA+S3t4PZXeIJQU8mlerXSvvcgzpHtwIbukjxa2UQx
         dDO6bIWHpMTp2IpiiMY1PkskPhpXuy9mf4rL2l5uwMlEIqHio8xK2bl029hGFRAhUH6H
         HVASmZ70p784VtF9/mKd2MYE1+SvRWAFRmKuEiiJKrNvpYFowJCef8eYAbuV1xeH9Ak9
         bb2NRss/9NClkVMixLvBCjO9ZBu6HuCnN455Wr9vAIem4MlVN/xQFzAxL9a09IMkYzml
         QLrOoBvUnWpPQtbFLhA7nvhhL3F41sAuhfSLJSQlL6CLZnWnpfJUnS4pRD9IDBYAk7ss
         j4cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qwojpGqH1mYXH3RBXLlIpKaJqGztkkGelysn19yz+W0=;
        b=RjJZoI4rn+agbWvyZPuSsL66lqwg6m8B1XE1hrDm1yPFUF2YLi96qt6DTxJI15jEEa
         162l5xcSdH8SV34uwFQu6JCS4y9v/RVi4pkL1XpquRAKZxMumV1UeW+g9xCv3lNbZ4rs
         ifQN5JMcszCbwoj1O9YvYYtHkiGHePLdpLPo0wbwrLfB4T3rhAJTS0XYArLPSNc4phY5
         Z42kRtNU49l/wx/G4io3//VWShHxxjcWjmuTSwh66s1HOuTznWx96HlRhbtpuwIUBgAv
         GOpAeVFafm97DUPKIXyc5IeTsWxvovjcsWOAb7xKwSwaXWrJk1WSegFj7nAE13Yjv550
         RVhg==
X-Gm-Message-State: AOAM532Tvl2hE0JtXf1Bl/CVODvfA9A2ZPtz4hTDtsiPh48rTnTc4kLz
        qhL3mdG0d9t9h1ZUWi90mko=
X-Google-Smtp-Source: ABdhPJwZal/julGImampUwynUA0bXzGBPfS1KJrWbKivC0UAyI4Pw9jUORQ0DdW1IT8xanUghezcnA==
X-Received: by 2002:a63:b60b:: with SMTP id j11mr16786499pgf.19.1615302143537;
        Tue, 09 Mar 2021 07:02:23 -0800 (PST)
Received: from [172.30.1.19] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id g72sm6304139pfb.189.2021.03.09.07.02.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 07:02:22 -0800 (PST)
Subject: Re: [PATCH 02/11] PM / devfreq: remove the invalid description for
 get_target_freq
To:     Dong Aisheng <aisheng.dong@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     dongas86@gmail.com, kernel@pengutronix.de, shawnguo@kernel.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, abel.vesa@nxp.com
References: <1615294733-22761-1-git-send-email-aisheng.dong@nxp.com>
 <1615294733-22761-3-git-send-email-aisheng.dong@nxp.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Message-ID: <c5f27c46-f1a0-cd19-3bec-3dd8800b2cae@gmail.com>
Date:   Wed, 10 Mar 2021 00:02:18 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1615294733-22761-3-git-send-email-aisheng.dong@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21. 3. 9. 오후 9:58, Dong Aisheng wrote:
> First of all, no_central_polling was removed since
> commit 7e6fdd4bad03 ("PM / devfreq: Core updates to support devices
> which can idle")
> Secondly, get_target_freq() is not only called only with update_devfreq()
> notified by OPP now, but also min/max freq qos notifier.
> 
> So remove this invalid description now to avoid confusing.
> 
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>   drivers/devfreq/governor.h | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
> index 70f44b3ca42e..5cee3f64fe2b 100644
> --- a/drivers/devfreq/governor.h
> +++ b/drivers/devfreq/governor.h
> @@ -57,8 +57,6 @@
>    *			Basically, get_target_freq will run
>    *			devfreq_dev_profile.get_dev_status() to get the
>    *			status of the device (load = busy_time / total_time).
> - *			If no_central_polling is set, this callback is called
> - *			only with update_devfreq() notified by OPP.
>    * @event_handler:      Callback for devfreq core framework to notify events
>    *                      to governors. Events include per device governor
>    *                      init and exit, opp changes out of devfreq, suspend
> 

As I replied from patch1, I recommend that squash it with patch1.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
