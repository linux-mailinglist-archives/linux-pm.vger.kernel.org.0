Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63CBB903D8
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2019 16:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfHPOTi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Aug 2019 10:19:38 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37032 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727299AbfHPOTh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Aug 2019 10:19:37 -0400
Received: by mail-pg1-f193.google.com with SMTP id d1so2433742pgp.4
        for <linux-pm@vger.kernel.org>; Fri, 16 Aug 2019 07:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=tBN0L54QMtDYld2dZHBXnZOaHPOrCsY9yGKAHJ7HtJ0=;
        b=iLtynzXp2unH1FB4V6Qf4QmIe20CFCYKaGvYyJveb4LxrCW63jAtA3i9KRJeoxmJJJ
         NK6IDGqtsnMNG1Kp/P8KjwSrredRdP9H3MvonGVmiFS3VouEsfA8pc2ebyf38oWLOigf
         gl3KBPJUfHK7xBL4pKE9E3qXAPNOFMF1nrZzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=tBN0L54QMtDYld2dZHBXnZOaHPOrCsY9yGKAHJ7HtJ0=;
        b=G2sr5SKvE2xso+vArp78+roeuZp2lVRO5pGKb38qGjcp2HNOR3KdCCZIITDV2zS56i
         qt37wdPrArHoqu8jiGMTNEpH8tEBIc9vRLo375XnqVa9M16KX1wEiPj6jH6EqzrKC2WH
         Mw0QSAj8SPHemJQqvE7UO37lYaJ4CPW5Uti6BgG7N5A0LcFZQ5x7DNe/mTJv9qcK7jEW
         LYA62kv5qaps+WFsC2PjD39kjIiPwSEYWeK7rCCp8PFa5jZx3kyRDC7uwoco7GJQUjte
         BZ2qXgQVfQgf6LieHZzsJTeBknMtLyzCpN4fzr63vwHjQMrPVrSsiv+UVA/e3P8HT9vO
         ZyMA==
X-Gm-Message-State: APjAAAUJaMT2RInVxtouy2ZKx4SgBjrmetvxZHPXWdkyzk3I7wYRGZy4
        nyT1GbPSiuOxGQ/5XMPmptsi1Q==
X-Google-Smtp-Source: APXvYqwwzm10fJ3ctwq/5tUrgeLy9Mcr/LM5jM1mglSPuSxrCJ+a04sKYfNc0DSOUi94rf+krvKZlg==
X-Received: by 2002:a62:198d:: with SMTP id 135mr10915627pfz.169.1565965176712;
        Fri, 16 Aug 2019 07:19:36 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id p1sm6067967pff.44.2019.08.16.07.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 07:19:35 -0700 (PDT)
Message-ID: <5d56bb77.1c69fb81.58e9d.1f86@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAJZ5v0hY8=0j=heXuAS-5cBafDSE8ZakLDW4NGCjAbxUAt3j4Q@mail.gmail.com>
References: <1565731976.8572.16.camel@lca.pw> <5d53b238.1c69fb81.d3cd3.cd53@mx.google.com> <20190814084014.GB52127@atomide.com> <CANA+-vDeSAYUNfTQzQPT2N_CUgvYr6i_LP_BdHT_zX+FPt8NHg@mail.gmail.com> <CAJZ5v0hY8=0j=heXuAS-5cBafDSE8ZakLDW4NGCjAbxUAt3j4Q@mail.gmail.com>
Subject: Re: "PM / wakeup: Show wakeup sources stats in sysfs" causes boot warnings
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Tony Lindgren <tony@atomide.com>, Qian Cai <cai@lca.pw>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>, Tri Vo <trong@android.com>
User-Agent: alot/0.8.1
Date:   Fri, 16 Aug 2019 07:19:35 -0700
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Rafael J. Wysocki (2019-08-16 05:17:23)
> On Wed, Aug 14, 2019 at 8:37 PM Tri Vo <trong@android.com> wrote:
> >
> > On Wed, Aug 14, 2019 at 1:40 AM Tony Lindgren <tony@atomide.com> wrote:
> > >
> > > * Stephen Boyd <swboyd@chromium.org> [691231 23:00]:
> > > > I also notice that device_set_wakeup_capable() has a check to see i=
f the
> > > > device is registered yet and it skips creating sysfs entries for the
> > > > device if it isn't created in sysfs yet. Why? Just so it can be cal=
led
> > > > before the device is created? I guess the same logic is handled by
> > > > dpm_sysfs_add() if the device is registered after calling
> > > > device_set_wakeup_*().
> > >
> > > Hmm just guessing.. It's maybe because drivers can enable and disable
> > > the wakeup capability at any point for example like driver/net drivers
> > > do based on WOL etc?
> > >
> > > > There's two approaches I see:
> > > >
> > > >       1) Do a similar check for device_set_wakeup_enable() and skip
> > > >       adding the wakeup class until dpm_sysfs_add().
> > > >
> > > >       2) Find each case where this happens and only call wakeup APIs
> > > >       on the device after the device is added.
> > > >
> > > > I guess it's better to let devices have wakeup modified on them bef=
ore
> > > > they're registered with the device core?
> > >
> > > I think we should at least initially handle case #1 above as multiple
> > > places otherwise seem to break. Then maybe we could add a warning to
> > > help fix all the #2 cases if needed?
> >
> > Makes sense. For case#1, we could also just register the wakeup source
> > without specifying the parent device if the latter hasn't been
> > registered yet. Userspace won't be able to associate a wakeup source
> > to the parent device. But I think it's a reasonable fix, assuming we
> > want to fix devices not being added before calling wakeup APIs #2.
>=20
> Well, OK
>=20
> I'm going to drop the entire series from linux-next at this point and
> let's start over.

I was going to send the first patch I floated as a more formal patch to
be applied to the PM tree. I was waiting to see if the semantics of
device_set_wakeup_*() could be clarified because I don't understand if
they're allowed to be called before device_add().

>=20
> Also note that all of this is not an issue until we start to add
> children under the device passed to device_set_wakeup_enable() and
> friends so maybe that is not a good idea after all?

My primary goal is to know what wakeup is associated with a device. If
we delay creation of the sysfs node to the time that device_add() is
called then it will allow device_set_wakeup_enable() to be called before
the device is published to userspace. Is anything wrong with that? This
seems to be the intention of the API based on the way
device_set_wakeup_capable() is written. Furthermore, if we make this
change then we don't need to fix various drivers to reorder calls to
device_set_wakeup_enable() and device_add(), so it looks like the right
approach.

I'll send the patch over the list now and let you decide. I'll also send
a patch for serio to have it operate on the device in a less racy way,
but not necessarily after the device_add() is called.

