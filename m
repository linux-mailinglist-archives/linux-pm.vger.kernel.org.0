Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68F1F1B970C
	for <lists+linux-pm@lfdr.de>; Mon, 27 Apr 2020 08:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgD0GLn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Apr 2020 02:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726221AbgD0GLm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Apr 2020 02:11:42 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4066FC061A0F
        for <linux-pm@vger.kernel.org>; Sun, 26 Apr 2020 23:11:42 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1jSwzJ-0005L3-RD; Mon, 27 Apr 2020 08:11:29 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1jSwzB-0003QW-8g; Mon, 27 Apr 2020 08:11:21 +0200
Date:   Mon, 27 Apr 2020 08:11:21 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, robh+dt@kernel.org,
        leonard.crestez@nxp.com, linux@rempel-privat.de, peng.fan@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH V5 1/2] dt-bindings: firmware: imx: Move system control
 into dt-binding headfile
Message-ID: <20200427061121.tsybnbqrzjpy7f3a@pengutronix.de>
References: <1587888704-7158-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587888704-7158-1-git-send-email-Anson.Huang@nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 08:10:13 up 163 days, 21:28, 173 users,  load average: 0.13, 0.18,
 0.12
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Anson,

sorry for jumping in..

On 20-04-26 16:11, Anson Huang wrote:
> From: Dong Aisheng <aisheng.dong@nxp.com>
> 
> i.MX8 SoCs DTS file needs system control macro definitions, so move them
> into dt-binding headfile, then include/linux/firmware/imx/types.h can be
> removed and those drivers using it should be changed accordingly.
> 
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V4:
> 	- Use another patch for new added system controls and PM clock types.
> ---
>  drivers/firmware/imx/imx-scu.c          |  1 -
>  drivers/thermal/imx_sc_thermal.c        |  2 +-
>  include/dt-bindings/firmware/imx/rsrc.h | 51 ++++++++++++++++++++++++++
>  include/linux/firmware/imx/sci.h        |  1 -
>  include/linux/firmware/imx/types.h      | 65 ---------------------------------
>  5 files changed, 52 insertions(+), 68 deletions(-)
>  delete mode 100644 include/linux/firmware/imx/types.h
> 
> diff --git a/drivers/firmware/imx/imx-scu.c b/drivers/firmware/imx/imx-scu.c
> index f71eaa5..f3340fa 100644
> --- a/drivers/firmware/imx/imx-scu.c
> +++ b/drivers/firmware/imx/imx-scu.c
> @@ -8,7 +8,6 @@
>   */
>  
>  #include <linux/err.h>
> -#include <linux/firmware/imx/types.h>
>  #include <linux/firmware/imx/ipc.h>
>  #include <linux/firmware/imx/sci.h>
>  #include <linux/interrupt.h>

You don't need this anymore here or was it a needless include?

Regards,
  Marco
