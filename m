Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98B71FF938
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jun 2020 18:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbgFRQ26 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jun 2020 12:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729077AbgFRQ2y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jun 2020 12:28:54 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221D4C0613ED
        for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2020 09:28:53 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h5so6738463wrc.7
        for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2020 09:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=5BtInqn0HK3LhGSOqpzcc+VvzjO2vK+SIfcb8Zyst/s=;
        b=odevfLHS7udDSNGRylCeO2GK+VEz1OY9+pY2RckNxWlzBCRG2hlFpNf6+gr8PKu4Iv
         tj1G1Vcxfz9LG+ygke6gIxql+cjGYpQ1mY6VdpdPlChpWDonM3PefuwcFBoJfWjZV/o+
         CR6xRglkdlXJoE51Sz7C2YMHN+mc9IwFc7P9kBuZck3wBty1M5Su/3/dhyDCecbVI5aH
         leQZVIOvdX1cwxW42QZRnwUFG7hLl7P7CljP2Km/bqlU2XWuvtEPLbskejDHm//uKQlz
         2IYDidYF2v8ay1rj1c0D9+gwTeVaMxh7naQQ8/I3zIQApSSo49rOYomcAMVweMTcXx1j
         U0VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5BtInqn0HK3LhGSOqpzcc+VvzjO2vK+SIfcb8Zyst/s=;
        b=oqe4bnbB8Omt2tCzW5APvgO595x+TgyDz6GUHX2B7QcE0wul/7n38WiLGw+kv4cVH+
         3DVMfFc/B2eSI/1u0ct/z7MeNao1si4TGn9IWO/1jtvIQ+HvONBPolUlfKnzbIOglaS2
         1YBMOqZFHU663OhS8ZBdF2b9Hw4C3jkroicGBA6fZ/hI0Vj80Vhe9Hpx9D+3velGJqfU
         UpQmeptnL9AzHI9cBo9IyAD88630LaRWW8XgDv1yQphHCdEZ+/nrdd9mo7k7eJGrJIpd
         1Qf2VEDTo2EXGyYR3Y/VPSCvQAIF5Lx9pM4Efp2yPaQRrNa/Sbdm9UprAONoVas5ShYu
         3t9w==
X-Gm-Message-State: AOAM530XfgglyMO7138YsE9F+ioNMonJp0+EZgDmjmYTwK9rCEt32pIe
        AITukaaoQ6nrxuALIinIKz+SUg==
X-Google-Smtp-Source: ABdhPJz6qa2JKgQLkPKOqwNTFZMVh3JmnZ6aw7y5et5eRtOtT3vbCB5EdZXzl9SVv6nhMcSGytpKjQ==
X-Received: by 2002:adf:ec42:: with SMTP id w2mr5505499wrn.269.1592497731532;
        Thu, 18 Jun 2020 09:28:51 -0700 (PDT)
Received: from dell ([95.149.164.118])
        by smtp.gmail.com with ESMTPSA id z7sm3185948wmb.42.2020.06.18.09.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 09:28:50 -0700 (PDT)
Date:   Thu, 18 Jun 2020 17:28:49 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: [PATCH v4 1/2] thermal: add support for the MCU controlled FAN
 on Khadas boards
Message-ID: <20200618162849.GH954398@dell>
References: <20200618133818.15857-1-narmstrong@baylibre.com>
 <20200618133818.15857-2-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200618133818.15857-2-narmstrong@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 18 Jun 2020, Neil Armstrong wrote:

> The new Khadas VIM2 and VIM3 boards controls the cooling fan via the
> on-board microcontroller.
> 
> This implements the FAN control as thermal devices and as cell of the Khadas
> MCU MFD driver.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

Is this an Ack?

If so, do you require a pull-request?

> ---
> Hi Lee,
> 
> Could you apply this patch via the MFD tree since it depends on
> the linux/mfd/khadas-mcu.h header ?
> 
> This patch is unchanged from the v3 serie.
> 
> Thanks,
> Neil
> 
>  drivers/thermal/Kconfig          |  11 ++
>  drivers/thermal/Makefile         |   1 +
>  drivers/thermal/khadas_mcu_fan.c | 174 +++++++++++++++++++++++++++++++
>  3 files changed, 186 insertions(+)
>  create mode 100644 drivers/thermal/khadas_mcu_fan.c

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
