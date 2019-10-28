Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD189E70E2
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2019 13:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfJ1MBe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Oct 2019 08:01:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:33106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbfJ1MBe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 28 Oct 2019 08:01:34 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E85F2086D;
        Mon, 28 Oct 2019 12:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572264093;
        bh=7l51Tf/Rpvd4APPr9YhiQKI2qTfKJAwzghAiuVldklc=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=dVBGlTgnyQ+3dFD20QojrvGrnCVQYwCiC7EeyMVFHS4DiX57IZyYVUS4pquoVuEc5
         UUEiLY0XodyjpKfJRjcwQPSO2yDbUdtuJ4iip06KB+n174g7vPhR3FEVh7Fap3bjOu
         8lLesUr0A0gmHnaA4SOzFlahNoa0c63VYqhKpJSI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191021022516.gecunkpahu7okvm5@vireshk-i7>
References: <2700308706c0d46ca06eeb973079a1f18bf553dd.1571390916.git.viresh.kumar@linaro.org> <20191018211214.444D32089C@mail.kernel.org> <20191021022516.gecunkpahu7okvm5@vireshk-i7>
Cc:     Nishanth Menon <nm@ti.com>, Viresh Kumar <vireshk@kernel.org>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] opp: Reinitialize the list_kref before adding the static OPPs again
To:     Viresh Kumar <viresh.kumar@linaro.org>
User-Agent: alot/0.8.1
Date:   Mon, 28 Oct 2019 05:01:32 -0700
Message-Id: <20191028120133.3E85F2086D@mail.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Viresh Kumar (2019-10-20 19:25:16)
> On 18-10-19, 14:12, Stephen Boyd wrote:
> > Quoting Viresh Kumar (2019-10-18 02:28:41)
> > > The list_kref reaches a count of 0 when all the static OPPs are remov=
ed,
> > > for example when dev_pm_opp_of_cpumask_remove_table() is called, thou=
gh
> > > the actual OPP table may not get freed as it may still be referenced =
by
> > > other parts of the kernel, like from a call to
> > > dev_pm_opp_set_supported_hw(). And if we call
> > > dev_pm_opp_of_cpumask_add_table() again at this point, we must
> > > reinitialize the list_kref otherwise the kernel will hit a WARN() in
> > > kref infrastructure for incrementing a kref with value 0.
> > >=20
> > > Fixes: 11e1a1648298 ("opp: Don't decrement uninitialized list_kref")
> > > Reported-by: Dmitry Osipenko <digetx@gmail.com>
> > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > ---
> > >  drivers/opp/of.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >=20
> > > diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> > > index 6dc41faf74b5..1cbb58240b80 100644
> > > --- a/drivers/opp/of.c
> > > +++ b/drivers/opp/of.c
> > > @@ -663,6 +663,13 @@ static int _of_add_opp_table_v2(struct device *d=
ev, struct opp_table *opp_table)
> > >                 return 0;
> > >         }
> > > =20
> > > +       /*
> > > +        * Re-initialize list_kref every time we add static OPPs to t=
he OPP
> > > +        * table as the reference count may be 0 after the last tie s=
tatic OPPs
> >=20
> > s/tie/time/
> >=20
> > > +        * were removed.
> > > +        */
> > > +       kref_init(&opp_table->list_kref);
> >=20
> > It seems racy.
>=20
> I am not sure if I see a race here, but maybe I am missing something.
> Care to explain ?

Some static OPP is removed at the same time that this function is
called?

>=20
> > Why are we doing this vs. making an entirely new and
> > different OPP structure? Or why is the count reaching 0 when something
> > is obviously still referencing it?
>=20
> The kref for the opp table is opp_table->kref and the one here is
> different. This is list_kref which is used for freeing OPPs added
> statically from the DT. The static OPPs get added to the OPP table
> when one calls dev_pm_opp_of_cpumask_add_table() and must be removed
> on a call to dev_pm_opp_of_cpumask_remove_table(). The opp table
> structure may not get freed at this moment though as it is still
> referenced by the caller of dev_pm_opp_set_supported_hw().
>=20
> And now when we try to add the static OPPs again (re-insertion of
> cpufreq module), we need to reinitialize the list_kref again as its
> count reached 0 earlier and the resources (static OPPs) were freed.
>=20

Right. I don't understand why the count reaches 0 if we can still get a
pointer to something. I guess we've got this kref thing that has a
lifetime beyond the life of what it's tracking, which is weird. Usually
the kref is embedded inside the pointer that is returned by the "get"
call, but here it's outside it and used to track when we should free
static OPPs. Why are we removing static OPPs? Shouldn't they just stick
around forever until the device is deleted vs. populated over and over
again?

