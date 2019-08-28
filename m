Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4BB9FE1D
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2019 11:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfH1JOK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Aug 2019 05:14:10 -0400
Received: from mga14.intel.com ([192.55.52.115]:44648 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbfH1JOK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 28 Aug 2019 05:14:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2019 02:14:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,440,1559545200"; 
   d="scan'208";a="381218667"
Received: from deyangko-mobl.ccr.corp.intel.com ([10.249.168.35])
  by fmsmga006.fm.intel.com with ESMTP; 28 Aug 2019 02:14:00 -0700
Message-ID: <ff3fd0ab2ba659e98070760be8e7c0f223e921f9.camel@intel.com>
Subject: Re: [PATCH V15 1/5] dt-bindings: fsl: scu: add thermal binding
From:   Zhang Rui <rui.zhang@intel.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Peng Fan <peng.fan@nxp.com>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "olof@lixom.net" <olof@lixom.net>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc:     dl-linux-imx <linux-imx@nxp.com>
Date:   Wed, 28 Aug 2019 17:14:09 +0800
In-Reply-To: <DB3PR0402MB39162EB555CD7AE75D58C582F5C60@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190618021820.14885-1-Anson.Huang@nxp.com>
         <DB3PR0402MB39162C5B5AF828B127DD871EF5E00@DB3PR0402MB3916.eurprd04.prod.outlook.com>
         <DB3PR0402MB39162EB555CD7AE75D58C582F5C60@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi, Anson,

We're missing ACK from the maintainers for patch 4/5 and 5/5, if we
want to shipped the patch via thermal tree.

For patch 2/5, as it introduces a new API for OF_THERMAL, I'd like to
get Eduardo' feedback before taking them.

thanks,
rui

On Wed, 2019-07-24 at 03:16 +0000, Anson Huang wrote:
> Ping...
> 
> > Hi, Daniel/Rui/Eduardo
> > 	Could you please take a look at this patch series?
> > 
> > Anson
> > 
> > > From: Anson Huang <Anson.Huang@nxp.com>
> > > 
> > > NXP i.MX8QXP is an ARMv8 SoC with a Cortex-M4 core inside as
> > > system
> > > controller, the system controller is in charge of system power,
> > > clock
> > > and thermal sensors etc. management, Linux kernel has to
> > > communicate
> > > with system controller via MU (message unit) IPC to get
> > > temperature
> > > from thermal sensors, this patch adds binding doc for i.MX system
> > > controller thermal driver.
> > > 
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
> > > ---
> > > No change.
> > > ---
> > >  .../devicetree/bindings/arm/freescale/fsl,scu.txt        | 16
> > 
> > ++++++++++++++++
> > >  1 file changed, 16 insertions(+)
> > > 
> > > diff --git
> > > a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> > > b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> > > index a575e42..fc3844e 100644
> > > --- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> > > +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> > > @@ -155,6 +155,17 @@ Required properties:
> > >  Optional properties:
> > >  - timeout-sec: contains the watchdog timeout in seconds.
> > > 
> > > +Thermal bindings based on SCU Message Protocol
> > > +------------------------------------------------------------
> > > +
> > > +Required properties:
> > > +- compatible:			Should be :
> > > +				  "fsl,imx8qxp-sc-thermal"
> > > +				followed by "fsl,imx-sc-thermal";
> > > +
> > > +- #thermal-sensor-cells:	See
> > > Documentation/devicetree/bindings/thermal/thermal.txt
> > > +				for a description.
> > > +
> > >  Example (imx8qxp):
> > >  -------------
> > >  aliases {
> > > @@ -222,6 +233,11 @@ firmware {
> > >  			compatible = "fsl,imx8qxp-sc-wdt", "fsl,imx-sc-
> > > wdt";
> > >  			timeout-sec = <60>;
> > >  		};
> > > +
> > > +		tsens: thermal-sensor {
> > > +			compatible = "fsl,imx8qxp-sc-thermal",
> > > "fsl,imx-sc-
> > > thermal";
> > > +			#thermal-sensor-cells = <1>;
> > > +		};
> > >  	};
> > >  };
> > > 
> > > --
> > > 2.7.4
> 
> 

