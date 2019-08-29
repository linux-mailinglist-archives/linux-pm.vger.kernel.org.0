Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A943A0FC1
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2019 05:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbfH2DBU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Aug 2019 23:01:20 -0400
Received: from mga18.intel.com ([134.134.136.126]:23409 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbfH2DBU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 28 Aug 2019 23:01:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2019 20:01:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,442,1559545200"; 
   d="scan'208";a="171750491"
Received: from deyangko-mobl.ccr.corp.intel.com ([10.249.168.35])
  by orsmga007.jf.intel.com with ESMTP; 28 Aug 2019 20:01:14 -0700
Message-ID: <678b4418be67c76cf1505f0fec69e25ecd0110f5.camel@intel.com>
Subject: Re: [PATCH V3 1/5] thermal: qoriq: Add clock operations
From:   Zhang Rui <rui.zhang@intel.com>
To:     Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Thu, 29 Aug 2019 11:01:28 +0800
In-Reply-To: <DB3PR0402MB3916372A08E2FF3A9C15E0A6F5A20@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190730022126.17883-1-Anson.Huang@nxp.com>
         <VI1PR04MB7023F219CA7B4187F86EAA42EEA10@VI1PR04MB7023.eurprd04.prod.outlook.com>
         <AM6PR0402MB3911D45B3B148588A582F6C4F5A00@AM6PR0402MB3911.eurprd04.prod.outlook.com>
         <VI1PR04MB7023773DD477FF89E2D2181CEEA00@VI1PR04MB7023.eurprd04.prod.outlook.com>
         <d9b428825654181fbdbfb4d613a6a3fd52330787.camel@intel.com>
         <DB3PR0402MB3916D1492F43D77E3679E3B1F5A30@DB3PR0402MB3916.eurprd04.prod.outlook.com>
         <3f268ab0e05b795c04dbb3490f0c93da998e3b2c.camel@intel.com>
         <DB3PR0402MB39168DA42F69336EB2B231E8F5A30@DB3PR0402MB3916.eurprd04.prod.outlook.com>
         <DB3PR0402MB3916372A08E2FF3A9C15E0A6F5A20@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 2019-08-29 at 02:49 +0000, Anson Huang wrote:
> Hi, Rui
> 
> > > On Wed, 2019-08-28 at 08:51 +0000, Anson Huang wrote:
> > > > Hi, Rui
> > > > 
> > > > > On Tue, 2019-08-27 at 12:41 +0000, Leonard Crestez wrote:
> > > > > > On 27.08.2019 04:51, Anson Huang wrote:
> > > > > > > > In an earlier series the CLK_IS_CRITICAL flags was
> > > > > > > > removed
> > > > > > > > from the TMU clock so if the thermal driver doesn't
> > > > > > > > explicitly enable it the system will hang on probe.
> > > > > > > > This is
> > > > > > > > what happens in linux-next right now!
> > > > > > > 
> > > > > > > The thermal driver should be built with module, so
> > > > > > > default
> > > > > > > kernel should can boot up, do you modify the thermal
> > > > > > > driver as
> > > > > > > built- in?
> > > > > > > 
> > > > > > > > Unless this patches is merged soon we'll end up with a
> > > > > > > > 5.4-
> > > > > > > > rc1
> > > > > > > > that doesn't boot on imx8mq. An easy fix would be to
> > > > > > > > drop/revert commit
> > > > > > > > 951c1aef9691 ("clk: imx8mq: Remove CLK_IS_CRITICAL flag
> > > > > > > > for
> > > > > > > > IMX8MQ_CLK_TMU_ROOT") until the thermal patches are
> > 
> > accepted.
> > > > > > > 
> > > > > > > If the thermal driver is built as module, I think no need
> > > > > > > to
> > > > > > > revert the commit, but if by default thermal driver is
> > > > > > > built-in or mod probed, then yes, it should NOT break
> > > > > > > kernel boot
> > 
> > up.
> > > > > > 
> > > > > > The qoriq_thermal driver is built as a module in defconfig
> > > > > > and
> > > > > > when modules are properly installed in rootfs they will be
> > > > > > automatically be probed on boot and cause a hang.
> > > > > > 
> > > > > > I usually run nfsroot with modules:
> > > > > > 
> > > > > >      make modules_install INSTALL_MOD_PATH=/srv/nfs/imx8-
> > > > > > root
> > > > > 
> > > > > so we need this patch shipped in the beginning of the merge
> > > > > window, right?
> > > > > if there is hard dependency between patches, it's better to
> > > > > send
> > > > > them in one series, and get shipped via either tree.
> > > > 
> > > > There is no hard dependency in this patch series. Previous for
> > > > the
> > > > TMU clock disabled patch, since thermal driver is built as
> > > > module so
> > > > I did NOT found the issue. The patch series is the correct fix.
> > > > 
> > > 
> > > Got it.
> > > the clock patch is also queued for 5.4-rc1, right?
> > > I will apply this series and try to push it as early as possible
> > > during the merge window.
> > 
> > The clock patch is as below in Linux-next tree, while I did NOT see
> > it in v5.3-
> > rc6, so it should be queued for 5.4-rc1, right?
> > Thanks for taking the patch series!
> 
> Sorry for pushing, so you will apply this patch series to avoid the
> i.MX8MQ kernel boot up hang
> caused by insmod qoriq thermal driver, right? Then we no need to
> revert that TMU clock patch
> 951c1aef9691 ("clk: imx8mq: Remove CLK_IS_CRITICAL flag for
> IMX8MQ_CLK_TMU_ROOT").
> 
right. I will queue it for 5.4-rc1.

thanks,
rui

> Thanks,
> Anson
> 
> > 
> > 
> > commit 951c1aef9691491ddf4dd5aab76f2665d56bd5d3
> > Author: Anson Huang <Anson.Huang@nxp.com>
> > Date:   Fri Jul 5 12:56:11 2019 +0800
> > 
> >     clk: imx8mq: Remove CLK_IS_CRITICAL flag for
> > IMX8MQ_CLK_TMU_ROOT
> > 
> >     IMX8MQ_CLK_TMU_ROOT is ONLY used for thermal module, the driver
> >     should manage this clock, so no need to have CLK_IS_CRITICAL
> > flag
> >     set.
> > 
> >     Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> >     Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
> >     Acked-by: Stephen Boyd <sboyd@kernel.org>
> >     Signed-off-by: Shawn Guo <shawnguo@kernel.org>
> > 
> > drivers/clk/imx/clk-imx8mq.c
> > 
> > 
> > Thanks,
> > Anson

