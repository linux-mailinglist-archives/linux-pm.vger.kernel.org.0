Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83BD2C8F9E
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2019 19:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbfJBRTN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Oct 2019 13:19:13 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53217 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbfJBRTN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Oct 2019 13:19:13 -0400
Received: by mail-wm1-f67.google.com with SMTP id r19so8057212wmh.2;
        Wed, 02 Oct 2019 10:19:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=no+pVuOU4/2ncxfp2PCuYfXSUaMyBiG5X4wKsXpzwTQ=;
        b=swTaXDKnnqPuZhOZEC0b1nEBZKPcDoYossUaqP6nArs1SrMiCc9O0xfNteBkU1W2cV
         yuosn9JUdoDtmeoN5pvijQiBKTSrxST1KMXEnFLj/lsXNcoyULoGMOm5zBXC43rJtq27
         saVjgcYqTjMiQ5x5+ITKbWQyo7l+4Dqk0gHD9dI0acHavGF34dvVvAOQ1ADfHaa3AFRO
         SCiDmnoKhRlR5LFyuvVdDdjqBZQtQI4FpJatbgtuJ7nqa6lmDAmiV6vO6wNY9dXkrCsx
         IPhj8r8mo5CrBGlKctOo8vbXPn2/eUaTcU2enNnmKJZPNSr6r1h3jnw6b1D8T2xYUtaC
         NguA==
X-Gm-Message-State: APjAAAXvPoGIt5sCH2EPMjpKCdte/WD6refVmHO0xkjzGsS3kEj4/AkO
        7VuDtqUzFY+roUh3XZHeH3c=
X-Google-Smtp-Source: APXvYqw/Sxw1D9QQ1ZzdqSb5BBqVgBbTwx0GfHLbZdDtnNnd+IxSlJStKyhtgTNKeqQVDgJz09jEbQ==
X-Received: by 2002:a7b:c764:: with SMTP id x4mr3662517wmk.62.1570036751382;
        Wed, 02 Oct 2019 10:19:11 -0700 (PDT)
Received: from kozik-lap ([194.230.155.145])
        by smtp.googlemail.com with ESMTPSA id z142sm12591475wmc.24.2019.10.02.10.19.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Oct 2019 10:19:10 -0700 (PDT)
Date:   Wed, 2 Oct 2019 19:19:07 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, b.zolnierkie@samsung.com, kgene@kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        keescook@chromium.org, tony@atomide.com, jroedel@suse.de,
        treding@nvidia.com, digetx@gmail.com, gregkh@linuxfoundation.org,
        willy.mh.wolff.ml@gmail.com
Subject: Re: [PATCH v13 8/8] ARM: exynos_defconfig: enable DMC driver
Message-ID: <20191002171907.GA21463@kozik-lap>
References: <20190821104303.32079-1-l.luba@partner.samsung.com>
 <CGME20190821104326eucas1p1f22b49095a17f0b303910c391ff1e906@eucas1p1.samsung.com>
 <20190821104303.32079-9-l.luba@partner.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190821104303.32079-9-l.luba@partner.samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Aug 21, 2019 at 12:43:03PM +0200, Lukasz Luba wrote:
> Enable driver for Exynos5422 Dynamic Memory Controller supporting
> dynamic frequency and voltage scaling in Exynos5422 SoCs.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  arch/arm/configs/exynos_defconfig | 1 +

Thanks, applied.

Best regards,
Krzysztof

