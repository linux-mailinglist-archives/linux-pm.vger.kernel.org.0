Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBAFD9DBDF
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2019 05:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbfH0DJW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Aug 2019 23:09:22 -0400
Received: from mga02.intel.com ([134.134.136.20]:31921 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728025AbfH0DJW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 26 Aug 2019 23:09:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Aug 2019 20:09:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,435,1559545200"; 
   d="scan'208";a="180076066"
Received: from deyangko-mobl.ccr.corp.intel.com ([10.249.168.35])
  by fmsmga008.fm.intel.com with ESMTP; 26 Aug 2019 20:09:17 -0700
Message-ID: <57ecab7c3600802d544683fcb968f9455b2b25d8.camel@intel.com>
Subject: Re: [PATCH V3 1/5] thermal: qoriq: Add clock operations
From:   Zhang Rui <rui.zhang@intel.com>
To:     Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Tue, 27 Aug 2019 11:09:16 +0800
In-Reply-To: <AM6PR0402MB3911D45B3B148588A582F6C4F5A00@AM6PR0402MB3911.eurprd04.prod.outlook.com>
References: <20190730022126.17883-1-Anson.Huang@nxp.com>
         <VI1PR04MB7023F219CA7B4187F86EAA42EEA10@VI1PR04MB7023.eurprd04.prod.outlook.com>
         <AM6PR0402MB3911D45B3B148588A582F6C4F5A00@AM6PR0402MB3911.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 2019-08-27 at 01:51 +0000, Anson Huang wrote:
> > On 7/30/2019 5:31 AM, Anson.Huang@nxp.com wrote:
> > > From: Anson Huang <Anson.Huang@nxp.com>
> > > 
> > > Some platforms like i.MX8MQ has clock control for this module,
> > > need to
> > > add clock operations to make sure the driver is working properly.
> > > 
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > Reviewed-by: Guido Günther <agx@sigxcpu.org>
> > 
> > This series looks good, do you think it can be merged in time for
> > v5.4?
> > Today was v5.3-rc6.
> 
> If the question is for me, then I am NOT sure, the thermal patches
> are pending
> there for almost half year and I did NOT receive any response,

which patch series you're referring to?

>  looks like no one
> is maintaining the thermal sub-system?
> 

Eduardo is maintaining all the thermal-soc driver changes. Thus I
usually filtered out the soc driver patches in my mailbox.

The last email from Eduardo is that he is offline during this July and
will be back and taking patches in August.

I will double check with Eduardo anyway.

thanks,
rui


> > 
> > In an earlier series the CLK_IS_CRITICAL flags was removed from the
> > TMU
> > clock so if the thermal driver doesn't explicitly enable it the
> > system will hang
> > on probe. This is what happens in linux-next right now!
> 
> The thermal driver should be built with module, so default kernel
> should can boot
> up, do you modify the thermal driver as built-in?
> 
> > 
> > Unless this patches is merged soon we'll end up with a 5.4-rc1 that
> > doesn't
> > boot on imx8mq. An easy fix would be to drop/revert commit
> > 951c1aef9691 ("clk: imx8mq: Remove CLK_IS_CRITICAL flag for
> > IMX8MQ_CLK_TMU_ROOT") until the thermal patches are accepted.
> 
> If the thermal driver is built as module, I think no need to revert
> the commit, but
> if by default thermal driver is built-in or mod probed, then yes, it
> should NOT break
> kernel boot up.
> 
> Anson.
> 
> > 
> > Merging patches out-of-order when they have hard (boot-breaking)
> > dependencies also breaks bisect.
> > 
> > --
> > Regards,
> > Leonard

