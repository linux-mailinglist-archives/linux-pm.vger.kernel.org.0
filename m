Return-Path: <linux-pm+bounces-20544-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F54A13ADD
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 14:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57D6B160EBD
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 13:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E29822A7EB;
	Thu, 16 Jan 2025 13:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="doa6shUH"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEC822A7E5;
	Thu, 16 Jan 2025 13:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737034033; cv=none; b=c1jVuBBMvFniOLTcHsc4BmLTSXOCaE3PtpI+TEiUrCo/9OpzXtI5e+cX+GaeDnGc0tL1zPrScL/fu3KsCSiXTayY6LCXyu+6mWvb65e0gyBff1DGtXpK+g+64pRCafFRFt0i5jsUASghRfKShpXALd1k1rtk0h6ollkajD2F+z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737034033; c=relaxed/simple;
	bh=CO6WZPYdeZC8+Bx0ho5URccoE4ccASaq/bcedaSPINk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XeEQqM1YAqVAiIV1TfW8aMBdTzOMvi19sKJvtc/e4ncd1jJGEgKTdRdfJCltvepRnx2jXJMxYFQZVXFO2OJxBgOhXRzZQAD3oDdOGnV4rfHBv5DUz471A3YsHDSEnhJHwnrcusAPO2oYCMTzLoe8pDU1Zm0MmFLmKCI2LKBKaC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=doa6shUH; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1737034029;
	bh=CO6WZPYdeZC8+Bx0ho5URccoE4ccASaq/bcedaSPINk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=doa6shUHNfIEHjEAqGxGeNydvwDIsM1DBvzqdtwPGDCSR34OXuitDO+D0BSeQ2Rqt
	 W9MVXML8f3pjH7YJCaXHs65OgRAOlA3Xwu+tEKOGWrZIMb/qLbCbN0PfaNsCSIhTKS
	 OfyB55kluekPg1CI9bdfN6AB9eqsWfqdgMHRecFtShYQDb5W+mH7D3b8d1zoHBg/Vy
	 eN/OWG7kPrF+ditoeDRg4zC5K+JaiSZljxdOotELYC/wvbAoG1DQci3XSrOxopF67G
	 e0UT5+nAUv00teiH5IQJS4oUGyZWqkqCtPpgYWzqTAGQScsfZfv5RqbHEt8+JQAVFX
	 +3/Xu0o3qQ7sA==
Received: from notapiano (unknown [IPv6:2804:14c:1a9:53ee::1001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2CAE817E0E9E;
	Thu, 16 Jan 2025 14:27:02 +0100 (CET)
Date: Thu, 16 Jan 2025 10:27:00 -0300
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alexandre Mergnat <amergnat@baylibre.com>,
	Balsam CHIHI <bchihi@baylibre.com>, kernel@collabora.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Hsin-Te Yuan <yuanhsinte@chromium.org>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Bernhard =?utf-8?Q?Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH RESEND v2 2/5] thermal/drivers/mediatek/lvts: Disable
 Stage 3 thermal threshold
Message-ID: <a61835ca-a13d-4547-b3a2-3563688bff25@notapiano>
References: <20250113-mt8192-lvts-filtered-suspend-fix-v2-0-07a25200c7c6@collabora.com>
 <20250113-mt8192-lvts-filtered-suspend-fix-v2-2-07a25200c7c6@collabora.com>
 <53f3803f-c6ef-40db-9794-6c90b37659c1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <53f3803f-c6ef-40db-9794-6c90b37659c1@linaro.org>

On Tue, Jan 14, 2025 at 12:54:43PM +0100, Daniel Lezcano wrote:
> On 13/01/2025 14:27, Nícolas F. R. A. Prado wrote:
> > The Stage 3 thermal threshold is currently configured during
> > the controller initialization to 105 Celsius. From the kernel
> > perspective, this configuration is harmful because:
> > * The stage 3 interrupt that gets triggered when the threshold is
> >    crossed is not handled in any way by the IRQ handler, it just gets
> >    cleared. Besides, the temperature used for stage 3 comes from the
> >    sensors, and the critical thermal trip points described in the
> >    Devicetree will already cause a shutdown when crossed (at a lower
> >    temperature, of 100 Celsius, for all SoCs currently using this
> >    driver).
> > * The only effect of crossing the stage 3 threshold that has been
> >    observed is that it causes the machine to no longer be able to enter
> >    suspend. Even if that was a result of a momentary glitch in the
> >    temperature reading of a sensor (as has been observed on the
> >    MT8192-based Chromebooks).
> > 
> > For those reasons, disable the Stage 3 thermal threshold configuration.
> 
> Does this stage 3 not designed to reset the system ? So the interrupt line
> should be attached to the reset line ? (just asking)

Yes, my guess is that the intention of stage 3 is to cause a system reset,
however it clearly does not cause a system reset, so it is not directly
connected to the reset line in any way. Instead it is up to the kernel to
receive the interrupt and deal with it. But then, since there are lower thermal
thresholds that already cause a system shutdown, it's useless to keep this
around - it only causes suspend/resume misbehaviors in case there are spurious
readings.

Thanks,
Nícolas

