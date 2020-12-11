Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 312F62D82CF
	for <lists+linux-pm@lfdr.de>; Sat, 12 Dec 2020 00:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406887AbgLKXiB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Dec 2020 18:38:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392147AbgLKXhc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Dec 2020 18:37:32 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A04FC0613D3;
        Fri, 11 Dec 2020 15:36:52 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id f14so2966293pju.4;
        Fri, 11 Dec 2020 15:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=JVHTTreEM2z5Jb4a2Pg0lMUiVLM2zzxERaeVoukhzjk=;
        b=MbrhpZ0uIHXrtdroa40nBt7WQ6zvm981oT4fFYbJQ66l43weByvwokjuT2pLdPGOib
         sE9yuKjLAqnF1NL0xuiqNN8DHtP+J+7XNryn03AwXLJGKrLHimjLFTtdvGVCOntDZeh2
         TH5sOf2OiTWoP4mIiqXrbutGTZyrJnpohuonyOdF2KN/DHKlLXJkoyM3ZTg6jj+Xx/Jq
         nvYiQIWYIbWKooi1X7SblpcP86eXpyIqeTmLEGS5Cq4y3WZFs33xbY7CKg3RL7IJysVS
         pPtCYhr72ticU2x/RS6FmGDoEEejZ8iGparkTVBRaou8cIQKhUPVk/SCBlmgAN//4vg8
         gW2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=JVHTTreEM2z5Jb4a2Pg0lMUiVLM2zzxERaeVoukhzjk=;
        b=s9dAy2r9KrvNBKw7/5BkCCcxD1pjDJQFdQ8R8gOVE9rge4aVAwcSopYDhMCzhc8Ont
         dsT5PkCWOcA5CiFZ26ndzLYxzhB6o0scIMI7AYo8P3djLZRUogTdzdfqROaPwu6wi+KW
         K+yTZsQefGaFJKJ4q3B2YJYVcOgfpBoxeCx0IX/TQ6vaAfOdw/j2m1piHz9f9+IQXHVV
         n6LFez4yQ7AIXxdurkQ1hnkEhn+p9/HWlSaYPNHSyD1Oc13qBg5lWjUpCSlRMFA0ZbvF
         fcu3MRy/WGVs7PLr+V91kErXuk3iLeDtdjzIoIecHrEMh/+9rBL/s/dLTBpgl5uZQCfu
         iuxw==
X-Gm-Message-State: AOAM532oFZqsCnJkVUD5ioTlpxu+i9ROe6jHIbmVdewiwDLAp0o5vMmZ
        XZWpXRufW1Hu7uKqtxu4vXA=
X-Google-Smtp-Source: ABdhPJzN4u6Wr+ypi9bODdcuQDcMwO+SZ18v3vpTjdDWY389q1Sfd4zEFiQlV/UW1yp18IP+01bLQA==
X-Received: by 2002:a17:902:6a82:b029:da:fc41:bafe with SMTP id n2-20020a1709026a82b02900dafc41bafemr13117554plk.20.1607729811928;
        Fri, 11 Dec 2020 15:36:51 -0800 (PST)
Received: from localhost ([2405:6580:31a1:500:1ac0:4dff:fe39:5426])
        by smtp.gmail.com with ESMTPSA id j10sm11725336pgc.85.2020.12.11.15.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 15:36:51 -0800 (PST)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Wei Huang <whuang2@amd.com>, rjw@rjwysocki.net, wei.huang2@amd.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        x86@kernel.org
Subject: Re: [RFC PATCH 2/4] cpufreq: acpi-cpufreq: Add processor to the
 ignore PSD override list
References: <20201125144847.3920-1-punitagrawal@gmail.com>
        <20201125144847.3920-3-punitagrawal@gmail.com>
        <cadb5d57-5aaf-79bc-e30e-502d5e522689@amd.com>
        <20201207202610.GG20489@zn.tnic>
        <e9b4ae11-1fe3-a660-bb65-d3ba55ffcc56@amd.com>
        <20201207223057.GJ20489@zn.tnic> <87a6unq3xv.fsf@stealth>
        <20201208233216.GH27920@zn.tnic>
Date:   Sat, 12 Dec 2020 08:36:48 +0900
In-Reply-To: <20201208233216.GH27920@zn.tnic> (Borislav Petkov's message of
        "Wed, 9 Dec 2020 00:32:16 +0100")
Message-ID: <871rfvoqy7.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Borislav Petkov <bp@alien8.de> writes:

> On Wed, Dec 09, 2020 at 08:21:48AM +0900, Punit Agrawal wrote:
>> According to the commit log, acd316248205 seems to be only targeted at
>> powernow-K8 -
>
> No, it is not targeted at powernow-k8 - acpi-cpufreq.c is what is used
> on AMD hw. He means to make acpi-cpufreq's behavior consistent with
> powernow-k8.

So "powernow-k8" is not a cpu but a cpufreq driver. That doesn't change
the fact that the patch causes all AMD systems using acpi-cpufreq to
ignore processor frequency groupings and treat each processor to be an
in independent frequency domain from cpufreq's point of view.

>> But if that is not available, the only way we have is to include
>> systems that have been verified to not need the override
>
> You have verified exactly *one* system - yours. Or are you sure that
> *all* family 0x17, model 0x60, stepping 0x1 machines don't need the
> override?

Unfortunately, I only have access to one system with that F/M/S.

Since posting the non-RFC patches, I was able to inspect the ACPI tables
for more CPUs -

Family: 0x17h, Model: 0x71h (Ryzen 3950X)
Family: 0x17h, Model: 0x18h (Ryzen 3500u)

To me it suggests, that there are likely more systems from the family
that show the characteristic described below.

> Also, you still haven't explained what you're trying to fix here.

All the CPUs here are multi-threaded with 2 threads per core. The _PSD
for the system describes the cores as having a coupling that consist of
a frequency domain per core that contains both the threads. The firmware
description makes sense and seems to accurately describe the hardware
topology.

In all these systems, the override causes this topology information to
be ignored - treating each core to be a separate domain. The proposed
patch removes the override so that _PSD is taken into account.
