Return-Path: <linux-pm+bounces-38761-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C05EEC8C9AE
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 02:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E23B3B48EB
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 01:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5ED2239594;
	Thu, 27 Nov 2025 01:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EzYiOJa3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B0A224B06;
	Thu, 27 Nov 2025 01:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764208508; cv=none; b=cItkA1b+8qhf+BEesLEAUNw8kSk4E3IDIEeQQIZX9aZ6XG9W1Vhzn4TJ+ozGnh1VAq/0epMpbz6YAV1y6M8ABQis91mp8hLHWsIBhNirdDDuFrGWbSI3PvgIfuHpfOZb4pTe0zpIn2mnqcilzIuhp7U1C+ULHvAZlAXq3+7ITQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764208508; c=relaxed/simple;
	bh=/NqG17rwpRoq7YYKDty/OdxHUk6Tf8IpKhsClBMsOkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xwt6xpAI9uRCxqsUe7Sp2tmNxSwadWcTyDr8BXKxwpOx+ufLqgBNgSWlCbAwMwSOxwSE/Kzqseq9WG3LJoPAaD/rZIkShjCuu58fJBLWbrWGNj3lKyZS7CVpApZS7W+9r8Ksda/jo6a53EBzBzH/WztbgryNnTrZi5SxUPVOREo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EzYiOJa3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E68CBC4CEF7;
	Thu, 27 Nov 2025 01:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764208504;
	bh=/NqG17rwpRoq7YYKDty/OdxHUk6Tf8IpKhsClBMsOkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EzYiOJa3YR9H6eZ8HCr1KToCFxIEO+ew/BcLqhj57zGekCM/ZK/Pr/eiTyQaXGvgv
	 T5AhkQWLJvlTEBoFbvcJIDxxsmF6ndlEpDBQa/hmxDBJwgIigrTpQ6ZUOYPPt18jo7
	 Kvd50M/qhN6chJCvZYY53aFrtDgpreG0isN+lQBIPAgnmshLUwdbUPoYSQ1au2st5M
	 XXwsiF2q1J6/YoAI/TVrenCyJT3o9zykMk5Ki9Xk4l7s5zZMQDnA7G66aQgLnvVp/I
	 1Xu19QcNEw7OTPqMlsFElD0TE/oyVjCXOQkJBWKAWcEvy0dGi9DPjnF/cVS+mfBIuW
	 9b8HslW/nh5yQ==
Date: Wed, 26 Nov 2025 19:55:02 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Saravana Kannan <saravanak@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Yangtao Li <tiny.windzz@gmail.com>, Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v2 00/11] of: Add wrappers to match root node with OF
 device ID tables
Message-ID: <20251127015502.GA3141507-robh@kernel.org>
References: <20251112-b4-of-match-matchine-data-v2-0-d46b72003fd6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112-b4-of-match-matchine-data-v2-0-d46b72003fd6@linaro.org>

On Wed, Nov 12, 2025 at 11:28:45AM +0100, Krzysztof Kozlowski wrote:
> Changes in v2:
> - Drop cpufreq/ti change: not correct.
> - Drop soc/qcom/qcom_pd_mapper.c - objections from Dmitry and I think
>   better to drop the patch in such case.
> - I did not implement feedback for first patch to make the
>   of_machine_compatible_match() matching machines in arbitrary nodes,
>   because there is no such use case possible and no arguments were provided.
>   I also did not use cleanup.h in first patch because existing code
>   of_device_get_match_data() does not use it and I prefer uniformity.
> 
> - Add Ack/Rb tags.
> - Link to v1: https://patch.msgid.link/20251106-b4-of-match-matchine-data-v1-0-d780ea1780c2@linaro.org
> 
> Dependency/merging
> ==================
> All patches depend on the first patch, thus everything could go via
> Rob's tree with people's acks.
> 
> Description
> ===========
> Several drivers duplicate same code for getting reference to the root
> node, matching it against 'struct of_device_id' table and getting out
> the match data from the table entry.
> 
> There is a of_machine_compatible_match() wrapper but it takes array of
> strings, which is not suitable for many drivers since they want the
> driver data associated with each compatible.
> 
> Add two wrappers, similar to existing of_device_get_match_data():
> 1. of_machine_device_match() doing only matching against 'struct
>    of_device_id' and returning bool.
> 2. of_machine_get_match_data() doing the matching and returning
>    associated driver data for found compatible.
> 
> Best regards,
> Krzysztof
> 
> ---
> Krzysztof Kozlowski (11):
>       of: Add wrappers to match root node with OF device ID tables
>       cpufreq: dt-platdev: Simplify with of_machine_get_match_data()
>       cpufreq: mediatek: Simplify with of_machine_get_match_data()
>       cpufreq: sun50i: Simplify with of_machine_device_match()
>       cpuidle: big_little: Simplify with of_machine_device_match()
>       firmware: qcom: scm: Simplify with of_machine_device_match()
>       irqchip/atmel-aic: Simplify with of_machine_get_match_data()
>       platform: surface: Simplify with of_machine_get_match_data()
>       powercap: dtpm: Simplify with of_machine_get_match_data()
>       soc: qcom: ubwc: Simplify with of_machine_get_match_data()
>       soc: tegra: Simplify with of_machine_device_match()
> 
>  drivers/cpufreq/cpufreq-dt-platdev.c               | 15 ++-----
>  drivers/cpufreq/mediatek-cpufreq.c                 | 12 +-----
>  drivers/cpufreq/sun50i-cpufreq-nvmem.c             | 11 +----
>  drivers/cpuidle/cpuidle-big_little.c               | 11 +----
>  drivers/firmware/qcom/qcom_scm.c                   | 17 +-------
>  drivers/irqchip/irq-atmel-aic-common.c             | 15 ++-----
>  drivers/of/base.c                                  | 47 ++++++++++++++++++++++
>  .../platform/surface/surface_aggregator_registry.c | 13 +-----
>  drivers/powercap/dtpm.c                            | 16 +-------
>  drivers/soc/qcom/ubwc_config.c                     | 14 ++-----
>  drivers/soc/tegra/common.c                         | 12 +-----
>  include/linux/of.h                                 | 13 ++++++
>  12 files changed, 79 insertions(+), 117 deletions(-)

Applied, thanks.

Rob

