Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB2742A120
	for <lists+linux-pm@lfdr.de>; Tue, 12 Oct 2021 11:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235562AbhJLJdb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 12 Oct 2021 05:33:31 -0400
Received: from marcansoft.com ([212.63.210.85]:49154 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232657AbhJLJda (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 12 Oct 2021 05:33:30 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 429AA425CB;
        Tue, 12 Oct 2021 09:31:25 +0000 (UTC)
Date:   Tue, 12 Oct 2021 18:31:18 +0900
From:   "Hector Martin \"marcan\"" <marcan@marcan.st>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     Sibi Sankar <sibis@codeaurora.org>,
        Saravana Kannan <saravanak@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sven Peter <sven@svenpeter.dev>, Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BRFC_PATCH_4/9=5D_opp=3A_core=3A_Don=27t_wa?= =?US-ASCII?Q?rn_if_required_OPP_device_does_not_exist?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20211012092603.lkmhhjoo5v67wh44@vireshk-i7>
References: <20211011165707.138157-1-marcan@marcan.st> <20211011165707.138157-5-marcan@marcan.st> <20211012032144.2ltlpat7orrsyr6k@vireshk-i7> <b7cd51ec-38e5-11d8-5193-1170c9d60ac9@marcan.st> <20211012055143.xmkbvhbnolspgjin@vireshk-i7> <caf16a6c-f127-7f27-ed17-0522d9f1fb9e@marcan.st> <20211012092603.lkmhhjoo5v67wh44@vireshk-i7>
Message-ID: <049FC437-EC38-4FE5-891E-5E25960892CF@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 2021年10月12日 18:26:03 JST, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>On 12-10-21, 14:57, Hector Martin wrote:
>> 
>> This is arguably not entirely representative of how the hardware works,
>> since technically the cluster switching couldn't care less what the memory
>> controller is doing; it's a soft dependency, states that should be switched
>> together but are not interdependent (in fact, the clock code does this
>> unconditionally after the CPU p-state change, regardless of whether we're
>> shifting up or down; this is, FWIW, the same order macOS uses, and it
>> clearly doesn't matter which way you do it).
>
>Yeah, I understand what you are doing. But the current patch is
>incorrect in the sense that it can cause a bug on other platforms. To
>make this work, you should rather set this genpd as parent of CPU
>devices (which are doing anyway since you are updating them with CPU's
>DVFS). With that the clk driver won't be required to do the magic
>behind the scene.
>

That doesn't work, though, because the CPUs aren't normal devices with runtime-pm. That was the first thing I tried :).

If you think this *should* be made to work instead then I can try that.


-- 
Hector Martin "marcan" (marcan@marcan.st)
Public key: https://mrcn.st/pub
