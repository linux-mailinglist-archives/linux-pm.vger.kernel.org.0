Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 553452B80B2
	for <lists+linux-pm@lfdr.de>; Wed, 18 Nov 2020 16:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbgKRPiR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Nov 2020 10:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbgKRPiR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Nov 2020 10:38:17 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF287C0613D4;
        Wed, 18 Nov 2020 07:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Zf0CbfUHIhnvDFMKv+8Giay1yr/S37jdUNiHj2HQ00A=; b=DKzWIx4HrI9alopXCxMPPuurtE
        AsVTthYov+Aam6YQGXLsigD7P5kJIdQh7v8eDg/lATDX3cfFQ8ZO7Hm2LZ6m55L9F3N8ajF0kFoJs
        Yi/rW72Nxn9M0yhTLgHRe8yyDI0wL25/oNQRsiPXNkLjt5xxdNbU0UI34Sh7K3juPxn0=;
Received: from p200300ccff0a3a001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0a:3a00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1kfPX6-0003lN-DA; Wed, 18 Nov 2020 16:38:08 +0100
Date:   Wed, 18 Nov 2020 16:38:07 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Nishanth Menon <nm@ti.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <lkft-triage@lists.linaro.org>, <linux-pm@vger.kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] regulator: ti-abb: Fix array out of bound read access
 on the first transition
Message-ID: <20201118163807.3783192c@aktux>
In-Reply-To: <20201118145009.10492-1-nm@ti.com>
References: <20201118145009.10492-1-nm@ti.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Wed, 18 Nov 2020 08:50:09 -0600
Nishanth Menon <nm@ti.com> wrote:

> At the start of driver initialization, we do not know what bias
> setting the bootloader has configured the system for and we only know
> for certain the very first time we do a transition.
> 
> However, since the initial value of the comparison index is -EINVAL,
> this negative value results in an array out of bound access on the
> very first transition.
> 
> Since we don't know what the setting is, we just set the bias
> configuration as there is nothing to compare against. This prevents
> the array out of bound access.
> 
> NOTE: Even though we could use a more relaxed check of "< 0" the only
> valid values(ignoring cosmic ray induced bitflips) are -EINVAL, 0+.
> 
> Fixes: 40b1936efebd ("regulator: Introduce TI Adaptive Body Bias(ABB) on-chip LDO driver")
> Link: https://lore.kernel.org/linux-mm/CA+G9fYuk4imvhyCN7D7T6PMDH6oNp6HDCRiTUKMQ6QXXjBa4ag@mail.gmail.com/
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> 
> Mark,
> 
> I will leave it to your descretion if this needs to be tagged for
> stable or to drop the Fixes tag - Side effect, if this occurs, will be
> an unstable system very hard to track down - but typically occurring
> during system boot - Impacts systems: DM3/OMAP3,4,5,DRA7/AM5x.
> 
> I would categorize this as "This could be a problem..." problem..
> the bug is an out of bound read, and has been around since v3.11 and is
> not a catastrophic data corruption kind of issue.
> 
> Though theoretically, there is a possibility that the compare may
> pass and result in missing bias configuration(and resulting system
> will be unstable), I have'nt heard of actual report (but, it will be
> surprising if any actual instability was actually tracked down to this
> bug). Any ways, I had to go to git full history to pick the exact
> commit - I have left it in the patch.
> 
> 
Hmm so probably these boot problems which only occur when your debug
cable is not attached?

Is there any connection with commits like this:
ARM: dts: omap36xx: using OPP1G needs to control the abb_ldo

So would the potential problem be more probable by patches like the
that one mentioned above?

Regards,
Andreas
