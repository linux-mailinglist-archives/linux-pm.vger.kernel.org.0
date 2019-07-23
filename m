Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D165070F47
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2019 04:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfGWCud (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Jul 2019 22:50:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:42254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729066AbfGWCud (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 22 Jul 2019 22:50:33 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 808C622387;
        Tue, 23 Jul 2019 02:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563850232;
        bh=tk2ImME7wgkuCKMHXoNvdEiYanrybl4tu/Ko28YBUfU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F963pTbce2NtBx2uERfIVEKelVGw9gmBe9W1/tv/fz6YwK3bB1zZuyu1ocFNO8N07
         zpMWoRj1lDmUOW8+NC1D2XxUu7viIF8Xx+cKNwcWLxysNJ2HBO9PeU0LLP14W5HZ+R
         eEqXo48ZCGkSmVI7wLRE1z03ggwKNEjzxqdqrT4M=
Date:   Tue, 23 Jul 2019 10:50:01 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson.Huang@nxp.com
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, mturquette@baylibre.com,
        sboyd@kernel.org, l.stach@pengutronix.de, abel.vesa@nxp.com,
        andrew.smirnov@gmail.com, angus@akkea.ca, ccaione@baylibre.com,
        agx@sigxcpu.org, leonard.crestez@nxp.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH 5/6] clk: imx8mq: Remove CLK_IS_CRITICAL flag for
 IMX8MQ_CLK_TMU_ROOT
Message-ID: <20190723024959.GI3738@dragon>
References: <20190705045612.27665-1-Anson.Huang@nxp.com>
 <20190705045612.27665-5-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190705045612.27665-5-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 05, 2019 at 12:56:11PM +0800, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> IMX8MQ_CLK_TMU_ROOT is ONLY used for thermal module, the driver
> should manage this clock, so no need to have CLK_IS_CRITICAL flag
> set.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
