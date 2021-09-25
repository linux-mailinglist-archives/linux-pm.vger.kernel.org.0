Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1309D4181EC
	for <lists+linux-pm@lfdr.de>; Sat, 25 Sep 2021 14:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237995AbhIYMd2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 25 Sep 2021 08:33:28 -0400
Received: from comms.puri.sm ([159.203.221.185]:53084 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237543AbhIYMd2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 25 Sep 2021 08:33:28 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 5E093E0162;
        Sat, 25 Sep 2021 05:31:53 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JTIO9IUaBvFf; Sat, 25 Sep 2021 05:31:50 -0700 (PDT)
From:   Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Iskren Chernev <iskren.chernev@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matheus Castello <matheus@castello.eng.br>,
        Sebastian Reichel <sre@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@puri.sm
Subject: Re: [PATCH 1/2] MAINTAINERS: power: supply: max17042: add entry with reviewers
Date:   Sat, 25 Sep 2021 14:31:44 +0200
Message-ID: <4803957.ieAp1BVO2D@pliszka>
In-Reply-To: <20210924115619.52927-1-krzysztof.kozlowski@canonical.com>
References: <20210924115619.52927-1-krzysztof.kozlowski@canonical.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On pi=C4=85tek, 24 wrze=C5=9Bnia 2021 13:56:18 CEST Krzysztof Kozlowski wro=
te:
> The Maxim max17042 fuel gauge driver supports several devices used on
> multiple different boards - both devicetree and ACPI based.  The driver
> is incomplete and has few known issues.  Fixing these might break other
> platforms so mention recent contributors who can provide feedback.  This
> way most of interested parties might help reviewing the patches.
>=20
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  MAINTAINERS | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 329d3a0a9fdb..da9d5383af04 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11429,6 +11429,16 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/proximity/
maxbotix,mb1232.yaml
>  F:	drivers/iio/proximity/mb1232.c
>=20
> +MAXIM MAX17042 FAMILY FUEL GAUGE DRIVERS
> +R:	Hans de Goede <hdegoede@redhat.com>
> +R:	Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> +R:	Marek Szyprowski <m.szyprowski@samsung.com>
> +R:	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>

I think it may be worth adding:

+R:	Purism Kernel Team <kernel@puri.sm>

In any case:

Reviewed-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>

Cheers,
Sebastian

> +L:	linux-pm@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
> +F:	drivers/power/supply/max17042_battery.c
> +
>  MAXIM MAX77650 PMIC MFD DRIVER
>  M:	Bartosz Golaszewski <bgolaszewski@baylibre.com>
>  L:	linux-kernel@vger.kernel.org


