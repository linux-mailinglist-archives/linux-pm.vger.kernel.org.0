Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57FBC5FFA7F
	for <lists+linux-pm@lfdr.de>; Sat, 15 Oct 2022 16:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiJOOQU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 15 Oct 2022 10:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiJOOQT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 15 Oct 2022 10:16:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E604C01E
        for <linux-pm@vger.kernel.org>; Sat, 15 Oct 2022 07:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665843377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SaG32OW7Y8fGmWwW+PTnAPVZrFvlSTGzznw5Adqz3qs=;
        b=aSx/o1a5zPEM7NseechKm5YxHYcJR879ARG2m+5g8xgOGEHQjQvma49oFiC5tJje434BEw
        yfbShxyDX8wGUDpkJf/Tz2dlHB5ma6z1jjzI0BdWBbC1+jQ+tgxXDGEZu9BgJ/55bJr2Ip
        7z/JqLBQKuTlMZqZedzosXsMcdNwx7c=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-402-uwCuNBTXOdi37beL6d9YLg-1; Sat, 15 Oct 2022 10:16:15 -0400
X-MC-Unique: uwCuNBTXOdi37beL6d9YLg-1
Received: by mail-lj1-f199.google.com with SMTP id f14-20020a2e950e000000b0026fa4066f3cso3297746ljh.21
        for <linux-pm@vger.kernel.org>; Sat, 15 Oct 2022 07:16:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SaG32OW7Y8fGmWwW+PTnAPVZrFvlSTGzznw5Adqz3qs=;
        b=OR+cBlKOYjxUA+FWtd6XFkoFLFmaDyFhOgeptbg/IqcK7wDNbIcmZ49bJt3lCDEnxm
         fT3QekcYksEcqFbi99PI1BgUgHCeoj9g8tM1tE+VDENsxvEchwkPZQaRl/SkhodtqYEF
         dSSGnXpRkGSnfsX2p5p64eZt+kyzhCvU9M2Cn2CDu1SXTEkn2K/IQC/cp7hgiajcvgEt
         tP3qsa8HhqAu4qoS1Kqp4Po892T+vmJJS1zhKl2w0uPV4Ix/ZVvdi4jBKTxYVjXnB3Jk
         yqksami3dsfDl6fthjx/U6eLuzAF+Z9ArNLIH2yl3Et3lR89FBrNj+d7zmS3APMnoegD
         8npw==
X-Gm-Message-State: ACrzQf0m8xcVPGPEAcUo/7QfNVwPCT/X72YSrx43NzmfNas3Lbut3hGD
        GWXxVpEO1m2TpEzSAdZ/atXezxO7K8coio/3ArJIS6Fr/6+j2SgpHkcco1psUWHkc5JOSHz32ca
        /ROKjjHOVV/IxSm5c4Do=
X-Received: by 2002:a05:6512:2388:b0:4a2:6150:c258 with SMTP id c8-20020a056512238800b004a26150c258mr972199lfv.348.1665843373924;
        Sat, 15 Oct 2022 07:16:13 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6qTpl6qmL2gkmmA755V/p41kDgJFX1Ay4/j47MPWztsOUQTfro+KlM/ZhBSvs1DqZc2l6vLg==
X-Received: by 2002:a17:906:5d04:b0:77f:ca9f:33d1 with SMTP id g4-20020a1709065d0400b0077fca9f33d1mr2213554ejt.526.1665843362985;
        Sat, 15 Oct 2022 07:16:02 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id q6-20020a17090676c600b0078c47463277sm3208562ejn.96.2022.10.15.07.16.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Oct 2022 07:16:02 -0700 (PDT)
Message-ID: <a86c5d18-5e4d-30f7-7634-675e78ee3a19@redhat.com>
Date:   Sat, 15 Oct 2022 16:16:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 5/7] power: supply: bq25890: Factor out regulator
 registration code
Content-Language: en-US, nl
To:     Marek Vasut <marex@denx.de>, linux-pm@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20221010210310.165461-1-marex@denx.de>
 <20221010210310.165461-5-marex@denx.de>
 <e0659fb1-7e1e-de5c-de6a-99a8f180bd3f@redhat.com>
 <00e6b9b0-ddef-6e2f-0603-9a25fd3b9e0d@denx.de>
 <848ada38-00a1-0631-871f-926bb33a166f@redhat.com>
 <021a1dfc-eb05-77ad-644c-f967a5bf7799@denx.de>
 <27d4c17a-1894-e055-9311-9fb6d69d3665@redhat.com>
 <08bbfa77-8001-9a69-94ea-936afe8195a8@denx.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <08bbfa77-8001-9a69-94ea-936afe8195a8@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 10/14/22 18:46, Marek Vasut wrote:
> On 10/13/22 11:12, Hans de Goede wrote:
>> Hi,
> 
> Hi,
> 
> [...]
> 
>>>> Looking at standard Linux userspace (Debian/Fedora/etc.)
>>>> all the userspace tools capable of reporting voltages
>>>> of various voltage rails inside the system to the user
>>>> use the hwmon interface for this. This is also why
>>>> the power-supply class core recently got support for
>>>> proxying some psy properties to a hwmon class device.
>>>>
>>>> So the way I see it is that if we want to report Vsys to
>>>> userspace, that we then clearly need to report it through
>>>> the hwmon interface.
>>>
>>> For regulators, you can read their values via /sys/class/regulators/* , if the user is interesting in Vsys .
>>>
>>> Maybe that is where we disagree -- I'm not particularly interested in exposing Vsys to user space, but since it was exposed before, I tried to retain that exposure, although via different channel. And the regulator also makes the Vsys useful, since it can be used as a supply on the kernel level.
>>
>> I don't particularly care a lot about exposing Vsys to user space either,
>> but like you I do believe that we should at least keep the functionality
>> around while fixing the wrong property use.
> 
> I agree.
> 
>> I'm still not 100% convinced a regular for Vsys is not a bit
>> overkill but I don't want to block going this route either.
> 
> Why would a regulator be an overkill compared to hwmon ?
> What am I missing here ?

A regulator is another struct device, and also more code at the
driver level then just adding a new property (there already is
a hwmon device related to the psy device, so a new property would
just use that.

Anyways you have expressed a clear preference for the regulator
approach and I'm fine with that, lets see what sre has to say.

Regards,

Hans

