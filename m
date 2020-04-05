Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2E9C19EBDA
	for <lists+linux-pm@lfdr.de>; Sun,  5 Apr 2020 16:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgDEOFT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 5 Apr 2020 10:05:19 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40414 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgDEOFT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 5 Apr 2020 10:05:19 -0400
Received: by mail-lf1-f67.google.com with SMTP id j17so9587214lfe.7;
        Sun, 05 Apr 2020 07:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HogDBcooWi67XENOKHci5+dOZCCQV64k3pTiHWgv4s4=;
        b=rBaEBSkXK2C0yzndQ/RkDwHj0w17BJXrPk7f9u7teTV8P9IxLUVusf3MKIvc4yffff
         Yp8Cpb3XQoNRyLBWUd2Cd7nJAmpHo6S2cmHSanRKQuITwv2z21ePnlDUNkIwkgTX1i4b
         2b2hc/0oVkEq6Q/e6S/1eW4jWOR2sSWa6ETRpFJgiSyBZ9wFqfWxgz9m9JutlfOFQN3J
         9kOG+onl1TMLjo1attSQqqadWl5xzuog8qJNOfcpGDTqTbgXykfUBXmW/KFEtZBhN2D5
         JO+FVp4R1fbWK6EjdVZmpfDN0wT+15Cuvh2HkfxPT+Gi+KckM4yugfn3CPwbKCbdHzvT
         kyrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HogDBcooWi67XENOKHci5+dOZCCQV64k3pTiHWgv4s4=;
        b=AwxUA+ndjKdeATrtFD1HKARSpUhTHo/ADo6mWTaePL/fBlOQe8QJ9yRlgfJPL7VRb+
         xql2pKtFJqqJqNlByRzYH4dJ72pNgG39lNGl2JPuZfRDwTwzBDCF8SGm8Piglz2iTxPe
         yN3Qp1tv7ywXe8vGB5Jb1tenjmsVsIUxnMgpYFxTm5g1O7POCm61CsvDOy9MZRoo8cYX
         9Y4+cHAleZv+KZa7NCurS7j8RUjCLJEaw7nJUNfL5RiQIXWmydT1UcW1lsKH+twS467y
         vO366HHA2SSuhPPTlvO1DTnE1CnZwTBeJN+fDjofATf4SzyTZHvjoWMzJLUIAGYWq5o5
         SlEA==
X-Gm-Message-State: AGi0PuZxCrI3yRGLw/bmKkbPMW0uFO764ZsXB5CgoirxWQOlauHtKBTg
        n3F5dY6C0JwDvbEdtoy5ZVM=
X-Google-Smtp-Source: APiQypILiNlHrBcNHoxP8124hD18AOTk35fqkGU+DQleRMILHJTfrkd1aUr9wRQOkM31pqNtx2BDfQ==
X-Received: by 2002:ac2:5185:: with SMTP id u5mr3629194lfi.64.1586095516549;
        Sun, 05 Apr 2020 07:05:16 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id k3sm8527148lji.43.2020.04.05.07.05.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Apr 2020 07:05:15 -0700 (PDT)
Subject: Re: [TEGRA194_CPUFREQ Patch v2 2/3] cpufreq: Add Tegra194 cpufreq
 driver
To:     Sumit Gupta <sumitg@nvidia.com>, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, catalin.marinas@arm.com, will@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com, talho@nvidia.com,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     bbasu@nvidia.com, mperttunen@nvidia.com
References: <1586028547-14993-1-git-send-email-sumitg@nvidia.com>
 <1586028547-14993-3-git-send-email-sumitg@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <67f9feb1-ba51-f1ac-b6eb-4587924d0748@gmail.com>
Date:   Sun, 5 Apr 2020 17:05:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1586028547-14993-3-git-send-email-sumitg@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

04.04.2020 22:29, Sumit Gupta пишет:
...
> +static void tegra_read_counters(struct work_struct *work)
> +{
> +	struct read_counters_work *read_counters_work;
> +	struct tegra_cpu_ctr *c;
> +	u64 val;
> +
> +	/*
> +	 * ref_clk_counter(32 bit counter) runs on constant clk,
> +	 * pll_p(408MHz).
> +	 * It will take = 2 ^ 32 / 408 MHz to overflow ref clk counter
> +	 *              = 10526880 usec = 10.527 sec to overflow
> +	 *
> +	 * Like wise core_clk_counter(32 bit counter) runs on core clock.
> +	 * It's synchronized to crab_clk (cpu_crab_clk) which runs at
> +	 * freq of cluster. Assuming max cluster clock ~2000MHz,
> +	 * It will take = 2 ^ 32 / 2000 MHz to overflow core clk counter
> +	 *              = ~2.147 sec to overflow
> +	 */
> +	read_counters_work = container_of(work, struct read_counters_work,
> +					  work);
> +	c = &read_counters_work->c;
> +
> +	val = read_freq_feedback();
> +	c->last_refclk_cnt = lower_32_bits(val);
> +	c->last_coreclk_cnt = upper_32_bits(val);
> +	udelay(c->delay);
> +	val = read_freq_feedback();
> +	c->refclk_cnt = lower_32_bits(val);
> +	c->coreclk_cnt = upper_32_bits(val);
> +}
> +
> +/*
> + * Return instantaneous cpu speed
> + * Instantaneous freq is calculated as -
> + * -Takes sample on every query of getting the freq.
> + *	- Read core and ref clock counters;
> + *	- Delay for X us
> + *	- Read above cycle counters again
> + *	- Calculates freq by subtracting current and previous counters
> + *	  divided by the delay time or eqv. of ref_clk_counter in delta time
> + *	- Return Kcycles/second, freq in KHz
> + *
> + *	delta time period = x sec
> + *			  = delta ref_clk_counter / (408 * 10^6) sec
> + *	freq in Hz = cycles/sec
> + *		   = (delta cycles / x sec
> + *		   = (delta cycles * 408 * 10^6) / delta ref_clk_counter
> + *	in KHz	   = (delta cycles * 408 * 10^3) / delta ref_clk_counter
> + *
> + * @cpu - logical cpu whose freq to be updated


> + * Returns freq in KHz on success, 0 if cpu is offline

I don't see any checks in the code about whether CPU is offline.

Googling for "queue_work_on offline cpu" suggests that this function
should hang.

> + */
> +static unsigned int tegra194_get_speed_common(u32 cpu, u32 delay)
> +{
> +	struct read_counters_work read_counters_work;
> +	struct tegra_cpu_ctr c;
> +	u32 delta_refcnt;
> +	u32 delta_ccnt;
> +	u32 rate_mhz;
> +
> +	read_counters_work.c.cpu = cpu;
> +	read_counters_work.c.delay = delay;
> +	INIT_WORK_ONSTACK(&read_counters_work.work, tegra_read_counters);
> +	queue_work_on(cpu, read_counters_wq, &read_counters_work.work);
> +	flush_work(&read_counters_work.work);
> +	c = read_counters_work.c;
> +
> +	if (c.coreclk_cnt < c.last_coreclk_cnt)
> +		delta_ccnt = c.coreclk_cnt + (MAX_CNT - c.last_coreclk_cnt);
> +	else
> +		delta_ccnt = c.coreclk_cnt - c.last_coreclk_cnt;
> +	if (!delta_ccnt)
> +		return 0;
> +
> +	/* ref clock is 32 bits */
> +	if (c.refclk_cnt < c.last_refclk_cnt)
> +		delta_refcnt = c.refclk_cnt + (MAX_CNT - c.last_refclk_cnt);
> +	else
> +		delta_refcnt = c.refclk_cnt - c.last_refclk_cnt;
> +	if (!delta_refcnt) {
> +		pr_debug("cpufreq: %d is idle, delta_refcnt: 0\n", cpu);
> +		return 0;
> +	}
> +	rate_mhz = ((unsigned long)(delta_ccnt * REF_CLK_MHZ)) / delta_refcnt;
> +
> +	return (rate_mhz * KHZ); /* in KHz */
> +}

