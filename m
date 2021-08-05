Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7020C3E156B
	for <lists+linux-pm@lfdr.de>; Thu,  5 Aug 2021 15:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240984AbhHENOA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Aug 2021 09:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241639AbhHENN7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Aug 2021 09:13:59 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6F6C061765
        for <linux-pm@vger.kernel.org>; Thu,  5 Aug 2021 06:13:44 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id c16so6456415wrp.13
        for <linux-pm@vger.kernel.org>; Thu, 05 Aug 2021 06:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=UUu523d0YBVb9bSzCWt3RRa6Pgd03o5Xn6oQ4tg8F7w=;
        b=aDTOYxz8dH7dnZEhyCzIcsmSkYNGAm00DR997ghOR4mCJMeOeY+UEPoKObi4M+Xzsi
         NaAvvnU8eKjBNe1JCwifAUs5TXQEoaZtYocEW7xmUiDUjRvMy7NaJSaUglrNZbOF3g/K
         znlpcZs//mW1k2rnKB739JmGh1BTxp7K6/PC4GJQvyCjGvBYGv4A9hwa+Lbx0zGt8wbq
         BAqTj01ZqKapsSkl3NkZdjPJ07yu0nAeoiWdRuBNyPrSb57vi+gGkN1jNyep3r4J9nTb
         2WFRegGYnYQqywRNbelMvGE/OovM4eM3lE8+1WGHQHPFgfJ1eR+dES2M15qxAxw+vnLJ
         5aLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=UUu523d0YBVb9bSzCWt3RRa6Pgd03o5Xn6oQ4tg8F7w=;
        b=mTvZy8DcNadp6ana5n/BtP8Ju9YLn02gKpsFMgqc7th/lMw7mTkmgw8qMt9NhWbAwB
         IL6GbjFID084xLcFLEPONvqA/igpat/1lnROJU0tHdhP3NRFEY6qCIofSOi6wp1NiNGe
         22YLKAAYPxunhFVxg5v3AQZXBF08md5xIZ5j7uuoZJCX4kaRvGlaTFOVEfwhfCrxksvc
         5H986oBFc/BIV7au40n2+t/Ovzk0TJbP+G4v9VgPjwc8TMXsHvuASITKj1RclJb6FkIS
         laO4/Gh2eMLy5NE2256K3vrZV57Z5nIROWdBiPJx7mvDIHm2XCaoQIqKbwFXOCyJjkf6
         id4Q==
X-Gm-Message-State: AOAM532nTpLSTz/NxRZ8wDmPSDlYaObixNq4Pl/tzMZrXR00gJea5hst
        +m1oXFLZIwB0o68IOYMevHUeQQ==
X-Google-Smtp-Source: ABdhPJxQ+UEI5xJdyxlz1PDCgogsvmKKjafiAQQ8CdNDUJZ1OzRvx5onZrnOxCLq+Z8PhJmIHLUrmA==
X-Received: by 2002:a5d:457b:: with SMTP id a27mr5153679wrc.169.1628169223212;
        Thu, 05 Aug 2021 06:13:43 -0700 (PDT)
Received: from google.com ([109.180.115.228])
        by smtp.gmail.com with ESMTPSA id p10sm8643316wme.30.2021.08.05.06.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 06:13:42 -0700 (PDT)
Date:   Thu, 5 Aug 2021 14:13:40 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Chris Morgan <macroalpha82@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, maccraft123mc@gmail.com,
        sre@kernel.org, heiko@sntech.de, robh+dt@kernel.org,
        Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [RFC v2 2/4] mfd: Add Rockchip rk817 battery charger support
Message-ID: <YQvkBAaFHIGtvmKz@google.com>
References: <20210726190130.1973-1-macroalpha82@gmail.com>
 <20210726190130.1973-3-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210726190130.1973-3-macroalpha82@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 26 Jul 2021, Chris Morgan wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add rk817 charger support cell to rk808 mfd driver.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
> ---
>  drivers/mfd/rk808.c       | 16 ++++++-
>  include/linux/mfd/rk808.h | 87 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 102 insertions(+), 1 deletion(-)

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
