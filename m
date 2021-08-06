Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 816DF3E222D
	for <lists+linux-pm@lfdr.de>; Fri,  6 Aug 2021 05:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbhHFDaP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Aug 2021 23:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbhHFDaP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Aug 2021 23:30:15 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99938C061798;
        Thu,  5 Aug 2021 20:29:57 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id mt6so14004607pjb.1;
        Thu, 05 Aug 2021 20:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=fS+XTOKPP/A+4Ea3Vfvk2lusfIUrsBa+uJZOXKxOTBs=;
        b=ONTPD9LmSno01aJOy1CjhKkYK3doqsHNZJrZJypUlYU/TnSa8zfSp1hgMhRtYwTIlq
         ffoizk7QD3R1/qUjFO1u3vDNlJFWDvgrSfY+yBrHMxgy2pPR/+1lfsCgB47FAIEBq/Z0
         u0cijgJtcZG2L58LElWv5Dw+zz8MMtvFAIt2eur6osbqkGOV07jUP6c7sa23yruL/MP/
         PvvaISEbIJcwiOgZQEj+pCdlMpY598g9v7h+lpjoSRYbDQtzsfOcsDxuu+6bMqCRGOwX
         4iAzKeGCSrchlHPqDnpyZQ7NtexcrLUUPSU7XWisGSrph402NGg7B3B2OsVaIF9xGicX
         CEtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=fS+XTOKPP/A+4Ea3Vfvk2lusfIUrsBa+uJZOXKxOTBs=;
        b=Yx4ex47yUmX2BnWX35pIBkLIws/51OKl5zUntq6BPVJf+16BcFOcxG4/CCxsZE1QkY
         9gnF3pjTTlR1M6zXI7M+hTri+oLG4Hjmn6mQAYg53JCz8cGm9Nh/iJwNHSkI9HMUmgD3
         lGn74w2MH1l9uUXd5pisTVVm27NmQUSGId5Q7ekrpn5rhkCBThWQ98YO5KL6zUzTnWSx
         WZunY6tjBrSkcSflUKHU2+AnQ9Y2c2Jg5NBC0C1asyhUHMGo5oNEhFFbYww4TJ29ALai
         86EoRzLZtNxOPMfYtWK/lD4rgUSJDxqAFQZdFqJfRKfIdE2M981AECxNdC+hDeUqGElb
         xtTA==
X-Gm-Message-State: AOAM530ts6Iii6r0MbZsRrxLdp0fT7k8w4Su+CR4MjuDrZtQh5qkS+h+
        bIoDnjrq/aXoJj5EeIMK2+w=
X-Google-Smtp-Source: ABdhPJwwWTURvjJ6ZonVIkYlcjFJ8ZdvWN6X+EzmB8O32dYuQDvMmXI9NMayJiB5K5hZhN3jBLnXaw==
X-Received: by 2002:a17:90a:4204:: with SMTP id o4mr18366892pjg.199.1628220597080;
        Thu, 05 Aug 2021 20:29:57 -0700 (PDT)
Received: from [10.173.0.66] ([45.135.186.87])
        by smtp.gmail.com with ESMTPSA id nr6sm962042pjb.39.2021.08.05.20.29.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Aug 2021 20:29:56 -0700 (PDT)
Subject: Re: [BUG] power: supply: 88pm860x_battery: possible
 uninitialized-variable access in measure_vbatt()
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        baijiaju1990@gmail.com, "Jett.Zhou" <jtzhou@marvell.com>
References: <e2080eb9-bbe2-5077-761d-b5594edb6006@gmail.com>
 <20210805174908.ctg6n5iwmg5izap3@earth.universe>
From:   Tuo Li <islituo@gmail.com>
Message-ID: <94bb8568-3f3b-b3af-c98f-9d9bf36528e1@gmail.com>
Date:   Fri, 6 Aug 2021 11:29:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210805174908.ctg6n5iwmg5izap3@earth.universe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Thanks for your feedback, and any further feedback about this problem 
would be appreciated.

Best wishes,
Tuo Li

On 2021/8/6 1:49, Sebastian Reichel wrote:
> [adding Jett Zhou to Cc who introduced the driver]
>
> Hi,
>
> On Wed, Jul 28, 2021 at 06:24:12PM +0800, Li Tuo wrote:
>> Our static analysis tool finds a possible uninitialized-variable access in
>> the 88pm860x_battery driver in Linux 5.14.0-rc3:
>>
>> In calc_soc():
>> 369:    int ocv;
>> 376:    switch (state) {
>> 380:    case OCV_MODE_SLEEP:
>> 381:        ret = measure_vbatt(info, OCV_MODE_SLEEP, &ocv);
>>
>> In measure_vbatt(struct pm860x_battery_info *info, int state, int *data)
>> 176:    switch (state) {
>> 184:    case OCV_MODE_SLEEP:
>> 201:        *data = ((*data & 0xff) * 27 * 25) >> 9;
>>
>> If the variable state is OCV_MODE_SLEEP, the function measure_vbatt() is
>> called with the argument &ocv, and the corresponding parameter is data.
>> Thus *data is uninitialized but it is used at line 201.
>>
>> I am not quite sure whether this possible uninitialized-variable access is
>> real and how to fix it if it is real.
>> Any feedback would be appreciated, thanks!
>>
>> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
> I suppose the code is suppose to look like this:
>
> 201:        *data = ((ret & 0xff) * 27 * 25) >> 9;
>
> Considering quite some code is spent before to setup ret, which is
> never used. I don't have the device (nor datasheets) though. Considering
> the driver has only seen trivial cleanups over the last 9 years, maybe
> it can just be removed?
>
> -- Sebastian

