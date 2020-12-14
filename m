Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0863D2D98BF
	for <lists+linux-pm@lfdr.de>; Mon, 14 Dec 2020 14:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439742AbgLNN14 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Dec 2020 08:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439741AbgLNN14 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Dec 2020 08:27:56 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333E4C0613CF;
        Mon, 14 Dec 2020 05:27:16 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id h186so1569976pfe.0;
        Mon, 14 Dec 2020 05:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version;
        bh=PBNSOaaUxzAK07xDcs4AhQT/gyQgaFGHouhLALcHT4k=;
        b=NNgW8W4kuCnGJsrJhSjqwejvUkeFk/qSPVzooFFlT/s1vWarX8I3foDCel7IhdkNFy
         qV4OkNvAG2slAqoIR6WoDI3ftHgErzXhxQ4BAuKgX/NAMBv9L0JGDbr/Gp51rhsHxjBR
         MAg8+BYfXJ3KtPCo3ExFWXjbHZ3ClDv0f0YXMpIO+uFvCfvRUPqnGv9AZadUmnUGJGpo
         bGXUt/o7Pr0iUdE79tWUQ/m5Mw9841xypz+2MGZRNfg9/Il3EJOS6DZvjsPcjkBa49ZF
         CJz8ecUHv1geatMsMIojcSbjteYo6xM7s3C6WPIRv8lxPSkAZkh3mWkXTk/LrXfgCW/H
         6wXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
         :user-agent:date:message-id:mime-version;
        bh=PBNSOaaUxzAK07xDcs4AhQT/gyQgaFGHouhLALcHT4k=;
        b=MOcErLRXXgrs2JmFkhfkCN9Kpw6rGRuwWMdN65+gSI/kcfrfZj7R4QYXO4DrOmJzvJ
         OkNtGKWk2sPpFJLfkl9QYOXHT2IakxKrq08LE0Ld6APEx66emYWTzfJvmF6qUAoH5XjX
         1FEBHH+IZrCkx/bbmcv2sSzNBAt2fFNKUcsHxArMo8sr2aClKmjelXmAm4T76gtzKSWl
         Qw8WAfhnBCyko606SK16KZvErpsjZp/ZuEJJtxcvmR04dsYuDQVqYW7qGxjmd/IIEnFv
         NDSzLtp4yseIndzzR/e2Kw/+YRRNQt0PzGS6f9UReGwYknL57Zxmkqwmjf2hSTP3nAIH
         ZdRQ==
X-Gm-Message-State: AOAM530E45j28JyegFW0R5squ2AsJVl98pcqQZdznUiLAGsZKwiAGtwu
        vBGlZcfvhdI4gCmCaD/AWMuiudSt3wDlhp1c
X-Google-Smtp-Source: ABdhPJzlTRqXN7S9RX/A9S85kdYAE5jKaryxmxnoyFvjVhkLBKo9Cy7/zWdEUiEzeAEZwBgA9OyhYQ==
X-Received: by 2002:aa7:92cf:0:b029:19e:aaab:8c0 with SMTP id k15-20020aa792cf0000b029019eaaab08c0mr21258976pfa.35.1607952435646;
        Mon, 14 Dec 2020 05:27:15 -0800 (PST)
Received: from localhost ([2405:6580:31a1:500:1ac0:4dff:fe39:5426])
        by smtp.gmail.com with ESMTPSA id u24sm4902136pjx.56.2020.12.14.05.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 05:27:14 -0800 (PST)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Wei Huang <whuang2@amd.com>, rjw@rjwysocki.net, wei.huang2@amd.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        x86@kernel.org
Subject: Re: [RFC PATCH 2/4] cpufreq: acpi-cpufreq: Add processor to the
 ignore PSD override list
In-Reply-To: <20201214124023.GA25916@zn.tnic> (Borislav Petkov's message of
        "Mon, 14 Dec 2020 13:40:23 +0100")
References: <20201125144847.3920-1-punitagrawal@gmail.com>
        <20201125144847.3920-3-punitagrawal@gmail.com>
        <cadb5d57-5aaf-79bc-e30e-502d5e522689@amd.com>
        <20201207202610.GG20489@zn.tnic>
        <e9b4ae11-1fe3-a660-bb65-d3ba55ffcc56@amd.com>
        <20201207223057.GJ20489@zn.tnic> <87a6unq3xv.fsf@stealth>
        <20201208233216.GH27920@zn.tnic> <871rfvoqy7.fsf@stealth>
        <20201214124023.GA25916@zn.tnic>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Mon, 14 Dec 2020 22:27:09 +0900
Message-ID: <87sg88tt5e.fsf@stealth>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Borislav Petkov <bp@alien8.de> writes:

> On Sat, Dec 12, 2020 at 08:36:48AM +0900, Punit Agrawal wrote:
>> To me it suggests, that there are likely more systems from the family
>> that show the characteristic described below.
>
> Until we find a *single* system with a broken BIOS which has those
> objects kaputt and then this heuristic would need an exception.
>
> VS the clear statement from AMD that from zen3 onwards, all BIOS will be
> tested. I hope they boot Linux at least before they ship.

IIUC, this suggests that Linux booting on anything prior to Zen3 is down
to pure luck - I hope that wasn't the case.

>> In all these systems, the override causes this topology information to
>> be ignored - treating each core to be a separate domain. The proposed
>> patch removes the override so that _PSD is taken into account.
>
> You're still not answering my question: what does the coupling of the
> SMT threads bring on those systems? Power savings? Perf improvement?
> Anything palpable or measurable?

At the moment acpi thermals is bust on this and other affected AMD
system I have access to. That'll need fixing before any sensible
measurements can be run.

Tbh, I didn't quite expect the patch to the PSD exclusion list to be so
controversial - especially when a similar change for zen3 had recently
been merged. If you're really not keen on the change, I will carry it
locally for the time being and revisit once the other issues have been
resolved.
