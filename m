Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 512392172F2
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jul 2020 17:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgGGPtP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jul 2020 11:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728485AbgGGPtO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jul 2020 11:49:14 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB14C08C5E3
        for <linux-pm@vger.kernel.org>; Tue,  7 Jul 2020 08:49:14 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f7so42686246wrw.1
        for <linux-pm@vger.kernel.org>; Tue, 07 Jul 2020 08:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R/msZMHFZFhx7FtV1U4x6F/0CAVdjvMvgRT/NC78y40=;
        b=MobMyrjR9AJycEk2mi5Sq3uQIiCVRztqdkLHqoXq0Xx+JZ8KAISUiDRjhN6Yn5A+22
         ou+UdEg2G1508GrcMLY5tP0WR6yXgF/Lq1rO2kitGdj7AYtMvcA1bNIXOLyMqhBFvtqB
         v0JWLpMJC9RF9i82bU6AnAS/QMK3zeBkaPqY7ZU9E64zNYFaCnQaeKapXxSZIZpre3dp
         /gyo2768jJfR+LmEezi+LOQng8QSzxQrX2Qap40V9sfiOCe4fR80Ml/kxi8aF8NNT88Z
         FdZdZKy++pzBg8IcMLZQnXm09IApuylDTWhDXD7+BCPQFDxa9uWVJdhTlXbcc0GHiQGQ
         xIcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R/msZMHFZFhx7FtV1U4x6F/0CAVdjvMvgRT/NC78y40=;
        b=qjRq28XxbtxPDP8+0MuxRlluHoE7PvMH1fubQMAm0OPYIeWYxuEzKcgiGqK9YubaKO
         wUX0mVTAEjKfdqwrTzgc2qAukFLvPgVeW75p8VYtI1jKNLt1cGGH6HrX2wY+5O/Rpf91
         pLmN8TgCE1FntRwRqCh3N1myOcmoih7i6XuvUY3/YoOp4jAOQNMJiCGYwuQD42hl3DO0
         qFIb0M8FQ6kooWWK2zmtw1dtuE8DLjVWMCBC34XK7Wq0a1y9F1aFsfoHGh7oZqhpVXh7
         IvtU0jpLd9QrsvLeuH38pNrVDn5IokTzerDhT/42K0+5YwuWdjQipr80mbJF4bSM6bAp
         YIWw==
X-Gm-Message-State: AOAM531MpdlFWbzYY24pXPopfNmZjNiEcFD0M2LPG6TKVokLbVqjxPvE
        BGRIqRVUiyr0YVDNCm47hsNi4bpjHDg=
X-Google-Smtp-Source: ABdhPJzB2lzxg02HvDyZykAOfBzZtzV6VPnCvusD+uRECHuBlKqXlNPf6GpDDuc2YVRPuhXxaJQK6g==
X-Received: by 2002:a5d:4992:: with SMTP id r18mr51805915wrq.323.1594136952944;
        Tue, 07 Jul 2020 08:49:12 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:b4ff:29eb:619e:318? ([2a01:e34:ed2f:f020:b4ff:29eb:619e:318])
        by smtp.googlemail.com with ESMTPSA id i67sm1721005wma.12.2020.07.07.08.49.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 08:49:12 -0700 (PDT)
Subject: Re: [PATCH] thermal: netlink: Fix compilation error when CONFIG_NET=n
To:     Randy Dunlap <rdunlap@infradead.org>, rui.zhang@intel.com
Cc:     amit.kucheria@verdurent.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20200707090159.1018-1-daniel.lezcano@linaro.org>
 <66b4c589-48e0-8975-b3b1-79168e3ea5e4@infradead.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <04a6904d-9220-9045-6816-12cf84781f4d@linaro.org>
Date:   Tue, 7 Jul 2020 17:49:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <66b4c589-48e0-8975-b3b1-79168e3ea5e4@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07/07/2020 17:47, Randy Dunlap wrote:
> On 7/7/20 2:01 AM, Daniel Lezcano wrote:
>> When the network is not configured, the netlink are disabled on all
>> the system. The thermal framework assumed the netlink are always
>> opt-in.
>>
>> Fix this by adding a Kconfig option for the netlink notification,
>> defaulting to yes and depending on CONFIG_NET.
>>
>> As the change implies multiple stubs and in order to not pollute the
>> internal thermal header, the thermal_nelink.h has been added and
>> included in the thermal_core.h, so this one regain some kind of
>> clarity.
>>
>> Reported-by: Randy Dunlap <rdunlap@infradead.org>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>  drivers/thermal/Kconfig           | 10 ++++
>>  drivers/thermal/Makefile          |  5 +-
>>  drivers/thermal/thermal_core.h    | 20 +------
>>  drivers/thermal/thermal_netlink.h | 98 +++++++++++++++++++++++++++++++
>>  4 files changed, 114 insertions(+), 19 deletions(-)
>>  create mode 100644 drivers/thermal/thermal_netlink.h
>>
> 
> 
> Hm, now I get this:
> 
> ../drivers/thermal/thermal_helpers.c: In function ‘thermal_cdev_set_cur_state’:
> ../drivers/thermal/thermal_helpers.c:182:2: error: implicit declaration of function ‘thermal_notify_cdev_update’; did you mean ‘thermal_notify_cdev_delete’? [-Werror=implicit-function-declaration]
>   thermal_notify_cdev_update(cdev->id, target);
> 
> 
> or should that call be to thermal_notify_cdev_state_update()?

Ah right, the patch applies on top of the v4 which is not yet in
linux-next, I'm waiting for the kernelci loop result.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
