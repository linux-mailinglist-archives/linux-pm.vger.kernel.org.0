Return-Path: <linux-pm+bounces-41534-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UId6F+jEeGmltAEAu9opvQ
	(envelope-from <linux-pm+bounces-41534-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 15:00:08 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BE99541E
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 15:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11AB43088467
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 13:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54E23570AD;
	Tue, 27 Jan 2026 13:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBAwseXn"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A382E9EAC
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 13:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769521953; cv=none; b=T6cNyZvW8LJurh0GGdEto6Fjx9H2GfieM55oZflUkLnSzOVZNAlsrKcvQUVzkZBmeXzLM4ICbahAkvfwRq73wKuYmftgo7Yprb0Mi5lIYZgCIKfzfRHcZ+LTSyK/B0pDyyOM6slNL7C1vKTXqHFw37sVTqEX266nGck1NYtMlSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769521953; c=relaxed/simple;
	bh=NVql8P5Mbunn0CSxPnWOrBCrUxoWg6ovj4JiHG3yTsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OwFnjl/EssCr2vkwvijmkGsCPXEKnS1TcqphSrV+rQS1AE89cXsXVthIfpM6zclFnq/P8WaJSS7g0jYKy7R1mCJG7Mfri8l5CmySj/2D1U4BKC2YWWRjpEhYulOOw/yXx8z6CDxvqJhxozkntJEwZlSo1uuyBOI+3JeQdMkqIXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBAwseXn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15043C116C6
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 13:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769521953;
	bh=NVql8P5Mbunn0CSxPnWOrBCrUxoWg6ovj4JiHG3yTsU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gBAwseXn/B1bom7Pj0l5663okmOiOlwA3d/bO0aKp0pfjg+7SiOS/lB39Ex4PP7kR
	 ee5yIZbRhgYE+LtZgPpQ2148QH7ZMAOQWfrWlUeVDaCAMTGFTjx9YYhQQLQ4WKqKH5
	 vPVX7seasOu/euvf4zLNiQGHcv8HpnTQjS0RKP7FVO7+5XdkG/sTj7VoIUU03+yEDm
	 KQ48IoFjqNzSC9wF77YkfqlfrukmXhL84YmVSPjANnxIk1+TedJLMXegz1ndxk4JQb
	 X3RKUTGYAq91pn0Euplmt/ZykVlL9+HpL98bzEc5bO/M89KEBUfmDitcZmKu4HgwFU
	 8HtJRvQ73v3tw==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-662f65c7d8cso82020eaf.2
        for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 05:52:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVL4w9U8LD2tCPiN+DH0hgQLYZLqjjBXguEf8+PFq/Y/Bxs6hDKY1OK4Wb9YN9nXlHvhevLfZar2w==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi+E2tWDZOsE/NyUsuLyOKinBstQGJLdfoHOgecQEZ4YWo4mmT
	abx7yREf370uTqOD0dA19afcOE6gTNUvi05QaUYjfFKfmFcLDcQKNZBmH7+nkvKjQB3rOkqOv+7
	EVAK/n7tGwTT1B0esZZqdJYaxNLCIJ+4=
X-Received: by 2002:a05:6820:458b:b0:659:9a49:9081 with SMTP id
 006d021491bc7-662f20ec883mr785520eaf.76.1769521952087; Tue, 27 Jan 2026
 05:52:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <j4qdid7iqmng4gzb5ozefemjkep3wx2b5z2yki5tnqc3vzvzf4@kvrnarvdod5p>
In-Reply-To: <j4qdid7iqmng4gzb5ozefemjkep3wx2b5z2yki5tnqc3vzvzf4@kvrnarvdod5p>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 27 Jan 2026 14:52:19 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gH-g5H4fqowtoNs1ZTDWR4xa4Wd9Db2uSJxjWW_KsZVg@mail.gmail.com>
X-Gm-Features: AZwV_Qh-gR8MqMMgvHpklg0HYw5v13tkKRZYN50DYm25uNl_nVAhjEpc22naLP4
Message-ID: <CAJZ5v0gH-g5H4fqowtoNs1ZTDWR4xa4Wd9Db2uSJxjWW_KsZVg@mail.gmail.com>
Subject: Re: [GIT PULL] cpufreq/arm updates for 7.0
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-41534-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A2BE99541E
X-Rspamd-Action: no action

Hi Viresh,

On Tue, Jan 27, 2026 at 7:56=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> Hi Rafael,
>
> The following changes since commit 7e3debb4c72fe840d60014192cf93950871fb3=
be:
>
>   cpufreq: qcom-nvmem: add sentinel to qcom_cpufreq_ipq806x_match_list (2=
026-01-27 11:21:22 +0530)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufr=
eq-arm-updates-7.0-rc1
>
> for you to fetch changes up to 0b7fbf9333fa4699a53145bad8ce74ea986caa13:
>
>   cpufreq: scmi: Fix device_node reference leak in scmi_cpu_domain_id() (=
2026-01-27 11:21:24 +0530)
>
> ----------------------------------------------------------------
> CPUFreq arm updates for 7.0

Is the 7.0 thing official already?

> - Update cpufreq-dt-platdev list for tegra, qcom, TI (Aaron Kling,
>   Dhruva Gole, and Konrad Dybcio).
>
> - Minor improvements to the cpufreq / cpumask rust implementation
>   (Alexandre Courbot, Alice Ryhl, Tamir Duberstein, and Yilin Chen).
>
> - Add support for AM62L3 SoC to ti-cpufreq driver (Dhruva Gole).
>
> - Update FIE arch_freq_scale in ticks for non-PCC regs (Jie Zhan).
>
> - Other minor cleanups / improvements (Felix Gu, Juan Martinez, Luca
>   Weiss, and Sergey Shtylyov).
>
> ----------------------------------------------------------------
> Aaron Kling (1):
>       cpufreq: Add Tegra186 and Tegra194 to cpufreq-dt-platdev blocklist
>
> Alexandre Courbot (1):
>       rust: cpufreq: always inline functions using build_assert with argu=
ments
>
> Alice Ryhl (1):
>       rust: cpufreq: add __rust_helper to helpers
>
> Dhruva Gole (2):
>       cpufreq: dt-platdev: Add ti,am62l3 to blocklist
>       cpufreq: ti-cpufreq: add support for AM62L3 SoC
>
> Felix Gu (1):
>       cpufreq: scmi: Fix device_node reference leak in scmi_cpu_domain_id=
()
>
> Jie Zhan (3):
>       ACPI: CPPC: Factor out and export per-cpu cppc_perf_ctrs_in_pcc_cpu=
()
>       cpufreq: CPPC: Factor out cppc_fie_kworker_init()
>       cpufreq: CPPC: Update FIE arch_freq_scale in ticks for non-PCC regs
>
> Juan Martinez (1):
>       cpufreq/amd-pstate: Add comment explaining nominal_perf usage for p=
erformance policy
>
> Konrad Dybcio (1):
>       cpufreq: dt-platdev: Block the driver from probing on more QC platf=
orms
>
> Luca Weiss (1):
>       dt-bindings: cpufreq: qcom-hw: document Milos CPUFREQ Hardware
>
> Sergey Shtylyov (1):
>       cpufreq: scmi: correct SCMI explanation
>
> Tamir Duberstein (1):
>       rust: cpufreq: replace `kernel::c_str!` with C-Strings
>
> Yilin Chen (1):
>       rust: cpumask: rename methods of Cpumask for clarity and consistenc=
y
>
>  Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml |  2 ++
>  drivers/acpi/cppc_acpi.c                                       | 48 ++++=
+++++++++++++++++++++++---------------------
>  drivers/cpufreq/amd-pstate.c                                   | 13 ++++=
+++++++++
>  drivers/cpufreq/cppc_cpufreq.c                                 | 96 ++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------=
-----------------
>  drivers/cpufreq/cpufreq-dt-platdev.c                           |  6 ++++=
++
>  drivers/cpufreq/rcpufreq_dt.rs                                 |  5 ++--=
-
>  drivers/cpufreq/scmi-cpufreq.c                                 |  3 ++-
>  drivers/cpufreq/ti-cpufreq.c                                   | 34 ++++=
+++++++++++++++++++++++++++++-
>  include/acpi/cppc_acpi.h                                       |  5 ++++=
+
>  rust/helpers/cpufreq.c                                         |  3 ++-
>  rust/kernel/cpufreq.rs                                         |  5 +++-=
-
>  rust/kernel/cpumask.rs                                         | 10 ++++=
+-----
>  12 files changed, 164 insertions(+), 66 deletions(-)
>
> --

Pulled and added to linux-pm.git/linux-next, thanks!

