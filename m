Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0B932B0B2
	for <lists+linux-pm@lfdr.de>; Wed,  3 Mar 2021 04:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235246AbhCCDkt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Mar 2021 22:40:49 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:38071 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378001AbhCBIxz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Mar 2021 03:53:55 -0500
Received: by mail-wm1-f54.google.com with SMTP id n4so1797162wmq.3;
        Tue, 02 Mar 2021 00:53:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QnekdLhk3AFB+nJq9zqt7UdfG6HkqQEO7yDItxf4rqE=;
        b=RxHxt7JH6at2T6f0WpUH8SC4sgeFXFn3MqkTAz3VNaP8rN4VPb2jcKPYj2bMHGQMiz
         Uva+rDHVNsKwtwdoa3MaTOOvOf1oUPWwOXXsNxyOEw5iHTqp60IBLF+eNNgjdh1AHCYo
         SKSzrg4NIPspjchy6KsTd6nR/E5nGE8tjq3zwra4oqTRItzAgqamWabH/ItmDl/3qwEZ
         FK5UqU5OxlePEOJSljxprmO0Cj5fzCXjkSufGJq7jyhCVeCP/RjkO+niMKufycuA8pHd
         d4yPpll1igxIShwN37i0T31uy+rZyALxc4CIaw0r5bSwQBCF2rUotiuRyyCLkLNrVArr
         /yEw==
X-Gm-Message-State: AOAM5300WRLwgPPIloDYhJppvOSJs/xiImsjnlW60ZoyjGLLwXc0cUTS
        JtMuY43XO4kJXvL9Ezn3fz0=
X-Google-Smtp-Source: ABdhPJyH0Kyadrx7w80V1cPKEKbNj7Qxh6MtS/xT5R2Cbx/ULBxm0HgJZUE5NdoWU3yky1HYte32SA==
X-Received: by 2002:a7b:cd81:: with SMTP id y1mr2913609wmj.51.1614675174463;
        Tue, 02 Mar 2021 00:52:54 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id h10sm26256201wrp.22.2021.03.02.00.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 00:52:53 -0800 (PST)
Date:   Tue, 2 Mar 2021 09:52:52 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Timon Baetz <timon.baetz@protonmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/3] ARM: dts: exynos: Add charger supply for I9100
Message-ID: <20210302085252.ipcqocxg3u6q3dtd@kozik-lap>
References: <20210130172747.2022977-1-timon.baetz@protonmail.com>
 <20210130172747.2022977-3-timon.baetz@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210130172747.2022977-3-timon.baetz@protonmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Jan 30, 2021 at 05:29:31PM +0000, Timon Baetz wrote:
> The regulator is used for charging control by max8997_charger driver.
> 
> Signed-off-by: Timon Baetz <timon.baetz@protonmail.com>
> ---
>  arch/arm/boot/dts/exynos4210-i9100.dts | 2 ++
>  1 file changed, 2 insertions(+)

Thanks, applied.

Best regards,
Krzysztof

