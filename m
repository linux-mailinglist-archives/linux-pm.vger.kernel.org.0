Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1CB2D4579
	for <lists+linux-pm@lfdr.de>; Wed,  9 Dec 2020 16:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbgLIPdc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Dec 2020 10:33:32 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35311 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgLIPdc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Dec 2020 10:33:32 -0500
Received: by mail-ot1-f65.google.com with SMTP id i6so1743089otr.2;
        Wed, 09 Dec 2020 07:33:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ynAxoQtGZhSqTFnf7x9QCUAKx2FSnpYdLwLBwZ4NJBQ=;
        b=X35IMXdUkGbL3/MFOn3qbW5rFzg/G3yHPgB57N/S8JMKen0yN9M1rzbJogewDGoxz1
         Hk/KkL8Lb6R9NHzvBgUikKpc8vkl8/tvciF941/L3MumiO7mhZ+Z+pLcND7WkCgn5BNK
         FE64nMczah6zERx5/fWZECBEaCsAvTkvQikhuvDcXph4JyfVZims4Zqcw5WbunBjcSee
         e6/JdN4YHdNo1FbSgotC5srP80uqJ5cZk5rWHo8aLChb8bHg1DvpkSsyAjhhLNqdbAOV
         3gvA24ZBwjyPmcnHTPc3/2E1Gd33MThHJOWVUls/aG3DFzwB9bkS/yB/GM9j/U6EweON
         CYHQ==
X-Gm-Message-State: AOAM532mf9SbtvkdMvLtg7bq1twdVVyupusAoaPuTSSz/6qaWR7OnfEW
        rJI+Hr8UViUaYf4jbeUp/gBkcL7P/O4F3RCbzW50rF2F
X-Google-Smtp-Source: ABdhPJzjI+8L5P5jInt0gqIV7kYG9efDyYOuP4lfPF4WJaerSLiZE0sYKmV7go4+6pCJk00+eqGVKCkk87VMRjJLrPI=
X-Received: by 2002:a9d:67da:: with SMTP id c26mr2235701otn.321.1607527970962;
 Wed, 09 Dec 2020 07:32:50 -0800 (PST)
MIME-Version: 1.0
References: <20201208191955.2466057-1-tstrudel@google.com> <X8/ZM7Vm/aD9FdlG@kroah.com>
In-Reply-To: <X8/ZM7Vm/aD9FdlG@kroah.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 9 Dec 2020 16:32:40 +0100
Message-ID: <CAJZ5v0gjZVWY3pMnZMNvO0Xn1M=GzpXLd-vkNUZANnfAcMrTxA@mail.gmail.com>
Subject: Re: [PATCH v4] PM: domains: create debugfs nodes when adding power domains
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thierry Strudel <tstrudel@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Dec 8, 2020 at 9:39 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Dec 08, 2020 at 11:19:55AM -0800, Thierry Strudel wrote:
> > debugfs nodes were created in genpd_debug_init alled in late_initcall
> > preventing power domains registered though loadable modules to have
> > a debugfs entry.
> >
> > Create/remove debugfs nodes when the power domain is added/removed
> > to/from the internal gpd_list.
> >
> > Signed-off-by: Thierry Strudel <tstrudel@google.com>
> > Change-Id: I8a2e0616746afe2a6bbd9c24bc3a0eaa84725a75
>
> You don't need this, checkpatch.pl should have warned you :)
>
> > ---
> > v2: fix forward declaration and genpd_debugfs_dir being NULL - Ulf
> > v3: remove extra trailing char added by mistake in v2 - kernel test robot
> > v4: cleanup includes and regroup CONFIG_DEBUG_FS CPP blocks - Greg
> >  drivers/base/power/domain.c | 73 +++++++++++++++++++++++--------------
> >  1 file changed, 45 insertions(+), 28 deletions(-)
>
> Looks good to me, thanks for fixing it up.  Rafael, will this go through
> your tree?

I can pick it up.

> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
