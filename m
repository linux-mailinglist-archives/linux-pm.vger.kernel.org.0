Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65984126EA7
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 21:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfLSUVb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 15:21:31 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42182 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbfLSUVb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2019 15:21:31 -0500
Received: by mail-ed1-f67.google.com with SMTP id e10so6139850edv.9;
        Thu, 19 Dec 2019 12:21:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GR1PmJOvhGpPpzVfO8kgGmz6p0Ok+BYanL+ypVYCuIo=;
        b=VHE0h/z8QUohGr0nxIUjLPnxbiZBiczVgQ7CLypXARylblDBDbT56ycS7qfgca7I2N
         auOka92SQcKGx0XGKWzvtegmnm0vqflHXidkL+V8oPep3qo5Grnyqv/1g/icuFwiiO6c
         RJH+4xtU2s5sLUKLCUrdLBsfGAKsSW59VXA/2OkFTaOor8o+X90GL3Ix+FzNH6jaDE8H
         miubaUMCV1uiYOvebxGn27psdfNRpBPcczaxDyjmK0oKKzRZWgumqyfPe3p/isfF/o1I
         KGQFQKZT5vameJ9Yspbsgl2xIquC7V6yp4w9/rFfxGDV7AqNFQZNllO1KpI8GS6Fb8o0
         2SCw==
X-Gm-Message-State: APjAAAXUHxPK/5zZeBWP0+9UKF0ZUvso5Q2/sNgz7CwEEl1HSGV0S8wL
        qtvJru+lYvsJnzzQ3CRwSv8=
X-Google-Smtp-Source: APXvYqwZwMHJTRig+SXE0kz2DegMMU7qPuSgopAX7Pwr9Y8S6Q8VfZ+NYpDzWXBIncow4tB/gDtDLA==
X-Received: by 2002:a17:906:4a12:: with SMTP id w18mr11475789eju.321.1576786889413;
        Thu, 19 Dec 2019 12:21:29 -0800 (PST)
Received: from kozik-lap ([194.230.155.234])
        by smtp.googlemail.com with ESMTPSA id u25sm722974ejb.53.2019.12.19.12.21.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Dec 2019 12:21:28 -0800 (PST)
Date:   Thu, 19 Dec 2019 21:21:26 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, heiko@sntech.de,
        leonard.crestez@nxp.com, lukasz.luba@arm.com, a.swigon@samsung.com,
        m.szyprowski@samsung.com, kgene@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 8/9] ARM: dts: exynos: Replace deprecated property for
 Exynos bus and DMC
Message-ID: <20191219202126.GB21576@kozik-lap>
References: <20191217055738.28445-1-cw00.choi@samsung.com>
 <CGME20191217055106epcas1p4c0f65bec74e53b38d95e984e146bf8b6@epcas1p4.samsung.com>
 <20191217055738.28445-9-cw00.choi@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191217055738.28445-9-cw00.choi@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Dec 17, 2019 at 02:57:37PM +0900, Chanwoo Choi wrote:
> Replace the property related to devfreq and devfreq-event device
> to remove the deprecated property name.
> - Replace 'devfreq' with 'exynos,parent-bus' property
>   for getting the parent devfreq device of exynos-bus.
> - Replace 'devfreq-events' with 'exynos,ppmu-device' property
>   for getting the devfreq-event device to monitor bus utilization.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  arch/arm/boot/dts/exynos3250-monk.dts         |  2 +-
>  arch/arm/boot/dts/exynos3250-rinato.dts       | 18 +++++-----
>  .../boot/dts/exynos4412-itop-scp-core.dtsi    | 16 ++++-----
>  arch/arm/boot/dts/exynos4412-midas.dtsi       | 18 +++++-----
>  .../boot/dts/exynos4412-odroid-common.dtsi    | 18 +++++-----
>  arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 34 +++++++++----------
>  6 files changed, 53 insertions(+), 53 deletions(-)
> 

It will have to wait till next release, after driver changes get
accepted.

Best regards,
Krzysztof
