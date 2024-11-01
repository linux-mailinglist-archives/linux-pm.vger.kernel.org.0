Return-Path: <linux-pm+bounces-16868-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3979B902C
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2024 12:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DFDF2826DA
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2024 11:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8512D1991AA;
	Fri,  1 Nov 2024 11:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dOmH6MCe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2497514A62B
	for <linux-pm@vger.kernel.org>; Fri,  1 Nov 2024 11:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730460215; cv=none; b=LS2CaR2lq34l01v9xvJz8pqybx2jLpoXOdZRrB5wj259evX1kCWovSJG8XAGlEg0TfMseHPRm6Fn2Cx6XiPqm5Kmk/ogqgYhVlM/iakBFfs6sxmIw2R3IwJFyrIR2NmJmY4dperOd6ehCRLfN2FpFlFR9HiU/AAl5lTx9rDcfqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730460215; c=relaxed/simple;
	bh=4SgjJ9A/uQQUZD/w43q1HHqtIFaCazNZPx4Fa6mn8C8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KzmDFr0+jCZ5HJuI7jrx6fTb60epE5dVabwHdncvGLHYkSNEpqL28RdfhaHqyElIQxwcfsv7iV6xNbBCLXV1YKIS73tcPHj73iIGDa5Z5SkLQbkj/ZEMzsoS1HMYGXfsrCTtez7KkXiTDmDETUYXPwwZD6i+Yy7YI1j72AeY09M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dOmH6MCe; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4315f24a6bbso14706735e9.1
        for <linux-pm@vger.kernel.org>; Fri, 01 Nov 2024 04:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730460211; x=1731065011; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MmSEmeYDonrIbemmrcZ6psyt+xl4tMHb9OZDAE7y7oo=;
        b=dOmH6MCehOOP7Q0bKR43t5SCcdjPe471gqLq8NxkSYaZYUHBuYY6lXSy6FwJWqlxVO
         F5hSTPQQbBcQ5NXHIw75zf3PdQZdMxhUh35VJCuMzQHSQrSDGaXusCguwdC86CZdF2nu
         PHlZhJTRAGeXhBTnCoJygD40aIHTj0wJn32veKFLMQGUJXWfQqz61gRSL2vBo76EP1qI
         0PY4v4OSzImxqCNMGhPGTz0yhhrfKTleaC5thvkFLk1a+oZx3hdldR4tWj4EwF90b6X6
         FMCcSqrtQf/MAlY1HWEWbLSsgYNZmVMCyJR6MpEj2CgUpNr79MEGnOQcM5/TwD9EOsyw
         72Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730460211; x=1731065011;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MmSEmeYDonrIbemmrcZ6psyt+xl4tMHb9OZDAE7y7oo=;
        b=pV8WVJN2pcCZ6kDr750qCJDLT8aXxBNoiSC8wXU+gc94tdynjcG4qy9gh3zltAu8dE
         pGBLTW3mU0HyY/CH6forFfnF69Q2EZuVGI1W3Y+ZYGReTVDPsQZKqcqVnyup8P0rSLIT
         tTdUNa39ktGTKU8x5tRFwIrqsZZRp7a6NLzDlpbST3NsJC/2DzZfKETT/+ZG0yiM6AWD
         whpouRpmvP9qIsYFXod7natmKiuKrYFw3BcmsU7s5XhoGA0MH6tMz5xn/zMW8Q66YHb0
         OIqJbWLxiblXamRpWVuUAGO1tYU5nFeFx09G/qZjedXB7nDdBXXKqbm3RznfZTZlM16J
         EWfw==
X-Gm-Message-State: AOJu0YwYHLolNJgLYfrH2wdlh1M2s/acFuWRBLFdixizTuFyKoNYDjaY
	C+UyDB9BgxNl/RtGc97QFlqOHONHRktfsIkAhO0I7i7LtogNRh2tE46RFLb/PvU=
X-Google-Smtp-Source: AGHT+IELC2z277Ao9WkMbcJsvDN3TCD73M3shzI0B+TN8qqkHEPp8i9NeV9O43mOqAaXk+lY3GKtFg==
X-Received: by 2002:a05:600c:1c11:b0:428:ec2a:8c94 with SMTP id 5b1f17b1804b1-4319ac9a725mr209913515e9.10.1730460211381;
        Fri, 01 Nov 2024 04:23:31 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d6984e3sm59350955e9.48.2024.11.01.04.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 04:23:31 -0700 (PDT)
Date: Fri, 1 Nov 2024 14:23:27 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: linux-pm@vger.kernel.org
Subject: [bug report] cpufreq: CPPC: Fix possible null-ptr-deref for
 cppc_get_cpu_cost()
Message-ID: <c4765377-7830-44c2-84fa-706b6e304e10@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Jinjie Ruan,

Commit 1a1374bb8c59 ("cpufreq: CPPC: Fix possible null-ptr-deref for
cppc_get_cpu_cost()") from Oct 30, 2024 (linux-next), leads to the
following Smatch static checker warning:

	kernel/power/energy_model.c:254 em_compute_costs()
	error: uninitialized symbol 'cost'.

kernel/power/energy_model.c
    241 static int em_compute_costs(struct device *dev, struct em_perf_state *table,
    242                             struct em_data_callback *cb, int nr_states,
    243                             unsigned long flags)
    244 {
    245         unsigned long prev_cost = ULONG_MAX;
    246         int i, ret;
    247 
    248         /* Compute the cost of each performance state. */
    249         for (i = nr_states - 1; i >= 0; i--) {
    250                 unsigned long power_res, cost;
    251 
    252                 if ((flags & EM_PERF_DOMAIN_ARTIFICIAL) && cb->get_cost) {
    253                         ret = cb->get_cost(dev, table[i].frequency, &cost);
--> 254                         if (ret || !cost || cost > EM_MAX_POWER) {
                                            ^^^^
cost can be uninitialized.

    255                                 dev_err(dev, "EM: invalid cost %lu %d\n",
    256                                         cost, ret);
    257                                 return -EINVAL;
    258                         }
    259                 } else {
    260                         /* increase resolution of 'cost' precision */
    261                         power_res = table[i].power * 10;
    262                         cost = power_res / table[i].performance;
    263                 }
    264 
    265                 table[i].cost = cost;
    266 
    267                 if (table[i].cost >= prev_cost) {
    268                         table[i].flags = EM_PERF_STATE_INEFFICIENT;
    269                         dev_dbg(dev, "EM: OPP:%lu is inefficient\n",
    270                                 table[i].frequency);
    271                 } else {
    272                         prev_cost = table[i].cost;
    273                 }
    274         }
    275 
    276         return 0;
    277 }

The commit added a new success path:

commit 1a1374bb8c5926674973d849feed500bc61ad535
Author: Jinjie Ruan <ruanjinjie@huawei.com>
Date:   Wed Oct 30 16:24:49 2024 +0800

    cpufreq: CPPC: Fix possible null-ptr-deref for cppc_get_cpu_cost()
    
    cpufreq_cpu_get_raw() may return NULL if the cpu is not in
    policy->cpus cpu mask and it will cause null pointer dereference,
    so check NULL for cppc_get_cpu_cost().
    
    Fixes: 740fcdc2c20e ("cpufreq: CPPC: Register EM based on efficiency class information")
    Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
    Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 309cca11b239..956d672c6d57 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -474,6 +474,9 @@ static int cppc_get_cpu_cost(struct device *cpu_dev, unsigned long KHz,
 	int step;
 
 	policy = cpufreq_cpu_get_raw(cpu_dev->id);
+	if (!policy)
+		return 0;
+
 	cpu_data = policy->driver_data;
 	perf_caps = &cpu_data->perf_caps;
 	max_cap = arch_scale_cpu_capacity(cpu_dev->id);

regards,
dan carpenter

