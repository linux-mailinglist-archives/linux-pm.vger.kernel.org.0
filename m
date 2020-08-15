Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9A0F245406
	for <lists+linux-pm@lfdr.de>; Sun, 16 Aug 2020 00:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbgHOWLF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 15 Aug 2020 18:11:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:41790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729475AbgHOWKb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 15 Aug 2020 18:10:31 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49F522078D;
        Sat, 15 Aug 2020 07:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597478126;
        bh=1xWL3OUbyTr894ufEXenLPaJIkNLutYTw8RXVEGQrNQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=BYS1jtankkHzJKx8pLSKDeCyoDquM4rFZEt4s1jTIU1WJLJLwFgQpv2/0oarVaimQ
         nmJ2dSvGjAqCxM677HpuUPrhthfGWN9/hueT9GPIyZbdknjMbjUPRTdeuAOT5igjFM
         HzWACWNEr6OBJYZ+pA7yL/aq4b5QXRvnGdPTLdSs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <359b588928b7e58b009f786b17ddc088c6a7d18b.1597292833.git.viresh.kumar@linaro.org>
References: <1597043179-17903-1-git-send-email-rnayak@codeaurora.org> <c6bba235a9a6fd777255bb4f1d16492fdcabc847.1597292833.git.viresh.kumar@linaro.org> <359b588928b7e58b009f786b17ddc088c6a7d18b.1597292833.git.viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/4] opp: Reused enabled flag and remove regulator_enabled
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, mka@chromium.org,
        sibis@codeaurora.org, linux-kernel@vger.kernel.org
To:     Nishanth Menon <nm@ti.com>, Viresh Kumar <viresh.kumar@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>
Date:   Sat, 15 Aug 2020 00:55:25 -0700
Message-ID: <159747812515.33733.6233341429546003955@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Viresh Kumar (2020-08-12 21:29:00)
> The common "enabled" flag can be used here instead of
> "regulator_enabled" now.
>=20
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Why not put this before the other patch? And mention that it will be
reused in another place soon? Then the previous patch won't look like
we're adding a variable to the struct when it is only used inside a
single function. Or at least squash it with the previous patch.

> ---
>  drivers/opp/core.c | 13 +++----------
>  drivers/opp/opp.h  |  2 --
>  2 files changed, 3 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index e8882e7fd8a5..5f5da257f58a 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -703,12 +703,10 @@ static int _generic_set_opp_regulator(struct opp_ta=
ble *opp_table,
>          * Enable the regulator after setting its voltages, otherwise it =
breaks
>          * some boot-enabled regulators.
>          */
> -       if (unlikely(!opp_table->regulator_enabled)) {
> +       if (unlikely(!opp_table->enabled)) {
>                 ret =3D regulator_enable(reg);
>                 if (ret < 0)
>                         dev_warn(dev, "Failed to enable regulator: %d", r=
et);
> -               else
> -                       opp_table->regulator_enabled =3D true;

A quick glance makes this look unsafe now because we're only checking
'enabled' and not actually setting it when this function is called. I
have to go back to the previous patch to understand where enabled is now
set to confirm that it is OK. If it was all one patch all the context
would be here.
