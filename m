Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1E173723BC
	for <lists+linux-pm@lfdr.de>; Tue,  4 May 2021 01:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbhECX6M (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 May 2021 19:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbhECX6M (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 May 2021 19:58:12 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF8BC061574
        for <linux-pm@vger.kernel.org>; Mon,  3 May 2021 16:57:18 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id p6-20020a05600c3586b029014131bbe5c7so241151wmq.3
        for <linux-pm@vger.kernel.org>; Mon, 03 May 2021 16:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=RTrhwe5FlqMxAXLpGz6FP3pMNfP7DO0JlS/VtPEMG74=;
        b=OY1GqMrdXwXrnAuXBTPr8YH2MPvErnn0sAltbHEyap7pDnJekaXQOqHbGBdfm0RmTC
         6lrbrm1e8bB27RkTSrQwqflaQuijdIRWiTrYNSXGkdM5JCYyqZ4EcvpSTZlZQW/daRSE
         kvncir60eNNRthz++TvIxP8bZjVdylGQlR8cDFxgIfe/kgIjzRjgNUZNiZW6ZecvgUAB
         Q9fDdzkrWXVqblYfvjxyvNwuAiAWK/VqmVU2mInJer6EsufZ3Zj5yIMFZeMon7DiZvPh
         smhmClp5QXg53UJHwbbucyPhi5mj2VxExty0pJqxLAXoKTsjfnlHbBr+fvnRKTg6RJAk
         k20w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=RTrhwe5FlqMxAXLpGz6FP3pMNfP7DO0JlS/VtPEMG74=;
        b=SZ+LjCWEEAxwjgh6Ig8DhVrCHKLh3ko3unsVUp+lIN/SaAMxTY+FKoqeDcMKbaLaKM
         t+02FnkT19jJ5IFPOHG39BUPzdp6nj2Dt83LrkL4YwwFPimtufSqCwi1ajWTQ5+0QPWl
         Aaglvpih2AaAowzrfTLaW5pw8a1QDsyIHTTHWbiDkzzl/PKZ6H+U5E9xC7Jxmtq+m7NM
         HKQjAbZcOz8EUL9FuWs/yx6AQYJ3kODyq57xmy2h4BwNiQ1Kl/tFAZSxO0l4wk4lH2/1
         vLfg6n+UUxkdEh9FvnKEypCXIEYaS/7QgdpaFthqpnJlZUZHXPAP3Lr5XMcLx4Qv+nmf
         lHIA==
X-Gm-Message-State: AOAM532UXrIKjKPw3wZ0c2A4oNhqLysjMzlI2Soj3nZX7Scq+8Xw/llh
        ym0NYZUBk3NwvRC2QzrfofZ/QA==
X-Google-Smtp-Source: ABdhPJwOb2mcyPA4UP5yR/4VuPO7Gv/UDWC/a9zIVAp438kCOwtM4TxMYEhupEG0lyY2Us6CEfsRFg==
X-Received: by 2002:a05:600c:3388:: with SMTP id o8mr1025054wmp.101.1620086235839;
        Mon, 03 May 2021 16:57:15 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id l14sm14048582wrv.94.2021.05.03.16.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 16:57:15 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        narmstrong@baylibre.com, linux-amlogic@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH RFC] soc: amlogic: meson-ee-pwrc: Drop the .shutdown
 callback from the driver
In-Reply-To: <20210429203723.1177082-1-martin.blumenstingl@googlemail.com>
References: <20210429203723.1177082-1-martin.blumenstingl@googlemail.com>
Date:   Mon, 03 May 2021 16:57:12 -0700
Message-ID: <7h4kfjpe07.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> Stefan reports that rebooting his ODROID-N2+ (using a G12B SoC) results
> in the board hanging. His kernel config uses:
>   CONFIG_MESON_EE_PM_DOMAINS=y
>   CONFIG_DRM_MESON=m
>
> He reports that his kernel config results in the DRM driver's .shutdown
> callback to be executed after the power domain driver's .shutdown
> callback. That's problematic because meson_ee_pwrc_shutdown disables the
> clock which are used by the VPU IP. This causes the board to hang.

I didn't dig deeply on this yet because this smells very much like an
issue Art reported[1] and fixed.

What kernel version are you using, and does it contain
commit fa0c16caf3d7 (drm: meson_drv add shutdown function)

Kevin

[1] https://lore.kernel.org/dri-devel/20210302042202.3728113-1-art@khadas.com/

