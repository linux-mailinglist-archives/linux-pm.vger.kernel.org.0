Return-Path: <linux-pm+bounces-30584-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E5EB002CF
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 15:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8309179660
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 13:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574B9269D11;
	Thu, 10 Jul 2025 13:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="hAj0Hq83";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OZmYiP5h"
X-Original-To: linux-pm@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4A72580D1;
	Thu, 10 Jul 2025 13:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752152509; cv=none; b=cBmMLQr36aSlZAHhMxF2V9wj7GVRcXyvD9GyP0C0d0f/Y6e3bI68rMC1d8G7hUCmyCAMKMg0xEykt7Jrw+Ah/oENq/OlxJCGBxj9T09M+y/91GorNEgyfJRk7DWfPo1N63eK9xqUwzhHK/sgg/paU2HVlsik3KhLMhmY2vHN8YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752152509; c=relaxed/simple;
	bh=jRfhyJ6ChsBrtwgp46OfsJwt3c8CPPaHbdv55k1BHU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IcYqLpyRm3SKejIVVpnOmUGbkMxrfBxgWdAtqPCkMmjnHHmftbllzqsHn4mXNmuPiC+TFGv6n1FJhHvTKOVtPis3RhjUxKTAIWYNekgntlD7QlQwlb44RO66j1V9qh7uqiVdJd7b/uoDHkd+xZlPZAA8xL/MkUn/64faaUaG6oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=hAj0Hq83; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OZmYiP5h; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id E00A3EC0170;
	Thu, 10 Jul 2025 09:01:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 10 Jul 2025 09:01:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752152506;
	 x=1752238906; bh=9+GJRENuyK0syYaCetyCXPpI2q0ocfPIfSHMIFaFdv8=; b=
	hAj0Hq83shUxizSooGTsWX+kR06KPwaYAJw1G9dN3G5NFRukQcQ4U+0uF+E2qRYw
	44pYS419LkNiCSZ9VQsAViE/mGZsOV6KcrqPAcsSjtMiRFMzVF4lDQCFnMtKS4yR
	SI5vnPQWJRz7PV572+4ZPEeuornCGlgBHwwmtmAxsgISg4pF5lMpZVQyhUVFI9O4
	WlgLoMmtaBUlba+ibYQ0dGaU6nPbV0C1fgRRdQUm5aG/6lzbDHtQr9jBtybSDU2c
	4f1rw5EOgt4j6mERlpaqOayld0EM93AgnS257EiY6aZjnezGPFmuECFy99l7NxAq
	ttHQfv/7hgkB8ArbqiD5lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752152506; x=
	1752238906; bh=9+GJRENuyK0syYaCetyCXPpI2q0ocfPIfSHMIFaFdv8=; b=O
	ZmYiP5ho1SQR3FyVeniaIU49FDCMLyHjLxjzpNu7Tza0G7GljMfc+RSHSEm8V6QU
	X/xhpclDfzi0HQN4dDnI/elrWmaSlM68lJbS5sl8Jroa8c6Fkae2/KmWHugA/ZH9
	6t0AuFeZa/5WQ5gtnrsx+8oLsTmJ+nTUAlDlk0QDO3MpuwT1lL1cZHQ8Lr4OQ5px
	NxwfM+UmOlq8/oFx+iYEKMbtLyJnbzEs5mRsHehmW3o97D6Owi/QQ7Ry6GkkgQQb
	u94A7KmfCgsNsXN3O7WGsO/O1UfbiNtM4F5abTJgNhqphJyve4A0hFPogfTvmlkK
	iM/JnZ4iqSF3MmaiZ3Udw==
X-ME-Sender: <xms:urlvaNdIvyZnzIf2AJlqN4uimNXQMlAsDA_3r7bMIaxNsmFIcvL0Dg>
    <xme:urlvaPABzDqcQR_F3BwJTPJS5vOhF289dRJmNwBVqOa-0NVjoHLtcMyWxM2iIWn5e
    eNZDf1hmQs50l60oMw>
X-ME-Received: <xmr:urlvaPnSJ47tr3_548yxkb5Hc0DJEL9rc13fQQdQTemPHJ1WwlGmqLZvKJBDI-0wX1Roho_OjD0a4TNnMpCT1RhSveWJTpOang>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegtdehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheppfhikhhlrghs
    ucfunpguvghrlhhunhguuceonhhikhhlrghsrdhsohguvghrlhhunhgusehrrghgnhgrth
    gvtghhrdhsvgeqnecuggftrfgrthhtvghrnhepveetgedtvddvhfdtkeeghfeffeehteeh
    keekgeefjeduieduueelgedtheekkeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepnhhikhhlrghsrdhsohguvghrlhhunhgusehrrghgnhgr
    thgvtghhrdhsvgdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepghgvvghrthdorhgvnhgvshgrshesghhlihguvghrrdgsvgdprhgtphhtthho
    pehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvg
    iitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehruhhirdiihhgrnhhgsehi
    nhhtvghlrdgtohhmpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomh
    dprhgtphhtthhopehlihhnuhigqdhrvghnvghsrghsqdhsohgtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:urlvaKfl5i1V5Dlg_Qj21kJ8uHmvo7ccyy8Idt21e9XJtH1FFHo5iw>
    <xmx:urlvaDTNABRqZs-ZvZNIScsfuqm22wMNQIKSRKd2CfLkHrjBuEdEMw>
    <xmx:urlvaBvVMBTVV1AyKNGyMRhUx2xCb1uT3ZznVVU-jH1c6t-IShOLug>
    <xmx:urlvaEccDsyLOdCHjNgv8w6eAtqrdoRAVJQqDjuWwNOohG2KvUyAZQ>
    <xmx:urlvaN9jgX01pWJBmRAUSha-Jd8TsTMmOCjA2d3pGJVyYMXSdUlhRIhT>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Jul 2025 09:01:45 -0400 (EDT)
Date: Thu, 10 Jul 2025 15:01:43 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] thermal: rcar_gen3: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Message-ID: <20250710130143.GD2234326@ragnatech.se>
References: <49d1fe8b8cc287825d6eafcbcd2a1eb64f1f2db0.1752087880.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <49d1fe8b8cc287825d6eafcbcd2a1eb64f1f2db0.1752087880.git.geert+renesas@glider.be>

Hi Geert,

Thanks for your patch.

On 2025-07-09 21:04:58 +0200, Geert Uytterhoeven wrote:
> Convert the Renesas R-Car Gen3 thermal driver from SIMPLE_DEV_PM_OPS()
> to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr().  This lets us drop the
> __maybe_unused annotation from its resume callback, and reduces kernel
> size in case CONFIG_PM or CONFIG_PM_SLEEP is disabled.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  drivers/thermal/renesas/rcar_gen3_thermal.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/renesas/rcar_gen3_thermal.c b/drivers/thermal/renesas/rcar_gen3_thermal.c
> index 24a702ee4c1fb83d..b54338bbc4c78a1d 100644
> --- a/drivers/thermal/renesas/rcar_gen3_thermal.c
> +++ b/drivers/thermal/renesas/rcar_gen3_thermal.c
> @@ -570,7 +570,7 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> -static int __maybe_unused rcar_gen3_thermal_resume(struct device *dev)
> +static int rcar_gen3_thermal_resume(struct device *dev)
>  {
>  	struct rcar_gen3_thermal_priv *priv = dev_get_drvdata(dev);
>  	unsigned int i;
> @@ -584,13 +584,13 @@ static int __maybe_unused rcar_gen3_thermal_resume(struct device *dev)
>  	return 0;
>  }
>  
> -static SIMPLE_DEV_PM_OPS(rcar_gen3_thermal_pm_ops, NULL,
> -			 rcar_gen3_thermal_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(rcar_gen3_thermal_pm_ops, NULL,
> +				rcar_gen3_thermal_resume);
>  
>  static struct platform_driver rcar_gen3_thermal_driver = {
>  	.driver	= {
>  		.name	= "rcar_gen3_thermal",
> -		.pm = &rcar_gen3_thermal_pm_ops,
> +		.pm = pm_sleep_ptr(&rcar_gen3_thermal_pm_ops),
>  		.of_match_table = rcar_gen3_thermal_dt_ids,
>  	},
>  	.probe		= rcar_gen3_thermal_probe,
> -- 
> 2.43.0
> 

-- 
Kind Regards,
Niklas Söderlund

