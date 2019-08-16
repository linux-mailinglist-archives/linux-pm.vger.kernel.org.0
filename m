Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51280904CC
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2019 17:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfHPPi7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Aug 2019 11:38:59 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:57840 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727345AbfHPPi7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Aug 2019 11:38:59 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id F246D25BDF3;
        Sat, 17 Aug 2019 01:38:56 +1000 (AEST)
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id DF79694057D; Fri, 16 Aug 2019 17:38:54 +0200 (CEST)
Date:   Fri, 16 Aug 2019 17:38:54 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/3] clk: renesas: mstp: Set GENPD_FLAG_ALWAYS_ON for
 clock domain
Message-ID: <20190816153854.w5oqlxrfndgp6l3b@verge.net.au>
References: <20190816125225.16061-1-geert+renesas@glider.be>
 <20190816125225.16061-2-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816125225.16061-2-geert+renesas@glider.be>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Aug 16, 2019 at 02:52:23PM +0200, Geert Uytterhoeven wrote:
> The CPG/MSTP Clock Domain driver does not implement the
> generic_pm_domain.power_{on,off}() callbacks, as the domain itself
> cannot be powered down.  Hence the domain should be marked as always-on
> by setting the GENPD_FLAG_ALWAYS_ON flag.
> 
> This gets rid of the following boot warning on RZ/A1:
> 
>     sh_mtu2 fcff0000.timer: PM domain cpg_clocks will not be powered off
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

