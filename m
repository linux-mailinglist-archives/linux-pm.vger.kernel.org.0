Return-Path: <linux-pm+bounces-34231-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8A6B4A94C
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 12:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A3B5161A1A
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 10:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A8C3176E1;
	Tue,  9 Sep 2025 10:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcNGCFiG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC7D3148B7;
	Tue,  9 Sep 2025 10:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757412236; cv=none; b=eR9426kCMB9G/dl8DSCwOcxYcT2OyFJT7dZh57uVOb0alUpTGkVWS4wAf9jZFf+X2NhBYeJkZJUIxKEGGnl0rKR8lOOXdTeclLnx7frn9ZYbuhja19JqjKNnUhhSLO1P92IBy+YSgI8NNsSSfQ90gJ6VSdeCWuVd/rGAUVquspA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757412236; c=relaxed/simple;
	bh=MX1yEKtU1XlkDkySNWFMl83sKLvqqiq1wh9vWRpHFI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AxkR3Zpq0T/F/vdMyMcazTifgpj6K1D9N9xy5wl5UAintdh5McVxQx4/YTUnBwHctVxuh+FnMknMd+G+KFPQQ0vV35GolwsnWy/s/Rf0zboDUoCX79BWJEd1tnupK/eeqZ+Bwu49QC6eGCBWFf4rrwtSP/2+nARecNWqRSNGBzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IcNGCFiG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31718C4CEF4;
	Tue,  9 Sep 2025 10:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757412236;
	bh=MX1yEKtU1XlkDkySNWFMl83sKLvqqiq1wh9vWRpHFI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IcNGCFiGtCBdlK6h3ILvTV3+IPmzjlaTRMi9z9G1FxFYljC0M7EBZ5EmsWrmiGzp/
	 gVMFc2QKLoySwHA70lazg0F30+jLHbFTn+WcYnAEF9eG2ETDjGzxLIjS4K6rw2c9mz
	 2D3bGFHNjV1s57QvgcFtygPVer631Myaiuo7jQkZ3/6LxtdFWK+YrQcV/NHjIWy38H
	 Dp4jp2uruQtJSsxQNOLAGj3TjDCw6/AdL+t68/59DknoP7AhnKnTIGNIa98YDReGXU
	 o3BvpcNq6EerKPwmuQIloDBc5Nh8JnQIYXuBq1tBpg1hwwu+9AGk7lXlbeIP0LH4Ed
	 BOh4I1W6SjGvA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1uvvCc-000000001ZX-0dx4;
	Tue, 09 Sep 2025 12:03:54 +0200
Date: Tue, 9 Sep 2025 12:03:54 +0200
From: Johan Hovold <johan@kernel.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jia-Wei Chang <jia-wei.chang@mediatek.com>,
	Rex-BC Chen <rex-bc.chen@mediatek.com>
Subject: Re: [PATCH] cpufreq: mediatek: fix device leak on probe failure
Message-ID: <aL_7ituSjf5a0p_U@hovoldconsulting.com>
References: <20250909073819.25295-1-johan@kernel.org>
 <CAGXv+5EcnLJHG_50mYb2YB0_q1XOztF84c9tAJJfKZxSCWuUCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXv+5EcnLJHG_50mYb2YB0_q1XOztF84c9tAJJfKZxSCWuUCQ@mail.gmail.com>

On Tue, Sep 09, 2025 at 05:57:45PM +0800, Chen-Yu Tsai wrote:
> On Tue, Sep 9, 2025 at 5:40 PM Johan Hovold <johan@kernel.org> wrote:
> >
> > Make sure to drop the reference to the cci device taken by
> > of_find_device_by_node() on probe failure (e.g. probe deferral).

> > @@ -552,6 +554,10 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
> >  out_free_mux_clock:
> >         clk_put(info->cpu_clk);
> >
> > +out_put_cci_dev:
> > +       if (info->soc_data->ccifreq_supported)
> > +               put_device(info->cci_dev);
> 
> put_device() has a check for NULL, so the if isn't really needed.

I know, but this follows the pattern currently used by the driver (e.g.
for regulator_put()) and avoids relying on the caller having cleared the
info struct.

> Either way,
> 
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

Thanks for reviewing.

Johan

