Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DCE77A00B
	for <lists+linux-pm@lfdr.de>; Sat, 12 Aug 2023 14:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjHLM5Q convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Sat, 12 Aug 2023 08:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjHLM5P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 12 Aug 2023 08:57:15 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754E010F
        for <linux-pm@vger.kernel.org>; Sat, 12 Aug 2023 05:57:17 -0700 (PDT)
Received: from i53875bbf.versanet.de ([83.135.91.191] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qUoB9-0000Ut-1g; Sat, 12 Aug 2023 14:57:15 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, Jagan Teki <jagan@edgeble.ai>
Cc:     Jagan Teki <jagan@edgeble.ai>, linux-pm@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 01/14] genpd: rockchip: Add PD_VO entry for rv1126
Date:   Sat, 12 Aug 2023 14:57:14 +0200
Message-ID: <3694249.5fSG56mABF@diego>
In-Reply-To: <5699457.DvuYhMxLoT@diego>
References: <20230731110012.2913742-1-jagan@edgeble.ai>
 <20230731110012.2913742-2-jagan@edgeble.ai> <5699457.DvuYhMxLoT@diego>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Am Montag, 31. Juli 2023, 22:48:45 CEST schrieb Heiko Stübner:
> Am Montag, 31. Juli 2023, 12:59:59 CEST schrieb Jagan Teki:
> > PD_VO power-domain entry in RV1126 are connected to
> > - BIU_VO
> > - VOP
> > - RGA
> > - IEP
> > - DSIHOST
> > 
> > Add an entry for it.
> > 
> > Signed-off-by: Jagan Teki <jagan@edgeble.ai>
> 
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> 
> @Ulf: now that we have a genpd subsystem, I assume you're going
> to pick up this patch, right?

Looking at other soc trees, it looks like genpd changes right now are
often still going through these ... so I've gone forward, merged the
genpd shared tag and applied this patch on top in my rockchip drivers
branch.


