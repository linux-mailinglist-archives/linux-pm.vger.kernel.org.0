Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C442F2A6443
	for <lists+linux-pm@lfdr.de>; Wed,  4 Nov 2020 13:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729772AbgKDM10 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 4 Nov 2020 07:27:26 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36774 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbgKDM1Z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2020 07:27:25 -0500
Received: by mail-wr1-f67.google.com with SMTP id x7so21862357wrl.3;
        Wed, 04 Nov 2020 04:27:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=uinOFoWWChkPcAueiWNTIshof8R8Mb7vQCYYpe5kHl0=;
        b=Lizi1hWslTzDY6sVSwAJPwW7Luo6VJlqs+Ow5i5Sgo9qQCW5SFKa333KF8Ss7o5LnZ
         oq/0pNkHVQ92XAtj1N8ddcO/E/8Z5MfBns7AR81M93Zg67vemmr5wEASOLSSsAMqBCMx
         2UyqcyAaOQxTLRFA6oeYFAhDAjumUm5sFCqqor1osztFjkGkI3gCAU9a1cCOiDdj21oz
         IA7MVhNwEprhSbFlBoVX0J9V+eg4RcoZTpyuej9Ss0GxTbEnSDNeKvBD3iHtSQhTBf7c
         ne7aKCMSvpmpAPKXO8BVA4t8jFYnlCikbW4oInzBjvqNzhKxzIYC1Wg44g4ScacJEaFX
         IfHQ==
X-Gm-Message-State: AOAM530+AxWMjvMxk5WUjmifFJIqBsvWfvGZD6UhtR9PaXG5xpZtHedX
        5SkHuSYXfyHNm+IZCnwNmc0rb6A4ksk=
X-Google-Smtp-Source: ABdhPJwjAFrO9uAL9rPXfY/qcv0uliGPwbkLgq1LCBJhudXfsT1rau74Fov3WvKgPByU94BxgJ/pXw==
X-Received: by 2002:adf:f245:: with SMTP id b5mr4513573wrp.389.1604492842233;
        Wed, 04 Nov 2020 04:27:22 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id c9sm2269890wrp.65.2020.11.04.04.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 04:27:21 -0800 (PST)
Date:   Wed, 4 Nov 2020 13:27:19 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     georgi.djakov@linaro.org, cw00.choi@samsung.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        a.swigon@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 3/7] MAINTAINERS: Add entry for Samsung interconnect
 drivers
Message-ID: <20201104122719.GB10157@kozik-lap>
References: <20201104103657.18007-1-s.nawrocki@samsung.com>
 <CGME20201104103722eucas1p1db939995e60d0bf2cd581070c14379f5@eucas1p1.samsung.com>
 <20201104103657.18007-4-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20201104103657.18007-4-s.nawrocki@samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 04, 2020 at 11:36:53AM +0100, Sylwester Nawrocki wrote:
> Add maintainers entry for the Samsung interconnect drivers, this currently
> includes Exynos SoC generic interconnect driver.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> Changes since v7:
>  - new patch.
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e73636b..4bbafef 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9156,6 +9156,13 @@ F:	include/dt-bindings/interconnect/
>  F:	include/linux/interconnect-provider.h
>  F:	include/linux/interconnect.h
>  
> +SAMSUNG INTERCONNECT DRIVERS

Does not look like ordered alphabetically.

> +M:	Sylwester Nawrocki <s.nawrocki@samsung.com>
> +M:	Artur Swigoń <a.swigon@samsung.com>
> +L:	linux-pm@vger.kernel.org

Also:
L: linux-samsung-soc@vger.kernel.org

> +S:	Supported
> +F:	drivers/interconnect/samsung

Add trailing /.

Best regards,
Krzysztof
