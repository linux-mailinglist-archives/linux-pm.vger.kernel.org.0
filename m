Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0DA4783A4B
	for <lists+linux-pm@lfdr.de>; Tue, 22 Aug 2023 09:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbjHVHGa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Aug 2023 03:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233156AbjHVHG3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Aug 2023 03:06:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5641B0
        for <linux-pm@vger.kernel.org>; Tue, 22 Aug 2023 00:06:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BEDB6417A
        for <linux-pm@vger.kernel.org>; Tue, 22 Aug 2023 07:06:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58984C433C7;
        Tue, 22 Aug 2023 07:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692687985;
        bh=zGBDUxjIvZcPtg0R5Ea1vqqrPZXmIjW0tJmo05UyV2w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D+845Wz02SgTgXrdg0yrrCpnyHfNVqozPaP+/t2NsJwHnczswD4OY0FYAzQGC0wJM
         H4oVcXHnQhGCmuxCBRfTZOq25+CBdyWX5COetGV1Mup50/epsrjb8pyNvHDnOBkMnI
         mrqIH26DD5BdRnZCy5Ay/h3KvGvZfpJLsmIumDlD+zu36gO8BL+trAzQtGad2oKOzn
         Px7Vogjw+hgr8BtwRh0RNDMZCXDtMjCWTPrUcjO6F+vivAiRsrhRoLkSw9EKjHXciq
         /NNWb3MPJvaqvU83a4awxo8lMemzfsdhfED2Nr6ikHZJAtdd5ZrH1OalCSVIkqOEcW
         drVelCZqUMO5Q==
Date:   Tue, 22 Aug 2023 08:06:21 +0100
From:   Lee Jones <lee@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-pm@vger.kernel.org, sre@kernel.org, jahau@rocketmail.com
Subject: Re: [PATCH -next] power: supply: rt5033_charger: fix missing unlock
Message-ID: <20230822070621.GO1380343@google.com>
References: <20230822030207.644738-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230822030207.644738-1-yangyingliang@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 22 Aug 2023, Yang Yingliang wrote:

> Fix missing mutex_unlock() in some error path.
> 
> Fixes: 12cc585f36b8 ("power: supply: rt5033_charger: Add cable detection and USB OTG supply")

Okay, this patch is causing too much trouble now.

Sebastian would you be able to take it instead please?

(I'm going to reply to it now to say that I'm removing it)

> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/power/supply/rt5033_charger.c | 28 ++++++++++++++++++---------
>  1 file changed, 19 insertions(+), 9 deletions(-)

-- 
Lee Jones [李琼斯]
