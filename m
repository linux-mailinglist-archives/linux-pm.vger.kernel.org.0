Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4512CF70E
	for <lists+linux-pm@lfdr.de>; Fri,  4 Dec 2020 23:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730382AbgLDWp0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Dec 2020 17:45:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728734AbgLDWpZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Dec 2020 17:45:25 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E2DC0613D1;
        Fri,  4 Dec 2020 14:44:45 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id p6so3947716plr.7;
        Fri, 04 Dec 2020 14:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version;
        bh=yuYclua/K6G1/NzZklfhnByGsvXi5uYNWph4XL2hSIs=;
        b=jGEvaLZ55EZaXGmYyljajBzGveSvX8t6YtByTv0yzn5xEk0mNTJgF7uyHpKEzjdV/v
         nJl3bg0njIZuBPeuyDtaVdEOBu86zM8qC7bEtrPJ6bIfDiTN6VZne6VYV/qMr7E6iY41
         aTyrl85v6Ii0bCj5oNlOz5phachxznzAkgqCFEAyT/AzgmT3ZqSRy7vHr8rF1zaJ2UFE
         I8i2KgFpHe+BNsy9KIZ0Fn53ocC+1KyI6hr+HrURAoDJ449GCTHkuNwFfIq/bdyE/ICy
         bIdlux3DXZPAjIqcjNq1N08wJAE2K+ybGKzHnrkoGFWZxBGh+ewBAd986wx0iNmKIv4p
         Jhhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
         :user-agent:date:message-id:mime-version;
        bh=yuYclua/K6G1/NzZklfhnByGsvXi5uYNWph4XL2hSIs=;
        b=r3dfBph2XwHycJJpcYjFFRsRsyCUJnws7PmCLPHhkuQ7IiWJVtpvSb79Xfi18G2H0P
         aRxG2JOGV2Iyg+rTtquAviHnb+2QiGJbKsiEHS1YNL34lYnvM7SUJP4B3bY0sL8xhF2t
         +3sfWz7qc+Vpd8J9D+uTfk+0m8/uX6Y0mj/rhpEZP2W4acdaWfe+TVr9GRyYIMZVk4aM
         /6Ntad6NQ8l55MDg6Jly3lDRAbF0dkCvfeMsaNCkFoPQ9aLP61qws6KGWlpBqThZ61/l
         AKS/Cq2isaiKdgnd82QOw5IItnXFuDeYdAfw6qMokU2tM7CRLcgtf15UcrYJgmPGxd8n
         6nlg==
X-Gm-Message-State: AOAM533ufg621CQdS9DEBHiFTRAENiY6immUR4GShOV1E4ZEszvEZc4Z
        tgWEVDBjiaR30IlRO0AMUhg=
X-Google-Smtp-Source: ABdhPJzobywerg8vaX5EtSuLsD9/y1ZfSYBHaXKoc9X8ALE2TfXiatvkFUNK1lvdB13oZaUEAKWGng==
X-Received: by 2002:a17:90b:4394:: with SMTP id in20mr3377414pjb.34.1607121885363;
        Fri, 04 Dec 2020 14:44:45 -0800 (PST)
Received: from localhost ([2405:6580:31a1:500:1ac0:4dff:fe39:5426])
        by smtp.gmail.com with ESMTPSA id y23sm3710809pje.41.2020.12.04.14.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 14:44:44 -0800 (PST)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     rjw@rjwysocki.net
Cc:     wei.huang2@amd.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, bp@alien8.de, x86@kernel.org
Subject: Re: [RFC PATCH 0/4] Add processor to the ignore PSD override list
In-Reply-To: <20201125144847.3920-1-punitagrawal@gmail.com> (Punit Agrawal's
        message of "Wed, 25 Nov 2020 23:48:43 +0900")
References: <20201125144847.3920-1-punitagrawal@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Sat, 05 Dec 2020 07:44:41 +0900
Message-ID: <87zh2tp4x2.fsf@stealth>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

Punit Agrawal <punitagrawal@gmail.com> writes:

> Hi,
>
> While looking into Giovanni's patches to enable frequency invariance
> on AMD systems[0], I noticed an issue with initialising frequency
> domain information on a recent AMD APU.
>
> Patch 1 refactors the test to ignore firmware provided frequency
> domain into a separate function.
>
> Patch 2 adds said APU (Family: 0x17, Model: 0x60, Stepping: 0x01) to
> the list of CPUs for which the PSD override is ignored. I am not quite
> happy with having to special case a particular CPU but also couldn't
> find any documentation to help identify the CPUs that don't need the
> override.

Are you be OK to pick the first two patches if there are no issues?

Thanks,
Punit


> Patch 3 and 4 are somewhat independent and a first step towards
> improving the situation with regards to the use of raw identifiers for
> AMD processors throughout the kernel.
>
> All feedback welcome.
>
> Thanks,
> Punit
>
> [0] https://lore.kernel.org/linux-acpi/20201112182614.10700-1-ggherdovich@suse.cz/
>
> Punit Agrawal (4):
>   cpufreq: acpi-cpufreq: Re-factor overriding ACPI PSD
>   cpufreq: acpi-cpufreq: Add processor to the ignore PSD override list
>   x86/cpu: amd: Define processor families
>   cpufreq: acpi-cpufreq: Use identifiers for AMD processor family
>
>  arch/x86/include/asm/amd-family.h    | 18 ++++++++++++++++++
>  arch/x86/include/asm/cpu_device_id.h |  2 ++
>  drivers/cpufreq/acpi-cpufreq.c       | 24 +++++++++++++++++++++---
>  3 files changed, 41 insertions(+), 3 deletions(-)
>  create mode 100644 arch/x86/include/asm/amd-family.h
