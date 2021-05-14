Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD1A138070D
	for <lists+linux-pm@lfdr.de>; Fri, 14 May 2021 12:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbhENKVk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 May 2021 06:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhENKVk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 May 2021 06:21:40 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C63C061574;
        Fri, 14 May 2021 03:20:28 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id l7so34178741edb.1;
        Fri, 14 May 2021 03:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8i+pf5KCrVeLRq3B2i8legEoTNI+x7ywbPg+dol1Za4=;
        b=Ofa29xzeHuZWjIRdcrnX1Fiy1+VtlJ9wmiFLh3b1PqdXhRoZqebV8mlYRzNXo6qZit
         XOMRmHLX6SW7YXL43Lsx1WVEzNVhVjKRbZg9IQLQVJ3tiyGf+zTgpZDE3UWCPRPCPHoj
         Tw/Z29x9btFybglaQyWVAZNMH6D3Y/covTj655sUUhEEzFh6sRKjmJ7Is24b0+/s3nK8
         CnAQptSvsEwWE8chKiynWA1BDlRRXGnMpBojA2hdZzmR+gCKE/EdAyWHWH8DXzYed7sm
         g57dnVG7gpT9ZZ0MmWt4n77+VnMKv9eCYHkA69pK0aJc2FudX9XF5WXFaMayPBMyXvDP
         B8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=8i+pf5KCrVeLRq3B2i8legEoTNI+x7ywbPg+dol1Za4=;
        b=hFFSY2ux3RMa3C85wU6ClhGyira1T6fqMaoj6oUtHEQ9kI66z0q7nQDAz1+D7C3reF
         kYdy8WeY0gT1h7x9lxgzTg8kJlncdIjOk/IBl733sN07Ka9fKakxD8IcwIds2Be/UCkN
         oNG6uhTselxqckaTmdL4sVQ3rp1U/WaDod0zW4UyNskOaD/ZoRb/52aTVMCdRJcnw47n
         7ZNeTHxo2sh7G9w5zl8j4Exv2KkcsgxYA6/gHAGfmvHY32NPllXf1yaZQQg0mSNYMQwI
         U1TDs68ozGt/QjyVKJhpkcsxhd7+QHlNJdl9XJA5cOfhlEKpgGdOaj/QKuynD0OOuC9Q
         R9rg==
X-Gm-Message-State: AOAM530Fg6fmpsZSyGH5ycAD8Cx8IF9veaGQWN17dYu9B486RymAVdhn
        EfnY/IR54BEakUeS3LiSXJM=
X-Google-Smtp-Source: ABdhPJxRrQtfpg0fJWU3VVLvJWVbpQR6tyWKP1T497y5x6ol68Ecyb35h9Ogv/KVrLNrFg/drxyBEw==
X-Received: by 2002:aa7:cb0a:: with SMTP id s10mr54839694edt.36.1620987626925;
        Fri, 14 May 2021 03:20:26 -0700 (PDT)
Received: from gmail.com (0526E777.dsl.pool.telekom.hu. [5.38.231.119])
        by smtp.gmail.com with ESMTPSA id ay4sm4121972edb.12.2021.05.14.03.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 03:20:24 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 14 May 2021 12:20:22 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/acpi: Switch to pr_xxx log functions
Message-ID: <YJ5O5gytKMDOCnFz@gmail.com>
References: <8436da08-4812-d383-8f2a-1c07181ebfb8@gmail.com>
 <YJ4hrrUkKRkKsUtf@gmail.com>
 <CAJZ5v0h0Z3pfwpL2SsJ53=SfqE2d+7PrG+nt0PXjYrqeAkc27g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0h0Z3pfwpL2SsJ53=SfqE2d+7PrG+nt0PXjYrqeAkc27g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


* Rafael J. Wysocki <rafael@kernel.org> wrote:

> On Fri, May 14, 2021 at 9:07 AM Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * Heiner Kallweit <hkallweit1@gmail.com> wrote:
> >
> > > Switching to pr_debug et al has two benefits:
> > > - We don't have to add PREFIX to each log statement
> > > - Debug output is suppressed except DEBUG is defined or dynamic
> > >   debugging is enabled for the respective code piece.
> > >
> > > In addition ensure that longer messages aren't split to multiple lines
> > > in source code, checkpatch complains otherwise.
> > >
> > > Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> > > ---
> > >  arch/x86/kernel/acpi/boot.c | 118 ++++++++++++++----------------------
> > >  1 file changed, 47 insertions(+), 71 deletions(-)
> >
> > Reviewed-by: Ingo Molnar <mingo@kernel.org>
> 
> So I'm going to take this through the ACPI tree if that's OK.

Sure!

Thanks,

	Ingo
