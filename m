Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43C3997B39
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2019 15:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbfHUNqv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Aug 2019 09:46:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:33836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728616AbfHUNqv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 21 Aug 2019 09:46:51 -0400
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FCBA2339F;
        Wed, 21 Aug 2019 13:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566395210;
        bh=1SBGubWHevGTaPku2q5p2VFb1E6YUKyo3XqPCp/g0/I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KKNovrSCCy+qxBBg+LQF1RxSdKIeUAor2DyyUj5ECkqeYKhur3RwCiqyuCLcvmilZ
         AJWSreR6LpOWFF96w3iUmUUzcBmp74dGMM4P+pm0JvsyO8+iGZoEKDuOmw4lWp0S4o
         7zyZ3AOden/ijNJ8D6jHxP+m5MlXrLZ0MMBG3090=
Received: by mail-qt1-f170.google.com with SMTP id t12so3043921qtp.9;
        Wed, 21 Aug 2019 06:46:50 -0700 (PDT)
X-Gm-Message-State: APjAAAXumeO3vEajpc68RHMqYcIXPZo6g8WEp/0uiwom4mSEBJy6qGkN
        yVqcqNzEsi8NR+5tqJ4aVCh8LFelOz5HLE2/LA==
X-Google-Smtp-Source: APXvYqzVcAdSEaO2BocJ4gK6VMRiGeLEnjs3XBBSPg8GhG/x28s2b9/g6MrsMfZlURkEkfCeqd6IZ4qdq3h8AExDMZE=
X-Received: by 2002:aed:24f4:: with SMTP id u49mr31852907qtc.110.1566395209619;
 Wed, 21 Aug 2019 06:46:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190821114121.10430-1-narmstrong@baylibre.com> <20190821114121.10430-2-narmstrong@baylibre.com>
In-Reply-To: <20190821114121.10430-2-narmstrong@baylibre.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 21 Aug 2019 08:46:38 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLy9etZtUYTJdvBRCRGuxPN_eXJQT8_xwdST5TNparJug@mail.gmail.com>
Message-ID: <CAL_JsqLy9etZtUYTJdvBRCRGuxPN_eXJQT8_xwdST5TNparJug@mail.gmail.com>
Subject: Re: [PATCH 1/5] dt-bindings: power: add Amlogic Everything-Else power
 domains bindings
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-amlogic@lists.infradead.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Aug 21, 2019 at 6:41 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Add the bindings for the Amlogic Everything-Else power domains,
> controlling the Everything-Else peripherals power domains.
>
> The bindings targets the Amlogic G12A and SM1 compatible SoCs,
> support for earlier SoCs will be added later.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../bindings/power/amlogic,meson-ee-pwrc.yaml | 93 +++++++++++++++++++
>  include/dt-bindings/power/meson-g12a-power.h  | 13 +++
>  include/dt-bindings/power/meson-sm1-power.h   | 18 ++++
>  3 files changed, 124 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml
>  create mode 100644 include/dt-bindings/power/meson-g12a-power.h
>  create mode 100644 include/dt-bindings/power/meson-sm1-power.h

Reviewed-by: Rob Herring <robh@kernel.org>
