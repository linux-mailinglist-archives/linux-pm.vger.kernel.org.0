Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF1484189DF
	for <lists+linux-pm@lfdr.de>; Sun, 26 Sep 2021 17:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbhIZPOu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 26 Sep 2021 11:14:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51892 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232304AbhIZPOi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 26 Sep 2021 11:14:38 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632669180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nuDlguqpot4ZhS9yQ8I8Yqw/c7AtPbUCp7ngPng0guU=;
        b=HfO01BhrvO7lPS9kSKQQ5bI4q7VhL8EusBWYjtl7qhJCWuulJsIkBfBeHETvlAJsL24QwT
        /aMABSZ1n28NUwlMnTrl2gpH7z0i32nl7fG+ex4Q4Jf2LFZujYvQMLjUjQwTjh2MT/cGeJ
        U6HDVO4R0z3qI2turX62dIA/BbW41SGUy2VMJmzW7TyJZD67vgLA4vFdDCAJwbmjtSrf0y
        lIlMj0VQLdyIltx1SeDubHS1Tvygi0Gst9YKPByAeKbMP9mEbJmwS1mrZuyR6cOAVNX1Rs
        vMHXOyX3p7z9Nk+YVGg5vYume8rav2yewx9C+TRswNBeWwVmS1l5C4qwm6vhhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632669180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nuDlguqpot4ZhS9yQ8I8Yqw/c7AtPbUCp7ngPng0guU=;
        b=X3opelUiwLdtCZxtQvA7LKjR0zadR/za4sUoO8ZI2N/sgPlJ47o5bOcYWx3sf+8PQr/+8l
        j0xVwXj6bqMcqhBw==
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Deepak Sharma <deepak.sharma@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [RESEND PATCH] x86: ACPI: cstate: Optimize C3 entry on AMD CPUs
In-Reply-To: <CAJZ5v0iS+TnkoqCxLa92Na=By53PXY-qW=k4utr_84KYaw+sVQ@mail.gmail.com>
References: <20210924061205.5523-1-deepak.sharma@amd.com>
 <CAJZ5v0iS+TnkoqCxLa92Na=By53PXY-qW=k4utr_84KYaw+sVQ@mail.gmail.com>
Date:   Sun, 26 Sep 2021 17:12:59 +0200
Message-ID: <87wnn3bcas.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Sep 24 2021 at 18:48, Rafael J. Wysocki wrote:

> On Fri, Sep 24, 2021 at 8:12 AM Deepak Sharma <deepak.sharma@amd.com> wrote:
>>
>> All Zen or newer CPU which support C3 shares cache. Its not necessary to
>> flush the caches in software before entering C3. This will cause drop in
>> performance for the cores which share some caches. ARB_DIS is not used
>> with current AMD C state implementation. So set related flags correctly.
>>
>> Signed-off-by: Deepak Sharma <deepak.sharma@amd.com>
>
> I'm planning to take this one unless the x86 maintainers have concerns, thanks.

Acked-by: Thomas Gleixner <tglx@linutronix.de>
