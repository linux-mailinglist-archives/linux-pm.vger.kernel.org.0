Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC50DC8FD9
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2019 19:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbfJBRYr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Oct 2019 13:24:47 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36333 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727624AbfJBRYq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Oct 2019 13:24:46 -0400
Received: by mail-wr1-f65.google.com with SMTP id y19so20605770wrd.3;
        Wed, 02 Oct 2019 10:24:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8OID6bEMxv+Gv/QZ0YNXTE8bbklUElxmTKC2iUlX+wc=;
        b=qouyxiVPu+1ZscgSXDmQJiINAPazmk13qJdeRwYzR+eYd2tgFVyzIRPLt8nhuSITp9
         g4RXOqVhV9zLy7qAV7VNnprzzorZaC8JX5v4yJAOWxH7ubXn2B3Af4A679b4smPWAEhn
         TDbMlPkmh4s6x+UwiS7ng25NchES1ajuhh/wGp+pyRYG3dtzVtUSmYjmckX7/hxs/3K6
         rfqKA6ukboXZ+NQqvNdUEKAb7lCsYlJHuHd9Yk69r7sJ2VOe6FW0WNoyHnoDL8XZRNp0
         VjWb4Iu1wMJUOOqxpjnaBT9owHTfyTWFlcHoGkzaODnWgA+zkDJH0NUyPThr5TkSEzyF
         IPDg==
X-Gm-Message-State: APjAAAUYcLEb0a/anLTj7Fre3vTuTQ4Mh8AcWz6DNO+iCabYtDT3DPCR
        0PVHjIhKKfcCL9d9xPOHd08=
X-Google-Smtp-Source: APXvYqx57q0j9xKZVurytfcIVWaGsSq1z7w9C8yIVXe6bOgJ7O5sIHMewl93NN5Ecs+5iEJ0GKvLSg==
X-Received: by 2002:a5d:424c:: with SMTP id s12mr3652381wrr.221.1570037084261;
        Wed, 02 Oct 2019 10:24:44 -0700 (PDT)
Received: from kozik-lap ([194.230.155.145])
        by smtp.googlemail.com with ESMTPSA id 26sm7246476wmf.20.2019.10.02.10.24.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Oct 2019 10:24:43 -0700 (PDT)
Date:   Wed, 2 Oct 2019 19:24:40 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, b.zolnierkie@samsung.com,
        kgene@kernel.org, mark.rutland@arm.com, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        robh+dt@kernel.org, willy.mh.wolff.ml@gmail.com
Subject: Re: [PATCH v3 2/4] ARM: dts: exynos: Add interrupt to DMC controller
 in Exynos5422
Message-ID: <20191002172440.GD21463@kozik-lap>
References: <20191002060455.3834-1-l.luba@partner.samsung.com>
 <CGME20191002060505eucas1p2efd80ccde8c728973df8d932580cd58b@eucas1p2.samsung.com>
 <20191002060455.3834-3-l.luba@partner.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191002060455.3834-3-l.luba@partner.samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 02, 2019 at 08:04:53AM +0200, Lukasz Luba wrote:
> Add interrupt to Dynamic Memory Controller in Exynos5422 and Odroid
> XU3-family boards. It will be used instead of devfreq polling mode
> governor. The interrupt is connected to performance counters private
> for DMC, which might track utilisation of the memory channels.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  arch/arm/boot/dts/exynos5420.dtsi | 3 +++

Thanks, applied.

Best regards,
Krzysztof

