Return-Path: <linux-pm+bounces-18211-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9B99DBB0B
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2024 17:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0C92B21252
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2024 16:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2571BD9F2;
	Thu, 28 Nov 2024 16:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="oj7sLfEs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5774F3232;
	Thu, 28 Nov 2024 16:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732810311; cv=none; b=Sqiv6kPNrCZ/fFaXfnmBjNRAwC4DB9euiuFVlfNyIv3a8fGHqHF1KRzeMvu9RhQaXlITTaU8mSReZ665L1Ow3JHe8rG2ppVZWia2q84VJ7LOV4sYT3nIXWRvWuzGH8knfJbNggQvEuvei29vggdMRrJdl17CEq2t0AkJZoq2ZO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732810311; c=relaxed/simple;
	bh=hk8fpGiKL3O9Sh34djHrjeiSXuSViWedgIE4zr39bXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dkbac5zC6KkK9hSJwyy09Ug+uLkrbYdBd0yxeAEEPvSubUyrgtGUIghZoUUxGwm4rexhTdVMrw1FSsQNCnLD/NhFuRxD6CrkPrMqPM+WWMM3Gya7ZPLV0iLWznNHu7dSmnfTKyU7L953qvxFLshx+Al80jCHk++9V6h+FZtgMgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=oj7sLfEs; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=fEbXQkB4IJYXc22/B7PWcP9nVPx5MuixvHf7IuMVJrg=; b=oj7sLfEs8oHFPkrx
	cah6DeKryAR3itpdcsZ4mcsKq1FrI+IbxK6S1XfOrpdGu+o1Ku6YYJ3jbM+IqkW3ieeiHyVukbsYo
	CQCIEQzhYDF8pXNI1cIZ4wHfFvbAnPRTCR65UcQ526G5b8BgNEw76d61mbeyWKSdGLVBfwx77cXp6
	u9hgZ1VEJu96JfwVPdVQQntt8BZzC+R6uAEbvpqnFgTFPEZ4uN/bYQ3h8WN9nozX58zk+Y96n1jSO
	/nJEBJP0v5BS/6Vz+BhjuWzlqWTOLlTg/0wYvbdoPlQjzJkKJzRnfTi/KVqDaeo1fsD1XkIYnHC46
	oOV3bCcsFP3kKlfm6A==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tGh7E-002Qml-1t;
	Thu, 28 Nov 2024 16:11:40 +0000
Date: Thu, 28 Nov 2024 16:11:40 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
	cw00.choi@samsung.com
Cc: linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM / devfreq: Remove unused
 devm_devfreq_(un)register_notifier
Message-ID: <Z0iWPCzjv9YQ4kO_@gallifrey>
References: <20241028021344.477984-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20241028021344.477984-1-linux@treblig.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 16:11:27 up 204 days,  3:25,  1 user,  load average: 0.02, 0.03,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* linux@treblig.org (linux@treblig.org) wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> devm_devfreq_register_notifier() and devm_devfreq_unregister_notifier()
> have been unused since 2019's
> commit 0ef7c7cce43f ("PM / devfreq: passive: Use non-devm notifiers")
> 
> Remove them, and the helpers they used.
> 
> Note, devm_devfreq_register_notifier() is still used as an example
> in Documentation/doc-guide/contributing.rst but that's just
> an example of an old doc bug rather than anything about the function
> itself.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Ping.

Thanks,

Dave
> ---
>  drivers/devfreq/devfreq.c | 67 ---------------------------------------
>  include/linux/devfreq.h   | 23 --------------
>  2 files changed, 90 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 98657d3b9435..6c3b241b4458 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -2224,70 +2224,3 @@ int devfreq_unregister_notifier(struct devfreq *devfreq,
>  	return ret;
>  }
>  EXPORT_SYMBOL(devfreq_unregister_notifier);
> -
> -struct devfreq_notifier_devres {
> -	struct devfreq *devfreq;
> -	struct notifier_block *nb;
> -	unsigned int list;
> -};
> -
> -static void devm_devfreq_notifier_release(struct device *dev, void *res)
> -{
> -	struct devfreq_notifier_devres *this = res;
> -
> -	devfreq_unregister_notifier(this->devfreq, this->nb, this->list);
> -}
> -
> -/**
> - * devm_devfreq_register_notifier()
> - *	- Resource-managed devfreq_register_notifier()
> - * @dev:	The devfreq user device. (parent of devfreq)
> - * @devfreq:	The devfreq object.
> - * @nb:		The notifier block to be unregistered.
> - * @list:	DEVFREQ_TRANSITION_NOTIFIER.
> - */
> -int devm_devfreq_register_notifier(struct device *dev,
> -				struct devfreq *devfreq,
> -				struct notifier_block *nb,
> -				unsigned int list)
> -{
> -	struct devfreq_notifier_devres *ptr;
> -	int ret;
> -
> -	ptr = devres_alloc(devm_devfreq_notifier_release, sizeof(*ptr),
> -				GFP_KERNEL);
> -	if (!ptr)
> -		return -ENOMEM;
> -
> -	ret = devfreq_register_notifier(devfreq, nb, list);
> -	if (ret) {
> -		devres_free(ptr);
> -		return ret;
> -	}
> -
> -	ptr->devfreq = devfreq;
> -	ptr->nb = nb;
> -	ptr->list = list;
> -	devres_add(dev, ptr);
> -
> -	return 0;
> -}
> -EXPORT_SYMBOL(devm_devfreq_register_notifier);
> -
> -/**
> - * devm_devfreq_unregister_notifier()
> - *	- Resource-managed devfreq_unregister_notifier()
> - * @dev:	The devfreq user device. (parent of devfreq)
> - * @devfreq:	The devfreq object.
> - * @nb:		The notifier block to be unregistered.
> - * @list:	DEVFREQ_TRANSITION_NOTIFIER.
> - */
> -void devm_devfreq_unregister_notifier(struct device *dev,
> -				      struct devfreq *devfreq,
> -				      struct notifier_block *nb,
> -				      unsigned int list)
> -{
> -	WARN_ON(devres_release(dev, devm_devfreq_notifier_release,
> -			       devm_devfreq_dev_match, devfreq));
> -}
> -EXPORT_SYMBOL(devm_devfreq_unregister_notifier);
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index d312ffbac4dd..ea161657ebc6 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -263,14 +263,6 @@ int devfreq_register_notifier(struct devfreq *devfreq,
>  int devfreq_unregister_notifier(struct devfreq *devfreq,
>  				struct notifier_block *nb,
>  				unsigned int list);
> -int devm_devfreq_register_notifier(struct device *dev,
> -				struct devfreq *devfreq,
> -				struct notifier_block *nb,
> -				unsigned int list);
> -void devm_devfreq_unregister_notifier(struct device *dev,
> -				struct devfreq *devfreq,
> -				struct notifier_block *nb,
> -				unsigned int list);
>  struct devfreq *devfreq_get_devfreq_by_node(struct device_node *node);
>  struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev,
>  				const char *phandle_name, int index);
> @@ -420,21 +412,6 @@ static inline int devfreq_unregister_notifier(struct devfreq *devfreq,
>  	return 0;
>  }
>  
> -static inline int devm_devfreq_register_notifier(struct device *dev,
> -					struct devfreq *devfreq,
> -					struct notifier_block *nb,
> -					unsigned int list)
> -{
> -	return 0;
> -}
> -
> -static inline void devm_devfreq_unregister_notifier(struct device *dev,
> -					struct devfreq *devfreq,
> -					struct notifier_block *nb,
> -					unsigned int list)
> -{
> -}
> -
>  static inline struct devfreq *devfreq_get_devfreq_by_node(struct device_node *node)
>  {
>  	return ERR_PTR(-ENODEV);
> -- 
> 2.47.0
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

