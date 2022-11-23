Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31C8636BBD
	for <lists+linux-pm@lfdr.de>; Wed, 23 Nov 2022 22:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbiKWVA4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Nov 2022 16:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235843AbiKWVAy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Nov 2022 16:00:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FAF14D01
        for <linux-pm@vger.kernel.org>; Wed, 23 Nov 2022 12:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669237188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1sOO24ElSZswZpTQQYOZoAVgnKzXm6MZGjbewnmAv8U=;
        b=P/oQtAeioNUtVgs6GkqaxHuYZBlHPFePBbcA892H2cGxJuANje91srDv9UPzuMProfkub5
        xSOFLiMwlFuOp1c2ag1OB9XdqJnyw9TNcluHUa2RYkAgov91fCSlwWoHMZ7q7kbHlvWtd6
        a7Rl5hziGWhENUamFcwN7VaFaLLnXAU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-668-HeDrR4sAM6CDYXRZaXqEFg-1; Wed, 23 Nov 2022 15:59:46 -0500
X-MC-Unique: HeDrR4sAM6CDYXRZaXqEFg-1
Received: by mail-ej1-f72.google.com with SMTP id dn14-20020a17090794ce00b007ae5d040ca8so10559547ejc.17
        for <linux-pm@vger.kernel.org>; Wed, 23 Nov 2022 12:59:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1sOO24ElSZswZpTQQYOZoAVgnKzXm6MZGjbewnmAv8U=;
        b=Mp+kSnp8nZ8gpp0uOhdG4wrNNn/XxjsAwh6QvmASwzipIzbJCIpmk5UwKi85DBzorD
         JbHc6M+cOO9V904RirDVCnOSRxQ43wZeTcz2ciqjb/5kf9HYREl95t/yvNcVfuSk14kZ
         UKH8HCgJZ0mkIKKHDIJ2HZmanMsutCyozwBlAkymeElFOCcg6Ohf3ZELFi+naKVNfVib
         Je4slBHOQLDjB5Tav0YrfwRj6igcTKUmmVn3jyJdkOZK7e6ITMPhv2wrcukPSG406l4d
         jRLTwi3FtcfGuENoTgC/hLXvgzbCPuGl4QYFtFGQdYCfNFTjO5Lz3QtAXqGxVXJjQNwJ
         XuPA==
X-Gm-Message-State: ANoB5pnUthyBy09MWEyWux8cHfZL80hFE3taxuc3uxI7PUf7zu041rRW
        p+OBiv4yXYTwwAlVZe75IGlNhtZOio0y9fRXWksdg1H8eLo3AaK7mL5jUubfirEYJyJCVb3DT2d
        brZxaLiULqwZvi95vfOY=
X-Received: by 2002:a05:6402:448c:b0:461:7378:3501 with SMTP id er12-20020a056402448c00b0046173783501mr10009562edb.35.1669237185810;
        Wed, 23 Nov 2022 12:59:45 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7lg6cdlyR3UiGu4Sf8KwL2Xr5DSzhVTEOeKzm4qQnvq22jlFZ3QsZb8jgbKRDR30fOTHQnsg==
X-Received: by 2002:a05:6402:448c:b0:461:7378:3501 with SMTP id er12-20020a056402448c00b0046173783501mr10009550edb.35.1669237185655;
        Wed, 23 Nov 2022 12:59:45 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id 25-20020a170906301900b007806c1474e1sm7566389ejz.127.2022.11.23.12.59.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 12:59:45 -0800 (PST)
Message-ID: <2a7a9407-d5f1-95ae-edd1-c4c41862cd25@redhat.com>
Date:   Wed, 23 Nov 2022 21:59:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH resend] platform/x86: intel-uncore-freq: add Emerald
 Rapids support
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Artem Bityutskiy <dedekind1@gmail.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Linux PM Mailing List <linux-pm@vger.kernel.org>
References: <20221122070014.3639277-1-dedekind1@gmail.com>
 <0b867f52-5fe8-f0e8-3f05-746b1db0059e@redhat.com>
 <635d481206b8945db751ea036cf789fe13b9698e.camel@gmail.com>
 <01c732b1-7211-8298-61da-0a6892988743@redhat.com>
 <CAJZ5v0gqmZNRQ61LiG-HKVLLciC9=7MPUB9di0LhuUe_tjHJGg@mail.gmail.com>
 <ee34cb44-9782-9c91-3ec8-3b9d37353b10@redhat.com>
 <d0f51fe4d653c47d7fb9b464c19b58a866f58459.camel@linux.intel.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <d0f51fe4d653c47d7fb9b464c19b58a866f58459.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Srinivas,

On 11/23/22 18:25, srinivas pandruvada wrote:
> Hi Hans,
> 
>>>>
> 
> [...]
> 
>>>> Ugh, no, *NO*! I really expect Intel to do better here!
>>>>
> Sorry, I didn't realize the CPUID is not added to rc1. Our internal
> tree constantly gets rebased. So difficult to catch.
> 
> As you rule, I will communicate internally that apply on top of 
> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=for-next

Thank you and no worries.

These simple CPUID patches seem to have been causing some
(minor) merging issues, as I mentioned there was a similar issue with
"platform/x86/intel: pmc/core: Add Raptor Lake support to pmc core driver"
last cycle.

It would be nice / good if Intel could try to get patches
adding new CPU-ids #defines to land in rc1, rather then
in a post rc1 pull-req as has now happened the last 2
cycles.

I believe that the CPU-ids #defines landing in rc1
(as you thought they did) would make things easier for
everyone.

Regards,

Hans

