Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2554158392
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2020 20:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbgBJTaL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Feb 2020 14:30:11 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42505 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbgBJTaL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Feb 2020 14:30:11 -0500
Received: by mail-ed1-f68.google.com with SMTP id e10so1700091edv.9;
        Mon, 10 Feb 2020 11:30:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zdlFZQe/OnqqWy/rZ1pDr5RvrV8lpGf4yVtCyVl/HnE=;
        b=szNJKZZIdZqAhXUo7BmsnZNmPZlcO3U1Xo+WUeQIfrs+Suo3uqMqHBWTYzRX6w5RkA
         tXEDtSC9AbCmi8I0CE5EP2uyFIHac92DHIFT8+Vl2MRxkPSsH6LEblRIL1rFV1G5xV88
         WlCA0MrPIv2Wo1oDQ9e4BX8cV1d4Udwblb5IBkVg77b1T8JUpjqv6IyOsHOG5g+C8JIu
         +XE6XY/O3Rb4k3nav0yoqHthOtjsN2mzhQq86YkaGuySBCzQrJQcaEFeYKlgQWtCVEPe
         xs2nF9yiEwiOLT8jJaquQi03UiDcb8OvNHPr7MpAOOifAN6dQmM9vS5z4zc2+aMZQ6pq
         gb3Q==
X-Gm-Message-State: APjAAAXJw2bZgm19tsN77s0OmSyC7zwM5YPXxb0Oqwxd6aQpr8HbkWwk
        ROFBOWOqCXd15f0CqiiRwnaIknYDpKM=
X-Google-Smtp-Source: APXvYqzShuEGhyo0aJa4PgQ87LvbUidIAfGr/qyPwdm5rUY+mEGPJRNk9PRDX5vEy76WXm4YM9go/w==
X-Received: by 2002:a50:84ab:: with SMTP id 40mr2641443edq.14.1581363009556;
        Mon, 10 Feb 2020 11:30:09 -0800 (PST)
Received: from kozik-lap ([194.230.155.125])
        by smtp.googlemail.com with ESMTPSA id m5sm79440ede.10.2020.02.10.11.30.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Feb 2020 11:30:08 -0800 (PST)
Date:   Mon, 10 Feb 2020 20:30:06 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] soc: samsung: chipid: Fix return value on non-Exynos
 platforms
Message-ID: <20200210193006.GC27658@kozik-lap>
References: <CGME20200207070701eucas1p2d6422d731f031ee66737683b54085ac7@eucas1p2.samsung.com>
 <20200207070552.26986-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200207070552.26986-1-m.szyprowski@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Feb 07, 2020 at 08:05:52AM +0100, Marek Szyprowski wrote:
> Correct the probe return value to -ENODEV on non-Exynos platforms.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/soc/samsung/exynos-chipid.c | 2 +-

Thanks, applied (with Cc-stable and Fixes tags).

Best regards,
Krzysztof

