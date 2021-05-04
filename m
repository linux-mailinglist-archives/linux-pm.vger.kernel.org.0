Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5F42373292
	for <lists+linux-pm@lfdr.de>; Wed,  5 May 2021 00:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbhEDW5I (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 May 2021 18:57:08 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:37595 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbhEDW5I (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 May 2021 18:57:08 -0400
Received: by mail-ed1-f50.google.com with SMTP id y26so12345386eds.4;
        Tue, 04 May 2021 15:56:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WRP8b2sRc20j5rcg9njusTqKIADVBLQcLXcryZWjpjw=;
        b=Uquxcj2K/mlY/n5GtTPu7vigDFVpa70/bcMufGVVP7JVMCt32Nh74q4A8Ss8YU1aab
         JvUwKXTvIzI72a/SzAtO1+hdzHDfR6KiCR9sWmPpGFTRgpnqh0LbkAwqR7PCXAGTJEaV
         bpPWjWU3cMqiPZ3bougq360GiWqqWz+IHlYHvMeLpKby6vZNdG2c3jX26u6+j34H2Ksx
         xeaNUsTALX9sISs/I4zDxlydUcC0jWQoRx1bGpKNpJxHe4mzH6ksvCTsEE7FzNvb58G8
         KDU0pfcyDpp91JkJqm6/vhuhjAymAH+s4+H7euK9ayFopWfiDOqd8x2ZWLTbjWZ7mHmb
         2VIw==
X-Gm-Message-State: AOAM530kA6Zp+YlQ+raCAmZ41t0CBBgAf3lffhtidMe7xT2N05nCjX1a
        8fUw3TZFlxsnxGrugde2Hy1y0dUwdsVSusjRMZD9KVlz
X-Google-Smtp-Source: ABdhPJwiLjOL9i2OIojEp0Np2q5vdgIkPwvfaSvY9vsYZJ8BSQEQ3TIzz2585rrerRMfsekVp42ywUTU67Bv9UH6mCI=
X-Received: by 2002:a05:6402:4245:: with SMTP id g5mr28549923edb.306.1620168971089;
 Tue, 04 May 2021 15:56:11 -0700 (PDT)
MIME-Version: 1.0
References: <20201012100205.2750-1-yu.c.chen@intel.com>
In-Reply-To: <20201012100205.2750-1-yu.c.chen@intel.com>
From:   Len Brown <lenb@kernel.org>
Date:   Tue, 4 May 2021 18:56:00 -0400
Message-ID: <CAJvTdK=wGHfNhOBuWFS5VmW+QqdyG+w7HdDrP-Vs1u84dkSiyw@mail.gmail.com>
Subject: Re: [PATCH][RFC] tools/power turbostat: Fix ACPI CState format issue
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 12, 2020 at 6:00 AM Chen Yu <yu.c.chen@intel.com> wrote:
>
> Currently if the system boots with BIOS _CST Cstate information
> enabled, the turbostat output would have unaligned problems:
>
> C1_ACPI C2_ACPI C3_ACPI POLL%   C1_ACPI%        C2_ACPI%        C3_ACPI%        CPU%c1
> 5       37      138     0.00    0.02    1.30    98.51   0.38    0.00    0.00    99.43
>
> The C1_ACPI% is of 8 bytes, so extend the format accordingly if the field name
> equals to/longer than 8 bytes.
>
> After the patch applied:
>
> C1_ACPI C2_ACPI C3_ACPI POLL%   C1_ACPI%        C2_ACPI%        C3_ACPI%        CPU%c1
> 2       42      96      0.00    0.12            2.60            97.09           0.60

Let's shorten the header fields so that a single tab continues to work.
this is helpful for processing turbostat output in .TSV format.

thx
