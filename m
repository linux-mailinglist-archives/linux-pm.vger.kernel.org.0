Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5FB5B16F1
	for <lists+linux-pm@lfdr.de>; Thu,  8 Sep 2022 10:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbiIHI1H (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Sep 2022 04:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbiIHI04 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Sep 2022 04:26:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A4C65261;
        Thu,  8 Sep 2022 01:26:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FA3661BB6;
        Thu,  8 Sep 2022 08:26:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE97DC433D6;
        Thu,  8 Sep 2022 08:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662625608;
        bh=sUV1o+v0ToEvegmITvK2iEIUqmKV/m3rYGgJK8I5bXo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YDdQxLRaqSCeBvC9ZukfdGmSyufC9gKMA4ERIeJiAAxBp5luh/a0aasgsNRK6dzLR
         Lu/hUuEwTQtBYiit/vU9uOp+DWrh25bcJEV4FU6eS4jh8XZxRPPxpAPVbZrf8e1GVt
         a3/LjxtZ7AUwBimJg4mZf9s/8rtOZf+mrEe+rUrAjojgab55/cVLdESxb1GELdDiLc
         UZ8KbXhziWLxwO1Wm7sm8DtZ5LV8H79gbgxnMHPYyrFtsFtlIN8+IXnfZXNCDktDeU
         eC2fHj9AEf/oOL2FTdteclrfdLpdchacreX41feRZTfGujUutUoYVpORwD8vVp7A0Z
         t4GaJL/nqq5Xw==
Date:   Thu, 8 Sep 2022 09:26:41 +0100
From:   Lee Jones <lee@kernel.org>
To:     Chris Morgan <macroalpha82@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, zhangqing@rock-chips.com,
        zyw@rock-chips.com, jon.lin@rock-chips.com,
        maccraft123mc@gmail.com, sre@kernel.org, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        philip@pscan.uk, mazziesaccount@gmail.com,
        Chris Morgan <macromorgan@hotmail.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH V10 2/4] mfd: Add Rockchip rk817 battery charger support
Message-ID: <YxmnQQWijnhlSGr4@google.com>
References: <20220827021623.23829-1-macroalpha82@gmail.com>
 <20220827021623.23829-3-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220827021623.23829-3-macroalpha82@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 26 Aug 2022, Chris Morgan wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add rk817 charger support cell to rk808 mfd driver.
> 
> Acked-for-mfd-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
> ---
>  drivers/mfd/rk808.c       | 16 ++++++-
>  include/linux/mfd/rk808.h | 91 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 106 insertions(+), 1 deletion(-)

Already applied.

-- 
Lee Jones [李琼斯]
