Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1061254AAE5
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jun 2022 09:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354074AbiFNHtA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jun 2022 03:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351773AbiFNHs7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jun 2022 03:48:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E42153E5D7
        for <linux-pm@vger.kernel.org>; Tue, 14 Jun 2022 00:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655192937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p+wrdfuMBKazwT1cY4RvGcWmJDzmwuDS6uqWLtKiUfE=;
        b=IIjvIQIo0b4/slD68YR7n73NVoMiMwJr5SDoalKdcL0d/rkeeqegwmzRjIbDKF7OuenPcA
        wCEOBT2p09N7W0l/ohsmX0ZpBPJWHyPrRgEXR5IDhGj6sCbSNJCK4tZ367sC7kJwF3b4Fk
        dFBrFDUuZ9LrHTYd0LthJsxc58OAKpA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-528-4fwtt90OOBmlDGWDtDQvWg-1; Tue, 14 Jun 2022 03:48:55 -0400
X-MC-Unique: 4fwtt90OOBmlDGWDtDQvWg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AF52A8041BD;
        Tue, 14 Jun 2022 07:48:54 +0000 (UTC)
Received: from [10.39.194.250] (unknown [10.39.194.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1D770492C3B;
        Tue, 14 Jun 2022 07:48:52 +0000 (UTC)
Message-ID: <9bc97629-8680-75f3-7cca-c6029a9235fa@redhat.com>
Date:   Tue, 14 Jun 2022 09:48:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 00/12] platform/surface: aggregator: Add support for
 client hot-removal
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Mark Gross <markgross@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-doc@vger.kernel.org
References: <20220527023447.2460025-1-luzmaximilian@gmail.com>
 <23f92ec3-a739-6ee7-10f9-f66b17ae6088@redhat.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
In-Reply-To: <23f92ec3-a739-6ee7-10f9-f66b17ae6088@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 6/13/22 17:27, Hans de Goede wrote:
> Hi,
> 
> On 5/27/22 04:34, Maximilian Luz wrote:
>> Summary:
>>
>>    Add support for the HID type cover input devices on the Pro 8 and all
>>    requirements for that.
>>
>>
>> Blurb from v1:
>>
>>    This series adds support for the type cover of the Surface Pro 8. On
>>    the Pro 8, the type cover is (unlike on previous generations) handled
>>    via the Surface System Aggregator Module (SSAM). As the type cover is
>>    detachable, care needs to be taken and the respective SSAM (HID)
>>    client devices need to be properly removed when detached and
>>    re-initialized when attached.
>>    
>>    Therefore, this series does three things:
>>    
>>     1. Improve hot-removal support for SSAM client devices. When
>>        hot-removing clients, subsequent communication may time out.
>>    
>>        In the worst case, this can lead to problems when devices are
>>        detached and re-attached quickly, before we can remove their
>>        respective kernel representations. This can then lead to devices
>>        being in an uninitialized state, preventing, for example, touchpad
>>        gestures from working properly as the required HID feature report
>>        has not been sent.
>>    
>>        Therefore, handle hot-removal of devices more gracefully by
>>        avoiding communication once it has been detected and ensure that
>>        devices are actually removed.
>>     
>>     2. Generify SSAM subsystem hubs and add a KIP hub. On the Surface Pro
>>        8, the KIP subsystem (only that abbreviation is known) is
>>        responsible for managing type-cover devices. This hub acts as the
>>        controller for device removal similar to the BAS (detachable base)
>>        subsystem hub on the Surface Book 3 (therefore we can share most
>>        of the code between them).
>>    
>>     3. Add the (HID) type-cover clients of the Surface Pro 8 to the
>>        aggregator registry.
>>
>>
>> Changes in v2:
>>
>>   - Introduce "platform/surface: aggregator: Allow is_ssam_device() to be
>>     used when CONFIG_SURFACE_AGGREGATOR_BUS is disabled" to fix an
>>     undefined reference  build issue when CONFIG_SURFACE_AGGREGATOR_BUS
>>     is disabled.
>>
>>   - Make SSAM hub device UIDs consistent.
>>      - Introduce "platform/surface: aggregator_registry: Change device ID
>>        for base hub" to make association between hub and subsystem target
>>        category more obvious.
>>      - Change hub device ID for KIP subsystem hub to be consistent with
>>        the id of the already existing BAS hub.
> 
> Thank you for your patch-series, I've applied the series to my
> review-hans branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans
> 
> Once I've run some tests on this branch the patches there will be
> added to the platform-drivers-x86/for-next branch and eventually
> will be included in the pdx86 pull-request to Linus for the next
> merge-window.
> 
> Jiri, Benjamin, note I've also taken the one small(ish) HID patch
> which is a part of this series, despite it lacking an Ack from
> either of you. I hope this is ok, if not let me know.

Sorry I am well behind on my patch processing.

The patch is simple enough and if you reviewed the rest, that is fine by me.

Just for the archives:
For the HID part
Acked-by: Benjamin Tissoires <benjamin.tisssoires@redhat.com>

(no need to force push your branch unless you think it's really 
important to have my ack).

Cheers,
Benjamin

> 
> Regards,
> 
> Hans
> 
> 
> 
> 
>> Maximilian Luz (12):
>>    platform/surface: aggregator: Allow is_ssam_device() to be used when
>>      CONFIG_SURFACE_AGGREGATOR_BUS is disabled
>>    platform/surface: aggregator: Allow devices to be marked as
>>      hot-removed
>>    platform/surface: aggregator: Allow notifiers to avoid communication
>>      on unregistering
>>    platform/surface: aggregator_registry: Use client device wrappers for
>>      notifier registration
>>    power/supply: surface_charger: Use client device wrappers for notifier
>>      registration
>>    power/supply: surface_battery: Use client device wrappers for notifier
>>      registration
>>    HID: surface-hid: Add support for hot-removal
>>    platform/surface: aggregator: Add comment for KIP subsystem category
>>    platform/surface: aggregator_registry: Generify subsystem hub
>>      functionality
>>    platform/surface: aggregator_registry: Change device ID for base hub
>>    platform/surface: aggregator_registry: Add KIP device hub
>>    platform/surface: aggregator_registry: Add support for keyboard cover
>>      on Surface Pro 8
>>
>>   .../driver-api/surface_aggregator/client.rst  |   6 +-
>>   drivers/hid/surface-hid/surface_hid_core.c    |  38 +-
>>   .../platform/surface/aggregator/controller.c  |  53 ++-
>>   .../surface/surface_aggregator_registry.c     | 403 +++++++++++++-----
>>   drivers/power/supply/surface_battery.c        |   4 +-
>>   drivers/power/supply/surface_charger.c        |   4 +-
>>   include/linux/surface_aggregator/controller.h |  24 +-
>>   include/linux/surface_aggregator/device.h     | 125 +++++-
>>   include/linux/surface_aggregator/serial_hub.h |   2 +-
>>   9 files changed, 513 insertions(+), 146 deletions(-)
>>
> 

