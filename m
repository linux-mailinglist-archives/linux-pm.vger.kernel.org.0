Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0E91C34A7
	for <lists+linux-pm@lfdr.de>; Mon,  4 May 2020 10:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgEDIkm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 May 2020 04:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726351AbgEDIkm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 May 2020 04:40:42 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184E0C061A0E
        for <linux-pm@vger.kernel.org>; Mon,  4 May 2020 01:40:42 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id d17so19834506wrg.11
        for <linux-pm@vger.kernel.org>; Mon, 04 May 2020 01:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Wpw4hLHfkH4N+JOXSI4RLmWbxNK2gVAne34AzQXBo8Y=;
        b=J3yzsGB2QZKh1Z+Ii6kkufTdep70GtErKemHckmXneKCPyHLhdh9tMb5i6IbTG/m73
         0s8Afn8+JSYzUH+z7ztFvlRcaHMUyN84q6fqAnVS2Br5PXjvMBddJLk/tBuXKBVcehLj
         IIzg46qYAnji9++Q2cRhGolaGp5kynN56oegR6E/CNF+8WPUhGgRmzmny/+ZF1/bwK7L
         vRSd8BDUr6htNiPXtmOGPaaMtja/kuSCCieTA7VAZKx0I7ggFOK/X+FqChM93YUaWcqM
         OYR1qNJG68C8pgRlRYSdcfbXJnP6efwV5sakQN7WBz77OQKAjrybEFpmUcdIjHppk5TN
         LA3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Wpw4hLHfkH4N+JOXSI4RLmWbxNK2gVAne34AzQXBo8Y=;
        b=QJdd6+8flcloGycFe+WtAMarrQ8bgP3hEgbYAlAYXd0YdfNlMILGBmTl7GfKDvv/7z
         6exICydbNSto3wrrWqcSbarh8uM1XFx+RfzkQPIWce182uw266Iob15fz5K0oDbCGb5n
         NtQ+DiVYL2IZiQO5AnrJn2gRL07kbOZmQOkQWipzDJDQkfqkELWxRzJxAYJ1O5ccePi4
         2ozKgpAcmSYwkW/WV2M/lPk01K0ECzxANVhh7M2CgO5WtAGNTqXr8mWmcVQJe8/x4Cao
         270QffuXbTA4mIpd+MNuKbpiveNTBTM3ao4b1alpqGRgiCdO6c49Lq/VTXmFFyUhROql
         ZZUg==
X-Gm-Message-State: AGi0PuYgV1KDS1X6Gywq7s5ZQAu+4BqXSMmd3RRYoyueCyaUULvuzc7l
        VMryMcVX7ekDy/WyuIyqXN5dBA==
X-Google-Smtp-Source: APiQypJO0zONjRsCboKbXszJQHwjxv+YnXjZXuR20iHpxubYidpCjzHDGbNcO+jV/xoiRdAE7tcptw==
X-Received: by 2002:adf:e58e:: with SMTP id l14mr17099093wrm.186.1588581640714;
        Mon, 04 May 2020 01:40:40 -0700 (PDT)
Received: from dell ([2.31.163.63])
        by smtp.gmail.com with ESMTPSA id n21sm4012749wra.15.2020.05.04.01.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 01:40:40 -0700 (PDT)
Date:   Mon, 4 May 2020 09:40:38 +0100
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
Subject: Re: [PATCH v2 11/16] mfd: vexpress-sysreg: Support building as a
 module
Message-ID: <20200504084038.GE298816@dell>
References: <20200429205825.10604-1-robh@kernel.org>
 <20200429205825.10604-12-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200429205825.10604-12-robh@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 29 Apr 2020, Rob Herring wrote:

> Enable building the vexpress-sysreg driver as a module.
> 
> As deferred probe between the vexpress components works now, we don't
> need to create struct devices early with of_platform_device_create().
> 
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/mfd/Kconfig           |  2 +-
>  drivers/mfd/vexpress-sysreg.c | 15 ++++-----------
>  2 files changed, 5 insertions(+), 12 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
