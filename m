Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24B43422DA5
	for <lists+linux-pm@lfdr.de>; Tue,  5 Oct 2021 18:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236435AbhJEQRU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Oct 2021 12:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235077AbhJEQRU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Oct 2021 12:17:20 -0400
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B29C061749;
        Tue,  5 Oct 2021 09:15:29 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id D599E41EA7;
        Tue,  5 Oct 2021 16:15:23 +0000 (UTC)
Subject: Re: [PATCH 3/7] soc: apple: Add driver for Apple PMGR power state
 controls
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
References: <20211005155923.173399-1-marcan@marcan.st>
 <20211005155923.173399-4-marcan@marcan.st>
 <CACRpkdanbovvXXLAGGZEEiKXXrNnW+8p1sCONQYWmAjVi-m-9A@mail.gmail.com>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <3bad7bc3-30ac-851f-57a3-7781dfa23521@marcan.st>
Date:   Wed, 6 Oct 2021 01:15:21 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdanbovvXXLAGGZEEiKXXrNnW+8p1sCONQYWmAjVi-m-9A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Linus,

On 06/10/2021 01.08, Linus Walleij wrote:
> Hi Hector,
> 
> On Tue, Oct 5, 2021 at 6:00 PM Hector Martin <marcan@marcan.st> wrote:
> 
>>   drivers/soc/apple/Kconfig               |  21 ++
>>   drivers/soc/apple/Makefile              |   2 +
>>   drivers/soc/apple/apple-pmgr-pwrstate.c | 281 ++++++++++++++++++++++++
> 
> This is traditionally where we put the ARM SoC drivers, but
> Mac has traditionally used drivers/macintosh for their custom
> board etc stuff. Or is that just for any off-chip stuff?
> 
> I suppose it doesn't matter much (unless there is code under
> drivers/macintosh we want to reuse for M1), but it could be a bit
> confusing?

Hmm, it seems that tree is mostly about the PowerPC era Macs; the only 
thing enabled for x86 there is MAC_EMUMOUSEBTN. There is also 
platform/x86/apple-gmux.c for an x86 Mac specific thing...

We already broke tradition with the "apple," DT compatible prefix (used 
to be AAPL for the PowerPC Macs), and these chips aren't even just used 
in Macs (e.g. the iPad, which in theory people would be able to run 
Linux on if someone figures out a jailbreak), so perhaps it's time for 
another break here?

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
