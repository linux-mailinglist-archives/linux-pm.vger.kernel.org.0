Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D81B2285B9A
	for <lists+linux-pm@lfdr.de>; Wed,  7 Oct 2020 11:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbgJGJJq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Oct 2020 05:09:46 -0400
Received: from gloria.sntech.de ([185.11.138.130]:50366 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbgJGJJq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 7 Oct 2020 05:09:46 -0400
X-Greylist: delayed 1824 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Oct 2020 05:09:45 EDT
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1kQ4ye-0004RV-Bl; Wed, 07 Oct 2020 10:39:12 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Nishanth Menon <nm@ti.com>, linux-pm@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Niklas Cassel <nks@flawful.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 2/4] power: avs: rockchip-io: Move the driver to the rockchip specific drivers
Date:   Wed, 07 Oct 2020 10:39:11 +0200
Message-ID: <1739403.NJMpfr3yiC@diego>
In-Reply-To: <20201006160516.319830-3-ulf.hansson@linaro.org>
References: <20201006160516.319830-1-ulf.hansson@linaro.org> <20201006160516.319830-3-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Am Dienstag, 6. Oktober 2020, 18:05:14 CEST schrieb Ulf Hansson:
> The avs drivers are all SoC specific drivers that doesn't share any code.
> Instead they are located in a directory, mostly to keep similar
> functionality together. From a maintenance point of view, it makes better
> sense to collect SoC specific drivers like these, into the SoC specific
> directories.
> 
> Therefore, let's move the rockchip-io driver to the rockchip directory.
> 
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: linux-rockchip@lists.infradead.org
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Heiko Stuebner <heiko@sntech.de>



