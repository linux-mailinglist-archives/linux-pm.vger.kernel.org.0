Return-Path: <linux-pm+bounces-18424-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FB09E1591
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 09:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8664281074
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 08:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35FC1C6F56;
	Tue,  3 Dec 2024 08:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckxK2dTU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA641BD9EB;
	Tue,  3 Dec 2024 08:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733214307; cv=none; b=U1GDNIJM4l4a9a62akNAyzt8vAjRU0wkTnZY+ATfz8fX5r6D54uNNwE5YlGSHE4vFBGMd9sqJH4exxlfBUWg6XM2b03gBRDXcXo1FUpOPzI1G9hSnP0fXgr9J4ctT3PAmWNvXloZ2UY3Ui5VM4tFj/bLWFoJ6iok2yQz+4U5Ug0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733214307; c=relaxed/simple;
	bh=BTa+wgiNyFIm2OTLgqY7mmgwN8DZyO7pNyzVFgh+TMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gnufi+d/LAcR06WHRwA08R+abQCjqjxoWtL3lv/EhCb8L+hGpvu/6Bd1tl3PNbURxNPSX01kvoFVi14UYcsKSVoQpaNA1f1nb8SVWtNNznEGJvHWtxWbrsAcztXzbjCJhRuuJ5lbwrqggVOATYVasUPZj5d6Br8YhUyygbJ9ZFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckxK2dTU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C84C4CECF;
	Tue,  3 Dec 2024 08:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733214307;
	bh=BTa+wgiNyFIm2OTLgqY7mmgwN8DZyO7pNyzVFgh+TMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ckxK2dTUgLzQ2DQRimHhuFTZClvmg9v2v6qZS5ZW0HEZnEHX0Z9eN6C5SXg8A9DTz
	 RwVg/W0dCHB+K9d5zC0zxTHlRp+jrc3LBuUREF8+/+7ZCaR0IqJMITxwZKu9AxPUBq
	 juo6vTmP4pnjcH40huRrykLqxdvwUNlm0JrL0O0s7+dXX1aCrImZzWUCC7HwXFMvH+
	 l8cqYI570GOD5Unw6DhAgn4RuuRPddA7Z5b7Yd9L+CEirC3AxjpL/hJ906pLS2HJGv
	 uoGxRgeknk0X+D0bw6c5aoFF7bFixA/20M4dG/5SzmujY6Qqw8uwUPdgZuubr+T4yD
	 gWv8VrbCKXxAA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tIODN-0000000082S-3VtQ;
	Tue, 03 Dec 2024 09:25:02 +0100
Date: Tue, 3 Dec 2024 09:25:01 +0100
From: Johan Hovold <johan@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev, Aishwarya TCV <aishwarya.tcv@arm.com>,
	Chuan Liu <chuan.liu@amlogic.com>,
	Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] Revert "clk: Fix invalid execution of clk_set_rate"
Message-ID: <Z07AXbQvvZwI8Ki6@hovoldconsulting.com>
References: <20241202100621.29209-1-johan+linaro@kernel.org>
 <3fd004add188460bf2bdd1a718387c7f.sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fd004add188460bf2bdd1a718387c7f.sboyd@kernel.org>

[ +CC: Viresh and Sudeep ]

On Mon, Dec 02, 2024 at 05:20:06PM -0800, Stephen Boyd wrote:
> Quoting Johan Hovold (2024-12-02 02:06:21)
> > This reverts commit 25f1c96a0e841013647d788d4598e364e5c2ebb7.
> > 
> > The offending commit results in errors like
> > 
> >         cpu cpu0: _opp_config_clk_single: failed to set clock rate: -22
> > 
> > spamming the logs on the Lenovo ThinkPad X13s and other Qualcomm
> > machines when cpufreq tries to update the CPUFreq HW Engine clocks.
> > 
> > As mentioned in commit 4370232c727b ("cpufreq: qcom-hw: Add CPU clock
> > provider support"):
> > 
> >         [T]he frequency supplied by the driver is the actual frequency
> >         that comes out of the EPSS/OSM block after the DCVS operation.
> >         This frequency is not same as what the CPUFreq framework has set
> >         but it is the one that gets supplied to the CPUs after
> >         throttling by LMh.
> > 
> > which seems to suggest that the driver relies on the previous behaviour
> > of clk_set_rate().
> 
> I don't understand why a clk provider is needed there. Is anyone looking
> into the real problem?

I mentioned this to Mani yesterday, but I'm not sure if he has had time
to look into it yet. And I forgot to CC Viresh who was involved in
implementing this. There is comment of his in the thread where this
feature was added:

	Most likely no one will ever do clk_set_rate() on this new
	clock, which is fine, though OPP core will likely do
	clk_get_rate() here.

which may suggest that some underlying assumption has changed. [1]

There are some more details in that thread that should explain why
things were implemented the way they were:

	https://lore.kernel.org/linux-arm-msm/20221117053145.10409-1-manivannan.sadhasivam@linaro.org/

> > Since this affects many Qualcomm machines, let's revert for now.
> > 
> > Fixes: 25f1c96a0e84 ("clk: Fix invalid execution of clk_set_rate")
> > Reported-by: Aishwarya TCV <aishwarya.tcv@arm.com>
> > Link: https://lore.kernel.org/all/e2d83e57-ad07-411b-99f6-a4fc3c4534fa@arm.com/
> > Cc: Chuan Liu <chuan.liu@amlogic.com>
> > Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> 
> Applied to clk-fixes

Thanks.

Johan

[1] https://lore.kernel.org/linux-arm-msm/20221118055730.yrzpuih3zfko5c2q@vireshk-i7/

