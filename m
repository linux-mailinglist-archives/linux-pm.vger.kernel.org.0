Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45E5A2D36E3
	for <lists+linux-pm@lfdr.de>; Wed,  9 Dec 2020 00:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731582AbgLHXZv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Dec 2020 18:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgLHXZu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Dec 2020 18:25:50 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3C0C0613D6;
        Tue,  8 Dec 2020 15:25:10 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id s21so121894pfu.13;
        Tue, 08 Dec 2020 15:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=XFoNwmiRWpNpmOeN4HBz6edK6SX4pgenNv89iRzJA+0=;
        b=MGkaAAWiDDhM/K5OZtLcxTQIvWgcVEln/QhbkhdSU6iF6axCS24aoAu66AV2dZlZWJ
         NaK24CvPrQpXzfPZ0ADsS3lAJMtoD/Afmyu6gH1+pxwPdixtM62315PgbcARbCbafkvS
         bNXSmTmBcOZub29uFcpsxqAq5nVzv3gSwCQZacnGIAW2FUwym7utmPT8BDimHcH+ACdZ
         nlaCALqJKgvO8TUP1ZUOvVJzQJ5+3BWobTQd4lnh4ykqcfjPpqG+abSSBAGoldQbIZbd
         nFWS5LYu/AprzJ3qCPhOmXL1q4rUrE8yZvPyAwsP5T2ypZDiAFNb43od7/bobnlhuALr
         PWRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=XFoNwmiRWpNpmOeN4HBz6edK6SX4pgenNv89iRzJA+0=;
        b=t0BOhBNQ4sIhbRVelGfwQSBMTixxo4MiUnyNgGZsxdaDnTl4sUpA0M/BWjzWD9PpD5
         KeiuQNpYqBh5W5bl3qr9+44+ekyzefL7PKrhEYWoI7vk16Wl0xCA7X3ACEFzMvaBfpDU
         To7Q2e/y1dhT0Wz0VYXLdgPI/Z42OHF51qkqPO1GZBn//WVnHD4uocaZjQW3gnXlUx8R
         n+VLCfOFOwUZkY7KymWBOoDPiaHyTtTpBXuHnez/Bo76lGvdpnjGXvtjNvlyjYGoGPot
         zV4P2LeE2qfO7qkhA/W2eqse2ThOTTQ6gh4bqJzg+rFcKUfRWoexfdbI8uzjEYZ5ospt
         Ipig==
X-Gm-Message-State: AOAM531VcCha4LKfgMwlt3wvtXTSrtMtMTQCNqlyOxuxgasN95r0XvI7
        cq18I3cupChEtb/SkBXCEVo=
X-Google-Smtp-Source: ABdhPJw3yQQd7TERf4lYaLgWlZaUS+GmNdzuS0xor7LybejZeQuzRIT6bDmEesM9ZW5w5kqhX9O1vg==
X-Received: by 2002:a17:90a:1b0d:: with SMTP id q13mr75796pjq.21.1607469910376;
        Tue, 08 Dec 2020 15:25:10 -0800 (PST)
Received: from localhost ([2405:6580:31a1:500:1ac0:4dff:fe39:5426])
        by smtp.gmail.com with ESMTPSA id u24sm266812pfm.51.2020.12.08.15.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 15:25:09 -0800 (PST)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Wei Huang <wei.huang2@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>
Subject: Re: [RFC PATCH 0/4] Add processor to the ignore PSD override list
References: <20201125144847.3920-1-punitagrawal@gmail.com>
        <87zh2tp4x2.fsf@stealth>
        <CAJZ5v0gXSN+JcakF6jwnUYgej=LRyYc_jCff07Nx=nGO1a3mfw@mail.gmail.com>
Date:   Wed, 09 Dec 2020 08:25:07 +0900
In-Reply-To: <CAJZ5v0gXSN+JcakF6jwnUYgej=LRyYc_jCff07Nx=nGO1a3mfw@mail.gmail.com>
        (Rafael J. Wysocki's message of "Mon, 7 Dec 2020 14:55:17 +0100")
Message-ID: <87360fq3sc.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

"Rafael J. Wysocki" <rafael@kernel.org> writes:

> On Fri, Dec 4, 2020 at 11:45 PM Punit Agrawal <punitagrawal@gmail.com> wrote:
>>
>> Hi Rafael,
>>
>> Punit Agrawal <punitagrawal@gmail.com> writes:
>>
>> > Hi,
>> >
>> > While looking into Giovanni's patches to enable frequency invariance
>> > on AMD systems[0], I noticed an issue with initialising frequency
>> > domain information on a recent AMD APU.
>> >
>> > Patch 1 refactors the test to ignore firmware provided frequency
>> > domain into a separate function.
>> >
>> > Patch 2 adds said APU (Family: 0x17, Model: 0x60, Stepping: 0x01) to
>> > the list of CPUs for which the PSD override is ignored. I am not quite
>> > happy with having to special case a particular CPU but also couldn't
>> > find any documentation to help identify the CPUs that don't need the
>> > override.
>>
>> Are you be OK to pick the first two patches if there are no issues?
>
> Please send them as non-RFC and change the name of override_acpi_psd()
> to indicate that it is AMD-specific.

Ack - I will incorporate your comments in the next version (once the
ongoing discussion finishes).

Thanks.
