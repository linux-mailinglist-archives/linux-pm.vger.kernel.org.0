Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCC746D728
	for <lists+linux-pm@lfdr.de>; Wed,  8 Dec 2021 16:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236190AbhLHPnG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 8 Dec 2021 10:43:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236179AbhLHPnF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Dec 2021 10:43:05 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FEFC061746
        for <linux-pm@vger.kernel.org>; Wed,  8 Dec 2021 07:39:33 -0800 (PST)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1muz2P-0000fz-PC; Wed, 08 Dec 2021 16:39:21 +0100
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1muz2N-000HIO-D1; Wed, 08 Dec 2021 16:39:19 +0100
Message-ID: <b19d492081f0f234f85408dd3897fb3c144ec80f.camel@pengutronix.de>
Subject: Re: [PATCH] thermal/drivers: Add error check for
 reset_control_deassert()
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Date:   Wed, 08 Dec 2021 16:39:19 +0100
In-Reply-To: <20211208153547.3612-1-biju.das.jz@bp.renesas.com>
References: <20211208153547.3612-1-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2021-12-08 at 15:35 +0000, Biju Das wrote:
> If reset_control_deassert() fails, then we won't be able to access
> the device registers. Therefore check the return code of
> reset_control_deassert() and bail out in case of error.
> 
> While at it replace the parameter "&pdev->dev" -> "dev" in
> devm_reset_control_get_exclusive().
> 
> Suggested-by: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Thanks,

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
