Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3593C249348
	for <lists+linux-pm@lfdr.de>; Wed, 19 Aug 2020 05:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgHSDMa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Aug 2020 23:12:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:45788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbgHSDMa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 18 Aug 2020 23:12:30 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF7182065F;
        Wed, 19 Aug 2020 03:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597806749;
        bh=g3ZGFP1PMiMQKLZBUCjQAQ2Iyb4s3PJWHgJWDCLAgJ4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=fxptJaq6layzDvL5cV7ucXpPZVJq5STOYXySIz5C6erwfaj+/7jWlURafEEBDA0Ed
         pvQvb237X5DBr+NE8gwORg4irdKTDQbCCLpAycmU7Ui7GnZYv6n6evJ5t0mQQc9q/Z
         QeQB18/FDDEfFb3gpmai5LeA08KmI2KjZgsLTS8s=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2ab29b37-5e7f-1a7a-e29c-f20f95aec1a9@kernel.org>
References: <CGME20200807133152eucas1p1d83611a984f5c5d875192d08e2f5711f@eucas1p1.samsung.com> <20200807133143.22748-1-m.szyprowski@samsung.com> <2ab29b37-5e7f-1a7a-e29c-f20f95aec1a9@kernel.org>
Subject: Re: [PATCH v2] clk: samsung: Keep top BPLL mux on Exynos542x enabled
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lukasz Luba <lukasz.luba@arm.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Date:   Tue, 18 Aug 2020 20:12:28 -0700
Message-ID: <159780674861.334488.4319979250253283002@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Sylwester Nawrocki (2020-08-11 04:31:30)
> On 8/7/20 15:31, Marek Szyprowski wrote:
> > BPLL clock must not be disabled because it is needed for proper DRAM
> > operation. This is normally handled by respective memory devfreq driver,
> > but when that driver is not yet probed or its probe has been deferred t=
he
> > clock might got disabled what causes board hang. Fix this by calling
> > clk_prepare_enable() directly from the clock provider driver.
> >=20
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> > Tested-by: Lukasz Luba <lukasz.luba@arm.com>
> > Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
>=20
> Should we add a "Fixes" tag so this commit gets backported down do the=20
> kernels where the DMC driver was introduced?
>=20
> Fixes: 6e7674c3c6df ("memory: Add DMC driver for Exynos5422") ?

I've recently discovered that stable trees aren't checking for Fixes
tags. So we have to put both a Fixes tag and a Cc stable on the patch
to make sure it gets applied to stable trees. Otherwise it's up to the
robot to figure out that a Fixes tag means maybe this is important.
