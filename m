Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA41541497D
	for <lists+linux-pm@lfdr.de>; Wed, 22 Sep 2021 14:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236084AbhIVMsw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Sep 2021 08:48:52 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:33437 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236085AbhIVMsr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Sep 2021 08:48:47 -0400
Received: by mail-ot1-f44.google.com with SMTP id c42-20020a05683034aa00b0051f4b99c40cso3368853otu.0;
        Wed, 22 Sep 2021 05:47:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UUiCBNielMa38BIb9BHPZtFbJzf43TTIl3svNHNMP3c=;
        b=JP8z0nVwm7YIp7nzrcav2eoba63+Uw4PoJVnQ0XHEdGui8MMYIku2y79YABCRFz+qz
         6Cky+6CQpshzbSPP9Dn1CmSbbUecUFznXHpitspSKhT7SUjj4Otw9tktLfJhvCC8GoRu
         s27fdZgvre5DjtYagTJq++DtqlVeBt2xSg71mzdUP6coLAUsSUId9VniHzHsZuJeeV8Y
         WEQUe6sdUtgRRlNeHFUN5Oetj05k00tWkDzDn6cYYdj3g54T5KpI/qGrKNACe3o9m1H2
         9bj2Jo1l2HSyPUTRpvSWKzaFZg49y5e8QB786ppNSzM5vprobFSMOkQImB0Zj8DT6fqc
         vfEg==
X-Gm-Message-State: AOAM5311Fz+kkdejyX7vdLNI0RYqL617nhDVUQQsTcXLqBv7JioUO0vl
        3H+HicRZ/nKyJeP8aPErzoQ6I5iSt6J9rLtGnk0=
X-Google-Smtp-Source: ABdhPJwd1dnNtMuVX2FgogpdGKAYJqSHyBwQI5zoFV2HKwLYYlUD9SMj/pAlzmOebA3v+NSF9Yby0tSjhZ7PsYz/YAQ=
X-Received: by 2002:a05:6830:82b:: with SMTP id t11mr2810637ots.319.1632314836721;
 Wed, 22 Sep 2021 05:47:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210819004305.20203-1-deepak.sharma@amd.com> <CAJZ5v0jWX=H=aZ25PzHdH05bRJvtYbGHfyTgH_68k4kfYkZc5A@mail.gmail.com>
 <951c4f8f-30ee-77d3-afb7-46e45c84213d@amd.com> <CAJZ5v0ic+0MKDbebrxnyxr=rRJbqP4LmB4g1fVVAVJWh98e=MA@mail.gmail.com>
 <a20fc6ba-14fa-e9b9-de69-54b9eaf20e73@amd.com>
In-Reply-To: <a20fc6ba-14fa-e9b9-de69-54b9eaf20e73@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 22 Sep 2021 14:47:05 +0200
Message-ID: <CAJZ5v0gp=_T7b9YVDBfdC11DzzY8Xovxm659-X6i_bJxoV1LgQ@mail.gmail.com>
Subject: Re: [PATCH] x86/ACPI/State: Optimize C3 entry on AMD CPUs
To:     "Sharma, Deepak" <deesharm@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Deepak Sharma <deepak.sharma@amd.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Sep 22, 2021 at 5:50 AM Sharma, Deepak <deesharm@amd.com> wrote:
>
> Hi Rafael,
>
> On 9/1/2021 5:45 AM, Rafael J. Wysocki wrote:
> > On Wed, Sep 1, 2021 at 4:14 AM Deepak Sharma <deesharm@amd.com> wrote:
> >>
> >> On 8/25/21 11:07 AM, Rafael J. Wysocki wrote:
> >>> On Thu, Aug 19, 2021 at 2:43 AM Deepak Sharma <deepak.sharma@amd.com> wrote:
> >>>> AMD CPU which support C3 shares cache. Its not necessary to flush the
> >>>> caches in software before entering C3. This will cause performance drop
> >>>> for the cores which share some caches. ARB_DIS is not used with current
> >>>> AMD C state implementation. So set related flags correctly.
> >>>>
> >>>> Signed-off-by: Deepak Sharma <deepak.sharma@amd.com>
> >>> Applied as 5.15 material under the edited subject "x86: ACPI: cstate:
> >>> Optimize C3 entry on AMD CPUs", thanks!
> >> I might need to send subsequent patch for this. Can you please point me
> >> to git and branch where this has been merged.
> > git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
>
> Still I am not able to see this patch merged on linux-next branch.

It was there, but got dropped before the merge window due to the
unclear next steps.

I'd rather see this resent along with the subsequent patch you were
talking about.
