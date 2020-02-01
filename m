Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71C8514FAE0
	for <lists+linux-pm@lfdr.de>; Sat,  1 Feb 2020 23:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgBAW5y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 1 Feb 2020 17:57:54 -0500
Received: from mout.perfora.net ([74.208.4.197]:41429 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbgBAW5y (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 1 Feb 2020 17:57:54 -0500
Received: from marcel-pc.lan ([81.221.75.74]) by mrelay.perfora.net
 (mreueus001 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MAvmU-1ioAL02lEK-009xEN;
 Sat, 01 Feb 2020 23:57:47 +0100
Message-ID: <334ac00a0c83e4178e3195cca5d77acaf4a3fae7.camel@ziswiler.com>
Subject: Re: [PATCH v6 07/12] ARM: tegra: Don't enable PLLX while resuming
 from LP1 on Tegra30
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 01 Feb 2020 23:57:42 +0100
In-Reply-To: <20191218202142.11717-8-digetx@gmail.com>
References: <20191218202142.11717-1-digetx@gmail.com>
         <20191218202142.11717-8-digetx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:/lPdDQ81GkL5XuSj9YrkkiM1dGphpYB4051qkDbcmMibnng5MvM
 2jxJI2tNl5CO3EXXWVg+iiWsd+k0L/28ZQ+qGew/CUiB0+KKvHmVe8/qHCAuOgJJS9FyYaZ
 HqevSICcgJIjSpshkRvQq5qi2ZlzmujibLw4UwynYIlV5hQGF5JfkpjSiyER7O47V+lTF+K
 3NMNuV83P/tY18kBWCNnQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qZDMthN2Mx8=:LmWa0a71b+FZal4YAAP3b1
 JxkKhke0OjZ3paqeKxnUiQOo2WmIZujgcz0ZgsiZALFc7rvrIrefEkJzG6B0QZZh91BMkaj3f
 GqaYzmTUD3JLGll6lYY9B77MFzgzXCg1v1DY522C6/RYgvET4Nn90EO1Ij3FC6KAjuRVUXPPU
 AB9dBANdMs0LzRfVNYmRxQwFevrLMk03tMpIvNRTDScsWoqZLUQN9GYIwim5ZN8cgv+V5BDNN
 ptWzaQmXQ7bb4UxZF8PFgSAMhDW6z0+rjTo7da8QmdQlKa1gIZO3k4s3MnsQ9Eef1NMvQKUhS
 WHE/1Rr6piETpf0EGzKSIbzxN4CnvDhUMbNo/aSfDhVGuEk/izbmAzh5kUA2ZRoJ8H4cXiXe2
 LxTYC33aq0i5K1P8LwsyNKECLYRxl2WwSeiChDKjYoL2PNMQeLcld2HGTGKD1hYhry2t46gpD
 1vyuRB3ggIcINdg5LcYqXl9YdzX02Z7+D2BL8vJbZQHYwbiUyvYde8QlWQhfRKldq1MwbxOt5
 i5JkioTvC3bHptEUx4GibUlT7/ugJi+O5sGzUAq5sDAYijdW1vLYdy4G5qhf3jVmUnMOJfjOx
 2UL6lxuXUJfSeYRGwSewdavaiSftFGdWOuNVjzm/Qwr9JQghPD2HLwMxXdixCj7gg8xO8+2f9
 2ZAGC8+ASVcPSKE6T/wLuSTKryYCqjv3Fy0OrmFtCfepJY2KDmVew+P/q1AEQMxj9JA7ersid
 XfUtEZ12GgpJOW3nXCmDA8lGxBNZMojH+JO9gKjfDsfm3zirobj+H1hVbZRm01Ge/MDTs0PGa
 YLahp0dM/2gcuYDswJiXrJGqkrGLUHgEHT88+xWrFGhU1kEwq/tDwNyXUTn/tCoYq3+7scS
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Dmitry

Finally, I came around giving this a try again on the Colibri T20 and
Apalis/Colibri T30.

Overall, works like a charm and you may add the following to the entire
series:

On Wed, 2019-12-18 at 23:21 +0300, Dmitry Osipenko wrote:
> PLLX may be kept disabled if cpufreq driver selects some other clock
> for
> CPU. In that case PLLX will be disabled later in the resume path by
> the
> CLK driver, which also can enable PLLX if necessary by itself. Thus
> there
> is no need to enable PLLX early during resume. Tegra114/124 CLK
> drivers do
> not manage PLLX on resume and thus they are left untouched by this
> patch.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Tested-by: Marcel Ziswiler <marcel@ziswiler.com>
Tested-on: Colibri T20, Apalis/Colibri T30 on resp. EvalBoards

> ---
>  arch/arm/mach-tegra/sleep-tegra30.S | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-tegra/sleep-tegra30.S b/arch/arm/mach-
> tegra/sleep-tegra30.S
> index 9a20c93abe48..4f073869b8ac 100644
> --- a/arch/arm/mach-tegra/sleep-tegra30.S
> +++ b/arch/arm/mach-tegra/sleep-tegra30.S
> @@ -358,7 +358,6 @@ _no_pll_iddq_exit:
>  
>  	pll_enable r1, r0, CLK_RESET_PLLM_BASE, CLK_RESET_PLLM_MISC
>  	pll_enable r1, r0, CLK_RESET_PLLC_BASE, CLK_RESET_PLLC_MISC
> -	pll_enable r1, r0, CLK_RESET_PLLX_BASE, CLK_RESET_PLLX_MISC
>  
>  _pll_m_c_x_done:
>  	pll_enable r1, r0, CLK_RESET_PLLP_BASE, CLK_RESET_PLLP_MISC
> @@ -368,8 +367,18 @@ _pll_m_c_x_done:
>  	pll_locked r1, r0, CLK_RESET_PLLP_BASE
>  	pll_locked r1, r0, CLK_RESET_PLLA_BASE
>  	pll_locked r1, r0, CLK_RESET_PLLC_BASE
> +
> +	/*
> +	 * CPUFreq driver could select other PLL for CPU. PLLX will be
> +	 * enabled by the Tegra30 CLK driver on an as-needed basis, see
> +	 * tegra30_cpu_clock_resume().
> +	 */
> +	cmp	r10, #TEGRA30
> +	beq	_pll_m_c_x_locked
> +
>  	pll_locked r1, r0, CLK_RESET_PLLX_BASE
>  
> +_pll_m_c_x_locked:
>  	mov32	r7, TEGRA_TMRUS_BASE
>  	ldr	r1, [r7]
>  	add	r1, r1, #LOCK_DELAY

Unfortunately, that one does no longer apply after the following patch
recently got applied on Wed Jan 8:

commit 1a3388d506bf ("ARM: tegra: Enable PLLP bypass during Tegra124
LP1")

Thanks!

Cheers

Marcel

