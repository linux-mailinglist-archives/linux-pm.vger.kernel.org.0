Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62EB0C8FEE
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2019 19:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfJBR3j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Oct 2019 13:29:39 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54143 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbfJBR3j (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Oct 2019 13:29:39 -0400
Received: by mail-wm1-f66.google.com with SMTP id i16so8085462wmd.3;
        Wed, 02 Oct 2019 10:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=knUYYHU2RbGFZMJdC/t7iP8HF/H6gnHVaApA8Esfhxo=;
        b=Z1xOXOi8giWYdBPsef30cFsZDIGE91qMj6llDgJPW4MAnTRsze81s3Kt21KZmE3BSc
         QGlspolGvKF4BNpt2F3kZ9KF/4itPArZYTl/BNoHNHP//3TfdFxYP8QozdwUA5O6mwfT
         tm0rnM2XkGoQCEwYUHlRVeCOl2XkRt+1tznNCmAOvGn6oQ1y4LupJCA9LZ+gAE9tZvCF
         FEDhvfCCq5lXO3BN5I1JrKc/iQfi3EWTk1Z+vpop+uwyzFznEJ2TuO5S8YXmSb0Lb4m1
         82GSVrKRg4Z1RqNjG16aRMDX7a+k1/Fa132GGVyxOjBKuPVBMoG/s8CB8r28GVipSSCn
         bSSA==
X-Gm-Message-State: APjAAAUST5AX9Hs/ljqKDY8T6zIZv4/vdHHvdxSLVVCTV3i0hplH4eCg
        SEtxQFtToUnpz44AtM5AgJM=
X-Google-Smtp-Source: APXvYqyH9fArHRTfXWfzqVQgaYVpo3bxfKpOmbUVndDKpAsFqO6SiYYHhg1MSaFN+BTdgbZp7amG7Q==
X-Received: by 2002:a1c:f004:: with SMTP id a4mr3750737wmb.42.1570037374987;
        Wed, 02 Oct 2019 10:29:34 -0700 (PDT)
Received: from kozik-lap ([194.230.155.145])
        by smtp.googlemail.com with ESMTPSA id n8sm11547015wma.7.2019.10.02.10.29.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Oct 2019 10:29:34 -0700 (PDT)
Date:   Wed, 2 Oct 2019 19:29:31 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, b.zolnierkie@samsung.com,
        kgene@kernel.org, mark.rutland@arm.com, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        robh+dt@kernel.org, willy.mh.wolff.ml@gmail.com
Subject: Re: [PATCH v3 3/4] ARM: dts: exynos: map 0x10000 SFR instead of
 0x100 in DMC Exynos5422
Message-ID: <20191002172931.GE21463@kozik-lap>
References: <20191002060455.3834-1-l.luba@partner.samsung.com>
 <CGME20191002060506eucas1p28c9670128f5adfb628d7e84ce55c6e60@eucas1p2.samsung.com>
 <20191002060455.3834-4-l.luba@partner.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191002060455.3834-4-l.luba@partner.samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 02, 2019 at 08:04:54AM +0200, Lukasz Luba wrote:
> There is a need to access registers at address offset near 0x10000.
> These registers are private DMC performance counters, which might be used
> as interrupt trigger when overflow. Potential usage is to skip polling
> in devfreq framework and switch to interrupt managed bandwidth control.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  arch/arm/boot/dts/exynos5420.dtsi | 2 +-

Thanks, applied but re-ordered with previous one. Applying first
interrupts enables the interrupt mode which does not make sense without
extended mapping

Best regards,
Krzysztof

