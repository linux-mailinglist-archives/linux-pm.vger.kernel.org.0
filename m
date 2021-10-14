Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2BB42D2FA
	for <lists+linux-pm@lfdr.de>; Thu, 14 Oct 2021 08:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbhJNGzH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Oct 2021 02:55:07 -0400
Received: from marcansoft.com ([212.63.210.85]:43070 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229584AbhJNGzG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 14 Oct 2021 02:55:06 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 9E34E41AC8;
        Thu, 14 Oct 2021 06:52:54 +0000 (UTC)
Subject: Re: [RFC PATCH 4/9] opp: core: Don't warn if required OPP device does
 not exist
To:     Viresh Kumar <viresh.kumar@linaro.org>
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
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211011165707.138157-1-marcan@marcan.st>
 <20211011165707.138157-5-marcan@marcan.st>
 <20211012032144.2ltlpat7orrsyr6k@vireshk-i7>
 <b7cd51ec-38e5-11d8-5193-1170c9d60ac9@marcan.st>
 <20211012055143.xmkbvhbnolspgjin@vireshk-i7>
 <caf16a6c-f127-7f27-ed17-0522d9f1fb9e@marcan.st>
 <20211012092603.lkmhhjoo5v67wh44@vireshk-i7>
 <049FC437-EC38-4FE5-891E-5E25960892CF@marcan.st>
 <20211012093252.hb6rlcpxv5bmk7n3@vireshk-i7>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <0db8e994-ac2c-8fad-55d0-1b5a9e2e21f2@marcan.st>
Date:   Thu, 14 Oct 2021 15:52:52 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211012093252.hb6rlcpxv5bmk7n3@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/10/2021 18.32, Viresh Kumar wrote:
> On 12-10-21, 18:31, Hector Martin "marcan" wrote:
>> That doesn't work, though, because the CPUs aren't normal devices
>> with runtime-pm. That was the first thing I tried :).
> 
> What's the exact problem with runtime PM here ?

The CPU devices aren't attached to their genpd, so the required OPP
transition fails with the same error.

However, this was easier to fix than I expected. With this patch to
cpufreq-dt, it all works properly, and I can drop the parent genpd
from the clock node and related handling. Thoughts?

commit c4f88743374c1f4678ee7f17fb6cae30ded9ed59
Author: Hector Martin <marcan@marcan.st>
Date:   Thu Oct 14 15:47:45 2021 +0900

     cpufreq: dt: Attach CPU devices to power domains
     
     This allows the required-opps mechanism to work for CPU OPP tables,
     triggering specific OPP levels in a parent power domain.
     
     Signed-off-by: Hector Martin <marcan@marcan.st>

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 8fcaba541539..5b22846b557d 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -16,6 +16,7 @@
  #include <linux/list.h>
  #include <linux/module.h>
  #include <linux/of.h>
+#include <linux/pm_domain.h>
  #include <linux/pm_opp.h>
  #include <linux/platform_device.h>
  #include <linux/regulator/consumer.h>
@@ -264,6 +265,16 @@ static int dt_cpufreq_early_init(struct device *dev, int cpu)
  		goto out;
  	}
  
+	/*
+	 * Attach the CPU device to its genpd domain (if any), to allow OPP
+	 * dependencies to be satisfied.
+	 */
+	ret = genpd_dev_pm_attach(cpu_dev);
+	if (ret <= 0) {
+		dev_err(cpu_dev, "Failed to attach CPU device to genpd\n");
+		goto out;
+	}
+
  	/*
  	 * The OPP table must be initialized, statically or dynamically, by this
  	 * point.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
