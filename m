Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E69D724736F
	for <lists+linux-pm@lfdr.de>; Mon, 17 Aug 2020 20:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403828AbgHQSzo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Aug 2020 14:55:44 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:39728 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730535AbgHQPu0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Aug 2020 11:50:26 -0400
Received: by mail-ej1-f65.google.com with SMTP id f24so18320903ejx.6;
        Mon, 17 Aug 2020 08:50:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CvY+Gv9fZiNUpyRo8aOD2OAX4f7HvaEYlR7elhE0eDI=;
        b=Z9tlqxxJD367x/vsFxQW1v7W2GGDyy8/7TJtOzee1d2tvH8PCI/cdgqHw3H+k6DXEm
         wAt37Suvj1+IfZO3xr3yRiF6kGtM41lKo44G3AQ664Q6MWBZT8ZdyFXcV7WOIDSuQYAu
         3c55axNm2VksqwpKUbf0FAGiouwKY7mFMfGLOP1yUf3JcjIZzzo/SU2x+VwcHSLsDfG3
         RPBmQ4OL2D0zpqsGV52iGB7JrK9UfBfwvHjI0VcUUKoLC6RvbSownFkNn7tPDHS/r2CT
         QtJpaSYpG042Hc+UpDeuCLHZwTVpc5qYLGckSiceELHVrJUurd0f8QJMUighkm168vGx
         TABg==
X-Gm-Message-State: AOAM532cK3jCFIk0qKYwBvgHPXWysWJ/qhKlESqlAQIlCPnyDSdqkeSm
        VVjvtfhPGtiiyhJNHI4jz+s=
X-Google-Smtp-Source: ABdhPJwUH2JfieM4+gZF9eNKg35FhFE+j87Rl4f371bQ3K5WOxcwB8LzeD/gzxX+LVyjfatGHlfezg==
X-Received: by 2002:a17:906:78e:: with SMTP id l14mr16737436ejc.67.1597679424558;
        Mon, 17 Aug 2020 08:50:24 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id g9sm14232950ejf.101.2020.08.17.08.50.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Aug 2020 08:50:23 -0700 (PDT)
Date:   Mon, 17 Aug 2020 17:50:21 +0200
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
Message-ID: <20200817155021.GC15887@kozik-lap>
References: <20200708153420.29484-1-lukasz.luba@arm.com>
 <20200708153420.29484-3-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200708153420.29484-3-lukasz.luba@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
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
>  1 file changed, 3 deletions(-)

I think the dependencies were merged so this can be safely applied
without bisectability problems?

Best regards,
Krzysztof

