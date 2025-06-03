Return-Path: <linux-pm+bounces-28021-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 810BFACC7CA
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 15:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50D53164C0F
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 13:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B38D231826;
	Tue,  3 Jun 2025 13:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pK/iBtt2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DD8A937;
	Tue,  3 Jun 2025 13:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748957342; cv=none; b=jB01zEBSAs2SwMs7PHCnMG+bPAEcQYuge4oBoVy7SgsAcjqrpVkX7kFCdrArMiCd43+0104NQ+R7nl12i7P7SvyrwF7crXyWX5vF2dn6DaX8x0sUZZ1DC2fIk8copJJirU8n2ar2FyBdkHK8VD/GWB+gdHMRvFdnhaN3/XAoh30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748957342; c=relaxed/simple;
	bh=F0kJRudsurFWvAfw/NQZAGVoSklCQBdR6GXq+HvgSFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2UPHcVURP2srPOFDQssY/UtLGxkmrI+uXQHpaxnz0ok3mhlcCLfRxfhC7ChBnEmlhpY1jP5LGfQTarQq9uYss9XPyQXdwwCzO2tXOB7zQ/2ZeJe4/HSOa22y/eILIFTFjnoqeCLyDndLnQJTN3vSzQu+xJG5ngeGvJNheLnYss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pK/iBtt2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0E95C4CEED;
	Tue,  3 Jun 2025 13:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748957341;
	bh=F0kJRudsurFWvAfw/NQZAGVoSklCQBdR6GXq+HvgSFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pK/iBtt299lLbE8VT7t/nTvPQLQVpuxt5Mgy8NKyug+Kt5+dx9+NGP4u5u+xdIGw7
	 ErxkyqUEmTwVK8pfVCa230zvl0NCQzrf3gs4jun/ohCWBw8rFBIXlVwzYLwRcsS1Ic
	 CHh7aoQw4ekcNVsGJPzkCevQ0PH3UFCJowUBmOKXOQmELF49W2lmENetlz4Nvsjhjr
	 +4fHeeAQTOEU3759B95m8c1QxZZ4T+J1XLEn35Nsvskz2ObDUBGPhFQe2K8vdWYnC2
	 Yt7RU+p+f31JlTY9kylbg1nKXUV3Gz5ipo+T4Avup6q0JOG9Odz6Rq3rF3E2B8yXf6
	 5V9tpkm6HY6hQ==
Date: Tue, 3 Jun 2025 15:28:58 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, 
	Fu Wei <wefu@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 3/8] drm/imagination: Use pwrseq for TH1520 GPU power
 management
Message-ID: <20250603-whispering-jaybird-of-thunder-f87867@kuoka>
References: <20250530-apr_14_for_sending-v3-0-83d5744d997c@samsung.com>
 <CGME20250529222405eucas1p18ed1254bf1b2d78468734656fec537e1@eucas1p1.samsung.com>
 <20250530-apr_14_for_sending-v3-3-83d5744d997c@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250530-apr_14_for_sending-v3-3-83d5744d997c@samsung.com>

On Fri, May 30, 2025 at 12:23:50AM GMT, Michal Wilczynski wrote:
> Update the Imagination PVR DRM driver to leverage the pwrseq framework
> for managing the power sequence of the GPU on the T-HEAD TH1520 SoC.
> 
> In pvr_device_init(), the driver now attempts to get a handle to the
> "gpu-power" sequencer target using devm_pwrseq_get(). If successful,
> the responsibility for powering on and off the GPU's core clocks and
> resets is delegated to the power sequencer. Consequently, the GPU
> driver conditionally skips acquiring the GPU reset line if the pwrseq
> handle is obtained, as the sequencer's match function will acquire it.
> Clock handles are still acquired by the GPU driver for other purposes
> like devfreq.
> 
> The runtime PM callbacks, pvr_power_device_resume() and
> pvr_power_device_suspend(), are modified to call pwrseq_power_on() and
> pwrseq_power_off() respectively when the sequencer is present.  If no
> sequencer is found, the driver falls back to its existing manual clock
> and reset management. A helper function,
> pvr_power_off_sequence_manual(), is introduced to encapsulate the manual
> power-down logic.
> 
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  drivers/gpu/drm/imagination/Kconfig      |  1 +
>  drivers/gpu/drm/imagination/pvr_device.c | 33 +++++++++++--
>  drivers/gpu/drm/imagination/pvr_device.h |  6 +++
>  drivers/gpu/drm/imagination/pvr_power.c  | 82 +++++++++++++++++++++-----------
>  4 files changed, 89 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/gpu/drm/imagination/Kconfig b/drivers/gpu/drm/imagination/Kconfig
> index 3bfa2ac212dccb73c53bdc2bc259bcba636e7cfc..737ace77c4f1247c687cc1fde2f139fc2e118c50 100644
> --- a/drivers/gpu/drm/imagination/Kconfig
> +++ b/drivers/gpu/drm/imagination/Kconfig
> @@ -11,6 +11,7 @@ config DRM_POWERVR
>  	select DRM_SCHED
>  	select DRM_GPUVM
>  	select FW_LOADER
> +  select POWER_SEQUENCING

Messed indent.

>  	help
>  	  Choose this option if you have a system that has an Imagination
>  	  Technologies PowerVR (Series 6 or later) or IMG GPU.
> diff --git a/drivers/gpu/drm/imagination/pvr_device.c b/drivers/gpu/drm/imagination/pvr_device.c
> index 8b9ba4983c4cb5bc40342fcafc4259078bc70547..19d48bbc828cf2b8dbead602e90ff88780152124 100644
> --- a/drivers/gpu/drm/imagination/pvr_device.c
> +++ b/drivers/gpu/drm/imagination/pvr_device.c
> @@ -25,6 +25,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/pwrseq/consumer.h>
>  #include <linux/reset.h>
>  #include <linux/slab.h>
>  #include <linux/stddef.h>
> @@ -631,10 +632,34 @@ pvr_device_init(struct pvr_device *pvr_dev)
>  	if (err)
>  		return err;
>  
> -	/* Get the reset line for the GPU */
> -	err = pvr_device_reset_init(pvr_dev);
> -	if (err)
> -		return err;
> +	/*
> +	 * Try to get a power sequencer. If successful, it will handle clocks
> +	 * and resets. Otherwise, we fall back to managing them ourselves.
> +	 */
> +	pvr_dev->pwrseq = devm_pwrseq_get(dev, "gpu-power");
> +	if (IS_ERR(pvr_dev->pwrseq)) {
> +		int pwrseq_err = PTR_ERR(pvr_dev->pwrseq);
> +
> +		/*
> +		 * If the error is -EPROBE_DEFER, it's because the
> +		 * optional sequencer provider is not present
> +		 * and it's safe to fall back on manual power-up.

It is safe but why it is desirable? The rule is rather to defer the
probe, assuming this is probe path.

Best regards,
Krzysztof


