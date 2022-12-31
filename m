Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56BCE65A402
	for <lists+linux-pm@lfdr.de>; Sat, 31 Dec 2022 13:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbiLaMg2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 31 Dec 2022 07:36:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiLaMg1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 31 Dec 2022 07:36:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F7825D2;
        Sat, 31 Dec 2022 04:36:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2C41B8072F;
        Sat, 31 Dec 2022 12:36:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 273F7C433EF;
        Sat, 31 Dec 2022 12:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672490183;
        bh=AlDCe2TjRTLpygj95Yb8msnF3BxBNpHLeKVwbNGCdRs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sh3Quj73EeuIJRPiBk1Hv25d+tqD81RlTEmVSbC9D8sQWEvmKf3w0VUSGFpfRGoTQ
         hnmAvVSnvCa8i8vY8ZNM/wgcEEn4BSfUUVqmbHsPREGuQ3gT6laK67rj9BqbKs05A2
         j6N7HpCHid1EHMkMMDIYUMs2/pF0yufuRTQbRNogOrTdObYDrMHptWVC33v+JVUDLg
         n3Zi/h9sOpErvJUBG2h2TBYbMXf/euPUskcJIlbehxkoEIUjAqnZW7kmKeE/Nq4/1s
         quLrQw+ZJUbdsle3kLbAEAedCpaIV1FkR8bt2zEdJtA0yhj0/xCMcBYmxIlkjKBjJt
         DCE4yA+UxPI2g==
Date:   Sat, 31 Dec 2022 20:36:14 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Marek Vasut <marex@denx.de>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>, Adam Ford <aford173@gmail.com>,
        Alice Guo <alice.guo@nxp.com>,
        Amit Kucheria <amitk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Jun <jun.li@nxp.com>, Lucas Stach <l.stach@pengutronix.de>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/5] arm64: dts: imx8m: Align SoC unique ID node unit
 address
Message-ID: <20221231123608.GS6112@T480>
References: <20221202162353.274009-1-marex@denx.de>
 <20221202162353.274009-2-marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202162353.274009-2-marex@denx.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Dec 02, 2022 at 05:23:50PM +0100, Marek Vasut wrote:
> Align the SoC unique ID DT node unit address with its reg property.
> 
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> Fixes: cbff23797fa1 ("arm64: dts: imx8m: add NVMEM provider and consumer to read soc unique ID")
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied 2/5, 3/5 and 4/5, thanks!
