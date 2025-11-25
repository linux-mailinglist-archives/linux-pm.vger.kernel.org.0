Return-Path: <linux-pm+bounces-38618-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BD0C85E24
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 17:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C1283B344D
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 16:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0136D22D9ED;
	Tue, 25 Nov 2025 16:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WD9d2f8p"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEDF22B584
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 16:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764087042; cv=none; b=uIFLi+eqbXtY0eOG9P9IIja+WZ5Hj7iTRQK08OYZumQxRDJF1S/F2MnkfOSVZ9IxjbftEfvjG7UB7lRhTD7AmYfy0M0DCWIZX5HieJ1DoifatX//xhO3x/45XNhlGeQ0kWTtRgAlOMTTsRsG39NmVvhMbYgOPBNbNQhdZbwJLL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764087042; c=relaxed/simple;
	bh=g6ZTz2yobFwlthgGwZXrECJTPtoNkUr4RXZpEKPTUgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TxdefvDJhzqDAO3L9eR1UNVLPaMkIGYDQR7MqSNP+ykXSTSVgnrWGeqHC3lNxivtHH+yhcm8GD5TdYDJr5gobSZWAdl/y7pYWSmaZRPL7c5J67oiEJ54pgeosoinCPJZoC6UpVVZOquiSYrm9dt662xgLHFw4ffQjs1bvGfob4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WD9d2f8p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6943FC4CEF1
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 16:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764087042;
	bh=g6ZTz2yobFwlthgGwZXrECJTPtoNkUr4RXZpEKPTUgw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WD9d2f8pCc6HZDMrL2cmOGv8lKMKAgOsWJZPVMDGTgG++yeKJAJwXmH4ePcNHsMm9
	 OuTBLrx0C1B46uj3JxZneMUfiCRSXfBKszdjODfwketljtSlQzWSY4jKzTqucGr+jA
	 JYt0GYruBLKqOZ5fdsEdy9H9wDrtoka6yHsRGPxqmb28fI8W0N+Rlk4HrlV0n/DaNe
	 e2PYJr/zee0aSoHqtUzixTvufGz9H6vuUtMH92GavLSKz2zGLdwr8jNHGV1cZBrr3c
	 ViMLinyhEFS9LoZAH41bVVQLuC5pXxox8+B36ajMQP4wYs4jU7xS9dZPv79Y9Z5cMG
	 b+cKvg/GC7P6w==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-3d47192e99bso8023182fac.0
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 08:10:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXdJHUgzhlAjbf9UUqdELmEk0SWfet7jh+rcvcpisdLw8EIYjbm9DhHBUvYNZC/T3BYHJisvoR7+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPLpSX3ZYxc3+64zlDQvUb+iCeE3oL9U4nZp9ieKLEYbK6r4q/
	vli2YluJxIGnPMpqrqQ8y4v3wEmkigsW8KROCMclI5xRUXpirOc5hETBwCfav7ImiP30qzBl6dv
	LODCPRn+lA+4B0sCNO3tSQOcWl7uMSTA=
X-Google-Smtp-Source: AGHT+IEseVB7v5M2kfQT/Qu0bZcOJXQbu79CVyUY2MSxOeaiAF/WCt/xC6QPmAwW+PR7HRz/qaUVnU1kmhXfcbSKmS8=
X-Received: by 2002:a05:6808:c1f7:b0:450:b87b:1ec4 with SMTP id
 5614622812f47-45112910ab3mr6995482b6e.15.1764087041769; Tue, 25 Nov 2025
 08:10:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <gwxigmsrpc55d6aruxhhw7f2vbsmeduirzc6kbtztv6rr5ivgd@nbqeh3rajqib>
In-Reply-To: <gwxigmsrpc55d6aruxhhw7f2vbsmeduirzc6kbtztv6rr5ivgd@nbqeh3rajqib>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 25 Nov 2025 17:10:30 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j+496-Ab7KWnzXUyKVoFNYHi0gSQj1fSMgowbzgQ3q-Q@mail.gmail.com>
X-Gm-Features: AWmQ_bke-ZLWQKvZNUfgQQ1EuHdmkS4JPcMUzr12NRYAt_ZgPCTCmNwtZ7JIMWk
Message-ID: <CAJZ5v0j+496-Ab7KWnzXUyKVoFNYHi0gSQj1fSMgowbzgQ3q-Q@mail.gmail.com>
Subject: Re: [GIT PULL] cpufreq/arm updates for 6.19
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Viresh,

On Tue, Nov 25, 2025 at 8:45=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> Hi Rafael,
>
> The following changes since commit 211ddde0823f1442e4ad052a2f30f050145cca=
da:
>
>   Linux 6.18-rc2 (2025-10-19 15:19:16 -1000)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufr=
eq-arm-updates-6.19
>
> for you to fetch changes up to c3852d2ca46503c00866d8eea5e18bb67d981f9b:
>
>   cpufreq: qcom-nvmem: fix compilation warning for qcom_cpufreq_ipq806x_m=
atch_list (2025-11-21 10:21:13 +0530)
>
> ----------------------------------------------------------------
> CPUFreq updates for 6.19
>
> - tegra186: Add OPP / bandwidth support for Tegra186 (Aaron Kling).
>
> - Minor improvements to various cpufreq drivers (Christian Marangi, Hal
>   Feng, Jie Zhan, Marco Crivellari, Miaoqian Lin, and Shuhao Fu).
>
> ----------------------------------------------------------------
> Aaron Kling (1):
>       cpufreq: tegra186: add OPP support and set bandwidth
>
> Christian Marangi (2):
>       cpufreq: qcom-nvmem: add compatible fallback for ipq806x for no SME=
M
>       cpufreq: qcom-nvmem: fix compilation warning for qcom_cpufreq_ipq80=
6x_match_list
>
> Hal Feng (1):
>       cpufreq: dt-platdev: Add JH7110S SOC to the allowlist
>
> Jie Zhan (1):
>       cpufreq: CPPC: Don't warn if FIE init fails to read counters
>
> Marco Crivellari (1):
>       cpufreq: tegra194: add WQ_PERCPU to alloc_workqueue users
>
> Miaoqian Lin (1):
>       cpufreq: nforce2: fix reference count leak in nforce2
>
> Shuhao Fu (1):
>       cpufreq: s5pv210: fix refcount leak
>
>  drivers/cpufreq/cppc_cpufreq.c       |  17 ++++++++---------
>  drivers/cpufreq/cpufreq-dt-platdev.c |   1 +
>  drivers/cpufreq/cpufreq-nforce2.c    |   3 +++
>  drivers/cpufreq/qcom-cpufreq-nvmem.c |  35 +++++++++++++++++++++++++++++=
+++--
>  drivers/cpufreq/s5pv210-cpufreq.c    |   6 ++++--
>  drivers/cpufreq/tegra186-cpufreq.c   | 150 +++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++-------
>  drivers/cpufreq/tegra194-cpufreq.c   |   3 ++-
>  7 files changed, 194 insertions(+), 21 deletions(-)
>
> --

Pulled and added to linux-pm.git/linux-next, thanks!

