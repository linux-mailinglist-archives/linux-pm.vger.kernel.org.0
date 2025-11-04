Return-Path: <linux-pm+bounces-37331-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3868C2EF0B
	for <lists+linux-pm@lfdr.de>; Tue, 04 Nov 2025 03:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24E8E1896F09
	for <lists+linux-pm@lfdr.de>; Tue,  4 Nov 2025 02:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866D9239E88;
	Tue,  4 Nov 2025 02:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adjU0mbr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5601DE4DC;
	Tue,  4 Nov 2025 02:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762222718; cv=none; b=LB2Ro2NblBqtntsNAPejlNtu8eWUQ7D7aNCYihVbAdLunw/MyD6zru6m683XuuZVUgfV24TnqXuaosb/xV7aiHyL8nT8T4+YiQcS2bg7piUqw39Ot9Z0ngjqGHgY2zMi3t43UOCiol3fr1ieiLRkgUq5neAAHBWWvQmde1vUwDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762222718; c=relaxed/simple;
	bh=FGOnnk3YAcN/+bFQPXCqXStUWdrCxyOR6xZUcaTRVdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SGiknEe1sGymOfXOxK8dgraYIaN3e4OmdJhFWSCA9kjwnVenx8HVKdWUKkciLgdSgx5zF8Amj+1yzraYmMQmrxelbGKRy2AFZXRSskaWGd4i4KL0jZCS3WQqNdDpxOoA/+t1Mf8QTia2/xWSHxkDkFSDTYf2s1h56ZIY2sFxi3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adjU0mbr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C071C4CEE7;
	Tue,  4 Nov 2025 02:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762222718;
	bh=FGOnnk3YAcN/+bFQPXCqXStUWdrCxyOR6xZUcaTRVdU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=adjU0mbr7wBKoKUfGhBlXyq4/dxlm9fA6gJ/5DEhKXIm98Obu4VC3O5Gob3Lb/wCA
	 BoSJbBPVrAt0/ZByTqmjobZusCYYsQnCUUSjNA9JERNIVCPZtt1f2DIAYFTyz3jn4a
	 TQti+ZdiouG9S8HmIFHyEm8ulNhJ9TapDid+BTKuDbafs/XyijvTrUDCYSMoWvg7kG
	 f7ZMx8DmFJVM6X/4SUMjNv+Rnizk9zgv6d/WlH4VWe5cXL4Io5FW7GW04IaGlUBh6R
	 Vc4RPq3W0JdjPitUViIZJ/0nsVI5r3ECCmcM6UbuTfKdDR0hEQHMVhNDOMl51mj7Xf
	 BoXsUXwc4WTYA==
Date: Mon, 3 Nov 2025 20:22:10 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, sre@kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 4/5] firmware: qcom: scm: Support for EDL reboot mode
Message-ID: <t5igalcp5zoxmqzt4p4fcipssjth7zifctj7ta4tkp3uxkvglc@gsdzioqth7zh>
References: <20251103182006.1158383-1-loic.poulain@oss.qualcomm.com>
 <20251103182006.1158383-5-loic.poulain@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103182006.1158383-5-loic.poulain@oss.qualcomm.com>

On Mon, Nov 03, 2025 at 07:20:05PM +0100, Loic Poulain wrote:
> When the dload register is specified, it can also be used to boot the
> platform into Emergency Download Mode (EDL). This mode is implemented
> by the primary ROM bootloader and provides a recovery mechanism.
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>  drivers/firmware/qcom/qcom_scm.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> index 26cd0458aacd..e697ef14619f 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -26,6 +26,7 @@
>  #include <linux/of_platform.h>
>  #include <linux/of_reserved_mem.h>
>  #include <linux/platform_device.h>
> +#include <linux/reboot-mode.h>
>  #include <linux/reset-controller.h>
>  #include <linux/sizes.h>
>  #include <linux/types.h>
> @@ -43,6 +44,7 @@ struct qcom_scm {
>  	struct icc_path *path;
>  	struct completion waitq_comp;
>  	struct reset_controller_dev reset;
> +	struct reboot_mode_driver reboot_mode;
>  
>  	/* control access to the interconnect path */
>  	struct mutex scm_bw_lock;
> @@ -130,6 +132,8 @@ static const u8 qcom_scm_cpu_warm_bits[QCOM_SCM_BOOT_MAX_CPUS] = {
>  #define QCOM_DLOAD_MINIDUMP	2
>  #define QCOM_DLOAD_BOTHDUMP	3
>  
> +#define QCOM_EDL_MASK		BIT(0)
> +
>  static const char * const qcom_scm_convention_names[] = {
>  	[SMC_CONVENTION_UNKNOWN] = "unknown",
>  	[SMC_CONVENTION_ARM_32] = "smc arm 32",
> @@ -2206,6 +2210,18 @@ static const struct kernel_param_ops download_mode_param_ops = {
>  	.set = set_download_mode,
>  };
>  
> +static int qcom_scm_reboot_mode_write(struct reboot_mode_driver *reboot,
> +				      unsigned int magic)
> +{
> +	struct qcom_scm *scm = container_of(reboot, struct qcom_scm, reboot_mode);
> +	int ret = -EOPNOTSUPP;
> +
> +	if (scm->dload_mode_addr)
> +		ret = qcom_scm_io_rmw(scm->dload_mode_addr, QCOM_EDL_MASK, magic);
> +
> +	return ret;
> +}
> +
>  module_param_cb(download_mode, &download_mode_param_ops, NULL, 0644);
>  MODULE_PARM_DESC(download_mode, "download mode: off/0/N for no dump mode, full/on/1/Y for full dump mode, mini for minidump mode and full,mini for both full and minidump mode together are acceptable values");
>  
> @@ -2251,6 +2267,12 @@ static int qcom_scm_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	scm->reboot_mode.dev = &pdev->dev;
> +	scm->reboot_mode.write = qcom_scm_reboot_mode_write;
> +	ret = devm_reboot_mode_register(&pdev->dev, &scm->reboot_mode);
> +	if (ret)
> +		return ret;

I think it would be sufficient with a dev_err() here. You're loosing the
ability to set the "edl" bit but you don't break the whole system - e.g.
in the event that you're making a typo in your mode definition.


Other than that, I think this looks good.

Regards,
Bjorn

> +
>  	/* vote for max clk rate for highest performance */
>  	ret = clk_set_rate(scm->core_clk, INT_MAX);
>  	if (ret)
> -- 
> 2.34.1
> 

