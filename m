Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06A4F42D4E8
	for <lists+linux-pm@lfdr.de>; Thu, 14 Oct 2021 10:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhJNIdj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Oct 2021 04:33:39 -0400
Received: from marcansoft.com ([212.63.210.85]:38746 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229970AbhJNIdj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 14 Oct 2021 04:33:39 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 1C86A41EA2;
        Thu, 14 Oct 2021 08:31:27 +0000 (UTC)
Subject: Re: [RFC PATCH 6/9] memory: apple: Add apple-mcc driver to manage MCC
 perf in Apple SoCs
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sven Peter <sven@svenpeter.dev>, Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211011165707.138157-1-marcan@marcan.st>
 <20211011165707.138157-7-marcan@marcan.st>
 <a9f6898d-bd76-b94e-52fc-98e9da1a04bd@canonical.com>
 <2a6f14e5-fbc9-4b9a-9378-a4b5200bc3fb@marcan.st>
 <f81467d4-74b2-176d-06bf-f04e073efce4@canonical.com>
 <00925242-b837-d75b-3655-536d45dcd4d2@marcan.st>
 <410c0ccb-68d3-478b-2b5b-9165890e614a@canonical.com>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <839339f3-7c12-32aa-cd37-e91d824cfdbe@marcan.st>
Date:   Thu, 14 Oct 2021 17:31:25 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <410c0ccb-68d3-478b-2b5b-9165890e614a@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 14/10/2021 17.04, Krzysztof Kozlowski wrote:
>> It is; only modules with a GPL-compatible MODULE_LICENSE get to use
>> symbols exported via EXPORT_SYMBOL_GPL.
> 
> Although there might be such correlation but it's not a rule. You can
> have a GPL module exporting symbols without GPL requirement
> (EXPORT_SYMBOLS). You can have a GPL+MIT module exporting symbols as
> GPL. Obviously you cannot have a non-GPL module, as we do not accept
> these and there is no such choice.

What I mean is that modules can only import GPL symbols if they 
themselves are GPL compatible. What I didn't know is that "Dual MIT/GPL" 
is a valid string for MODULE_LICENSE to qualify as such.

>> See kernel/module.c for the symbol lookup logic and
>> include/linux/license.h for the logic to check the string (seems like
>> "Dual MIT/GPL" is explicitly whitelisted there).
> 
> Not related to export symbol. It is used for determining the tainted
> kernel via other licenses.
> 

Not just that; that module taint is used as a filter so that 
non-GPL-compatible modules are technically prevented from resolving 
EXPORT_SYMBOL_GPL symbols.

>> Of course, this is a futile effort, as ~every time I see a proprietary
>> module in some embedded device, it either falsely declares itself to be
>> GPL, or they have a shim module that re-exports GPL symbols as non-GPL.
>>
> 
> This is being removed soon (or already).

? Good luck getting proprietary embedded vendors to start following 
licenses... :)

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
