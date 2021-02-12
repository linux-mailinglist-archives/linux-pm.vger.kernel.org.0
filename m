Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4C36319BFC
	for <lists+linux-pm@lfdr.de>; Fri, 12 Feb 2021 10:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbhBLJiv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Feb 2021 04:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbhBLJis (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Feb 2021 04:38:48 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B44C06178B
        for <linux-pm@vger.kernel.org>; Fri, 12 Feb 2021 01:37:50 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id j11so336244wmi.3
        for <linux-pm@vger.kernel.org>; Fri, 12 Feb 2021 01:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=PkIJB2P07r0I1a+6LmYfF/eJubpC6EF+zgj8b/X18t0=;
        b=eqRVHicKGReNXZNXMkWRBT0kFywqGplwhpjcUYlB+Dzf0i6cW4ak4i+4McZgmJiDxU
         qrcLAVDrynys9ejnB2JdhWeUwxwpesyBKOsqS28WeTxBLe/O8XZfxjSdPnL/Y5t0peNi
         yDM08OokUHlNIRwXFhjHYEZqY70UeuTxiiY+dQzuIaWkqIpwAfu2tbDXnUKmnGg3A/JM
         BmzedKCknGOD7v86cKOoEnA49Oa+EY0X217l2DnwuVg5eD0gNT3OOveC2ia01NRveZsm
         aI5Yrk+fFU+f1gZePAoti/0LbeM4BrPodYTHlpG/R4FnE3YtwJ1uZvsIC2Fd4YOpzJ6u
         P/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PkIJB2P07r0I1a+6LmYfF/eJubpC6EF+zgj8b/X18t0=;
        b=d8kjyMaLsdV6iLqW87acK2Wy1fJPRVY7P9apkxqisqsLh//tgsb5PG/Y39fIBssAT8
         RL+O1ib29jFJ5ZniOmKsVOekuqGBxmNKaSghZZDu6hUNoRjPj1nJbu2Al4JoRzargaYE
         EQLKbYuEilRja4rOYf+GmBv/AtBVYrpgEjNzMmcfEa4UkjXE2SpKwbny0OcpocBpJ7vq
         9EVZ75AVJaN2EUKLsM2xzbgEkbYocOEdVhNwMSKf9Lc6BUPITRk50FJp0/KLu2fV/T0i
         LB0RfMkFvKd6/XrIsPXWO81JIy8GBiHgDcypt5z6AZMH6g7gc9EqDicF8KU8oY5EDtN2
         in2w==
X-Gm-Message-State: AOAM530J2fhD1yIGRT6xmFE4sqxAnM1smqTcvBaTHZlHZB4JitZkOm94
        tu3u8+YYoNMnC6CZKPhmWyEu7w==
X-Google-Smtp-Source: ABdhPJwDhFICyz/JghmhucGWJYKHNvfrNUqx6TUMtJd8PfA8C9At8/3JQNBc9Xkla9akgZ01OGXsSQ==
X-Received: by 2002:a1c:7e4e:: with SMTP id z75mr1879586wmc.168.1613122669035;
        Fri, 12 Feb 2021 01:37:49 -0800 (PST)
Received: from dell ([91.110.221.187])
        by smtp.gmail.com with ESMTPSA id u10sm12871354wmj.40.2021.02.12.01.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 01:37:48 -0800 (PST)
Date:   Fri, 12 Feb 2021 09:37:46 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Timon Baetz <timon.baetz@protonmail.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v3 3/7] mfd: max8997: Add of_compatible to extcon and
 charger mfd_cell
Message-ID: <20210212093746.GH4572@dell>
References: <20201222070520.710096-1-timon.baetz@protonmail.com>
 <20201222070520.710096-3-timon.baetz@protonmail.com>
 <20201222095522.GC53991@dell>
 <20210211221132.5e8d156c.timon.baetz@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210211221132.5e8d156c.timon.baetz@protonmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 11 Feb 2021, Timon Baetz wrote:

> On Tue, 22 Dec 2020 09:55:22 +0000, Lee Jones wrote:
> > On Tue, 22 Dec 2020, Timon Baetz wrote:
> > 
> > > Add of_compatible ("maxim,max8997-muic") to the mfd_cell to have a
> > > of_node set in the extcon driver.
> > >
> > > Add of_compatible ("maxim,max8997-battery") to the mfd_cell to configure
> > > the charger driver.
> > >
> > > Signed-off-by: Timon Baetz <timon.baetz@protonmail.com>
> > > ---
> > >  drivers/mfd/max8997.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)  
> > 
> > Applied, thanks.
> 
> Once https://lore.kernel.org/lkml/20210130172747.2022977-1-timon.baetz@protonmail.com/
> gets accepted, this is not needed anymore. Can this be reverted or
> should I create a new patch?

Please submit a revert with the reasons why.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
