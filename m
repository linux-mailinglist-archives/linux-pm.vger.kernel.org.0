Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90DCB549BDA
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jun 2022 20:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245601AbiFMSlF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jun 2022 14:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344062AbiFMSkc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jun 2022 14:40:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4953962CE2
        for <linux-pm@vger.kernel.org>; Mon, 13 Jun 2022 08:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655134052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=349ItO45Tva+Eg6mNSQZ8gAgx0dNkmVf6n7IrTnPg/k=;
        b=DKD2aMRYWxq/AN3Jrp9y8znBjc4DORo9JLcRxmPegXEzXJlPUgxB5hgNbe43SAZ39/UMl2
        bEwLOk1n7fO1k8aK2STvniE0HcHBDQaPx35XiPJgU3jK9U4s9xfOCyVex/hvlu+3/N8Nez
        fGa1RzrvJSBcVE6fHxifBtoVb0q2jTE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-479-anIiA9ouOmKnLp7RI2ngrw-1; Mon, 13 Jun 2022 11:27:31 -0400
X-MC-Unique: anIiA9ouOmKnLp7RI2ngrw-1
Received: by mail-ed1-f69.google.com with SMTP id cy18-20020a0564021c9200b0042dc7b4f36fso4186966edb.4
        for <linux-pm@vger.kernel.org>; Mon, 13 Jun 2022 08:27:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=349ItO45Tva+Eg6mNSQZ8gAgx0dNkmVf6n7IrTnPg/k=;
        b=fPy+tZCaiUOBMPEdFcMOb+VeGdzJAXcvhdjCnggzOFOqh54Rq5Ai/megGv9m+tKc+R
         nr7jX/3CxOoFGRQIGcA9S7fiEYaF/893D+qoq7aP2OBb1iJJ681HwJlncomI8ZrECPci
         tTZw9t3Kgp/jT5vu81YpL55XANUrOkGJ/Zpk9v7v8UMF9pxZutbWicJdq4tW0o0fLydR
         /EvoqS0oDarZAsCK1XIGVMYcHwvj0RLa4yx5ej5wm67aowW6r3Lt3CYD8FueeCnOCj3P
         tlbm1/i3Vr+yUra916GdKJIBHw2ffLvUntuLq8htWeD/5QxycchPPB7ZA/5yzUCzoZHI
         P+KQ==
X-Gm-Message-State: AOAM533+km/5e+LZwaoQx2Eo0kH6HshUxG5h1P5Lm51gA3ABAqOrPlYs
        CULxYLk78jPp8uoYLGTrvKwgKm3tYEXgsX3ikiJ7X+P9DaVYYxa0pneMb9s3lh5qHbhfwkunccg
        7BQpNQ/3O3HFQLbnE8ik=
X-Received: by 2002:a17:906:2c4d:b0:70f:ede5:d456 with SMTP id f13-20020a1709062c4d00b0070fede5d456mr373618ejh.366.1655134049914;
        Mon, 13 Jun 2022 08:27:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJybsNmkzlGzyyL4shgHdKlEEvyjK/FcnSjJ/CLCJb6gofvFDki+1kMsAbYEIwlvSuuJGGJGfA==
X-Received: by 2002:a17:906:2c4d:b0:70f:ede5:d456 with SMTP id f13-20020a1709062c4d00b0070fede5d456mr373604ejh.366.1655134049710;
        Mon, 13 Jun 2022 08:27:29 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id h20-20020a056402281400b0042dd05edeedsm5226591ede.17.2022.06.13.08.27.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 08:27:29 -0700 (PDT)
Message-ID: <23f92ec3-a739-6ee7-10f9-f66b17ae6088@redhat.com>
Date:   Mon, 13 Jun 2022 17:27:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 00/12] platform/surface: aggregator: Add support for
 client hot-removal
Content-Language: en-US
To:     Maximilian Luz <luzmaximilian@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Mark Gross <markgross@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-doc@vger.kernel.org
References: <20220527023447.2460025-1-luzmaximilian@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220527023447.2460025-1-luzmaximilian@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 5/27/22 04:34, Maximilian Luz wrote:
> Summary:
> 
>   Add support for the HID type cover input devices on the Pro 8 and all
>   requirements for that.
> 
> 
> Blurb from v1:
> 
>   This series adds support for the type cover of the Surface Pro 8. On
>   the Pro 8, the type cover is (unlike on previous generations) handled
>   via the Surface System Aggregator Module (SSAM). As the type cover is
>   detachable, care needs to be taken and the respective SSAM (HID)
>   client devices need to be properly removed when detached and
>   re-initialized when attached.
>   
>   Therefore, this series does three things:
>   
>    1. Improve hot-removal support for SSAM client devices. When
>       hot-removing clients, subsequent communication may time out.
>   
>       In the worst case, this can lead to problems when devices are
>       detached and re-attached quickly, before we can remove their
>       respective kernel representations. This can then lead to devices
>       being in an uninitialized state, preventing, for example, touchpad
>       gestures from working properly as the required HID feature report
>       has not been sent.
>   
>       Therefore, handle hot-removal of devices more gracefully by
>       avoiding communication once it has been detected and ensure that
>       devices are actually removed.
>    
>    2. Generify SSAM subsystem hubs and add a KIP hub. On the Surface Pro
>       8, the KIP subsystem (only that abbreviation is known) is
>       responsible for managing type-cover devices. This hub acts as the
>       controller for device removal similar to the BAS (detachable base)
>       subsystem hub on the Surface Book 3 (therefore we can share most
>       of the code between them).
>   
>    3. Add the (HID) type-cover clients of the Surface Pro 8 to the
>       aggregator registry.
> 
> 
> Changes in v2:
> 
>  - Introduce "platform/surface: aggregator: Allow is_ssam_device() to be
>    used when CONFIG_SURFACE_AGGREGATOR_BUS is disabled" to fix an
>    undefined reference  build issue when CONFIG_SURFACE_AGGREGATOR_BUS
>    is disabled.
> 
>  - Make SSAM hub device UIDs consistent.
>     - Introduce "platform/surface: aggregator_registry: Change device ID
>       for base hub" to make association between hub and subsystem target
>       category more obvious.
>     - Change hub device ID for KIP subsystem hub to be consistent with
>       the id of the already existing BAS hub.

Thank you for your patch-series, I've applied the series to my
review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Jiri, Benjamin, note I've also taken the one small(ish) HID patch
which is a part of this series, despite it lacking an Ack from
either of you. I hope this is ok, if not let me know.

Regards,

Hans




> Maximilian Luz (12):
>   platform/surface: aggregator: Allow is_ssam_device() to be used when
>     CONFIG_SURFACE_AGGREGATOR_BUS is disabled
>   platform/surface: aggregator: Allow devices to be marked as
>     hot-removed
>   platform/surface: aggregator: Allow notifiers to avoid communication
>     on unregistering
>   platform/surface: aggregator_registry: Use client device wrappers for
>     notifier registration
>   power/supply: surface_charger: Use client device wrappers for notifier
>     registration
>   power/supply: surface_battery: Use client device wrappers for notifier
>     registration
>   HID: surface-hid: Add support for hot-removal
>   platform/surface: aggregator: Add comment for KIP subsystem category
>   platform/surface: aggregator_registry: Generify subsystem hub
>     functionality
>   platform/surface: aggregator_registry: Change device ID for base hub
>   platform/surface: aggregator_registry: Add KIP device hub
>   platform/surface: aggregator_registry: Add support for keyboard cover
>     on Surface Pro 8
> 
>  .../driver-api/surface_aggregator/client.rst  |   6 +-
>  drivers/hid/surface-hid/surface_hid_core.c    |  38 +-
>  .../platform/surface/aggregator/controller.c  |  53 ++-
>  .../surface/surface_aggregator_registry.c     | 403 +++++++++++++-----
>  drivers/power/supply/surface_battery.c        |   4 +-
>  drivers/power/supply/surface_charger.c        |   4 +-
>  include/linux/surface_aggregator/controller.h |  24 +-
>  include/linux/surface_aggregator/device.h     | 125 +++++-
>  include/linux/surface_aggregator/serial_hub.h |   2 +-
>  9 files changed, 513 insertions(+), 146 deletions(-)
> 

