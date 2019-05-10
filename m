Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6451983B
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2019 08:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbfEJGIu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 May 2019 02:08:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35238 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbfEJGIu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 May 2019 02:08:50 -0400
Received: from mail-pf1-f200.google.com ([209.85.210.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hOyfG-0008Lw-Er
        for linux-pm@vger.kernel.org; Fri, 10 May 2019 06:05:50 +0000
Received: by mail-pf1-f200.google.com with SMTP id a141so3382086pfa.13
        for <linux-pm@vger.kernel.org>; Thu, 09 May 2019 23:05:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=h4iloC0KtdgJLw+SNGEEUmnBN4eoRDfhXPOMnZhH8Go=;
        b=RXO7iSAwORnjE2IvOgfhEohiUslH9CAu8Z1HpmmzrosVs0Yq1P84l1V/ZvuFURQ2bL
         /dhVUJEvmPHsc5LLH05+b8Vyr8gxk1IMGLNDfUzcqfW3xsCCn4d6yWn/FzrE9vuslyEs
         a3GTqZNlw3HaCmXHe0UrAbKi3cn4xd1jm4wcBvQO7KSnIeVpxCqrIv/TeHuAIeev2uZz
         qU7gAmwRsxgnI8LqqMw7qLfjbUyFEui8V2pKbtKrvGzRUN6Cf66BIcpyyEth9sen3sbS
         uuNZjv9pIPxLe33Ng74ykrOzWygPOzaoWNfjK97gURZhzyhH2HlCqfVFr+N6LI0zuoks
         x9Bw==
X-Gm-Message-State: APjAAAW4GxLJYJ49r4t7Oje5toimxPW5xoD4diAmkJli/RkLIv4VZqvz
        Zapr+9k7meLlmJ2n8+MBEV0KjQEpTUwaoHfo2DfZhtEdnTQ39M//lTZNk7IHK9bwI0taH2WjpyT
        mAVT2tRM+6tlMn16/iWm5I4fb7c+NTkg8lRCN
X-Received: by 2002:a17:902:84:: with SMTP id a4mr10873387pla.210.1557468348970;
        Thu, 09 May 2019 23:05:48 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxXPyaUtQNX07mwCNZ8kOnyUyv6UZtI2eN6ht8y+GbBqPCDNxHpJxPrJO5YXlmuD/in1wCC7Q==
X-Received: by 2002:a17:902:84:: with SMTP id a4mr10873365pla.210.1557468348655;
        Thu, 09 May 2019 23:05:48 -0700 (PDT)
Received: from 2001-b011-380f-14b9-e18f-0df6-9a4b-4e37.dynamic-ip6.hinet.net (2001-b011-380f-14b9-e18f-0df6-9a4b-4e37.dynamic-ip6.hinet.net. [2001:b011:380f:14b9:e18f:df6:9a4b:4e37])
        by smtp.gmail.com with ESMTPSA id u123sm8618461pfu.67.2019.05.09.23.05.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 23:05:48 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH] nvme-pci: Use non-operational power state instead of D3
 on Suspend-to-Idle
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <495d76c66aec41a8bfbbf527820f8eb9@AUSX13MPC101.AMER.DELL.COM>
Date:   Fri, 10 May 2019 14:05:42 +0800
Cc:     Keith Busch <kbusch@kernel.org>, hch@lst.de, axboe@fb.com,
        sagi@grimberg.me, rafael@kernel.org, linux-pm@vger.kernel.org,
        rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, keith.busch@intel.com
Content-Transfer-Encoding: 8bit
Message-Id: <BC5EB1D0-8718-48B3-ACAB-F7E5571D821D@canonical.com>
References: <064701C3-2BD4-4D93-891D-B7FBB5040FC4@canonical.com>
 <CAJZ5v0ggMwpJt=XWXu4gU51o8y4BpJ4KZ5RKzfk3+v8GGb-QbQ@mail.gmail.com>
 <A4DD2E9F-054E-4D4B-9F77-D69040EBE120@canonical.com>
 <20190509095601.GA19041@lst.de>
 <225CF4F7-C8E1-4C66-B362-97E84596A54E@canonical.com>
 <20190509103142.GA19550@lst.de>
 <AB325926-0D77-4851-8E8A-A10599756BF9@canonical.com>
 <31b7d7959bf94c15a04bab0ced518444@AUSX13MPC101.AMER.DELL.COM>
 <20190509192807.GB9675@localhost.localdomain>
 <7a002851c435481593f8629ec9193e40@AUSX13MPC101.AMER.DELL.COM>
 <20190509215409.GD9675@localhost.localdomain>
 <495d76c66aec41a8bfbbf527820f8eb9@AUSX13MPC101.AMER.DELL.COM>
To:     Mario.Limonciello@dell.com
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

at 06:19, <Mario.Limonciello@dell.com> <Mario.Limonciello@dell.com> wrote:

>> -----Original Message-----
>> From: Keith Busch <kbusch@kernel.org>
>> Sent: Thursday, May 9, 2019 4:54 PM
>> To: Limonciello, Mario
>> Cc: kai.heng.feng@canonical.com; hch@lst.de; axboe@fb.com;
>> sagi@grimberg.me; rafael@kernel.org; linux-pm@vger.kernel.org;
>> rafael.j.wysocki@intel.com; linux-kernel@vger.kernel.org; linux-
>> nvme@lists.infradead.org; keith.busch@intel.com
>> Subject: Re: [PATCH] nvme-pci: Use non-operational power state instead  
>> of D3 on
>> Suspend-to-Idle
>>
>>
>> [EXTERNAL EMAIL]
>>
>> On Thu, May 09, 2019 at 09:37:58PM +0000, Mario.Limonciello@dell.com  
>> wrote:
>>>> +int nvme_set_power(struct nvme_ctrl *ctrl, unsigned npss)
>>>> +{
>>>> +	int ret;
>>>> +
>>>> +	mutex_lock(&ctrl->scan_lock);
>>>> +	nvme_start_freeze(ctrl);
>>>> +	nvme_wait_freeze(ctrl);
>>>> +	ret = nvme_set_features(ctrl, NVME_FEAT_POWER_MGMT, npss, NULL, 0,
>>>> +				NULL);
>>>> +	nvme_unfreeze(ctrl);
>>>> +	mutex_unlock(&ctrl->scan_lock);
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(nvme_set_power);
>>>
>>> I believe without memory barriers at the end disks with HMB this will
>>> still kernel panic (Such as Toshiba BG3).
>>
>> Well, the mutex has an implied memory barrier, but your HMB explanation
>> doesn't make much sense to me anyway. The "mb()" in this thread's original
>> patch is a CPU memory barrier, and the CPU had better not be accessing
>> HMB memory. Is there something else going on here?
>
> Kai Heng will need to speak up a bit in his time zone as he has this disk  
> on hand,
> but what I recall from our discussion was that DMA operation MemRd after
> resume was the source of the hang.

Yes, that’ what I was told by the NVMe vendor, so all I know is to impose a  
memory barrier.
If mb() shouldn’t be used here, what’s the correct variant to use in this  
context?

>
>>> This still allows D3 which we found at least failed to go into deepest  
>>> state and
>> blocked
>>> platform s0ix for the following SSDs (maybe others):
>>> Hynix PC601
>>> LiteOn CL1
>>
>> We usually write features to spec first, then quirk non-compliant
>> devices after.
>
> NVME spec doesn't talk about a relationship between SetFeatures w/
> NVME_FEAT_POWER_MGMGT and D3 support, nor order of events.
>
> This is why we opened a dialog with storage vendors, including  
> contrasting the behavior
> of Microsoft Windows inbox NVME driver and Intel's Windows RST driver.
>
> Those two I mention that come to mind immediately because they were most  
> recently
> tested to fail.  Our discussion with storage vendors overwhelmingly  
> requested
> that we don't use D3 under S2I because their current firmware  
> architecture won't
> support it.
>
> For example one vendor told us with current implementation that receiving  
> D3hot
> after NVME shutdown will prevent being able to enter L1.2.  D3hot entry  
> was supported
> by an IRQ handler that isn't serviced in NVME shutdown state.
>
> Another vendor told us that with current implementation it's impossible  
> to transition
> to PS4 (at least via APST) while L1.2 D3hot is active.

I tested the patch from Keith and it has two issues just as simply skipping  
nvme_dev_disable():
1) It consumes more power in S2I
2) System freeze after resume

Also I don’t think it’s a spec. It’s a guide to let OEM/ODM pick and  
assemble Modern Standby compliant machines, so what Windows NVMe driver  
really does is still opaque to us.

Kai-Heng


