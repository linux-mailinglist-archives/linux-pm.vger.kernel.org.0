Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F37A42A665
	for <lists+linux-pm@lfdr.de>; Tue, 12 Oct 2021 15:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236993AbhJLNuW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Oct 2021 09:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236678AbhJLNuV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Oct 2021 09:50:21 -0400
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989EEC061570;
        Tue, 12 Oct 2021 06:48:19 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 7D39F426A2;
        Tue, 12 Oct 2021 13:48:12 +0000 (UTC)
Subject: Re: [RFC PATCH 3/9] dt-bindings: clock: Add apple,cluster-clk binding
To:     Viresh Kumar <viresh.kumar@linaro.org>
References: <20211011165707.138157-1-marcan@marcan.st>
 <20211011165707.138157-4-marcan@marcan.st>
 <0fe602f6-3adc-dfac-beee-2854b01cec5c@canonical.com>
 <20211012093529.pzzfo44ikq5oc6cl@vireshk-i7>
 <D0DE08FE-562E-4A48-BCA0-9094DAFCA564@marcan.st>
 <20211012094302.3cownyzr4phxwifs@vireshk-i7>
 <64584F8C-D49F-41B5-9658-CF8A25186E67@marcan.st>
 <20211012095735.mhh2lzu52ohtotl6@vireshk-i7>
Cc:     Hector Martin <marcan@marcan.st>,
        linux-arm-kernel@lists.infradead.org,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sven Peter <sven@svenpeter.dev>, Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <0168a91d-0e7d-41df-8a65-bc739fc50498@marcan.st>
Date:   Tue, 12 Oct 2021 22:48:09 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211012095735.mhh2lzu52ohtotl6@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/10/2021 18.57, Viresh Kumar wrote:
> I didn't realize earlier that we have moved out of lists :)

Whoops, sorry, I was on mobile and must've hit the wrong reply button! 
My apologies.

> On 12-10-21, 18:54, Hector Martin "marcan" wrote:
>> Typically cpufreq-dt is used with clock drivers that directly take
>> the clock frequency and do whatever voodoo is necessary to set it
>> for the CPU. But here, the hardware just wants to know the index,
>> and does everything itself. So we need to encode that somewhere, to
>> avoid hardcoding it in the clock driver.
>>
>> In general, based on how these SoCs are designed, we're trying to
>> avoid having tables of volatile information in the drivers, and
>> instead keep everything in the DT. This means we have a good chance
>> that these drivers will continue to work with future SoC
>> generations, since Apple doesn't change register definitions
>> randomly most of the time.
> 
> Yeah I get that and it is actually better this way. I just wanted to
> point out that we didn't think of it this way earlier :)

Yeah, makes sense. Seems to work fine :)


-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
