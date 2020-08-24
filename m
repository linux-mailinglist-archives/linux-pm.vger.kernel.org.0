Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B93B924FCDE
	for <lists+linux-pm@lfdr.de>; Mon, 24 Aug 2020 13:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbgHXLni (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 07:43:38 -0400
Received: from foss.arm.com ([217.140.110.172]:60374 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbgHXLnh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 24 Aug 2020 07:43:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F21631063;
        Mon, 24 Aug 2020 04:43:36 -0700 (PDT)
Received: from [10.37.12.65] (unknown [10.37.12.65])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9399D3F66B;
        Mon, 24 Aug 2020 04:43:35 -0700 (PDT)
Subject: Re: [PATCH 2/3] memory: samsung: exynos5422-dmc: remove unused
 exynos5_dmc members
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20200822163218.21857-1-krzk@kernel.org>
 <20200822163218.21857-2-krzk@kernel.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <6c61572d-ef7a-ca0a-2253-7a3c0736f0a5@arm.com>
Date:   Mon, 24 Aug 2020 12:43:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200822163218.21857-2-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Krzysztof,

On 8/22/20 5:32 PM, Krzysztof Kozlowski wrote:
> The struct exynos5_dmc members bypass_rate, mx_mspll_ccore_phy,
> mout_mx_mspll_ccore_phy and opp_bypass are not actually used.
> 
> Apparently there was a plan to store the OPP for the bypass mode in
> opp_bypass member, but drivers fails to do it and instead always sets
> target voltage during bypass mode.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>   drivers/memory/samsung/exynos5422-dmc.c | 9 ---------
>   1 file changed, 9 deletions(-)
> 
> diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
> index 31864ce59b25..df02afa8aa90 100644
> --- a/drivers/memory/samsung/exynos5422-dmc.c
> +++ b/drivers/memory/samsung/exynos5422-dmc.c
> @@ -123,9 +123,7 @@ struct exynos5_dmc {
>   	struct mutex lock;
>   	unsigned long curr_rate;
>   	unsigned long curr_volt;
> -	unsigned long bypass_rate;
>   	struct dmc_opp_table *opp;
> -	struct dmc_opp_table opp_bypass;
>   	int opp_count;
>   	u32 timings_arr_size;
>   	u32 *timing_row;
> @@ -143,8 +141,6 @@ struct exynos5_dmc {
>   	struct clk *mout_bpll;
>   	struct clk *mout_mclk_cdrex;
>   	struct clk *mout_mx_mspll_ccore;
> -	struct clk *mx_mspll_ccore_phy;
> -	struct clk *mout_mx_mspll_ccore_phy;
>   	struct devfreq_event_dev **counter;
>   	int num_counters;
>   	u64 last_overflow_ts[2];
> @@ -455,9 +451,6 @@ static int exynos5_dmc_align_bypass_voltage(struct exynos5_dmc *dmc,
>   					    unsigned long target_volt)
>   {
>   	int ret = 0;
> -	unsigned long bypass_volt = dmc->opp_bypass.volt_uv;
> -
> -	target_volt = max(bypass_volt, target_volt);


Could you explain which use cases you considered when you decided to
remove these lines?

Regards,
Lukasz
