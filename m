Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C20701B34
	for <lists+linux-pm@lfdr.de>; Sun, 14 May 2023 04:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjENCck (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 13 May 2023 22:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjENCcj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 13 May 2023 22:32:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFD92130;
        Sat, 13 May 2023 19:32:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E864861491;
        Sun, 14 May 2023 02:32:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 850C4C433D2;
        Sun, 14 May 2023 02:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684031557;
        bh=sc8UrLU9bo7pQFPgnJPVQgPMdYWPTHV76oVXH1yQ2AE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I2LbixDJa5CO0sa33Glfx6FSbrCkYbFMusB55WLtTGdpkdXw/8hSVSflSnFD5CSpi
         itvewSz2ZSY5lOQlFvd9EraxKA79s/VGOQD0Rz/MGyqIMCiU5K5ncPo60bOphoBzxu
         2h0n8YwyX/pzW7DFyA7J7xyXMyd/AdiCm4GEdn/Fu5e4XlYKgihI7GXidUbBTUcD5K
         BQ/znbT5RyERmzxRUzWJ2A8USeazmJvKc7mQJCRM+mooSQCEkw1ea263a/fYK92SGu
         5M/51hoazdfTe5rXR08zPb/TNEZRtROx+0oMrx4v5UA9J1Mmp00InheM7jc7Cb5vZX
         hJl0Na02paMZw==
Date:   Sun, 14 May 2023 10:32:22 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de,
        Fabio Estevam <festevam@gmail.com>, linux-imx@nxp.com,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Jacky Bai <ping.bai@nxp.com>
Subject: Re: [PATCH V3 6/6] ARM: dts: imx6ul: Add clock and PGC node to GPC
Message-ID: <20230514023222.GH727834@dragon>
References: <20230414091947.7831-1-stefan.wahren@i2se.com>
 <20230414091947.7831-7-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414091947.7831-7-stefan.wahren@i2se.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Apr 14, 2023 at 11:19:47AM +0200, Stefan Wahren wrote:
> According to fsl,imx-gpc.yaml the General Power Control requires
> a ipg clock and a Power Gating Control node. So add them to fix
> the dtbs_check warnings on i.MX6UL boards:
> 
> gpc@20dc000: 'clocks' is a required property
> gpc@20dc000: 'clock-names' is a required property
> gpc@20dc000: 'pgc' is a required property
> 
> Suggested-by: Jacky Bai <ping.bai@nxp.com>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Applied, thanks!
