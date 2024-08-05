Return-Path: <linux-pm+bounces-11916-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC815947A77
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2024 13:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99356281C84
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2024 11:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58ECA1586F3;
	Mon,  5 Aug 2024 11:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fgLakQ9F"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62F4155C98
	for <linux-pm@vger.kernel.org>; Mon,  5 Aug 2024 11:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722857746; cv=none; b=d5+ggR6vAXB762B8TYA15l25H9vaA8LiR+89t7/x5jJQCrZZuN0mYYQSIsv/iexwbGM7CPCQtWL37bSaMapgyuOIpfzbOl2svXiXp6XyQ7NChwXvmQf6Ibo3FMv3yU/7aPbq8n3VpBzCrBgVhMmoxoYudnqFAIqWv7qQQcUUI2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722857746; c=relaxed/simple;
	bh=8G/5og31ZdWxDbzaltklXNdhbY//dhSu0UC8kT0ECxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jn8XZgOLP+nB2CeoMY2SGawf8m+1k/j+pH74ZSxYXgFE5YDnXgMF/wdOT/UKvoT7jduE8uUsX4Peo0/BKuumVVUq5nr07JZpLWjCcLQ1ADWhcn9VPqATSVeoO3I12zPfux7HcsvAFoIgq1SwOyanKHKHR1fnaWDwftyDOI0jdnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fgLakQ9F; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dff1ccdc17bso8787584276.0
        for <linux-pm@vger.kernel.org>; Mon, 05 Aug 2024 04:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722857742; x=1723462542; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RC1mkfGxghq8dpQy/VjlNqYZwIedOyF9cpN0BiEfzRE=;
        b=fgLakQ9FvpXkn4I4E/CNR9O9YKevVC2hvjyD+Ysb6HdjSzoO9IhLqjAUIiclhaP6xU
         nbGCVNi0LSZUxo4pTQFNH3jzwYTR4prKuPN7qIYW6Cs0DNMKtRK4TUabCYRuecG2+3R7
         5KAAUHbxa7tjsn7fAfSvr03MsP5uK1auh9WmMCDBRsDw9uGk0M02FliFzVGCZmEUSL15
         9ljuLTa0cDx1QV5m1y1xCMrtdlyGPs/m6OKt79a7dmkuCIpvMNwLXGb18O+H3aLC1xIN
         MeMFUwnVvN5qpnlPBNRIi2QJHb9hJUCuS5d14HYhcMm2lTdqVgutqtc/yZvUDro8ewHx
         Q8Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722857742; x=1723462542;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RC1mkfGxghq8dpQy/VjlNqYZwIedOyF9cpN0BiEfzRE=;
        b=XH2ws2q2CFhWpkymyE8R6TDONQUawlE9IaVz7/174uc20V760rW+IgEOYEE7omyFP+
         tEaILWrCLNvvQOXBwExv1FaWOUjIi1B9j2+IjEtLe93Kg7S5EMk8ih4HXwmssSxDWn7a
         I1gsqLTPJjXBKsmnje4ZANBMxDChXaPrk4GO2hPICZWKsevJOcMyLWvvZHrfrHR2e5YT
         GCEANHzR1aN/w2/h/Q6fRP5Zo4bQIvFVJD6bpGToO7sRpn7NphehKNjcIZN4INjlOlmI
         fskFrkwBqu3mukt8abtm1soDXEELf+L0x7V/cPWRb+bQbB1G1556namE7IWo0pA/ox2J
         a11A==
X-Forwarded-Encrypted: i=1; AJvYcCVoqs+RY2FNuAgQSKuToBJQ0tsir1WYaKe3elcLu3VlgDKCdRL5oV2N46tckW8oGWn2MD1kwpuBj8UbTwILcvJo2+OOOg75fhk=
X-Gm-Message-State: AOJu0YzMeUr7q6IJ/owFGh6gN5VDpIEPh9Ph0E+wgp3gc8xXuPwnswum
	Cm4roRpGxm3Crhb9LoGZWr5cwCib24o+tURjwRjYBeP6FdEu2CKcRgwA4jzAA4ANVP4sQ3bjhcX
	e8BkLOud+q3+hPqg9s/5fQK8wanI9Qpc9/Xc3TA==
X-Google-Smtp-Source: AGHT+IGrk7bdr9hMTo+pdPXGdlCB4JCPDeCJ5I15NZK30YOAHMCo5ECXoQSHSGJf0dFY7hrfZVW0IaiXzgYW21XQJsg=
X-Received: by 2002:a05:6902:2193:b0:e0b:e28c:b4f4 with SMTP id
 3f1490d57ef6-e0be28cb8b9mr11954505276.38.1722857741726; Mon, 05 Aug 2024
 04:35:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527142557.321610-1-ulf.hansson@linaro.org>
In-Reply-To: <20240527142557.321610-1-ulf.hansson@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 5 Aug 2024 13:35:06 +0200
Message-ID: <CAPDyKFpPbQ9rPSL8Uurk_AsZfqH8-EY9vGUVC9ah-c9tMqTvXg@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] pmdomain/cpuidle-psci: Support s2idle/s2ram on PREEMPT_RT
To: "Rafael J . Wysocki" <rafael@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org, 
	quic_rkakarla@quicinc.com, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Nikunj Kela <nkela@quicinc.com>, 
	Prasad Sodagudi <psodagud@quicinc.com>, Maulik Shah <quic_mkshah@quicinc.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, linux-rt-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

+ Raghavendra Kakarla, Sebastian Andrzej Siewior

On Mon, 27 May 2024 at 16:26, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> Updates in v2:
>         - Rebased and fixed a small issue in genpd, see patch3.
>         - Re-tested on v6.9-rt5 (PREEMPT_RT enabled)
>         - Re-tested on v6.10-rc1 (for regressions, PREEMPT_RT disabled)
>
> The hierarchical PM domain topology and the corresponding domain-idle-states
> are currently disabled on a PREEMPT_RT based configuration. The main reason is
> because spinlocks are turned into sleepable locks on PREEMPT_RT, which means
> genpd and runtime PM can't be use in the atomic idle-path when
> selecting/entering an idle-state.
>
> For s2idle/s2ram this is an unnecessary limitation that this series intends to
> address. Note that, the support for cpuhotplug is left to future improvements.
> More information about this are available in the commit messages.
>
> I have tested this on a Dragonboard 410c.
>
> Kind regards
> Ulf Hansson
>
>
> Ulf Hansson (7):
>   pmdomain: core: Enable s2idle for CPU PM domains on PREEMPT_RT
>   pmdomain: core: Don't hold the genpd-lock when calling
>     dev_pm_domain_set()
>   pmdomain: core: Use dev_name() instead of kobject_get_path() in
>     debugfs
>   cpuidle: psci-domain: Enable system-wide suspend on PREEMPT_RT
>   cpuidle: psci: Drop redundant assignment of CPUIDLE_FLAG_RCU_IDLE
>   cpuidle: psci: Enable the hierarchical topology for s2ram on
>     PREEMPT_RT
>   cpuidle: psci: Enable the hierarchical topology for s2idle on
>     PREEMPT_RT
>
>  drivers/cpuidle/cpuidle-psci-domain.c | 10 ++--
>  drivers/cpuidle/cpuidle-psci.c        | 26 ++++++----
>  drivers/pmdomain/core.c               | 75 +++++++++++++++++++--------
>  include/linux/pm_domain.h             |  5 +-
>  4 files changed, 80 insertions(+), 36 deletions(-)
>

Just wanted to let you all know that I have queued up this series via
my pmdomain tree. Please let me know if you have any further
comments/suggestions.

Kind regards
Uffe

