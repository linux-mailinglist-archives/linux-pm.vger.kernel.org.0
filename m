Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1C2C2DEBB
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2019 15:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfE2Nnb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 May 2019 09:43:31 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:57038 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfE2Nnb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 May 2019 09:43:31 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id AA7B925B7B3;
        Wed, 29 May 2019 23:43:28 +1000 (AEST)
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id B6F1C940361; Wed, 29 May 2019 15:43:26 +0200 (CEST)
Date:   Wed, 29 May 2019 15:43:26 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] clk: renesas: cpg-mssr: Use genpd of_node instead of
 local copy
Message-ID: <20190529134326.ytxyc5oqiz2tobdn@verge.net.au>
References: <20190527123323.6912-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527123323.6912-1-geert+renesas@glider.be>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, May 27, 2019 at 02:33:23PM +0200, Geert Uytterhoeven wrote:
> Since commit 6a0ae73d95956f7e ("PM / Domain: Add support to parse
> domain's OPP table"), of_genpd_add_provider_simple() fills in
> the dev.of_node field in the generic_pm_domain structure.
> 
> Hence cpg_mssr_is_pm_clk() can use that instead of its own copy in the
> driver-private cpg_mssr_clk_domain structure.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

