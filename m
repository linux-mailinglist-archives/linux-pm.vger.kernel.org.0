Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 300E36473DD
	for <lists+linux-pm@lfdr.de>; Thu,  8 Dec 2022 17:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiLHQE4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Dec 2022 11:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbiLHQEu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Dec 2022 11:04:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CA29E451
        for <linux-pm@vger.kernel.org>; Thu,  8 Dec 2022 08:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670515423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IXsbEpWWvRn6V4K4AQAglneXzBPO0+xjG/LZYZe3/qc=;
        b=aCUXyWM2Tl9O5basoVv0Ce6Nhoig2Xogj/p8vsmNwtNfrsKqiZaF+l3s6cDNpmyfJO5Tf2
        tOqhqPTtJPT0uZ4xaCWEucK3AU13J3wWw1X1q1FEwB8xJZSzqdTUj5GPD8fJfIwj0jxiRe
        xQzC58lL+X+IecvtRIOTLU/3EA1pLHQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-22-6F_711LqOPepxE5miJI-9A-1; Thu, 08 Dec 2022 11:03:41 -0500
X-MC-Unique: 6F_711LqOPepxE5miJI-9A-1
Received: by mail-ej1-f69.google.com with SMTP id hq42-20020a1709073f2a00b007c100387d64so1434045ejc.3
        for <linux-pm@vger.kernel.org>; Thu, 08 Dec 2022 08:03:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IXsbEpWWvRn6V4K4AQAglneXzBPO0+xjG/LZYZe3/qc=;
        b=ULXartzniRUi6A1Ky9XimW0j5ExyAVbioLfAuQklI275PMsIRc78w2NsRuDBUSDDc1
         Plq9IWUcqWBqKLXOluMDUgeFJBnmUeHYmgdinwuX1QudKHasIVvfp/1VW4xTrimmRnRG
         5c1cadoORSIMgNRFcymS6bF1B1IOJyG3q0Mepr+709A8oekGr+W1+TJk5owB9wHPctJ/
         uQFPLObKXuhjBheDzGKIsmQt+IIU8P/ogdtgv5+sX91Rvc8OMzYO+r9QGygsGOO70d0V
         wZWvTCcXFSfJyP5MjfwqJH7CVL/lDiyJDlCJWjowtatS+uivWYitMATDcHDNkLxeSMJK
         OVDQ==
X-Gm-Message-State: ANoB5pnZ3ZExzaKm2liIF6D0+vb24zCZnJdBgSFwlCyGLFBNOzyqNgYn
        8RVsa2K5ZDTm/x6Hp8U+9iv5kIi8/LO+vPdcT5dhbO/Lb64ybhHd9AsPjh4KqAiRRNhuwBpCiNN
        gohGak0Tq/BK2X3Elqc8=
X-Received: by 2002:a17:906:c51:b0:7b2:91e8:1553 with SMTP id t17-20020a1709060c5100b007b291e81553mr2320256ejf.20.1670515420125;
        Thu, 08 Dec 2022 08:03:40 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6uLmr2ps/eoyIFTKExf/xJaLtd19e4nt+MMsCSb4MkIRG9XBk/nHAPLf9ph+m7OFZKDow9IA==
X-Received: by 2002:a17:906:c51:b0:7b2:91e8:1553 with SMTP id t17-20020a1709060c5100b007b291e81553mr2320247ejf.20.1670515419917;
        Thu, 08 Dec 2022 08:03:39 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id fe17-20020a1709072a5100b0077a8fa8ba55sm9850087ejc.210.2022.12.08.08.03.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 08:03:39 -0800 (PST)
Message-ID: <c09c9cef-14ac-2ab3-5e01-13189823a053@redhat.com>
Date:   Thu, 8 Dec 2022 17:03:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 0/9] platform/surface: aggregator: Improve target/source
 handling in SSH messages
Content-Language: en-US, nl
To:     Maximilian Luz <luzmaximilian@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Mark Gross <markgross@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        platform-driver-x86@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-input@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221202223327.690880-1-luzmaximilian@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221202223327.690880-1-luzmaximilian@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Maximilian,

On 12/2/22 23:33, Maximilian Luz wrote:
> We have some new insights into the Serial Hub protocol, obtained through
> reverse engineering. In particular, regarding the command structure. The
> input/output target IDs actually represent source and target IDs of
> (what looks like) physical entities (specifically: host, SAM EC, KIP EC,
> debug connector, and SurfLink connector).
> 
> This series aims to improve handling of messages with regards to those
> new findings and, mainly, improve clarity of the documentation and usage
> around those fields.
> 
> See the discussion in
> 
>     https://github.com/linux-surface/surface-aggregator-module/issues/64
> 
> for more details.
> 
> There are a couple of standouts:
> 
> - Patch 1 ensures that we only handle commands actually intended for us.
>   It's possible that we receive messages not intended for us when we
>   enable debugging. I've kept it intentionally minimal to simplify
>   backporting. The rest of the series patch 9 focuses more on clarity
>   and documentation, which is probably too much to backport.
> 
> - Patch 8 touches on multiple subsystems. The intention is to enforce
>   proper usage and documentation of target IDs in the SSAM_SDEV() /
>   SSAM_VDEV() macros. As it directly touches those macros I
>   unfortunately can't split it up by subsystem.
> 
> - Patch 9 is a loosely connected cleanup for consistency.

Thank you for the patches. Unfortunately I don't have time atm to
review this.

And the next 2 weeks are the merge window, followed by 2 weeks
of christmas vacation.

So I'm afraid that I likely won't get around to reviewing
this until the week of January 9th.

> Hans, Jiri, Benjamin, Sebastian: While patch 8 ("platform/surface:
> aggregator: Enforce use of target-ID enum in device ID macros") touches
> multiple subsystems, it should be possible to take the whole series
> through the pdx86 tree. The changes in other subsystems are fairly
> limited.

I agree that it will be best to take all of this upstream through the
pdx86 tree. Sebastian thank you for the ack for patch 8/9.

Jiri or Benjamin may we have your ack for merging patch 7/9 + 8/9
through the pdx86 tree ?

Regards,

Hans




> Maximilian Luz (9):
>   platform/surface: aggregator: Ignore command messages not intended for
>     us
>   platform/surface: aggregator: Improve documentation and handling of
>     message target and source IDs
>   platform/surface: aggregator: Add target and source IDs to command
>     trace events
>   platform/surface: aggregator_hub: Use target-ID enum instead of
>     hard-coding values
>   platform/surface: aggregator_tabletsw: Use target-ID enum instead of
>     hard-coding values
>   platform/surface: dtx: Use target-ID enum instead of hard-coding
>     values
>   HID: surface-hid: Use target-ID enum instead of hard-coding values
>   platform/surface: aggregator: Enforce use of target-ID enum in device
>     ID macros
>   platform/surface: aggregator_registry: Fix target-ID of base-hub
> 
>  .../driver-api/surface_aggregator/client.rst  |  4 +-
>  .../driver-api/surface_aggregator/ssh.rst     | 36 ++++-----
>  drivers/hid/surface-hid/surface_hid.c         |  2 +-
>  drivers/hid/surface-hid/surface_kbd.c         |  2 +-
>  .../platform/surface/aggregator/controller.c  | 12 +--
>  .../platform/surface/aggregator/ssh_msgb.h    |  4 +-
>  .../surface/aggregator/ssh_request_layer.c    | 15 ++++
>  drivers/platform/surface/aggregator/trace.h   | 73 +++++++++++++++++--
>  .../platform/surface/surface_aggregator_hub.c |  8 +-
>  .../surface/surface_aggregator_registry.c     |  2 +-
>  .../surface/surface_aggregator_tabletsw.c     | 10 +--
>  drivers/platform/surface/surface_dtx.c        | 20 ++---
>  .../surface/surface_platform_profile.c        |  2 +-
>  drivers/power/supply/surface_battery.c        |  4 +-
>  drivers/power/supply/surface_charger.c        |  2 +-
>  include/linux/surface_aggregator/controller.h |  4 +-
>  include/linux/surface_aggregator/device.h     | 50 ++++++-------
>  include/linux/surface_aggregator/serial_hub.h | 40 ++++++----
>  18 files changed, 191 insertions(+), 99 deletions(-)
> 

