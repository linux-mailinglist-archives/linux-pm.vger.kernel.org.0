Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2A2D1D44F3
	for <lists+linux-pm@lfdr.de>; Fri, 15 May 2020 06:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbgEOEs7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 May 2020 00:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726246AbgEOEs6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 May 2020 00:48:58 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA721C05BD09
        for <linux-pm@vger.kernel.org>; Thu, 14 May 2020 21:48:57 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id i15so1798382wrx.10
        for <linux-pm@vger.kernel.org>; Thu, 14 May 2020 21:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EyTbMaSjEg6fQvgk3wUtXbrwuxV/n8kuNdG89Y81Dfc=;
        b=nteVbU4Yo4gHksL8unhzbaZyHtjm6dqN5Ecmm2nGdcrbIlO9OLCkG+SXV9xh7Hei5l
         AAcxs6RYU/fYlmx1MCzUJ/bsAa9ff0+iB9Ti3xLboy4cyv71LjEJoMeOy2svT3sZPuZ+
         30VuuRRNRb8nbH3+ipxbVyiObydBkSehJ/UJSFxV2GQRI24udWnlGyGgxGcn86FkOrfs
         7/oU5iV4wXpkVXTqzhJKwnaIn4LC6/N555nKuGLuuaFtKGP9kzggoIp7+tPq+kQ/EHks
         Dv+e1gb4RfTbtXtRwRrf0O99x6LQ+ct8fmytYBB4xpN7IVB2SBdxEZaY3u3Fw39AHWnM
         iAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EyTbMaSjEg6fQvgk3wUtXbrwuxV/n8kuNdG89Y81Dfc=;
        b=gbFZ1YHLJjGlBQc995bRU3IFeMKN8W3+FiZ1VE0q+fGhIu6oUqe8P1FqFN+88t02wx
         2hl+23dPnVA9RcBy5gIY7sq6Ypm//jjEEfsNV6TJAuIUOn4j20tNDya0wtVaPjzjHuuB
         Xedssx/QhoO0Dqiakgn1BCHYswtWKrLdbt0DX1AE1FJI/dEha5SX4UwjbsCul/rgpt2x
         3Ft/NwasrYp4GwoCr28exCxihuyiQbLI/Pwh+JSP93OMrCmN/sK0mkU0r+tjB7QbFn9u
         RO/yyWkmO4cfEj1AvXM4g1GGLV8Bjagvrfc+okRnSAM5qVLcVGL04RhCkuNf8VzQ8+Ai
         QO0w==
X-Gm-Message-State: AOAM5331HLldh2Vogqe3X/8t2VOVtCsacur0urVtUMB1o9DMzhmrnYqV
        +5XN1BYGyxyHVCA0kQTwr+5q1ShC7uk=
X-Google-Smtp-Source: ABdhPJwg3J4YNB1AjmPweAMPkS2QgQCTL29ywUSR9jowW9uqzmUipXM4BXx0dNHcdAn+lScwH/Bk0w==
X-Received: by 2002:a5d:6750:: with SMTP id l16mr1999765wrw.295.1589518136320;
        Thu, 14 May 2020 21:48:56 -0700 (PDT)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id 60sm1680232wrp.92.2020.05.14.21.48.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 May 2020 21:48:55 -0700 (PDT)
Subject: Re: [PATCH] interconnect: Disallow interconnect core to be built as a
 module
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Matthias Kaehlcke <mka@chromium.org>
References: <b789cce388dd1f2906492f307dea6780c398bc6a.1567065991.git.viresh.kumar@linaro.org>
 <CAOCOHw4ri6ikRpkJWtAdaPQiMhdKMrdNciqQ8YNaXR+ApSnAew@mail.gmail.com>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <66c3d470-48e2-619a-dd95-6064a85161e0@linaro.org>
Date:   Fri, 15 May 2020 07:48:47 +0300
MIME-Version: 1.0
In-Reply-To: <CAOCOHw4ri6ikRpkJWtAdaPQiMhdKMrdNciqQ8YNaXR+ApSnAew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 9/12/19 19:33, Bjorn Andersson wrote:
> On Thu, Aug 29, 2019 at 1:07 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>>
>> Building individual drivers as modules is fine but allowing a core
>> framework to be built as a module makes it really complex and should be
>> avoided.
>>
>> Whatever uses the interconnect core APIs must also be built as a module
>> if interconnect core is built as module, else we will see compilation
>> failures.
>>
>> If another core framework (like cpufreq, clk, etc), that can't be built
>> as module, needs to use interconnect APIs then we will start seeing
>> compilation failures with allmodconfig configurations as the symbols
>> (like of_icc_get()) used in other frameworks will not be available in
>> the built-in image.
>>
>> Disallow the interconnect core to be built as a module to avoid all
>> these issues.

Hi Greg,

We had a discussion [1] a few months back about frameworks being built as
modules. IIUC, you initially expressed some doubts about this patch, so i
wanted to check with you again on this.

While i think that the possibility for a framework core to be a module is a
nice feature, and we should try to be as modular as possible, it seems that
handling dependencies between the different core frameworks becomes difficult
when one of them is tristate.

This of course affects the drivers which use it (every client should express
the dependency in Kconfig as a "depends on framework || !framework"), in order
to avoid build failures in the case when framework=m and client=y. However, this
is not a big issue.

But it gets more complex when another framework2 becomes a client of the modular
framework and especially when framework2 is "select"-ed in Kconfig by it's
users. When selects are used in Kconfig, it forces the option, without ever
visiting the dependencies. I am not sure what we should do in this case, maybe
we can continue and sprinkle more "depends on framework || !framework" also for
every single user which selects framework2.. But i believe that this is very
inconvenient.

Well, the above is not impossible, but other frameworks (regulator, clk, reset,
pinctrl, etc.) are solving this problem by just being bool, instead of tristate.
This makes life much easier for everyone. So i am wondering if it wouldn't be
more appropriate to use the same approach here too?

Thanks,
Georgi

[1] https://lore.kernel.org/linux-pm/20191107142111.GB109902@kroah.com/

>>
> 
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>> ---
>>  drivers/interconnect/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/interconnect/Kconfig b/drivers/interconnect/Kconfig
>> index bfa4ca3ab7a9..b6ea8f0a6122 100644
>> --- a/drivers/interconnect/Kconfig
>> +++ b/drivers/interconnect/Kconfig
>> @@ -1,6 +1,6 @@
>>  # SPDX-License-Identifier: GPL-2.0-only
>>  menuconfig INTERCONNECT
>> -       tristate "On-Chip Interconnect management support"
>> +       bool "On-Chip Interconnect management support"
>>         help
>>           Support for management of the on-chip interconnects.
>>
>> --
>> 2.21.0.rc0.269.g1a574e7a288b
>>
