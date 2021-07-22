Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFD43D2051
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jul 2021 11:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbhGVIYj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Jul 2021 04:24:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34063 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230330AbhGVIYg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Jul 2021 04:24:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626944710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=613H4wAGuEnZg548mMLIz3DNJ0VmDXrroK5bj+IIg9Q=;
        b=Z6amGgMpJWyGu9uXdYbWbvnlys+Fd9XZTxqSadFj9GGEfWOGvzOW8FE/EWmOMHsiWDFCZb
        KPQGYNvvz5GLLPoH+lvPKEfNtOa5scWyWfuIYnt7bjxmvRgi5iHveAB/K5ZxvMr8rNP1tF
        FbrOt/R7r4nOtXWPXWhsfThZJz+QJw0=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-519-O3tu80j3NBymrJdvvWL7pQ-1; Thu, 22 Jul 2021 05:05:08 -0400
X-MC-Unique: O3tu80j3NBymrJdvvWL7pQ-1
Received: by mail-pl1-f199.google.com with SMTP id n11-20020a170902e54bb029012b5431cb04so2415211plf.12
        for <linux-pm@vger.kernel.org>; Thu, 22 Jul 2021 02:05:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=613H4wAGuEnZg548mMLIz3DNJ0VmDXrroK5bj+IIg9Q=;
        b=LPu/pHpbMfZe8pzrfUY38EKI0RNV5RF59kJv4FuBdb87X+ACNrlMcs4uLMkzuRZHEF
         kX0VIKGFjN4lG14KKJS5DYv3+fNvkeBcEvMN4rOcg2A+Qf91nWsTUeSjApCovCGMZSMz
         avomf9eVzExouPI2D/07kRfATx6VLf38X2i631AN14SoKGU0R3tPquoAac9VfFlRSuek
         ouGcA/u3h8gPS07R+Rey4ZOAm35FZKilcCW72CYms8nVwtUTYxD2A60b0Ck0swfMilIa
         7fUga7l/ehqahXwtMWaw4nsQTLGWmzZvXT9M4srlBHvGbpnyzbMl7bb2gEWpu9d4OPGm
         ITyg==
X-Gm-Message-State: AOAM532DPx62GnoP3X0vxR/SbOFLzlXDaq3hgN18V6ugtKwwI5L0GNdL
        GgMIeqbl6NuTGfk77bJx6x0bONo9/odHhXnSFU2ECfZsUD40qcoVDw7cjH+qWgaJXKZJ+2y9pGd
        rnZHle9Bw/dbBTAZ+CCM=
X-Received: by 2002:a63:1658:: with SMTP id 24mr12874148pgw.307.1626944707782;
        Thu, 22 Jul 2021 02:05:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy0+x8zNhuoIB4bhgvnGT/Lauq7S1tovNJXVfSEHqXJ8wvxOVkqIxFpT/VtggSDtTXoyT+32Q==
X-Received: by 2002:a63:1658:: with SMTP id 24mr12874128pgw.307.1626944707458;
        Thu, 22 Jul 2021 02:05:07 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id t3sm4781930pfd.153.2021.07.22.02.05.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jul 2021 02:05:07 -0700 (PDT)
Subject: Re: [RFC 0/3] cpuidle: add poll_source API and virtio vq polling
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Ming Lei <ming.lei@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        virtualization@lists.linux-foundation.org,
        linux-pm@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
References: <20210713161906.457857-1-stefanha@redhat.com>
 <1008dee4-fce1-2462-1520-f5432bc89a07@redhat.com>
 <YPfryV7qZVRbjNgP@stefanha-x1.localdomain>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <869a993d-a1b0-1c39-d081-4cdd2b71041f@redhat.com>
Date:   Thu, 22 Jul 2021 17:04:57 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YPfryV7qZVRbjNgP@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


在 2021/7/21 下午5:41, Stefan Hajnoczi 写道:
> On Wed, Jul 21, 2021 at 11:29:55AM +0800, Jason Wang wrote:
>> 在 2021/7/14 上午12:19, Stefan Hajnoczi 写道:
>>> These patches are not polished yet but I would like request feedback on this
>>> approach and share performance results with you.
>>>
>>> Idle CPUs tentatively enter a busy wait loop before halting when the cpuidle
>>> haltpoll driver is enabled inside a virtual machine. This reduces wakeup
>>> latency for events that occur soon after the vCPU becomes idle.
>>>
>>> This patch series extends the cpuidle busy wait loop with the new poll_source
>>> API so drivers can participate in polling. Such polling-aware drivers disable
>>> their device's irq during the busy wait loop to avoid the cost of interrupts.
>>> This reduces latency further than regular cpuidle haltpoll, which still relies
>>> on irqs.
>>>
>>> Virtio drivers are modified to use the poll_source API so all virtio device
>>> types get this feature. The following virtio-blk fio benchmark results show the
>>> improvement:
>>>
>>>                IOPS (numjobs=4, iodepth=1, 4 virtqueues)
>>>                  before   poll_source      io_poll
>>> 4k randread    167102  186049 (+11%)  186654 (+11%)
>>> 4k randwrite   162204  181214 (+11%)  181850 (+12%)
>>> 4k randrw      159520  177071 (+11%)  177928 (+11%)
>>>
>>> The comparison against io_poll shows that cpuidle poll_source achieves
>>> equivalent performance to the block layer's io_poll feature (which I
>>> implemented in a separate patch series [1]).
>>>
>>> The advantage of poll_source is that applications do not need to explicitly set
>>> the RWF_HIPRI I/O request flag. The poll_source approach is attractive because
>>> few applications actually use RWF_HIPRI and it takes advantage of CPU cycles we
>>> would have spent in cpuidle haltpoll anyway.
>>>
>>> The current series does not improve virtio-net. I haven't investigated deeply,
>>> but it is possible that NAPI and poll_source do not combine. See the final
>>> patch for a starting point on making the two work together.
>>>
>>> I have not tried this on bare metal but it might help there too. The cost of
>>> disabling a device's irq must be less than the savings from avoiding irq
>>> handling for this optimization to make sense.
>>>
>>> [1] https://lore.kernel.org/linux-block/20210520141305.355961-1-stefanha@redhat.com/
>>
>> Hi Stefan:
>>
>> Some questions:
>>
>> 1) What's the advantages of introducing polling at virtio level instead of
>> doing it at each subsystems? Polling in virtio level may only work well if
>> all (or most) of the devices are virtio
> I'm not sure I understand the question. cpuidle haltpoll benefits all
> devices today, except it incurs interrupt latency. The poll_source API
> eliminates the interrupt latency for drivers that can disable device
> interrupts cheaply.
>
> This patch adds poll_source to core virtio code so that all virtio
> drivers get this feature for free. No driver-specific changes are
> needed.
>
> If you mean networking, block layer, etc by "subsystems" then there's
> nothing those subsystems can do to help. Whether poll_source can be used
> depends on the specific driver, not the subsystem. If you consider
> drivers/virtio/ a subsystem, then that's exactly what the patch series
> is doing.


I meant, if we choose to use idle poll, we have some several choices:

1) bus level (e.g the virtio)
2) subsystem level (e.g the networking and block)

I'm not sure which one is better.


>
>> 2) What's the advantages of using cpuidle instead of using a thread (and
>> leverage the scheduler)?
> In order to combine with the existing cpuidle infrastructure. No new
> polling loop is introduced and no additional CPU cycles are spent on
> polling.
>
> If cpuidle itself is converted to threads then poll_source would
> automatically operate in a thread too, but this patch series doesn't
> change how the core cpuidle code works.


So networking subsystem can use NAPI busy polling in the process context 
which means it can be leveraged by the scheduler.

I'm not sure it's a good idea to poll drivers for a specific bus in the 
general cpu idle layer.

Another questions, are those numbers measured by APICV capable machine?

Virtio-net turns on the tx interrupts since 2 years ago. And we don't 
see too much difference when measured with a APICV host.


>
>> 3) Any reason it's virtio_pci specific not a general virtio one?
> Good idea, it is possible to move the virtio_pci changes into virtio.c.
>
> Other transports can't use this feature yet though. Only virtio_pci
> supports vq irq affinity. But the code can be generic and if other
> transports ever support vq irq affinity they'll get it for free.


Yes.

Thanks


>
>> (Btw, do we need to cc scheduler guys?)
> I'm not sure. This patch series doesn't change how cpuidle interacts
> with the scheduler. The cpuidle maintainers can pull in more people, if
> necessary.
>
> Stefan

