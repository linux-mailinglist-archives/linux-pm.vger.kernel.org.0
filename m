Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7583C42D330
	for <lists+linux-pm@lfdr.de>; Thu, 14 Oct 2021 09:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbhJNHFu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Oct 2021 03:05:50 -0400
Received: from marcansoft.com ([212.63.210.85]:45702 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230035AbhJNHFt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 14 Oct 2021 03:05:49 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 3043B3FA5E;
        Thu, 14 Oct 2021 07:03:37 +0000 (UTC)
Subject: Re: [RFC PATCH 4/9] opp: core: Don't warn if required OPP device does
 not exist
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sibi Sankar <sibis@codeaurora.org>,
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
        Kevin Hilman <khilman@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211011165707.138157-1-marcan@marcan.st>
 <20211011165707.138157-5-marcan@marcan.st>
 <20211012032144.2ltlpat7orrsyr6k@vireshk-i7>
 <b7cd51ec-38e5-11d8-5193-1170c9d60ac9@marcan.st>
 <20211012055143.xmkbvhbnolspgjin@vireshk-i7>
 <caf16a6c-f127-7f27-ed17-0522d9f1fb9e@marcan.st>
 <20211012092603.lkmhhjoo5v67wh44@vireshk-i7>
 <049FC437-EC38-4FE5-891E-5E25960892CF@marcan.st>
 <20211012093252.hb6rlcpxv5bmk7n3@vireshk-i7>
 <0db8e994-ac2c-8fad-55d0-1b5a9e2e21f2@marcan.st>
 <20211014065636.lkv77aqbugp3qhif@vireshk-i7>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <039b77f3-d10e-bd7a-a594-b951a98bdd45@marcan.st>
Date:   Thu, 14 Oct 2021 16:03:36 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211014065636.lkv77aqbugp3qhif@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 14/10/2021 15.56, Viresh Kumar wrote:
>> +	/*
>> +	 * Attach the CPU device to its genpd domain (if any), to allow OPP
>> +	 * dependencies to be satisfied.
>> +	 */
>> +	ret = genpd_dev_pm_attach(cpu_dev);
>> +	if (ret <= 0) {
>> +		dev_err(cpu_dev, "Failed to attach CPU device to genpd\n");
>> +		goto out;
>> +	}
>> +
> 
> Other platform do this from some other place I think.
> 
> Ulf, where should this code be moved ? cpu-clk driver ?
> 

I see one driver that does this is drivers/clk/qcom/apcs-sdx55.c (via 
dev_pm_domain_attach). Though it only does it for CPU#0; we need to do 
it for all CPUs.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
