Return-Path: <linux-pm+bounces-34701-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAD1B58B85
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 03:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66E151A20FB4
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 01:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF99212560;
	Tue, 16 Sep 2025 01:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="IubZfCkp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C135C96;
	Tue, 16 Sep 2025 01:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757987616; cv=none; b=Avbpz9i5LhXnNnF/4wCfrbO+MPhD4phfubIiIaXPx6vFyv/Nhzd6zuOkqi1PVQWambOZfOglZq69ikGAkWjosIKSOepcY/ZJIE/LB42+I4ggqXbxLU2eGDprs1K6hM+mwz/78cnjNKHmsQ7AM9R0Sv1Y8c5eJv4DgYsAytJTC+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757987616; c=relaxed/simple;
	bh=+WC97bJV2feID+JAMJ7EpHO+HiaXV2tmzHdqaD9C6eA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PbFkw1HnBbR/L5ALa/sIeaU8CwjWMYzbkphltJcmT4WEKvLBb8IAWQc8IMgsr4Zi2qpXHvC9yM4KEuuqrai0k0lNZChWID9vSdwbarNjlsJQLCS7oif6ElZT2YTeLT1EX8ZAShqWNmrAjsDAmk5/xCPcDuGvxRAIncc6fMCj94I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=IubZfCkp; arc=none smtp.client-ip=220.197.32.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=l6mMRQRQgJNTDEgOEAjOL4ukZGtOO3ve5WWGMFpFwsE=;
	b=IubZfCkp+y3i0Zn1VNHhEEJjR94YNbfb3FgcUJt5Fv8AyIafbrHS2C4xcLSHF2
	97sGvdUaPnjqKgr1Hkmm0CAHjzGYnkXZdvGo9KqJOl57syyV3AzxNhvK6r1//H6w
	csZe2wfnGLXKbKoLK0lmdP5kFwm5sptbAls1WeTpUusRo=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgDXTwb4wshoJtOeBA--.45753S3;
	Tue, 16 Sep 2025 09:52:58 +0800 (CST)
Date: Tue, 16 Sep 2025 09:52:56 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Qais Yousef <qyousef@layalina.io>,
	Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] cpufreq: cap the default transition delay at 10 ms
Message-ID: <aMjC-BHKXjZkFmvj@dragon>
References: <20250910065312.176934-1-shawnguo2@yeah.net>
 <CAJZ5v0gL5s99h0eq1U4ngaUfPq_AcfgPruSD096JtBWVMjSZwQ@mail.gmail.com>
 <aMQbIu5QNvPoAsSF@dragon>
 <20250914174326.i7nqmrzjtjq7kpqm@airbuntu>
 <aMfAQXE4sRjru9I_@dragon>
 <CAJZ5v0i8L8w_ojua1ir3CGcwGSvE+3Jj0Sh5Cs1Yi8i4BX1Lbw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i8L8w_ojua1ir3CGcwGSvE+3Jj0Sh5Cs1Yi8i4BX1Lbw@mail.gmail.com>
X-CM-TRANSID:Ms8vCgDXTwb4wshoJtOeBA--.45753S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF4kZw1fuw1fur4xXrWDArb_yoW8trWxpF
	W5WwsFya4kXayqgwsFkw48ur1FqanYvFy7Ka4UurnYyw47JFnYg3WDKrWjyF95Aw1kJa1Y
	qFyqk39rGFWUArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uz6wZUUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiIBo7oGjIwvrUKQAA3E

On Mon, Sep 15, 2025 at 03:18:44PM +0200, Rafael J. Wysocki wrote:
> The question is not about who's fault it is, but what's the best place
> to address this issue.
> 
> I think that addressing it in cpufreq_policy_transition_delay_us() is
> a bit confusing because it is related to initialization and the new
> branch becomes pure overhead for the drivers that don't set
> cpuinfo.transition_latency to CPUFREQ_ETERNAL.
> 
> However, addressing it at the initialization time would effectively
> mean that the core would do something like:
> 
> if (policy->cpuinfo.transition_latency == CPUFREQ_ETERNAL)
>         policy->cpuinfo.transition_latency =
> CPUFREQ_DEFAULT_TANSITION_LATENCY_NS;
> 
> but then it would be kind of more straightforward to update everybody
> using CPUFREQ_ETERNAL to set cpuinfo.transition_latency to
> CPUFREQ_DEFAULT_TANSITION_LATENCY_NS directly (and then get rid of
> CPUFREQ_ETERNAL entirely).

So we fix the regression with an immediate change like below, and then
plan to remove CPUFREQ_ETERNAL entirely with another development series.
Do I get you right?

---8<---

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index d873ff9add49..e37722ce7aec 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -574,6 +574,10 @@ unsigned int cpufreq_policy_transition_delay_us(struct cpufreq_policy *policy)
        if (policy->transition_delay_us)
                return policy->transition_delay_us;
 
+       if (policy->cpuinfo.transition_latency == CPUFREQ_ETERNAL)
+               policy->cpuinfo.transition_latency =
+                       CPUFREQ_DEFAULT_TANSITION_LATENCY_NS;
+
        latency = policy->cpuinfo.transition_latency / NSEC_PER_USEC;
        if (latency)
                /*
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 7fe0981a7e46..7331bc06f161 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -36,6 +36,8 @@
 /* Print length for names. Extra 1 space for accommodating '\n' in prints */
 #define CPUFREQ_NAME_PLEN              (CPUFREQ_NAME_LEN + 1)
 
+#define CPUFREQ_DEFAULT_TANSITION_LATENCY_NS   NSEC_PER_MSEC
+
 struct cpufreq_governor;
 
 enum cpufreq_table_sorting {

--->8---

Shawn


