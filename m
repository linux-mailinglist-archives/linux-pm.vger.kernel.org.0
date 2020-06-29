Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6CF420D718
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jun 2020 22:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730244AbgF2T0x (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jun 2020 15:26:53 -0400
Received: from foss.arm.com ([217.140.110.172]:40108 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732409AbgF2TYz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 29 Jun 2020 15:24:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24A5B13D5;
        Mon, 29 Jun 2020 04:05:38 -0700 (PDT)
Received: from [10.37.12.67] (unknown [10.37.12.67])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A02103F73C;
        Mon, 29 Jun 2020 04:05:34 -0700 (PDT)
Subject: Re: [PATCH v2 1/4] ARM: exynos: MCPM: Restore big.LITTLE cpuidle
 support
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
References: <20200629091343.GA16015@kozik-lap>
 <CGME20200629100230eucas1p1bf07ca4c84ba6be1fbdd80c45d077518@eucas1p1.samsung.com>
 <20200629100218.6267-1-m.szyprowski@samsung.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <1be67c26-57c2-c32d-4e32-e8389094bb59@arm.com>
Date:   Mon, 29 Jun 2020 12:05:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200629100218.6267-1-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 6/29/20 11:02 AM, Marek Szyprowski wrote:
> Call exynos_cpu_power_up(cpunr) unconditionally. This is needed by the
> big.LITTLE cpuidle driver and has no side-effects on other code paths.
> 
> The additional soft-reset call during little core power up has been added
> to properly boot all cores on the Exynos5422-based boards with secure
> firmware (like Odroid XU3/XU4 family). This however broke big.LITTLE
> CPUidle driver, which worked only on boards without secure firmware (like
> Peach-Pit/Pi Chromebooks). Apply the workaround only when board is
> running under secure firmware.
> 
> Fixes: 833b5794e330 ("ARM: EXYNOS: reset Little cores when cpu is up")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> v2:
> - adjusted patch subject to better describe the change
> - added a comment about exynos_cpu_power_up(cpunr) call
> ---


Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Regards,
Lukasz
