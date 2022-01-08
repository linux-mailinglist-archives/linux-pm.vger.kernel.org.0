Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2EF348845B
	for <lists+linux-pm@lfdr.de>; Sat,  8 Jan 2022 16:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbiAHP6s (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 8 Jan 2022 10:58:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:27287 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229521AbiAHP6s (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 8 Jan 2022 10:58:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641657527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vU57yWko8FS2IXRvev408Ys04n75VGGdrg6NxAdaDtE=;
        b=PEXceYtwqr3htkSe9MNxwvlyiAQvZI8K3XXU84CkSMpY+wTdT12KwLf7A0lEnnFK0aKZ/H
        yzs6tyET3XaxV4XAHmAuENwO94BThP7qtUl0pzutIotvcVPRfa/sW1RhNEsptOs/pjYSEA
        tXvJsyX9AFRmMVkQaZOkJOvqUpxzePY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-133-4ebJltPKNiKtEI27kHZpLA-1; Sat, 08 Jan 2022 10:58:46 -0500
X-MC-Unique: 4ebJltPKNiKtEI27kHZpLA-1
Received: by mail-ed1-f69.google.com with SMTP id z10-20020a05640235ca00b003f8efab3342so6967773edc.2
        for <linux-pm@vger.kernel.org>; Sat, 08 Jan 2022 07:58:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vU57yWko8FS2IXRvev408Ys04n75VGGdrg6NxAdaDtE=;
        b=BMNmxQV5ealX+4oUPwQsVSSjhNHGs1KxTVKk8qMzm+je5XmBPu66QDPJorrfwmE81a
         /bvY099HmnVyY0MXx4BmL3pE5b2biscDfP4q7RNvFZ3fTpW5dPxJSMRMmzu8n46Kinwo
         NPcRGvnFthhYMf0amiksr3VS1Fxutr+Fr/IAkCPoJjPwR33Inn4eiMDCpKM0XpeZwtAW
         Vi800pLm8lhhSzwZXCGD5F6mweugOZpCzBxPDTytLy5SZ2I4jkQu75a/3aw4uLr2+vbM
         W/5MjCCvv+d3LyVz5YzLsIotGgXmIfm5FcV5Xht2sK29Tv1wf8TDIUzHs27isOOa0mnN
         PQ8w==
X-Gm-Message-State: AOAM533XXQJDn7j1lHCtvTSt5E+0pOe6BIw22PCzI9267W8ppRqCx3vV
        ouj8oGEST8OYa3ABEbuL4I47IAyEqylDIGbRr9REuIstTB2BGqoxR7MGCYooTM2R+HWHHNUeOsL
        siUmWxPAnuLnIRuu6B3k=
X-Received: by 2002:a17:907:7b88:: with SMTP id ne8mr52690235ejc.39.1641657524144;
        Sat, 08 Jan 2022 07:58:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwxsDi88gWoz/yFn06znH+GlQCed5mHhzzbuFm0oPCmY5DmkRskm4o2cKqyiJpOlrxdATjS+A==
X-Received: by 2002:a17:907:7b88:: with SMTP id ne8mr52690232ejc.39.1641657523992;
        Sat, 08 Jan 2022 07:58:43 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id x17sm857217edv.69.2022.01.08.07.58.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Jan 2022 07:58:43 -0800 (PST)
Message-ID: <442f838d-5143-e272-9679-5bfaa9ac7b6a@redhat.com>
Date:   Sat, 8 Jan 2022 16:58:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] power: supply: Provide stubs for charge_behaviour helpers
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        Sebastian Reichel <sre@kernel.org>
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Thomas Koch <linrunner@gmx.net>,
        =?UTF-8?Q?Nicol=c3=b2_Piazzalunga?= <nicolopiazzalunga@gmail.com>,
        linux-pm@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <487dd7a3-8f29-de9a-2612-65fe895e676f@redhat.com>
 <20220108153158.189489-1-linux@weissschuh.net>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220108153158.189489-1-linux@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 1/8/22 16:31, Thomas Weißschuh wrote:
> When CONFIG_SYSFS is not enabled provide stubs for the helper functions
> to not break their callers.
> 
> Fixes: 539b9c94ac83 ("power: supply: add helpers for charge_behaviour sysfs")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans


> ---
>  include/linux/power_supply.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index d92de670d6a7..e218041cc000 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -723,6 +723,21 @@ ssize_t power_supply_charge_behaviour_show(struct device *dev,
>  					   char *buf);
>  
>  int power_supply_charge_behaviour_parse(unsigned int available_behaviours, const char *buf);
> +#else
> +static inline
> +ssize_t power_supply_charge_behaviour_show(struct device *dev,
> +					   unsigned int available_behaviours,
> +					   enum power_supply_charge_behaviour behaviour,
> +					   char *buf)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int power_supply_charge_behaviour_parse(unsigned int available_behaviours,
> +						      const char *buf)
> +{
> +	return -EOPNOTSUPP;
> +}
>  #endif
>  
>  #endif /* __LINUX_POWER_SUPPLY_H__ */
> 
> base-commit: b8170452cd5121b11a5726e3ea8dbdfc2d74e771
> 

