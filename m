Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 691933922C8
	for <lists+linux-pm@lfdr.de>; Thu, 27 May 2021 00:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234525AbhEZWfH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 May 2021 18:35:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:52080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234278AbhEZWfH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 26 May 2021 18:35:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 64D34613CA;
        Wed, 26 May 2021 22:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622068415;
        bh=Lgc2ApRO4m7E7FHqU9DmoWY4keZyJY0T6HyK7vuHDkY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=HtKesleSte7hB3z0+wNl6epd0GgeKEzh3Q+gRZ88dSKbgwsZkREsndbQBhD8c8UBN
         Rh/cySddD1WwD3/zF4TPhVH1pYINGzrmFUme74BKeYU4swxEV4T8p5hGZqxwvr1sCf
         Lw4K8nb0N3JvbJsFCN+Z3ynvC+SiwSgNrY6ARuBmfG6nbAW0wjjiyl6SITlQSphAW/
         cL38SowC1CrVp1QVjjMfAjr0+x1d7m+rFBJtCMFD3Jjnbk+l9c1GNuLJClUjP+S056
         vMq4fP1Wh16PhszXQtyzCgEfzwJ5XyPtk5b/LecS4YuDk0ug7XEVch9N6kTHMgtTMg
         /5yxyj1YXss7w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210526172036.183223-3-krzysztof.kozlowski@canonical.com>
References: <20210526172036.183223-1-krzysztof.kozlowski@canonical.com> <20210526172036.183223-3-krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH v2 2/7] mfd: max77686: Do not enforce (incorrect) interrupt trigger type
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh@kernel.org>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Date:   Wed, 26 May 2021 15:33:34 -0700
Message-ID: <162206841417.4130789.13945208806958598688@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Krzysztof Kozlowski (2021-05-26 10:20:31)
> From: Krzysztof Kozlowski <krzk@kernel.org>
>=20
> Interrupt line can be configured on different hardware in different way,
> even inverted.  Therefore driver should not enforce specific trigger
> type - edge falling - but instead rely on Devicetree to configure it.
>=20
> The Maxim 77686 datasheet describes the interrupt line as active low
> with a requirement of acknowledge from the CPU therefore the edge
> falling is not correct.
>=20
> The interrupt line is shared between PMIC and RTC driver, so using level
> sensitive interrupt is here especially important to avoid races.  With
> an edge configuration in case if first PMIC signals interrupt followed
> shortly after by the RTC, the interrupt might not be yet cleared/acked
> thus the second one would not be noticed.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Acked-by: Rob Herring <robh@kernel.org>
>=20
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org> # clock binding
