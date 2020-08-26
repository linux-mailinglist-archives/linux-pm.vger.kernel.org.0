Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBBF252F92
	for <lists+linux-pm@lfdr.de>; Wed, 26 Aug 2020 15:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbgHZNVX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Aug 2020 09:21:23 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34326 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728276AbgHZNVV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Aug 2020 09:21:21 -0400
Received: by mail-ot1-f67.google.com with SMTP id k20so1457144otr.1;
        Wed, 26 Aug 2020 06:21:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hGUTdln7l6OLSRN/oGX5pGuJYKRn/THkz/0Z1CGTGCE=;
        b=SNzsDPNwvcl7wtAUFh0rJbVCHgzVgv0h1sACI5h+n6JHvXmQp89UG+eDmEmpozDbZ3
         1Khbrz0trcgCONf1fC1YMWRzYvBSQ0NSwN3Amgd5rr585hrupWx0okELSY80jFuG1QIG
         m/tJJ47yW8PS6Y2Pn913q7c9N/reqVXKyZXhMKBj3shqJIdX7sDGDAk9b49XA6H8fRSn
         27FD9QZd5pIlYJQvdgGbqBGXFwXrKWpV5akD8YdDfWurN7wlCzOs4amBVTdo3Yk8FaCe
         H04KO7fQQKb3PeaEKLeIE9oVDV8+VHQDxUfbBa6SU0Qmyv57kJUe22HnMzz7rLb44FXR
         XsfQ==
X-Gm-Message-State: AOAM533m9UDLw9yD7NcSvhNebXp98FjjzEW8bHCeVoAnY3tIRyuxJdWA
        PLvRW5IrMDdQlSGxyXNrhQWlbWkxKVMQLzf/LlY=
X-Google-Smtp-Source: ABdhPJz67fBI+FnXN0Nbltt9xsmaVh/I80TmzH8bIG5g6B/MYxdoRc6colwa+z1JLpX8myV1CZbmLzZTl97jYXwSPhw=
X-Received: by 2002:a9d:5c06:: with SMTP id o6mr9985323otk.262.1598448080994;
 Wed, 26 Aug 2020 06:21:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200826120421.44356-1-guilhem@barpilot.io> <CAJZ5v0i8XUF39Vv=EM4TgyXgK6zHniZW3tGYFPweO3kg+BrxOQ@mail.gmail.com>
 <CAGX5Wg2OOgY6d1RH514Kh9D6b+siga+jzH7qubcmE+ukq+6KKA@mail.gmail.com>
 <d0ca671465e6ce72c6c4d5178440ebc1e4814da8.camel@gmail.com> <e82c121057c4496238d3de7f7c919b7039d23b7c.camel@gmail.com>
In-Reply-To: <e82c121057c4496238d3de7f7c919b7039d23b7c.camel@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 26 Aug 2020 15:21:09 +0200
Message-ID: <CAJZ5v0gT_XKToTtuBdAeDuz6Ggk8-rVxE-hSjdfQC4uCMsTcdA@mail.gmail.com>
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

On Wed, Aug 26, 2020 at 3:18 PM Artem Bityutskiy <dedekind1@gmail.com> wrote:
>
> On Wed, 2020-08-26 at 16:16 +0300, Artem Bityutskiy wrote:
> > Just get a reasonably new turbostat (it is part of the kernel tree, you
> > can compile it yourself) and run it for few seconds (like 'turbostat
> > sleep 10'), get the output (will be a lot of it), and we can check what
> > is actually going on with regards to C-states.
>
> Oh, and if you could do that with and without your patch, we could even
> compare things. But try to do it at least with the default (acpi_idle)
> configuration.

IMO it is way easier to get the information from sysfs.
