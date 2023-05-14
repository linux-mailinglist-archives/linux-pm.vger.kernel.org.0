Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4635C701B2F
	for <lists+linux-pm@lfdr.de>; Sun, 14 May 2023 04:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjENCam (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 13 May 2023 22:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjENCal (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 13 May 2023 22:30:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB852130;
        Sat, 13 May 2023 19:30:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F299C61232;
        Sun, 14 May 2023 02:30:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E98B8C433D2;
        Sun, 14 May 2023 02:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684031439;
        bh=K8z4msTDWrINW1KUS2sZfaj4ZFghKPB1pjFp8U06XIg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NHuNnC9/0qv/2GSNLS0AMudMB2l2KxVhfgvaF1HXnLycNDyQ63AtxSUfoZC//6nMh
         30mnzDZU/o+BYN0sbn5hKLExZNYVSxST2MWqIWEAO22nL1T1Pv1WRK5Ph/A13cC8Og
         tsyDtuEJ7EQ783ZRFjyYxLRtakER5q/q5rAltJNLuC75QbwdOEkZ/m+ci7CXyHkp3I
         bguj3CfiPPKsnWrHONgLhfgUrvNVysj/ejHrkaLPAF0KT2g5wz3vHifzKYz/07ZN6n
         mTM2WPRrN8TqVLLetLD18V4wbRj6WMhoB4V6T5g0hMhOqJeVh4VDkrDBo77oLAZLpp
         wGsad3y2AIfPQ==
Date:   Sun, 14 May 2023 10:30:23 +0800
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
        linux-pm@vger.kernel.org
Subject: Re: [PATCH V3 5/6] ARM: dts: imx: Adjust dma-apbh node name
Message-ID: <20230514023023.GG727834@dragon>
References: <20230414091947.7831-1-stefan.wahren@i2se.com>
 <20230414091947.7831-6-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414091947.7831-6-stefan.wahren@i2se.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Apr 14, 2023 at 11:19:46AM +0200, Stefan Wahren wrote:
> Currently the dtbs_check generates warnings like this:
> 
> $nodename:0: 'dma-apbh@110000' does not match '^dma-controller(@.*)?$'
> 
> So fix all affected dma-apbh node names.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Applied, thanks!
