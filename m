Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D14D3329EA
	for <lists+linux-pm@lfdr.de>; Tue,  9 Mar 2021 16:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhCIPOE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Mar 2021 10:14:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbhCIPNv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Mar 2021 10:13:51 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54964C06174A;
        Tue,  9 Mar 2021 07:13:51 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id f2-20020a17090a4a82b02900c67bf8dc69so5170339pjh.1;
        Tue, 09 Mar 2021 07:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PPov/9T98riblII7kJqoM73Pg7SwKGZvj0dSrsyCgNA=;
        b=rZy+G2gcu8aaRbU2kxotS+wR4LAO8OMEhTpsbGb/8XgVl+OcKFWYCnJ41GeAGFHtvl
         0trMIadJ4616AWTpOwJ46jP8YVHear5p4z08D4cNg148CCS3eCU4h1n5kLhgMGQTPT9c
         1rDaMXZJS3pg5RqDFCUXr9Ev3awDNlSdJSLhGD6EmPkYZElQ6VGOQhteK7u3RN3OhVRz
         Wy//9/YT57h0LVRoHOJ9LAVobBJZxDLWw9/ATzEhrG6FVSzvs6sIIZ4+2DECRD78mvIP
         IMy8M8OhvuTqYXYrxuY1uvFSXuca8gYzVS5GF7lK6O3o2TvaxX322yBJUWzp7Ug/g7RX
         WBeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PPov/9T98riblII7kJqoM73Pg7SwKGZvj0dSrsyCgNA=;
        b=MRiwSzhjrvKGJa5Eh/11F3GmhFf+IAUH2VYgE4H12DXscNqNbtEQelceeBn3yyVjLV
         /2C+P9HEDqZQq5bbnRd0R1hXVCo5j9gyYRD99fekAO3qfz6ytoI24onjaJIW/IkBEK5K
         AeTAfhKuCVuDSGJIRVF+/p9dVJvB4+3aLdbkSGSE3yK6taof0A0Fj6kL0pMwrClBJ7Fv
         fSLIHj8oLZIZtxEeEdWwSHAHPExj5thgWksQk/mrKrARZvN41DcEgoPnpWb5dXYDCW3Q
         5j8SQlN0z800xPv5H0aC4uFoR1enXMBIq5/4wTLq1OXkUMhAN6tVk+rXrhhffgx7f6cm
         RQfg==
X-Gm-Message-State: AOAM533SSoziO0IkBE9Oqcs9UWor5OmajgIPWRKJWtB+o/FRuAIVm3ZX
        4hJP04W6rKWsPJja4qgAjUY=
X-Google-Smtp-Source: ABdhPJzyeVXEFUczPyje2QwFl6Pavkud5/xilELjcf1oM5svOGek7V69oOqUW4rmrjwcqJ+/Bo1pKg==
X-Received: by 2002:a17:902:6b83:b029:e6:3ebe:55e3 with SMTP id p3-20020a1709026b83b02900e63ebe55e3mr4179986plk.5.1615302830856;
        Tue, 09 Mar 2021 07:13:50 -0800 (PST)
Received: from [172.30.1.19] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id o3sm13156818pgm.60.2021.03.09.07.13.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 07:13:50 -0800 (PST)
Subject: Re: [PATCH 03/11] PM / devfreq: fix the wrong set_freq path for
 userspace governor
To:     Dong Aisheng <aisheng.dong@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     dongas86@gmail.com, kernel@pengutronix.de, shawnguo@kernel.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, abel.vesa@nxp.com
References: <1615294733-22761-1-git-send-email-aisheng.dong@nxp.com>
 <1615294733-22761-4-git-send-email-aisheng.dong@nxp.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Message-ID: <717a9e7c-1b3f-2ea6-7471-fa554e47b71a@gmail.com>
Date:   Wed, 10 Mar 2021 00:13:44 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1615294733-22761-4-git-send-email-aisheng.dong@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21. 3. 9. 오후 9:58, Dong Aisheng wrote:
> Fix the wrong set_freq path for userspace governor.
> 
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>   drivers/devfreq/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index 00704efe6398..20373a893b44 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -62,7 +62,7 @@ config DEVFREQ_GOV_USERSPACE
>   	help
>   	  Sets the frequency at the user specified one.
>   	  This governor returns the user configured frequency if there
> -	  has been an input to /sys/devices/.../power/devfreq_set_freq.
> +	  has been an input to /sys/devices/.../userspace/set_freq.
>   	  Otherwise, the governor does not change the frequency
>   	  given at the initialization.
>   
> 

Looks good. But this patch just fix the information in Kconfig
instead of fixing the wrong operation. To clarify the commit message,
I'll change the patch title and commit message as following:

     PM / devfreq: Fix the wrong set_freq path for userspace governor in 
Kconfig

     Fix the wrong set_freq path for userspace governor in Kconfig.

     Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>


Applied it. But, if you have any other objection, please let me know.


-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
