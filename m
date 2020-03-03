Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05B00177B9A
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2020 17:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbgCCQJ6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Mar 2020 11:09:58 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:55662 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729537AbgCCQJ6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Mar 2020 11:09:58 -0500
Received: by mail-pj1-f65.google.com with SMTP id a18so1533567pjs.5;
        Tue, 03 Mar 2020 08:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PW2q1O1LawBhjKs2T037lJZGZjX7nCN1iWTrJRayolM=;
        b=KCka3Q2wKj2xVhjSXAi8XIkgJ9mhNXB/kTDBT1C1NuPxqIl8xXd6pVByb9ojoZejpw
         8TespAE8VKuf17GKiCRf6WiTmkKqznh4jQbzVppjBC3HK01CGZj/FjZHdhM9sRT7IPKz
         52ALAGynVBSMhGEuE2ueaEumNrG6kvlIlTwrkOAhhr6IpG3iG9iA2vmVnrGZbs7z8LcR
         99WgjY3WQyyqVBwQmWUxjBY+MFbULrzfoy1MpNME4AnJ/5qvU1+LzPfYgY/e/+0HKm+K
         KK7Tx4FruMouiQ9+DhneMzPHoZTM0iuvYfFemkH4JPOPsPYGiM0l1DLAX3J2wzfsnRg8
         XfmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PW2q1O1LawBhjKs2T037lJZGZjX7nCN1iWTrJRayolM=;
        b=pYeovKXJ+HPlH/3vs7SxYliN1WDqVaP1a+VntqVn7kOymwTkJDfdoS6qbNZyo3leJS
         NJ1+bKGK0nMhE4k4HcCNARd1p4wJVni3EjuyQhMYuYbsPdkv839EMyxPvOeP9/dW83Qy
         tfaRTEYlge1lHFfOKyEB+9AtPfDnO7vn6JAxB1d4jL6wkteloGn8Ek/tY+3lA4b7kV6s
         BBH2EPspH5j+6SQFTLK32hshtsS9+27Q357c94fkKRSJ2E/tensKmcoLSCiC9qUWxeC+
         VWiGB2Fgl86qGjO05kyi1Fu4pWM0zmDxY4S8fC1b2FdBhuQskDRg+0Yn0NAfuDmoGmNx
         klrw==
X-Gm-Message-State: ANhLgQ2rSyhZCm2Vdxhl69qZzaTOJdGCDWHuWn/Q660WnbH1qZHSQbiq
        TzRG9UOLYUr8LWVN12fZzQ==
X-Google-Smtp-Source: ADFU+vvU5CjB5y9u06eyei85NMjbw5qrIk3jyjI8+yUjUqJ73mj64gxiHt9qRLQ+G4XUWNomDb87UQ==
X-Received: by 2002:a17:90a:aa83:: with SMTP id l3mr4747518pjq.5.1583251797089;
        Tue, 03 Mar 2020 08:09:57 -0800 (PST)
Received: from madhuparna-HP-Notebook ([112.79.49.138])
        by smtp.gmail.com with ESMTPSA id x65sm12449591pfd.34.2020.03.03.08.09.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Mar 2020 08:09:56 -0800 (PST)
From:   Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
X-Google-Original-From: Madhuparna Bhowmik <change_this_user_name@gmail.com>
Date:   Tue, 3 Mar 2020 21:39:06 +0530
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Amol Grover <frextrite@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH 1/2] drivers: base: power: main: Use built-in RCU list
 checking
Message-ID: <20200303160810.GA5486@madhuparna-HP-Notebook>
References: <20200228174630.8989-1-madhuparnabhowmik10@gmail.com>
 <CAJZ5v0jhw+cVm=ViiOtZgKr+a1L_PbeVPNXpsPbgghUvMPODSA@mail.gmail.com>
 <C2E57D31-A459-4F5F-8ECF-484FBB26C065@joelfernandes.org>
 <CAJZ5v0jTSKd_23fJhM+XUmFX_yTjcD+c_s1Jvi3HA1EmXPkzZw@mail.gmail.com>
 <CAEXW_YRL0kum5yVm+9V8i_PK2FcHfPeUOxJKZ+T8P3zqhATxJg@mail.gmail.com>
 <CAD=jOEZ3vdNC4qTMxptaXLjs7i8TCTYjeiv9vXhcapLSkrr9RQ@mail.gmail.com>
 <CAJZ5v0hee4FxeVub_ZkAYn9z8q1_ZLA_AcmTtS-w39VzSe0UxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hee4FxeVub_ZkAYn9z8q1_ZLA_AcmTtS-w39VzSe0UxA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Mar 02, 2020 at 06:02:21PM +0100, Rafael J. Wysocki wrote:
> On Mon, Mar 2, 2020 at 1:34 PM Madhuparna Bhowmik
> <madhuparnabhowmik10@gmail.com> wrote:
> >
> >
> >
> > On Mon, 2 Mar, 2020, 3:48 AM Joel Fernandes, <joel@joelfernandes.org> wrote:
> >>
> >> On Sun, Mar 1, 2020 at 4:23 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >> >
> >> > On Sun, Mar 1, 2020 at 9:53 PM <joel@joelfernandes.org> wrote:
> >> > >
> >> > >
> >> > >
> >> > > On March 1, 2020 3:12:53 PM EST, "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> >> > > >On Fri, Feb 28, 2020 at 6:47 PM <madhuparnabhowmik10@gmail.com> wrote:
> >> > > >>
> >> > > >> From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> >> > > >>
> >> > > >> This patch passes the cond argument to list_for_each_entry_rcu()
> >> > > >> to fix the following false-positive lockdep warnings:
> >> > > >>
> >> > > >> [  330.302784] =============================
> >> > > >> [  330.302789] WARNING: suspicious RCU usage
> >> > > >> [  330.302796] 5.6.0-rc1+ #5 Not tainted
> >> > > >> [  330.302801] -----------------------------
> >> > > >> [  330.302808] drivers/base/power/main.c:326 RCU-list traversed in
> >> > > >non-reader section!!
> >> > > >>
> >> > > >> [  330.303303] =============================
> >> > > >> [  330.303307] WARNING: suspicious RCU usage
> >> > > >> [  330.303311] 5.6.0-rc1+ #5 Not tainted
> >> > > >> [  330.303315] -----------------------------
> >> > > >> [  330.303319] drivers/base/power/main.c:1698 RCU-list traversed in
> >> > > >non-reader section!!
> >> > > >>
> >> > > >> [  331.934969] =============================
> >> > > >> [  331.934971] WARNING: suspicious RCU usage
> >> > > >> [  331.934973] 5.6.0-rc1+ #5 Not tainted
> >> > > >> [  331.934975] -----------------------------
> >> > > >> [  331.934977] drivers/base/power/main.c:1238 RCU-list traversed in
> >> > > >non-reader section!!
> >> > > >>
> >> > > >> [  332.467772] WARNING: suspicious RCU usage
> >> > > >> [  332.467775] 5.6.0-rc1+ #5 Not tainted
> >> > > >> [  332.467775] -----------------------------
> >> > > >> [  332.467778] drivers/base/power/main.c:269 RCU-list traversed in
> >> > > >non-reader section!!
> >> > > >
> >> > > >I don't see these warnings in the kernels run locally here.
> >> > > >
> >> > > >What do you do to get them?
> >> > > >
> >> > > >Joel, any comments here?
> >> > >
> >> > > You have to enable lockdep in your config. Does your setup have that?
> >> >
> >> > CONFIG_LOCK_DEBUGGING_SUPPORT=y
> >> > CONFIG_PROVE_LOCKING=y
> >> > CONFIG_DEBUG_SPINLOCK=y
> >> > CONFIG_DEBUG_LOCK_ALLOC=y
> >> > CONFIG_LOCKDEP=y
> >>
> >>
> > I had CONFIG_PROVE_RCU_LIST = y and I think these warnings were triggered when I had closed my laptop (like just close without shutting down).
> 
> OK, so let's define a macro for that in this file to avoid code duplication.
> 
> And analogously in the second patch.
>
Sure, I will do it and send the patch soon.

> Thanks!
