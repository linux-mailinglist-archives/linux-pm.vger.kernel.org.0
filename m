Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0946361F7
	for <lists+linux-pm@lfdr.de>; Wed, 23 Nov 2022 15:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237712AbiKWOia (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Nov 2022 09:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237411AbiKWOi2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Nov 2022 09:38:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EEA10A7
        for <linux-pm@vger.kernel.org>; Wed, 23 Nov 2022 06:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669214251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3QnpEYhOKCVrAcLWBnO2mdvLHxPqgOt8Aay14Q6qnGQ=;
        b=Zd+vCZ01aIcrNpo3XXNVl5M9iWFQXlX9E3Kb44gTyNhA3F4AQLvijh1g4xrmuY8WIajhWK
        uEmu+ec0Y8DZP1pdh+jYF6DC5Wz47Bw+4vTXWQ2fxF1ixizF7aXTge5enyGNYFNdqAZL7I
        pr0oZHpFV0RikCpGb4cYkrqL2LhCyPA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-64-2GklN3whM5q773xWKMFi9g-1; Wed, 23 Nov 2022 09:37:30 -0500
X-MC-Unique: 2GklN3whM5q773xWKMFi9g-1
Received: by mail-ed1-f69.google.com with SMTP id y2-20020a056402440200b00469c41d5367so4452244eda.1
        for <linux-pm@vger.kernel.org>; Wed, 23 Nov 2022 06:37:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3QnpEYhOKCVrAcLWBnO2mdvLHxPqgOt8Aay14Q6qnGQ=;
        b=y+an/TOjAdF7yzS/Zm9yDSEefD/ucCMjzKDGNP0SBsD/jEcqh7rqdhEaFo9btrexHZ
         y+HInUNbVjbZLKBs3b554J0NZBHhMdmR3Vu4EBWGEsWmKaKTlA++MNNazQ7V2AsjnLvs
         ui2NNpmIqm+bSIuiwOYzXszh5QCCkRR27ZUFXXLzeNmbcaECr5+zg7lU7BBPuCTWoakS
         F3J3YM3qOwnUy/u93t+Rp8NsA6mGCpa3xWyy//YvK7X31+Rs5osfAm5owd4rYEVQ6F8v
         2DIkdxMjpOlGpAIFBvRcxDjEBbELviytA8g+0DLGyfdLhHdFEsrUaSllBWDnnk/izapV
         zv7Q==
X-Gm-Message-State: ANoB5plMGvXsJJthwClodj5qTJbMyne2AGvt26kI3szJcfl3THrrVSSH
        iEGYzOWsFUDXirS11Bexy9eOYjLoctVOiG6tZymMqwNE1Wy1tcruhJJe8M70hR/M1sQokHN5Wi5
        rCk7axpxvLWKcDIN9w/A=
X-Received: by 2002:a17:907:1183:b0:7ae:25ba:5e4b with SMTP id uz3-20020a170907118300b007ae25ba5e4bmr9570766ejb.724.1669214248899;
        Wed, 23 Nov 2022 06:37:28 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7BDEgodoS2BalJZJHVIys77jXmm5YD22m7b1bkTqMXFU/OVS37hXraXwuYHWsIhHwqSihHVA==
X-Received: by 2002:a17:907:1183:b0:7ae:25ba:5e4b with SMTP id uz3-20020a170907118300b007ae25ba5e4bmr9570750ejb.724.1669214248686;
        Wed, 23 Nov 2022 06:37:28 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:2625:d256:70bd:577e? (2001-1c00-0c1e-bf00-2625-d256-70bd-577e.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:2625:d256:70bd:577e])
        by smtp.gmail.com with ESMTPSA id gt22-20020a170906f21600b0073c10031dc9sm7244530ejb.80.2022.11.23.06.37.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 06:37:28 -0800 (PST)
Message-ID: <01c732b1-7211-8298-61da-0a6892988743@redhat.com>
Date:   Wed, 23 Nov 2022 15:37:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH resend] platform/x86: intel-uncore-freq: add Emerald
 Rapids support
Content-Language: en-US
To:     Artem Bityutskiy <dedekind1@gmail.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux PM Mailing List <linux-pm@vger.kernel.org>
References: <20221122070014.3639277-1-dedekind1@gmail.com>
 <0b867f52-5fe8-f0e8-3f05-746b1db0059e@redhat.com>
 <635d481206b8945db751ea036cf789fe13b9698e.camel@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <635d481206b8945db751ea036cf789fe13b9698e.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 11/23/22 09:45, Artem Bityutskiy wrote:
> Hello Hans,
> 
> On Tue, 2022-11-22 at 16:30 +0100, Hans de Goede wrote:
> There are 3 different issues with this patch, next time please
> check your patch a bit more thorough before submitting it:
> 
> 1. This is the first time I see this, or that the
> platform-driver-x86@vger.kernel.org
> list sees this. Next time please make sure you address the patch to the right
> people the first time you send it:
> 
> sure, thanks.
> 
> 2. This has checkpatch warnings which are easily fixable:
> 
> [hans@shalem platform-drivers-x86]$ scripts/checkpatch.pl 0001-platform-x86-
> intel-uncore-freq-add-Emerald-Rapids-su.patch 
> WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per
> line)
> 
> OK.
> 
> 3. This fails to build on top of:
> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=for-next
> 
> OK, thanks for the pointer. I'd need platfrom-drivers-x86 git tree to include
> this upstream commit:
> 
> 7beade0dd41d x86/cpu: Add several Intel server CPU model numbers
> 
> Would you please consider updating?

Ugh, no, *NO*! I really expect Intel to do better here!

As I repeated explained with the

"platform/x86/intel: pmc/core: Add Raptor Lake support to pmc core driver"

patch I cannot just go and cherry-pick random patches merged through other trees
because that may cause conflicts and will cause the merge to look really
funky.

There are proper ways to do this and this is not it!

This is something which Intel really *must* do correctly next time because
having this discussion over and over again is becoming very tiresome!

So the proper way to do starts with realizing *beforehand* that things
will not build on top of pdx86/for-next. By like actually doing
a build-test based on top of pdx86/for-next instead of this nonsense of
repeatedly sending me broken patches.

Once you realize this there are a couple of options, these all start
with identifying which tree has the patch on which the other patch depends
iow through which tree / subsystem was "7beade0dd41d x86/cpu: Add several
Intel server CPU model numbers" merged? Based on the name I'm going to
assume this is done through the x86 tree.

Once you have:

1. Realized the patch actually won't build on top of pdx86/for-next
2. Identified which tree has the commit your patch depends on

Then there are several options how to proceed:

1. Since this is a one-liner and it touches a driver which has
seen no other recent changes, you can submit the patch to the
x86/tip tree maintainers instead of to the pdx86 subsystem.

The x86/tip tree maintainers will likely want my ack for merging
this through their tree. For the next version which you should
submit to the x86/tip tree folks, not to the pdx86 list! Feel free
to add my:

Acked-by: Hans de Goede <hdegoede@redhat.com>

and you will want to add a cover-letter explaining why this
is being submitted to the x86/tip tree and my ack is there
to indicate that I believe it is ok for the patch to go
through another tree.

What you would normally do is realize beforehand you want to go
this route and directly submit to the x86/tip maintainers with me
in the Cc asking for my ack for merging through another tree.

Or what you could have done is:

2. Ask the x86 maintainers to create an immutable branch based on
the last rc1 + just the patch adding the defines (which means
realizing before hand you will need this patch in other subsystems
and ask them to do this when *submitting* the patch.

Then I could have merged the immutable-branch and then cleanly
apply your patch on top.

###

What you can *NOT* do is just submit the patch to me and expect me
to somehow magically fix the cross subsystem dependency problems
for you. As the patch submitter any cross subsystem dependency problems
arr *your problem* not mine.

Regards,

Hans






