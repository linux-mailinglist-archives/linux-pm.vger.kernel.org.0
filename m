Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7759031195D
	for <lists+linux-pm@lfdr.de>; Sat,  6 Feb 2021 04:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbhBFDC4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Feb 2021 22:02:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbhBFC6U (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Feb 2021 21:58:20 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5BEC061A32
        for <linux-pm@vger.kernel.org>; Fri,  5 Feb 2021 18:45:58 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id k4so8703215ybp.6
        for <linux-pm@vger.kernel.org>; Fri, 05 Feb 2021 18:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oeZT1Ar4/x7iejk6TCKZJw9nmldyPb7Q9CQuMN8dXaw=;
        b=AFhS6ATY/Y9NYutPrE19KVJ8QEJaF2PGTuOgrz9Gy3OYD8T3nfEM6tCPc4DQDe+cmT
         gGbLVifQsQtzUiF3X4dGA4SNwVI3LH7qwxl1vZhz3YR9Cp0qiGY/3jeh+rr5qm3r6IY7
         7hxHxK00mdEOHcIzgnBPiTqPV6L0vljvrfDvcDix7+8XPR81Lvup9F+WfsCimBB6dz24
         J+btxbs8E6J54C44KCAuZnUKGV86hdX+MuPzB7x2eyZrfnvisXKRD/0QNEtfhqDIpVGA
         Umt5XZHpqcC8bLOtBUQYJkjuYUyDhcO+rJXg9bilCjQKjRIdxzmsD4JoNfGKr5VvY1w/
         v/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oeZT1Ar4/x7iejk6TCKZJw9nmldyPb7Q9CQuMN8dXaw=;
        b=sotO/W9Kf84BW0hWpmaNi/lyubYfruN7EeDoVESk6PaDLRtS+uyPGwZuq4vDMdiwkN
         wKRh3Odyg2qwM3gaJ1bvoMuRvGsdyIBAXtHELo6epbYhuTA/4+6frzXeAHqBygQggTnR
         rGayjr62ehut4PjgYupl0bhX9Cq5n7g2zqD63y0qUM5uHYY7TiVBaxqTww0/6BCowS0N
         4GfHsFhkAXDGhvPpR3e5MRQyMFwPLQxfzIAxqUqr2GLiz4tiGs+RELk1Vvfcf01YDqqU
         W2jwqV9s48KBHEoQqm24tPzTfdN0e/WnRmasLiIqUcM3ZznFCt7raLNMBv0I4FmTrKJB
         3mCg==
X-Gm-Message-State: AOAM533gewjNHXNurNGu59vIaiRD39zR2yy9cYVbIDCFb223xBmm3RRp
        NJzA7nGbEQ5FAlZLXyub52B9c3VAtgD7c3117BaMSg==
X-Google-Smtp-Source: ABdhPJy11Z5i7gStQAF/aV2cWsIZWC4t0l/3YBj3YIJdn7KvpZm4nPNRQyA7a/+WGcaogoso5SndN/JmnOvk57r9ybc=
X-Received: by 2002:a25:af0b:: with SMTP id a11mr4263580ybh.228.1612579557241;
 Fri, 05 Feb 2021 18:45:57 -0800 (PST)
MIME-Version: 1.0
References: <20210205222644.2357303-1-saravanak@google.com>
In-Reply-To: <20210205222644.2357303-1-saravanak@google.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 5 Feb 2021 18:45:21 -0800
Message-ID: <CAGETcx_f7BEbkOFtw_6_4fMcgGOWkujbqXhDbDcNstOxgvcPfA@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] Make fw_devlink=on more forgiving
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Len Brown <lenb@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Feb 5, 2021 at 2:26 PM Saravana Kannan <saravanak@google.com> wrote:
>
> There are a lot of devices/drivers where they never have a struct device
> created for them or the driver initializes the hardware without ever
> binding to the struct device.
>
> This series is intended to avoid any boot regressions due to such
> devices/drivers when fw_devlink=on and also address the handling of
> optional suppliers.
>
> Patch 1 and 2 addresses the issue of firmware nodes that look like
> they'll have struct devices created for them, but will never actually
> have struct devices added for them. For example, DT nodes with a
> compatible property that don't have devices added for them.
>
> Patch 3 and 4 allow for handling optional DT bindings.
>
> Patch 5 sets up a generic API to handle drivers that never bind with
> their devices.
>
> Patch 6 through 8 update different frameworks to use the new API.
>
> Thanks,
> Saravana
>

Forgot to add version history:

v1 -> v2:
Patch 1: Added a flag to fwnodes that aren't devices.
Patch 3: New patch to ise the flag set in patch 1 to not create bad links.

v2 -> v3:
- Patch 1: Added Rafael's Ack
- New patches 3 and 4

v3 -> v4:
- No changes to patches 1-4.
- New patches 5-8.

-Saravana

> Saravana Kannan (8):
>   driver core: fw_devlink: Detect supplier devices that will never be
>     added
>   of: property: Don't add links to absent suppliers
>   driver core: Add fw_devlink.strict kernel param
>   of: property: Add fw_devlink support for optional properties
>   driver core: fw_devlink: Handle suppliers that don't use driver core
>   irqdomain: Mark fwnodes when their irqdomain is added/removed
>   PM: domains: Mark fwnodes when their powerdomain is added/removed
>   clk: Mark fwnodes when their clock provider is added/removed
>
>  .../admin-guide/kernel-parameters.txt         |  5 ++
>  drivers/base/core.c                           | 58 ++++++++++++++++++-
>  drivers/base/power/domain.c                   |  2 +
>  drivers/clk/clk.c                             |  3 +
>  drivers/of/property.c                         | 16 +++--
>  include/linux/fwnode.h                        | 20 ++++++-
>  kernel/irq/irqdomain.c                        |  2 +
>  7 files changed, 98 insertions(+), 8 deletions(-)
>
> --
> 2.30.0.478.g8a0d178c01-goog
>
