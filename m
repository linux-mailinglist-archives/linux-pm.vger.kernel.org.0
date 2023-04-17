Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBC46E428D
	for <lists+linux-pm@lfdr.de>; Mon, 17 Apr 2023 10:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjDQIZz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Apr 2023 04:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjDQIZw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Apr 2023 04:25:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3755C5278
        for <linux-pm@vger.kernel.org>; Mon, 17 Apr 2023 01:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681719896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UcXu6x56VatJHPoIi02+E+e45LAvk1jm28QAaFuNKY4=;
        b=enTFoS6lkA0L5++/MgJsT6JEVAuq/ORtdnMaHG0NJx3h8DRIEOk7kA1nS+uccrJedHiDUq
        AiIlRh/55fr/yLDsrv8/T0/to9/Ymy8KRcDQFnyktNhR8w10CwXrqgu26jDdpDt8WW9Ren
        qcktzt0gvSElGRa+YnPgu8kg+oahv2E=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-8eifMu4GMfK--1ODHR-z2w-1; Mon, 17 Apr 2023 04:24:54 -0400
X-MC-Unique: 8eifMu4GMfK--1ODHR-z2w-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-50508242889so2441343a12.1
        for <linux-pm@vger.kernel.org>; Mon, 17 Apr 2023 01:24:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681719893; x=1684311893;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UcXu6x56VatJHPoIi02+E+e45LAvk1jm28QAaFuNKY4=;
        b=CpvyyESRpTbCgDbyXTGoaNk7AeZXnCnPdHLOsf5P2+Nf6b2+vayZo8mQsnwmj0xaKG
         5XYAO6yU9Q/MrhHTVWpv65mCcmQhSmQdhJc1PbsyJoU3IgHo+US4WTxVT3lnXcNmjw77
         UOTymE3+bUZFEI1Ac1Vqw96GPBqRc0+meccyjzlKGzBKX7bX+ejDR5n0G3znw7tYK3wo
         vhYL94PxEJT1kBWS9Sx58UI6Cb4rK5Q1pyeeJR5qBFaNkLlL1KEX5DhYGbR9W2pP5sY5
         Ho9QPTo8blbNOQcV8iwFKRSdyT8I8MpQzO1duzq9m53KkGJDfOSZR2yKjIK7GK49Ajgg
         x73Q==
X-Gm-Message-State: AAQBX9f/z4g7p8e7ZLbgWAeDfTRlHJr9I16Xx2m4kCs9Za4BNGAA3NNN
        5jpCGB/oSDADauDGzvvQNY0WHNWTNd61zo8VS4Wx5uIggYiXEWvq/Rhk7TMnF63o4VvILZ+0pPs
        5AfVgyNH8pUEz2UQTe0c95HVXi5o=
X-Received: by 2002:aa7:c155:0:b0:506:8edd:b883 with SMTP id r21-20020aa7c155000000b005068eddb883mr6453567edp.36.1681719893503;
        Mon, 17 Apr 2023 01:24:53 -0700 (PDT)
X-Google-Smtp-Source: AKy350b4i65gxNLASOvBXz6lnH55FvdetEEPTPD6VrcxYPr+lNl+ZQCC+GMWZsfmqc1JZ9am8bk2vw==
X-Received: by 2002:aa7:c155:0:b0:506:8edd:b883 with SMTP id r21-20020aa7c155000000b005068eddb883mr6453555edp.36.1681719893168;
        Mon, 17 Apr 2023 01:24:53 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id l12-20020a056402344c00b00504803f4071sm5552136edc.44.2023.04.17.01.24.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 01:24:52 -0700 (PDT)
Message-ID: <8a4f2454-809c-d773-42b2-e62fb057feb2@redhat.com>
Date:   Mon, 17 Apr 2023 10:24:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v9 0/4] Add vendor agnostic mechanism to report hardware
 sleep
Content-Language: en-US, nl
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Box David E <david.e.box@intel.com>, jstultz@google.com,
        pavel@ucw.cz, svenva@chromium.org,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Shyam-sundar.S-k@amd.com, rrangel@chromium.org,
        Jain Rajat <rajatja@google.com>, linux-kernel@vger.kernel.org
References: <20230414012346.1946-1-mario.limonciello@amd.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230414012346.1946-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Mario, et al.,

On 4/14/23 03:23, Mario Limonciello wrote:
> An important part of validating that s0ix worked properly is to check how
> much of a cycle was spent in a hardware sleep state.
> 
> The reporting of hardware sleep is a mix of kernel messages and sysfs
> files that vary from vendor to vendor. Collecting this information
> requires extra information on the kernel command line or fetching from
> debugfs.
> 
> To make this information more readily accessible introduce a new file in
> suspend_stats that drivers can report into during their resume routine.
> 
> Userspace can fetch this information and compare it against the duration
> of the cycle to allow determining residency percentages and flagging
> problems.
> 
> Mario Limonciello (4):
>   PM: Add sysfs files to represent time spent in hardware sleep state
>   platform/x86/amd: pmc: Report duration of time in hw sleep state
>   platform/x86/intel/pmc: core: Always capture counters on suspend
>   platform/x86/intel/pmc: core: Report duration of time in HW sleep
>     state
> 
>  Documentation/ABI/testing/sysfs-power | 29 +++++++++++++
>  drivers/platform/x86/amd/pmc.c        |  6 +--
>  drivers/platform/x86/intel/pmc/core.c | 17 ++++----
>  drivers/platform/x86/intel/pmc/core.h |  4 +-
>  include/linux/suspend.h               |  8 ++++
>  kernel/power/main.c                   | 59 +++++++++++++++++++++------
>  6 files changed, 98 insertions(+), 25 deletions(-)
> 
> 
> base-commit: 09a9639e56c01c7a00d6c0ca63f4c7c41abe075d

Thank you for working on this, this looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

For the series. Since this also touches kernel/power/main.c
I think it would be best if the entire series is merged
through the linux-pm tree and I'm fine with the pdx86 bits
also getting merged through linux-pm.

Rafael ?

Regards,

Hans



