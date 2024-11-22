Return-Path: <linux-pm+bounces-17972-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 883819D64F9
	for <lists+linux-pm@lfdr.de>; Fri, 22 Nov 2024 21:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 148DB1617FC
	for <lists+linux-pm@lfdr.de>; Fri, 22 Nov 2024 20:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D33187FEC;
	Fri, 22 Nov 2024 20:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmJv6Kho"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC76917B428;
	Fri, 22 Nov 2024 20:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732308221; cv=none; b=AaOSmWhn0drzeFMI7Au4EGn3aR1XCKcG72Xyx69s5kFIa5RVhrnDri3pukdgW0jsR1KjxCpuwt6BSbZMGpiLMHjAML+qBwkWbh8wn0OFBzJMavTok2kzAvZPxvujO1XR8lDKwZBhQMivR5+gzOCaLR8lJS9V081cw3cQqF1iLII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732308221; c=relaxed/simple;
	bh=9ur4fx8g1n2aQGv6Iks60+fVeXS+jljxmXCqMX/FUJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JSTJ/Tuos4ZSVw1zdDQWw38FD84A9zDgb9gZVqCXua5NJNdOyGqgXww6UK9Wtw5Zvjcpdlnuw5qEkdMsyiAutleUH0bkWCV+j8WvaUO1FWPH7Ca10dUJAXbq4eJMB2ZncScvSObOaVF8pdx7AbzUIjqokTfhKA/ooVvZM+fVa4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WmJv6Kho; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65824C4CED0;
	Fri, 22 Nov 2024 20:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732308220;
	bh=9ur4fx8g1n2aQGv6Iks60+fVeXS+jljxmXCqMX/FUJ4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WmJv6KhouoPjpYLnMmpuN8uVIn3pLQ0Vd7k2AQGH9abPMLZZhMmh9G6MWgp1q8m4I
	 Pr/Vc3akz8klX7oxufe/3NkQDg5Xqh7480yRTyKme5dz5LHpLPSreF2O7o0qcfwUdQ
	 pYpCWaGGkzeSZV6r3tdVuAQnq83X5DIBGBUrORRoVb+1zpbjA5SQHi4WbWgZjAuvqE
	 hS+XC/Ouj4fPKANKiMnRvsh942pLYXZ6agsarnLBIMOtl9595DP4WIDVp3LB8yBFRq
	 wlHudLoPFIOdYGvsdqu6nw/2VbtDWeGEJvzoOhab7RmDCoYYFouD97rsHObLFnfNiS
	 ypKOd1a3pR0MA==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5ec1ee25504so1213094eaf.3;
        Fri, 22 Nov 2024 12:43:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUER6iThg7MTu6Axtj3mJ4cg1reKPjWD7bcaybaXf5gLIxxRWowMmr7qJr2Xu6a5mnoPKhslxM+JN7SNumU@vger.kernel.org, AJvYcCUiChhOCMNvd/q4wZKzxz9NcpWtvjOnFwXbNS6G3gZlR+YaWXgjk/4+rV3GhwlQAzgNCMCMoPxXwUs=@vger.kernel.org, AJvYcCXCnhLQ4UBt3D0FthQ2Int6rdI+O/9z6bwgZRX2Q6CUFBjKuiPP5r+IHajCCnkTbD2LVUJf/DOjNl9xVII=@vger.kernel.org, AJvYcCXmKKRQ7W7GqYrSdnnv9OSxiip05TYsiLpXHEYCXO8NYVuzGEaVhbCjukueEErt73SikOGNDlQ8BoIsZWIV@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+62R+E+1npT1UVEPwCP3cPFeMf9fUp0BXu3ZTqVy6BcX57Cyy
	3oMAcTLC9wKR7OyHQ5T/lbVhjnDWNcHCte+AHS6hx1b9zPKbS3xEzdbudKbgOmsprdTaCyQjQV7
	1Z8mnZsycJa4qo9tTOSU3P0bjuZg=
X-Google-Smtp-Source: AGHT+IEutDuraKb6w9V+8CLjNMD2UYE+lNm29XfGmOiaTuVzMfm8AxFlD6kXcNxHi/+pw8cR8P3Zi9iHFF2EXbeKgV0=
X-Received: by 2002:a05:6871:69c1:b0:287:d8df:7c22 with SMTP id
 586e51a60fabf-29720c59d21mr4407291fac.23.1732308219677; Fri, 22 Nov 2024
 12:43:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010-b4-cleanup-h-of-node-put-thermal-v4-0-bfbe29ad81f4@linaro.org>
In-Reply-To: <20241010-b4-cleanup-h-of-node-put-thermal-v4-0-bfbe29ad81f4@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 22 Nov 2024 21:43:28 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jjjA6enruipTU9kTnuA6x5p_XUQyXc-4Cr4bo_b4VHtQ@mail.gmail.com>
Message-ID: <CAJZ5v0jjjA6enruipTU9kTnuA6x5p_XUQyXc-4Cr4bo_b4VHtQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] thermal: scope/cleanup.h improvements
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Vasily Khoruzhick <anarsoul@gmail.com>, Yangtao Li <tiny.windzz@gmail.com>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Chen-Yu Tsai <wenst@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Thu, Oct 10, 2024 at 8:06=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Changes in v4:
> - Patch 2: rewrite, significant change: kzalloc() also with
>   scoped-handling so the entire error handling could be removed.
>   Due to above, drop review-tags (Chen-Yu, Jonathan).
> - Add Rb tags for other patches.
> - Link to v3: https://lore.kernel.org/r/20241008-b4-cleanup-h-of-node-put=
-thermal-v3-0-825122398f71@linaro.org
>
> Changes in v3:
> - Rebase, because there was bigger rework in thermal code.
>   This made two patches obsolete, but brought new one:
>   1/6: thermal: of: Simplify thermal_of_should_bind with scoped for each =
OF child
> - Link to v2: https://lore.kernel.org/r/20240816-b4-cleanup-h-of-node-put=
-thermal-v2-0-cee9fc490478@linaro.org
>
> Changes in v2:
> - Drop left-over of_node_put in regular exit path (Chen-Yu)
> - Link to v1: https://lore.kernel.org/r/20240814-b4-cleanup-h-of-node-put=
-thermal-v1-0-7a1381e1627e@linaro.org
>
> Few code simplifications with scope/cleanup.h.
>
> Best regards,
> Krzysztof
>
> ---
> Krzysztof Kozlowski (6):
>       thermal: of: Simplify thermal_of_should_bind with scoped for each O=
F child
>       thermal: of: Use scoped memory and OF handling to simplify thermal_=
of_trips_init()
>       thermal: of: Use scoped device node handling to simplify of_thermal=
_zone_find()
>       thermal: qcom-spmi-adc-tm5: Simplify with scoped for each OF child =
loop
>       thermal: tegra: Simplify with scoped for each OF child loop
>       thermal: sun8i: Use scoped device node handling to simplify error p=
aths
>
>  drivers/thermal/qcom/qcom-spmi-adc-tm5.c |  7 ++---
>  drivers/thermal/sun8i_thermal.c          | 11 +++----
>  drivers/thermal/tegra/soctherm.c         |  5 ++-
>  drivers/thermal/thermal_of.c             | 54 ++++++++++----------------=
------
>  4 files changed, 25 insertions(+), 52 deletions(-)
> ---

This seems to have fallen through cracks.

Since all of the other 6.13 thermal changes have been integrated now,
I'm going to apply it and push next week unless you have concerns (in
which case please let me know).

Thanks!

