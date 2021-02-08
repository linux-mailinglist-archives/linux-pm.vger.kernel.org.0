Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C89B314128
	for <lists+linux-pm@lfdr.de>; Mon,  8 Feb 2021 22:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbhBHVBt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Feb 2021 16:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbhBHVBa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Feb 2021 16:01:30 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D97AC061788;
        Mon,  8 Feb 2021 13:00:45 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id y11so15535066otq.1;
        Mon, 08 Feb 2021 13:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/wBVwDhDiae21VdHyS4ED5wTElYuC56T0HP27SlXgtE=;
        b=CUW15GK+D/oFv5TbkBvwV1isjKpFSWsiZ0cRSrxAS9WqlrtaEbn7XbL4fv4KbaLuE8
         HGkr6tBB170aq1yHzWJH6UEUpfs9UG/1T3juWiHAa4h6ueaO0YDgZH+LAVSvCtuSZwqY
         K165inKoI38+MIAZBXigzRxsvtBvoyOS7TQtj+rGNpIbW1XO+JJSTvNOdG1hFbnqkxA1
         qgdg4kFqEBiYS9MuDucC7gZGdqlJ1o89aFEEmNMVuqS4dfeUL4LL0quBYVxgu7Ht/+ke
         4mjAow7DoIebJoNyaGRM3rThKbShc35/k6cBe50bebEtU9hbrQSxV5qkCLVOSYKx69UU
         KTLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=/wBVwDhDiae21VdHyS4ED5wTElYuC56T0HP27SlXgtE=;
        b=YONAtPuO4CTSoQgidPaLcSHwjXxNF7z1vPQkSyRSgsmnnzAy62JL8yhXViDX0Lt57G
         p86fSoBMwxfkl8Z5zpM3sfpfW57rvV+ERzfXxzKUEkVkkfD8oGFUwJp4sxzR1iKK1nWN
         Z7Upf1KQgj7u/yMxVbNqDg7vUIbzyJRktiZgHqgeI3go2Vy8VNIpgADeNyg9aF6Hgalr
         4dE4xUESd2gCdLy3guP1+hbW4sQctSjPnldKOc7jEIRJNKhAcmLP/HG9nipBmDVD1N01
         N+3rKS1ngkPavV/QjRCps0eKHIZuGdEfnHrUi5OkAzuYNrjRzQZRfqIznlXdhdKlPUkv
         7QaA==
X-Gm-Message-State: AOAM532gbY52QPotpeDbHQj5BY9TD6FKkIERu3S8Kau9ZeQUKkTzO+LC
        AHF69CYwVwQE+bSc7lpsxpK8K02LaB0=
X-Google-Smtp-Source: ABdhPJw3GrZkJqAyt5PqhqZjuyDR+obIP8z2fzNZdQEhbafDn6CP5Am4wpO9l7qj/X2uikCOrEdI6A==
X-Received: by 2002:a9d:7ccd:: with SMTP id r13mr13699132otn.253.1612818044809;
        Mon, 08 Feb 2021 13:00:44 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 62sm2279729oii.23.2021.02.08.13.00.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 13:00:43 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 2/4] hwmon: Use subdir-ccflags-* to inherit debug flag
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Yicong Yang <yangyicong@hisilicon.com>, gregkh@linuxfoundation.org,
        jdelvare@suse.com, giometti@enneenne.com, abbotti@mev.co.uk,
        hsweeten@visionengravers.com, kw@linux.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-hwmon@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kbuild@vger.kernel.org, masahiroy@kernel.org,
        michal.lkml@markovi.net, prime.zeng@huawei.com,
        linuxarm@openeuler.org
References: <20210205200859.GA193526@bjorn-Precision-5520>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <28707cb4-8f2d-2864-4efe-749ca7ee494c@roeck-us.net>
Date:   Mon, 8 Feb 2021 13:00:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210205200859.GA193526@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2/5/21 12:08 PM, Bjorn Helgaas wrote:
> On Fri, Feb 05, 2021 at 10:28:32AM -0800, Guenter Roeck wrote:
>> On Fri, Feb 05, 2021 at 05:44:13PM +0800, Yicong Yang wrote:
>>> From: Junhao He <hejunhao2@hisilicon.com>
>>>
>>> Use subdir-ccflags-* instead of ccflags-* to inherit the debug
>>> settings from Kconfig when traversing subdirectories.
>>>
>>> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
>>> Signed-off-by: Junhao He <hejunhao2@hisilicon.com>
>>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>>
>> What problem does this fix ? Maybe I am missing it, but I don't see
>> DEBUG being used in a subdirectory of drivers/hwmon.
> 
> It's my fault for raising this question [1].  Yicong fixed a real
> problem in drivers/pci, where we are currently using
> 
>   ccflags-$(CONFIG_PCI_DEBUG) := -DDEBUG
> 
> so CONFIG_PCI_DEBUG=y turns on debug in drivers/pci, but not in the
> subdirectories.  That's surprising to users.
> 
> So my question was whether we should default to using subdir-ccflags
> for -DDEBUG in general, and only use ccflags when we have
> subdirectories that have their own debug options, e.g.,
> 
>   drivers/i2c/Makefile:ccflags-$(CONFIG_I2C_DEBUG_CORE) := -DDEBUG
>   drivers/i2c/algos/Makefile:ccflags-$(CONFIG_I2C_DEBUG_ALGO) := -DDEBUG
>   drivers/i2c/busses/Makefile:ccflags-$(CONFIG_I2C_DEBUG_BUS) := -DDEBUG
>   drivers/i2c/muxes/Makefile:ccflags-$(CONFIG_I2C_DEBUG_BUS) := -DDEBUG
> 
> I mentioned drivers/hwmon along with a few others that have
> subdirectories, do not have per-subdirectory debug options, and use
> ccflags.  I didn't try to determine whether those subdirectories
> currently use -DDEBUG.
> 
> In the case of drivers/hwmon, several drivers do use pr_debug(),
> and CONFIG_HWMON_DEBUG_CHIP=y turns those on.  But if somebody
> were to add pr_debug() to drivers/hwmon/occ/common.c, for example,
> CONFIG_HWMON_DEBUG_CHIP=y would *not* turn it on.  That sounds
> surprising to me, but if that's what you intend, that's totally fine.
> 

That does make sense, but that explanation is missing from the
description.

Guenter

> [1] https://lore.kernel.org/r/20210204161048.GA68790@bjorn-Precision-5520
> 
>>> ---
>>>  drivers/hwmon/Makefile | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
>>> index 09a86c5..1c0c089 100644
>>> --- a/drivers/hwmon/Makefile
>>> +++ b/drivers/hwmon/Makefile
>>> @@ -201,5 +201,5 @@ obj-$(CONFIG_SENSORS_XGENE)	+= xgene-hwmon.o
>>>  obj-$(CONFIG_SENSORS_OCC)	+= occ/
>>>  obj-$(CONFIG_PMBUS)		+= pmbus/
>>>  
>>> -ccflags-$(CONFIG_HWMON_DEBUG_CHIP) := -DDEBUG
>>> +subdir-ccflags-$(CONFIG_HWMON_DEBUG_CHIP) := -DDEBUG
>>>  
>>> -- 
>>> 2.8.1
>>>

