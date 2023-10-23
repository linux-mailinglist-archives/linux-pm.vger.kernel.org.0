Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33997D36B8
	for <lists+linux-pm@lfdr.de>; Mon, 23 Oct 2023 14:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbjJWMdr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Oct 2023 08:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjJWMdr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Oct 2023 08:33:47 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4729210C
        for <linux-pm@vger.kernel.org>; Mon, 23 Oct 2023 05:33:45 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1quu7f-0004Jk-Nk; Mon, 23 Oct 2023 14:33:31 +0200
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mfe@pengutronix.de>)
        id 1quu7e-003hrK-Nk; Mon, 23 Oct 2023 14:33:30 +0200
Received: from mfe by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1quu7e-00Fvg8-Kg; Mon, 23 Oct 2023 14:33:30 +0200
Date:   Mon, 23 Oct 2023 14:33:30 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux@ew.tq-group.com
Subject: Re: [PATCH 4/5] clk: imx: clk-fracn-gppll: Add 477.4MHz config for
 video pll
Message-ID: <20231023123330.2z37jzwdsx52w7p3@pengutronix.de>
References: <20231020130019.665853-1-alexander.stein@ew.tq-group.com>
 <20231020130019.665853-5-alexander.stein@ew.tq-group.com>
 <20231020142055.xnxbumcg2o6cfpfl@pengutronix.de>
 <10361180.nUPlyArG6x@steina-w>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10361180.nUPlyArG6x@steina-w>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23-10-23, Alexander Stein wrote:
> Hi Marco,
> 
> Am Freitag, 20. Oktober 2023, 16:20:55 CEST schrieb Marco Felsch:
> > Hi Alexander,
> > 
> > On 23-10-20, Alexander Stein wrote:
> > > Add the 477.4MHz frequency support that will be used by video subsystem
> > > on imx93.
> > 
> > albeit the change is fine, could we consider adding support to calc the
> > params dynamically?
> 
> Agreed, I would prefer that as well: But unfortunately I will not be able to 
> add dynamic calculation right now.

Okay, just wanted to ask if someone (maybe TQ) has the time to implement
and test it.

Regards,
  Marco
