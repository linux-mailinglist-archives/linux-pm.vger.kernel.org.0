Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0453841AB9F
	for <lists+linux-pm@lfdr.de>; Tue, 28 Sep 2021 11:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239848AbhI1JUJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Sep 2021 05:20:09 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:54804
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239839AbhI1JUJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Sep 2021 05:20:09 -0400
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 50AC74019A
        for <linux-pm@vger.kernel.org>; Tue, 28 Sep 2021 09:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632820709;
        bh=UEwPYoEAcHY9GRKjlSgsfRi7nzOLAdhMhKDnso+q7nw=;
        h=To:Cc:References:From:Subject:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=EtEXOsiNUVViOqqnYXk+SjO9E9PjH/r5G9vzftAw+QVXlNrOMEydrYH2beEEC+jJQ
         rWfgJc3hXmAZbL6NpREzYKFKBBnZwBqu/3ogRh133R8CsGD5POf7tBh+vada4xN6dJ
         MRRQJAt65oD4KrMKfjPpj3fZQKmI/AjLdgbeoYRgKGJbffpA7UQeEIavzh8IY228Vp
         3EgwVx1zID5rVs7iVh1J1EaRY+uLuPZ3SpWMivpPXEOAZHA/e7rTL4wvy7leXbV+9a
         g6AT9y7deXYxb4rlQDccpvwHtjbX8c9QyABgC9Hyo9+mpw7gCA3hNGEiTvWhRuRL6M
         I9UEaWWJaYohw==
Received: by mail-lf1-f71.google.com with SMTP id h27-20020a0565123c9b00b003fca9e11144so17580225lfv.19
        for <linux-pm@vger.kernel.org>; Tue, 28 Sep 2021 02:18:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UEwPYoEAcHY9GRKjlSgsfRi7nzOLAdhMhKDnso+q7nw=;
        b=nzwAwzvQygWuAyCD0i99aA+W9kZYk6qt/v7D9kgXlW0opJyVi0xNMF7SypZHj/ad2R
         A5mB5pku4DW1ZdBegSgXl4EXpTp4fXl6GvwntKLbNPN/Scj8VCS3GvHVDg0bp+vt9gZE
         Lck77SQX9myfKQa/HEvPoOEP1mYD4PYSbzTCnGdiq6LYgnl1ujuJsUUTFYR0HEtTl7Zs
         k/wQawk3hpeER9/IcgbhnbokylxLi/+jAfZANxJPavLijLhPEepk23m6+HQSZOpeLIaK
         MWarX4+jI2AX4E1aw35TtZbD7i0FZxVmEZtpQrNkVU8E1gJGeTKUib76GbF0+QibkI5A
         Z15g==
X-Gm-Message-State: AOAM530LpxYApGC+yOS/5FeLh8SkPakb0H9lc4ziZ0g6/dnOhpSVjTPU
        yAQazLbwHgV8NJzQM/tEp01dfWS6nMWiGnFnvUv9x19hNiZsVfPyPwsa0qcLlwYCMmbZQoVdM76
        KbJrhOcDSpR0D5Y0AuAzU3RJMNftdUMZvGAht
X-Received: by 2002:a19:690e:: with SMTP id e14mr1909515lfc.553.1632820708685;
        Tue, 28 Sep 2021 02:18:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKDYuABfvueO2sPn1V9pQTgAf7Uce/FLkCD7Ov7RDKIV6bQ5b9lHhYZmBF9fvl/Y220gV2/Q==
X-Received: by 2002:a19:690e:: with SMTP id e14mr1909501lfc.553.1632820708509;
        Tue, 28 Sep 2021 02:18:28 -0700 (PDT)
Received: from [192.168.0.20] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id v18sm2299366ljg.95.2021.09.28.02.18.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 02:18:28 -0700 (PDT)
To:     Henrik Grimler <henrik@grimler.se>
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, wolfgit@wiedmeyer.de,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Hans de Goede <hdegoede@redhat.com>,
        Nikita Travkin <nikita@trvn.ru>
References: <20210919200735.142862-1-henrik@grimler.se>
 <20210919200735.142862-2-henrik@grimler.se>
 <17ba5aaa-c456-2bb9-1680-ff0a302b412f@canonical.com>
 <YVIWC5gehfh3TXX/@grimlerstat.localdomain>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH 1/1] power: supply: max17042_battery: use VFSOC for
 capacity when no rsns
Message-ID: <6b77953f-cbad-5688-7364-667975309f8f@canonical.com>
Date:   Tue, 28 Sep 2021 11:18:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YVIWC5gehfh3TXX/@grimlerstat.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27/09/2021 21:05, Henrik Grimler wrote:
> On Fri, Sep 24, 2021 at 01:45:29PM +0200, Krzysztof Kozlowski wrote:
>> Thanks for the patch. I found also my comments to Wolfgang's patch in
>> 2016, which you resolve here but I have more. :)
>>
>> I think my previous message about current sense are not correct. What is
>> important is whether ModelGauge is being used/configured. For example
>> none of DT platforms support it but ACPI might.
>> There is incoming patch around it:
>> https://lore.kernel.org/lkml/5702731.UytLkSCjyO@pliszka/
>>
>> If you switch to VSSoc, I think you need to modify the SOC Alert Config
>> in MiscCFG register (bits 0:1 to 0x1). Otherwise the alerts will be
>> generated on different value.
> 
> So, 0x1 should correspond to AvSOC (i.e. non-filtered RepSOC), while
> right now we write 0x3 (VFSOC) to MiscCFG for devices without current
> sense [1]. Could you elaborate on why AvSOC should be used for alert
> if we use VFSOC to get PROP_CAPACITY?

I meant that same measurement should be used for both: for PROP_CAPACITY
and for alerts.

I double checked the driver and your change is actually aligned with it.
If !enable_current_sense, the driver will set MiscCFG to 0x3 to use
VFSOC for alerts. I think you can ignore that part of my comment before.

However still remaining issue is that switching to VFSoc should happen
not only if !enable_current_sense but also if ModelGauge m3 is not
configured.

> On this particular device it does not seem to make a difference what I
> use for the SOC alert, the alert triggers all the time in any case
> since RepSOC does not give an accurate value. Supposedly this happens
> because ModelGauge configuration is incomplete, as you said. Looking
> at the registers used by the ModelGauge it seems that only the
> "characterization table" at 0x80 - 0xAF is missing. The rest (FullCap,
> DesignCap, ICHGTerm, ..) are set to the same values as with vendor
> kernel.

Are you sure? I could not find setting of these (e.g.
MAX17042_FullCAP/config->fullcap) for a DT platform.

Best regards,
Krzysztof
