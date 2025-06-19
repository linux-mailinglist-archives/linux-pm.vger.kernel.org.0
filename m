Return-Path: <linux-pm+bounces-29068-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4D8AE0427
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 13:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 701F11885B74
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 11:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5752264DD;
	Thu, 19 Jun 2025 11:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FeJazXEM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EE622539D
	for <linux-pm@vger.kernel.org>; Thu, 19 Jun 2025 11:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750333296; cv=none; b=Z+J9Nybgxm7Jc9ju2MfIFPEeOS+GvsORn2weSC92M7yM5k0zgFSp/Hnjo/+mzQFX6wOybH8JI0fLIdljZ0BdLpLA/g/ThPsrB4vCMVwkBUdwzlpdp/Z6h4tK9v6uyIPYtnXKe5eTCx6GyBOi1RPcSN1FNb9d5yZrs1wxJsUq6Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750333296; c=relaxed/simple;
	bh=FNkRJbjUbXtGGE6vjhHrYlnt1hp6guFu6M6ANMABhwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oBzJweDM9GWAGXQlHtc0jAt0h/Ium47tTAzCoj51orsQkxg0W6pQNFwFiK6DA+ZQCOLRT2ntmOpR0GNPe09+arYgwhXMmUTpTUlRc/YEXp9MJ7jo0SEK6qf5wuOPIBFtFcYKMOIXjOFm94kQhwHX4VCkXNYfezpZwEZPjDMVeNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FeJazXEM; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e82596e88c4so652703276.1
        for <linux-pm@vger.kernel.org>; Thu, 19 Jun 2025 04:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750333294; x=1750938094; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4Gg7ntijtB80tv+b2enRtRMmTEicRNdW1NiQNVbSDNo=;
        b=FeJazXEMOjHde4QHNCFjVSVDnhPcE6Xy0G5YeyvdEcbZ8YEaokBq+Ys4zrqtht0bdR
         5TLVJQvgAjU7sKdEdpz2j4e0JtpV0eScMMbx3TU02Csu072OndkAQyvVCPOsuxDGNWJM
         r7ujWsdP7Ick8ifhdGDIF0NDBpGQ1Y/jWzT6rPAcn8cI5nC5+fqizuHgIGKY2AbpbV+w
         mVB5qoRSBMGugRh1RlaUovWtwgmSmyvvXr2yloHc0Q8rc+9u48IQa89nnaCCaIT73VO1
         5l7wR7bnZhLx9eyvpmsdnlIi5nLVS2vkt5ahMEfIMqoe637wU1NZFEY+LyDLxj2IK5hx
         BeWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750333294; x=1750938094;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Gg7ntijtB80tv+b2enRtRMmTEicRNdW1NiQNVbSDNo=;
        b=ki7aipEMMbBp5on2O4CG+UmCgKU/vlHiwQKp8pHVHM1sLAEksGOlySF6TbOOaM38J4
         mplvWP9XRIEpx1X0yDTgjP2W+uG/+PeIlW11oavNGv8Wy3G2T3OzVpEXCdyJhzYRNvaX
         BaXt9F07ImGv2ffEgHd8+NemdQVIxDkJ3LodAp3v/Z1DXpWonv5DmilkNzaqFFvvauIl
         DsjY35EvzaMKPfOy4mlXAXMYaWX+Xtrt45TkIfi0gImhxfjB8g5olRgzHyrwNnl5T0nf
         KFpPUqrsmyQHoouabc+1DHHYmFpW8kJeyZzXeBiZINEZs6PUu4H7CZZrm9OuNrLu6CYn
         pOKg==
X-Forwarded-Encrypted: i=1; AJvYcCUUY81QMPJQRUMDoYxZPYAWQnF44A6bhFdpH1nyCpWria+khzd9TMhcmRvmJnKmht1qMG83i5msAQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyieR8vJp3pNc75dt6VXgzpuWUOx9njj8GT3g7U+c0O/pxITqB2
	yAxu28WBZekNaV43+YVnqiYToG0c0d8ztQHR3qIBC65pG2db+uk7BPSsVrblrBTOPfqJUhsjTLC
	9PGmHDA/YvAgPqZNpsa+ysYRQ2eFjkPMfzQC5ZvFZoA==
X-Gm-Gg: ASbGncvdEjNyY3idDImFtlPKE4+viRUwytzdY+jO90B/sCT3hGjXbFUw8o7LKLnuAkR
	hEj2kFOJPg8japxuewmbtGytTFOq1QKYnYgswbXfwF8frHSqmqK/GxW6FdKBkwzNJkcLwqurK3k
	xriCYc95OxRVOwIhch2WPezhRCeTCFK+pIm7VscU1LlpDh
X-Google-Smtp-Source: AGHT+IESytQv1SK+Cd0PiaLJS4H3+JL25iRqvMAyP4xLxjP0vD5U9p3Ec+J/uOKogngm7hlSby5T2PNl/VdbIi6REWE=
X-Received: by 2002:a05:6902:1b8e:b0:e81:9d60:93a4 with SMTP id
 3f1490d57ef6-e822acac581mr30264102276.10.1750333293696; Thu, 19 Jun 2025
 04:41:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523134025.75130-1-ulf.hansson@linaro.org> <fd4cfe7a-e29b-4237-b82f-48354deead3b@ideasonboard.com>
In-Reply-To: <fd4cfe7a-e29b-4237-b82f-48354deead3b@ideasonboard.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 19 Jun 2025 13:40:57 +0200
X-Gm-Features: AX0GCFuFeZwy4zEBgov1_20jiDIxj_2DarP8G86PtCbzf_bxqvHrj-WuuKyOtBY
Message-ID: <CAPDyKFpprO=HGuiHX3MQ_+m1YRnaWG=XwCx8-fSdXak8VBDUbQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/21] pmdomain: Add generic ->sync_state() support to genpd
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Saravana Kannan <saravanak@google.com>, Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, Bjorn Andersson <andersson@kernel.org>, 
	Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@oss.nxp.com>, 
	Johan Hovold <johan@kernel.org>, Maulik Shah <maulik.shah@oss.qualcomm.com>, 
	Michal Simek <michal.simek@amd.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Jun 2025 at 12:33, Tomi Valkeinen
<tomi.valkeinen@ideasonboard.com> wrote:
>
> Hi Ulf,
>
> On 23/05/2025 16:39, Ulf Hansson wrote:
> > Changes in v2:
> >       - Well, quite a lot as I discovered various problems when doing
> >       additional testing of corner-case. I suggest re-review from scratch,
> >       even if I decided to keep some reviewed-by tags.
> >       - Added patches to allow some drivers that needs to align or opt-out
> >       from the new common behaviour in genpd.
> >
> > If a PM domain (genpd) is powered-on during boot, there is probably a good
> > reason for it. Therefore it's known to be a bad idea to allow such genpd to be
> > powered-off before all of its consumer devices have been probed. This series
> > intends to fix this problem.
> >
> > We have been discussing these issues at LKML and at various Linux-conferences
> > in the past. I have therefore tried to include the people I can recall being
> > involved, but I may have forgotten some (my apologies), feel free to loop them
> > in.
> >
> > I have tested this with QEMU with a bunch of local test-drivers and DT nodes.
> > Let me know if you want me to share this code too.
> >
> > Please help review and test!
>
> I tested this Renesas white-hawk board, and it hangs at boot. With
> earlycon, I captured with/without boot logs, attached.
>
> The hang case doesn't look very healthy with all these: "kobject:
> '(null)' ((____ptrval____)): is not initialized, yet kobject_get() is
> being called."

Tomi, thanks a lot for helping out with testing!

rcar_gen4_sysc_pd_init() calls pm_genpd_init() and
of_genpd_add_provider_onecell().

rcar_gen4_sysc_pd_init() is an early_initcall, which I guess is the
reason for these problems, as the genpd_provider_bus has not been
registered that early (it's done at core_initcall)

Do you think it would be possible to move rcar_gen4_sysc_pd_init() to
a postcore/arch_initcall?

Kind regards
Uffe

