Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A365E3E29C9
	for <lists+linux-pm@lfdr.de>; Fri,  6 Aug 2021 13:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243362AbhHFLgv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Aug 2021 07:36:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47050 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232704AbhHFLgu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Aug 2021 07:36:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628249794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hvNQYJMcc/VfPAcgHw2rmdTZfqoiP2ibGcZ+eg0lOcM=;
        b=PTrh8rQbpqLjM5/2YyPI/tosREG05iVpJO8qCjPGNGVMMIjmyOBKmV6YGJwuXJL67C9fUE
        QLLNA0Ud3IRe4gAtg7mAJYQbMr50OmvsQqWTXRNwEf/aIBxoC/rwRbdCw/Rmxu4PUu/uag
        rXRMq81FOb0k3mmxzA/wYlqZoT/ohkA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-ncf-i1nuPpCp5oknQQXqOQ-1; Fri, 06 Aug 2021 07:36:33 -0400
X-MC-Unique: ncf-i1nuPpCp5oknQQXqOQ-1
Received: by mail-ed1-f70.google.com with SMTP id s10-20020a05640217cab02903bddc3e8fb3so4608708edy.0
        for <linux-pm@vger.kernel.org>; Fri, 06 Aug 2021 04:36:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hvNQYJMcc/VfPAcgHw2rmdTZfqoiP2ibGcZ+eg0lOcM=;
        b=kysyOotjG4PujUjQPf6S7dRDJ76X4q3tcIWoNLvH4/UpuFkLb1S35oYyYRTbBKPBUw
         ivf7O9Mgn5+bEIReBoAOAMJY0HCMoSsYUIJNIWmS743maY55cNxhDa/+FIicTYOBt6/v
         RcdknGmRqAs/kZrlupBcN6LHvgV6PPqlkbzC3pGvS1R1HbUdpmjnK8Q9h4j2sI2UZg+O
         VNoiGcgK3TT8m4+2Gbw71gWUstb25JGeyHOWVz9kFv01llQLNJZdbNiRr4jAqLaIEYSY
         hy0eXqdPk8J/SOwMCgWCk8nJcJzK0XNEZh6L4YvR6fpbccybu2EWveixS/K4LwFKqRn2
         Va8Q==
X-Gm-Message-State: AOAM532wOOLjpbdhsSfj5uTRl4DgvSuZWnAf+v6GudxeqDzvrUEW5KoG
        E0mL4fOqzAelOst3PtrL2dxEHCHS00ogE1xfWDWFyp4pybwfc+SI8neBZOpSewrfogLk2hRJpx5
        xOtF55n4d9lDSBTiPMb/ekVtaVAGCSZgiAxugvvdDvKO3AVXArhVPApVUiaeZ7rPQ7jvRQfA=
X-Received: by 2002:a50:f1c7:: with SMTP id y7mr12361256edl.386.1628249792357;
        Fri, 06 Aug 2021 04:36:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxssxu+xwMdvzo7u1qLeZ41NfbogLTTunHGjtp8BwD0zUF/aNd0wDk8CQgiPWyZd1pR58HmKA==
X-Received: by 2002:a50:f1c7:: with SMTP id y7mr12361232edl.386.1628249792146;
        Fri, 06 Aug 2021 04:36:32 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id o23sm3776328eds.75.2021.08.06.04.36.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Aug 2021 04:36:31 -0700 (PDT)
Subject: Re: [PATCH v3 00/10] power: supply: axp288_fuel_gauge: Reduce number
 of register accesses + cleanups
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Andrejus Basovas <cpp@gcc.lt>, linux-pm@vger.kernel.org
References: <20210801133105.101761-1-hdegoede@redhat.com>
 <20210805171951.xkvndkzpx3od2nki@earth.universe>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <8b43afbb-918a-9a88-5a0d-a6d1f3509a97@redhat.com>
Date:   Fri, 6 Aug 2021 13:36:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210805171951.xkvndkzpx3od2nki@earth.universe>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sebastian,

On 8/5/21 7:19 PM, Sebastian Reichel wrote:
> Hi Hans,
> 
> On Sun, Aug 01, 2021 at 03:30:55PM +0200, Hans de Goede wrote:
>> Hi all,
>>
>> Changes in v3:
>> - Replace "depends on X86" with "depends on IOSF_MBI" as the new code uses
>>   symbols which are only defined when IOSF_MBI support is enabled.
>>   Depending on this is ok since IOSF_MBI support should always be enabled
>>   on devices which use the AXP288 PMIC.
>>
>> Changes in v2:
>> - Add a "depends on X86" to Kconfig since the iosf_mbi functions are X86 only
>>   (the AXP288 PMIC is only used on X86 devices).
>>
>> And here is the v1 cover-letter again:
>>
>> The I2C-bus to the XPower AXP288 is shared between the Linux kernel and
>> the SoCs P-Unit. The P-Unit has a semaphore which the kernel must "lock"
>> before it may use the bus and while the kernel holds the semaphore the CPU
>> and GPU power-states must not be changed otherwise the system will freeze.
>> This is a complex process, which is quite expensive.
>>
>> To ensure that no unguarded I2C-bus accesses happen, the semaphore is
>> taken by the I2C-bus-driver for every I2C transfer. When upower refreshes
>> its battery stats it reads all the power-supply properties at once,
>> leading to the semaphore getting hammered which sometimes causes the
>> system to hang.
>>
>> Andrejus maintains a large "fleet" of affected Cherry Trail tablets
>> and was seeing these hangs semi regularly. After discussing this with
>> me Andrejus wrote the caching patch in this series which greatly reduces
>> the number of semaphore accesses and since then there have been no
>> reports of hangs in the fleet of devices which he maintains.
>>
>> I've cleaned up Andrejus work a bit before submitting it upstream and
>> while working on this I found a slew of other issues in this driver
>> which bugged me enough to write a bunch of cleanup patches. I've also
>> added some extra patches to also reduce the semaphore use during driver
>> probe.
> 
> Thanks, I applied the whole series.

Thank you.

> The double goto from the last
> patch is a bit ugly and can be avoided by switching the driver to
> devm_*(). Do you mind doing so?

No I can take care of this, the problem is finding some time for
it though. I've added this to my to do list, but there is a bunch
of higher priority items above it.

Still I will try to get around to doing some clean-up by switching
to devm_... eventually.

Regards,

Hans




>> Andrejus Basovas (1):
>>   power: supply: axp288_fuel_gauge: Refresh all registers in one go
>>
>> Hans de Goede (9):
>>   power: supply: axp288_fuel_gauge: Fix define alignment
>>   power: supply: axp288_fuel_gauge: Remove debugfs support
>>   power: supply: axp288_fuel_gauge: Silence the chatty IRQ mapping code
>>   power: supply: axp288_fuel_gauge: Report register-address on readb /
>>     writeb errors
>>   power: supply: axp288_fuel_gauge: Drop retry logic from
>>     fuel_gauge_reg_readb()
>>   power: supply: axp288_fuel_gauge: Store struct device pointer in
>>     axp288_fg_info
>>   power: supply: axp288_fuel_gauge: Only read PWR_OP_MODE,
>>     FG_LOW_CAP_REG regs once
>>   power: supply: axp288_fuel_gauge: Move the AXP20X_CC_CTRL check
>>     together with the other checks
>>   power: supply: axp288_fuel_gauge: Take the P-Unit semaphore only once
>>     during probe()
>>
>>  drivers/power/supply/Kconfig             |   2 +-
>>  drivers/power/supply/axp288_fuel_gauge.c | 489 +++++++++--------------
>>  2 files changed, 187 insertions(+), 304 deletions(-)
>>
>> -- 
>> 2.31.1

