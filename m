Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF2D174FE2
	for <lists+linux-pm@lfdr.de>; Sun,  1 Mar 2020 22:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgCAVXT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Mar 2020 16:23:19 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44308 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgCAVXS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Mar 2020 16:23:18 -0500
Received: by mail-oi1-f193.google.com with SMTP id d62so8357570oia.11;
        Sun, 01 Mar 2020 13:23:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g90Jsy31XrppfqU2qdwvAKX4AQi5k+8zFJzl7y6CTO8=;
        b=hpqnu07zFA3Uke2RMN5J3KIoXQHeR5VtJcuge9sJYzpib0EgJmQMvA1lYUmqbK3FBI
         kKif4O9kcKlAVsv3MOzdHiFQzi19/ON+4JYm3DBUD8gaSiNxvOoWYCc/ayZtkmlfnqAm
         2GCHO9qnKohEpFb2Ez0H8s8oaaRhVNc4aA9ZvtFfk3fVno69l2JASjpAoVuIbS42eydb
         wdBJT2fRMOWudKEMhfE3eSKqbLufyhoNbhkzq+PlAxToZMCfmGrg0gFpw6eHhb/OYgEL
         Ewgc5+5rdfhDxhyVmvEWTcwppcYzSDvHmQevv2HXXlfWft9q37ydH2i3gQYOpmtFQ59A
         1Fgw==
X-Gm-Message-State: APjAAAXRDXWlXJV0uhoX9vtg7QM5r727EEzrod6M2vG4sPmIFZhRTmdn
        HaCypxfZ+FCvoqfwVQghd9u+/S2Yhy7Q1KswxhM=
X-Google-Smtp-Source: APXvYqzcg028OV6MOcUNz9riYTwG1HmNKNDoar9+w8ggrxYqXP3bcp5HMo1s3kEuWmpCdQOlzFaMz3PPlEVbBkxC6jQ=
X-Received: by 2002:aca:ebcf:: with SMTP id j198mr8056491oih.115.1583097798061;
 Sun, 01 Mar 2020 13:23:18 -0800 (PST)
MIME-Version: 1.0
References: <20200228174630.8989-1-madhuparnabhowmik10@gmail.com>
 <CAJZ5v0jhw+cVm=ViiOtZgKr+a1L_PbeVPNXpsPbgghUvMPODSA@mail.gmail.com> <C2E57D31-A459-4F5F-8ECF-484FBB26C065@joelfernandes.org>
In-Reply-To: <C2E57D31-A459-4F5F-8ECF-484FBB26C065@joelfernandes.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 1 Mar 2020 22:23:07 +0100
Message-ID: <CAJZ5v0jTSKd_23fJhM+XUmFX_yTjcD+c_s1Jvi3HA1EmXPkzZw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drivers: base: power: main: Use built-in RCU list checking
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        madhuparnabhowmik10@gmail.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        frextrite@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org, paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Mar 1, 2020 at 9:53 PM <joel@joelfernandes.org> wrote:
>
>
>
> On March 1, 2020 3:12:53 PM EST, "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> >On Fri, Feb 28, 2020 at 6:47 PM <madhuparnabhowmik10@gmail.com> wrote:
> >>
> >> From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> >>
> >> This patch passes the cond argument to list_for_each_entry_rcu()
> >> to fix the following false-positive lockdep warnings:
> >>
> >> [  330.302784] =============================
> >> [  330.302789] WARNING: suspicious RCU usage
> >> [  330.302796] 5.6.0-rc1+ #5 Not tainted
> >> [  330.302801] -----------------------------
> >> [  330.302808] drivers/base/power/main.c:326 RCU-list traversed in
> >non-reader section!!
> >>
> >> [  330.303303] =============================
> >> [  330.303307] WARNING: suspicious RCU usage
> >> [  330.303311] 5.6.0-rc1+ #5 Not tainted
> >> [  330.303315] -----------------------------
> >> [  330.303319] drivers/base/power/main.c:1698 RCU-list traversed in
> >non-reader section!!
> >>
> >> [  331.934969] =============================
> >> [  331.934971] WARNING: suspicious RCU usage
> >> [  331.934973] 5.6.0-rc1+ #5 Not tainted
> >> [  331.934975] -----------------------------
> >> [  331.934977] drivers/base/power/main.c:1238 RCU-list traversed in
> >non-reader section!!
> >>
> >> [  332.467772] WARNING: suspicious RCU usage
> >> [  332.467775] 5.6.0-rc1+ #5 Not tainted
> >> [  332.467775] -----------------------------
> >> [  332.467778] drivers/base/power/main.c:269 RCU-list traversed in
> >non-reader section!!
> >
> >I don't see these warnings in the kernels run locally here.
> >
> >What do you do to get them?
> >
> >Joel, any comments here?
>
> You have to enable lockdep in your config. Does your setup have that?

CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y

Anything else?
