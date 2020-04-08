Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A35A1A1E9C
	for <lists+linux-pm@lfdr.de>; Wed,  8 Apr 2020 12:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgDHKOP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Apr 2020 06:14:15 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55752 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727916AbgDHKON (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Apr 2020 06:14:13 -0400
Received: by mail-wm1-f67.google.com with SMTP id e26so4540195wmk.5
        for <linux-pm@vger.kernel.org>; Wed, 08 Apr 2020 03:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=25069VDYosEmyzjyjgB1Fr18hxU9v2CBSXz/PzXbBl8=;
        b=qH2Gq9ofUudA1pSW/odMa2/8M3XmMMz4UqX2oplXnZzl9Zo6pq3fFKvWczVldbcoE3
         rCblbFO7EivrifQ0yexwYerKq5cUSFOuFmSsm+ChZxBrayh9ItBM00FDUsvaif0CzZUT
         yXwnsYgQPkmmQec1o15WiCKzl7gZ5VKsbTqCIqd3B+4Vp56sx080HaaB3XlU92ixc7j+
         lxi3bHPtjS9RgyNojZsXRodNFPBF4XYPZQdnvvXcwz+1uGfrkDexovaZic2rcBwRZ8ii
         3QNtzuH4yGE4hmhzJEFo6vFePo89Z8YhFrjA40dtu/+8URe59utwIJ0kIMFqkLvlzLB5
         qsaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=25069VDYosEmyzjyjgB1Fr18hxU9v2CBSXz/PzXbBl8=;
        b=TzKDDq+JLN5BxPGKf7d0yVJz0v0868F+pBxt4Ud6foA5I1QBr4Ua36M4fla5a677pR
         CioURDejoIG2vKFctPbKOHtAgt5ivAYbMfQuhQ2laLqHPiDl1dze5sH6SQZsPwa17CUk
         a0CXdSRXIg3zGqxH7CKWeMlq+/x7iG2caIKOeycfNUN7/VBQsmVmAqb49WyxekD0sEIU
         Labhk+WEfhTKuI5phkBxcGTm559RHA7ox4qWPOLkHSWFp6iVs9gX/KMai3b/s9M3FWFC
         4T+7pOtTxDzJ279trjUKhRRne1h+w4E1M5NkUVZVH04+O0JWciaRDl8nV34myFWRlzy1
         Lnwg==
X-Gm-Message-State: AGi0PubCwnLRU1zcolljYCF5/uPhkgQqJk/lpsPz9wjKPz98vbC1bNq0
        vvvHiiYWbxOOcjuuhSSvYI5v0g==
X-Google-Smtp-Source: APiQypJXilSL/A+a4hF27py3ApM+n04W/ugNsSh5QoeD0Hyiw1yKokhPBGveos7hrHjep9MKgM7opA==
X-Received: by 2002:a05:600c:2c06:: with SMTP id q6mr3967744wmg.42.1586340850731;
        Wed, 08 Apr 2020 03:14:10 -0700 (PDT)
Received: from dell ([2.31.167.253])
        by smtp.gmail.com with ESMTPSA id y7sm33984899wrq.54.2020.04.08.03.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 03:14:10 -0700 (PDT)
Date:   Wed, 8 Apr 2020 11:15:06 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     saravanan sekar <sravanhome@gmail.com>
Cc:     robh+dt@kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, sre@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 1/5] dt-bindings: mfd: add document bindings for mp2629
Message-ID: <20200408101506.GI30614@dell>
References: <20200322224626.13160-1-sravanhome@gmail.com>
 <20200322224626.13160-2-sravanhome@gmail.com>
 <20200327080013.GG603801@dell>
 <d449b567-bd5c-168d-83af-5ba38771f75a@gmail.com>
 <20200330064630.GA30614@dell>
 <e4412378-1423-a48e-9176-f0d48f6000c4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e4412378-1423-a48e-9176-f0d48f6000c4@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 07 Apr 2020, saravanan sekar wrote:

> Hi Lee,
> 
> On 30/03/20 8:46 am, Lee Jones wrote:
> > On Fri, 27 Mar 2020, saravanan sekar wrote:
> > > On 27/03/20 9:00 am, Lee Jones wrote:
> > > > On Sun, 22 Mar 2020, Saravanan Sekar wrote:
> > > > 
> > > > > Add device tree binding information for mp2629 mfd driver.
> > > > > 
> > > > > Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> > > > > ---
> > > > >    .../devicetree/bindings/mfd/mps,mp2629.yaml   | 60 +++++++++++++++++++
> > > > >    1 file changed, 60 insertions(+)
> > > > >    create mode 100644 Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
> > > > > 
> > > > > diff --git a/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml b/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
> > > > > new file mode 100644
> > > > > index 000000000000..314309ea91ac
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
> > > > > @@ -0,0 +1,60 @@
> > > > > +# SPDX-License-Identifier: GPL-2.0
> > > > > +%YAML 1.2
> > > > > +---
> > > > > +$id: http://devicetree.org/schemas/mfd/mps,mp2629.yaml#
> > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > Are these links supposed to work?
> > > Not really, but as far my understanding needed for dt-bindings check
> > Rob, why are these here if they just result in 404s?
> > 
> > > > > +examples:
> > > > > +  - |
> > > > > +    #include <dt-bindings/interrupt-controller/irq.h>
> > > > > +    #include <dt-bindings/input/linux-event-codes.h>
> > > > > +    i2c {
> > > > i2c@0x????????
> > > Its a I2C controller node, I don't think address is needed. Mention like
> > > this my previous other driver patches,
> > This doesn't sound right.
> > 
> > How do you control/operate the controller?
> > 
> > Surely you read/write from/to registers?
> 
> 
> Indeed, but each SoC will have different address so which address to mention
> here.
> For me it should be like &i2c {}, anyhow I respect maintainers review (I can
> give RPi I2c bus address used for testing)
> and wait for Rob's reply

It's only an example.  It doesn't have to match any real H/W.

> > > dt_binding_check is also passed
> > > 
> > > > > +        #address-cells = <1>;
> > > > > +        #size-cells = <0>;
> > > > > +
> > > > > +        pmic@4b {
> > > > > +            compatible = "mps,mp2629";
> > > > > +            reg = <0x4b>;
> > > > > +
> > > > > +            interrupt-controller;
> > > > > +            interrupt-parent = <&gpio2>;
> > > > > +            #interrupt-cells = <2>;
> > > > > +            interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
> > > > > +        };
> > > > > +    };

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
