Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F19285D16
	for <lists+linux-pm@lfdr.de>; Wed,  7 Oct 2020 12:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbgJGKoD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Oct 2020 06:44:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21305 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726096AbgJGKoC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Oct 2020 06:44:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602067440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Afqtaj9YGTNyFKnlxC+EHrLbHcV8SnptjdKNT34NPOU=;
        b=ELUnrwNlzWZFjlCza0qZurW1hZWfG6E1Pbkz2kMNvjq7uJrlY3FKnO929YX7brJ1DWtoxm
        8QHPlv+vpTnVyemhv3kigQa/30qd5HGUfkyV/NBSYbQEKbqWJ4nK5XUO/SDi1g68NPZidU
        JuZu8sDXqoH02dytRetDj/PVWrabqwI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-A0EBfbwzPpq-VfMh8UG8Vw-1; Wed, 07 Oct 2020 06:43:59 -0400
X-MC-Unique: A0EBfbwzPpq-VfMh8UG8Vw-1
Received: by mail-ej1-f69.google.com with SMTP id s20so618405ejx.19
        for <linux-pm@vger.kernel.org>; Wed, 07 Oct 2020 03:43:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Afqtaj9YGTNyFKnlxC+EHrLbHcV8SnptjdKNT34NPOU=;
        b=ZhBkHq5mrHG9zNnJqeeLKUHIFt4/PwJQs0Riq+Ej3fKyAp+ubiCBx3oULGW5MqDSmb
         aKyEPfaBoksqivUnCu/V35DphuXhTEDDmYKEBlOnyR0dLZ0l3dQ1MwHqZ1kdoiKbAOOa
         qAGzG+LBMS1qOxjvpkkkb+5vSU+afgX1Nph9rxw5g8yi3Vlpns2Q9iZt9GNS20Z9res/
         3jBvA2ZI3VxA8UmHAeX+BY2K1B2iol9eIV1A25oO304fqIuRL9SLItZCIsbrG2qSPmkW
         UWqobPSseWxl67ieVPnGF2V4AjlZYGMLbkOUeVEfWdUNAmcM9acc3RRYxyS6K7KH9gER
         4pvg==
X-Gm-Message-State: AOAM531brmUxp5QzI55ZPdx82XeSUF6XNSztFa6owC9cwbriwetKSPV7
        y5QGR+1/xnPe/eduBWhVwYFK90NcxUNdE5BdPnwiz3RAdef+Syj+ih/WPxO/UKW6k8LUyMn8HZr
        soZwCDQmVo+EOmFyEUZw=
X-Received: by 2002:a17:906:5fc6:: with SMTP id k6mr2670098ejv.494.1602067437408;
        Wed, 07 Oct 2020 03:43:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztInw6msXFcxzTPkh0FdiJxXhuHIih0Cqt1EYMAAZVvliSEPKTKpghAaXWPq6ZTA//xVHVPA==
X-Received: by 2002:a17:906:5fc6:: with SMTP id k6mr2670082ejv.494.1602067437169;
        Wed, 07 Oct 2020 03:43:57 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id o3sm1192485edv.63.2020.10.07.03.43.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2020 03:43:56 -0700 (PDT)
Subject: Re: [PATCH 0/4] powercap/dtpm: Add the DTPM framework
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org,
        srinivas.pandruvada@linux.intel.com
Cc:     lukasz.luba@arm.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rui.zhang@intel.com
References: <20201006122024.14539-1-daniel.lezcano@linaro.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <eb26a00d-eee0-a4d1-ed25-61a661ad5683@redhat.com>
Date:   Wed, 7 Oct 2020 12:43:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201006122024.14539-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 10/6/20 2:20 PM, Daniel Lezcano wrote:
> The density of components greatly increased the last decade bringing a
> numerous number of heating sources which are monitored by more than 20
> sensors on recent SoC. The skin temperature, which is the case
> temperature of the device, must stay below approximately 45°C in order
> to comply with the legal requirements.
> 
> The skin temperature is managed as a whole by an user space daemon,
> which is catching the current application profile, to allocate a power
> budget to the different components where the resulting heating effect
> will comply with the skin temperature constraint.
> 
> This technique is called the Dynamic Thermal Power Management.
> 
> The Linux kernel does not provide any unified interface to act on the
> power of the different devices. Currently, the thermal framework is
> changed to export artificially the performance states of different
> devices via the cooling device software component with opaque values.
> This change is done regardless of the in-kernel logic to mitigate the
> temperature. The user space daemon uses all the available knobs to act
> on the power limit and those differ from one platform to another.
> 
> This series provides a Dynamic Thermal Power Management framework to
> provide an unified way to act on the power of the devices.

Interesting, we have a discussion going on about a related
(while at the same time almost orthogonal) discussion for
setting policies for if the code managing the restraints
(which on x86 is often hidden in firmware or ACPI DPTF tables)
should have a bias towards trying to have as long a battery life
as possible, vs maximum performance. I know those 2 aren't
always opposite ends of a spectrum with race-to-idle, yet most
modern x86 hardware has some notion of what I call performance-profiles
where we can tell the firmware managing this to go for a bias towards
low-power / balanced / performance.

I've send a RFC / sysfs API proposal for this here:
https://lore.kernel.org/linux-pm/20201003131938.9426-1-hdegoede@redhat.com/

I've read the patches in this thread and as said already I think
the 2 APIs are mostly orthogonal. The API in this thread is giving
userspace direct access to detailed power-limits allowing userspace
to configure things directly (and for things to work optimal userspace
must do this). Where as in the x86 case with which I'm dealing everything
is mostly handled in a black-box and userspace can merely configure
the low-power / balanced / performance bias (*) of that black-box.

Still I think it is good if we are aware of each-others efforts here.

So Daniel, if you can take a quick look at my proposal:
https://lore.kernel.org/linux-pm/20201003131938.9426-1-hdegoede@redhat.com/

That would be great. I think we definitely want to avoid having 2
APIs for the same thing here. Again I don't think that is actually
the case, but maybe you see this differently ?

Regards,

Hans


*) bias might not always give the correct impression at least
on some Thinkpads switching from balanced (which they call medium)
to performance boosts the long time power-limit from aprox.
15W to 25W which as expected results in a significant performance
boost.

Note usually we have no idea what the black-box knob which we are
tweaking actually does, all we know is that it is there and
Windows 10 often has a slider to configure it and users want
the same functionality under Linux.

