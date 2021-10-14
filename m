Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6349E42D418
	for <lists+linux-pm@lfdr.de>; Thu, 14 Oct 2021 09:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbhJNHyQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Oct 2021 03:54:16 -0400
Received: from marcansoft.com ([212.63.210.85]:57432 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230049AbhJNHyO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 14 Oct 2021 03:54:14 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id B237741AC8;
        Thu, 14 Oct 2021 07:52:03 +0000 (UTC)
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
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [RFC PATCH 6/9] memory: apple: Add apple-mcc driver to manage MCC
 perf in Apple SoCs
Message-ID: <00925242-b837-d75b-3655-536d45dcd4d2@marcan.st>
Date:   Thu, 14 Oct 2021 16:52:01 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <f81467d4-74b2-176d-06bf-f04e073efce4@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 14/10/2021 16.36, Krzysztof Kozlowski wrote:
> On 14/10/2021 08:59, Hector Martin wrote:
>>> Don't you have a limit of supported channels? It cannot be any uint32...
>>
>> Today, it's max 8. But if come Monday we find out Apple's new chips have
>> 16 channels and otherwise the same register layout, I'd much rather not
>> have to change the driver...
> 
> OK, however if the driver ever receives different DT with a different
> value, it will accept it unconditionally and go via address space. I am
> just saying that being conservative on received values is safer, but I
> am fine with skipping this problem. At the end we trust DT that it will
> always match the kernel, don't we? Oh wait, someone can use DT from
> other kernel in this one...

DTs using these compatibles should have the same register layout, and 
should work with this driver; if a new chip comes out that has a 
different register layout we will change the compatibles (both) and 
therefore older kernels won't bind at all. If it has the same layout 
we'll keep the base compatible, `reg` will grow as needed to accomodate 
the extra channels, and e.g. num-channels=16 will then just work on 
older kernels with no changes.

Obviously a broken DT with an insane value here would crash the driver, 
but so would any other number of crazy DT things; however, I don't 
expect that to ever happen.

There's also the case where we end up with multiple memory controllers 
at discrete offsets (e.g. rumored multi-die configurations); in that 
case we'll end up with multiple genpd parents and have to add code to 
support that, and in the meantime older kernels will just have broken 
cpufreq on the p-cores. But I think that is ~acceptable as long as the 
system boots; we don't expect to be able to *fully* support newer SoCs 
on older kernels with no code changes. What I'm aiming for is just 
making the system work, hopefully with NVMe and USB and a dumb 
framebuffer, so that distro installers can run and then users can later 
install a proper up to date kernel will full support for the new SoC.

>> Ah, I didn't realize that was a valid option for MODULE_LICENSE. I guess
>> anything containing "GPL" works with EXPORT_SYMBOL_GPL?
> 
> I don't think exporting symbols is related to how you license your code.

It is; only modules with a GPL-compatible MODULE_LICENSE get to use 
symbols exported via EXPORT_SYMBOL_GPL.

See kernel/module.c for the symbol lookup logic and 
include/linux/license.h for the logic to check the string (seems like 
"Dual MIT/GPL" is explicitly whitelisted there).

Of course, this is a futile effort, as ~every time I see a proprietary 
module in some embedded device, it either falsely declares itself to be 
GPL, or they have a shim module that re-exports GPL symbols as non-GPL.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
