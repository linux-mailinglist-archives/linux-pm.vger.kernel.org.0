Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8C333D075E
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jul 2021 05:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbhGUCtc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Jul 2021 22:49:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32984 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231363AbhGUCtb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Jul 2021 22:49:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626838208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k05rJ04IU9dEG8xbaeJSAOzZNy8JTOVIRfo0vVOjOCg=;
        b=UkrQAPY/jJJBP7IhjgyWmTvbkFxAnwKlONODMGHTpjbG14cFAtDREsLYAMEWKPzvUbCaeu
        qkdS4IMQJXcDLPOYDhttPJMTOLlGxf6nN2Bs5KMyFmoNntNru5d8IcKht8AMnnGubPHYYt
        kNnJPHioxad/MoAhuD6i3+HpGkXR+tA=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-PNcotGnhPeO958BhZ5wxPA-1; Tue, 20 Jul 2021 23:30:07 -0400
X-MC-Unique: PNcotGnhPeO958BhZ5wxPA-1
Received: by mail-pf1-f199.google.com with SMTP id s5-20020aa78d450000b02902ace63a7e93so966670pfe.8
        for <linux-pm@vger.kernel.org>; Tue, 20 Jul 2021 20:30:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=k05rJ04IU9dEG8xbaeJSAOzZNy8JTOVIRfo0vVOjOCg=;
        b=W6dEOnA80LpgkRjOth3fcb18Tb29CX9C0TRn8Dv4lUAR8zP+I01oSBZanv/O3dLQfJ
         5S+2hKxiI5yDUpWdClvrW0sW9ltHrPUlGjqSlrDCZOhDxA17d7/1lWT7IffEq59Akaw3
         ho53HYobIhNNG82eIgFuNG4eGQkeB6NsGOClVBFCEhBdBaFgpdMLGcZbjVfRyeht6fSe
         J1fKQS16YWNzb0hAxMDFJtK2ihd46sGLYT+S66caelmWXHONhOli2BEcoKO5rgQxP7Yt
         VtI/n2zi7APCsKKn7tLlmHdcdDkI/d5ULE4UIMGd0CKSNqdqbZ90PQLfiEr5T62goV4J
         TBlw==
X-Gm-Message-State: AOAM533F80ZWbt4wJ53QWFIJix2JYaLw/4YgHZkn/5eVsHl/jCA0EisD
        VHREKEMztp1q2yV5MXA57Wh2v71qqx8tByjZh1XoNaAIB13NlCKefj4UqIX63qe7KEStmZ1IEN7
        CNQTa+F3bNyIdKZK9WJc=
X-Received: by 2002:a17:90a:17eb:: with SMTP id q98mr1637498pja.183.1626838206005;
        Tue, 20 Jul 2021 20:30:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyESsAEWCDLWvcTfXZOmxCYVAakGzjamKbkQkgTTty1VuN8o5+HezI8WKMk3qXoufEpH/sFbw==
X-Received: by 2002:a17:90a:17eb:: with SMTP id q98mr1637476pja.183.1626838205751;
        Tue, 20 Jul 2021 20:30:05 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id w14sm30244343pgo.75.2021.07.20.20.30.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jul 2021 20:30:05 -0700 (PDT)
Subject: Re: [RFC 0/3] cpuidle: add poll_source API and virtio vq polling
To:     Stefan Hajnoczi <stefanha@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Ming Lei <ming.lei@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        virtualization@lists.linux-foundation.org,
        linux-pm@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
References: <20210713161906.457857-1-stefanha@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <1008dee4-fce1-2462-1520-f5432bc89a07@redhat.com>
Date:   Wed, 21 Jul 2021 11:29:55 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210713161906.457857-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


在 2021/7/14 上午12:19, Stefan Hajnoczi 写道:
> These patches are not polished yet but I would like request feedback on this
> approach and share performance results with you.
>
> Idle CPUs tentatively enter a busy wait loop before halting when the cpuidle
> haltpoll driver is enabled inside a virtual machine. This reduces wakeup
> latency for events that occur soon after the vCPU becomes idle.
>
> This patch series extends the cpuidle busy wait loop with the new poll_source
> API so drivers can participate in polling. Such polling-aware drivers disable
> their device's irq during the busy wait loop to avoid the cost of interrupts.
> This reduces latency further than regular cpuidle haltpoll, which still relies
> on irqs.
>
> Virtio drivers are modified to use the poll_source API so all virtio device
> types get this feature. The following virtio-blk fio benchmark results show the
> improvement:
>
>               IOPS (numjobs=4, iodepth=1, 4 virtqueues)
>                 before   poll_source      io_poll
> 4k randread    167102  186049 (+11%)  186654 (+11%)
> 4k randwrite   162204  181214 (+11%)  181850 (+12%)
> 4k randrw      159520  177071 (+11%)  177928 (+11%)
>
> The comparison against io_poll shows that cpuidle poll_source achieves
> equivalent performance to the block layer's io_poll feature (which I
> implemented in a separate patch series [1]).
>
> The advantage of poll_source is that applications do not need to explicitly set
> the RWF_HIPRI I/O request flag. The poll_source approach is attractive because
> few applications actually use RWF_HIPRI and it takes advantage of CPU cycles we
> would have spent in cpuidle haltpoll anyway.
>
> The current series does not improve virtio-net. I haven't investigated deeply,
> but it is possible that NAPI and poll_source do not combine. See the final
> patch for a starting point on making the two work together.
>
> I have not tried this on bare metal but it might help there too. The cost of
> disabling a device's irq must be less than the savings from avoiding irq
> handling for this optimization to make sense.
>
> [1] https://lore.kernel.org/linux-block/20210520141305.355961-1-stefanha@redhat.com/


Hi Stefan:

Some questions:

1) What's the advantages of introducing polling at virtio level instead 
of doing it at each subsystems? Polling in virtio level may only work 
well if all (or most) of the devices are virtio
2) What's the advantages of using cpuidle instead of using a thread (and 
leverage the scheduler)?
3) Any reason it's virtio_pci specific not a general virtio one?

Thanks

(Btw, do we need to cc scheduler guys?)


>
> Stefan Hajnoczi (3):
>    cpuidle: add poll_source API
>    virtio: add poll_source virtqueue polling
>    softirq: participate in cpuidle polling
>
>   drivers/cpuidle/Makefile           |   1 +
>   drivers/virtio/virtio_pci_common.h |   7 ++
>   include/linux/interrupt.h          |   2 +
>   include/linux/poll_source.h        |  53 +++++++++++++++
>   include/linux/virtio.h             |   2 +
>   include/linux/virtio_config.h      |   2 +
>   drivers/cpuidle/poll_source.c      | 102 +++++++++++++++++++++++++++++
>   drivers/cpuidle/poll_state.c       |   6 ++
>   drivers/virtio/virtio.c            |  34 ++++++++++
>   drivers/virtio/virtio_pci_common.c |  86 ++++++++++++++++++++++++
>   drivers/virtio/virtio_pci_modern.c |   2 +
>   kernel/softirq.c                   |  14 ++++
>   12 files changed, 311 insertions(+)
>   create mode 100644 include/linux/poll_source.h
>   create mode 100644 drivers/cpuidle/poll_source.c
>

