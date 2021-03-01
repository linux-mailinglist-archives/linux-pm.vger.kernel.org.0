Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0657328A6F
	for <lists+linux-pm@lfdr.de>; Mon,  1 Mar 2021 19:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239228AbhCASRd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Mar 2021 13:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239459AbhCASPq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Mar 2021 13:15:46 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5EC7C06178A
        for <linux-pm@vger.kernel.org>; Mon,  1 Mar 2021 10:15:05 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id e10so16925360wro.12
        for <linux-pm@vger.kernel.org>; Mon, 01 Mar 2021 10:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1TZn5aNPCl1cGxDvp7RwBF7xgvk6iFKcNOp5AnS19Cc=;
        b=KaM/YzkDQJhjvMuxUHB/bfLDq0gMOJbpd6BQKJAt37xrn7iHDCbAJspU+3aPjgId4x
         AA4Slz5zOBiqyZgrL9/VMDmqalsbt50QjxQ0HvBa3Zr9p8GXF+8QnHLPljZevsxB1u0j
         Wis78Wem15qtqBpmi6OpCm5cIP+2bL4WDmLjejYqXgC6dyd2DnEeJTIHYski2B3pLF+o
         c2FVGskTezwAOdwrTUEvYDN07UcK9yQrP86mDVksOxXnMxeMH+kaFsffNJJ0RXwAUERi
         +KYBhiUqeK0WRgXOhwzBsrB6D2W5iPWS3JG4HPu6jQ8nh4WnnkP49xnQ7pe+KuJms0zV
         pVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1TZn5aNPCl1cGxDvp7RwBF7xgvk6iFKcNOp5AnS19Cc=;
        b=EHU5EfItIWDzRzN/a5pWcPTyWTltk1+sZQ/39X70kpPxmVL47A/q7b7zxYl2LvQhKx
         Y6jbS2/gCrpEp5uawpklrUBmVf93hzKtS+j6ghgedDqVFnAM78ZuzLafY89ax0JJgp3p
         QPCPEaJijHvCIBEgGUqkJ/vbMZZ9Nx9iyvVTbi86A73MKZ8m9pG0wVbUuWdtMgvk0ngd
         pGLQ1EyaSd1wZ9+OQ25Em0osfIscASwJr0l8IWy3WCy2SBK4wwyx93I6AS9DZHe8uRlC
         117pOajqLHdnL1lGrAueBk0/cC/+dvFCk0CgUUCYOXqqie14+BNFwpMjZdFAaJLmlb1l
         kzCA==
X-Gm-Message-State: AOAM533RTWZwwyQ2WqVEjfoIdcQPT80Ay5NV9SCftSW9VVhiD7JWQnxY
        ieYzzjuSYgCh5QNk9z/Qkd38UrV4Rhabyg==
X-Google-Smtp-Source: ABdhPJyNMnNBRbs8M+x+0zL3Vem0LyBSWdfTgNUeHwTfTvWCHWRZDXbOPFHtviDebsIDU/aN/h8Xhw==
X-Received: by 2002:adf:d236:: with SMTP id k22mr10976581wrh.144.1614622504408;
        Mon, 01 Mar 2021 10:15:04 -0800 (PST)
Received: from [192.168.0.41] (lns-bzn-59-82-252-144-192.adsl.proxad.net. [82.252.144.192])
        by smtp.googlemail.com with ESMTPSA id f7sm25716349wre.78.2021.03.01.10.15.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Mar 2021 10:15:03 -0800 (PST)
Subject: Re: [PATCH 1/2] powercap/drivers/dtpm: Fix root node initialization
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
References: <20210224183022.11846-1-daniel.lezcano@linaro.org>
 <CAJZ5v0igJztj3fRoGh9AjAPfe01wsBT27X8b19HAyr0t2kRgtg@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <67319766-8a76-7b24-96ea-17e2e5ea09d1@linaro.org>
Date:   Mon, 1 Mar 2021 19:15:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0igJztj3fRoGh9AjAPfe01wsBT27X8b19HAyr0t2kRgtg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01/03/2021 17:45, Rafael J. Wysocki wrote:
> On Wed, Feb 24, 2021 at 7:30 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> The root node is not set to NULL when the dtpm root node is
>> removed. Consequently, it is not possible to create a new root as it
>> is already set.
>>
>> Set the root node to NULL when the last node is removed.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>  drivers/powercap/dtpm.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
>> index 5a51cd34a7e8..c2185ec5f887 100644
>> --- a/drivers/powercap/dtpm.c
>> +++ b/drivers/powercap/dtpm.c
>> @@ -207,6 +207,9 @@ int dtpm_release_zone(struct powercap_zone *pcz)
>>         if (dtpm->ops)
>>                 dtpm->ops->release(dtpm);
>>
>> +       if (root == dtpm)
>> +               root = NULL;
>> +
>>         kfree(dtpm);
>>
>>         return 0;
>> --
> 
> Applied along with the [2/2[ as 5.12-rc material, thanks!

Thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
