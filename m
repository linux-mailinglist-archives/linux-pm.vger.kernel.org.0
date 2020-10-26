Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB1CF299788
	for <lists+linux-pm@lfdr.de>; Mon, 26 Oct 2020 20:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbgJZT5l (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Oct 2020 15:57:41 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:42293 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728761AbgJZT5l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Oct 2020 15:57:41 -0400
Received: by mail-ej1-f67.google.com with SMTP id h24so15476489ejg.9;
        Mon, 26 Oct 2020 12:57:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gMz6Q9gkRlBtUOxEOTyZX0KD7N64Y6/Z7wDoDmAI3Oo=;
        b=FkIHz1W+wXPi/QN8w0inaZbHTaRvNyMF5tLV0vaBicbWrg1Dh75XMJDwLi+pTABsxf
         Il4j/I3cdwEw4keHphpZ6nEZBC4HN1XFLhxxrOFdsncgUmZGdsqRruhtyJMl6mNFl49R
         jFl2t847hteTp2LiDC7p6fx9fc2nbI0mS5mSHemNRE8ODznEmFuMhAeMoSLLWFT2bUA9
         Eq0IPC1ieH2cS2N4fUA+U4aaTh8D65YVKcmHFQ8erlBdDKzam5BBZz6pVuzM+wNC8ITC
         JvVoup94mb1JtIjVCIgsj+ZrI3No1az++NRzBSBdJ/hW3V0RJRfCDIQWsX/el7J6L7OL
         HO3Q==
X-Gm-Message-State: AOAM532xY6GIBpgW0WAfJI3UlRyGqC/BpAykrIsKDwIgBQvwcA+yLXDV
        GtaZuy//MXMaKOSMGnKLJCc=
X-Google-Smtp-Source: ABdhPJx/4nh2ACtoaxcswMoN+m/YclK52TB3ULpvDpqT0U5Fw9YKO9OKwbZu93i2NfFWxumVxQy5yA==
X-Received: by 2002:a17:906:d41:: with SMTP id r1mr16823532ejh.383.1603742258999;
        Mon, 26 Oct 2020 12:57:38 -0700 (PDT)
Received: from kozik-lap ([194.230.155.184])
        by smtp.googlemail.com with ESMTPSA id i14sm6378453ejy.110.2020.10.26.12.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 12:57:37 -0700 (PDT)
Date:   Mon, 26 Oct 2020 20:57:33 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, willy.mh.wolff.ml@gmail.com,
        k.konieczny@samsung.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        s.nawrocki@samsung.com, kgene@kernel.org
Subject: Re: [PATCH 2/2] ARM: dts: exynos: Remove interrupts from DMC
 controller in Exynos5422
Message-ID: <20201026195733.GA240203@kozik-lap>
References: <20200708153420.29484-1-lukasz.luba@arm.com>
 <20200708153420.29484-3-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200708153420.29484-3-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 08, 2020 at 04:34:20PM +0100, Lukasz Luba wrote:
> The interrupts in Dynamic Memory Controller in Exynos5422 and Odroid
> XU3-family boards are no longer needed. They have been used in order
> to workaround some issues in scheduled work in devfreq. Now when the
> devfreq framework design is improved, remove the interrupt driven
> approach and rely on devfreq monitoring mechanism with fixed intervals.
> 
> Reported-by: Willy Wolff <willy.mh.wolff.ml@gmail.com>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  arch/arm/boot/dts/exynos5420.dtsi | 3 ---

Thanks, applied.

Best regards,
Krzysztof

