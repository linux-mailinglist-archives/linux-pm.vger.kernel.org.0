Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8032CBF4F
	for <lists+linux-pm@lfdr.de>; Wed,  2 Dec 2020 15:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388890AbgLBONs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Dec 2020 09:13:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388913AbgLBONp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Dec 2020 09:13:45 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D830DC0613CF;
        Wed,  2 Dec 2020 06:13:05 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id y7so1308126pfq.11;
        Wed, 02 Dec 2020 06:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version;
        bh=AqItRk7mnZdsZA6csT1tLYDrY8hNeqLdGWBbN7B9gGY=;
        b=CDuPN3jMkzAvFsf6wKUEy7vd7dfYDs8SG6IU2Ve+YHEDOGlrx+h0NpxrHmx4Na3fI4
         WJMloAcjfZSDb9mDOXHFFHVhEAgCaLoYr7BaMF/neXMlFXmEYsr02XAD2kHwQlrYscDm
         70O55hzbypg7MnXzchF/3y1dvdtIU8OzGPB3YW4K2koPIPuBaOF6QOIy9FIbtjLHtuUt
         4uEL/0L5OAWOsFNLsC9KxJPmCTHoIxSd7Syxcy4qKGuHYpAM5Hhp+AtpwC4gW0AxjgFV
         W4+KKQYgacq9ZcVR0LqHFVjYF4eRployEIbzf+Y9n482siGTIQZpuxgpLJsQUjuJZrB1
         F6bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
         :user-agent:date:message-id:mime-version;
        bh=AqItRk7mnZdsZA6csT1tLYDrY8hNeqLdGWBbN7B9gGY=;
        b=NqD9LLLgMmMeFSp1epfIy8+4hFWFEY3qLJ2xjGyApkVEsYnQ9CKrjSmpImEHqMmEl+
         BfKqh2FGqCgALSZwxvHj3217URlCc3WyUqpE95lC6IpoOLiGWPnVjDyeEqlOE+OB/mrw
         fM3immHQluSg1RyXNw2HXOoTpd4kfpSBQnuZKdMiYkb5xq1Sw1JifqrHg/xs2t967gkm
         HWxFRksGJyfRan2FJoi4CQhx4KE711rOEEtxyokFwT/535P2L419GOgE6PUM3yEv8H/a
         oj4Oh+VJ2vJjNQLuk43rEHY2YBL7A+GSy9FDeaLyx21f9oLiuogTbJuzv1TMfIkbz9eH
         ++og==
X-Gm-Message-State: AOAM530BXLGw5jhtSxpSv7QDuS50/N82/KngRTJTYNb+GJNUkECpQWa8
        K0AAgdT7ZqnSIvZK3L8OBvc=
X-Google-Smtp-Source: ABdhPJxMzOjHybLV+EnkqdJv9Yp2s8o0k1dUanMG3LkNfz4c+1eF+WOgszMHUR8aWjw42HDUhf3rgw==
X-Received: by 2002:a63:283:: with SMTP id 125mr81772pgc.282.1606918385338;
        Wed, 02 Dec 2020 06:13:05 -0800 (PST)
Received: from localhost ([2405:6580:31a1:500:1ac0:4dff:fe39:5426])
        by smtp.gmail.com with ESMTPSA id y19sm15637pfp.211.2020.12.02.06.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 06:13:04 -0800 (PST)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     rjw@rjwysocki.net, wei.huang2@amd.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [RFC PATCH 3/4] x86/cpu: amd: Define processor families
In-Reply-To: <20201130140018.GC6019@zn.tnic> (Borislav Petkov's message of
        "Mon, 30 Nov 2020 15:00:18 +0100")
References: <20201125144847.3920-1-punitagrawal@gmail.com>
        <20201125144847.3920-4-punitagrawal@gmail.com>
        <20201130140018.GC6019@zn.tnic>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Wed, 02 Dec 2020 23:13:02 +0900
Message-ID: <87pn3s2t5d.fsf@stealth>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Boris,

Borislav Petkov <bp@alien8.de> writes:

> On Wed, Nov 25, 2020 at 11:48:46PM +0900, Punit Agrawal wrote:
>> So far, the AMD processor identifier (family, models, stepping) are
>> referred to by raw values making it easy to make mistakes. It is also
>> harder to read and maintain. Additionally, these values are also being
>> used in subsystems outside the arch code where not everybody maybe be
>> as familiar with the processor identifiers.
>> 
>> As a first step towards improving the status quo, add macros for the
>> AMD processor families and propagate them through the existing
>> cpu_device_id.h header used for this purpose.
>> 
>> Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Borislav Petkov <bp@alien8.de>
>> Cc: x86@kernel.org
>> ---
>>  arch/x86/include/asm/amd-family.h    | 18 ++++++++++++++++++
>>  arch/x86/include/asm/cpu_device_id.h |  2 ++
>>  2 files changed, 20 insertions(+)
>>  create mode 100644 arch/x86/include/asm/amd-family.h
>> 
>> diff --git a/arch/x86/include/asm/amd-family.h b/arch/x86/include/asm/amd-family.h
>> new file mode 100644
>> index 000000000000..dff4d13b8e74
>> --- /dev/null
>> +++ b/arch/x86/include/asm/amd-family.h
>> @@ -0,0 +1,18 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _ASM_X86_AMD_FAMILY_H
>> +#define _ASM_X86_AMD_FAMILY_H
>> +
>> +#define AMD_FAM_K5			0x04
>> +#define AMD_FAM_K6			0x05
>> +#define AMD_FAM_K7			0x06
>> +#define AMD_FAM_K8			0x0F
>> +#define AMD_FAM_K10			0x10
>
> Fam 0x10 is Greyhound and a lot more core names. I'd let the AMD folks
> on Cc say what they wanna call it but I don't think K10 was used
> anywhere except outside of AMD. :)

Didn't realize the core was internal only. There are a couple of
instances where the family does shows up arch/x86/kernel/cpu/amd.c so
atleast some of the patches did make it upstream.

>> +#define AMD_FAM_K8_K10_HYBRID		0x11
>
> That was called Griffin so AMD_FAM_GRIFFIN I guess. If not used anywhere
> in the tree, no need to add the define.

I haven't looked to deeply but there's one instance in
arch/x86/kernel/cpu/amd.c - though I wonder if that could be re-written
to rely on a hardware / firmware interface instead.

> Same holds true for the rest of the defines - add them only when
> they're used.

Makes sense - I will follow your suggestion in the next version.

>> +#define AMD_FAM_LLANO			0x12
>> +#define AMD_FAM_BOBCAT			0x14
>> +#define AMD_FAM_BULLDOZER		0x15
>> +#define AMD_FAM_JAGUAR			0x16
>> +#define AMD_FAM_ZEN			0x17
>
> ZEN2 is also 0x17 but different models so this is where the family
> matching scheme doesn't work - you'd need the models too.

Yes, I wasn't sure the best way to handle this so went with the earlier
generation name. I think for such cases, something that looks at the
cpuinfo_x86 structure and decides the family / generation is probably
the way to go.

> 0x18 is HYGON

I missed this one. I'll add it to the list.

Thanks for the review and your comments. I'll wait a bit to see if
there's any further feedback.

Cheers,
Punit

[...]

