Return-Path: <linux-pm+bounces-27676-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5627AAC47EA
	for <lists+linux-pm@lfdr.de>; Tue, 27 May 2025 07:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05CB13ACA53
	for <lists+linux-pm@lfdr.de>; Tue, 27 May 2025 05:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C401E1C1A;
	Tue, 27 May 2025 05:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FN7MR3WA"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CD0EC5;
	Tue, 27 May 2025 05:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748325406; cv=none; b=ZiGg3E0BUkA69MRCUIOg/y8g6gjAO7l6ZAFhIOgt+IeHZU4dQ9US0q6XVT7RD0JJOdLjmKAY0nzlzfXCylac0Pie4WVjCCci9MEXOiQb7cGU7MoUbCCdh7hwJyUfPKXmlxmibCv58SwtLhhBLHTohLE/5lKXqXWWiSpqkGGbUww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748325406; c=relaxed/simple;
	bh=U9Yf5Qn+CWpgrecG5lo3yXM4ImFNhP5nzssC2XvTG3I=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gR0GkZna066KR2ZHBE+q11dovtlugT25y1/b1EQrRYfpzQgx8uX1P3JoOtAyOVYPKI6nZnurMk9bvwU2WbFvJX6aIykeBAULmQo0wkwpRVJE6DdyxoI6FIPotOVWxA6Eq78d5XtVkqvrZZWtSAZSO9jqCAPaiGwm1h8aLXgpY3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FN7MR3WA; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 54R5ubQx1667523;
	Tue, 27 May 2025 00:56:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1748325397;
	bh=TyQEMTJMjv/JXggHV0vUjGan81xX/UwqrqP/Y9Utr6I=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=FN7MR3WAYpjes24Ev46ZD8so0Hr6hLBuJIQfU2JVyEtFoFGniMrl6pL9PluakhLR7
	 PacaaxoMrFCq/Ivrv+0f9jgFqe/4LAO+70YcfeL4yciHr09fQO6RsqyN5EcmcxPkpg
	 9CasfXen/evUyG3Z+JXmzw8oM2LGFnQdkxaYk+EA=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 54R5ub012658494
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 27 May 2025 00:56:37 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 27
 May 2025 00:56:36 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 27 May 2025 00:56:36 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 54R5uZpo3202397;
	Tue, 27 May 2025 00:56:36 -0500
Date: Tue, 27 May 2025 11:26:35 +0530
From: Dhruva Gole <d-gole@ti.com>
To: bhanuseshukumar <bhanuseshukumar@gmail.com>
CC: <cw00.choi@samsung.com>, <myungjoo.ham@samsung.com>,
        <kyungmin.park@samsung.com>, <skhan@linuxfoundation.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] docs: devfreq: Fix typo 'enabeld' to 'enabled' in
 devfreq-event.c
Message-ID: <20250527055635.qgpf2v7artictbf2@lcpd911>
References: <20250526133839.64455-1-bhanuseshukumar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250526133839.64455-1-bhanuseshukumar@gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On May 26, 2025 at 19:08:39 +0530, bhanuseshukumar wrote:
> Fixed a typo in  description of the function 
> 
> This is me trying my way into opensource linux kernel contribution
> journey beginning with this  first patch of trivial spelling 
> mistake fix. 

We appreciate your contribution, and welcome you to the community :)

However, this is not something that's meaningful to be part of a "git
log". commit messages in the git log should convey explanation or
reasoning behind purely the content of the patch itself.
So it's fine in this case to write just "Fix a typo...."

Read more about this here:
https://docs.kernel.org/process/submitting-patches.html#explanation-body

> 
> Signed-off-by: bhanuseshukumar <bhanuseshukumar@gmail.com>
> ---
>  drivers/devfreq/devfreq-event.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfreq-event.c
> index 70219099c604..020fe30ed5d9 100644
> --- a/drivers/devfreq/devfreq-event.c
> +++ b/drivers/devfreq/devfreq-event.c
> @@ -100,7 +100,7 @@ EXPORT_SYMBOL_GPL(devfreq_event_disable_edev);
>   * @edev	: the devfreq-event device
>   *
>   * Note that this function check whether devfreq-event dev is enabled or not.
> - * If return true, the devfreq-event dev is enabeld. If return false, the
> + * If return true, the devfreq-event dev is enabled. If return false, the
>   * devfreq-event dev is disabled.
>   */
>  bool devfreq_event_is_enabled(struct devfreq_event_dev *edev)
> -- 
> 2.34.1
> 
> 

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

