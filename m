Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBF9144E8A
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2020 10:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbgAVJU7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Jan 2020 04:20:59 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33351 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgAVJU7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jan 2020 04:20:59 -0500
Received: by mail-ot1-f66.google.com with SMTP id b18so5672063otp.0;
        Wed, 22 Jan 2020 01:20:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L4DR0uqrh3NSpikl3N4VGuv6Ks2RUJrYoTTwNSKL0qI=;
        b=AXvEF71ARwWT1AE/jKO8ngbSUnZP0tGo3/VutkdW6B3aqndxynXOfWO86tJPypVPHO
         2/eWCoKSVV4QwCcrYfdpojli+i+uEZYY5e5m+UHEwNhULTlu7jwkzqPFT7mFrKZMnXbh
         A/KDnNERQOYj6hVneKYMyox0gOdxaJLiKIMjjyQAxLSuo+xReXBUonWYNxpgkaC8XuKQ
         THM4Y5SHO7khS/2xWDwQHcE98LMgdkxsV4HGRh7BiVSJyDn3FtTEtwUk98XcT3RYsQQn
         Fasr2LIMmXtVITEjVXeDTbGfE2CrwFLDTma7KffEha0r1rj7L0RS2lwokVJWZJ0an14a
         6efQ==
X-Gm-Message-State: APjAAAVlqjSxgsvm1TZcBtzDlvRwSFFbij2lQ4AYG3Ubg7J9Bfh2O4W9
        sPMr+Cvdkb796rfzhQrgKl6GxIB9dYeslwHWkmo=
X-Google-Smtp-Source: APXvYqxpLDd6aLdC3e2leL2mO11lm7bgxP633+uOSOvqUGSaFWw2v5+0WYpKLTFUbx1JrLo9KhMbUsA8L+Jg4VcYGMo=
X-Received: by 2002:a05:6830:4b9:: with SMTP id l25mr6798500otd.266.1579684859013;
 Wed, 22 Jan 2020 01:20:59 -0800 (PST)
MIME-Version: 1.0
References: <20200122034723.1863-1-caoj.fnst@cn.fujitsu.com>
In-Reply-To: <20200122034723.1863-1-caoj.fnst@cn.fujitsu.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 22 Jan 2020 10:20:46 +0100
Message-ID: <CAJZ5v0inCzOsea6ihUaKojNERzXZbgj3Sjay3SwCSbD05h=YiA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] x86/boot: early ACPI MADT processing cleanup
To:     Cao jin <caoj.fnst@cn.fujitsu.com>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jan 22, 2020 at 4:47 AM Cao jin <caoj.fnst@cn.fujitsu.com> wrote:
>
> Logic in early_acpi_process_madt() & acpi_process_madt() is really hard to
> follow now. Clean them up.
>
> Done basic boot test on my x86-64 PC.
>
> Cao jin (2):
>   x86/acpi: Improve code readablity of early madt processing
>   x86/acpi: Cleanup acpi_process_madt()
>
>  arch/x86/kernel/acpi/boot.c | 72 +++++++++++++++----------------------
>  1 file changed, 28 insertions(+), 44 deletions(-)

Please always CC ACPI patches to linux-acpi@vger.kernel.org, thanks!
