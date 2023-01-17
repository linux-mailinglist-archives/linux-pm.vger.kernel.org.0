Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96DCB66E000
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jan 2023 15:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjAQOJo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Jan 2023 09:09:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjAQOJk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Jan 2023 09:09:40 -0500
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1620D3A5A6;
        Tue, 17 Jan 2023 06:09:36 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id vw16so12482457ejc.12;
        Tue, 17 Jan 2023 06:09:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SxrCGjSKfBkjK5viyn3/63bLv/HFmaC1YTqocY1zE1E=;
        b=PsXakM8q0f3n89Ua6Zpw1AS8ZFLjv7nlKW5iNCEeaQ6+AnoozAJknXwd3QTS/1uIne
         CkGwGHzOg1pw46HF0Djvn1VvZymJdhrW0rOisTonUw5IupDQMVcLQ1MMpCioAgYhZlYV
         p4XFRFnkP29aD7eJVlZCjshjEF4feJdZ9CZRRJk/WSJUDO6/WnuYWIKPXjWegpflUKV6
         IsdzSlAw7aI312w7DOzhBdTS2Tto7f8VEWCDpsYZI7nnIxHjVytoVyhV9odsqft7l8UC
         G3t7IhQUxv/7jJy2HtNHTfC2/nAE9YXquQHeUQrT6jsEmMcCR9C5DjdPrACuC3fAbAYE
         OVLQ==
X-Gm-Message-State: AFqh2kplE+D9PdjxIIdPO0XHWrFj3cgJMQziGV0HhMJALuCRZpG+20xD
        UAKODakWkgVucteEZUR3g0yXOEoM8sNEoXlv1II=
X-Google-Smtp-Source: AMrXdXu3u90Y/GKUFfDt7Oeht0ZXER9iAI4urcFhf748H5avCW3qieQtQPSGgH0KHpzyPJom0xOGNHHT1Jp4RjFOURk=
X-Received: by 2002:a17:906:eb1b:b0:86e:abe4:5acf with SMTP id
 mb27-20020a170906eb1b00b0086eabe45acfmr297536ejb.615.1673964575446; Tue, 17
 Jan 2023 06:09:35 -0800 (PST)
MIME-Version: 1.0
References: <20230113140610.7132-1-jgross@suse.com> <CAJZ5v0gP_NUeQimn21tJuUjpMAOW_wFrRe4jstN13So_4_T4QQ@mail.gmail.com>
 <e5cc2f96-82bc-a0dc-21fa-2f605bc867d1@suse.com>
In-Reply-To: <e5cc2f96-82bc-a0dc-21fa-2f605bc867d1@suse.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 17 Jan 2023 15:09:24 +0100
Message-ID: <CAJZ5v0ggSbR7+RiXuJo4aq+PYWS-eb9R2iSr0DFfVhcaJ1bfUQ@mail.gmail.com>
Subject: Re: [PATCH] x86/acpi: fix suspend with Xen
To:     Juergen Gross <jgross@suse.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org,
        =?UTF-8?Q?Marek_Marczykowski=2DG=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jan 16, 2023 at 7:45 AM Juergen Gross <jgross@suse.com> wrote:
>
> On 13.01.23 20:40, Rafael J. Wysocki wrote:
> > On Fri, Jan 13, 2023 at 3:06 PM Juergen Gross <jgross@suse.com> wrote:
> >>
> >> Commit f1e525009493 ("x86/boot: Skip realmode init code when running as
> >> Xen PV guest") missed one code path accessing real_mode_header, leading
> >> to dereferencing NULL when suspending the system under Xen:
> >>
> >>      [  348.284004] PM: suspend entry (deep)
> >>      [  348.289532] Filesystems sync: 0.005 seconds
> >>      [  348.291545] Freezing user space processes ... (elapsed 0.000 seconds) done.
> >>      [  348.292457] OOM killer disabled.
> >>      [  348.292462] Freezing remaining freezable tasks ... (elapsed 0.104 seconds) done.
> >>      [  348.396612] printk: Suspending console(s) (use no_console_suspend to debug)
> >>      [  348.749228] PM: suspend devices took 0.352 seconds
> >>      [  348.769713] ACPI: EC: interrupt blocked
> >>      [  348.816077] BUG: kernel NULL pointer dereference, address: 000000000000001c
> >>      [  348.816080] #PF: supervisor read access in kernel mode
> >>      [  348.816081] #PF: error_code(0x0000) - not-present page
> >>      [  348.816083] PGD 0 P4D 0
> >>      [  348.816086] Oops: 0000 [#1] PREEMPT SMP NOPTI
> >>      [  348.816089] CPU: 0 PID: 6764 Comm: systemd-sleep Not tainted 6.1.3-1.fc32.qubes.x86_64 #1
> >>      [  348.816092] Hardware name: Star Labs StarBook/StarBook, BIOS 8.01 07/03/2022
> >>      [  348.816093] RIP: e030:acpi_get_wakeup_address+0xc/0x20
> >>
> >> Fix that by adding an indirection for acpi_get_wakeup_address() which
> >> Xen PV dom0 can use to return a dummy non-zero wakeup address (this
> >> address won't ever be used, as the real suspend handling is done by the
> >> hypervisor).
> >
> > How exactly does this help?
>
> I believed the first sentence of the commit message would make this
> clear enough.

That was clear, but the fix part wasn't really.

> I can expand the commit message to go more into detail if you think
> this is really needed.

IMO calling acpi_set_waking_vector() with a known-invalid wakeup
vector address in dom0 is plain confusing.

I'm not sure what to do about it yet, but IMV something needs to be done.
