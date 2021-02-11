Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEF2D3185C7
	for <lists+linux-pm@lfdr.de>; Thu, 11 Feb 2021 08:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbhBKHkH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Feb 2021 02:40:07 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41]:39519 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbhBKHkB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Feb 2021 02:40:01 -0500
Received: by mail-wm1-f41.google.com with SMTP id u14so4422907wmq.4;
        Wed, 10 Feb 2021 23:39:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Slvp0O5a2xW0GJAJWB769mdLBLRDIEx9/k/OPk1qyq4=;
        b=cC68LBYr4+ZcSKieQD0/ELHVXYjV5SBAkH9z0d7eVn0W4zu/i83a/tFVoeWCEe0loU
         ot5e2UPe+eQTXejQm2dKcE5pWx5V1oUPX9TxqitUpPfpFBlKkUAvrMnku0HHMy1EkANN
         RxriAMYYAUD7fN3+ocPDsV4ufnA4u/lhr9Ms/cL9rCbxW+chFL10nAxToNQ36G02GCbY
         OvlxHGEIf52mZEWcu6o+OVLPXf3uoPxPN+B0jbE+2mKtPxdHwMDVk/cpt3+Cbgsn2GsF
         hkUMxM/DOcJDdYSUy0qp1hAjyjw56J9kV23C6Dr0UkpRFbguk+s+UZ7czXprj99ny4az
         fleQ==
X-Gm-Message-State: AOAM5330dFhHAnFS3s+WlB2q1HT9VtWdIvLSGimagTiuA52lWtDCtQym
        ifh/pJfL3AlQV1CGpM7yKAE=
X-Google-Smtp-Source: ABdhPJzVTOoTs07kV3snqP5vt6nM5+VZaU78wa1lEsRAPeojg+oKlbGxjk5Brt02b4Igkbi4e4XTcA==
X-Received: by 2002:a05:600c:430a:: with SMTP id p10mr3597169wme.142.1613029158759;
        Wed, 10 Feb 2021 23:39:18 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id j71sm8445307wmj.31.2021.02.10.23.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 23:39:18 -0800 (PST)
Date:   Thu, 11 Feb 2021 08:39:16 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Timon Baetz <timon.baetz@protonmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/3] ARM: dts: exynos: Add charger supply for I9100
Message-ID: <20210211073916.apyqfins3x2q44yq@kozik-lap>
References: <20210130172747.2022977-1-timon.baetz@protonmail.com>
 <20210130172747.2022977-3-timon.baetz@protonmail.com>
 <20210211065850.1e4a8943.timon.baetz@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210211065850.1e4a8943.timon.baetz@protonmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Feb 11, 2021 at 05:59:04AM +0000, Timon Baetz wrote:
> On Sat, 30 Jan 2021 17:29:31 +0000, Timon Baetz wrote:
> > The regulator is used for charging control by max8997_charger driver.
> > 
> > Signed-off-by: Timon Baetz <timon.baetz@protonmail.com>
> > ---
> >  arch/arm/boot/dts/exynos4210-i9100.dts | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/exynos4210-i9100.dts b/arch/arm/boot/dts/exynos4210-i9100.dts
> > index 304a8ee2364c..dad950daafb4 100644
> > --- a/arch/arm/boot/dts/exynos4210-i9100.dts
> > +++ b/arch/arm/boot/dts/exynos4210-i9100.dts
> > @@ -384,6 +384,8 @@ pmic@66 {
> >  		pinctrl-0 = <&max8997_irq>, <&otg_gp>, <&usb_sel>;
> >  		pinctrl-names = "default";
> >  
> > +		charger-supply = <&charger_reg>;
> > +
> >  		regulators {
> >  			vadc_reg: LDO1 {
> >  				regulator-name = "VADC_3.3V_C210";
> 
> Now that the bindings have been accepted and integrated into linux-next,
> is anything else blocking this?

No, patch is fine. It's just too late in the cycle, so I'll take the
patch after merge window.

Best regards,
Krzysztof

