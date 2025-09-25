Return-Path: <linux-pm+bounces-35364-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD92B9FE03
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 16:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA5A84E12D8
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 14:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CD228C009;
	Thu, 25 Sep 2025 14:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="jEN2Ueeq"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2A627A12D;
	Thu, 25 Sep 2025 14:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758809144; cv=pass; b=gLBriCYyyCzziiV2m1tZwNJN+BzcqYf935L/+PaMzqDf7loDi3iS6m3ZiskL9MzIi3keEWJxJzFBFndoam/MyePKK9J96BdEARLPNeU3hMJMH6ra41mU+FxHtkcTykae8CRtJTQhBaMva6+5tVIagyhxjZOCSm6xSg9t2m1exwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758809144; c=relaxed/simple;
	bh=hTVILfN3Sn10gPcXrUEeaPunkq3YbuHplVwnyMjR6qU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tBipAHRUxqiX/9cSfrjn4QFCm+gi7uHAHlwQE0E6ITN6yU1LvMQbS0dTPMdVMI+ibBxR52oieZMYbIzJRJ1c9cHKjGX2A63oCUQYXo1qrCAy/nFkS+STejTqBfbxv6aSsDOnIQgrqXD55UfC98DcS5Lm5kgamRgANTQ70LgOX3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=jEN2Ueeq; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1758809109; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cQh9vCGaK7a5DYd7rza61JtUGEP0Vz18KvzIfciBZKzG7jXvEMAD3kDwZFw2F5BDouwKe689Bh/3vNB5tAOdJlDlY4j7kOda4ZAxDhcWIUgpOPd1S0CzZ14RnE5zeR1R+VlFouKW/hEIJ/efZXKXoTJV7CqVsZ2ukJiu/DmKZ38=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758809109; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=OvzRWlr1AsAppW+7NbJb7lHmXfQyzadLNFuD+HINmpE=; 
	b=UZ/VsNtpBrPjPmJ1vrfNmiu/+3MDkNII5l1JivYKK84zCKKOhWw+RVG1FbWXO1fdRAwh0LwLfKKy1yUI3U3uuq43dv84BC+6RDaURBDbrvt3dw1bOD/fRTjZuWucvmGQ9anhWBARMJef8dtvZk89F44coSgM3I5HXluDBTXVPQI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758809109;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=OvzRWlr1AsAppW+7NbJb7lHmXfQyzadLNFuD+HINmpE=;
	b=jEN2Ueeq3h2ncv9IpdvT6N+pBrPDythheciswAlgARWVQBrUiSGuf6Ms9FtpVs+b
	rZd9U4lz0/vR19E1wqaDeX29hAehM/hu9xbvSuROcq0laF3jqv7a+D+KK4QrFzD8n5r
	qRx9UVBEv3VRY01OlG/2GxUdW0wIUHtNtl0kpF2A=
Received: by mx.zohomail.com with SMTPS id 1758809108075771.102720899719;
	Thu, 25 Sep 2025 07:05:08 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Jassi Brar <jassisinghbrar@gmail.com>, Chia-I Wu <olvaffe@gmail.com>,
 Chen-Yu Tsai <wenst@chromium.org>, Steven Price <steven.price@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, kernel@collabora.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-hardening@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 8/8] pmdomain: mediatek: Add support for MFlexGraphics
Date: Thu, 25 Sep 2025 16:04:59 +0200
Message-ID: <2015216.PYKUYFuaPT@workhorse>
In-Reply-To:
 <CAPDyKFpLNJRRxWPm2Eye+Fs8go-LNwWGzPUPPKmNVJkyK5N3Dw@mail.gmail.com>
References:
 <20250923-mt8196-gpufreq-v4-0-6cd63ade73d6@collabora.com>
 <20250923-mt8196-gpufreq-v4-8-6cd63ade73d6@collabora.com>
 <CAPDyKFpLNJRRxWPm2Eye+Fs8go-LNwWGzPUPPKmNVJkyK5N3Dw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Tuesday, 23 September 2025 16:24:13 Central European Summer Time Ulf Hansson wrote:
> On Tue, 23 Sept 2025 at 13:41, Nicolas Frattaroli
> <nicolas.frattaroli@collabora.com> wrote:
> >
> > Various MediaTek SoCs use GPU integration silicon named "MFlexGraphics"
> > by MediaTek. On the MT8196 and MT6991 SoCs, interacting with this
> > integration silicon is required to power on the GPU.
> >
> > This glue silicon is in the form of an embedded microcontroller running
> > special-purpose firmware, which autonomously adjusts clocks and
> > regulators.
> >
> > Implement a driver, modelled as a pmdomain driver with a
> > set_performance_state operation, to support these SoCs.
> >
> > The driver also exposes the actual achieved clock rate, as read back
> > from the MCU, as common clock framework clocks, by acting as a clock
> > provider as well.
> >
> > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > ---
> >  drivers/pmdomain/mediatek/Kconfig            |  16 +
> >  drivers/pmdomain/mediatek/Makefile           |   1 +
> >  drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c | 928 +++++++++++++++++++++++++++
> >  3 files changed, 945 insertions(+)
> 
> [...]
> 
> > +
> > +static int mtk_mfg_set_performance(struct generic_pm_domain *pd,
> > +                                  unsigned int state)
> > +{
> > +       struct mtk_mfg *mfg = mtk_mfg_from_genpd(pd);
> > +
> > +       /*
> > +        * Occasionally, we're asked to set OPPs when we're off. This will fail,
> > +        * so don't do it at all. We do foo != GENPD_STATE_ON instead of !foo
> > +        * as to not depend on the actual value of the enum.
> > +        */
> > +       if (mfg->pd.status != GENPD_STATE_ON)
> > +               return 0;
> 
> Returning 0 here, means that we may end up never restoring the
> performance state for a device and its genpd, when the device is
> getting runtime resumed. In genpd_runtime_resume() we are calling
> genpd_restore_performance_state() before calling genpd_power_on().
> This is deliberate, see commit ae8ac19655e0.
> 
> That said, I think we need to manage the restore in the ->power_on()
> callback. In principle, it means we should call
> mtk_mfg_set_oppidx(mfg, genpd->performance_state) from there.
> 

Thanks for pointing this out, yeah setting the oppidx in power_on
does look like the right choice.

> > +
> > +       return mtk_mfg_set_oppidx(mfg, state);
> > +}
> > +
> > +static int mtk_mfg_power_on(struct generic_pm_domain *pd)
> > +{
> > +       struct mtk_mfg *mfg = mtk_mfg_from_genpd(pd);
> > +       int ret;
> > +
> > +       ret = regulator_bulk_enable(mfg->variant->num_regulators,
> > +                                   mfg->gpu_regs);
> > +       if (ret)
> > +               return ret;
> > +
> > +       ret = clk_prepare_enable(mfg->clk_eb);
> > +       if (ret)
> > +               goto err_disable_regulators;
> > +
> > +       ret = clk_bulk_prepare_enable(mfg->variant->num_clks, mfg->gpu_clks);
> > +       if (ret)
> > +               goto err_disable_eb_clk;
> > +
> > +       ret = mtk_mfg_eb_on(mfg);
> > +       if (ret)
> > +               goto err_disable_clks;
> > +
> > +       ret = mtk_mfg_power_control(mfg, true);
> > +       if (ret)
> > +               goto err_eb_off;
> > +
> > +       return 0;
> > +
> > +err_eb_off:
> > +       mtk_mfg_eb_off(mfg);
> > +err_disable_clks:
> > +       clk_bulk_disable_unprepare(mfg->variant->num_clks, mfg->gpu_clks);
> > +err_disable_eb_clk:
> > +       clk_disable_unprepare(mfg->clk_eb);
> > +err_disable_regulators:
> > +       regulator_bulk_disable(mfg->variant->num_regulators, mfg->gpu_regs);
> > +
> > +       return ret;
> > +}
> 
> [...]
> 
> Note, I intend to have a bit closer look at this soon, but I just
> observed the issue I pointed out above from my first quick look.

I actually have a question about a mystery that has been puzzling
me as I work on v5: when unloading the driver that uses the PD
(panthor) and my driver using `modprobe -r panthor mtk_mfg_pmdomain`,
I see that sometimes detach_dev is called with the pd status
reportedly being off, but according to my own power-on/power-off
counting I hacked in, it actually being on. It then proceeds to
call my remove, which results in three splats from the regulator
subsystem as the regulators weren't balanced with disables before
they were freed, which isn't the main problem but more a symptom
of the bigger problem that power_off and power_on calls don't
appear to be balanced by the pmdomain subsystem when a driver is
removed under certain circumstances.

Did I run into a core pmdomain bug here, or do I have to balance
the power_on/off myself somehow in detach_dev? If the latter, I'm
struggling to figure out how I can determine that the PD is still
on without doing my own bookkeeping, as pmdomain core seems to clear
these fields before my detach_dev gets to them :(

> 
> Kind regards
> Uffe
> 

Kind regards,
Nicolas Frattaroli



