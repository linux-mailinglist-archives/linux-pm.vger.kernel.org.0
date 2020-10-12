Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3651328B3D1
	for <lists+linux-pm@lfdr.de>; Mon, 12 Oct 2020 13:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387919AbgJLLcS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Oct 2020 07:32:18 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33172 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387743AbgJLLcR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Oct 2020 07:32:17 -0400
Received: by mail-ot1-f67.google.com with SMTP id t15so15588733otk.0;
        Mon, 12 Oct 2020 04:32:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O4ZpKAn+stNCxSw5R7czdTo5agLU3Ug3iAu8crI2+nM=;
        b=tlEBwSjq+G0SF+o0Iu9daKYqmKAkl7YFAvIInGfT5S+Xx6D2au7FpWzJs242N4eDEB
         6/Tt2p/vGIPvXLrzl2IrdktGm72MhjQSPDFV64OqwAJ+DZ719DzqFI1pV/lDMJaVPwFN
         KQJYMmYNWz/MPRX+HTnQ+vioHpk2iMCxBQu43cdeB231gc9C4SvpN/GOCTsE3Razw47y
         4X1Zkco9iFq+LMJ9hFP+bUB2rokhFHzT89Jhz3O63Ck+rwJ0MBVW5HvMbLpXHNtwzGld
         XGSYt8Uo8OcJ8UJWx93aDGlDZHCqFNhQg7VyeZ/lSjtzxuMdEZ2nwUWp1UhVISL4Uqdw
         XqYg==
X-Gm-Message-State: AOAM530ime8s0NnCRvGLAEKDwYyC2nwJs9gVEQCmAL0phO8BLzDeofeF
        2iyaKiiGVd/srgyfNDq1r7hLs5Nd8TBJKgmj5XEt5T97
X-Google-Smtp-Source: ABdhPJyQpZgrxGbjpqXS/GpB4O13vCoPucQuy1qZ4GmUGOhXwGzKBJnr7tYz36CsKKqTb722800voTd29mUHK4f0dzo=
X-Received: by 2002:a9d:349:: with SMTP id 67mr18799651otv.321.1602502336753;
 Mon, 12 Oct 2020 04:32:16 -0700 (PDT)
MIME-Version: 1.0
References: <20201010221806.2106-1-amonakov@ispras.ru> <CAJZ5v0iFj0s=ZNrLnBxQ34uUnn2NQ6bH+oriyNWrFu-g8HGfUg@mail.gmail.com>
 <alpine.LNX.2.20.13.2010121410490.15808@monopod.intra.ispras.ru>
In-Reply-To: <alpine.LNX.2.20.13.2010121410490.15808@monopod.intra.ispras.ru>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 12 Oct 2020 13:32:05 +0200
Message-ID: <CAJZ5v0jzebmUJ8zYzCU1W08POdE7=+Uu5DGGjJaZLsp06+=YAw@mail.gmail.com>
Subject: Re: [PATCH] intel_idle: mention assumption that wbinvd is not needed
To:     Alexander Monakov <amonakov@ispras.ru>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 12, 2020 at 1:14 PM Alexander Monakov <amonakov@ispras.ru> wrote:
>
> On Mon, 12 Oct 2020, Rafael J. Wysocki wrote:
>
> > > @@ -20,7 +20,11 @@
> > >   * All CPUs have same idle states as boot CPU
> > >   *
> > >   * Chipset BM_STS (bus master status) bit is a NOP
> > > - *     for preventing entry into deep C-stats
> > > + *     for preventing entry into deep C-states
> > > + *
> > > + * CPU will flush caches as needed when entering a C-state via MWAIT
> >
> > I would rephrase this to mention that the above actually is an assumption.
>
> This comment block is by itself a list of assumptions.

Ah, OK

> It begins with heading
> "Design Assumptions" and then lists two assumptions. This patch adds a third
> one.
>
> With that clarified, do you still need me to change this hunk?

No need.
