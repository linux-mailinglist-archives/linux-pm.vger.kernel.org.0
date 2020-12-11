Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6342D82D0
	for <lists+linux-pm@lfdr.de>; Sat, 12 Dec 2020 00:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388643AbgLKXiC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Dec 2020 18:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437309AbgLKXhW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Dec 2020 18:37:22 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E29C0613CF;
        Fri, 11 Dec 2020 15:36:42 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id hk16so3172179pjb.4;
        Fri, 11 Dec 2020 15:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version;
        bh=MgWP9jxRB8amULVjgVJSqmEz5Q4ppHRiQaLzS/iT588=;
        b=UR3MFTM4CQWCYCmvT32O1a+ZA7AG2qyLrJHwxP4ONPm9+MwSSztBnomol+J4gC/JzE
         0TAFACUrFGfjA6R8nmIr2+mlekIjiQktrDWesC2QIZ8RFLUxFsQq/dAIkpV3rCwCfFCZ
         6Zkinpqxdq5kLeX3pXVkxebQLM9S8MQdw5Mo6unIyvRyHhAu3GTVegNH6DvbcOB91put
         LwrhCKaxMw60zNO+wdAT84rFrgV+cXcYWkvG/MHRpTGzhnH3hbYYuLYXcz1dXC5K9b/M
         8snR0TwwKpZqN1MDYcon294WMrb2RHcGd88NxrEf4Rn7hvZM4xgKt+P3cDDviUKoomII
         jZDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
         :user-agent:date:message-id:mime-version;
        bh=MgWP9jxRB8amULVjgVJSqmEz5Q4ppHRiQaLzS/iT588=;
        b=LwkE7s6OKhgzhMcm7qxNN78d3cMTEnLNZbJX3tcUQCjY3iPjhJ+j+a8FVE4NsFnXeh
         aB5HcdhlGHHc9Weud3xRsFJfh35sobr/e/TdaIh44r0yWhv97j1R4L3jbEouNtsyJojP
         w00X+IP9U/bFZXt7ijwsX8AFriZKGi0HI2rRj1sBdidNFaw4incbgLCK8ajIIwWgMlcX
         3wbI3CV6o4yYcVK2FFWzw6/RiZKbyJNhYUOVjmfmHh9IVUqyB7mADO+NXoxBUvnNecO+
         6OlFuhhJSuu5bKMpwOrzqDdu/Tm7iaN7PtQrzXVijvHff7F2k4eNub4uNEOiQZjtArJO
         DqLA==
X-Gm-Message-State: AOAM532RYBEkfUwvLZ71QltUVodZi65cNgISeO7XRPDVrJuMcbWzX8AE
        SSUYmToCL7KF8I0k1t5FWu68Q/jg1bPxeVNb
X-Google-Smtp-Source: ABdhPJymF6gXu8+CqxK2LcoXOugpvcZ4EbDPbhweW2aRhLaxlkau3GwDXg6DnVHJOsKQUW352EPhfw==
X-Received: by 2002:a17:902:22e:b029:d9:e591:7bd1 with SMTP id 43-20020a170902022eb02900d9e5917bd1mr13297768plc.50.1607729802347;
        Fri, 11 Dec 2020 15:36:42 -0800 (PST)
Received: from localhost ([2405:6580:31a1:500:1ac0:4dff:fe39:5426])
        by smtp.gmail.com with ESMTPSA id m77sm12361409pfd.105.2020.12.11.15.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 15:36:41 -0800 (PST)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     rjw@rjwysocki.net, wei.huang2@amd.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/2] cpufreq: acpi-cpufreq: Add processor to the ignore
 PSD override list
In-Reply-To: <20201210230332.GH26529@zn.tnic> (Borislav Petkov's message of
        "Fri, 11 Dec 2020 00:03:32 +0100")
References: <20201210225640.317719-1-punitagrawal@gmail.com>
        <20201210225640.317719-3-punitagrawal@gmail.com>
        <20201210230332.GH26529@zn.tnic>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Sat, 12 Dec 2020 08:36:38 +0900
Message-ID: <87360boqyh.fsf@stealth>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Borislav Petkov <bp@alien8.de> writes:

> On Fri, Dec 11, 2020 at 07:56:40AM +0900, Punit Agrawal wrote:
>> Booting Linux on a Zen2 based processor (family: 0x17, model: 0x60,
>> stepping: 0x1) shows the following message in the logs -
>> 
>>     acpi_cpufreq: overriding BIOS provided _PSD data
>> 
>> Although commit 5368512abe08 ("acpi-cpufreq: Honor _PSD table setting
>> on new AMD CPUs") indicates that the override is not required for Zen3
>> onwards, it seems that domain information can be trusted even on
>> certain earlier systems. Update the check, to skip the override for
>> Zen2 processors known to work without the override.
>> 
>> Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
>> Cc: Wei Huang <wei.huang2@amd.com>
>> ---
>>  drivers/cpufreq/acpi-cpufreq.c | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> What about answers to those questions first?
>
> https://lkml.kernel.org/r/20201208233216.GH27920@zn.tnic

Oh.. sorry I missed that mail for some reason. Let's continue
there.
