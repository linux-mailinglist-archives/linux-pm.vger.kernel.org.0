Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBAB824FC31
	for <lists+linux-pm@lfdr.de>; Mon, 24 Aug 2020 13:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgHXLBv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 07:01:51 -0400
Received: from foss.arm.com ([217.140.110.172]:59610 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726483AbgHXLBg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 24 Aug 2020 07:01:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F22741063;
        Mon, 24 Aug 2020 04:01:35 -0700 (PDT)
Received: from [10.37.12.65] (unknown [10.37.12.65])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 653203F66B;
        Mon, 24 Aug 2020 04:01:34 -0700 (PDT)
Subject: Re: [PATCH 3/3] memory: samsung: exynos5422-dmc: add missing and fix
 kerneldoc
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20200822163218.21857-1-krzk@kernel.org>
 <20200822163218.21857-3-krzk@kernel.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <6a87531f-a16f-5597-a10f-bdc2130077f1@arm.com>
Date:   Mon, 24 Aug 2020 12:01:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200822163218.21857-3-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 8/22/20 5:32 PM, Krzysztof Kozlowski wrote:
> Add missing kerneldoc to struct exynos5_dmc and correct the existing
> kerneldoc in other places to fix W=1 warnings like:
> 
>      drivers/memory/samsung/exynos5422-dmc.c:107: warning: Function parameter or member 'freq_hz' not described in 'dmc_opp_table'
>      drivers/memory/samsung/exynos5422-dmc.c:154: warning: Function parameter or member 'dev' not described in 'exynos5_dmc'
>      drivers/memory/samsung/exynos5422-dmc.c:357: warning: Excess function parameter 'param' description in 'exynos5_set_bypass_dram_timings'
>      drivers/memory/samsung/exynos5422-dmc.c:630: warning: Function parameter or member 'flags' not described in 'exynos5_dmc_get_volt_freq'
>      drivers/memory/samsung/exynos5422-dmc.c:962: warning: cannot understand function prototype: 'struct devfreq_dev_profile exynos5_dmc_df_profile = '
>      drivers/memory/samsung/exynos5422-dmc.c:1011: warning: Function parameter or member 'reg_timing_row' not described in 'create_timings_aligned'
>      drivers/memory/samsung/exynos5422-dmc.c:1011: warning: Excess function parameter 'idx' description in 'create_timings_aligned'
>      drivers/memory/samsung/exynos5422-dmc.c:1345: warning: Excess function parameter 'set' description in 'exynos5_dmc_set_pause_on_switching'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Lukasz Luba <lukasz.luba@arm.com>

Regards,
Lukasz
