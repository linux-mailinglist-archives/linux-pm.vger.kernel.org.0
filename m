Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 212512CB629
	for <lists+linux-pm@lfdr.de>; Wed,  2 Dec 2020 09:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387671AbgLBIEI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 2 Dec 2020 03:04:08 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37265 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387654AbgLBIEI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Dec 2020 03:04:08 -0500
Received: by mail-ed1-f68.google.com with SMTP id cm17so2379955edb.4;
        Wed, 02 Dec 2020 00:03:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=OocYqlgK4Xylu28gCNjsvAAgZTXFJDhCWyTcVhq/Gf0=;
        b=YFxb233cU8AYdsjTWSjDlD99uxchlvaZWFID/9fUWTw1S2kZlUI/CPT04wWajZeetw
         fxqwVXzbEvUDjci6FQ0aNTK5e5lTGGi2vK8H7SICMa+CXBtRJ4hexVLfJNOsgivkugfZ
         aTHjsbbzvVqsFsl/np+BntBoge2YpnkJ2fHsbLR0kQl4J6agiOC0eN0vQF1RNkuTfJy4
         yQ0ekMoqNWMWnglhHaOaLjtJDhiFdZ55d1kH7OeY7wYw4FbFymwr6lU8ihPRtENSNK+a
         JcAOGn25ivldlMyQ/xBil2ebMDcy2DWPYf8mS8vOscDkHLFM5M7ZOqbdgmgjP0qYtgON
         GtKw==
X-Gm-Message-State: AOAM531Rrbx3dHFTlxOPF0tFfgdsv21xx8WFcm5nbCNdnPpvtFYEqogS
        ZDnxOimmX/Y0w0vYY1cyvS8=
X-Google-Smtp-Source: ABdhPJw09kO5E6ZqipbMcWG/198iG6louqdNHvYOkFPS12KQksTNhoH33CmZ/9lXOdRCmBwoYQI0DQ==
X-Received: by 2002:a50:bc06:: with SMTP id j6mr1526771edh.150.1606896205968;
        Wed, 02 Dec 2020 00:03:25 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id t19sm568524eje.86.2020.12.02.00.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 00:03:25 -0800 (PST)
Date:   Wed, 2 Dec 2020 10:03:21 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>, robh@kernel.org,
        shawnguo@kernel.org, festevam@gmail.com, catalin.marinas@arm.com,
        will@kernel.org, cdleonard@gmail.com, kernel@pengutronix.de,
        linux-imx@nxp.com, kernel@puri.sm, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 7/7] arm64: defconfig: Enable interconnect for imx8mq
Message-ID: <20201202080321.GB6087@kozik-lap>
References: <20201201123932.12312-1-martin.kepplinger@puri.sm>
 <20201201123932.12312-8-martin.kepplinger@puri.sm>
 <cb498c2c-e052-390a-c64a-2be44d1d2b42@linaro.org>
 <a2c0fae4-13c5-9114-876f-bc324138e6cc@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <a2c0fae4-13c5-9114-876f-bc324138e6cc@puri.sm>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Dec 01, 2020 at 02:15:04PM +0100, Martin Kepplinger wrote:
> On 01.12.20 14:10, Georgi Djakov wrote:
> > On 1.12.20 14:39, Martin Kepplinger wrote:
> > > Enable INTERCONNECT_IMX8MQ in order to make interconnect more widely
> > > available for testing.
> > 
> > I hope that it's not just for testing, but using it.
> 
> sure, I just think that most people will use their own config for production
> but that's a different story. I can rephrase.
> 
> > 
> > > Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> > > ---
> > >   arch/arm64/configs/defconfig | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> > > index 1fed16950a7c..830c26a95b3d 100644
> > > --- a/arch/arm64/configs/defconfig
> > > +++ b/arch/arm64/configs/defconfig
> > > @@ -1023,7 +1023,8 @@ CONFIG_OPTEE=y
> > >   CONFIG_MUX_MMIO=y
> > >   CONFIG_SLIM_QCOM_CTRL=m
> > >   CONFIG_SLIM_QCOM_NGD_CTRL=m
> > > -CONFIG_INTERCONNECT=y
> > 
> > Why are you removing this line?
> 
> savedefconfig removes it. INTERCONNECT_IMX below depends on it.

It's save to remove it as other Interconnect options are directly
dependant.

Best regards,
Krzysztof

