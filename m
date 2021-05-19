Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED1573891CA
	for <lists+linux-pm@lfdr.de>; Wed, 19 May 2021 16:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239741AbhESOrz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 May 2021 10:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242814AbhESOry (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 May 2021 10:47:54 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03036C06175F
        for <linux-pm@vger.kernel.org>; Wed, 19 May 2021 07:46:34 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id r12so14332216wrp.1
        for <linux-pm@vger.kernel.org>; Wed, 19 May 2021 07:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=qcih1ZsB54IYnpGJlyvkpoeAatFrfT168mDlUAbVXbc=;
        b=ZtflBpiFzxk9IT9dvQLhj9zAX07ZOfwvbA/SbHogb7zqkB2Fz2wBOyx04jcdgoMnhR
         gtU55xkk+MqmEvBL27AxoxAWzkbfwlfrlMjcRDPD/+1gMbBah6cGyS7nnlqa7MJm31N4
         qfI9xRe+I5hdagUQo++vkAvuF/oZicXRoRk/0egqw5P8AiVaMt0n68i1PCFFxOX/xNDm
         tqSIQmyan48kAtXOqtIrPvZUJMvCmK8ecONHAwhi+G/9q+FqJ3gkSpoQbcrGkLDRFxv+
         kZjvm9gYTzXRoJeDB3BfkXBb7lG77g8e6AfI8UCTD/RwtRC6XFvuvKBDXpQDVj8rkGUB
         SEyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qcih1ZsB54IYnpGJlyvkpoeAatFrfT168mDlUAbVXbc=;
        b=EvNh3sycyhO5JN/Rrc3wI6bPBdDU2pSNTiiVTwtnFmxx2LHa6G/zmE2hApPSJha0ho
         vTZxFnQpQ6R9BjpxxcxQy9SURf6JgvIpKH2trcURBe/AWyuve/2LnauweCGrFl0R06if
         y5Uqu9zLfvcS/XLRAjCirH3CpwlatR7r1yzezZWZOG05onFA+/qDP5zWFmS6pFf3/VH5
         gvrgeGEmWpdha3/hvXQH5rM5Mhr9qvFJEaIJWYlKKIxkZpMOP8zm67WBpt+vY2tN/fbg
         4blsh0jAjPe/0n4sSNsF0m0dP4hOGx1dIdW7Wd+dxiDQjrbzw9pf3QLh9rr9a7TR9NP7
         He/Q==
X-Gm-Message-State: AOAM532v5Fbtcak3lhL9PvCrE2e8GmVZIJy7rw5AIYEwQUtjIlEHmVyj
        j5VCWYsHkKlrGAmJrBomZYB+QA==
X-Google-Smtp-Source: ABdhPJyIt8eL6wfcj/xZA/0YCPZS/2JzPSNbt554efDjHPLXgMAWowEbrZ1/KMI0hS6vR3gARlmFxw==
X-Received: by 2002:adf:ffd2:: with SMTP id x18mr15161346wrs.144.1621435592655;
        Wed, 19 May 2021 07:46:32 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id q13sm24456544wrw.56.2021.05.19.07.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 07:46:32 -0700 (PDT)
Date:   Wed, 19 May 2021 15:46:30 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 3/3] mfd: rt5033: Drop rt5033-battery sub-device
Message-ID: <20210519144630.GC2549456@dell>
References: <20210517105113.240379-1-stephan@gerhold.net>
 <20210517105113.240379-4-stephan@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210517105113.240379-4-stephan@gerhold.net>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 17 May 2021, Stephan Gerhold wrote:

> The fuel gauge in the RT5033 PMIC (rt5033-battery) has its own I2C bus
> and interrupt lines. Therefore, it is not part of the MFD device
> and needs to be specified separately in the device tree.
> 
> Cc: Beomho Seo <beomho.seo@samsung.com>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Fixes: 0b271258544b ("mfd: rt5033: Add Richtek RT5033 driver core.")
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
>  drivers/mfd/rt5033.c | 3 ---
>  1 file changed, 3 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
