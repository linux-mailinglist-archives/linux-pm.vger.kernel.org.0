Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 546EAF5993
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2019 22:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732930AbfKHVPj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Nov 2019 16:15:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:56982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732926AbfKHVPj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 8 Nov 2019 16:15:39 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9543720869;
        Fri,  8 Nov 2019 21:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573247738;
        bh=0OHKn/NSP13Adarhq9wPSTSqkcmLeCqcUJ/45x0J6ok=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date:From;
        b=JPORAN6QAt8G+verpqAPM4zK4BVLDPAyfMBkFDOckhcyz7af3S2g4htaHUO2ENWJP
         DTKTvMhfJHfDx+T3Y8TyJhCEu2H2fjd9YVZyu8fBP08ybyWbx5Zk5UkyJLwjjXs6SO
         m8lVWe7z2JXWJXzXW4h/G08DGtzDTqlIqVemrTgM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191108185503.GB3384779@ulmo>
References: <1565984527-5272-1-git-send-email-skomatineni@nvidia.com> <1565984527-5272-8-git-send-email-skomatineni@nvidia.com> <20191106231005.F2CD820869@mail.kernel.org> <fcc43ccb-8c6e-d518-4c70-503501706ffd@gmail.com> <20191107152115.GA2580600@ulmo> <20191107191933.0B18021D6C@mail.kernel.org> <20191108101116.GA2583136@ulmo> <20191108181249.E284E214DB@mail.kernel.org> <20191108185503.GB3384779@ulmo>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        jason@lakedaemon.net, jonathanh@nvidia.com,
        linus.walleij@linaro.org, marc.zyngier@arm.com,
        mark.rutland@arm.com, stefan@agner.ch, tglx@linutronix.de,
        pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        jckuo@nvidia.com, josephl@nvidia.com, talho@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        mperttunen@nvidia.com, spatra@nvidia.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v9 07/22] clk: Add API to get index of the clock parent
User-Agent: alot/0.8.1
Date:   Fri, 08 Nov 2019 13:15:37 -0800
Message-Id: <20191108211538.9543720869@mail.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Thierry Reding (2019-11-08 10:55:03)
> On Fri, Nov 08, 2019 at 10:12:49AM -0800, Stephen Boyd wrote:
> >=20
> > Sure a WARN_ON() sounds fair. That will not take the whole task down
> > and makes sure that drivers aren't doing something incorrect. Otherwise,
> > this looks good and we can optimize by caching the parent index later if
> > we really need to.
>=20
> Okay, great. I'll go replace the above patch in the branch that I have.
> I'm not sure if you saw it, but I had sent this in a pull request for
> v5.5-rc1 about a week ago because I've got Tegra clock driver patches
> that depend on this. I can replace this patch with the above proposal
> and update the Tegra clock driver branch and then resend the two pull
> requests.
>=20
> Does that sound like a plan?
>=20

Yes please refresh the PRs. I don't think anything else is concerning
but I'll go do a sweep over the Tegra patches right now.

