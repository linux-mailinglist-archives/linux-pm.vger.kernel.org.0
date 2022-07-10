Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABFD56CFC7
	for <lists+linux-pm@lfdr.de>; Sun, 10 Jul 2022 17:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiGJP17 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 Jul 2022 11:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiGJP16 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 Jul 2022 11:27:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C8B70DFF6
        for <linux-pm@vger.kernel.org>; Sun, 10 Jul 2022 08:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657466876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WEgc4+9EZyWOg0DX1APF1+peVAF/Sf5RwA1DWtcyQls=;
        b=RUpHmKoPheQr+PLhu/555ZV7Q1Mfj0evTog10PHypJI3itORN402oqMinFsYv4rWh1chh8
        TDtPyta3XhvxzrQBCrcVmnaGKeqKPf5eomf8HYt9ajKY/ZytN26me9QUhlsMZ2mM+m8GxS
        ZF2b2tbPsKl174YoWPnXMTWr6nrQDAQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-461-K-RZmYwAOU68QG_uDAnOdA-1; Sun, 10 Jul 2022 11:27:55 -0400
X-MC-Unique: K-RZmYwAOU68QG_uDAnOdA-1
Received: by mail-ed1-f71.google.com with SMTP id b15-20020a056402278f00b0043acaf76f8dso1266370ede.21
        for <linux-pm@vger.kernel.org>; Sun, 10 Jul 2022 08:27:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WEgc4+9EZyWOg0DX1APF1+peVAF/Sf5RwA1DWtcyQls=;
        b=qFWdZorSTt3YPRGdsFovwzcd12UWj4LDgj1P/NjtbIVg0irydzepQzTizOOxcb0hMy
         /EY+wf603NC7AGKTTv7KvFhWuD5WNnLO39F1ZJjC3kcPgnXNRX2r6H99UHqq2yW+CoO2
         NiK9W+lOVT7nJSe8LGrDjdvoPgz1dCcFoEFjQeQk/gEoFUNH+9vqZT5IsU/PLPsDOQjp
         bxHE0vxQbpLi9n3N2dgvT4VRmoNyqBpLgagy3NCXp2lzzpS9hQn8/7eFUKwdpJr6dfOJ
         dEvNExh5do3TSG4uHPo1/aGqphWByFzRH6oxi4RDJeE9JMhwW1nInk/cA2YV6g+kBBMS
         0rag==
X-Gm-Message-State: AJIora/2NnbDlKvnNEnBJSvESuMujh9C10DQos+zexA/bXI3xZKVeJav
        liievvu5UAtIxzEaBNa1GCI1EtAiRIwJ7VE97BWVfUt9Z/kJBrcXKQQnijjvhZuVuAcL9On+OBr
        3XcoewRCg3mLPdA+O+Jw=
X-Received: by 2002:a05:6402:35c5:b0:437:140d:5cb3 with SMTP id z5-20020a05640235c500b00437140d5cb3mr18766579edc.72.1657466874432;
        Sun, 10 Jul 2022 08:27:54 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sar1BApa+f5UiaF83FXmU4bkBODkz9o1fNx7/o9HOXstI0QKL9JWDfHduHhfrrwr0qUspBig==
X-Received: by 2002:a05:6402:35c5:b0:437:140d:5cb3 with SMTP id z5-20020a05640235c500b00437140d5cb3mr18766565edc.72.1657466874293;
        Sun, 10 Jul 2022 08:27:54 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id y26-20020a056402135a00b00435a742e350sm2895727edw.75.2022.07.10.08.27.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Jul 2022 08:27:53 -0700 (PDT)
Message-ID: <c00dc0f7-dfe8-ecd7-ee6d-72b11a4ab3dc@redhat.com>
Date:   Sun, 10 Jul 2022 17:27:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 0/2] Fix 2 5.19 power-off regressions caused by
 sys-off-handler work
Content-Language: en-US
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, x86@kernel.org,
        linux-efi@vger.kernel.org
References: <20220708131412.81078-1-hdegoede@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220708131412.81078-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 7/8/22 15:14, Hans de Goede wrote:
> Hi All,
> 
> I noticed that my Lenovo Yoga Tablet 2 1050L was hanging on power-off again
> with 5.19, even though I had implemented a workaround for this in 5.17 .
> 
> I quickly realized that this was caused by the recent sys-off-handler work
> and fixed this by switching the workaround over to register_sys_off_handler
> with a priority of SYS_OFF_PRIO_FIRMWARE + 1, so that the workaround runs
> before acpi_power_off() get a chance to run.
> 
> This made me realize that the efi_power_off handler which sometimes is
> used in preference of acpi_power_off had the same problem, so the second
> patch in this series fixes that.
> 
> I plan to include patch 1/2 in a fixes pull-req to Linus soon. Ard,
> if I can get your Ack for 2/2 then I can include this in the pull-req
> if you want; or you can send this to Linus yourself.

I've added these to my review-hans (soon to be for-next) branch now
and I'll include them in my upcoming 5.19 fixes pull-req.

Regards,

Hans

> 
> Regards,
> 
> Hans
> 
> 
> Hans de Goede (2):
>   platform/x86: x86-android-tablets: Fix Lenovo Yoga Tablet 2 830/1050
>     poweroff again
>   efi: Fix efi_power_off() not being run before acpi_power_off() when
>     necessary
> 
>  drivers/firmware/efi/reboot.c              | 21 +++++++++++----------
>  drivers/platform/x86/x86-android-tablets.c | 17 +++++++++++++----
>  2 files changed, 24 insertions(+), 14 deletions(-)
> 

