Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A190A437573
	for <lists+linux-pm@lfdr.de>; Fri, 22 Oct 2021 12:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbhJVKdH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Oct 2021 06:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232638AbhJVKdD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Oct 2021 06:33:03 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB291C061348
        for <linux-pm@vger.kernel.org>; Fri, 22 Oct 2021 03:30:45 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id g141so2369633wmg.4
        for <linux-pm@vger.kernel.org>; Fri, 22 Oct 2021 03:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Uuv/l8Z6b7ekXd997KsXRmES+x1U5+fbUAKRi/yox+M=;
        b=vghaXR6b/FRilDnKNasUTagEwjx71xTiFLLJGlqwS1Kt4HwnLry4XUcWZzxLBj/OQz
         oUznLZuzo8Kuk40Jth9Fk5xHA5M6vfXd8YFCQyE6X7hFxtEW/R45xmoV7JYl+TyQtjXb
         QsoHtr9g/zmGOunhX2Hxg50p6SJLu5pw/V7+6ccdZzfyPGApTQCzHRTNql+OBovdNaSI
         HLAlWsh4BpZDrLK+ANYYnzZ4fsRaL6Td918BL4LNA1ktgdDDqbANnJNl7kzcXs3/8cFU
         JowKUbqV/saw43egcZUcabjSN3aeHZE0Hj9IK3IWl7IwOoIVQO3LIEZXppCP9jQvMFdP
         wgSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Uuv/l8Z6b7ekXd997KsXRmES+x1U5+fbUAKRi/yox+M=;
        b=wR3fIfhO07ROlIiFRusEn7ZpwJ8yfGacCmtBU1LRERUoncLIWavInd5fZa241WXJ8P
         1iFYm9YtvSkgnsjBOGFgnH5h/Qt3iYn+FSG/TXk73Y7+iHdQrli+eS/mPCGNJoP0z8sJ
         drkvvD7X25OzYXX+ykjIF9BA/rVLkk7TMdsBbSOijD1kvecZSbgG/KnGdUcbfc22TJJP
         wF09jjQhc/bcV2vt41ve2tn/AcaqfKHldeFqVmdjwWXFy+EEwFh7mC8i9DWnoxtCGqAo
         XHVYqH2yL4U6l3ePcUDVOQICOT3CnFEDr11VgRnC7ynDXMAUs1MlYvuwObyq8PL7cKVc
         D19w==
X-Gm-Message-State: AOAM530N/0oLNofUZ/Sm83RzhrcmlOjfflznWAgEf1feB841Edf+dRgx
        HvNWZGnF2+vKgUT3Y1HrJboz6Q==
X-Google-Smtp-Source: ABdhPJyaZP5rL50oKIOhioIOY3zP1DE/WpC/skYPotutgfyEwmOodaalN0ZTqeBZqtWEPtstvY2nng==
X-Received: by 2002:a05:600c:1990:: with SMTP id t16mr13516553wmq.124.1634898644446;
        Fri, 22 Oct 2021 03:30:44 -0700 (PDT)
Received: from google.com ([95.148.6.207])
        by smtp.gmail.com with ESMTPSA id k17sm7393699wrc.93.2021.10.22.03.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 03:30:43 -0700 (PDT)
Date:   Fri, 22 Oct 2021 11:30:42 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     robh+dt@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        kernel@pengutronix.de, shawnguo@kernel.org, s.hauer@pengutronix.de,
        linux-imx@nxp.com, amitk@kernel.org, rui.zhang@intel.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, linux-hwmon@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v13 2/9] mfd: simple-mfd-i2c: Add a Kconfig name
Message-ID: <YXKS0gpBAkZL4Dpg@google.com>
References: <20211015122551.38951-1-alistair@alistair23.me>
 <20211015122551.38951-3-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211015122551.38951-3-alistair@alistair23.me>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 15 Oct 2021, Alistair Francis wrote:

> Add a Kconfig name to the "Simple Multi-Functional Device support (I2C)"
> device so that it can be enabled via menuconfig.
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
>  drivers/mfd/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
