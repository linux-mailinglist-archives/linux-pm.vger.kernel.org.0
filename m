Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B267A3ED428
	for <lists+linux-pm@lfdr.de>; Mon, 16 Aug 2021 14:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235457AbhHPMmd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Aug 2021 08:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235747AbhHPMm2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Aug 2021 08:42:28 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311FFC0612AC
        for <linux-pm@vger.kernel.org>; Mon, 16 Aug 2021 05:41:10 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id x10so17093292wrt.8
        for <linux-pm@vger.kernel.org>; Mon, 16 Aug 2021 05:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Dd2RvTZ8gfpygtsaCzyWPhxOJ3nDcTnkRmNkdPIycPE=;
        b=MN80BPlTMUSdGRt9o4zUkk6ciSKkUoDM5z8fqGbgjtuUeHQHeJtWULk47nDTEuSH4X
         kclPHJ6EZWwlXgJ83NzAwgzt8phoVAnrObLpRRTCzL1MCfCGS7qw6DMFr5CPiAu0zwJE
         dt59c0quohqlXl5X71m1sFXf92Juklkr3eL/YKdOFP1ACi/7H9JyFG/8WiysxvhymUXT
         Am4QMChg5zWcjLAmop9ZTTGwJa+g17/5svJEkfNkx25JzJPeJeZBJlKxXAZEkh36O9I/
         iugcvle5bfF0zkQSyYQwqDYpQ5CFMHfskAO3A9fhWx9FjxFZPmBYwKqJ4slIdTYqoZd0
         85Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Dd2RvTZ8gfpygtsaCzyWPhxOJ3nDcTnkRmNkdPIycPE=;
        b=Q8gDtltDVZu8KENGP8ZMXz6bLSmTxj7SVM1M0jGKYMXPl2IP9eYfteLpXyUZCwYhgN
         y4jHDWLG+bv9iS88nk1bmqSGUytVPZoXWozVm5mnkWWNEKciOQUfrJL2OVGUiYfR71Oa
         GnEqN59QlAo3l1hZTZLAVC2iFwC8Zm7XepR0Tpi4N+L3hyCxBz9NK/zbvPFw6J3AEoh8
         VvZt68lWYVVYBd5sReMKg3uRPozNS3MLI/ISmlhzvptPG/fwp1Jx79OKZvwVViXSE1IW
         ig4JRQt1kbSDf267RbooKqEkj8to0KhOZSk10ZkkTYa1xU/YUkF4cAWORLqd6mPCdMnM
         /0EQ==
X-Gm-Message-State: AOAM531QwCT+WC19tIb0RYyz1dWvehK+CHjfY6WepEP0cHEIdO1sQGm5
        mG6XQyUaNhOhdYXddjj0yO15YA==
X-Google-Smtp-Source: ABdhPJzCaVGtA83Fws9GgfQkHtlFDfu5aVDPplXc1yQxTUf27mK6sgXSIb97EvM/JH/WIE9f8DpE2A==
X-Received: by 2002:a5d:6d82:: with SMTP id l2mr18369118wrs.225.1629117668801;
        Mon, 16 Aug 2021 05:41:08 -0700 (PDT)
Received: from google.com ([2.31.167.59])
        by smtp.gmail.com with ESMTPSA id i10sm10195719wmq.21.2021.08.16.05.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 05:41:08 -0700 (PDT)
Date:   Mon, 16 Aug 2021 13:41:06 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] mfd: tps65086: Add cell entry for reset driver
Message-ID: <YRpc4jajnsEaGbeW@google.com>
References: <20210727092554.1059305-1-kernel@esmil.dk>
 <20210727092554.1059305-5-kernel@esmil.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210727092554.1059305-5-kernel@esmil.dk>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 27 Jul 2021, Emil Renner Berthing wrote:

> The only way to reset the BeagleV Starlight v0.9 board[1] properly is to
> tell the PMIC to reset itself which will then assert the external reset
> lines of the SoC, USB hub and ethernet phy.
> 
> This adds an mfd cell entry for the reset driver doing just that.
> 
> [1] https://github.com/beagleboard/beaglev-starlight
> 
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> ---
>  drivers/mfd/tps65086.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
