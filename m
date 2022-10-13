Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE645FD6AE
	for <lists+linux-pm@lfdr.de>; Thu, 13 Oct 2022 11:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiJMJMg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Oct 2022 05:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiJMJMf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Oct 2022 05:12:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE3713D62D
        for <linux-pm@vger.kernel.org>; Thu, 13 Oct 2022 02:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665652353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eJPTf+J0rkxkKJ6ep7rmBEFxSznnVS2v0m6jwh2RDu0=;
        b=SchzoOzFbEkR+RuB7TGwoWrVZX0GkOpBu5JleOAuPKgQKCIMPtND0dJMRyRY2UF1miVZEK
        euZbPB0952vfhBVSDLptOM1Fo9jGkC91e4PsDmY2K7Cw9g9vgwBHJg0vY3ERTef+MFG3AA
        2Db4To6THNr811U6OYoe4+XNo5crFwo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-630-32xRMy5WMAi-EVUUVnOyrw-1; Thu, 13 Oct 2022 05:12:32 -0400
X-MC-Unique: 32xRMy5WMAi-EVUUVnOyrw-1
Received: by mail-ed1-f70.google.com with SMTP id f18-20020a056402355200b0045c13ee57d9so1060960edd.20
        for <linux-pm@vger.kernel.org>; Thu, 13 Oct 2022 02:12:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eJPTf+J0rkxkKJ6ep7rmBEFxSznnVS2v0m6jwh2RDu0=;
        b=nMfL/fOFSWr93feYYRm0T/BmGkd6Jwfc1MREd7bZUTzt502iVMEQ2GAL26ruuNf6n9
         0YnIZdGBjWdFpm6jB05vhVMlTY+p1nd55hOgEqEHLKGEcXE8WCCAz8pjPOXpDeubMQq7
         yyx3EhgizZHg2ppWvVMcetjb21lAUQeVC2dJ1c5gTWPGhvhG36yfhi2Ob8Kl9hT39tRZ
         M/tdw3nPTexsn1KTafpeYWVcaRE3DhsDlqrVqwTkW/nOmxuv8QaQJW2C3DC4AWBNWE7Y
         AKGGR85gzoppd3gu2oLU1EWaxTJdZsi/x8dcMcdSawBXn2mt47sfhn39hby+Sj+EW8Jz
         BXNg==
X-Gm-Message-State: ACrzQf33DZBEDEBxmQ08niWjmrtIM7B4aBZgWKiW+j4u3He3+SQPgvR1
        BUFS2f+ByzXU/UcJzyE8ZvZAJb45wNr7GalMeJNq7C3MVeBOpaeJsyF524laA+9Fd6rzjsH3l0f
        5pHL3WGBG+LJLqfYbI2g=
X-Received: by 2002:a17:906:2a93:b0:78d:b87e:6aab with SMTP id l19-20020a1709062a9300b0078db87e6aabmr14531624eje.157.1665652350737;
        Thu, 13 Oct 2022 02:12:30 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM486OQG8dRXTsVAeiklXmE0BR4db2hABa99S1xKJQy+TWMm5tI0qhBDDV1g+/7apMJsPiqjCA==
X-Received: by 2002:a17:906:2a93:b0:78d:b87e:6aab with SMTP id l19-20020a1709062a9300b0078db87e6aabmr14531615eje.157.1665652350431;
        Thu, 13 Oct 2022 02:12:30 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id e14-20020a170906080e00b0078d25e0f74bsm2634812ejd.46.2022.10.13.02.12.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 02:12:29 -0700 (PDT)
Message-ID: <27d4c17a-1894-e055-9311-9fb6d69d3665@redhat.com>
Date:   Thu, 13 Oct 2022 11:12:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 5/7] power: supply: bq25890: Factor out regulator
 registration code
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
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <021a1dfc-eb05-77ad-644c-f967a5bf7799@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 10/13/22 00:02, Marek Vasut wrote:
> On 10/12/22 12:10, Hans de Goede wrote:
>> Hi Marek,
> 
> Hello Hans,
> 
>>>> On 10/10/22 23:03, Marek Vasut wrote:
>>>>> Pull the regulator registration code into separate function, so it can
>>>>> be extended to register more regulators later. Currently this is only
>>>>> moving ifdeffery into one place and other preparatory changes. The
>>>>> dev_err_probe() output string is changed to explicitly list vbus
>>>>> regulator failure, so that once more regulators are registered, it
>>>>> would be clear which one failed.
>>>>>
>>>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>>>
>>>> First of all thank you for your work on this series. Based purely
>>>> on reading the commit messages patches 1-4 sound good to me. I will
>>>> do a more detailed review tomorrow.
>>>>
>>>> As for patch 5-7 thinking some more about adding a Vsys regulator
>>>> just to report the Vsys reading feels wrong to me.
>>>>
>>>> A regulator device's voltage in sysfs is about the value the regulator
>>>> is supposed to try and regulate its outputted voltage to, while here
>>>> we are talking about an ADC reading of the actual outputted voltage.
>>>>
>>>> This really should *not* be modeled as a regulator if anything the
>>>> hwmon interface would be applicable for this ADC reading and
>>>> the power_supply core has support for exporting some of
>>>> the psy info through hwmon now.
>>>>
>>>> So what should happen for Vsys IMHO is make it a new
>>>> POWER_SUPPLY_PROP_SYSTEM_VOLTAGE property and while adding support
>>>> for this new property to the power-supply core, also make the core's
>>>> hwmon glue code export this in the registered hwmon device so that
>>>> e.g. a sensors applet on the desktop can easily show it (*).
>>>>
>>>> Sorry for the confusion with my ack in the other thread which
>>>> only meant to agree with a part of the alinea/sentence I put
>>>> the ack under.
>>>
>>> I'm not sure that's all there is to the Vsys regulator, it would let us model the connection between the charger chip and PMIC, where the charger would be the supply and the PMIC the regulator consumer. If the PMIC can determine its input voltage, it might be able to configure itself to some more optimal mode of operation. With the Vsys regulator, the PMIC can determine its voltage. So I think the Vsys regulator would be useful in that scenario (that's how it is wired on my board btw.).
>>
>> You are right that theoretically there is nothing wrong with
>> the model of having the charger-IC's Vsys output being
>> a perent regulator for the PMIC.
>>
>> As for this being useful to actually have I have my doubts
>> though. All the PMICs I know automatically select the
>> optimal mode/parameters for their buck convertors based
>> on the detected input voltage. So they basically always
>> work optimally as long as the input voltage is within
>> their supported range. So having Vsys moduled as
>> a regulator is only theoretically useful which is not
>> a good argument for adding this to the kernel in this
>> way IMHO.
> 
> I would be careful with "All the PMICs" , not all of them are fully automatic, some are just broken or partly automatic. i.MX28 POWER unit and one of the Dialog 9062 I think come to mind.
> 
> I also think if we have a supplier (bq25890) -> consumer (pmic input) relationship in hardware between two chips, we should model it using regulators. This is the common approach on embedded systems, so I don't see why we shouldn't do it here the same way?
> 
>> I believe it is important to go back to the original
>> problem / question which we are trying to solve / answer
>> here, which is:
>>
>> "what is the best way to make the readings from
>> the Vsys ADC available to userspace?"
> 
> Actually, I don't particularly care about exposing Vsys to user space. We are already changing the ABI with these first four patches, and the Vsys is no longer reported with 1..4 applied, so shall we change the question to:
> "
> Do we care about making Vsys reading available to userspace at all ?
> "
> 
>> Looking at standard Linux userspace (Debian/Fedora/etc.)
>> all the userspace tools capable of reporting voltages
>> of various voltage rails inside the system to the user
>> use the hwmon interface for this. This is also why
>> the power-supply class core recently got support for
>> proxying some psy properties to a hwmon class device.
>>
>> So the way I see it is that if we want to report Vsys to
>> userspace, that we then clearly need to report it through
>> the hwmon interface.
> 
> For regulators, you can read their values via /sys/class/regulators/* , if the user is interesting in Vsys .
> 
> Maybe that is where we disagree -- I'm not particularly interested in exposing Vsys to user space, but since it was exposed before, I tried to retain that exposure, although via different channel. And the regulator also makes the Vsys useful, since it can be used as a supply on the kernel level.

I don't particularly care a lot about exposing Vsys to user space either,
but like you I do believe that we should at least keep the functionality
around while fixing the wrong property use.

I'm still not 100% convinced a regular for Vsys is not a bit
overkill but I don't want to block going this route either.

So I'll go and review the last 3 patches and then lets wait
and see what Sebastian (SRE) has to say.

Regards,

Hans

