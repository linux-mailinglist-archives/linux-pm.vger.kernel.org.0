Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2AFD90764
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2019 20:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfHPSBY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Aug 2019 14:01:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:60732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbfHPSBY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 16 Aug 2019 14:01:24 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6299720665;
        Fri, 16 Aug 2019 18:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565978483;
        bh=XqtifSXX9OUPb9A8BckG9vL0E6DJew+nlH5Ft32w1cs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=fAFHbbvuaUYlD6QgldrNCvmvteqOc8Zz+0OypyoMrHeq1UNSsOXiikQgFnOTksa+w
         kWlkSZtLAdvw1irRddjKq5DelKgzIr4XgubaKfrg7DQlLXXiKKtQZA+Fb//mC6ev+M
         0iaykEptG0hMrRDYxWF9Ktulc35tp8Sjp8tC8y4A=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190816125225.16061-2-geert+renesas@glider.be>
References: <20190816125225.16061-1-geert+renesas@glider.be> <20190816125225.16061-2-geert+renesas@glider.be>
Subject: Re: [PATCH 1/3] clk: renesas: mstp: Set GENPD_FLAG_ALWAYS_ON for clock domain
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>
User-Agent: alot/0.8.1
Date:   Fri, 16 Aug 2019 11:01:22 -0700
Message-Id: <20190816180123.6299720665@mail.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Geert Uytterhoeven (2019-08-16 05:52:23)
> The CPG/MSTP Clock Domain driver does not implement the
> generic_pm_domain.power_{on,off}() callbacks, as the domain itself
> cannot be powered down.  Hence the domain should be marked as always-on
> by setting the GENPD_FLAG_ALWAYS_ON flag.
>=20
> This gets rid of the following boot warning on RZ/A1:
>=20
>     sh_mtu2 fcff0000.timer: PM domain cpg_clocks will not be powered off
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Are you going to add a Fixes tag?

