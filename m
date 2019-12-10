Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B96111927C
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2019 21:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfLJUyR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Dec 2019 15:54:17 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33516 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbfLJUyQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Dec 2019 15:54:16 -0500
Received: by mail-wm1-f67.google.com with SMTP id d139so2064858wmd.0
        for <linux-pm@vger.kernel.org>; Tue, 10 Dec 2019 12:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4x+e0bGnBfRH7hq+Tzi9qjxxt6H+KQCgDgk15WCNryU=;
        b=yk02gMK8rzfoHy7kpXXv5wRu2KmPz6mAz/fKFa5TN/lkauDpIbQAQqAKPMwDfJOmnT
         Fu+zpRAxBLOL74pa80T3ndrICwZlNhCaGWZWr3xPtQKVw64IdokSeMeDEjInz/ZCJMpc
         yir0phKkV6QYEoKZaUT7Jf5IISfrsRrnfG6xmtUWP1/ZyiXi27roahDGqWeU0ML7mQEx
         SpDCC0sqg5zP+5LAYwBxPWkaDGW9N7K1jdKT8VbhZxRXZL06Wv5K/+5t4pUcT7VmJUVh
         wC9oRQ8rEd3hChFv4YFpRb1MsHj7syeKaxAj5byt/nuU5phwbd2jSPFDACggXeAtfHvt
         gvfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=4x+e0bGnBfRH7hq+Tzi9qjxxt6H+KQCgDgk15WCNryU=;
        b=bGvbqR7u877BnSxkfmoz8TENuwJPZua5CkoZCP45tAJQHXvpLMB0nz5mPYGDJ7z5U5
         tg6P7IHAd5bObP5Oygp7C7dKSs6PRR6zCkGp3kyRyMboO3RxrbEs+9X1bEI/vM5Ki+YD
         3sQ9i1BsOJvQex/oyh+UYalzWwFWEH5VYhmct5+NK+KhWKWqDa2EV4vulmLFMw3bvNQ1
         vgySgCkxopqhLISLrZEfKRjZzO1K/dDxsB7TyO+Zv+8DeLQvl3t5xwFVMV5A0Wf7nUgM
         rVXGukwfxPg7qu0TD3lZBPfHHLQkzSpgB8phj4I4szXdyX08ZVvq+hrNHHvkA5nDwV8C
         ZDwg==
X-Gm-Message-State: APjAAAXWrQvpsku9/DExxU/PODpgc23lvbJz7Nf755/IZUnqfXWTEMmw
        Qj+N09S7v6yrQlE1gsosUj51qA==
X-Google-Smtp-Source: APXvYqz8xCLcGVgwGP5MmqI432Zx0B3LeQtvKU3oeH4sl9pMVKO/NxmsjQ9iSHkefN4cIxXkK+WHVw==
X-Received: by 2002:a05:600c:54b:: with SMTP id k11mr7241530wmc.63.1576011253379;
        Tue, 10 Dec 2019 12:54:13 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:e505:be10:23e:110d? ([2a01:e34:ed2f:f020:e505:be10:23e:110d])
        by smtp.googlemail.com with ESMTPSA id e12sm4562714wrn.56.2019.12.10.12.54.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2019 12:54:12 -0800 (PST)
Subject: Re: [PATCH v3 0/3] thermal: introduce by-name softlink
To:     Wei Wang <wvw@google.com>
Cc:     Wei Wang <wei.vince.wang@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20191205071953.121511-1-wvw@google.com>
 <69dd3a7a-c5fe-3ae7-8a4d-c3939870eed8@linaro.org>
 <CAGXk5yrsmvHK_xwvp_kFNmSqKOZ7Ef3HrVBHYDMBmDsCz0FNSQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <0603228e-5f0b-d335-30ce-67cf0626a489@linaro.org>
Date:   Tue, 10 Dec 2019 21:54:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CAGXk5yrsmvHK_xwvp_kFNmSqKOZ7Ef3HrVBHYDMBmDsCz0FNSQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/12/2019 21:01, Wei Wang wrote:
> On Tue, Dec 10, 2019 at 6:36 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 05/12/2019 08:19, Wei Wang wrote:
>>> The paths thermal_zone%d and cooling_device%d are not intuitive and the
>>> numbers are subject to change due to device tree change. This usually
>>> leads to tree traversal in userspace code.
>>> The patch creates `tz-by-name' and `cdev-by-name' for thermal zone and
>>> cooling_device respectively.
>>
>> Instead of adding another ABI, I suggest we put the current one
>> deprecated with a warning in the dmesg, update the documentation and
>> change the name the next version.
>>
>>
> 
> IMHO, we should keep the existing path which is a common pattern for
> sysfs interface. There are reasons we need couple thermal zone and
> cooling device in one class, but might be worth considering split as
> the latter might be used for other purposes e.g. battery current limit
> for preventive vdrop prevention. By nature, thermal zone are sensors,
> and cooling devices are usually components with potential high power
> use.

[Added Greghk and Rafael in Cc]

I understand but I would like to have Greg's and Rafael's opinion on that.

The result is:

ls -al /sys/devices/virtual/thermal/
total 0
drwxr-xr-x 22 root root 0 Dec 10 12:34 .
drwxr-xr-x 15 root root 0 Dec 10 12:34 ..
drwxr-xr-x  2 root root 0 Dec 10 13:18 cdev-by-name
drwxr-xr-x  3 root root 0 Dec 10 12:34 cooling_device0
drwxr-xr-x  3 root root 0 Dec 10 12:34 cooling_device1
drwxr-xr-x  3 root root 0 Dec 10 12:34 cooling_device10
drwxr-xr-x  3 root root 0 Dec 10 12:34 cooling_device11
drwxr-xr-x  3 root root 0 Dec 10 12:34 cooling_device12
drwxr-xr-x  3 root root 0 Dec 10 12:34 cooling_device13
drwxr-xr-x  3 root root 0 Dec 10 12:34 cooling_device14
drwxr-xr-x  3 root root 0 Dec 10 12:34 cooling_device15
drwxr-xr-x  3 root root 0 Dec 10 12:34 cooling_device2
drwxr-xr-x  3 root root 0 Dec 10 12:34 cooling_device3
drwxr-xr-x  3 root root 0 Dec 10 12:34 cooling_device4
drwxr-xr-x  3 root root 0 Dec 10 12:34 cooling_device5
drwxr-xr-x  3 root root 0 Dec 10 12:34 cooling_device6
drwxr-xr-x  3 root root 0 Dec 10 12:34 cooling_device7
drwxr-xr-x  3 root root 0 Dec 10 12:34 cooling_device8
drwxr-xr-x  3 root root 0 Dec 10 12:34 cooling_device9
drwxr-xr-x  3 root root 0 Dec 10 12:34 thermal_zone0
drwxr-xr-x  3 root root 0 Dec 10 12:34 thermal_zone1
drwxr-xr-x  2 root root 0 Dec 10 13:18 tz-by-name

ls -al /sys/devices/virtual/thermal/cdev-by-name/
total 0
drwxr-xr-x  2 root root 0 Dec 10 13:18 .
drwxr-xr-x 22 root root 0 Dec 10 12:34 ..
lrwxrwxrwx  1 root root 0 Dec 10 13:18 thermal-cpufreq-0 ->
../cooling_device0
lrwxrwxrwx  1 root root 0 Dec 10 13:18 thermal-cpufreq-1 ->
../cooling_device1
lrwxrwxrwx  1 root root 0 Dec 10 13:18 thermal-idle-0 -> ../cooling_device2
lrwxrwxrwx  1 root root 0 Dec 10 13:18 thermal-idle-1 -> ../cooling_device3
lrwxrwxrwx  1 root root 0 Dec 10 13:18 thermal-idle-10 ->
../cooling_device12
lrwxrwxrwx  1 root root 0 Dec 10 13:18 thermal-idle-11 ->
../cooling_device13
lrwxrwxrwx  1 root root 0 Dec 10 13:18 thermal-idle-12 ->
../cooling_device14
lrwxrwxrwx  1 root root 0 Dec 10 13:18 thermal-idle-13 ->
../cooling_device15
lrwxrwxrwx  1 root root 0 Dec 10 13:18 thermal-idle-2 -> ../cooling_device4
lrwxrwxrwx  1 root root 0 Dec 10 13:18 thermal-idle-3 -> ../cooling_device5
lrwxrwxrwx  1 root root 0 Dec 10 13:18 thermal-idle-4 -> ../cooling_device6
lrwxrwxrwx  1 root root 0 Dec 10 13:18 thermal-idle-5 -> ../cooling_device7
lrwxrwxrwx  1 root root 0 Dec 10 13:18 thermal-idle-6 -> ../cooling_device8
lrwxrwxrwx  1 root root 0 Dec 10 13:18 thermal-idle-7 -> ../cooling_device9
lrwxrwxrwx  1 root root 0 Dec 10 13:18 thermal-idle-8 -> ../cooling_device10
lrwxrwxrwx  1 root root 0 Dec 10 13:18 thermal-idle-9 -> ../cooling_device11

ls -al /sys/devices/virtual/thermal/tz-by-name/
total 0
drwxr-xr-x  2 root root 0 Dec 10 13:18 .
drwxr-xr-x 22 root root 0 Dec 10 12:34 ..
lrwxrwxrwx  1 root root 0 Dec 10 20:53 cpu -> ../thermal_zone0
lrwxrwxrwx  1 root root 0 Dec 10 20:53 gpu -> ../thermal_zone1



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

