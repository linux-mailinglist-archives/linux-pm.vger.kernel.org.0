Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B87B3B56DE
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jun 2021 03:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbhF1Bp1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Jun 2021 21:45:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:42436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231706AbhF1Bp1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 27 Jun 2021 21:45:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2758C61A1D;
        Mon, 28 Jun 2021 01:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624844582;
        bh=066YMFHqSGCgkK9gz/RQO+n11OjyRE0FlxJc5NciWS0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=tF2R/1UeKoBw+YfNGIuMni8e/F24wDYu6UgRnJO65rSiuzSqX0ht37aQtoJbB5qTl
         Gc6cTbF0kJ4ItKbo+MJhSo5w+eRgxBbjlUmK8TKkpBZTlHUFq5ybSUc80gLz4ITKAD
         13UGSDy3pzuTT84DldFJdRqkIwoibcW8ZegVYGaBbTEC3BDUK+K58TDgyAVekRTRe/
         KidmuMALXGEVTF+wFE6rnL28ckAqKXwAevmC0CyS9J6t87tC6x+CrmqYCuxWbBmvFM
         x3lBrQ+m7ZjNE80ZnmhgBZPXCvzUkieUvpxyuy9BPuRTS/xJpFFPtHa3yRm9PYWYP5
         c/Arh4ZkpATXA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <937ed0828486a08e2d00bce2815d491c1c9c49b4.1621937490.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1621937490.git.matti.vaittinen@fi.rohmeurope.com> <937ed0828486a08e2d00bce2815d491c1c9c49b4.1621937490.git.matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH 5/9] clk: bd718xx: Drop BD70528 support
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sebastian Reichel <sre@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-power@fi.rohmeurope.com, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Date:   Sun, 27 Jun 2021 18:43:00 -0700
Message-ID: <162484458090.3259633.13766939155374243434@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Matti Vaittinen (2021-05-25 03:15:10)
> The only known BD70528 use-cases are such that the PMIC is controlled
> from separate MCU which is not running Linux. I am not aware of
> any Linux driver users. Furthermore, it seems there is no demand for
> this IC. Let's ease the maintenance burden and drop the driver. We can
> always add it back if there is sudden need for it.
>=20
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
>=20
> ---

Applied to clk-next
