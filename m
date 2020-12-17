Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C54312DD222
	for <lists+linux-pm@lfdr.de>; Thu, 17 Dec 2020 14:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgLQN2A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Dec 2020 08:28:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727723AbgLQN17 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Dec 2020 08:27:59 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BD8C061794;
        Thu, 17 Dec 2020 05:27:19 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id hk16so4114862pjb.4;
        Thu, 17 Dec 2020 05:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=GuvWsv2yH33NCbzze1u2wOKepqpjiXX/reGunhKlIKk=;
        b=IEF3qBmbCLKSbITyeNNTcsR769DfrQUerOvbCp6Aebs20HURcKK8Cs3qdCNR52SADp
         BcWy88BxAlOc+5x8GWElaHfbG4rps9aKsgb7rUPOuFMIozVEEfZVFBBJU7xLd8kxUVyD
         3QHPh3plxxjlRC+VwpJ6jAl37p5KdGBripJkh64xVHC2VoAhXGMRkbQtPKg/SGBiv5Di
         f/L5ogRVPo16XxdOm4WBQUXbgye2NHSGJKLRvrvpqL5wzicwckApQtNLf1TuQ+WnKDSm
         EI8TCwkv8f7njbGFvNXuajSdgVP9baGsXo3Y5jUfiwSTZeEsJcteztxlQIC+j/cxk2vP
         UdMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=GuvWsv2yH33NCbzze1u2wOKepqpjiXX/reGunhKlIKk=;
        b=Qex3mIxGo8Q9rkcg30MmzA71TAatjnVcPaqhBQ5KiVZeuq4iHLGpFeb3t5ueo9i68t
         0M6tSG5psyNT6EkEHhHE6mlM5iUO7RaAmUg+grHjw1odV2hRbHRUdQVWh0fSsBbs3Bh0
         QkP4YyTRbCXQpNoSx17E2+OWSoXX4wngPEu+mPWbdmF4SJX0EZc72nchbt+V9Rrxta/O
         NyEcB9E/BknSKD4dkjtghRdfU7NBW82qYvAVnbuZqzdl9mogg9u+Knr8GAwOHlP1s0is
         H2kRWo6g4hinifkFwCjuCC33xUaiux61/1isrL+ulqI1RV2YC6SxU+98/Pb6pFTpsrRl
         RE2Q==
X-Gm-Message-State: AOAM532hVElZDGlDfIk6iAoZjLU2wAfDmwhCtc0u7gcnfB26HjNkaZg9
        uRjsYtpVdFBqRWvNkqCR0Cw=
X-Google-Smtp-Source: ABdhPJwwH0pFYFGlogGbCovlTaH6DTtnk4vYuGwWFIcW7jXuU8q659i6hONb2RC0omh9aXs8zo1WtA==
X-Received: by 2002:a17:902:7d84:b029:db:feae:425e with SMTP id a4-20020a1709027d84b02900dbfeae425emr17803897plm.43.1608211639098;
        Thu, 17 Dec 2020 05:27:19 -0800 (PST)
Received: from localhost ([2405:6580:31a1:500:1ac0:4dff:fe39:5426])
        by smtp.gmail.com with ESMTPSA id r7sm4873129pjd.55.2020.12.17.05.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 05:27:17 -0800 (PST)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Wei Huang <whuang2@amd.com>, rjw@rjwysocki.net, wei.huang2@amd.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        x86@kernel.org
Subject: Re: [RFC PATCH 2/4] cpufreq: acpi-cpufreq: Add processor to the
 ignore PSD override list
References: <20201125144847.3920-3-punitagrawal@gmail.com>
        <cadb5d57-5aaf-79bc-e30e-502d5e522689@amd.com>
        <20201207202610.GG20489@zn.tnic>
        <e9b4ae11-1fe3-a660-bb65-d3ba55ffcc56@amd.com>
        <20201207223057.GJ20489@zn.tnic> <87a6unq3xv.fsf@stealth>
        <20201208233216.GH27920@zn.tnic> <871rfvoqy7.fsf@stealth>
        <20201214124023.GA25916@zn.tnic> <87sg88tt5e.fsf@stealth>
        <20201214142540.GB25916@zn.tnic>
Date:   Thu, 17 Dec 2020 22:27:14 +0900
In-Reply-To: <20201214142540.GB25916@zn.tnic> (Borislav Petkov's message of
        "Mon, 14 Dec 2020 15:25:40 +0100")
Message-ID: <87ft44tvf1.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Borislav Petkov <bp@alien8.de> writes:

> On Mon, Dec 14, 2020 at 10:27:09PM +0900, Punit Agrawal wrote:
>> IIUC, this suggests that Linux booting on anything prior to Zen3 is down
>> to pure luck - I hope that wasn't the case.
>
> WTF does this have to do with linux booting?!

I guess I misunderstood the comment from your previous mail. Pasting
back for context (emphasis mine) -

    VS the clear statement from AMD that from zen3 onwards, all BIOS
    will be tested. *I hope they boot Linux at least before they ship.*

>> At the moment acpi thermals is bust on this and other affected AMD
>> system I have access to. That'll need fixing before any sensible
>> measurements can be run.
>
> Nope, still not answering my questions.
>
>> Tbh, I didn't quite expect the patch to the PSD exclusion list to be
>> so controversial
>
> It won't be if you explain properly what your patch is fixing. That is,
> if it fixes anything.

I stared at the driver code (and the ACPI tables for the platform) to
see if I could provide a better explanation.

That's when I realised that as the platform advertises hardware
frequency co-ordination, even without the override it still skips
setting the policy cpus -

    /*
     * Will let policy->cpus know about dependency only when software
     * coordination is required.
     */
    if (policy->shared_type == CPUFREQ_SHARED_TYPE_ALL ||
        policy->shared_type == CPUFREQ_SHARED_TYPE_ANY) {
            cpumask_copy(policy->cpus, perf->shared_cpu_map);
    }

This ends up treating each CPU as an independent frequency domain
anyways. So even ignoring the override for the CPU, doesn't change
anything other than dropping the message from boot log -

    overriding BIOS provided _PSD data

As such, there's no point in merging the patch as it is.

Apologies for the noise. I should've checked more thoroughly before
sending the patches. 

[ Aside: If Zen3 is using hardware co-ordination it'll probably face the
issue described above as well. ]
