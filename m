Return-Path: <linux-pm+bounces-10703-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D07E2928B57
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 17:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DA7D1C23758
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 15:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B9814AD30;
	Fri,  5 Jul 2024 15:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BAxMFXhz"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181A914AA0;
	Fri,  5 Jul 2024 15:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720192396; cv=none; b=cTyK/4mtM1svViThDO1CGwUKje/+gKNf1jnIl1n+CaimLTlbeAxpXq9EobBzULLHSps01YHxc3bdiW1L86Wz40aj5iQExN+lWtmJ5eAVRvTLeb+eTWkJ+lXBdy7bO9BIPp58Bebn5EsWoansYF3LykqwIOMEDY6w5prYVkaFcI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720192396; c=relaxed/simple;
	bh=oUmZVVTb1bwWD8rbWU2EmG9u4kNanX6k86LKJuHxGyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hw2k5uaWxTNBKn77bHptV2CcmMFXtW6OTRRr07ZrvufEW8KW738IHyrGE1nf0p+AtVrJdttSC/sSmR1E8a/uxdwO0Qby/I6okQcf2uf5pQ8juMxNo0b0gA1FTmSfbm3PyjW2Gytl6QXa17JqNzri5egiyIs1J8Yfol8GvGs28lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BAxMFXhz; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720192393;
	bh=oUmZVVTb1bwWD8rbWU2EmG9u4kNanX6k86LKJuHxGyk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BAxMFXhz5MxIpKg6E+aFOrU+Mj+VvauyZQMPEStRfvtovKB08cMy5rpEXNnqJ2uGh
	 fmojMWaeJ2pVnndolKNh64rKPLp49HkhxbHF9gQfMPLJ972q1e0tw9ysXl2X5acn3c
	 lUEPB6UaQY4AXahLbg8NrdqfZf4hG4efWrkp6vzsljjhqml9oyBEsD1vNHhp8/dybF
	 bcXfuJBS2fRvJKn15XIl0Y9w1khN+LeUVJczr0AlDJgovMTM58Eq+W5JFP6EvVXwLY
	 FeIH0b0w/uYYww9XHfdap09erVNzhVYh5Qz78r6N34RGidkekFfODpfkVchmqRaIB/
	 YGgQgsttnlJYw==
Received: from notapiano (tango.collaboradmins.com [167.235.144.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 66AAE37800C9;
	Fri,  5 Jul 2024 15:13:11 +0000 (UTC)
Date: Fri, 5 Jul 2024 11:13:09 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, kernel@collabora.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] cpufreq: mediatek: Use dev_err_probe in every error path
 in probe
Message-ID: <8602bf12-1b8d-4249-8814-52ecaa29d0ec@notapiano>
References: <20240628-mtk-cpufreq-dvfs-fail-init-err-v1-1-19c55db23011@collabora.com>
 <20240702055703.obendyy2ykbbutrz@vireshk-i7>
 <aa6e93bd-aba2-4e4d-bce9-04e818ac25ed@collabora.com>
 <20240702084307.wwvl5dchxa4frif3@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240702084307.wwvl5dchxa4frif3@vireshk-i7>

On Tue, Jul 02, 2024 at 02:13:07PM +0530, Viresh Kumar wrote:
> On 02-07-24, 10:26, AngeloGioacchino Del Regno wrote:
> > Il 02/07/24 07:57, Viresh Kumar ha scritto:
> > > On 28-06-24, 15:48, Nícolas F. R. A. Prado wrote:
> > > > diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> > > > @@ -629,11 +630,9 @@ static int mtk_cpufreq_probe(struct platform_device *pdev)
> > > >   	int cpu, ret;
> > > >   	data = dev_get_platdata(&pdev->dev);
> > > > -	if (!data) {
> > > > -		dev_err(&pdev->dev,
> > > > -			"failed to get mtk cpufreq platform data\n");
> > > > -		return -ENODEV;
> > > > -	}
> > > > +	if (!data)
> > > > +		return dev_err_probe(&pdev->dev, -ENODEV,
> > > 
> > > What's the point of calling dev_err_probe() when we know for sure that
> > > the error isn't EPROBE_DEFER ?
> > > 
> > 
> > Logging consistency, that's all; the alternative would be to rewrite the dev_err()
> > messages to be consistent with what dev_err_probe() says, so that'd be
> > dev_err("error %pe: (message)");
> 
> That would be better I guess. There is no point adding inefficient
> code.

Well, that would add duplication of the error format string, and make the error
message (the actual information here) less clear in the source code. Also,
dev_err doesn't return the error so it needs to be written in two lines, instead
of a single one.

Consider it's not just about consistency of the log messages, but consistency of
the source code as well: with so many drivers transitioning to the use of
`return dev_err_probe(...);` patterns, sticking to the pattern means it's
immediately clear what the code does. And it is a desirable pattern because it
removes all boilerplate and leaves just the real information (the error code and
the message).

Besides, the inneficient code amounts to an extra va_list usage and an int
comparison. That would only run once during boot and only in the error path...
I'm confident in saying this won't amount to any real performance gain. So the
usage of dev_err_probe() everywhere for log and source code standardization is
well worth it.

Thanks,
Nícolas

