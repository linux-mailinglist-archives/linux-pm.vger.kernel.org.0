Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D66442DFAFE
	for <lists+linux-pm@lfdr.de>; Mon, 21 Dec 2020 11:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgLUKYY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Dec 2020 05:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgLUKYY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Dec 2020 05:24:24 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A4DC0613D6
        for <linux-pm@vger.kernel.org>; Mon, 21 Dec 2020 02:23:27 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id x22so9363064wmc.5
        for <linux-pm@vger.kernel.org>; Mon, 21 Dec 2020 02:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=0Vv2JbmBAjngC3pMRGSx1cPuMWHtt6tiXQKcY+Kelgw=;
        b=TLglt5AQvjZgZmdtnh/EyevOANMYsHXzcV/JGMkqoYtFMBAB4kYQ/FqDpNBbyLj48D
         YFxH24jMq6+64MYkJlnI6seNq47sfrXEI+5MhdutCJwZVSkm48VuGXPf1v1VNOJsdxlv
         iHthvFWR/wkc83nv1NiMeo2ZqObxpNRmpONRObi9+XxrKHLCmAkJ/phEI4ldc2oInkdo
         JUHNZwIT9NV6u4DS+PMxv7l3sd8oxRa1+zUHbr+0w0Qmq4tLYEe2EE/qyUhhFL/1NBbX
         Ay/tfe9NA/6jbseLr44dJdVM/Q9g5/cYjg5ReXw9X+mdgjkMjyKP0GxowkASkcKWE3Ii
         DiIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0Vv2JbmBAjngC3pMRGSx1cPuMWHtt6tiXQKcY+Kelgw=;
        b=DvMeNRuCORtHk7E5cDxdV5XLd1l6jhHoDGp6FyGndqIMoSlpeT0GXGJ9+iksPEixpM
         UGvvUL9lmqiEjqVLCFRRFB7AlB78zLi33v7q1PBSSc9rG8mYJkVSi/kvlbPPXUzQoBba
         QsnZYczV0IzEPEgJxuYOVOSjqqXwocdNW4ck1+CZqC0A9WM98cPhR+DLP/aZVbmcOEhe
         26TkudrZuSRmIZOoBYnLQ311H46qC4Bv7OFGvALmU6Do1sybQzC5wF2huFlEsyAatfxH
         Oh1gBEKkzvY8hKdPmeWwcd3m+hLGVCICLkOJROUFrn8q6AoVKqEsNpFWYvzj3mRJKoDA
         msRg==
X-Gm-Message-State: AOAM532FpruNrQ9zgCc5WOXEIwkuzCnhvUK1DgfyAzSG0jQ/aeL6pCYU
        V0f1PwE+1V0KqARnANn04iqyBNvU9zdjxnB/
X-Google-Smtp-Source: ABdhPJwV1UaD4rwmRRKU3eYSK2VySTMJPM9TCAXi8auRr8LxcUXt/74B0bP1dkXBIbzejKLTyh/UWg==
X-Received: by 2002:a1c:7d58:: with SMTP id y85mr5910588wmc.50.1608544757077;
        Mon, 21 Dec 2020 01:59:17 -0800 (PST)
Received: from dell ([91.110.221.144])
        by smtp.gmail.com with ESMTPSA id e16sm27858733wra.94.2020.12.21.01.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 01:59:16 -0800 (PST)
Date:   Mon, 21 Dec 2020 09:59:12 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Timon Baetz <timon.baetz@protonmail.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 2/6] power: supply: max8997_charger: Set CHARGER
 current limit
Message-ID: <20201221095912.GB53991@dell>
References: <20201202203516.43053-1-timon.baetz@protonmail.com>
 <20201221095001.595366-1-timon.baetz@protonmail.com>
 <20201221095001.595366-2-timon.baetz@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201221095001.595366-2-timon.baetz@protonmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 21 Dec 2020, Timon Baetz wrote:

> Register for extcon notification and set charging current depending on
> the detected cable type. Current values are taken from vendor kernel,
> where most charger types end up setting 650mA [0].
> 
> Also enable and disable the CHARGER regulator based on extcon events.
> 
> [0] https://github.com/krzk/linux-vendor-backup/blob/samsung/galaxy-s2-epic-4g-touch-sph-d710-exynos4210-dump/drivers/misc/max8997-muic.c#L1675-L1678
> 
> Signed-off-by: Timon Baetz <timon.baetz@protonmail.com>
> ---
>  drivers/mfd/max8997.c                  |  4 +-

Please split this out into a separate patch.

>  drivers/power/supply/max8997_charger.c | 94 ++++++++++++++++++++++++++
>  2 files changed, 96 insertions(+), 2 deletions(-)

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
