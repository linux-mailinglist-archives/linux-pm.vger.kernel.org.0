Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA90534AFF2
	for <lists+linux-pm@lfdr.de>; Fri, 26 Mar 2021 21:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhCZUNt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Mar 2021 16:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbhCZUNQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Mar 2021 16:13:16 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEE9C0613AA
        for <linux-pm@vger.kernel.org>; Fri, 26 Mar 2021 13:13:15 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id c17so6044221ilj.7
        for <linux-pm@vger.kernel.org>; Fri, 26 Mar 2021 13:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WVMG+7OiXIZ+Tm7880JAi7R4ykpWVADSbHltba1Tmtw=;
        b=PToeyhk756IYZ6A8qqmUKdWRLxuiMuBiC8vnreFD06Ls7ehqeoJXU9pdvob9HcY2bQ
         BDWOOnzVVxyPOxYwVjpS0FGW5OsTJ1EgnjhPOPpcHJ6PBFvvobkCewLruQQMRwGGEOiL
         W5fDvsaNg6YDst25ZRwfcBSRLd+uvym0snuOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WVMG+7OiXIZ+Tm7880JAi7R4ykpWVADSbHltba1Tmtw=;
        b=jzO33Bmh6C0q6IbGLBGDJA9xlUEeLpE2+L0BIGpd9QPyy8NU34zzcSM4/J1kcK03n8
         uT05xDE0RVPTcMwVH7S6xSgJiX1czEF2WzKFCcBpTlTj3fCFfUTDY9pVvOUoAv+yf8Ia
         tNf+1/UFh95Mj0H+4C/pT09BJbzQ8tG/jRhdMKw4brfXigzK21eylHJIfWFYSLOhtI7B
         KtJk0KhpmCAbTVPZzDZLxZWbUT0L4q8e4IToAXH2Pnr41CFA7UNk4PrDwV6T+cj+NVUZ
         JYh4wOjFwcBk92JPxgT5ntks+NjcXRRN5sj2pKGWZcSRuuEq+/vxWVPUMs4fe4VMbSpk
         9SgQ==
X-Gm-Message-State: AOAM533DfouSQV4x55sMnpFWhx/vgsBOjQIJE6iTfE757VGUTWBv/DbS
        0iecN44SwL4j9hLzK9QEUlBCWA==
X-Google-Smtp-Source: ABdhPJwIDes6amG0J/cAf8yoUYe0o8MHlYApTDoSJi5e5BMogPc/YMrs7/psuQmwh+I1XkIdNR5kKg==
X-Received: by 2002:a92:902:: with SMTP id y2mr2748928ilg.98.1616789594655;
        Fri, 26 Mar 2021 13:13:14 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id d2sm4771243ilm.7.2021.03.26.13.13.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Mar 2021 13:13:13 -0700 (PDT)
Subject: Re: [PATCH 1/2] cpupower: fix amd cpu (family < 0x17) active state
 issue
To:     xufuhai <xufuhai1992@gmail.com>, linux@dominikbrodowski.net,
        sherry.hurwitz@amd.com, trenn@suse.com, linux-pm@vger.kernel.org
Cc:     lishujin@kuaishou.com, Shuah Khan <skhan@linuxfoundation.org>
References: <35ab0d0a-f9ce-b4d7-cd85-3cd8a8638ab6@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <6b87cf2f-cb58-735f-49ac-f51b83b71306@linuxfoundation.org>
Date:   Fri, 26 Mar 2021 14:13:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <35ab0d0a-f9ce-b4d7-cd85-3cd8a8638ab6@gmail.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 3/24/21 4:27 AM, xufuhai wrote:
> From: xufuhai <xufuhai@kuaishou.com>
> 
> For the old  AMD processor (family < 0x17), cpupower will call the
> amd_pci_get_num_boost_states function, but for the non-root user
> pci_read_byte function (implementation comes from the psutil library),
> val will be set to 0xff, indicating that there is no read function
> callback. At this time, the original logic will set the cpupower turbo
> active state to yes. This is an obvious issue~
> 

Please run get_maintainer.pl and send patch maintainers
and others suggested by the tool. I don't see this in my
Inbox for me to review/accept and send it to pm maintainer.

Hmm. I am seeing on my AMD

as non-root
current CPU frequency: Unable to call hardware

as root
current CPU frequency: 3.60 GHz (asserted by call to hardware)

Are you sure this change is necessary?

Please give me more information on this fix.


> Reproduce procedure:
> 	cpupower frequency-info
> 
> Signed-off-by: xufuhai <xufuhai@kuaishou.com>
> Signed-off-by: chenguanqiao <chenguanqiao@kuaishou.com>
> Signed-off-by: lishujin <lishujin@kuaishou.com>
> ---
>   tools/power/cpupower/utils/helpers/amd.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/tools/power/cpupower/utils/helpers/amd.c b/tools/power/cpupower/utils/helpers/amd.c
> index 97f2c857048e..6f9504906afa 100644
> --- a/tools/power/cpupower/utils/helpers/amd.c
> +++ b/tools/power/cpupower/utils/helpers/amd.c
> @@ -137,6 +137,13 @@ int amd_pci_get_num_boost_states(int *active, int *states)
>   		return -ENODEV;
>   
>   	val = pci_read_byte(device, 0x15c);
> +
> +	/* If val is 0xff, meaning has no permisson to

Typo: permisson. Reads better as "0xff indicates user
doesn't have permission to read boot states"

> +	 * get the boost states, return -1
> +	 */
> +	if (val == 0xff)
> +		return -1;
> +
>   	if (val & 3)
>   		*active = 1;
>   	else
> 

thanks,
-- Shuah
