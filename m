Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13BDA2CBFC7
	for <lists+linux-pm@lfdr.de>; Wed,  2 Dec 2020 15:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbgLBObS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Dec 2020 09:31:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727694AbgLBObS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Dec 2020 09:31:18 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2794CC0613CF;
        Wed,  2 Dec 2020 06:30:32 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id s2so1206847plr.9;
        Wed, 02 Dec 2020 06:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=flB/gAbF0vQpareTnMEpZra4KoplDuqW+j+K4MBaZuM=;
        b=mjHEqh8+6chX40XhD8iJ3lFqFVFotA2wb/nnPTLnyz5Z2MABablFtrl/jfJZMaJMrM
         MMjg0kxaTyFEnUxca0SkO6Q88JHebLWktpT32FKGuY5rI8/TH9sUcYzHzT4sh6Z+Q0yt
         8MqP3k+Ic7o9T00mXSXy0NCkPcs+INn00bBP8rfVFwatTXJunpBETt1Pzt/EWSGkbFe0
         9c47XRRh/tZtFniJUoe0YjVaySHY1ej9rWo3j+exBgHeOoWd0OGTTkB1NGSFmB1Ys44v
         aIjUjMB93MQ4eX1WLtqO8owKtcheNQDf0FEs2Z627GfkK8HTy4HIq0TSxq0FGGtRhoqe
         Tz2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:message-id
         :user-agent:mime-version;
        bh=flB/gAbF0vQpareTnMEpZra4KoplDuqW+j+K4MBaZuM=;
        b=t16jo0Vuq7ZTuJ3UBM+8Ez0bdfhCmpvm38INwfF+fnMOJhL+il+sG/mezmRdr+g3HO
         JnBR5UwqWObelRvfOdRp7+NcwpyQKkyuFupNi8uq1K+O/zYNyeizr7gtEfucrJQ6RLES
         FXay8qALUacHOszdbNNNVML52V200QgBnQmJ71P9jyACmc46sLKR6wZ2JHPmfrbE6ahq
         5/tNvQeUBf8g41xawvFoC/qgJTNcv/DOjwYK6ck558KTZjmFez3cBg8Gbf3X73l/8Pfh
         2iwt+yWcbT+h2kTwUoXNChF7QVe78GHxH57U+uqQxI+Kdcw1IPJ2bZScRC/sLtxhCgEx
         LBQw==
X-Gm-Message-State: AOAM533M+N6ukmHuJwHWBlAJxMiN4t122GI1MrqziuFFR43wj4pOgGy9
        auybiGgGQgKTzDH+JZ/kzwWwfY6UiMTWqCy4
X-Google-Smtp-Source: ABdhPJzGmwNnE0rWLQQmeBgEL79F3Is3zVNw2Nxtics1edwq428C3UUBp2dApoF1mr0Z1klKbMdvFQ==
X-Received: by 2002:a17:902:e901:b029:d8:e727:2595 with SMTP id k1-20020a170902e901b02900d8e7272595mr2895632pld.56.1606919431495;
        Wed, 02 Dec 2020 06:30:31 -0800 (PST)
Received: from localhost ([2405:6580:31a1:500:1ac0:4dff:fe39:5426])
        by smtp.gmail.com with ESMTPSA id h16sm5456pjt.43.2020.12.02.06.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 06:30:30 -0800 (PST)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     rjw@rjwysocki.net, wei.huang2@amd.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [RFC PATCH 4/4] cpufreq: acpi-cpufreq: Use identifiers for AMD
 processor family
References: <20201125144847.3920-1-punitagrawal@gmail.com>
        <20201125144847.3920-5-punitagrawal@gmail.com>
        <20201130140224.GD6019@zn.tnic>
Date:   Wed, 02 Dec 2020 23:30:28 +0900
Message-ID: <87eek82scb.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Borislav Petkov <bp@alien8.de> writes:

> On Wed, Nov 25, 2020 at 11:48:47PM +0900, Punit Agrawal wrote:
>> Replace the raw values for AMD processor family with recently
>> introduced identifier macros to improve code readability and
>> maintainability.
>> 
>> Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
>> ---
>>  drivers/cpufreq/acpi-cpufreq.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>> 
>> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
>> index 29f1cd93541e..d8b8300ae9e0 100644
>> --- a/drivers/cpufreq/acpi-cpufreq.c
>> +++ b/drivers/cpufreq/acpi-cpufreq.c
>> @@ -202,8 +202,8 @@ static int override_acpi_psd(unsigned int cpu_id)
>>  		 * CPU's before Zen3 (except some Zen2) need the
>>  		 * override.
>>  		 */
>> -		return (c->x86 < 0x19) &&
>> -			!(c->x86 == 0x17 && c->x86_model == 0x60 &&
>> +		return (c->x86 < AMD_FAM_ZEN3) &&
>> +			!(c->x86 == AMD_FAM_ZEN && c->x86_model == 0x60 &&
>
> This is what I mean - that's Zen2 as the comment above says so having
>
> 		c->x86 == AMD_FAM_ZEN
>
> is not enough. And you have a comment above it stating which CPUs are
> matched here so I'm not sure those family defines make it any better...

Hmm.. for this series, it probably doesn't add much value - especially
with the comment and macro mismatch.

The last two patches were posted to check if there's wider interest in
the changes. If the macro conversion is useful, I can split the patches
from this series into a separate set with more sites being updated. I'll
wait to see if there's any further feedback.

Thanks,
Punit

