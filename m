Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69A2CF8D47
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2019 11:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbfKLKut (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Nov 2019 05:50:49 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53625 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfKLKus (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Nov 2019 05:50:48 -0500
Received: by mail-wm1-f65.google.com with SMTP id u18so2574984wmc.3
        for <linux-pm@vger.kernel.org>; Tue, 12 Nov 2019 02:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=oVTOrGv6UqAshczVJh0uIxd2QUj4yR+TP/qwy/D72SM=;
        b=f8V7u5XaxhR9Me0u6H7YtB0JnVoZVlTyw6B8RiXS/gTTtZ4CWkSpQ2IiZLvZVy4WpP
         zFZ3n/4eGnepya+KaNmjmsnXiTwqyYYPaUmJa7zRNAIVQy/I5rZMv7M6ifl1jn9oan+D
         dXDKo5OTFO1RQNayUm84HUzJ7lI2NF47P8YEdtsO4h6C6VnH4dmDbe7neD35ryHozTv/
         pHlcAp4kNoV9hhwdCszMrCcUGbSZ9L48phiqc8ns33jbww8qBJTC9RIVVTwxyomKBvER
         3vMnrSbzoscX1WuxRx+vllfYiSQ2WK360cB1P/WGDYtAmcHFDYJk+Ve7yHWoQgJIi+Hm
         0A6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=oVTOrGv6UqAshczVJh0uIxd2QUj4yR+TP/qwy/D72SM=;
        b=YUVQC4fZWgCMF05NkzeK6tVIKltL8M6Xu5z8u3iY6/nHHxlmVPyGA0aOwBWYtSQkJ4
         vIE9U6LEzwRZqyQ77BGP9/NhGFmjOuo+VYedCte3MhWsLBXAKVjBhV11ak4uRc9BtWhu
         SpWVhzNq59JoKoDhOosJwUN89bGFF/E6tFvHz55APHb4Vhcx2chiz8ipHZLPE4LGkuZt
         VngxZXdnZhVh3QmH0OPIA7aIIY8SMMVFtx5POS3aLXqEPSnzAQzVCbSQqmU4Km+oxgNP
         lH3zjcCCW1pCN3qZJFMIxHOW+kDcM/cuubc2VtYtT6GhRb+Tjq09A96XCHoTbm49McbN
         DnYQ==
X-Gm-Message-State: APjAAAVhPryv5k8mxYG5Q0LQfKf1osdu2GJGZ8vPmQSgfr0t/9qyhYqX
        LW3nfxK9zsxmd78IBNmhouMUag==
X-Google-Smtp-Source: APXvYqzi4Qu1un8C1gnUD1abl4YeesyzYmNoALTno3QELDH6+WaB67VPZdDZciPvbJDd/FbnG7cWXQ==
X-Received: by 2002:a7b:ca51:: with SMTP id m17mr3133879wml.110.1573555845148;
        Tue, 12 Nov 2019 02:50:45 -0800 (PST)
Received: from dell ([2.27.35.135])
        by smtp.gmail.com with ESMTPSA id b66sm3967527wmh.39.2019.11.12.02.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 02:50:44 -0800 (PST)
Date:   Tue, 12 Nov 2019 10:50:35 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v4 5/6] dt-bindings: mfd: max77650: convert the binding
 document to yaml
Message-ID: <20191112105035.GR3218@dell>
References: <20191021124428.2541-1-brgl@bgdev.pl>
 <20191021124428.2541-6-brgl@bgdev.pl>
 <20191111080837.GF18902@dell>
 <CAMRc=Me_b5c_e+qZ1s=TgTh7k_bQqrqthC8VTb7ak8+3AOEugg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Me_b5c_e+qZ1s=TgTh7k_bQqrqthC8VTb7ak8+3AOEugg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 11 Nov 2019, Bartosz Golaszewski wrote:

> pon., 11 lis 2019 o 09:08 Lee Jones <lee.jones@linaro.org> napisał(a):
> >
> > On Mon, 21 Oct 2019, Bartosz Golaszewski wrote:
> >
> > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > >
> > > Convert the binding document for MAX77650 core MFD module to YAML.
> > >
> > > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > ---
> > >  .../devicetree/bindings/mfd/max77650.txt      |  46 ------
> > >  .../devicetree/bindings/mfd/max77650.yaml     | 149 ++++++++++++++++++
> > >  2 files changed, 149 insertions(+), 46 deletions(-)
> > >  delete mode 100644 Documentation/devicetree/bindings/mfd/max77650.txt
> > >  create mode 100644 Documentation/devicetree/bindings/mfd/max77650.yaml
> >
> > Applied, thanks.
> >
> 
> Hi Lee,
> 
> FYI this series is already in next through Rob's DT tree.

Why don't I see an 'applied' email?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
