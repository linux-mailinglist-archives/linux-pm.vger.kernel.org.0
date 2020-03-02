Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43ED51760A7
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2020 18:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbgCBRCd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Mar 2020 12:02:33 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35185 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbgCBRCd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Mar 2020 12:02:33 -0500
Received: by mail-ot1-f67.google.com with SMTP id v10so3157624otp.2;
        Mon, 02 Mar 2020 09:02:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3E3fWxDEv9ZHfmOkcec5gIIJeOvKCzK/ypdiNkYfC8Q=;
        b=PU5YSgJM0v8gIGcwJCuVXvlgu5Cm9dRRs4HeH+ZE1UYmKTrqSHRrSeIklZmnd41AF8
         TiM+ovRk8Esx/fBCyLAR6jMKwit0RuIXMzXXNfNE+ZF5RmWwxHLLH1bor53s4fn+IMbF
         9B/CfH1QAeIEhW+oAg96abRDPoiPlPYVXSt0COj3g2zrWOdlY9pBYbW+lLHl/yti71h5
         Vpjr4HD9YzUGHZUwvoSUeTjk51WC4jHfpWa3LQ51Ypr7JvmrDtSDYYVTiTZuNcp2qdwz
         FIRA6C4Uvesg70p2NBCTIZCLujXKyaclBHDL9CFoyOwKJzMTq1NAk5QHWi+Tdc6NInl5
         MPtA==
X-Gm-Message-State: ANhLgQ2AagbWnLnObH29eBzcxI/w2JG5nx/sU13i0gXrTcNmcR2HJFkA
        Ee/ALzUBKxbKduUDYlRaQAeFis6BDAb/c3woLS0=
X-Google-Smtp-Source: ADFU+vtrrwRitcEkkYBbTuh1knba7jp5gALhcQEhCs5xZDWVZPrBv0NBfHT14a2k5mSe4rTQlRheR8mZvBJynFnoa78=
X-Received: by 2002:a9d:67d7:: with SMTP id c23mr125593otn.262.1583168552404;
 Mon, 02 Mar 2020 09:02:32 -0800 (PST)
MIME-Version: 1.0
References: <20200228174630.8989-1-madhuparnabhowmik10@gmail.com>
 <CAJZ5v0jhw+cVm=ViiOtZgKr+a1L_PbeVPNXpsPbgghUvMPODSA@mail.gmail.com>
 <C2E57D31-A459-4F5F-8ECF-484FBB26C065@joelfernandes.org> <CAJZ5v0jTSKd_23fJhM+XUmFX_yTjcD+c_s1Jvi3HA1EmXPkzZw@mail.gmail.com>
 <CAEXW_YRL0kum5yVm+9V8i_PK2FcHfPeUOxJKZ+T8P3zqhATxJg@mail.gmail.com> <CAD=jOEZ3vdNC4qTMxptaXLjs7i8TCTYjeiv9vXhcapLSkrr9RQ@mail.gmail.com>
In-Reply-To: <CAD=jOEZ3vdNC4qTMxptaXLjs7i8TCTYjeiv9vXhcapLSkrr9RQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 2 Mar 2020 18:02:21 +0100
Message-ID: <CAJZ5v0hee4FxeVub_ZkAYn9z8q1_ZLA_AcmTtS-w39VzSe0UxA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drivers: base: power: main: Use built-in RCU list checking
To:     Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Amol Grover <frextrite@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Mar 2, 2020 at 1:34 PM Madhuparna Bhowmik
<madhuparnabhowmik10@gmail.com> wrote:
>
>
>
> On Mon, 2 Mar, 2020, 3:48 AM Joel Fernandes, <joel@joelfernandes.org> wrote:
>>
>> On Sun, Mar 1, 2020 at 4:23 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>> >
>> > On Sun, Mar 1, 2020 at 9:53 PM <joel@joelfernandes.org> wrote:
>> > >
>> > >
>> > >
>> > > On March 1, 2020 3:12:53 PM EST, "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>> > > >On Fri, Feb 28, 2020 at 6:47 PM <madhuparnabhowmik10@gmail.com> wrote:
>> > > >>
>> > > >> From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
>> > > >>
>> > > >> This patch passes the cond argument to list_for_each_entry_rcu()
>> > > >> to fix the following false-positive lockdep warnings:
>> > > >>
>> > > >> [  330.302784] =============================
>> > > >> [  330.302789] WARNING: suspicious RCU usage
>> > > >> [  330.302796] 5.6.0-rc1+ #5 Not tainted
>> > > >> [  330.302801] -----------------------------
>> > > >> [  330.302808] drivers/base/power/main.c:326 RCU-list traversed in
>> > > >non-reader section!!
>> > > >>
>> > > >> [  330.303303] =============================
>> > > >> [  330.303307] WARNING: suspicious RCU usage
>> > > >> [  330.303311] 5.6.0-rc1+ #5 Not tainted
>> > > >> [  330.303315] -----------------------------
>> > > >> [  330.303319] drivers/base/power/main.c:1698 RCU-list traversed in
>> > > >non-reader section!!
>> > > >>
>> > > >> [  331.934969] =============================
>> > > >> [  331.934971] WARNING: suspicious RCU usage
>> > > >> [  331.934973] 5.6.0-rc1+ #5 Not tainted
>> > > >> [  331.934975] -----------------------------
>> > > >> [  331.934977] drivers/base/power/main.c:1238 RCU-list traversed in
>> > > >non-reader section!!
>> > > >>
>> > > >> [  332.467772] WARNING: suspicious RCU usage
>> > > >> [  332.467775] 5.6.0-rc1+ #5 Not tainted
>> > > >> [  332.467775] -----------------------------
>> > > >> [  332.467778] drivers/base/power/main.c:269 RCU-list traversed in
>> > > >non-reader section!!
>> > > >
>> > > >I don't see these warnings in the kernels run locally here.
>> > > >
>> > > >What do you do to get them?
>> > > >
>> > > >Joel, any comments here?
>> > >
>> > > You have to enable lockdep in your config. Does your setup have that?
>> >
>> > CONFIG_LOCK_DEBUGGING_SUPPORT=y
>> > CONFIG_PROVE_LOCKING=y
>> > CONFIG_DEBUG_SPINLOCK=y
>> > CONFIG_DEBUG_LOCK_ALLOC=y
>> > CONFIG_LOCKDEP=y
>>
>>
> I had CONFIG_PROVE_RCU_LIST = y and I think these warnings were triggered when I had closed my laptop (like just close without shutting down).

OK, so let's define a macro for that in this file to avoid code duplication.

And analogously in the second patch.

Thanks!
