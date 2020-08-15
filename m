Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC1F245420
	for <lists+linux-pm@lfdr.de>; Sun, 16 Aug 2020 00:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbgHOWMs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 15 Aug 2020 18:12:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:41772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728787AbgHOWK1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 15 Aug 2020 18:10:27 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20A4A22DBF;
        Sat, 15 Aug 2020 08:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597478593;
        bh=2YAaeXqnIxpTxcvp+gkdqr00TyuFnSBiXPvvQsS/1S8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=aTdvelhcDS6+WntNjpiJrmmTg0/fEpvpqr6npg7eBxu/5+LO+YqOhG1mdsrqX/7gs
         nK9ebxaqXPHzYoN6LG83OIQaMCFXkZabbWZQa+D+SvWc8Q3/P1GPp5AWiefb29obck
         4ObLJOn75w2Irkqn2mtHLriIM3G52qsge/ilfdyo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <453b3897507838e95359d891ef967165bd167a4e.1597292833.git.viresh.kumar@linaro.org>
References: <1597043179-17903-1-git-send-email-rnayak@codeaurora.org> <c6bba235a9a6fd777255bb4f1d16492fdcabc847.1597292833.git.viresh.kumar@linaro.org> <453b3897507838e95359d891ef967165bd167a4e.1597292833.git.viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/4] opp: Track device's resources configuration status
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, mka@chromium.org,
        sibis@codeaurora.org, linux-kernel@vger.kernel.org
To:     Nishanth Menon <nm@ti.com>, Viresh Kumar <viresh.kumar@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>
Date:   Sat, 15 Aug 2020 01:03:11 -0700
Message-ID: <159747859192.33733.13232258434530046392@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Viresh Kumar (2020-08-12 21:28:59)
> The OPP core needs to track if the resources of devices are enabled or
> configured or not, as it disables the resources when target_freq is set
> to 0.
>=20
> Handle that with a separate variable to make it easy to maintain.
>=20
> Also note that we will unconditionally call clk_set_rate() in the case
> where the resources are getting enabled again. This shouldn't have any
> side effects anyway.

Any reason to want to do that? We'll have to grab the prepare lock in
the clk framework to figure out that there's nothing to do sometimes. If
anything, a comment may help to indicate that we call clk_set_rate()
again, but don't expect it to matter much.
