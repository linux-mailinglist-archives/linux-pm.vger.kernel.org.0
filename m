Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A47092187A9
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jul 2020 14:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbgGHMez (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jul 2020 08:34:55 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:10909 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728965AbgGHMeu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jul 2020 08:34:50 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f05bcff0000>; Wed, 08 Jul 2020 05:33:03 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 08 Jul 2020 05:34:49 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 08 Jul 2020 05:34:49 -0700
Received: from [10.26.73.185] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 8 Jul
 2020 12:34:48 +0000
From:   Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v2] cpuidle: tegra: Correctly handle result of
 arm_cpuidle_simple_enter()
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>
References: <20200702001354.27056-1-digetx@gmail.com>
Message-ID: <4ffff3d8-2d41-3fb2-ed16-c9662d18d261@nvidia.com>
Date:   Wed, 8 Jul 2020 13:34:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200702001354.27056-1-digetx@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594211583; bh=+WiKehweVjFm/N1WTgoSGN3YwF0LWqAX6QQ458Y2Z4o=;
        h=X-PGP-Universal:From:Subject:To:CC:References:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=NBOjwAFfGvCc0zWdBhGhm4frMUR2zarSDCnAcyTi9urKVTpk44xeBVG2iYLIAlRjG
         m+d/qO6NEhsCW4YKqFAcpOBtmbPrR8AoVuox/bZkzMjQINDPYzNP94qBZEZvl6amxJ
         wLWREHv4545+RiGMcZlHiiQTzlW16A2hOwGQS5zAlpu8biC3TZMGeaSM2+N/aXe/Vu
         YwyKEUZOLwtJJct91E/p7HmJnbtPsDre5xECjpvNustGgKspSWs3auELLN+ML0SXr6
         MaTK/AwupS4eOqGxWcUvcMomWYy23HBQKcyDfHG5SWn7zUmtT5lZ0QqZOvGBofpZZW
         VNB/IjWof2IFg==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 02/07/2020 01:13, Dmitry Osipenko wrote:
> The enter() callback of CPUIDLE drivers returns index of the entered idle
> state on success or a negative value on failure. The negative value could
> any negative value, i.e. it doesn't necessarily needs to be a error code.
> That's because CPUIDLE core only cares about the fact of failure and not
> about the reason of the enter() failure.
> 
> Like every other enter() callback, the arm_cpuidle_simple_enter() returns
> the entered idle-index on success. Unlike some of other drivers, it never
> fails. It happened that TEGRA_C1=index=err=0 in the code of cpuidle-tegra
> driver, and thus, there is no problem for the cpuidle-tegra driver created
> by the typo in the code which assumes that the arm_cpuidle_simple_enter()
> returns a error code.
> 
> The arm_cpuidle_simple_enter() also may return a -ENODEV error if CPU_IDLE
> is disabled in a kernel's config, but all CPUIDLE drivers are disabled if
> CPU_IDLE is disabled, including the cpuidle-tegra driver. So we can't ever
> see the error code from arm_cpuidle_simple_enter() today.
> 
> Of course the code may get some changes in the future and then the typo
> may transform into a real bug, so let's correct the typo in the code by
> making tegra_cpuidle_enter() to directly return the index returned by the
> arm_cpuidle_simple_enter().

Are you suggesting that arm_cpuidle_simple_enter() could be updated to
actually return an error? Sorry it is not clear to me what you are implying.

Cheers
Jon

-- 
nvpublic
