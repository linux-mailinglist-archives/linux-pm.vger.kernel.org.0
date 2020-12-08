Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 201942D36D9
	for <lists+linux-pm@lfdr.de>; Wed,  9 Dec 2020 00:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731701AbgLHXWd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Dec 2020 18:22:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgLHXWc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Dec 2020 18:22:32 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE607C0613CF;
        Tue,  8 Dec 2020 15:21:52 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id n7so13673704pgg.2;
        Tue, 08 Dec 2020 15:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version;
        bh=0FJ1YRYImxMmlQO2LI5uIhefrNRA07khzv3xrFgG2/8=;
        b=bLFNeFt/2RhDPIS8pWvEM0dRjVlLC8QByxPqyI/RFQt9zmezzqbAT2Q5CjkDoifkV0
         jiEgz2X7vDbBF+pLttmd3abTTz5Tky1dCm3EyVUfgWi9xnnOTOjTpJG2Sq3V6/LkVX9s
         5YPcnz68VhA276jDZFLf5az94kWtX6Q0v1phjfFGaNNpIQEYLi3kfi5b4PNgUFeOlHpT
         CrtugzHj7ZBxN4TGEhgPRpdnJxRnSya95SEl25dx1Fz2M4p80dWKRvhIeL99mjrq/GUy
         mlhOwrOm5/a1dKX1KnBHyokCHj34j4uUwLDrv8QD29AtUm3LjuxVzsoxs+2LAgbDGLU+
         NMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
         :user-agent:date:message-id:mime-version;
        bh=0FJ1YRYImxMmlQO2LI5uIhefrNRA07khzv3xrFgG2/8=;
        b=ojxvOiiPH3O/0Kt+x+SJv/ZBL7S2g4NG+6n6n1ZGbJApfshje+S2N6+Wewo3R9zwTX
         4A1L4P40eI4YV8vKtwl252nGT+ObIH9JiyhGop5z/8d6jAMYIXmlFmml0EfbrEK++zpY
         suPTllfL6L8lUi7NjoE2MygFl9CaddkaaD85cfYr5goCpCyhKUwcpbZnI9lgifq6bBDJ
         t6RXNaiX0ftK2QWJ+zgN4oORqFRgOVp8uzOolh8mQFaquj59hnBf79CTCCtJYCCe6WT6
         7ptsmBqow/9hyxQdfRXTtJXvDhc/EKA4QZLe6DGIf+EQwU+F1ucsITP9ClRyrbRbhz5d
         Mc4Q==
X-Gm-Message-State: AOAM5331P4gXFi1mCuc99uHDPQzvk/RS6RRp6vPPrRBOzswEzjo1+Lfh
        R5NDnL7YR5yXjObb9s5A9Ks=
X-Google-Smtp-Source: ABdhPJxYy+ceWo18jWrtQFFCSJHlpJNnkt7SRQwBZsQlrjTQAd9b7hGj51pR3GeTkV8Lk+Q0Kk7Fgw==
X-Received: by 2002:a17:90a:a012:: with SMTP id q18mr29043pjp.223.1607469712311;
        Tue, 08 Dec 2020 15:21:52 -0800 (PST)
Received: from localhost ([2405:6580:31a1:500:1ac0:4dff:fe39:5426])
        by smtp.gmail.com with ESMTPSA id y6sm247897pfn.145.2020.12.08.15.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 15:21:51 -0800 (PST)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Wei Huang <whuang2@amd.com>, rjw@rjwysocki.net, wei.huang2@amd.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        x86@kernel.org
Subject: Re: [RFC PATCH 2/4] cpufreq: acpi-cpufreq: Add processor to the
 ignore PSD override list
In-Reply-To: <20201207223057.GJ20489@zn.tnic> (Borislav Petkov's message of
        "Mon, 7 Dec 2020 23:30:57 +0100")
References: <20201125144847.3920-1-punitagrawal@gmail.com>
        <20201125144847.3920-3-punitagrawal@gmail.com>
        <cadb5d57-5aaf-79bc-e30e-502d5e522689@amd.com>
        <20201207202610.GG20489@zn.tnic>
        <e9b4ae11-1fe3-a660-bb65-d3ba55ffcc56@amd.com>
        <20201207223057.GJ20489@zn.tnic>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Wed, 09 Dec 2020 08:21:48 +0900
Message-ID: <87a6unq3xv.fsf@stealth>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Borislav Petkov <bp@alien8.de> writes:

> On Mon, Dec 07, 2020 at 04:07:52PM -0600, Wei Huang wrote:
>> I think we shouldn't override zen2 if _PSD is correct. In my opinion,
>> there are two approaches:
>> 
>> * Keep override_acpi_psd()
>> Let us keep the original quirk and override_acpi_psd() function. Over
>> the time, people may want to add new CPUs to override_acpi_psd(). The
>> maintainer may declare that only CPUs >= family 17h will be fixed, to
>> avoid exploding the check-list.
>> 
>> * Remove the quirk completely
>> We can completely remove commit acd316248205 ("acpi-cpufreq: Add quirk
>> to disable _PSD usage on all AMD CPUs")? I am not sure what "AMD desktop
>> boards" was referring to in the original commit message of acd316248205.
>> Maybe such machines aren't in use anymore.
>
> * Third option: do not do anything. Why?
>
> - Let sleeping dogs lie and leave the workaround acd316248205 for old
> machines.

According to the commit log, acd316248205 seems to be only targeted at
powernow-K8 -

    "in order to use the hardware to its full potential and keep the
    original powernow-k8 behavior, lets override the _PSD table setting on
    AMD hardware."

It's unfortunate that it has continued to apply to all systems since. An
alternate to this and 5368512abe08 would be to restrict the original
workaround to the system mentioned in the commit log.

> - Make a clear cut that the override is not needed from Zen3 on, i.e.,
> your patch
>
>    5368512abe08 ("acpi-cpufreq: Honor _PSD table setting on new AMD CPUs")
>
>
> Punit's commit message reads "...indicates that the override is not
> required for Zen3 onwards, it seems that domain information can be
> trusted even on certain earlier systems."
>
> That's not nearly a justification in my book to do this on anything <
> Zen3.
>
> This way you have a clear cut, you don't need to deal with adding any
> more models to override_acpi_psd() and all is good.

PSD (P-State Dependency) object is used to express the coupling of
processors that share the same frequency domain. Ignoring the hardware
topology information will cause both power management and scheduling to
make sub-optimal choices.

Wasn't this the motivation for taking it into account for Zen3 based
systems in 5368512abe08? Or the powernow-k8 in the original workaround
(though there it required ignoring firmware)? The exact same argument
applies here to the Zen2 system I have running in a thermally
constrained environment.

In an ideal case, I was hoping AMD folks would come back with
confirmation of how far back the override can be dropped and the
workaround condition could be relaxed further. But if that is not
available, the only way we have is to include systems that have been
verified to not need the override and somebody that cares to send the
patch.
