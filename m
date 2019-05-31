Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD74031079
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2019 16:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfEaOqr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 May 2019 10:46:47 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38874 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfEaOqr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 31 May 2019 10:46:47 -0400
Received: by mail-pl1-f195.google.com with SMTP id f97so4116843plb.5
        for <linux-pm@vger.kernel.org>; Fri, 31 May 2019 07:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+oLbiZHvRS3KJUUhvyJO8fvkgdbxNQmutC3j5WyUYO0=;
        b=ow1qafi/yDoy8hGQWMfwkPT9Czm8xE8VCHegc942/JfVLkxWoeAZTJ/r/KQszB4j79
         lRAOGX/CGV0r7ulIhOSHWJ6PcOYCv+8EwodLCDnazKRw87eZoPFce7ssEr2Pohve5f1p
         IiDGn6AWl6hxoL2jnoCm4qWaGJHEdkqnwZ0yZ+bjWFwxXZJbpkhJv+qDssNFzcEvkTzB
         Bx8VVtmQhhuzpVLbCh4YGFTCq16QL2z+bfqzP4QzbkOPXDDLyrfMEb6s6tDf1nl7Td6c
         Ou1To2DqffD5NV1BPsd1JpPLWaa70yEf/j1Uy+nQe7SqxZ9mklc5axPnkhAsewU4h9MT
         Rkvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+oLbiZHvRS3KJUUhvyJO8fvkgdbxNQmutC3j5WyUYO0=;
        b=C9WSjzSGNh2DSmmxxAHAT2gAiyBuIqpkHp4HbBlHAiVeKNUrGzr4nyFzg7pLgokIsC
         EyWzfxPJn6iud0i1CjGer2QvLU/kjpFVqY0S/H8tqUPK5y3LEsg2hq3akhYix8hQoB2B
         YCr4TqhOOB4UyJrGNapRKV7fUnImYr4PPYtWUEdTnK9MU5BkBDoOvhj8nQfi5kKLtBtH
         CSLMqi3KRBEM5+3DBc9xkbzGNmkoxjsRlRexeBaybI5nUyYX4Hpg85GLNfmvwJxS2z3y
         zqS3L3wr39AW4tkkxJTGsrAeCl7YKs992IrYk/Xv49Yn9xqGpOg2eQmvcDgDFLphwbOv
         hvzg==
X-Gm-Message-State: APjAAAVsR0cwN+8rVLMo5GmNaQy5UbWheytBkSRHh9lYB3mxyNepOaMQ
        HrPpmlkfbBNw2Cp/6FWvf93YSg==
X-Google-Smtp-Source: APXvYqzgoVSATQWDxNKRHe+afQfSmp5S9GRT8jp3eK9h/gSeWzk5chGnKqzOJHwgZoZ+tfKJObuDEA==
X-Received: by 2002:a17:902:7c15:: with SMTP id x21mr9799142pll.311.1559314006938;
        Fri, 31 May 2019 07:46:46 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:40a6:bfd8:6bf:bfbe? ([2601:646:c200:1ef2:40a6:bfd8:6bf:bfbe])
        by smtp.gmail.com with ESMTPSA id l141sm13355299pfd.24.2019.05.31.07.46.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 07:46:45 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4] x86/power: Fix 'nosmt' vs. hibernation triple fault during resume
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16E227)
In-Reply-To: <nycvar.YFH.7.76.1905311628330.1962@cbobk.fhfr.pm>
Date:   Fri, 31 May 2019 07:46:44 -0700
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B7AC83ED-3F11-42B9-8506-C842A5937B50@amacapital.net>
References: <nycvar.YFH.7.76.1905282326360.1962@cbobk.fhfr.pm> <20190531051456.fzkvn62qlkf6wqra@treble> <nycvar.YFH.7.76.1905311045240.1962@cbobk.fhfr.pm> <5564116.e9OFvgDRbB@kreacher> <CALCETrUpseta+NrhVwzzVFTe-BkBHtDUJBO22ci3mAsVR+XOog@mail.gmail.com> <nycvar.YFH.7.76.1905311628330.1962@cbobk.fhfr.pm>
To:     Jiri Kosina <jikos@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



> On May 31, 2019, at 7:31 AM, Jiri Kosina <jikos@kernel.org> wrote:
>=20
>> On Fri, 31 May 2019, Andy Lutomirski wrote:
>>=20
>> 2. Put the CPU all the way to sleep by sending it an INIT IPI.
>>=20
>> Version 2 seems very simple and robust.  Is there a reason we can't do
>> it?  We obviously don't want to do it for normal offline because it
>> might be a high-power state, but a cpu in the wait-for-SIPI state is
>> not going to exit that state all by itself.
>>=20
>> The patch to implement #2 should be short and sweet as long as we are
>> careful to only put genuine APs to sleep like this.  The only downside
>> I can see is that an new kernel resuming and old kernel that was
>> booted with nosmt is going to waste power, but I don't think that's a
>> showstopper.
>=20
> Well, if *that* is not an issue, than the original 3-liner that just=20
> forces them to 'hlt' [1] would be good enough as well.
>=20
>=20

Seems okay to me as long as we=E2=80=99re confident we won=E2=80=99t get a s=
purious interrupt.

In general, I don=E2=80=99t think we=E2=80=99re ever suppose to rely on mwai=
t *staying* asleep.  As I understand it, mwait can wake up whenever it wants=
, and the only real guarantee we have is that the CPU makes some effort to s=
tay asleep until an interrupt is received or the monitor address is poked.

As a trivial example, if we are in a VM and we get scheduled out at any poin=
t between MONITOR and the eventual intentional wakeup, we=E2=80=99re toast. S=
ame if we get an SMI due to bad luck or due to a thermal event happening sho=
rtly after pushing the power button to resume from hibernate.

For that matter, what actually happens if we get an SMI while halted?  Does R=
SM go directly to sleep or does it re-fetch the HLT?

It seems to me that we should just avoid the scenario where we have IP point=
ed to a bogus address and we just cross our fingers and hope the CPU doesn=E2=
=80=99t do anything.

I think that, as a short term fix, we should use HLT and, as a long term fix=
, we should either keep the CPU state fully valid or we should hard-offline t=
he CPU using documented mechanisms, e.g. the WAIT-for-SIPI state.=
