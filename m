Return-Path: <linux-pm+bounces-38419-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F063EC7E263
	for <lists+linux-pm@lfdr.de>; Sun, 23 Nov 2025 16:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C33143AADAF
	for <lists+linux-pm@lfdr.de>; Sun, 23 Nov 2025 15:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF3F29E10B;
	Sun, 23 Nov 2025 15:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhMRBaMg"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC25821B918;
	Sun, 23 Nov 2025 15:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763911247; cv=none; b=hxXh6+WdTnsM41I8wCxeif1Yba1vmJLAhOamz5JM6xOECYXscSVQgMn+UFWfxQSOTzCZGCE9WDXLQAC0Q7xy0G/jRfb5bEKYBhgqt1Hs9fGYp+91uPwf/sL7tVt3EoGM4ONa/T0kSabMDen8oAd6D6pbit6VyKydAykbUqhSdQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763911247; c=relaxed/simple;
	bh=Z4iaAtHuU2L2bBN5HeCWjqlEakR2sNKBfdG1aRpG4sc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OPXRCmdmo2r8jjGn2IZ6J+hu30zGjA7PdEG+cwX/OJeZfZtzKVlLFS7CGYjjZrRdAjQ5CBKlAYTpwInSlgc2mxOi1FnqaKInHoqR/KMcdIw5GhKcw/oG+umrt5+iBuSu5kVw8v0DLrqxmCZZOE/NF3U6OrqxsWOmri6s56rwN6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhMRBaMg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 304A8C113D0;
	Sun, 23 Nov 2025 15:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763911246;
	bh=Z4iaAtHuU2L2bBN5HeCWjqlEakR2sNKBfdG1aRpG4sc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RhMRBaMgSeUlrc1/FH8ekmIMkfYyVE245Roedi0Y8uR0kXPZ5tQgo+M1RHWs78tTK
	 yZZjK3U/b3sUP1pPoz+kWIIPnCq2uMGc0W0Sm60CAWVVy76ezkcjqfAgSAiXddnA6+
	 Zi9Hf6Cyf2ZqR00KH7MvOseWMlPBGZ7aA+4KjuLSTSJlsl9Xp9Np0Xi+NBLWlPsbDW
	 Hde79185dpMEQGGVRISIvg3mxp1CxlanVZ7kkm01xDUOhm1Y3Z51VlWilU3XzOKaoM
	 ZLmGP7Wrm5RN9EQFUQDLCi72YV9upsK9dSp9QjHIlEKpByd/dyrh4FwQ7ObI75okEp
	 irfWnf0dmkAfQ==
Message-ID: <42715ebe-2d52-4212-9dc4-5d9b1db880e1@kernel.org>
Date: Mon, 24 Nov 2025 00:20:43 +0900
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] PM: devfreq: fix typo in DFSO_DOWNDIFFERENTIAL
 macro name
To: Riwen Lu <luriwen@kylinos.cn>, myungjoo.ham@samsung.com,
 kyungmin.park@samsung.com, cw00.choi@samsung.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251118032339.2799230-1-luriwen@kylinos.cn>
From: Chanwoo Choi <chanwoo@kernel.org>
Content-Language: en-US
In-Reply-To: <20251118032339.2799230-1-luriwen@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

25. 11. 18. 12:23에 Riwen Lu 이(가) 쓴 글:
> Correct the spelling error in the DFSO_DOWNDIFFERENTIAL macro
> definition and update the corresponding variable assignment.
> 
> The macro was previously misspelled as DFSO_DOWNDIFFERENCTIAL.
> This change ensures consistent and correct spelling throughout
> the simpleondemand governor implementation.
> 
> Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
> ---
>  drivers/devfreq/governor_simpleondemand.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/governor_simpleondemand.c
> index c23435736367..b4d7be766f33 100644
> --- a/drivers/devfreq/governor_simpleondemand.c
> +++ b/drivers/devfreq/governor_simpleondemand.c
> @@ -14,7 +14,7 @@
>  
>  /* Default constants for DevFreq-Simple-Ondemand (DFSO) */
>  #define DFSO_UPTHRESHOLD	(90)
> -#define DFSO_DOWNDIFFERENCTIAL	(5)
> +#define DFSO_DOWNDIFFERENTIAL	(5)
>  static int devfreq_simple_ondemand_func(struct devfreq *df,
>  					unsigned long *freq)
>  {
> @@ -22,7 +22,7 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
>  	struct devfreq_dev_status *stat;
>  	unsigned long long a, b;
>  	unsigned int dfso_upthreshold = DFSO_UPTHRESHOLD;
> -	unsigned int dfso_downdifferential = DFSO_DOWNDIFFERENCTIAL;
> +	unsigned int dfso_downdifferential = DFSO_DOWNDIFFERENTIAL;
>  	struct devfreq_simple_ondemand_data *data = df->data;
>  
>  	err = devfreq_update_stats(df);

Applied it. Thanks.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi


