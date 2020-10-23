Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3EC2971C8
	for <lists+linux-pm@lfdr.de>; Fri, 23 Oct 2020 16:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461223AbgJWO6M (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Oct 2020 10:58:12 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40263 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S461220AbgJWO6M (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Oct 2020 10:58:12 -0400
Received: by mail-ot1-f66.google.com with SMTP id f97so1611732otb.7;
        Fri, 23 Oct 2020 07:58:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sh4XGYh6HGjEIbya0JlmwandcV47fSdnDSxnvIYHkcU=;
        b=UXu0b3AxMm8DP/6F7u0xPwQI2AcraBN0pzbkKR51CUO4nAFV89uaYnWQLMDadvkS0S
         3OXdTjWQpIWonP6YoYwb+skWf2tyF3NFypXi9zDCShX0yUj7FkDZvytxcGwXSEdpiity
         Q/gnOQO9gjItbC9MGKDiaHQuZs+a/J/69cbKknZ/+QjAjjQuvAgZcHg+nkzda6ARhsIK
         fy2dQ2nu9eGuX/pej39dYI/pTF3D/n+MYjkrJdVlOv0oWP06gXSPf6wcAkvhSIhk4VY7
         8I7KbiqrCD/E24TNfDi0bzeQ/72crCd2TIDnzZiOIDx9R+f7Dhf5WJPiqa+2kv9KD+/I
         OK/A==
X-Gm-Message-State: AOAM532O9REJ15uTWFxDHfnaEtD97n4FhIhNqdvf672QYzHEqhd/YgnP
        R2VzkNFpC7y1aU+WKBnzNEpotd9vchRBL0QntIc=
X-Google-Smtp-Source: ABdhPJwWynZevqQLElXxNd+RoaIFPGIei005wJY7JOjJGbL6bB5o7oYmvdQn9tUKdp++B0dXSF02UcHWy+GnYUcsFf0=
X-Received: by 2002:a9d:ac9:: with SMTP id 67mr1981783otq.321.1603465091227;
 Fri, 23 Oct 2020 07:58:11 -0700 (PDT)
MIME-Version: 1.0
References: <20201022061748.13730-1-claude.yen@mediatek.com>
 <20201022061748.13730-2-claude.yen@mediatek.com> <20201022070154.hqvksoj4nss3er2e@bogus>
 <1603427300.7573.6.camel@mtkswgap22> <20201023144842.zos4pvpwv4r3rv4j@bogus>
In-Reply-To: <20201023144842.zos4pvpwv4r3rv4j@bogus>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 23 Oct 2020 16:58:00 +0200
Message-ID: <CAJZ5v0jJHBBrxANa-+mHFE47TZfE4NKNpgp0-rq2BD=Yw7qMXg@mail.gmail.com>
Subject: Re: [PATCH] PM / s2idle: Export s2idle_set_ops
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     claude yen <claude.yen@mediatek.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 23, 2020 at 4:48 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Fri, Oct 23, 2020 at 12:28:20PM +0800, claude yen wrote:
> > On Thu, 2020-10-22 at 08:02 +0100, Sudeep Holla wrote:
> > > On Thu, Oct 22, 2020 at 02:17:48PM +0800, Claude Yen wrote:
> > > > As suspend_set_ops is exported in commit a5e4fd8783a2
> > > > ("PM / Suspend: Export suspend_set_ops, suspend_valid_only_mem"),
> > > > exporting s2idle_set_ops to make kernel module setup s2idle ops too.
> > > >
> > > > In this way, kernel module can hook platform suspend
> > > > functions regardless of Suspend-to-Ram(S2R) or
> > > > Suspend-to-Idle(S2I)
> > > >
> > >
> > > If this is for arm64 platform, then NACK. You must use PSCI and it will
> > > set the ops and it can't be module.
> > >
> >
> > PSCI uses suspend_set_ops instead. And suspend_set_ops has been
> > exported years ago.
> >
> > Suspend-to_Idle(S2I) is another suspend method supported by linux
> > kernel. The corresponding s2idle_ops can be hooked by s2idle_set_ops
> > by underlying platforms.  For example, S2I is now introduced into
> > Mediatek SoC platforms. Besides, power management driver is built as
> > kernel module.
> >
> > Mobile platforms are now call for kernel drivers to be kernel modules.
> > This could help drivers easier to migrate to newer linux kernel.
> > Ref: https://linuxplumbersconf.org/event/7/contributions/790/
> >
>
> I understand that. But I am interested in looking at the module you want
> to use this and how that interacts with PSCI. If this is arm64, you must
> use PSCI for system suspend and cpu suspend. What does this module do on
> top of those is what I want to know. Please post that module or point
> me if it is already present in the tree.

Regardless, generally speaking, patches that export stuff to modules
without an in-the-tree user needing this are not applicable to the
mainline kernel source tree IMV.

Cheers!
