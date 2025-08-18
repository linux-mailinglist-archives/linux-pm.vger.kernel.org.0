Return-Path: <linux-pm+bounces-32525-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 174C6B29E91
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 11:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 253E618A6C53
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 09:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7936F30FF23;
	Mon, 18 Aug 2025 09:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="tSHnOwDf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED69273D77;
	Mon, 18 Aug 2025 09:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755510955; cv=none; b=gJykqO+FJ3o1SrvsjgYOXTuRDlAYjN+YdKC24kwza4UPN87JFvjbNXqEHb0oFa7GHQu8JtmxXnrzEReU85lFJ1Drae6sF7/2zF0uV/JQBcXiWVm7hAKwPFUj/WfS5r7ONulw2Cmhbl0jX88hgo+RwnJDKofY4zNg89Uqmx9CgcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755510955; c=relaxed/simple;
	bh=iOMvpR5ULLxiQ8A6H8TBN7iop6QkwuGc8NxBlTGTMVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0nEmsQhy+Zj6vlT5NJM6Qw7b19M8KMfNJsG0WYbNktaXESGasTMv9ecRAVQn3KzeeDDgB73a+H4J3HJWotMyCI599dezsTJwEBOlQpN8EtlLc1Bl9J/BdcMrmBSOaAwlbMnQ1Kp6w373JpRoTSl6H6tREYVZK3T/+QPH3/BqcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=tSHnOwDf; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1755510945;
	bh=VHlf81wL+CZcIODTXXenYL/631OM0f2P2rYjTCgiBzI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=tSHnOwDf90IXxu5Ctnbv2e35M5tIgmxRKNrBxv5PmQ01rnCW1TqlVVkJmxItZEyY0
	 2ysKAI63mYu/VNSed8S9d0MfkwPNG4ArQBpp61pvOuBQvtozg+5VUfQnFYLbB3HKDs
	 JGToJCUcQkBS/18eW0gvUd8ljfoUHTB2TDDL9j6o=
X-QQ-mid: esmtpgz14t1755510939t95958824
X-QQ-Originating-IP: I8GjGI20rjvRSpDEOuPZgNyL2YsWJO/bsOAUmI2b5HI=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 18 Aug 2025 17:55:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8607044835764841759
EX-QQ-RecipientCnt: 13
Date: Mon, 18 Aug 2025 17:55:38 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Icenowy Zheng <uwu@icenowy.me>, Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	Michal Wilczynski <m.wilczynski@samsung.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sebastian Reichel <sre@kernel.org>
Cc: Han Gao <rabenda.cn@gmail.com>, Yao Zi <ziyao@disroot.org>,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-pm@vger.kernel.org,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: Re: [PATCH 2/2] pmdomain: thead: create auxiliary device for
 rebooting
Message-ID: <492D2D5B0A6B3E27+aKL4mqMhxQ3lWDTa@LT-Guozexi>
References: <20250818074906.2907277-1-uwu@icenowy.me>
 <20250818074906.2907277-3-uwu@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818074906.2907277-3-uwu@icenowy.me>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: Mf+wQkWJ2TuYCiAPWgFdra0vJujaLRvpFaPKy98YStTXnhQ88yBRsPn2
	JDJOZn9R3VJCHvC93FGsU0vSF5DfLCyJQwHHDbU84cj+mLP+uOsQPQjelI71Jit8808KQCp
	G4nn5rb4SDiKCU14QeKuYR4t/shbx8RNUcKZtWCBLtb4HSb5zgja1vc21nTbCoKQIUbWyny
	aJhbeBRYYs7ktMy+wnQPI9gGBdykqD48gbf2WkuSZtVIVyQliw8dacBVeEcI8UbGfLLOB3g
	Tped+ycDIaNtJMPYkbXPyxWILCa7gkmurXnjuynl+JgIiqIb+1rHbQune9bpfSA1Z/HguP/
	agdX8EKNqpABdubnany9Ron7DyuFRTXuIrI99oY2l5VDDK+fRLfjyxL/y0FTeGfFfEh9lx8
	7hPe1Rnu4mKgxpp4PILOLiv8VZ/AjxIk/hwaUYyOQoHGia1BLv0PvwA4nAJrPW8mRgYCMwS
	yXmEcY0WfeV4gs8SKw1LDfECGsGrAPqyGbbUAv52lT3eHF/Uzz+YCmTeJSvl1b0VnxVU9jx
	ORkY6zu+BBWp+iKMW8fuI7PeXZpT93qPi4l9U1czadtRCe87IFSeVMTwPwn4enju7Kf0lvB
	1kLeAEmtSO25p4IWZd01NJExoiGXagIlxe6Qszr7XA13ifWx72gCBrS7pty0ZhUzNNreKnw
	21edzBfmCLosgxNUo9IMI71dNfWrOGywU9pNeyfZGDhIdkewMcg7g5I3FaxPkJnRJYxSDHv
	SZoXHqLFWknLfXJsbITsNrf6in6/IGvUf/4dgN5Qoud6He8C3ZGq4eNktM1R+AWRw1NY0E1
	gCNN/Ly0V4BojR1nFkiKDaQd53DW4qkrI1mk4owWUKEnxrWmm/OjFqqEi9H7kwtPs502BIn
	jFGV0uZCT5hANOgXKCA/bl4XVehV3Ugoku3X1Dm2wTAMQoG4sq9g6DzGSGgsaP0vOAolyCS
	nH3WR92jnKGTCJZlDZtwba4oZsPsEZYf2PkURd+nuCWwqFtK2Kh4MWTTXN4N+z+I0kFpWSA
	QPhhXrqeYM62OAs85xa7bk973kEPLFKugbFNybqphKwr/kNBTMJF8U6DKj6MF3mA0+/VKNr
	MZG4E/IRvhs
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

On Mon, Aug 18, 2025 at 03:49:06PM +0800, Icenowy Zheng wrote:
> The reboot / power off operations require communication with the AON
> firmware too.
> 
> As the driver is already present, create an auxiliary device with name
> "reboot" to match that driver, and pass the AON channel by using
> platform_data.
> 
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
Acked-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>

Best regards,
Troy
> ---
>  drivers/pmdomain/thead/th1520-pm-domains.c | 35 ++++++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pmdomain/thead/th1520-pm-domains.c b/drivers/pmdomain/thead/th1520-pm-domains.c
> index 9040b698e7f7f..8285f552897b0 100644
> --- a/drivers/pmdomain/thead/th1520-pm-domains.c
> +++ b/drivers/pmdomain/thead/th1520-pm-domains.c
> @@ -129,12 +129,39 @@ static void th1520_pd_init_all_off(struct generic_pm_domain **domains,
>  	}
>  }
>  
> -static void th1520_pd_pwrseq_unregister_adev(void *adev)
> +static void th1520_pd_unregister_adev(void *adev)
>  {
>  	auxiliary_device_delete(adev);
>  	auxiliary_device_uninit(adev);
>  }
>  
> +static int th1520_pd_reboot_init(struct device *dev, struct th1520_aon_chan *aon_chan)
> +{
> +	struct auxiliary_device *adev;
> +	int ret;
> +
> +	adev = devm_kzalloc(dev, sizeof(*adev), GFP_KERNEL);
> +	if (!adev)
> +		return -ENOMEM;
> +
> +	adev->name = "reboot";
> +	adev->dev.parent = dev;
> +	adev->dev.platform_data = aon_chan;
> +
> +	ret = auxiliary_device_init(adev);
> +	if (ret)
> +		return ret;
> +
> +	ret = auxiliary_device_add(adev);
> +	if (ret) {
> +		auxiliary_device_uninit(adev);
> +		return ret;
> +	}
> +
> +	return devm_add_action_or_reset(dev, th1520_pd_unregister_adev,
> +					adev);
> +}
> +
>  static int th1520_pd_pwrseq_gpu_init(struct device *dev)
>  {
>  	struct auxiliary_device *adev;
> @@ -169,7 +196,7 @@ static int th1520_pd_pwrseq_gpu_init(struct device *dev)
>  		return ret;
>  	}
>  
> -	return devm_add_action_or_reset(dev, th1520_pd_pwrseq_unregister_adev,
> +	return devm_add_action_or_reset(dev, th1520_pd_unregister_adev,
>  					adev);
>  }
>  
> @@ -235,6 +262,10 @@ static int th1520_pd_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_clean_provider;
>  
> +	ret = th1520_pd_reboot_init(dev, aon_chan);
> +	if (ret)
> +		goto err_clean_provider;
> +
>  	return 0;
>  
>  err_clean_provider:
> -- 
> 2.50.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

