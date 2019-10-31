Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65472EA934
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2019 03:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbfJaCUm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Oct 2019 22:20:42 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36509 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbfJaCUm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Oct 2019 22:20:42 -0400
Received: by mail-pl1-f193.google.com with SMTP id g9so1949466plp.3;
        Wed, 30 Oct 2019 19:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CPWsP48AwDYwzHrNSqeuwfy/i4c2b3NcScLUzgAvHDs=;
        b=KCLGKae/h9k8SF56oGpwR9AKeNRrZH0ZQQgmlkQs8WpkqFsCQ3jyDiH/xvyFihdx79
         aSbnyCqAzhWrVioBiT/hmiiiZae0wZHme7YieZtyUnmElTZ29pV3Dr463LMsZF5iP8PB
         nOTZjVPw+CzGIRzSFWIPJby/loXkr4N5sW2Fa6UA6NG3lvtUf+Z8gE1mDiD70TFDC7ZB
         eS6/WzL2mNNblCUHX9sdCErOwEJ8v0BOJLOy772Hhte0NsUBQtbc91CWucFzIMm/ANut
         Hr417nCHQ37w98i7u/T5HJQc8wcRmIY88woFCLRH5DqiDOIcnQ3iLFqy7NkFgF9soCGt
         PgvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CPWsP48AwDYwzHrNSqeuwfy/i4c2b3NcScLUzgAvHDs=;
        b=g3G3M281GGvr3vsc1OBG8f7PVF61MFDwMEYIFYdfkdcSvgKax/S/IK0gnnqEQO+I6z
         QbXTjNxBtDOuYQ6fouirMHZAadSY3EctrHUFANUp3Um6cVZx12vlpE56+4rNCJhbGPjI
         AUK0PyJpNGwTj6xPQEK6/bc9I4USWj41TKIGQyJNGg2saFBEQRrPy+5HPhGvKznyEFab
         YcKs4FRqjCqo71EVhOuAYze2xr/Q2pZW/dR47YyLFR+Dz0ZnoVfs6EblSpCJNpGAHkE+
         sraPnESV+9y8+nYcY6fr1nVUzLMPPUE/oo+d21Qh9UByie+tyE16g2kWczBhAnWO/1BF
         4HsA==
X-Gm-Message-State: APjAAAV7HAAzBjEdEBG/jqIxGwci3N67chQ3ZBDjjbtUzEhI/93kPplG
        Puyh/4Dw7jodmVJDsLcFq/u5yLNg
X-Google-Smtp-Source: APXvYqy8I1tQGkbZtFS4jbuQfBSsUXVrF19zbJuAgSm6DqjNwrQVyeE5AyQ1mSKAuUlgRtKErnkvog==
X-Received: by 2002:a17:902:326:: with SMTP id 35mr3485385pld.248.1572488440863;
        Wed, 30 Oct 2019 19:20:40 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a20sm3135164pjs.30.2019.10.30.19.20.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Oct 2019 19:20:39 -0700 (PDT)
Subject: Re: [PATCH v2] nvme: Add hardware monitoring support
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org,
        Linux PM <linux-pm@vger.kernel.org>,
        Chris Healy <cphealy@gmail.com>
References: <20191029223214.18889-1-linux@roeck-us.net>
 <CAC5umyhc=6yULiLwXu65VDvDk2cBiF0R9O39B-T5ftapJfj0rQ@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <e62b6763-0d1b-3359-6d3b-cb31e96bb862@roeck-us.net>
Date:   Wed, 30 Oct 2019 19:20:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAC5umyhc=6yULiLwXu65VDvDk2cBiF0R9O39B-T5ftapJfj0rQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/30/19 4:16 AM, Akinobu Mita wrote:
> 2019年10月30日(水) 7:32 Guenter Roeck <linux@roeck-us.net>:
>>
>> nvme devices report temperature information in the controller information
>> (for limits) and in the smart log. Currently, the only means to retrieve
>> this information is the nvme command line interface, which requires
>> super-user privileges.
>>
>> At the same time, it would be desirable to use NVME temperature information
>> for thermal control.
>>
>> This patch adds support to read NVME temperatures from the kernel using the
>> hwmon API and adds temperature zones for NVME drives. The thermal subsystem
>> can use this information to set thermal policies, and userspace can access
>> it using libsensors and/or the "sensors" command.
>>
>> Example output from the "sensors" command:
>>
>> nvme0-pci-0100
>> Adapter: PCI adapter
>> Composite:    +39.0°C  (high = +85.0°C, crit = +85.0°C)
>> Sensor 1:     +39.0°C
>> Sensor 2:     +41.0°C
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> v2: Use devm_kfree() to release memory in error path
>>
>>   drivers/nvme/host/Kconfig      |  10 ++
>>   drivers/nvme/host/Makefile     |   1 +
>>   drivers/nvme/host/core.c       |   5 +
>>   drivers/nvme/host/nvme-hwmon.c | 163 +++++++++++++++++++++++++++++++++
>>   drivers/nvme/host/nvme.h       |   8 ++
>>   5 files changed, 187 insertions(+)
>>   create mode 100644 drivers/nvme/host/nvme-hwmon.c
>>
>> diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
>> index 2b36f052bfb9..aeb49e16e386 100644
>> --- a/drivers/nvme/host/Kconfig
>> +++ b/drivers/nvme/host/Kconfig
>> @@ -23,6 +23,16 @@ config NVME_MULTIPATH
>>             /dev/nvmeXnY device will show up for each NVMe namespaces,
>>             even if it is accessible through multiple controllers.
>>
>> +config NVME_HWMON
>> +       bool "NVME hardware monitoring"
>> +       depends on (NVME_CORE=y && HWMON=y) || (NVME_CORE=m && HWMON)
>> +       help
>> +         This provides support for NVME hardware monitoring. If enabled,
>> +         a hardware monitoring device will be created for each NVME drive
>> +         in the system.
>> +
>> +         If unsure, say N.
>> +
>>   config NVME_FABRICS
>>          tristate
>>
>> diff --git a/drivers/nvme/host/Makefile b/drivers/nvme/host/Makefile
>> index 8a4b671c5f0c..03de4797a877 100644
>> --- a/drivers/nvme/host/Makefile
>> +++ b/drivers/nvme/host/Makefile
>> @@ -14,6 +14,7 @@ nvme-core-$(CONFIG_TRACING)           += trace.o
>>   nvme-core-$(CONFIG_NVME_MULTIPATH)     += multipath.o
>>   nvme-core-$(CONFIG_NVM)                        += lightnvm.o
>>   nvme-core-$(CONFIG_FAULT_INJECTION_DEBUG_FS)   += fault_inject.o
>> +nvme-core-$(CONFIG_NVME_HWMON)         += nvme-hwmon.o
>>
>>   nvme-y                                 += pci.o
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index fa7ba09dca77..fc1d4b146717 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -2796,6 +2796,9 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
>>          ctrl->oncs = le16_to_cpu(id->oncs);
>>          ctrl->mtfa = le16_to_cpu(id->mtfa);
>>          ctrl->oaes = le32_to_cpu(id->oaes);
>> +       ctrl->wctemp = le16_to_cpu(id->wctemp);
>> +       ctrl->cctemp = le16_to_cpu(id->cctemp);
>> +
>>          atomic_set(&ctrl->abort_limit, id->acl + 1);
>>          ctrl->vwc = id->vwc;
>>          if (id->mdts)
>> @@ -2897,6 +2900,8 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
>>
>>          ctrl->identified = true;
>>
>> +       nvme_hwmon_init(ctrl);
>> +
>>          return 0;
>>
>>   out_free:
> 
> The nvme_init_identify() can be called multiple time in nvme ctrl's
> lifetime (e.g 'nvme reset /dev/nvme*' or suspend/resume paths), so
> should we need to prevent nvme_hwmon_init() from registering hwmon
> device more than twice?
> 
> In the nvme thermal zone patchset[1], thernal zone is registered in
> nvme_init_identify and unregistered in nvme_stop_ctrl().
> 

Doesn't that mean that the initialization should happen in nvme_start_ctrl()
and not here ?

Either case, good point. Reason for calling the init function from here
is that I wanted to ensure that it is called after controller
identification. But then it is really undesirable to re-instantiate
the driver on each device reset. I'll have to think about that.

> [1] https://lore.kernel.org/linux-devicetree/1561990354-4084-2-git-send-email-akinobu.mita@gmail.com/
> 
>> diff --git a/drivers/nvme/host/nvme-hwmon.c b/drivers/nvme/host/nvme-hwmon.c
>> new file mode 100644
>> index 000000000000..af5eda326ec6
>> --- /dev/null
>> +++ b/drivers/nvme/host/nvme-hwmon.c
>> @@ -0,0 +1,163 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * NVM Express hardware monitoring support
>> + * Copyright (c) 2019, Guenter Roeck
>> + */
>> + >> +#include <linux/hwmon.h>
>> +
>> +#include "nvme.h"
>> +
>> +struct nvme_hwmon_data {
>> +       struct nvme_ctrl *ctrl;
>> +       struct nvme_smart_log log;
>> +};
>> +
>> +static int nvme_hwmon_get_smart_log(struct nvme_hwmon_data *data)
>> +{
>> +       return nvme_get_log(data->ctrl, NVME_NSID_ALL, NVME_LOG_SMART, 0,
>> +                           &data->log, sizeof(data->log), 0);
>> +}
> 
> The 'data->log' is allocated per nvme_ctrl, so are there any locks to
> prevent multiple callers of nvme_hwmon_get_smart_log() from breaking
> the log buffer?
> 
Good point. This needs either local memory like in your patch, or
I'll need a lock. I prefer a lock, though I am open to suggestions.

>> +
>> +static int nvme_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
>> +                          u32 attr, int channel, long *val)
>> +{
>> +       struct nvme_hwmon_data *data = dev_get_drvdata(dev);
>> +       struct nvme_smart_log *log = &data->log;
>> +       int err;
>> +       int temp;
>> +
>> +       err = nvme_hwmon_get_smart_log(data);
>> +       if (err)
>> +               return err < 0 ? err : -EPROTO;
>> +
>> +       switch (attr) {
>> +       case hwmon_temp_max:
>> +               *val = (data->ctrl->wctemp - 273) * 1000;
>> +               break;
>> +       case hwmon_temp_crit:
>> +               *val = (data->ctrl->cctemp - 273) * 1000;
>> +               break;
> 
> When this function is called with 'hwmon_temp_max' or 'hwmon_temp_crit',
> we don't need to call nvme_hwmon_get_smart_log() at all, do we?
> 

Another good point.

Thanks,
Guenter

>> +       case hwmon_temp_input:
>> +               if (!channel)
>> +                       temp = le16_to_cpup((__le16 *)log->temperature);
>> +               else
>> +                       temp = le16_to_cpu(log->temp_sensor[channel - 1]);
>> +               *val = (temp - 273) * 1000;
>> +               break;
>> +       case hwmon_temp_crit_alarm:
>> +               *val = !!(log->critical_warning & NVME_SMART_CRIT_TEMPERATURE);
>> +               break;
>> +       default:
>> +               err = -EOPNOTSUPP;
>> +               break;
>> +       }
>> +       return err;
>> +}
> 

