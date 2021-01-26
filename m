Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20CB1304E90
	for <lists+linux-pm@lfdr.de>; Wed, 27 Jan 2021 02:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbhA0AhU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Jan 2021 19:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730660AbhAZRIE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Jan 2021 12:08:04 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA062C0611BD
        for <linux-pm@vger.kernel.org>; Tue, 26 Jan 2021 08:45:47 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id p72so34830197iod.12
        for <linux-pm@vger.kernel.org>; Tue, 26 Jan 2021 08:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BdN+glEVgeYhnUo2SFc/y+zPoJzWySqh9gKW4wQ+MUc=;
        b=g2NzyrdO8qJc9gCmNX6MMT+uVx9heLOB8e6cxKjT4RRCRVRezEQsRZrty72bZ8jTbG
         ePCn51fae/rChUFBImBy+iN7wS30ENu0xAo9KS1sojNC3/8dez9eHbWjCURFPdXyBPj6
         zvsxX2Pl5YqHPLyWJ3N/f4gB6V10Ynpd0TmWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BdN+glEVgeYhnUo2SFc/y+zPoJzWySqh9gKW4wQ+MUc=;
        b=bWq6ILITVgQG+83aKlHJwWTd7isUMNICeesQcoJ4Bme0b/f5RFFAsj6tUXXxcHPaWG
         xFkEsCjnDtDoCzmmpvP8BJxlEIsrcEOfwrQlA6wFxu4uIdOF602+vOEh4gejP/kuZNap
         FQHh3ZPgzTGbcS577722KOkpAX/rfw1wC9+MT8Z27Yul455rBg4FvrRgtN1iYfjCpB9W
         qfFziHgVqHuEcS0Dh9Otl7aZ4a3FfPPW4X9bXF6CuhP2jz/PAqN5U+0jrScoL9Mkjqe9
         /tHfjc54Ip/GwejBVd3SnsokCM/T0KdLdDjg9iELDgju+44C84FU0mvGoGW6NcSitzQ0
         NwcA==
X-Gm-Message-State: AOAM531c8APQNeE3y8HDSvU4ecvygW4E8H2D8h4ISmjl43XH3A7tQlxW
        hmN0OxklMADh1UU4p934KSruSQ==
X-Google-Smtp-Source: ABdhPJzoEfRlJfb2BxFmWyNOtUPG+bzH7lGmNi5OkZqiYHDR18+VfL7GrL6LHQreL1gGeAJ1cXyQ3w==
X-Received: by 2002:a05:6e02:507:: with SMTP id d7mr5097817ils.133.1611679547103;
        Tue, 26 Jan 2021 08:45:47 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id v2sm11205221ilj.19.2021.01.26.08.45.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 08:45:46 -0800 (PST)
Subject: Re: [PATCH v2 0/8] cpupower: Updates and cleanup to support AMD
 Family 0x19
To:     Nathan Fontenot <nathan.fontenot@amd.com>, rrichter@amd.com,
        shuah@kernel.org, linux-kernel@vger.kernel.org, trenn@suse.com,
        linux-pm@vger.kernel.org
Cc:     boris.ostrovsky@oracle.com, joao.m.martins@oracle.com,
        konrad.wilk@oracle.com, Shuah Khan <skhan@linuxfoundation.org>
References: <161159600371.68367.14890273216040482793.stgit@ethanol01c7-host.amd.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <bbc30a6a-de13-869a-f58e-cb98bb070d4e@linuxfoundation.org>
Date:   Tue, 26 Jan 2021 09:45:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <161159600371.68367.14890273216040482793.stgit@ethanol01c7-host.amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 1/25/21 10:34 AM, Nathan Fontenot wrote:
> Updates to the cpupower command to add support for AMD family 0x19
> and cleanup the code to remove many of the family checks to hopefully
> make any future family updates easier.
> 
> The first couple of patches are simple updates to rename the structs
> in the msr_pstate union to better reflect current support and correcting
> the name of the CPUPOWER_CAP_AMD_CPB cpuid cap flag.
> 
> Patches 3, 5, and 8 update the family checks to either replace
> them with a new cpuid cap flag based off of cpuid checks or check for
> family >= 0x17 where removing the direct family check isn't possible.
> 
> The reamianing patches are cleanups to remove unneeded extra enabled bit
> checking, remove passing no longer used variables, and remove unused
> variables in decode_pstates().
> ---
> 
> Updates for v2:
> - Patch 1/8: Add links to AMD PPR and BKDG to commit message.
> - Patch 3/8: Update and add back removed comment.
> 
> ---
> 
> Nathan Fontenot (7):
>        cpupower: Update msr_pstate union struct naming
>        cpupower: Add CPUPOWER_CAP_AMD_HW_PSTATE cpuid caps flag
>        cpupower: Remove unused pscur variable.
>        cpupower: Update family checks when decoding HW pstates
>        cpupower: Condense pstate enabled bit checks in decode_pstates()
>        cpupower: Remove family arg to decode_pstates()
>        cpupower: Add cpuid cap flag for MSR_AMD_HWCR support
> 
> Robert Richter (1):
>        cpupower: Correct macro name for CPB caps flag
> 
> 
>   tools/power/cpupower/utils/cpufreq-info.c    |    3 -
>   tools/power/cpupower/utils/helpers/amd.c     |   65 ++++++++++++--------------
>   tools/power/cpupower/utils/helpers/cpuid.c   |   20 +++++++-
>   tools/power/cpupower/utils/helpers/helpers.h |   14 +++---
>   tools/power/cpupower/utils/helpers/misc.c    |    9 +---
>   5 files changed, 57 insertions(+), 54 deletions(-)
> 
> --
> Nathan Fontenot
> 

Thank you. Applied now for 5.12-rc1

https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/log/?h=cpupower

thanks,
-- Shuah
