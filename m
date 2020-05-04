Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBAC1C350E
	for <lists+linux-pm@lfdr.de>; Mon,  4 May 2020 10:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbgEDI4V (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 May 2020 04:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728165AbgEDI4U (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 May 2020 04:56:20 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09076C061A0E
        for <linux-pm@vger.kernel.org>; Mon,  4 May 2020 01:56:20 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id s8so9628470wrt.9
        for <linux-pm@vger.kernel.org>; Mon, 04 May 2020 01:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=cxb+ZWhOowouZHcr/9zGu47fpdlJUABxmhLddbqkDGo=;
        b=KjP/CPhVoyoVHxRfOZPYKJMbQbb1OH1X/SdQnlH6Sqv0GWA4AXO0GgW5eyxKsEyl/9
         acv63S4fAoTQKYX6VT01lF9GS8UmNMS+LcCPmBGoyVMwIorwJaWPrqY+n4t78za2Seev
         ir1YERXRmPk3MsUjiE4j0VI8FOXwUQdiPoiRdfeP7xGpV6M/FJveH7HfBc2befxjRg1L
         +0ChXAHT9j2WVzB/gemP33nvbA8hv760xmKScJN0oQcFbYv2+zHVVDP9HicmDaY9Wjnd
         FIsctLUhhIfn4O2wBNcsxeqxVjtW2+E9XgYH+NG9kSQa5z84w2RWWPhohpWYST2HG6gb
         QTRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cxb+ZWhOowouZHcr/9zGu47fpdlJUABxmhLddbqkDGo=;
        b=c9UCib0A0/eaKKN5a4yv/TVK0LEH3TF6JNxLPeWbpcJYo7NAYMvm8IKNGCMX472wFH
         SLzIwiV3OF343rZdnh6BDv/27wNC1XpfIaLX/UHc+YcA/BvH4aHiv2H5SoZyRYjM67YW
         AvjhqJW3IL6bqsB2na2zPr5Oa+14c4fZNT+FxDWwAtGGikOyx/WoZPj64hWpUoZUVjMR
         fcxQ3WV4cgk2aqolHPgpX54MhIPX3FPMsEJC/q+tPATGpT/WGEM0dHFxFqp/3sO7qdDx
         blAdzooDT49lSO6M6b7a/tu/3tsNBoCqj6oaY40fR9CkCcJ++8JsF85JbGVJIBMWnPrC
         RRFw==
X-Gm-Message-State: AGi0PubtdArlkygAYWov82DvSnyaiEVlVwCsCxAhWqg68z5tHh3tyq9Q
        /NPwZQQMeP7lkBblkjFhdmWSfg==
X-Google-Smtp-Source: APiQypIJA1Cxt7YOUF+68JT0W1SFjsyeUbBkN9uhvc9MdF+wh/6hR3+o3fvijZm+Tupqy5kyDXXe0w==
X-Received: by 2002:adf:f041:: with SMTP id t1mr4458998wro.346.1588582578720;
        Mon, 04 May 2020 01:56:18 -0700 (PDT)
Received: from dell ([2.31.163.63])
        by smtp.gmail.com with ESMTPSA id d5sm17646871wrp.44.2020.05.04.01.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 01:56:18 -0700 (PDT)
Date:   Mon, 4 May 2020 09:56:16 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Reichel <sre@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 01/16] ARM: vexpress: Move vexpress_flags_set() into
 arch code
Message-ID: <20200504085616.GI298816@dell>
References: <20200429205825.10604-1-robh@kernel.org>
 <20200429205825.10604-2-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200429205825.10604-2-robh@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 29 Apr 2020, Rob Herring wrote:

> vexpress_flags_set() is only used by the platform SMP related code and
> has nothing to do with the vexpress-sysreg MFD driver other than both
> access the same h/w block. It's also only needed for 32-bit systems and
> must be built-in for them. Let's move vexpress_flags_set() closer to
> where it is being used. This will allow for vexpress-sysreg to be built
> as a module.
> 
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Liviu Dudau <liviu.dudau@arm.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  arch/arm/mach-vexpress/Kconfig |  1 -
>  arch/arm/mach-vexpress/core.h  |  1 +
>  arch/arm/mach-vexpress/dcscb.c |  1 +
>  arch/arm/mach-vexpress/v2m.c   | 23 +++++++++++++++++++++++

>  drivers/mfd/vexpress-sysreg.c  | 19 -------------------

Acked-by: Lee Jones <lee.jones@linaro.org>

>  include/linux/vexpress.h       |  4 ----
>  6 files changed, 25 insertions(+), 24 deletions(-)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
