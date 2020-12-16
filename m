Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7138F2DBD23
	for <lists+linux-pm@lfdr.de>; Wed, 16 Dec 2020 09:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgLPIzy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Dec 2020 03:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbgLPIzy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Dec 2020 03:55:54 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40974C0613D6
        for <linux-pm@vger.kernel.org>; Wed, 16 Dec 2020 00:55:14 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id 91so22355145wrj.7
        for <linux-pm@vger.kernel.org>; Wed, 16 Dec 2020 00:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2X0i4LnWvhmDFLe5iRLCVbqdwzEb8VnCa7MUUVftSIM=;
        b=KKmFkvJ6+Pp0k13eW7K9dRJ/GBUKcTyFvlGvGPyPit+Bpk+KcV+OAAahNMFpxvU/Bb
         Wztaqcp4EgYcBCeaAwGe21cdweZAM1n6zvXnos7neKCAXNLclMWC72JjcM73dLQQyLt8
         CqS1tUPM/GBFgcsxYBuoK4evReKaupUR6e7vsQgHU7V6speuCHLs4OJEmZJpN7WZTZpm
         y5TuGzZj/Q3dqObtYThHAx54Ws5c+/PYXhj415osZcGp57dEQ16ub/6pn/glREnzl5s4
         lc8Li4PwLuY5Gzan+UxSJnRFIIa/xv80WavF6eaKPXhUVSknBwtJ8G75gvTfOPrjwCOu
         K3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2X0i4LnWvhmDFLe5iRLCVbqdwzEb8VnCa7MUUVftSIM=;
        b=e1l5yerqdCbP13TBGRmxWbdDD5WnqSdrexByCirE4nHkh6sFkWVt7mcjB8BJE1l39G
         ZgJwAIifWDBD3jjVsxjv4dVxm3kCjLZWhnFjwb581IBFAi4aUb7GZmBQCDhnTX8DlzFY
         n+PkaVPP4FjCOsarAAccqwtWFpJnV9l0Iw0VVoUht5UkyG99fdxOpNLl4eOVE3F2omJR
         Srklpx5ERgHNDPthW9YqZfPNdIVT7Ns35FluuJhOotOXSwTg0hiiaIK40GXWuVGqcrsI
         Z87cDop7xH7rSEKE1ibnrj5FpUMpNUpJv02jWpMnerM/MCabgXjsnnpW/YrlzYbP87W7
         LP7g==
X-Gm-Message-State: AOAM533NS1shrtJDLznfT2FLFTAQhzFpgdh/M08JkhaInK5u9B5EZ/gY
        CFRtAQGfJ7UHmO+LvuEYQ7ThiA==
X-Google-Smtp-Source: ABdhPJwnGtS9A/gGhOBAsI7ahIG2u0mP9aR4+czSbE59/b/1ukS60p297avYZmDALN8JBC/eVFK0rQ==
X-Received: by 2002:adf:a29d:: with SMTP id s29mr36867749wra.272.1608108913046;
        Wed, 16 Dec 2020 00:55:13 -0800 (PST)
Received: from dell ([91.110.221.200])
        by smtp.gmail.com with ESMTPSA id b73sm5275396wmb.0.2020.12.16.00.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 00:55:12 -0800 (PST)
Date:   Wed, 16 Dec 2020 08:55:10 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Cong Pham <cpham2403@gmail.com>, rostokus@gmail.com,
        fan.chen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH v2 6/6] MFD: bd71828: differentiate bd71828 and
 bd71827 chargers
Message-ID: <20201216085510.GH4776@dell>
References: <cover.1607085199.git.matti.vaittinen@fi.rohmeurope.com>
 <a892b00bd90bcd09e124b3a8e306ededebb64d08.1607085199.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a892b00bd90bcd09e124b3a8e306ededebb64d08.1607085199.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 04 Dec 2020, Matti Vaittinen wrote:

> BD71828 and BD71827 charger blocks have some minor differencies.
> Use own name for BD71828 so that charger driver can differentiate
> these by device-id.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
> 
> This patch is also provided in this RFC version only for the sake
> of the completeness.
> 
>  drivers/mfd/rohm-bd71828.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
