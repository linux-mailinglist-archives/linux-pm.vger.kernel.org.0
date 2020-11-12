Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19D112B03DA
	for <lists+linux-pm@lfdr.de>; Thu, 12 Nov 2020 12:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbgKLL3W (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Nov 2020 06:29:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbgKLL3W (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Nov 2020 06:29:22 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD5CC0613D1
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2020 03:29:22 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id j7so5637311wrp.3
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2020 03:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kEGmo14fLBYd6nSV3jI87mJ9Na1xum6NrqwdS4+IQ9Y=;
        b=nu/S8C1Yfzo9SHPOKV654ix3Bn7t9atAD7AUykvxjLXtDBitsoIhyQBnn0xD4aS7gx
         cT/hR+koIINFS5aszapJJqOPFA0xDNRQ9aw1H9aE4HtH8AYnfVnp4zZONs7JhK95tV+b
         yoTLe/bA1W1GKaoUSP+ygtMYupwIp4iCWgtjZDg0cXh7iaEYsJ8Jg2zpDecd897p8qrG
         ZmFGkJk3MrTdN3AuPYE3zAZkK5Xm+IaB7T2zVMCxpIY8nMqsLrIq6/8IppPlOjIj70ca
         j3blFEFrL8WguNYDLTlMgHhu8p+MKEqk4Jkq+u7rG90RfcgOktY4EbTyaSMhxsAfWE5c
         wuXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kEGmo14fLBYd6nSV3jI87mJ9Na1xum6NrqwdS4+IQ9Y=;
        b=aBSEMaHQpNmg2wANqvb6immR0wwxnpoJFoqsVkbaeRmtbKT3l9Fsu3Njxw1rnnSrcv
         jh/2QDamJ7qGOvOOK8ung60/+fe7Pg3GBWr4NYlE1QYDgWwf2srmPCjNW8ll/cVZi6oU
         5ktV+dUxTdU7z8+LiHHiSh6IEu5xOhcAwa8FvIa8d9ZohtgmUFjUNluXToRq+Faizctm
         41MMfWccu5NkXajvVLIqWVDnzrr6SvWMbb43IlOIzLjBYdWA7YrAFoAMLH9LpYj64UmP
         9CAonkS25NhDMF3kOf2zgAtaMRfhmjofJyUPuqgu4O891aNCT0FeF2Y17E1bM+EIol5y
         uIlw==
X-Gm-Message-State: AOAM532HRuPYrGKoeQ96PSC4oEV2bmfB0uce+euXXhRSvL9JwRAKRINt
        +uTfLcP3JAFBduE3pni4inPgzNgNpBPJqQ==
X-Google-Smtp-Source: ABdhPJxyFdKh+yZ6q8Rw1tY96SUPbmpWmKbb2vOHAkpwQyJDdNnfM7LsQRWGdffrTxd7Amuh5Mswqw==
X-Received: by 2002:a5d:4f12:: with SMTP id c18mr16332843wru.304.1605180560855;
        Thu, 12 Nov 2020 03:29:20 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:6971:b700:3764:fa96? ([2a01:e34:ed2f:f020:6971:b700:3764:fa96])
        by smtp.googlemail.com with ESMTPSA id u8sm6233604wmg.6.2020.11.12.03.29.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2020 03:29:20 -0800 (PST)
Subject: Re: [PATCH] thermal: intel_pch_thermal: Add PCI ids for Lewisburg
 PCH.
To:     Andres Freund <andres@anarazel.de>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Tushar Dave <tushar.n.dave@intel.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200115184415.1726953-1-andres@anarazel.de>
 <2a5e9df32e2df27297149a577512f6b1557de241.camel@linux.intel.com>
 <20200116184250.qlvc3ilx2b42czqk@alap3.anarazel.de>
 <2de70e961f24592d2d157b8586526df2eaf0ae6e.camel@linux.intel.com>
 <20201028202101.2m2jp3tfa6mh3brz@alap3.anarazel.de>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <0a62fbb3-a858-02ca-b89d-5234775da4a4@linaro.org>
Date:   Thu, 12 Nov 2020 12:29:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201028202101.2m2jp3tfa6mh3brz@alap3.anarazel.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28/10/2020 21:21, Andres Freund wrote:
> Hi,
> 
> On 2020-01-16 11:41:34 -0800, Srinivas Pandruvada wrote:
>> On Thu, 2020-01-16 at 10:42 -0800, Andres Freund wrote:
>>> Hi,
>>>
>>> On 2020-01-16 05:53:13 -0800, Srinivas Pandruvada wrote:
>>>> On Wed, 2020-01-15 at 10:44 -0800, Andres Freund wrote:
>>>>> I noticed that I couldn't read the PCH temperature on my
>>>>> workstation
>>>>> (C620 series chipset, w/ 2x Xeon Gold 5215 CPUs) directly, but
>>>>> had to
>>>>> go
>>>>> through IPMI. Looking at the data sheet, it looks to me like the
>>>>> existing intel PCH thermal driver should work without changes for
>>>>> Lewisburg.
>>>> Does the temperature reading match with what you read via IPMI?
>>>
>>> It does:
>>>
>>> root@awork3:~# ipmitool sdr|grep ^PCH
>>> PCH Temp         | 58 degrees C      | ok
>>>
>>> andres@awork3:~$ cat /sys/class/thermal/thermal_zone0/type
>>> pch_lewisburg
>>> andres@awork3:~$ cat /sys/class/thermal/thermal_zone0/temp
>>> 58000
>>>
>>> And if I generate some load, it rises for both:
>>> root@awork3:~# ipmitool sdr|grep ^PCH
>>> PCH Temp         | 60 degrees C      | ok
>>> andres@awork3:~$ cat /sys/class/thermal/thermal_zone0/temp
>>> 60000
>>>
>> Thanks for the test.
>>
>> Rui can add his ACK.
> 
> Ping? Looks like this got lost somewhere?

Waiting for Rui's ack :)


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
