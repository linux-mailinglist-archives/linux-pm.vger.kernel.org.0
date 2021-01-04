Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE742E9D34
	for <lists+linux-pm@lfdr.de>; Mon,  4 Jan 2021 19:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbhADSjG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Jan 2021 13:39:06 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:51683 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbhADSjG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Jan 2021 13:39:06 -0500
Received: by mail-wm1-f50.google.com with SMTP id v14so183768wml.1;
        Mon, 04 Jan 2021 10:38:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C4a7e9iYEX7onVSgyKRCPpx3nNaq3txIA6JWld1n9j0=;
        b=eyyMcAPwsTmWf8+t+qq/e7sKhnU3+foQwTOdhyMYW7mjVlUAXAOF2TLqDMdQwGIsgK
         iH0GDO60Lcq/DThWOEUbt2PP8kbQSakaGE45ebYzA+T76TPOUuBCk7BLODyhdZAoBIS2
         ncEPXNMT0TRR1kXxKu/0EP51ttvzHYzcmjzTIdSFWbH0Um2NbTiMLg8Sg7fgbuCfsp0l
         MkrgIse8hAN6edMsM6mqq6Km38GhawePn5VW4rvWGf3vE32tEgNUergunJQ6JkwSEELU
         m3e2MtUYp5OFi4fYaV79KfM7QRcWJAI7KM5XeQEX+3zALMq0fEwMOtWYRxriTsuBG35p
         ClRg==
X-Gm-Message-State: AOAM530MUM7e/GVF8R3r3mgvvbYi00jfFT+5CHR13SrPS74hQoxTuPNB
        MPSS+tnAapsUvSf2+4xkWk0=
X-Google-Smtp-Source: ABdhPJxuVINeQEEmLpcBzfvhhDMMJibveqWeEQXqTuW3zW0q5F/SVBHRglAB6rgQYS/uGqGQA2u20Q==
X-Received: by 2002:a1c:2b46:: with SMTP id r67mr201271wmr.162.1609785503622;
        Mon, 04 Jan 2021 10:38:23 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id b83sm274815wmd.48.2021.01.04.10.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 10:38:22 -0800 (PST)
Date:   Mon, 4 Jan 2021 19:38:21 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Timon Baetz <timon.baetz@protonmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v6 2/8] regulator: dt-bindings: Document max8997-pmic
 nodes
Message-ID: <20210104183821.GA29033@kozik-lap>
References: <20201230205139.1812366-1-timon.baetz@protonmail.com>
 <20201230205139.1812366-2-timon.baetz@protonmail.com>
 <20210104135156.GB5645@sirena.org.uk>
 <20210104181825.GB27043@kozik-lap>
 <20210104182734.GH5645@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210104182734.GH5645@sirena.org.uk>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jan 04, 2021 at 06:27:34PM +0000, Mark Brown wrote:
> On Mon, Jan 04, 2021 at 07:18:25PM +0100, Krzysztof Kozlowski wrote:
> > On Mon, Jan 04, 2021 at 01:51:56PM +0000, Mark Brown wrote:
> 
> > > > +- charger: Node for configuring the charger driver.
> > > > +  Required properties:
> > > > +  - compatible: "maxim,max8997-battery"
> 
> > > > +  Optional properties:
> > > > +  - extcon: extcon specifier for charging events
> > > > +  - charger-supply: regulator node for charging current
> 
> > > > +- muic: Node used only by extcon consumers.
> > > > +  Required properties:
> > > > +  - compatible: "maxim,max8997-muic"
> 
> > > Why do these need to appear in the DT binding?  We know these features
> > > are there simply from knowing this is a max8997.
> 
> > If you refer to children nodes, then we do not know these entirely
> > because the features could be disabled (pins not connected).  In such
> > case these subnodes can be disabled and MFD framework will not
> > instantiate children devices.
> 
> We can indicate the presence of features without adding new compatible
> strings, that's just encoding the way Linux currently divides things up
> into the bindings.  For example having an extcon property seems like it
> should be enough to figure out if we're using extcon.

It won't be enough because MFD will create device for extcon and bind
the driver. The same for the charger. We have a board where max8997 is
used only as PMIC (providing regulators) without battery and USB
connectivity.

Another point, is that this reflects the real hardware. The same as we
model entire SoC as multiple children of soc node (with their own
properties), here we represent smaller chip which also has
sub-components.

Best regards,
Krzysztof
