Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1842D262661
	for <lists+linux-pm@lfdr.de>; Wed,  9 Sep 2020 06:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbgIIEfV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Sep 2020 00:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgIIEfT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Sep 2020 00:35:19 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF71C061756
        for <linux-pm@vger.kernel.org>; Tue,  8 Sep 2020 21:35:18 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id q4so701231pjh.5
        for <linux-pm@vger.kernel.org>; Tue, 08 Sep 2020 21:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z/ZqzCBddoOe6cElQsXSPaPa9YScgcb1RA++AVKK45o=;
        b=S0iEEtWHdVMdH4ZvaQfDsFtl52bOxgDUnqEKCqK13oLiS7xCyycKXwY2VIuvCNRPuU
         MSMSWLy3KV532CJHWDObBmAImM+Kzyow0iB/WZ3vpgmbaMoVLL821tpO+eFo5FFbgrip
         H7WtG7PWAs8H4fLvNoMTxm2fnGS9vJwhmTdrbe82kgfVzhvuaFov6fTPRbh0lO5ZKflO
         Haw9eVq2OgvUPoE2rL6YdKWsv7pYA+ceRcl26RdHS9M9oNwAW+fhUhipZi0KXjCARbKD
         MqKTbptINtOsGNz24PX9A9eWoXX/U0uIV5kr4VBcKo7COkJ+CR8pJi1GbbmuzpY6+PS2
         PANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z/ZqzCBddoOe6cElQsXSPaPa9YScgcb1RA++AVKK45o=;
        b=h2pJFbK4ZT8eucxD/kEP3X9EZwIwkTbvQPPHGMmg90fkPcOb9Gkom0VDcBdmzlkr1p
         G9hekDP7ijAfHktBP1fEXRJwV5yDYSdPLZX2XB8fX05g7eqGmag5umIwQjWjvfHCZPIM
         quK2s6xUAlkQHqxRtKunaTooMybLGZ4Ne4t6JHCS1TYR4Oz0umDnsy0qsBS1ttQoBE7g
         Sp7hGmtbKzjg7qctsiXfEMpINYjxeXupIRfc9wp/MlEIo/QJMgzmOmeuBNAGKW43nchS
         VnEEQPcrDUar9PxsojajBjOOIdLlsq1sczd1gXDY+40SND9LVY79RkRtRaw88+4X8da6
         rTFg==
X-Gm-Message-State: AOAM532bbMVTb3+/QiNnpWt3Rm+R3rw8lorxckduiYHf2pqCxS3dfts+
        nL0L0f2capIb5Aoe2m9wY98vaA==
X-Google-Smtp-Source: ABdhPJym123jrDQyOmckTomGRhHglYxlPrWudYpouUVfZSewDsr/fa/uKEO4Gqv50DZEE8lcrCB6yw==
X-Received: by 2002:a17:90b:4a4b:: with SMTP id lb11mr1891666pjb.111.1599626117949;
        Tue, 08 Sep 2020 21:35:17 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id z1sm355353pfz.70.2020.09.08.21.35.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Sep 2020 21:35:16 -0700 (PDT)
Date:   Wed, 9 Sep 2020 10:05:14 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Amit Kucheria <amitk@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Taniya Das <tdas@codeaurora.org>
Subject: Re: [PATCH 5/7] cpufreq: qcom-hw: Use regmap for accessing hardware
 registers
Message-ID: <20200909043514.kuchag27eb255lgk@vireshk-i7>
References: <20200908075716.30357-1-manivannan.sadhasivam@linaro.org>
 <20200908075716.30357-6-manivannan.sadhasivam@linaro.org>
 <20200908103444.5e526uawa45om6lt@vireshk-i7>
 <20200908111141.GB23095@mani>
 <20200908111813.bbgfxo5v7qt6ujpc@vireshk-i7>
 <CAHLCerMndYeEBOxtj8mV7OdOP9pufx+C7n1F9m+CFAneuh8DnA@mail.gmail.com>
 <CAHLCerPm6MXr662CaA3zZm4fQ3dJ_StJt3Ehutc3xnc0L9wj3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHLCerPm6MXr662CaA3zZm4fQ3dJ_StJt3Ehutc3xnc0L9wj3Q@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08-09-20, 17:38, Amit Kucheria wrote:
> On Tue, Sep 8, 2020 at 5:18 PM Amit Kucheria <amitk@kernel.org> wrote:
> >
> > On Tue, Sep 8, 2020 at 4:48 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > On 08-09-20, 16:41, Manivannan Sadhasivam wrote:
> > > > On 0908, Viresh Kumar wrote:
> > > > > On 08-09-20, 13:27, Manivannan Sadhasivam wrote:
> > > > > > Use regmap for accessing cpufreq registers in hardware.
> > > > >
> > > > > Why ? Please mention why a change is required in the log.
> > > > >
> > > >
> > > > Only because it is recommended to use regmap for abstracting the hw access.
> > >
> > > Yes it can be very useful in abstracting the hw access in case of
> > > busses like SPI/I2C, others, but in this case there is only one way of
> > > doing it with the exact same registers. I am not sure it is worth it
> > > here. FWIW, I have never played with regmaps personally, and so every
> > > chance I can be wrong here.
> >
> > One could handle the reg offsets through a struct initialisation, but
> > then you end up with lots of #defines for bitmasks and bits for each
> > version of the IP. And the core code becomes a bit convoluted IMO,
> > trying to handle the differences.
> >
> > regmap hides the differences of the bit positions and register offsets
> > between several IP versions.

Right and I agree that is another useful aspect of it which I missed
mentioning.

> > > > Moreover it handles the proper locking for us in the core (spinlock vs mutex).
> > >
> > > What locking do you need here ?
> >
> > Right, locking isn't the main reason here.
> 
> Having said this, perhaps this patch can be held back for now, since
> we're not yet using some of the features of regmap to abstract away
> bit fields and such.
> 
> We don't strictly need it for just different register offsets.

Right, I just didn't understood why it was required currently as it
wasn't all that complex at all.

-- 
viresh
