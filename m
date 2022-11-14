Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F50628A74
	for <lists+linux-pm@lfdr.de>; Mon, 14 Nov 2022 21:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236823AbiKNUcU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Nov 2022 15:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236559AbiKNUcT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Nov 2022 15:32:19 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94035102;
        Mon, 14 Nov 2022 12:32:17 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 7E188833F9;
        Mon, 14 Nov 2022 21:32:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1668457935;
        bh=9YyOSpKzqVVws+Y9bNHk1/QJAvQGfurrcCfXg7JraVI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gXuSAEWmcLjvoIj7RYKkTRkklx+oGIsBKGCaPTLmx2CQggrvkzUaDWDBgoQliC4sb
         1qR6pftyLU/jiIkTfZ34N98RHZZnFR3W7ryJkvuIcLs5IPG3b40hf8IVgr55K5te4Y
         ONse+XjUsp/KWJghgmcNDza9Ye14iBpI/Lq9RTS3IAO82dQqXS5wTpUl/TrewVISiP
         N7EIt8R0OAM4F0FMbNvNiOfWlAqcKnjKoPJDAW+PNmhLMjZIkI/Oj24t85Dt3luoGG
         U/RxTWSemvE3C//SGKNLad0lEgJSugxJJxTpdkjACjgAaehIfvCfzVF6P6Obp+qkmV
         kAz83lKq4jnDw==
Message-ID: <52578b45-cf4c-e949-b2b1-a0f251815337@denx.de>
Date:   Mon, 14 Nov 2022 21:32:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 1/3] [RFC] PM: domains: Introduce .power_pre/post_on/off
 callbacks
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-pm@vger.kernel.org, Adam Ford <aford173@gmail.com>,
        Fabio Estevam <festevam@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Kevin Hilman <khilman@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Len Brown <len.brown@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        Martin Kepplinger <martink@posteo.de>,
        Pavel Machek <pavel@ucw.cz>, Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-imx@nxp.com
References: <20221108013517.749665-1-marex@denx.de>
 <CAPDyKFoUdfUjZMgzU-3SS0gVstj-04FbTSjxihdar2wxu5c97w@mail.gmail.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <CAPDyKFoUdfUjZMgzU-3SS0gVstj-04FbTSjxihdar2wxu5c97w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/14/22 20:40, Ulf Hansson wrote:
> On Tue, 8 Nov 2022 at 02:35, Marek Vasut <marex@denx.de> wrote:
>>
>> Currently it is possible that a power domain power on or off would claim
>> the genpd lock first and clock core prepare_lock second, while another
>> thread could do the reverse, and this would trigger lockdep warning.
> 
> I am not quite sure I fully understand. In this case is the lockdep
> warning relevant or just something that we want to silence?

This is a valid problem, see patches 2/3 and 3/3 for details too.

>> Introduce new callbacks, .power_pre/post_on() and .power_off_pre/post(), which
>> are triggered before the genpd_lock() and after genpd_unlock() respectively in
>> case the domain is powered on and off. Those are meant to let drivers claim
>> clock core prepare_lock via clk_*prepare() call and release the lock via
>> clk_*unprepare() call to always assure that the clock and genpd lock ordering
>> is correct.
> 
> To me, this sounds like a problem that may be better fixed by trying
> to model the parent/child-domains in a more strict way, through genpd.
> 
> There is a comment in the code in imx8mp_blk_ctrl_probe() that seems
> to be pointing in this direction too.
> 
> "* We use runtime PM to trigger power on/off of the upstream GPC
>    * domain, as a strict hierarchical parent/child power domain
>    * setup doesn't allow us to meet the sequencing requirements......"
> 
> I am wondering about what those "sequencing requirements" are - and
> whether it could make better sense to fix these issues instead?

Here is the lockdep splat:

https://lore.kernel.org/all/Y1cs++TV2GCuh4tS@pendragon.ideasonboard.com/

It really is a problem between the clock and genpd subsystem locks, they 
can be claimed in arbitrary order, see patch 2/3 and 3/3.

I think that might clarify what I am attempting to solve here.

[...]
