Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3712DD0E6
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2019 23:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502111AbfJRVMP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Oct 2019 17:12:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:52054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394095AbfJRVMO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 18 Oct 2019 17:12:14 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 444D32089C;
        Fri, 18 Oct 2019 21:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571433134;
        bh=nWv0pT1v8ileCG/uTO1XI4TI/P//OjNODZ+LjyV8Pnk=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date:From;
        b=g0MrlMp1cPSmyMilQM/x8aUF2msz5Kh9rffAd7IdbaMnxc3U+UbXjiLIo+wxDNa0G
         xpMfhYlByJM55jASjiX64wuV127c/ULYwYDlRTFP9+X2hahQKxZgk7+J+jKsveSc+Y
         u2SyLbvDNl6nIL8wIhnBcA04FCEZI81l3hYDDUXs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2700308706c0d46ca06eeb973079a1f18bf553dd.1571390916.git.viresh.kumar@linaro.org>
References: <2700308706c0d46ca06eeb973079a1f18bf553dd.1571390916.git.viresh.kumar@linaro.org>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Nishanth Menon <nm@ti.com>, Viresh Kumar <viresh.kumar@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] opp: Reinitialize the list_kref before adding the static OPPs again
User-Agent: alot/0.8.1
Date:   Fri, 18 Oct 2019 14:12:13 -0700
Message-Id: <20191018211214.444D32089C@mail.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Viresh Kumar (2019-10-18 02:28:41)
> The list_kref reaches a count of 0 when all the static OPPs are removed,
> for example when dev_pm_opp_of_cpumask_remove_table() is called, though
> the actual OPP table may not get freed as it may still be referenced by
> other parts of the kernel, like from a call to
> dev_pm_opp_set_supported_hw(). And if we call
> dev_pm_opp_of_cpumask_add_table() again at this point, we must
> reinitialize the list_kref otherwise the kernel will hit a WARN() in
> kref infrastructure for incrementing a kref with value 0.
>=20
> Fixes: 11e1a1648298 ("opp: Don't decrement uninitialized list_kref")
> Reported-by: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/opp/of.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 6dc41faf74b5..1cbb58240b80 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -663,6 +663,13 @@ static int _of_add_opp_table_v2(struct device *dev, =
struct opp_table *opp_table)
>                 return 0;
>         }
> =20
> +       /*
> +        * Re-initialize list_kref every time we add static OPPs to the O=
PP
> +        * table as the reference count may be 0 after the last tie stati=
c OPPs

s/tie/time/

> +        * were removed.
> +        */
> +       kref_init(&opp_table->list_kref);

It seems racy. Why are we doing this vs. making an entirely new and
different OPP structure? Or why is the count reaching 0 when something
is obviously still referencing it?

> +
>         /* We have opp-table node now, iterate over it and add OPPs */
>         for_each_available_child_of_node(opp_table->np, np) {
>                 opp =3D _opp_add_static_v2(opp_table, dev, np);
