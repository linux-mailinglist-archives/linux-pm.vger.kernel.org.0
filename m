Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8EB158D968
	for <lists+linux-pm@lfdr.de>; Tue,  9 Aug 2022 15:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242624AbiHINdz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Aug 2022 09:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237342AbiHINdy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Aug 2022 09:33:54 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3707719018
        for <linux-pm@vger.kernel.org>; Tue,  9 Aug 2022 06:33:53 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id a18-20020a05600c349200b003a30de68697so724195wmq.0
        for <linux-pm@vger.kernel.org>; Tue, 09 Aug 2022 06:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=qDs3v/+2gBoPPTdjMsAIc3WC8rX3YXkWxxonQKGl4/w=;
        b=KXL2NUWmqPFko1XMcwYNAF4yLqrFdYZ7RUQo+B+ik3rzRGdaZDhSjTb1RZuaxEUFLx
         TJhTj6a87LkmuY67UEMMkfqawtVRA8wd/vp+KeZJfGfeRDwLGp6cORXFWRNmZ2Rs7vlG
         428ZrWeyxSXsHKH16eDUE3abwgJoNTbbMqm4WtkS3lNsIOLtSObFCKtE16h/brgAO4Tx
         DEfNDXI+qNcvGGfXUbLBZZdYFfwYzQjGPsQJmnOnfSmOcZ5r/SzJRvuQdV8e/a8aQasE
         /V7TDBSIsSpUQXvQyblVgN5tfNCkoE/kisoTB3alYsIbpLzCCbsLkZylILz8ayfQTjVs
         vU0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=qDs3v/+2gBoPPTdjMsAIc3WC8rX3YXkWxxonQKGl4/w=;
        b=Z1dcI95OdF79Z9fDCTktQrtiIshw6RL5WzycwYIG1d/krMR2mx0/a4AYTNlzzsgAFS
         TXLT8cm0uaZosGe6a0FmKOPhhy/zo+nuVjqlx1lWFDb7mwuImhZt4xS8/ZQ6K/XwYrRf
         pp5M1K+LChotxMIpc3yGIWEF9CaaRUHlzJDg/3oGDGGa28btsBnF+TLWaXO+K0+dS2Mt
         V47pwyYxRGRciW074J2E7TCeqTCepN9BdHaUALhAT8Oh8+BymJLNncS0Nt2TQs67y/yo
         pzFzMNjtN1lvgJigAqTKcMEWYA6WLTyl1uqPxHYWtNZh2I8yPQ5F4CRRZRdQEY+Y/bvk
         rAfQ==
X-Gm-Message-State: ACgBeo3xgC3guHMo6oA1OI3Fjsag901JuWCTBRAQUl600Vo8ps3RVzEY
        I+FCb4skgkhn50vzR1AF5L+KBw==
X-Google-Smtp-Source: AA6agR5Vw/hb9AVtINItYDqXRX7S16jDBHR9oXX97sa2DaTwoEP2cNEyV2erhdztP6VJgZ5ukYQEwg==
X-Received: by 2002:a05:600c:a02:b0:39c:97cc:82e3 with SMTP id z2-20020a05600c0a0200b0039c97cc82e3mr20753390wmp.97.1660052031819;
        Tue, 09 Aug 2022 06:33:51 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id k30-20020a05600c1c9e00b003a38606385esm2261133wms.3.2022.08.09.06.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 06:33:51 -0700 (PDT)
Date:   Tue, 9 Aug 2022 14:33:48 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        kernel@pengutronix.de, s.hauer@pengutronix.de,
        alistair23@gmail.com, linux-arm-kernel@lists.infradead.org,
        andreas@kemnade.info, amitk@kernel.org, shawnguo@kernel.org,
        linux-kernel@vger.kernel.org, geert@linux-m68k.org,
        linux-hwmon@vger.kernel.org, linux-imx@nxp.com, linux@roeck-us.net,
        rui.zhang@intel.com, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v21 1/4] mfd: silergy,sy7636a: Add config option
Message-ID: <YvJiPM0Ak1Z34Bog@google.com>
References: <20220525115554.430971-1-alistair@alistair23.me>
 <20220525115554.430971-2-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525115554.430971-2-alistair@alistair23.me>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 25 May 2022, Alistair Francis wrote:

> Add a specific MFD_SY7636A config option.
> 
> As part of this change we can use MFD_SY7636A as a dependency for all
> SY7636a components and also remove the name from MFD_SIMPLE_MFD_I2C as
> it no longer needs to be selectable.
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/Kconfig     |  1 +
>  drivers/mfd/Kconfig       | 12 +++++++++++-
>  drivers/regulator/Kconfig |  1 +
>  3 files changed, 13 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
DEPRECATED: Please use lee@kernel.org
