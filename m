Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE6E2D5717
	for <lists+linux-pm@lfdr.de>; Thu, 10 Dec 2020 10:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388672AbgLJJ0Q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Dec 2020 04:26:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729784AbgLJJ0N (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Dec 2020 04:26:13 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D08C0613CF;
        Thu, 10 Dec 2020 01:25:29 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id d17so6324499ejy.9;
        Thu, 10 Dec 2020 01:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LKDlIegO8b/PUk6lqWTMXXqASk1SqEAKD63RKLvZ68w=;
        b=QMOZjz7wrgnL1MDa0Wnp4GVWcEVLDMYmZZNJYrAAMf7pNpxncqh50+6bZC8tedndNN
         dDDMUin/Qg/GNomEsC0jTp2jRAcm8HbCf+VHfG/6HNMI3waRQVzXDZC/NtRaSO0zScKO
         srrriiirZBYBIwU5ps2kko9A1J1QvWkT8Wav6ctiG4GKfxJ00JFTBmIktWBTrqXjLwwZ
         wtQ7DgviVF20uHazA9kmOrrzrM1rl/yhMU7TmqSWROyFyaV44X47PZKUG2zc6OcCHaU5
         c6i21LMhNb+Ys8geYVmYoqzcOgYjepj5/cLoxyMkzkkmTeqs9XZ8goKXGq2LH2H3yf0b
         l8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LKDlIegO8b/PUk6lqWTMXXqASk1SqEAKD63RKLvZ68w=;
        b=k1EMlFVl2m+OJ80uahpzz9QjxCot1S+QOr5cioy1UpgUt6qQ3b0aslqYGLjfHESrjn
         CJJZ+WGPGJMSlsLOW8CAc8GPBEXJHq/9xvjMdum1VjKJSAOa8xLPXIesEVZwwiLDrLMo
         BOAc9mWXm/dcixW7NohJda1kVKLGW48sjC6DKeNzE9llDFXSKlOLRN5tVKZB2YFm+vZ1
         +8liQjA81tnpl+7a4jxsCZH8hiHhjDbpztopzKwjDyC8mozk3+c7Gjq2OROdr7yaGoc4
         /heI6cKf8YLfFymAivpe/qTLIGk9sfwvJVO+DtX7bSFzGHD73qgI5U7+Vaz6GpmQIC1/
         wDvA==
X-Gm-Message-State: AOAM533n9tfz8QIHOi14FLUPCuak9iYAMBAixPMrjSzVvkhhbu7r3k6K
        FdGIS0ETaL+xRQy5Ef0vVM8=
X-Google-Smtp-Source: ABdhPJzcmcYNgXjJDk+3nXHFVvMB9YJWIvKD+ZhPsfGQCB5DoXUhwcQAPS3C3DFBZgIlfwIQK7kxlw==
X-Received: by 2002:a17:906:55d0:: with SMTP id z16mr5490933ejp.466.1607592328449;
        Thu, 10 Dec 2020 01:25:28 -0800 (PST)
Received: from ubuntu2004 ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id d13sm3788214ejc.44.2020.12.10.01.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 01:25:27 -0800 (PST)
Date:   Thu, 10 Dec 2020 11:25:35 +0200
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 1/7] dt-bindings: input: Add reset-time-sec common
 property
Message-ID: <20201210092535.GB322060@ubuntu2004>
References: <cover.1607216141.git.cristian.ciocaltea@gmail.com>
 <c08349db08db67e71cf428fe7fd53624aaa0acf8.1607216141.git.cristian.ciocaltea@gmail.com>
 <20201210040644.GC6466@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210040644.GC6466@thinkpad>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Mani,

On Thu, Dec 10, 2020 at 09:36:44AM +0530, Manivannan Sadhasivam wrote:
> On Sun, Dec 06, 2020 at 03:27:01AM +0200, Cristian Ciocaltea wrote:
> > Add a new common property 'reset-time-sec' to be used in conjunction
> > with the devices supporting the key pressed reset feature.
> > 
> > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> > ---
> > Changes in v3:
> >  - This patch was not present in v2
> > 
> >  Documentation/devicetree/bindings/input/input.yaml | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/input/input.yaml b/Documentation/devicetree/bindings/input/input.yaml
> > index ab407f266bef..caba93209ae7 100644
> > --- a/Documentation/devicetree/bindings/input/input.yaml
> > +++ b/Documentation/devicetree/bindings/input/input.yaml
> > @@ -34,4 +34,11 @@ properties:
> >        specify this property.
> >      $ref: /schemas/types.yaml#/definitions/uint32
> >  
> > +  reset-time-sec:
> > +    description:
> > +      Duration in seconds which the key should be kept pressed for device to
> > +      reset automatically. Device with key pressed reset feature can specify
> > +      this property.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +
> 
> Why can't you just use "power-off-time-sec"?

I think the common behavior of keeping the power button pressed is to
trigger a power off rather than a reset. Hence, per Rob's suggestion in
the previous revision of this patch series, I added the reset variant:
https://lore.kernel.org/lkml/20200908214724.GA959481@bogus/

Thanks,
Cristi

> Thanks,
> Mani
> 
> >  additionalProperties: true
> > -- 
> > 2.29.2
> > 
