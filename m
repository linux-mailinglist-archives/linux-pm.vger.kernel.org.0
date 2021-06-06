Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E1639D078
	for <lists+linux-pm@lfdr.de>; Sun,  6 Jun 2021 20:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbhFFSlg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 6 Jun 2021 14:41:36 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:43873 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229697AbhFFSlg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 6 Jun 2021 14:41:36 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id E2A3758094C;
        Sun,  6 Jun 2021 14:39:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 06 Jun 2021 14:39:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm2; bh=/
        jdo7cePtO24oEruM82Zm8LlZTN5Vu0LoLWniZZ9ji8=; b=OhvTP95hppIbju+O/
        OH7w5xIuU3nVosv6KggLjXzehodZLMWfCh3S4Zb8B5Wcxp55Vbg5sK2JFFp5sPp5
        e1HaEwfcjZVH8/UydNusK+GnXT2O0pG2dOtmcPGfOdFOsDNWLMIWdB6WsaxT19g3
        uD2N8M8FJ4yPWvb9w46CfBxrnX5h/CF2+Hs+br3RlpIIuY0hNn+fSgDcvIuGdi2l
        jNQihj706UnbV0FVVACRxIbqpcb7xJX71v7p/dG2Y0KHRhxj2Q1IaQukTKNRmhe+
        GDT7daGhU9oFPqR7ADJ4s8x0HWDtgoC+5lqiQmgu6z2XkS3XVHZgmRMfbrASqEPA
        ImWKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=/jdo7cePtO24oEruM82Zm8LlZTN5Vu0LoLWniZZ9j
        i8=; b=T4WtxARGFX9OVC4HmhDCc3JnbLM35Wx39jiPIx53ynKyjhS6kaPX4oyCg
        KqiK9MgKHLaF/0yirHteTrEVY8PfgcoPGaErj4sp58qdrJFuFVxiqDgHX5cRe3u5
        tlnJUaiejdXzNHriD6+lB98rF60TUdoaKA3RmatIrz3FmqT2VUpApTXvNEbGB0ji
        KSr4GoxuN3mNYCHkmHDfPc8+pLjcWdKFy1D2Pf4C8yDJ/heawtmlPMP13poWYdRb
        TeDDNZnqb1e6jYEErTMoFn8D1doX+tJTKRWX4vDJ3es+ueVTk9E9PBZu9YV9uyRM
        si5EuoAS3kk8p1U3FMSxacoM+NdbQ==
X-ME-Sender: <xms:cBa9YIPvwPLqLpEH5jPCBFdwMfiPAdMM_MUzbU_DOdc0RcbOKocMVw>
    <xme:cBa9YO_ID2KlBW-Dr9tu-QxIjd97urpLiLaNpZQGU5Qx3H-YKV_7tn1ylXVmQKE6w
    NvFGf4w2mkM9JfkGQ>
X-ME-Received: <xmr:cBa9YPSf82SL6QqGlztnHgMHNyxdBD8c_1I9I2LkXIMkqp7gxsj3hrHDIdvjcPgutJW855gGaqnd1kyGP1z0AP6VVQ7VRv6FqYPgdWswQU0Ww2Y4U6OqnyW9rQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedthedgudeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpefgveffteelheffjeeukedvkedviedtheevgeefkeehueeiieeu
    teeugfettdeggeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:cBa9YAu_Qy_jW2ENNaqVpFc9IDMDDmbt7u7eBRhXa2ERIudYb1cp9g>
    <xmx:cBa9YAf-4-Fu2514hC8XEqppjh6ES3oYaRU_RMx4XezHG_BVek4JkA>
    <xmx:cBa9YE0PqMWUnV3f2d-LUB1BGPStwdWdxmjEvqtNceoUOQog59Jkkw>
    <xmx:cRa9YDUfcS2UOPdnilZVNeYW0MDmjRmcSjrUwTLch_K1n8_EQiTmug>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 6 Jun 2021 14:39:43 -0400 (EDT)
Subject: Re: [PATCH v5 6/8] cpuidle: Add RISC-V SBI CPU idle driver
To:     Anup Patel <anup.patel@wdc.com>
Cc:     Sandeep Tripathy <milun.tripathy@gmail.com>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Liush <liush@allwinnertech.com>,
        Anup Patel <anup@brainfault.org>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Pavel Machek <pavel@ucw.cz>
References: <20210602112321.2241566-1-anup.patel@wdc.com>
 <20210602112321.2241566-7-anup.patel@wdc.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <26cddfa8-75e2-7b5b-1a47-e01cc1c7821e@sholland.org>
Date:   Sun, 6 Jun 2021 13:39:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux ppc64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210602112321.2241566-7-anup.patel@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 6/2/21 6:23 AM, Anup Patel wrote:
> The RISC-V SBI HSM extension provides HSM suspend call which can
> be used by Linux RISC-V to enter platform specific low-power state.
> 
> This patch adds a CPU idle driver based on RISC-V SBI calls which
> will populate idle states from device tree and use SBI calls to
> entry these idle states.
> 
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  MAINTAINERS                   |   7 +
>  drivers/cpuidle/Kconfig       |   5 +
>  drivers/cpuidle/Kconfig.riscv |  15 +
>  drivers/cpuidle/Makefile      |   4 +
>  drivers/cpuidle/cpuidle-sbi.c | 626 ++++++++++++++++++++++++++++++++++
>  5 files changed, 657 insertions(+)
>  create mode 100644 drivers/cpuidle/Kconfig.riscv
>  create mode 100644 drivers/cpuidle/cpuidle-sbi.c
> 
> ...
> diff --git a/drivers/cpuidle/cpuidle-sbi.c b/drivers/cpuidle/cpuidle-sbi.c
> new file mode 100644
> index 000000000000..f743684d07de
> --- /dev/null
> +++ b/drivers/cpuidle/cpuidle-sbi.c
> @@ -0,0 +1,626 @@
> ...
> +	/* Initialize idle states from DT. */
> +	ret = sbi_cpuidle_dt_init_states(dev, drv, cpu, state_count);
> +	if (ret) {
> +		pr_err("HART%ld: failed to init idle states\n",
> +		       cpuid_to_hartid_map(cpu));
> +		return ret;
> +	}
> +
> +	ret = cpuidle_register(drv, NULL);
> +	if (ret)
> +		goto deinit;
> +
> +	cpuidle_cooling_register(drv);
> +
> +	return 0;
> +deinit:
> +	sbi_cpuidle_deinit_cpu(cpu);
> +	return ret;
> +}
> +
> +static int sbi_cpuidle_pd_power_off(struct generic_pm_domain *pd)

This function should be moved inside the CONFIG_DT_IDLE_GENPD block
below. Otherwise it is defined but unused.

> +{
> +	struct genpd_power_state *state = &pd->states[pd->state_idx];
> +	u32 *pd_state;
> +
> +	if (!state->data)
> +		return 0;
> +
> +	if (!sbi_cpuidle_pd_allow_domain_state)
> +		return -EBUSY;
> +
> +	/* OSI mode is enabled, set the corresponding domain state. */
> +	pd_state = state->data;
> +	sbi_set_domain_state(*pd_state);
> +
> +	return 0;
> +}
> +
> +static void sbi_cpuidle_domain_sync_state(struct device *dev)
> +{
> +	/*
> +	 * All devices have now been attached/probed to the PM domain
> +	 * topology, hence it's fine to allow domain states to be picked.
> +	 */
> +	sbi_cpuidle_pd_allow_domain_state = true;
> +}
> +
> +#ifdef CONFIG_DT_IDLE_GENPD
> +
> +struct sbi_pd_provider {
> +	struct list_head link;
> +	struct device_node *node;
> +};
> +
> +static LIST_HEAD(sbi_pd_providers);
> +
> +static int sbi_pd_init(struct device_node *np)
> +{
> +	struct generic_pm_domain *pd;
> +	struct sbi_pd_provider *pd_provider;
> +	struct dev_power_governor *pd_gov;
> +	int ret = -ENOMEM, state_count = 0;
> +
> +	pd = dt_idle_pd_alloc(np, sbi_dt_parse_state_node);
> +	if (!pd)
> +		goto out;
> ...
