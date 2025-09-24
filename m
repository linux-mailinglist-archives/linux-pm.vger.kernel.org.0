Return-Path: <linux-pm+bounces-35286-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF902B9AC67
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 17:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A31702A26BE
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 15:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087103128C9;
	Wed, 24 Sep 2025 15:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uTEP9tP5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1584630C0E7
	for <linux-pm@vger.kernel.org>; Wed, 24 Sep 2025 15:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758729229; cv=none; b=UNubGGZZOgMgzNt0NVDvo75XW6Fw864Ftyb2H3lT4ywmTbV71hnHL94+JTD98dKp5ihDcn0mtjPaJxtxl91ZJlgAOC73kkZ7KnEasvMuMYD7FH6iwtDDP+4xvM9X3OPI9qrx/EgdP3c64Fa9nf9MRA6dRGpbFjxiHNwaU/1r7XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758729229; c=relaxed/simple;
	bh=1PUNlHIAYtCH55z1RdMjhD1jhr0FPn3wNb7XI9Lq6xo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C1QI0EfjlH6nzveuSNUK/LMleQ4UBxD95VC4odcVfkD/EjTGQC95A6mkrar0V+Gu5moKPp4Pp8A2wOVDcRvlu4pRTdhrEvXwlWMeIQXiocG7nBDkrBLThV0pry6GGiMF+RAyWAIQkEsGnjKikS3rFrZqMHvyueG5vu9b20kIyRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uTEP9tP5; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-eaf8e473ddcso1125719276.0
        for <linux-pm@vger.kernel.org>; Wed, 24 Sep 2025 08:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758729227; x=1759334027; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/ws36E4l6sDZ0NgTD31F0HXvzlU5qFwYdqyOPAZNL3c=;
        b=uTEP9tP5bDcl9prhys/XUgupR6QJxTpv9JoRmKqdHXUbMNWG4f+BR66aO85uVUIHng
         UufipDJlFFR+fSUCcpTk/pf8wIeuePmjMuIrpboHmSnsvY7Wa6VGz6N8HGmZ+qNcZdkY
         wNrRkOhYTezFljyl7Y5bM98UTTcQxFsavDibS2RGGlneTvgFbq6iayoNBG0RoBW2kJct
         0o4lzd9a0cCAwD+pQCyt634J+tFeqhFRvSR2mGZcnca8Nzz0pvTMlUM8MDMBAQSG7q/B
         ++TR1Fp0acm7kIpz+hJlRyLkF1Gc67qqQ1v3kRQDsqrzSWW0IyCOrteGUO7pmS2ryNXl
         eHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758729227; x=1759334027;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ws36E4l6sDZ0NgTD31F0HXvzlU5qFwYdqyOPAZNL3c=;
        b=PIhvCFrBgRmExBn9Wpec5XMhmeD6xNQu97dCsDG1Q7Z8vw5PkjkDUcAbgiRJfCRkr5
         8C1V7t9GjX6o6syWpqY7SQe0K5CaFe/DlnwP541CWZ66OPPKQb4U3XJnfWUokiOKeEeP
         NWaZKf6Bgn4RJIOLIlG/umvUa22Q14jNoWoZh+o9M3S+UbbiwpeksN/OqBZlp/xeEnrd
         fKC4jSIdM6YPrQNyEkaCmUUDLl/ztx/H/zK843jbSElZKOusPdmuFA7/YuqIrIsbhyqp
         deajryqjI974/JyKHVHYWTrVgoNuL2fyJyyYvD2ZaBCzBZgomJxzyhD3UIipADXKTGIL
         ZtaA==
X-Forwarded-Encrypted: i=1; AJvYcCXCpacoOSmmSK2RUcGRiH2AS02oGpo+OffQK+EY3aHTJgF6Pg7DYeyw9Z+1BEkcpwPJATG/5YGDBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwuA8IZ0H7ThhPn5Z/bzFE1GdCxOoNcBxQ2canyogACFqXmw9S8
	U/H/w4PVZGvAKj2Fil+K55m3b/85gXLbv5vCzpBbqzgTG52ElNaB5sPNNZNnL9kfcAzpALGdcMT
	Y+LnbYLwDjHSpeyHMEcA0R13UeRRSbcXWHZ1ozBucRA==
X-Gm-Gg: ASbGnctG0VUPbb8tmmnTFQxnqMbuyuoSrLPUbfFFTrrmhjHfxZGOopYiDDDS3SPKxMM
	tuvWh5IEIkBliEAQiw6t+eQNxknJlXvQd010d5Fu9HOhBFvYq7a0RWoPZyOHGsxTjlGT+7a4GiQ
	aKaSQ2435i9K4s7YgOkV99DvdTYXOK3uoQTciQS4Id3FwTSKn+tql0VNUS0pQd8EjEdL3RAj1K9
	1qEtdrZGbwuZchn9M9Er4FIdEH6ZYHchxxCEA==
X-Google-Smtp-Source: AGHT+IG/0HOlWN+Opy8mk1rlXCX6lREWcCWPZFITT3xAhxjSLe4cF9GNTsFZhuk9Ow8vzBprt7QptbBAX/tQMBdgAFw=
X-Received: by 2002:a05:690e:1648:b0:633:b317:9cea with SMTP id
 956f58d0204a3-6361a90013cmr66977d50.8.1758729226717; Wed, 24 Sep 2025
 08:53:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701114733.636510-1-ulf.hansson@linaro.org>
 <20250701114733.636510-21-ulf.hansson@linaro.org> <4478f28b-47f8-4049-bf17-b7fc95cfac65@nvidia.com>
 <CAPDyKFqSyP3e=JRFYEuFefWVN5SYJWULU8SKzXmrThvyiVGXgg@mail.gmail.com>
 <a904d953-acb2-44f6-81bd-118f7abd22da@nvidia.com> <614f726c-4d6d-463b-a8b3-26d3df590575@nvidia.com>
In-Reply-To: <614f726c-4d6d-463b-a8b3-26d3df590575@nvidia.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 24 Sep 2025 17:53:11 +0200
X-Gm-Features: AS18NWBv34Nq6YjDF4uwQFfPTxm1VXqbNiERHa_duVzXNf8ehBq83NeR0ORga00
Message-ID: <CAPDyKFoPOejFT+=OBoLTBXj5GYuHFwwnY9qGROTynrtHT=mCAw@mail.gmail.com>
Subject: Re: [PATCH v3 20/24] pmdomain: core: Default to use
 of_genpd_sync_state() for genpd providers
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Saravana Kannan <saravanak@google.com>, Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, Bjorn Andersson <andersson@kernel.org>, 
	Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@oss.nxp.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Johan Hovold <johan@kernel.org>, 
	Maulik Shah <maulik.shah@oss.qualcomm.com>, Michal Simek <michal.simek@amd.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Hiago De Franco <hiago.franco@toradex.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Sept 2025 at 13:41, Jon Hunter <jonathanh@nvidia.com> wrote:
>
> Hi Ulf,
>
> On 03/09/2025 13:33, Jon Hunter wrote:
>
> ...
>
> >>> Following this change I am seeing the following warning on our Tegra194
> >>> devices ...
> >>>
> >>>    WARNING KERN tegra-bpmp bpmp: sync_state() pending due to
> >>> 17000000.gpu
> >>>    WARNING KERN tegra-bpmp bpmp: sync_state() pending due to 3960000.cec
> >>>    WARNING KERN tegra-bpmp bpmp: sync_state() pending due to
> >>> 15380000.nvjpg
> >>>    WARNING KERN tegra-bpmp bpmp: sync_state() pending due to
> >>> 154c0000.nvenc
> >>>    WARNING KERN tegra-bpmp bpmp: sync_state() pending due to
> >>> 15a80000.nvenc
> >>>
> >>> Per your change [0], the 'GENPD_FLAG_NO_SYNC_STATE' is set for Tegra
> >>> and so should Tegra be using of_genpd_sync_state() by default?
> >>
> >> This is a different power-domain provider (bpmp) in
> >> drivers/firmware/tegra/bpmp.c and
> >> drivers/pmdomain/tegra/powergate-bpmp.c.
> >>
> >> For the bpmp we don't need GENPD_FLAG_NO_SYNC_STATE, as the
> >> power-domain provider is described along with the
> >> "nvidia,tegra186-bpmp" compatible string. In the other case
> >> (drivers/soc/tegra/pmc.c) the "core-domain" and "powergates" are
> >> described through child-nodes, while ->sync_state() is managed by the
> >> parent-device-node.
> >>
> >> In the bpmp case there is no ->sync_state() callback assigned, which
> >> means genpd decides to assign a default one.
> >>
> >> The reason for the warnings above is because we are still waiting for
> >> those devices to be probed, hence the ->sync_state() callback is still
> >> waiting to be invoked. Enforcing ->sync_state() callback to be invoked
> >> can be done via user-space if that is needed.
> >>
> >> Did that make sense?
> >
> > Sorry for the delay, I was on vacation. Yes makes sense and drivers for
> > some of the above drivers are not yet upstreamed to mainline and so this
> > would be expected for now.
>
>
> I have been doing more testing and do see a lot of "tegra-bpmp bpmp:
> sync_state() pending due to" on our platforms for basically are driver
> that is built as a module. It seems a bit noisy given that these do
> eventually probe OK. I am wondering if this should be more of a
> dev_info() or dev_dbg() print?

Yes, I agree. We have had similar reports for other platforms too.

I intend to send a patch for this in the next day or so.

Kind regards
Uffe

