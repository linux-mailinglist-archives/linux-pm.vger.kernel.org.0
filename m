Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D71558D304
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2019 14:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfHNMY5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Aug 2019 08:24:57 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34085 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfHNMY5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Aug 2019 08:24:57 -0400
Received: by mail-wm1-f67.google.com with SMTP id e8so3224848wme.1;
        Wed, 14 Aug 2019 05:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qvNyqHPxqM17Hgwfx7q6qGcw30LiEL2kP6HeS6GNFVk=;
        b=TqzSu3r+JKdRwqwXMxKNEjktlIzFuuB5McOF228N/8JIw1F4JBLqzzcwneQE0o/cKd
         5wICaY7S25HNHsrXXue6xGmC/UviD83CsaZUd5bmETUNFATYt+hI3S4aWmBtSy/tfrti
         mLWrd/+elniaPpb8c2fO8Pacmccxbwnyj1zAT6xIhqUABTnFzaEyj5vUVry4ox1btx48
         tZ07Sy+405SyHtQ836cmoYhbMr11W7XVn2IN28dRLJXmcMHcsRklcyxI3km9skDhRESw
         7Kgu4fYoqdNCbWNoSslPkVJic79u2dD57kRyyGJg3Ru0/JWungE8E8+oing9AgfoHDIk
         lmpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qvNyqHPxqM17Hgwfx7q6qGcw30LiEL2kP6HeS6GNFVk=;
        b=XHXeIxApr10EKBelFAkbWrj3u2N2cqKW2+C7+yucFizkGQxx+fryj6ROmikB03k7YK
         t4Wsi3Um6IY1vXRY3gHg4hMF3op4e5Yy5kR9W6Qhx/MeaiYWHqnwakXlbekzeLKaDAED
         YSCs4e1eiPwo1oJxFZHaWXbZQEVgiVfwubQYewf9Jai8wQcAaQZsfk82eXgIcOVlqbA1
         uzzV8QFz2kWuZXKS5PqXGSfuSPKTCy8pPH/Sfw+J2FyBpABl4siefU38Q1qCFS6IKFqh
         pXxhU8zEutNWk0VNGHhfXIXuUoUj9OM2N+96ZxIQkkoD9+yCaRPwMJFgYoehM4T5WzWM
         Wb5Q==
X-Gm-Message-State: APjAAAURbE7sdhe+QE+skrjkz/2z7nXCEFNR8J6wbq1CmGpxt59fOsUU
        RrZqCUzWR/yyuLgeaXcK/44=
X-Google-Smtp-Source: APXvYqzkK3WQL9KYB1TyBBzuH6MQ5nCwZyYjF7EGNKE+AniVd85uZ9BfFF8sWaTFPPOyfIqxvfmzrg==
X-Received: by 2002:a1c:e90d:: with SMTP id q13mr8649524wmc.89.1565785495404;
        Wed, 14 Aug 2019 05:24:55 -0700 (PDT)
Received: from [192.168.1.169] ([87.201.30.26])
        by smtp.gmail.com with ESMTPSA id l62sm4544230wml.13.2019.08.14.05.24.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Aug 2019 05:24:54 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v3 0/6] Add support of New Amlogic temperature sensor for
 G12 SoCs
From:   Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <20190806130506.8753-1-glaroque@baylibre.com>
Date:   Wed, 14 Aug 2019 16:24:51 +0400
Cc:     daniel.lezcano@linaro.org, khilman@baylibre.com,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <357FACA6-6EAC-4E9D-B6F7-4D8D0D59A20A@gmail.com>
References: <20190806130506.8753-1-glaroque@baylibre.com>
To:     Guillaume La Roque <glaroque@baylibre.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 6 Aug 2019, at 5:05 pm, Guillaume La Roque <glaroque@baylibre.com> =
wrote:
>=20
> This patchs series add support of New Amlogic temperature sensor and =
minimal
> thermal zone for SEI510 and ODROID-N2 boards.
>=20
> First implementation was doing on IIO[1] but after comments i move on =
thermal framework.
> Formulas and calibration values come from amlogic.
>=20
> Changes since v2:
>  - fix yaml documention=20
>  - remove unneeded status variable for temperature-sensor node
>  - rework driver after Martin review
>  - add some information in commit message
>=20
> Changes since v1:
>  - fix enum vs const in documentation
>  - fix error with thermal-sensor-cells value set to 1 instead of 0
>  - add some dependencies needed to add cooling-maps
>=20
> Dependencies :
> - patch 3,4 & 5: depends on Neil's patch and series :
>              - missing dwc2 phy-names[2]
>              - patchsets to add DVFS on G12a[3] which have deps on [4] =
and [5]
>=20
> [1] =
https://lore.kernel.org/linux-amlogic/20190604144714.2009-1-glaroque@bayli=
bre.com/
> [2] =
https://lore.kernel.org/linux-amlogic/20190625123647.26117-1-narmstrong@ba=
ylibre.com/
> [3] =
https://lore.kernel.org/linux-amlogic/20190729132622.7566-1-narmstrong@bay=
libre.com/
> [4] =
https://lore.kernel.org/linux-amlogic/20190731084019.8451-5-narmstrong@bay=
libre.com/
> [5] =
https://lore.kernel.org/linux-amlogic/20190729132622.7566-3-narmstrong@bay=
libre.com/
>=20
> Guillaume La Roque (6):
>  dt-bindings: thermal: Add DT bindings documentation for Amlogic
>    Thermal
>  thermal: amlogic: Add thermal driver to support G12 SoCs
>  arm64: dts: amlogic: g12: add temperature sensor
>  arm64: dts: meson: sei510: Add minimal thermal zone
>  arm64: dts: amlogic: odroid-n2: add minimal thermal zone
>  MAINTAINERS: add entry for Amlogic Thermal driver

Tested-by: Christian Hewitt <christianshewitt@gmail.com>

I=E2=80=99ve tested this series with Odroid N2 and Khadas VIM3, X96-Max. =
Patches to add
support for VIM3/X96-max will be submitted once the driver is merged.

VIM3:~ # dmesg | grep thermal
[    0.046375] thermal_sys: Registered thermal governor 'step_wise'

VIM3:~ # cat /sys/devices/virtual/thermal/thermal_zone0/temp
51300

VIM3:~ # cat /sys/devices/virtual/thermal/thermal_zone1/temp
52800

Christian=
