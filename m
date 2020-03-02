Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0823175684
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2020 10:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgCBJBi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Mar 2020 04:01:38 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59835 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbgCBJBi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Mar 2020 04:01:38 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1j8gxC-0002PE-Mi; Mon, 02 Mar 2020 10:01:34 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1j8gx9-0003CA-VP; Mon, 02 Mar 2020 10:01:31 +0100
Date:   Mon, 2 Mar 2020 10:01:31 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Anson Huang <anson.huang@nxp.com>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH V2] thermal: imx_thermal: Use __maybe_unused instead of
 CONFIG_PM_SLEEP
Message-ID: <20200302090131.7e6s4swys45fnksx@pengutronix.de>
References: <1583135410-7496-1-git-send-email-Anson.Huang@nxp.com>
 <20200302080700.ubnboqklhbva7bas@pengutronix.de>
 <DB3PR0402MB3916DC28A21BE0B9B8BFFC25F5E70@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <c5ecab57-cc38-762c-ae06-fed0433e0246@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c5ecab57-cc38-762c-ae06-fed0433e0246@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Mar 02, 2020 at 09:54:34AM +0100, Daniel Lezcano wrote:
> On 02/03/2020 09:26, Anson Huang wrote:
> > Hi, Uwe
> > 
> > 
> >> Subject: Re: [PATCH V2] thermal: imx_thermal: Use __maybe_unused instead
> >> of CONFIG_PM_SLEEP
> >>
> >> On Mon, Mar 02, 2020 at 03:50:10PM +0800, Anson Huang wrote:
> >>> Use __maybe_unused for power management related functions instead of
> >>> #if CONFIG_PM_SLEEP to simplify the code.
> >>>
> >>> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> >>> Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> >>
> >> IMHO translating my "otherwise looks fine" in a "Reviewed-by" is a bit bold.
> >> Please don't assume this.
> > 
> > OK, will keep it in mind next time, thanks.
> 
> When applying a patch, now we add the link to the lkml archive
> automatically. I can't apply this patch if the Reviewed-by is not accepted.
> 
> Or the Reviewed-by tag is confirmed or a V3 without the Reviewed-by must
> be resent.

I didn't look close enough to justify a Reviewed-by:, so "the
Reviewed-by tag is confirmed" is ruled out.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
