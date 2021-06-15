Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C60EA3A85C7
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jun 2021 17:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbhFOQAT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Jun 2021 12:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233060AbhFOP7a (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Jun 2021 11:59:30 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE2BC061D7C;
        Tue, 15 Jun 2021 08:51:38 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id t9so11810816pgn.4;
        Tue, 15 Jun 2021 08:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=k2dNOWTNlbIdh5i+8Nsx9KpD00S4Gm6luTuaXTJKuvA=;
        b=ChZgBAMq1DPAkCXl3o9ThacQ8Rn81K9UwoROidAaA54sYtZ8SM0GPS9Tnm9zH2xNpq
         C8oeufkZzN7UGlvaq8W0w//ODCeHnzdzCEdXWAlbrsoKfjPM2cQ8mFBBojKuw82QMs3K
         EYctZLOzMqS4QJel5Al5+H0jc8AWYDnl4Ch7CgkuQbrR6EQbAwsg2hNKzdDSbkoPLUuT
         ohrGaEoIapADit3oW3Y2OlIgcwPGab3JDsMeGCqnVe+AGCcwhq7vZVbLkLIOM9rmzAad
         43B1O1cUuacPjpsWlnJDpczV0tN28HgiuUd6rRNTUdOEFU89xtDN5SPDxx4GACuBtAdg
         +tDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k2dNOWTNlbIdh5i+8Nsx9KpD00S4Gm6luTuaXTJKuvA=;
        b=RFjImuFurH6xs1CxdnsImGccgREm/HBuZSq5WuSDCyzqSUC14Ftj17WArx/JfkSRIq
         xaqeplr+5lvn8Qqj0xiUxgbpBUw4vg7NGOcqwKD9jK5iOveFedRSvabBeqZMa6aYhZEx
         X7f/p/ht53D3skKiExzXTsTbfuuJFALdB2dNQFzNf+GoZupy6g+Q4ZTEVXodPPkusq8C
         WUDzdF4D5mLc/z9eefu5EiWBUbOhU118i5kiBS4fCCn5J5OYWU2+QTZvQGTnZ9DGx8kL
         NQxqHTlfaS4l/9h9/y7C9KgDvGdTeay/j6pPLBtLYOmwmP0esCxWjuho5D94ssZSiZUG
         OCGQ==
X-Gm-Message-State: AOAM532cdm5unLRWKSppIRg1ijVudacz7WmIulzEL8bsNfuiw3t7l3g2
        mQiY20/intwXyZ8JxCZJCVA=
X-Google-Smtp-Source: ABdhPJzxd+19YUuuC7dp7PSqpG6zMz1GjqbkKB8x0UgFg+bpPlGxhB5l+HFRsBM/nFelIuD3dWFT/w==
X-Received: by 2002:a63:5c4e:: with SMTP id n14mr196153pgm.192.1623772297831;
        Tue, 15 Jun 2021 08:51:37 -0700 (PDT)
Received: from [10.230.29.202] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id k18sm3013838pff.63.2021.06.15.08.51.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 08:51:36 -0700 (PDT)
Subject: Re: [PATCH 2/2] mmc: sdhci-iproc: Add support for the legacy sdhci
 controller on the BCM7211
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Al Cooper <alcooperx@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Ray Jui <rjui@broadcom.com>, Rob Herring <robh+dt@kernel.org>,
        Scott Branden <sbranden@broadcom.com>
References: <20210602192758.38735-1-alcooperx@gmail.com>
 <20210602192758.38735-2-alcooperx@gmail.com>
 <CAPDyKFrynST66yA_T3iroiJsfmNuBOEiiBnb=vNoyP6QpvZ7aQ@mail.gmail.com>
 <fe956941-bb39-413e-f051-d9f353f64eda@gmail.com>
 <CAPDyKFpEtvjS1mWC68gRBWD64dq2M1LO84UWE5uDLTzbGz1g8Q@mail.gmail.com>
 <6acd480a-8928-89bb-0f40-d278294973a1@gmail.com>
 <CAPDyKFqk23xg5R2k9GwQrnamwWYbMkmrbWYsHPF9VBQTAbvQHw@mail.gmail.com>
 <a1199e99-eb29-125b-2bac-f0abb4803c9b@gmail.com>
 <CAPDyKFq-rofbCyAhcQGt2xZykip6Le+CUDXgDwAisVOj=Tt-uA@mail.gmail.com>
 <b4c36944-8f41-1f30-10b4-b3efe0aade01@gmail.com>
 <CAPDyKFpR1GZcqCO5=-h7jvG0TysPLfJOP6rDJBagHvg9HFxnSQ@mail.gmail.com>
 <e25164b4-fa0c-b1c1-e40b-0f0c71641976@gmail.com>
 <CAPDyKFq92mp4CXj8-QHw=DEQ8bcAjtrmLyowrGKSJL2Fch1cJQ@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <c356986f-08de-e8d5-5d1e-f4e13c77648f@gmail.com>
Date:   Tue, 15 Jun 2021 08:51:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAPDyKFq92mp4CXj8-QHw=DEQ8bcAjtrmLyowrGKSJL2Fch1cJQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 6/15/2021 8:30 AM, Ulf Hansson wrote:
> [...]
> 
>>>
>>>>
>>>> In all honesty, I am a bit surprised that the Linux device driver model
>>>> does not try to default the absence of a ->shutdown() to a ->suspend()
>>>> call since in most cases they are functionally equivalent, or should be,
>>>> in that they need to save power and quiesce the hardware, or leave
>>>> enough running to support a wake-up event.
>>>
>>> Well, the generall assumption is that the platform is going to be
>>> entirely powered off, thus moving things into a low power state would
>>> just be a waste of execution cycles. Of course, that's not the case
>>> for your platform.
>>
>> That assumption may hold true for ACPI-enabled machines but power off is
>> offered as a general function towards other more flexible and snowflaky
>> systems (read embedded) as well.
>>
>>>
>>> As I have stated earlier, to me it looks a bit questionable to use the
>>> kernel_power_off() path to support the use case you describe. On the
>>> other hand, we may not have a better option at this point.
>>
>> Correct, there is not really anything better and I am not sure what the
>> semantics of something better could be anyway.
>>
>>>
>>> Just a few things, from the top of my head, that we certainly are
>>> missing to support your use case through kernel_power_off() path
>>> (there are certainly more):
>>> 1. In general, subsystems/drivers don't care about moving things into
>>> lower power modes from their ->shutdown() callbacks.
>>> 2. System wakeups and devices being affected in the wakeup path, needs
>>> to be respected properly. Additionally, userspace should be able to
>>> decide if system wakeups should be enabled or not.
>>> 3. PM domains don't have ->shutdown() callbacks, thus it's likely that
>>> they remain powered on.
>>> 4. Etc...
>>
>> For the particular eMMC driver being discussed here this is a no-brainer
>  > because  it is not a wake-up source, therefore there is no reason not to
>> power if off if we can. It also seems proper to have it done by the
>> kernel as opposed to firmware.
> 
> Okay, I have applied the $subject patch onto my next branch, along
> with patch 1/2 (the DT doc change).
> 
> However, I still think we should look for a proper long term solution,
> because the kernel_power_off() path does not currently support your
> use case, with system wakeups etc.

Not really, it does work fine, some drivers like gpio-keys.c or
gpio-brcmstb.c will ensure that the GPIOs that are enabled as wake-up
interrupts are configured that way during kernel_power_off() and the
various interrupt controllers like irq-brcmstb-l2.c will make sure they
don't mask wake-up interrupts.

> 
> I guess it could be a topic that is easier to bring up at the Linux
> Plumbers Conf, for example.

OK, not sure if I will be able to attend, but would definitively try to.
-- 
Florian
