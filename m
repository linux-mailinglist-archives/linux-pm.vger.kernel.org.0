Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA1A33F76F
	for <lists+linux-pm@lfdr.de>; Wed, 17 Mar 2021 18:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbhCQRrl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Mar 2021 13:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbhCQRrf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Mar 2021 13:47:35 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986B6C06174A;
        Wed, 17 Mar 2021 10:47:34 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j18so2726687wra.2;
        Wed, 17 Mar 2021 10:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2Cd1SMDr1wQa79ujqLK8yb0puOds3ZVuJlI62KZKeHQ=;
        b=oovO+y/7qFc5DeRnXaAQSIwssoECa2CwNB0SMJMWVNIdk1h2RWL1McUk8NMkXwo31V
         8y0EeT721pYvdpuncfhF/yC0LqAFWvuOGZLHGHR6iqa70c1U9bv0TN+Xf8DPjBwZEC/f
         B2AyNCiXfjItZW2EQjNeJzCe3smqBZjtgEMNGxaXEXIb9MKCS2sGVTH+xxWhWoJ6/uJJ
         yqKQ2o0FWcVFsL+rrxii4N1rkOqlcj1XAz3XOVyaOJDo8v+qjAQIbPcJlS1VK+UyQrUE
         CaWrqBcfDMnFi2iK5rvTF8nOaJJ3VnDf9iEwge7t93LdV7tYOEE8T0hzBcFv7yk9ZcIG
         wzzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2Cd1SMDr1wQa79ujqLK8yb0puOds3ZVuJlI62KZKeHQ=;
        b=cs4q3GoOipqzFqe2pyLIpGdGNhGbvmA9fHqnJBUR7l4UMtBH58Oh26hNQy/s4z4LVi
         V3H/brKOqfl+UHChFZWTuwEfqEw/rKXl4d6xGgKy09Bf+DqrdDIrkvQcC9Kb01BNh1hT
         x/Id3Yaya+N2aZh7p282hFixxfpRXZzohf9CZbuwkrf+IPseoMHIcGjLLaWLXuuedYnG
         IlULcq34S+9C20qbsAiDuFOGg5F0wcT1ZxfODqYLZg/Q3uSfLBjGwPEiVJQyS0YNOyF5
         A1IUyBkkqYBPA2zAh76/wS9vdAOXSZGX8coP1RHK5nlxSESAabcMyX35oeSLnwrc/N0Q
         8BRw==
X-Gm-Message-State: AOAM530jQhLJePmjEcAvH4IqFiVRXVHCKySUA8ps3oNzV4A4zKaIRAQS
        ZTmMWUZeZxvZYHpQdKle9v13Bzsk+8I=
X-Google-Smtp-Source: ABdhPJwdZsBBJEuUGcQb/Ui/fy1Be48MHHoTheQ8sHL8wpqE2b9VfIhrvZOc6SXatCgSPaQ+/COZpg==
X-Received: by 2002:adf:f292:: with SMTP id k18mr5665889wro.335.1616003253001;
        Wed, 17 Mar 2021 10:47:33 -0700 (PDT)
Received: from [192.168.2.202] (p5487bc2b.dip0.t-ipconnect.de. [84.135.188.43])
        by smtp.gmail.com with ESMTPSA id i3sm27685614wra.66.2021.03.17.10.47.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Mar 2021 10:47:32 -0700 (PDT)
Subject: Re: [PATCH 0/2] power: supply: Add battery and AC drivers for Surface
 devices
To:     Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210309000530.2165752-1-luzmaximilian@gmail.com>
 <edcbe108-8cd7-4034-222f-c8ce56918dee@redhat.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <f124e477-2786-d842-5694-13aa4146ba34@gmail.com>
Date:   Wed, 17 Mar 2021 18:47:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <edcbe108-8cd7-4034-222f-c8ce56918dee@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 3/17/21 6:39 PM, Hans de Goede wrote:
> Hi,
> 
> On 3/9/21 1:05 AM, Maximilian Luz wrote:
>> This series provides battery and AC drivers for Microsoft Surface
>> devices, where this information is provided via an embedded controller
>> (the Surface System Aggregator Module, SSAM) instead of the usual ACPI
>> interface.
>>
>> Specifically, 7th generation Surface devices, i.e. Surface Pro 7,
>> Surface Book 3, Surface Laptop 3, as well as the Surface Laptop Go use
>> this new interface.
>>
>> Note: This series depends on the
>>
>>      platform/surface: Add Surface Aggregator device registry
>>
>> series. More specifically patch
>>
>>      platform/surface: Set up Surface Aggregator device registry
>>
>> The full series has been merged into the for-next branch of the
>> platform-drivers-x86 tree [1]. The commit in question can be found at
>> [2].
>>
>> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=for-next
>> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/commit/?h=for-next&id=fc622b3d36e6d91330fb21506b9ad1e3206a4dde
> 
> Sebastian, I guess you want a pull-req from an immutable branch from me for
> that dependend commit and then you will merge these 2 patches ?
> 
> Maximillian, this only needs that commit right, or would it be better if
> I send Sebastian a pull-req for a branch with the entire series?

The entire series would be better, I think.

Strictly speaking, it only requires the mentioned commit to compile
successfully, but if anyone would want to test this they'd need the full
series (or at least the battery/power subsystem commit) due to the
device instantiation.

Same reasoning applies to the HID series.

Thanks,
Max
