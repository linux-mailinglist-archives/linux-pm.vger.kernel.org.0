Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C798149858F
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jan 2022 17:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244033AbiAXQ6y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Jan 2022 11:58:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241183AbiAXQ6y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Jan 2022 11:58:54 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E8DC06173D
        for <linux-pm@vger.kernel.org>; Mon, 24 Jan 2022 08:58:54 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id w190so10351821pfw.7
        for <linux-pm@vger.kernel.org>; Mon, 24 Jan 2022 08:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=QpweiVyIfmb5hj1sObeMoupM7nExebWp4y/78WjEl2o=;
        b=KDOcJo5VhtwHDYkRvxFLe2+8bdiG3/Uk+A59ZObbMymNhlfS5n75/xTEDHaC4pb2RW
         oJRWHcQb3z+pmIvLIXCmTMK1ddA7KKZGOJ8L/2qRnorzLU4l0QG0uJPDaFE1vB/Aj8N3
         Fo/+tT4g2b/ftcx6RppZOyB5biFw+pEfpxA6eg5rV1xrKK4APlmhwmrTlto+roVogi6h
         L+URhA9G81VATPDvfsLgNgLgKe93cjhhr9j7IOi3qzVgTgCkh26o1+z0ZVAyJwtbUuQL
         PPHgqFOgqaH3Pk+wjxq8ZQLekAjvcQEpzD61nodAygpv5M5Y0Tqemg7HWzKABeJliIvz
         lhOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=QpweiVyIfmb5hj1sObeMoupM7nExebWp4y/78WjEl2o=;
        b=oEC/MLZc2CmUUcSKF9SZ+qN9PWbf6MFiOF/NoNQp9cyd1fIwmfZMS0w1P66rf4Qhzq
         HeHCq+hgJRZ6UAIpR/o5IpuVVboiIGOJ14xVVzI6E8t1VT0p7K1BCRUaitTpzXwFFwyp
         /X/8nZBZn0Z8KvPpL0iN/ffDY0D81A2oOaXXMpvCPlHHjMqxDfpuxRJFUJf37swaGr7P
         eor+yZtM1k2967mAaUPjbZssJ7uTRWTUY5ejyJaWc6sBQz08xlsqgP7jFiuR1FsLjMP9
         bXnPYz2cY9xPThzjRCrcUPV2Y7dWgJ3Pe3Xi+4zeEbsOnQ62K4iVy4E6FpHpRvo3sUA0
         C09Q==
X-Gm-Message-State: AOAM533IwUExnOgX/NKrj76DYj9yXCqXMDDlp9UeQQFfwbv0Nw4FXCBx
        iqylqcswBQ/6bRLlqoqv6BRr6g==
X-Google-Smtp-Source: ABdhPJzFFs4pNrvCJjliYLl0Xd2gUQ4IZdd9l1RcnT7MfpuqAkrcqgx4Kuk2LSLF5GEFQtg9h6gySw==
X-Received: by 2002:a63:3182:: with SMTP id x124mr12248537pgx.586.1643043533673;
        Mon, 24 Jan 2022 08:58:53 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id v4sm16849486pfu.202.2022.01.24.08.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 08:58:53 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     daniel.lezcano@linaro.org, amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.tseng@mediatek.com, mka@chromium.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Alexandre Bailon <abailon@baylibre.com>, rafael@kernel.org,
        rui.zhang@intel.com
Subject: Re: [PATCH v4 RESEND 0/2] Add a generic virtual thermal sensor
In-Reply-To: <20220111103346.2660639-1-abailon@baylibre.com>
References: <20220111103346.2660639-1-abailon@baylibre.com>
Date:   Mon, 24 Jan 2022 08:58:52 -0800
Message-ID: <7hilu9xe7n.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Daniel, Amit,

Alexandre Bailon <abailon@baylibre.com> writes:

> This series add a virtual thermal sensor.
> It could be used to get a temperature using some thermal sensors.
> Currently, the supported operations are max, min and avg.
> The virtual sensor could be easily extended to support others operations.
>
> Changes in v2:
> - Fix some warnings / errors reported by kernel test robot
> - rename some struct and functions with a more accurate name
> - update the dt bindings: rename type attribute to aggregation-function
> - factorize a little bit the aggregation functions
> Changes in v3:
> - Aggregate thermal zone instead of thermal sensors
> - Use try_get_module / put_module to prevent thermal providers to be removed
> - Update the bindings, to be more accurate
> Changes in v4:
> - Fix two warnings reported by kernel test robot

Any more feedback on this series?

Thanks,

Kevin
