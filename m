Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 492C9249356
	for <lists+linux-pm@lfdr.de>; Wed, 19 Aug 2020 05:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbgHSDOP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Aug 2020 23:14:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:47766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727077AbgHSDON (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 18 Aug 2020 23:14:13 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AE392065F;
        Wed, 19 Aug 2020 03:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597806853;
        bh=hLuwTC7klaEgIk64JrkEA7uqeW5wvcuVuslfVY4Brv8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Z8MP8FCwKQucUhc1d23z5aT8pfgxeSEVQ4qA4Z4OKn5culdPfiUhljFQPZa9wn1ap
         Oeeb3+G7yA9VhJP7iu+UV4wPAbfpriAh3KIqZHqcVUIjJvyYhSvuqcTVUNH7kxsbWd
         UiKCDUEaT4WF0hae7Wa4ngIxAqstH1tE8TkqgvKE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200807133143.22748-1-m.szyprowski@samsung.com>
References: <CGME20200807133152eucas1p1d83611a984f5c5d875192d08e2f5711f@eucas1p1.samsung.com> <20200807133143.22748-1-m.szyprowski@samsung.com>
Subject: Re: [PATCH v2] clk: samsung: Keep top BPLL mux on Exynos542x enabled
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lukasz Luba <lukasz.luba@arm.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Date:   Tue, 18 Aug 2020 20:14:12 -0700
Message-ID: <159780685238.334488.5802955284004610550@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Marek Szyprowski (2020-08-07 06:31:43)
> BPLL clock must not be disabled because it is needed for proper DRAM
> operation. This is normally handled by respective memory devfreq driver,
> but when that driver is not yet probed or its probe has been deferred the
> clock might got disabled what causes board hang. Fix this by calling
> clk_prepare_enable() directly from the clock provider driver.
>=20
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> Tested-by: Lukasz Luba <lukasz.luba@arm.com>
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---

Can I pick this up for clk-fixes?
