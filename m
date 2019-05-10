Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAA419B15
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2019 12:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbfEJKMa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 May 2019 06:12:30 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:47035 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727289AbfEJKM0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 May 2019 06:12:26 -0400
Received: by mail-pl1-f194.google.com with SMTP id bi2so2602948plb.13
        for <linux-pm@vger.kernel.org>; Fri, 10 May 2019 03:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=YEAAdnjFo5d+nFsQyBOaqPUBBRxUoX1ZF3WyvxMrBkU=;
        b=dl1ae2wHT+zVPYcECGFIgL/JB+F87tAIPyE5pOOUzeAWOS8WhEZFvYwWwvDt6dQfgl
         Sij0E5EcRupjwid6veCbXVlELd9V4px46nUA76L/Ai8p6ARnK8ST9zb5Ec8Pm85yVDbp
         7e9ecxLxiR7+VeJkkfIEvNeqH2Udtv6W0KSgIjZ3p82GQFvga5A51plKiGWCVJ9Ku9PS
         vaSndTfCi3RIhfoFOLxje1cSNTFWABYzd+t6143p8X2M48ByiV9Zr6hJdgDUO8KSnbOx
         /Q9xTOyATyexqP+H41AZg6czlsQXGWjTK4FwgW74IdyATyMZFQDa1CL6t3ACjeCQi3zO
         3q5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YEAAdnjFo5d+nFsQyBOaqPUBBRxUoX1ZF3WyvxMrBkU=;
        b=Ws8XOG/LJ4jqUVHnat9E91aRLUrhOprnK5LAIZz/Ef3nxJ+O1KGvLAMtSp8a16QjOM
         Hcvj5P1j7Ezv8tp1gy8/tg8MN6BkcsZfp7rPX4Dpj+K5mQmqyDp51b3BD5aPwVy/+rU3
         H0K4NsxjNMqUeltnt299XkCZP5ZQbEX7IaGhm7vlXixQi5F/fybGxWUTHTKvepDQ3ESO
         NrUeHhrmwRBl1XbZPT7uAbqr9wgWLtPEplUeUOrzcnQpmQhS5DSNYvsN2+OUpoLM6Z2p
         BIz+HpdZZezTIR0+kMq/95jC5664cnIQ87SmXBpSBdBr34FN76p5IrZMj4facpHqFuJM
         YYQw==
X-Gm-Message-State: APjAAAWXtqwnhCSuD4RJZaT3+l0SQkesdjGXhhkd/BXyNChYlay9/Nd6
        y+3mxqzt6R0n1ZTDYUhdDioeiw==
X-Google-Smtp-Source: APXvYqxKrnh807PzQYhRXIk7/R9rWTSh3mHRassJS1OSBIxgT137TWREOpor2e2oLQn4J3ONB28xVg==
X-Received: by 2002:a17:902:d24:: with SMTP id 33mr11638563plu.148.1557483143830;
        Fri, 10 May 2019 03:12:23 -0700 (PDT)
Received: from localhost ([122.172.118.99])
        by smtp.gmail.com with ESMTPSA id b14sm5970214pfi.92.2019.05.10.03.12.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 03:12:21 -0700 (PDT)
Date:   Fri, 10 May 2019 15:42:19 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Andy Tang <andy.tang@nxp.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>
Subject: Re: [EXT] Re: [PATCH v6] arm64: dts: ls1088a: add one more thermal
 zone node
Message-ID: <20190510101219.oruzvzlk7mm6iahw@vireshk-i7>
References: <20190423022507.34969-1-andy.tang@nxp.com>
 <20190510031335.GD15856@dragon>
 <VI1PR04MB4333D24227603D1497BA3CB9F30C0@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <9fb2e306-38c7-2af7-5470-ff5bc4e23370@linaro.org>
 <VI1PR04MB4333372C1DABD0E4C9DD7FE8F30C0@VI1PR04MB4333.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <VI1PR04MB4333372C1DABD0E4C9DD7FE8F30C0@VI1PR04MB4333.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10-05-19, 08:47, Andy Tang wrote:
> + Viresh for help.
> 
> > -----Original Message-----
> > From: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Sent: 2019年5月10日 15:17
> > To: Andy Tang <andy.tang@nxp.com>; Shawn Guo <shawnguo@kernel.org>
> > Cc: Leo Li <leoyang.li@nxp.com>; robh+dt@kernel.org;
> > mark.rutland@arm.com; linux-arm-kernel@lists.infradead.org;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> > linux-pm@vger.kernel.org; rui.zhang@intel.com; edubezval@gmail.com
> > Subject: Re: [EXT] Re: [PATCH v6] arm64: dts: ls1088a: add one more thermal
> > zone node
> > 
> > Caution: EXT Email
> > 
> > On 10/05/2019 05:40, Andy Tang wrote:
> > >> -----Original Message-----
> > >> From: Shawn Guo <shawnguo@kernel.org>
> > >> Sent: 2019年5月10日 11:14
> > >> To: Andy Tang <andy.tang@nxp.com>
> > >> Cc: Leo Li <leoyang.li@nxp.com>; robh+dt@kernel.org;
> > >> mark.rutland@arm.com; linux-arm-kernel@lists.infradead.org;
> > >> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> > >> linux-pm@vger.kernel.org; daniel.lezcano@linaro.org;
> > >> rui.zhang@intel.com; edubezval@gmail.com
> > >> Subject: [EXT] Re: [PATCH v6] arm64: dts: ls1088a: add one more
> > >> thermal zone node
> > >>
> > >> Caution: EXT Email
> > >>
> > >> On Tue, Apr 23, 2019 at 10:25:07AM +0800, Yuantian Tang wrote:
> > >>> Ls1088a has 2 thermal sensors, core cluster and SoC platform. Core
> > >>> cluster sensor is used to monitor the temperature of core and SoC
> > >>> platform is for platform. The current dts only support the first sensor.
> > >>> This patch adds the second sensor node to dts to enable it.
> > >>>
> > >>> Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
> > >>> ---
> > >>> v6:
> > >>>         - add cooling device map to cpu0-7 in platform node.
> > > I like to explain a little. I think it makes sense that multiple thermal zone
> > map to same cooling device.
> > > In this way, no matter which thermal zone raises a temp alarm, it can call
> > cooling device to chill out.
> > > I also asked cpufreq maintainer about the cooling map issue, he think it
> > would be fine.

Yes, you asked me and I said it should be okay.

> > > I have tested and no issue found.
> > >
> > > Daniel, what's your thought?
> > 
> > If there are multiple thermal zones, they will be managed by different
> > instances of a thermal governor. Each instances will act on the shared cooling
> > device and will collide in their decisions:
> > 
> >  - If the sensors are closed, their behavior will be similar regarding the
> > temperature. The governors may take the same decision for the cooling
> > device. But in such case having just one thermal zone managed is enough.
> > 
> >  - If the sensors are not closed, their behavior will be different regarding the
> > temperature. The governors will take different decision regarding the cooling
> > device (one will decrease the freq, other will increase the freq).
> > 
> > As the thermal governors are not able to manage several thermal zones and
> > there is one cooling device (the cpu cooling device), this setup won't work as
> > expected IMO.
> > 
> > The setup making sense is having a thermal zone per 'cluster' and a cooling
> > device per 'cluster'. That means the platform has one clock line per 'cluster'.
> > The thermal management happens in a self-contained thermal zone (one
> > cooling device - one governor - one thermal zone).
> > 
> > In the case of HMP, other combinations are possible to be optimal.

But not sure how I missed the obvious, though I do remember thinking about this.

So the problem is that the cpu_cooling driver will get requests in parallel to
set different max frequencies and the last call will always win and may result
in undesired outcome.

Sorry about creating the confusion.

-- 
viresh
