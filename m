Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF097252F84
	for <lists+linux-pm@lfdr.de>; Wed, 26 Aug 2020 15:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730231AbgHZNU1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Aug 2020 09:20:27 -0400
Received: from mail-oo1-f65.google.com ([209.85.161.65]:38303 "EHLO
        mail-oo1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730227AbgHZNUZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Aug 2020 09:20:25 -0400
Received: by mail-oo1-f65.google.com with SMTP id z11so432336oon.5;
        Wed, 26 Aug 2020 06:20:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PWAM+fSMgJoSOIShD1u7yfMXsrJhEvdfCxjPmQvzz1A=;
        b=fc4Inb13Wth035FjdizJpRz9UYhvQ7ZNvjLUUiwmNKznOcrYJeeobLDEqaTbXlu8fW
         1CYk4y4t1gG+dRmrdx25yy66Zj7Gn7hRDCJnUPoVsgigI7I8bSIUZtk1bvLH2gLjwwTb
         wOssj+kNKpAq8zZ4BDjpf0weCESwscHnKwoDcwYPXPWHkuvb3zUu4vBtwVzyK63gBNf+
         AVyQ0JV5iFHaH+d/t/gsAH3zEt3K3EmwrSVDcW6T5SjLZKH6hBbCIv1vsGhi8QYyEn3n
         gUTerWcJcOwsIwXVZRyhPq7pTAQ1P4jIauEemboO03zJoDJ4E8UDa2EOKw8eunErTIKE
         UMXQ==
X-Gm-Message-State: AOAM530nm2RnDEKdVMjWmzPWqVo4+BaPu1PvPO5kkgbucYgw23aJDUY/
        75aFBlQq3PJfCPuA2c18ZRic1m+Vj+F9q85et6g=
X-Google-Smtp-Source: ABdhPJyYYmr8DMHJ7k2ZgyqVB9v2GAJt6G0w+tTYb2PRyQqL6H9WNqhVZH4qzKdXt4Tll8WOsUMEjHzxpQ+U0Vs4SRU=
X-Received: by 2002:a4a:d62c:: with SMTP id n12mr10597744oon.38.1598448023959;
 Wed, 26 Aug 2020 06:20:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200826120421.44356-1-guilhem@barpilot.io> <CAJZ5v0i8XUF39Vv=EM4TgyXgK6zHniZW3tGYFPweO3kg+BrxOQ@mail.gmail.com>
 <CAGX5Wg2OOgY6d1RH514Kh9D6b+siga+jzH7qubcmE+ukq+6KKA@mail.gmail.com> <a7c8ee4b54b5f205548c055b7b8d599c1bd7ddeb.camel@gmail.com>
In-Reply-To: <a7c8ee4b54b5f205548c055b7b8d599c1bd7ddeb.camel@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 26 Aug 2020 15:20:12 +0200
Message-ID: <CAJZ5v0iBn8M062CpMfv8sJ9tavMjrfrDtN6aTFq7DGV60X5iLQ@mail.gmail.com>
Subject: Re: [PATCH] intel_idle: Add ICL support
To:     Artem Bityutskiy <dedekind1@gmail.com>
Cc:     Guilhem Lettron <guilhem@barpilot.io>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Aug 26, 2020 at 3:09 PM Artem Bityutskiy <dedekind1@gmail.com> wrote:
>
> On Wed, 2020-08-26 at 15:03 +0200, Guilhem Lettron wrote:
> > On Wed, 26 Aug 2020 at 14:43, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > On Wed, Aug 26, 2020 at 2:05 PM Guilhem Lettron <guilhem@barpilot.io> wrote:
> > > > Use the same C-states as SKL
> > >
> > > Why is this change needed?
> >
> > On my laptop, a Dell XPS 13 7390 2-in-1 with i7-1065G7, ACPI only
> > report "C1_ACPI", "C2_ACPI" and "C3_ACPI".
>
> Did you try to dig into the BIOS menus and check if you can enable
> more/deeper C-states?

I would be surprised if there were settings for that in the BIOS, as
Windows only expects #1, C2 and C3 AFAICS.

It might be possible to disable C1E autopromotion, but that option is
not likely to be available on a laptop.

Cheers!
