Return-Path: <linux-pm+bounces-21079-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A00A2182F
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jan 2025 08:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E25C93A3C41
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jan 2025 07:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324DE198A34;
	Wed, 29 Jan 2025 07:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VABuxuU2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022D61799F;
	Wed, 29 Jan 2025 07:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738135899; cv=none; b=KdTjO9CcRyhK7L0dDX073zNu4terSODcAbgu/O89/RzNoBD3Q0yeegbUV8FkHSznZZClBKQSO+lz97y46DnnSeHWPHO12auze9EaIrrYiFswtsfPrQmv2A94sFhVluncorFcg5aITGGg+nruTaMsJD81J/EyR6HaLvNtT2OfHTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738135899; c=relaxed/simple;
	bh=vaLfSjS74gqgUZVZqpZI1Spi9TQQGJMrQAS15v1471U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dCRyeuCgnCl4G2M5/ikGHXeGHqz1uv61FQ0LPtBlyxIy5QuCkREtu+EMSkX3OcwF9GByvR64qG36Zei/u9O+44axqfVJtpoggXlQjd3ToQCvEmez/tVD/pTxkelQs2dp/K6yfDykNQ19nv9ilxoTzoAR51LdCskWp8V3R/Ujhq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VABuxuU2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87D90C4CEE0;
	Wed, 29 Jan 2025 07:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738135898;
	bh=vaLfSjS74gqgUZVZqpZI1Spi9TQQGJMrQAS15v1471U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VABuxuU27Ks/hWe7YYp/ddzQeaZDLN3UPkrl/THpXnuMyctbE5sHTHSnp3MeIMq7c
	 wwOZZQraoGbvTOTTEq+WvLMZlHXPrssFW575y1bCBArS2cx+jq++4Z9ON4RVa8sQ9Y
	 8+UPAd4kkoK5o1NVg1YB8j59NZk41qHAgg53gWFMc3VkWpGBmh8GZBvaroBFiWCs2m
	 uhYX127ozm/hK4TmC4DMrO9k4LqWhZd3FE6yN0jDSEh0rRqU/vEy906s0AL2mlgUin
	 zSA0AxA3ysKTJI86bJ2rvryAKDYcULXhPPVWxJsCTJ9CH1MSReCjuLntGyQ/6pLSsa
	 +zs3MzRpdeouA==
Date: Wed, 29 Jan 2025 08:31:35 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com, guoren@kernel.org, 
	wefu@redhat.com, jassisinghbrar@gmail.com, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, frank.binns@imgtec.com, 
	matt.coster@imgtec.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, ulf.hansson@linaro.org, 
	jszhang@kernel.org, p.zabel@pengutronix.de, m.szyprowski@samsung.com, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 05/18] dt-bindings: power: Add TH1520 SoC power domains
Message-ID: <20250129-daring-tan-hawk-ffdc1b@krzk-bin>
References: <20250128194816.2185326-1-m.wilczynski@samsung.com>
 <CGME20250128194831eucas1p258522118b2f21abd8f6d4cdde277fe07@eucas1p2.samsung.com>
 <20250128194816.2185326-6-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250128194816.2185326-6-m.wilczynski@samsung.com>

On Tue, Jan 28, 2025 at 08:48:03PM +0100, Michal Wilczynski wrote:
> Add power domain ID's for the TH1520 SoC power domains.
> 
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  MAINTAINERS                                   |  1 +
>  .../dt-bindings/power/thead,th1520-power.h    | 19 +++++++++++++++++++
>  2 files changed, 20 insertions(+)
>  create mode 100644 include/dt-bindings/power/thead,th1520-power.h

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


