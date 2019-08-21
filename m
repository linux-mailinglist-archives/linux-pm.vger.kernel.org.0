Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9C8A987F8
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2019 01:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbfHUXji (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Aug 2019 19:39:38 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41745 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbfHUXji (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Aug 2019 19:39:38 -0400
Received: by mail-pf1-f196.google.com with SMTP id 196so2513652pfz.8
        for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2019 16:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=RoJLziPgJY9mLs+fRu2lKqTyEaUKSYiiOnVn7t9lzGo=;
        b=znM/oClHkBR6pN7RG6wDMkQnx6pbsRIaoNYQc2ceYPiPEl7hq69Qo14MyokFBCw2Xe
         FQ20sImAG9QaU+NbtIppKgexVWzDXK7u3I2TJkT7ch4fu0lhJyBfxEQnkTfHBDvjMSBK
         SBjbbFjeIO1/Uug6SqmyTdB2c9tIYDcPZZc5y1rgtbC2kpInFxWKmChK9bLwT7GvdFbD
         zXk4Lw6gFtHp+EJz64710+rpjuMARq6Zx3BHACB26ZRCfJoRZD+X+W7tc6iRJTi2dOXi
         K6vTKICEJmVxIQEBRpUEaBsT6/s5TODqCjYQ7Ba0Bc8KTkwktqpTmNnvQe18Qg4JtDPr
         HDmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=RoJLziPgJY9mLs+fRu2lKqTyEaUKSYiiOnVn7t9lzGo=;
        b=crQy6WWD9uAhe+TEdRmAKzvmd9I1nh0DMUU6FG8o8Slja4PNOEXqDkLLpXACYNhkYi
         Ax23NuXrscUrRmWyRAyOtDKE3ZeO+W9vbZOgdEVl3PitGiYw/FrMwlhquxsBk5mYQv4I
         DlmbY/uM2Cb5X2TqN8FGxe3wSYvC/y8CMjb1uHqld6VpjkK8Jt35tCCIVdcjKhPcAjUH
         hsZXoUqE+qbFbc2p1VjXlknzW/SjtC1wbP4OSdwBMyYTZMxor8LQrHbYHz/z+0MIosJj
         arrUfiWZa5k+alGPXcdg26inSjmBEXuqVViTSvlHKKqyCt1bhn2fMhrLX6WsKQ6Cq6hT
         ZzjQ==
X-Gm-Message-State: APjAAAUD/cuAwGVCZ1hIGIrLN7EDny0BkLkcBZmUEJs2kwWCgX2+YSjg
        wVYZPgtba2L/AbrIF5vspgA94Q==
X-Google-Smtp-Source: APXvYqxbUoVvUvpMfuvIMtOftEIUIVFxHRXscpTOlg7Xd4x9nP3Em83MNj+d7QIroKxxfU76f9qS/w==
X-Received: by 2002:a17:90a:d793:: with SMTP id z19mr2480702pju.36.1566430777357;
        Wed, 21 Aug 2019 16:39:37 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id s5sm24549074pfm.97.2019.08.21.16.39.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Aug 2019 16:39:36 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Guillaume La Roque <glaroque@baylibre.com>, rui.zhang@intel.com,
        edubezval@gmail.com, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH v4 0/6] Add support of New Amlogic temperature sensor for G12 SoCs
In-Reply-To: <20190821222421.30242-1-glaroque@baylibre.com>
References: <20190821222421.30242-1-glaroque@baylibre.com>
Date:   Wed, 21 Aug 2019 16:39:36 -0700
Message-ID: <7hk1b65brb.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Guillaume La Roque <glaroque@baylibre.com> writes:

> This patchs series add support of New Amlogic temperature sensor and minimal
> thermal zone for SEI510 and ODROID-N2 boards.
>
> First implementation was doing on IIO[1] but after comments i move on thermal framework.
> Formulas and calibration values come from amlogic.
>
> Changes since v3:
>   - Add cooling map and trip point for hot type
>   - move compatible on g12a instead of g12 to be aligned with others
>   - add all reviewer, sorry for this mistake
>
> Changes since v2:
>   - fix yaml documention
>   - remove unneeded status variable for temperature-sensor node
>   - rework driver after Martin review
>   - add some information in commit message
>
> Changes since v1:
>   - fix enum vs const in documentation
>   - fix error with thermal-sensor-cells value set to 1 instead of 0
>   - add some dependencies needed to add cooling-maps
>
> Dependencies :
> - patch 3,4 & 5: depends on Neil's patch and series :
>               - missing dwc2 phy-names[2]
>               - patchsets to add DVFS on G12a[3] which have deps on [4] and [5]
>
> [1] https://lore.kernel.org/linux-amlogic/20190604144714.2009-1-glaroque@baylibre.com/
> [2] https://lore.kernel.org/linux-amlogic/20190625123647.26117-1-narmstrong@baylibre.com/
> [3] https://lore.kernel.org/linux-amlogic/20190729132622.7566-1-narmstrong@baylibre.com/
> [4] https://lore.kernel.org/linux-amlogic/20190731084019.8451-5-narmstrong@baylibre.com/
> [5] https://lore.kernel.org/linux-amlogic/20190729132622.7566-3-narmstrong@baylibre.com/
>
>
> Tested-by: Christian Hewitt <christianshewitt@gmail.com>
> Tested-by: Kevin Hilman <khilman@baylibre.com>

nit: you should put these on the individual patches, since the cover
letter does not get applied to any tree, any tags here get lost.

Kevin
