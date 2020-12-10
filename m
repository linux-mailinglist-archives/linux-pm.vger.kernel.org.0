Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6E62D567C
	for <lists+linux-pm@lfdr.de>; Thu, 10 Dec 2020 10:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388740AbgLJJOa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Dec 2020 04:14:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388739AbgLJJO1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Dec 2020 04:14:27 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4698C0613CF;
        Thu, 10 Dec 2020 01:13:46 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id ce23so6275006ejb.8;
        Thu, 10 Dec 2020 01:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=K+DVSHiJnzRZk+oC9MjBKUhPYmCnDv5TwhJVFqHuLvw=;
        b=dMxloizdshy/7FS/gyC+DwjY773aXJWiR6E3hIPwI2UZ6HraMFvRXf4gnmzgrcuuuq
         aGDDXpcGeWuzr2i+NCNzZdRpjjE6I2VH7Yrt0IWATEHPV3Z4D5rg6171Uf9Rd0bCCGG0
         fv89bvWIwwA5szQJOkVzJe7qqBWWy54SO52dslwl/fe3hVuCfW7efcSvL7Kjt2N9t8CT
         i8gn05ALX8rUVW/682O/kFFKsfs5RFGyEFTwcfF//AcYjVJTYB6TWNvky5bwkCa9u7u/
         wlbOA7KKry5wZnI0QTzaDKxEQvQwQSAbEMBDzU12iDzLIQVQ5uX+6mU938hCD3f3lGkb
         k1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K+DVSHiJnzRZk+oC9MjBKUhPYmCnDv5TwhJVFqHuLvw=;
        b=rxVaNvTwTqFIUwbosbdtoiAsaXGCu0vPDF/pKoKaa02tjVAK1S4JrXDXuqqRbwyFMb
         n7hBb5URCpOxZ3rYvdpXMTaG+LU6mbhrNrvnSrHUOKiPR5ubtz3prtz8YrEH0vcP1bn0
         +UeDh1zrrigfkzP0K5oLDgJj6soLOaaawy4gLVgxkmfAFbm8MA4BZmK8njbCeA/kLW0E
         xlGjWthUFzhooSG6eVSZe0TmHTP2RkzEFQzIGW3nkHlQrYWre6PP0so52++zHnElx/wQ
         JmDcquSQND+VkQmSw68Mn3M/COfVWkLtdWLJfF26jwM4vtVX0K2UiR8CJtJlUsEt5VzF
         x4Vg==
X-Gm-Message-State: AOAM530OiqXpHdO32GrCxjNsgB7AoAO0ygWjs5gwgqK8xF7NOgMTUKxZ
        4M5NXNag/C4nTMZ1JUrC500=
X-Google-Smtp-Source: ABdhPJyNXDZ32NmWN6+Z8+njhTkuV2Ml/7gZFPwYAnmn16+mjzEw8JhzQfvzvzrEgPEYYTjfgoTICw==
X-Received: by 2002:a17:907:c10:: with SMTP id ga16mr5498230ejc.43.1607591625448;
        Thu, 10 Dec 2020 01:13:45 -0800 (PST)
Received: from ubuntu2004 ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id r24sm4236984edo.4.2020.12.10.01.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 01:13:44 -0800 (PST)
Date:   Thu, 10 Dec 2020 11:13:50 +0200
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 1/7] dt-bindings: input: Add reset-time-sec common
 property
Message-ID: <20201210091350.GA322060@ubuntu2004>
References: <cover.1607216141.git.cristian.ciocaltea@gmail.com>
 <c08349db08db67e71cf428fe7fd53624aaa0acf8.1607216141.git.cristian.ciocaltea@gmail.com>
 <20201210033708.GA1606132@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210033708.GA1606132@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rob,

On Wed, Dec 09, 2020 at 09:37:08PM -0600, Rob Herring wrote:
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
> 
> Humm, I'm pretty sure we already have something for this. Or maybe just 
> power off.

We only have 'power-off-time-sec', so I added 'reset-time-sec' according
to your review in v2:
https://lore.kernel.org/lkml/20200908214724.GA959481@bogus/

Thanks,
Cristi

> > +    description:
> > +      Duration in seconds which the key should be kept pressed for device to
> > +      reset automatically. Device with key pressed reset feature can specify
> > +      this property.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +
> >  additionalProperties: true
> > -- 
> > 2.29.2
> > 
