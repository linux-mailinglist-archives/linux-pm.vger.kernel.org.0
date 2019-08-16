Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1D6902F0
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2019 15:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbfHPN0A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Aug 2019 09:26:00 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:54980 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbfHPN0A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Aug 2019 09:26:00 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 659A725AD7A;
        Fri, 16 Aug 2019 23:25:58 +1000 (AEST)
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 6082F94057D; Fri, 16 Aug 2019 15:25:56 +0200 (CEST)
Date:   Fri, 16 Aug 2019 15:25:56 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] soc: renesas: rmobile-sysc: Set GENPD_FLAG_ALWAYS_ON for
 always-on domain
Message-ID: <20190816132556.hog2kzx2p7gqbyi7@verge.net.au>
References: <20190816124106.15383-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816124106.15383-1-geert+renesas@glider.be>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Aug 16, 2019 at 02:41:06PM +0200, Geert Uytterhoeven wrote:
> Currently the R-Mobile "always-on" PM Domain is implemented by returning
> -EBUSY from the generic_pm_domain.power_off() callback, and doing
> nothing in the generic_pm_domain.power_on() callback.  However, this
> means the PM Domain core code is not aware of the semantics of this
> special domain, leading to boot warnings like the following on
> SH/R-Mobile SoCs:
> 
>     sh_cmt e6130000.timer: PM domain c5 will not be powered off
> 
> Fix this by making the always-on nature of the domain explicit instead,
> by setting the GENPD_FLAG_ALWAYS_ON flag.  This removes the need for the
> domain to provide power control callbacks.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
