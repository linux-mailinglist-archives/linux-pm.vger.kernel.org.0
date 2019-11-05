Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65799F06B7
	for <lists+linux-pm@lfdr.de>; Tue,  5 Nov 2019 21:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfKEUNF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Nov 2019 15:13:05 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45623 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfKEUNF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Nov 2019 15:13:05 -0500
Received: by mail-oi1-f196.google.com with SMTP id k2so18737385oij.12;
        Tue, 05 Nov 2019 12:13:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mU9UcOU7sHcf7HCmRIHXhWHMA1uoQHabE8Uv8Jt+A7E=;
        b=deYGSv8p6GIzQ3anqm/7VuAyUdkL8f4vSLJd//erntmjUeSYr369cjy2nWUkkDX8BX
         1T6PqCjcVp8lm3GY5LohQhIQEVqUjZXpAZ8LxMs0d5GaO599TdUR3E2umG8fppna7E/K
         pn12fGx312nfP23kG7KaPJeUd+QzOi77BifVXHYjMuKy6g2fZqLu+J20/UpJSMONwzLH
         1k+JRJ9nrTd3Fo0mhO7ZmWsHoWNOYMk7qVcM1pZAYiwbqyTQyCyKo7kEhtyu47DVDi9h
         sxnJAHPK8SfuYH5nCCzv5+QwLWUssw2vxAp0gAEuTlCW1QHFKGPhnHYvmXhANpkywSKE
         5qFA==
X-Gm-Message-State: APjAAAWET6wphwNAdWYbdfGmT6cssUm9sQwmXeUNShouijm4e9DSXMgp
        T6/aEYB2bu61bbrtu2bt6Q==
X-Google-Smtp-Source: APXvYqzy0m98tPqHlFSqTVQuTPMUjEJDLNZe7DOwoduqbUy3ipM2+KtNECfZLQnN0fel0V++XN/OPg==
X-Received: by 2002:aca:dd0a:: with SMTP id u10mr740393oig.130.1572984783628;
        Tue, 05 Nov 2019 12:13:03 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v13sm1077013ota.53.2019.11.05.12.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 12:13:03 -0800 (PST)
Date:   Tue, 5 Nov 2019 14:13:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Artur =?utf-8?B?xZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Angus Ainslie <angus@akkea.ca>,
        Martin Kepplinger <martink@posteo.de>,
        Matthias Kaehlcke <mka@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 3/6] dt-bindings: devfreq: Add bindings for imx ddr
 controller
Message-ID: <20191105201302.GA4772@bogus>
References: <cover.1572558427.git.leonard.crestez@nxp.com>
 <b9a87c69eb603622303add4f0c02dd4c1262462a.1572558427.git.leonard.crestez@nxp.com>
 <20191104222126.GB5218@bogus>
 <VI1PR04MB7023F375AEDC4549FA12247FEE7E0@VI1PR04MB7023.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB7023F375AEDC4549FA12247FEE7E0@VI1PR04MB7023.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Nov 05, 2019 at 07:25:57PM +0000, Leonard Crestez wrote:
> On 05.11.2019 00:21, Rob Herring wrote:
> > On Thu, Oct 31, 2019 at 11:50:24PM +0200, Leonard Crestez wrote:
> >> Add devicetree bindings for the i.MX DDR Controller on imx8m series
> >> chips. It supports dynamic frequency switching between multiple data
> >> rates and this is exposed to Linux via the devfreq subsystem.
> >>
> >> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> >> ---
> >>   .../devicetree/bindings/devfreq/imx-ddrc.yaml | 60 +++++++++++++++++++
> > 
> > .../bindings/memory-controllers/
> 
> Okay, but I'm not sure about the rules here. Usually there is a 1:1 
> mapping between subsystems and bindings directory but I guess devfreq is 
> odd since it's not really a physical class of device.

Mostly true, but it's not completely 1:1.


> I saw there is also a drivers/memory and there is already a 
> devfreq-using driver in there (EXYNOS5422_DMC).

Yeah, well it's been a while since I last tried to clean up locations of 
things. DDR controller bindings are not in the best shape.


> It's not clear if my driver fits in there; as far as I can see the only 
> "core" functionality in drivers/memory is parsing DDR timings from DTS 
> but for imx8m this is all controlled in firmware.

You shouldn't have to think about that. Bindings should be for DDR 
controllers regardless of whether there's a driver for devfreq, EDAC, 
perf, or ??? or all of those.

Rob
