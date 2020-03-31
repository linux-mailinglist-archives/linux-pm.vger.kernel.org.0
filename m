Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF8E719A080
	for <lists+linux-pm@lfdr.de>; Tue, 31 Mar 2020 23:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbgCaVNx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Mar 2020 17:13:53 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:33792 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728245AbgCaVNx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Mar 2020 17:13:53 -0400
Received: by mail-il1-f194.google.com with SMTP id t11so20949620ils.1;
        Tue, 31 Mar 2020 14:13:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4ULdlzKgkks3OW2EmDmbFExkJ0r2q+fNhmp2tVhb4l8=;
        b=mBMHN3RgIkb2ey/0pcJknlUmKuQaciIUmzkBGREGKheGptj3Yq7lsefvbQCLr1sxcj
         LXHN/PyxU5WirqyBwVbB+MGzUd5oJ6NXoghPe0+vtSywVSv3rFBLwgkg+is/TcXM2Z1T
         XE5rbukpgjSAVT8ZFpz9um+0UpRF61kap/JD8e4QpZlMFxZqjQn4Bs4QTqXxcQvXBpXJ
         laz0Fpp+1i5BIIj4/yZkmEGezJ/lpr+fVd9GGiySU0Ev1zXWa4bwmeo8bPYGMd8HAfss
         +UY7NtdPFhpx2gF+5ewGPhRUtxxi7rT/HC5KOycS95OM6kgZiD2XSPjTjub1rIn8wNQs
         7gNQ==
X-Gm-Message-State: ANhLgQ3XBkwrLmvJEjocXJevI5ZTEyWvWbAhgF4KaD1UiCXr4dyU0T1i
        bWzR4e3xdI22pIpTVMElFQ==
X-Google-Smtp-Source: ADFU+vtI4U220QGuNWyV94ZFCn12h5H69QS17f+/gpWqZrqPKyCEIRebwpyd92V6x0A2F+AHZF0ssA==
X-Received: by 2002:a92:da4a:: with SMTP id p10mr17457677ilq.34.1585689231749;
        Tue, 31 Mar 2020 14:13:51 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id f20sm7989ilf.64.2020.03.31.14.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 14:13:50 -0700 (PDT)
Received: (nullmailer pid 29775 invoked by uid 1000);
        Tue, 31 Mar 2020 21:13:49 -0000
Date:   Tue, 31 Mar 2020 15:13:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] dt-bindings: thermal: Add yaml bindings for
 thermal zones
Message-ID: <20200331211349.GA18149@bogus>
References: <cover.1585117436.git.amit.kucheria@linaro.org>
 <9c447186008ef2e3f4c3e712458dc0ddcd8a8b03.1585117436.git.amit.kucheria@linaro.org>
 <81b0cbe1-23c8-b4a3-4775-62e7d6c49b6b@arm.com>
 <CAP245DWS=yqNQpbk3Y8_0KjcBurSyQbNW9jqepSz8LC=ruFWhA@mail.gmail.com>
 <CAHLCerMRcPmE70kN1Cyxio4_Dd1OoWT3iZ4vpzYKQVfORS336Q@mail.gmail.com>
 <693bda26-1eed-a886-2ce0-7b3a2ca410d2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <693bda26-1eed-a886-2ce0-7b3a2ca410d2@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Mar 30, 2020 at 03:07:53PM +0200, Daniel Lezcano wrote:
> 
> Hi Amit,
> 
> On 30/03/2020 12:34, Amit Kucheria wrote:
> 
> [ ... ]
> 
> >>> I don't know why it's not consistent with the actual code in
> >>> of-thermal.c, where there is even a comment stated: /* For now,
> >>> thermal framework supports only 1 sensor per zone */
> >>>
> >>> I think this is the place where developers should be informed
> >>> about the limitation and not even try to put more sensors into
> >>> the list.
> >>
> >> That is a good point. I'm currently "porting" the existing
> >> binding as described in thermal.txt to yaml. If you look at some
> >> of the example (c) in there, the bindings allow many sensors to a
> >> zone mapping but the thermal core doesn't implement that
> >> functionality.
> >>
> >> So should we fix the core code or change the bindings? Thoughts -
> >> Rob, Daniel, Rui?
> >
> > Rob, Daniel: Any comments? We don't have any concerns for Linux
> > backward compatibility since multiple sensors per zone isn't used
> > anywhere. But asking since bindings are supposed to be
> > OS-agnostic.
> 
> IMO, we should remove it as it is not used anywhere.
> 
> We still have to decide how we aggregate multiple sensors.

The schema only needs to pass what currently exists (assuming no 
errors), so extending it later is fine with me.

Rob
