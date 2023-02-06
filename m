Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92BA68BF9D
	for <lists+linux-pm@lfdr.de>; Mon,  6 Feb 2023 15:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbjBFOJr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Feb 2023 09:09:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjBFOJd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Feb 2023 09:09:33 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E572620D33
        for <linux-pm@vger.kernel.org>; Mon,  6 Feb 2023 06:08:07 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id j32-20020a05600c1c2000b003dc4fd6e61dso10842949wms.5
        for <linux-pm@vger.kernel.org>; Mon, 06 Feb 2023 06:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=63FbMXrHnvr/mXxfnNiaGgvC6f2V9Ec37cTVHS6GGy8=;
        b=d4qoiTd/w/GXkJAEplSab84iZwfJhUKLODfoDrE3nJbWhZOgdFwifmvmvr+Bmwzxqc
         byxgxKovHjY8IDjqE8Ht2MvAeRE8pWaijnXpDAswjl9O/Xb7m+M8suBagdJpsKeNYIZG
         SzKZxuqtVOwpfCtgxJXY7cUFwUmSyE99TOG//W+q0rNq+R2ur7A3hIhyyVTDBgvEPmT4
         WtTVI78kyLPX2GQywXjKGOK0WHUQwrD7cQOuxOgp321t9Wp0YKZlDwz5/Sr6ZOnd7tu9
         Wa056N7SCsz88EAsaIE1rKK0tY2mQB6SMwdkbSHdud9lVDpWIQSWfomNb6dHx6OmZwO/
         x4yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=63FbMXrHnvr/mXxfnNiaGgvC6f2V9Ec37cTVHS6GGy8=;
        b=o1+7wHDCDMfXYCNH6bWNY2LeqFGMx2NsnZ1IujUCbg2sHWEino6OiCKlrDXk71KCPg
         9SFTTjxk5wTImAzac9+T6BgNL/ESiraU4TFiuHE3EvUtXHxRmxqYO7rrhOGjO5ADapAd
         4W+VX6iHijX4v/SfJj4O+dAHi67TDYZmHY7oY5pwfgh6TpyorH1Noyri0TQzlNP5HlN8
         gm8MwV9lgZRBTIu+YnTIx0G5BGhN9lEAggtyQK62ph+1s+GJL4Q+VpG5Yhg0j0p7VHVJ
         7OoC5IrNE5Ojqnugc8xrrPkPvVYGABFyM/g4q0YA4znMCB/CvP7YnrpfWhCeoKkVcXy2
         oAtw==
X-Gm-Message-State: AO0yUKWzQp7SAR03oTEJA7iTKWcWf+0Vu3hgY8ep3/H3eTFtspvYCkz6
        ANr8AfijfSZS2pnMVD3dKM0amw==
X-Google-Smtp-Source: AK7set/TdtA74eFvGRdYxYzvd4ZKtZvFhWEOzAAXv1InLpgvOTG5k3hLRNddq+oAvmj/I4LxwoFEKw==
X-Received: by 2002:a05:600c:1c0e:b0:3d0:6a57:66a5 with SMTP id j14-20020a05600c1c0e00b003d06a5766a5mr19373315wms.0.1675692436728;
        Mon, 06 Feb 2023 06:07:16 -0800 (PST)
Received: from linaro.org (wifi-eduroam-trans.univ-tlse3.fr. [195.220.58.237])
        by smtp.gmail.com with ESMTPSA id ip20-20020a05600ca69400b003dd19baf45asm10543114wmb.40.2023.02.06.06.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 06:07:16 -0800 (PST)
Date:   Mon, 6 Feb 2023 15:07:13 +0100
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     bchihi@baylibre.com, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
Subject: Re: [PATCH v12] thermal: drivers: mediatek: Add the Low Voltage
 Thermal Sensor driver
Message-ID: <20230206140713.GB15176@linaro.org>
References: <20230124131717.128660-5-bchihi@baylibre.com>
 <20230131153816.21709-1-bchihi@baylibre.com>
 <ab1e4822-d5f4-79f6-ea38-47e2342ebe49@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab1e4822-d5f4-79f6-ea38-47e2342ebe49@linaro.org>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Feb 01, 2023 at 08:55:07AM +0100, Krzysztof Kozlowski wrote:
> On 31/01/2023 16:38, bchihi@baylibre.com wrote:
> > From: Balsam CHIHI <bchihi@baylibre.com>
> > 
> > The Low Voltage Thermal Sensor (LVTS) is a multiple sensors, multi
> > controllers contained in a thermal domain.
> > 
> > A thermal domains can be the MCU or the AP.
> > 
> > Each thermal domains contain up to seven controllers, each thermal
> > controller handle up to four thermal sensors.
> > 
> > The LVTS has two Finite State Machines (FSM), one to handle the
> > functionin temperatures range like hot or cold temperature and another
> > one to handle monitoring trip point. The FSM notifies via interrupts
> > when a trip point is crossed.
> > 
> 
> (...)
> 
> > +
> > +struct lvts_domain {
> > +	struct lvts_ctrl *lvts_ctrl;
> > +	struct reset_control *reset;
> > +	struct clk *clk;
> > +	int num_lvts_ctrl;
> > +	void __iomem *base;
> > +	size_t calib_len;
> > +	u8 *calib;
> > +};
> > +
> > +#ifdef CONFIG_MTK_LVTS_THERMAL_DEBUGFS
> > +
> > +static struct dentry *root;
> 
> How do you handle two instances of driver?

For now, we can put the entry in /sys/kernel/debug/<dev_name>

I'm preparing a debugfs series for the thermal framework and that will provide
an entry to hook in for the sensors debugfs if available
