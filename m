Return-Path: <linux-pm+bounces-27452-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E48AABF2DA
	for <lists+linux-pm@lfdr.de>; Wed, 21 May 2025 13:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FD7E1672F3
	for <lists+linux-pm@lfdr.de>; Wed, 21 May 2025 11:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44916262FE5;
	Wed, 21 May 2025 11:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I/yVtItf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C371262FE0
	for <linux-pm@vger.kernel.org>; Wed, 21 May 2025 11:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747826978; cv=none; b=pBtX8e02DwxrZWj5ZP7sCRUoTurON8Cks7YOmG8ggpNKQKePKlw1c7OAGHmB/sWrPF4V+3MJqM44Zan4Fm8MPeKGeOh8zMvIHCDR7m64jwGr/wJZq7M5NHl0/qPL2yJJSmHwjbNEKrdloIZEr+BRJfrVCt0povE6tZmCQ+memqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747826978; c=relaxed/simple;
	bh=tbsCdilN27ywHqdRLbl7X+RfFJBd/tfZvsPN6sBlXCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V7lbFeWZo956GevsGoDe7bMohIXKsXAyo0UawwaoedukV3gMUGMXWHn63JXPXfcIvG0XnOtNb2xu8Rp5IurrTUVQcJ7OIwnf4Qqa4n5occXZKyzsOGWYraeXuKRPmuMq/seZ5nmqYDcOFublFSfYaq/cL5dIsGMJW/0wzQA4TyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I/yVtItf; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e7b7b4eaca1so4495780276.0
        for <linux-pm@vger.kernel.org>; Wed, 21 May 2025 04:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747826975; x=1748431775; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JWTPeu6guknXgD+xPLbcKD6/R/1DRiGD6zvZeqSl37k=;
        b=I/yVtItfDGMA1sACE8usaLMK+pLbO+0YkrREsSTuf1cEB0Y1N9xP/mIzD2n0/W2Qo1
         kzcWpURs8b0tQiGvOG7JyD2Ujkv5UV9dT7WzpROT2Zk14QTIVSTC3C2/eeRT+5f7MHR8
         FgaumTGfH/HKDLLnTFGvAEZ7DaLs0BZMIAZVaKykJhOKhlCOIGgI3AiHn/sUTNquNbmS
         m2oj7OUxsuMRlsv3Cel70jFuADfSfdyI7pZPLh2SZl46k6iIAfAUckAJytXDO1Mn5P/z
         CXOdUucciWE0RMDqSoLfEzhP9QYjJSeFDlXydNINY8slQI2vPMDq+yMLw8alI7NyGL7b
         xBmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747826975; x=1748431775;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JWTPeu6guknXgD+xPLbcKD6/R/1DRiGD6zvZeqSl37k=;
        b=gZvAWIXXMr6KoaOV965m1lTOPO3TC3M6CgrcozKrRWNyIAybpqG8woDU7P0oTtApFf
         6OG5CwYFvmOu0cAQFWs7/c3uXJY+9He8GMZvnL9W08UoXeHoDUzGP8NWR9wrNXE4qvTy
         uw3HCzHHz1JzOoA5nd7FIBKP8vY3LAgvFoeEt+Xgc4er8QSK0Eub3+O94BVYB3rkMJqf
         Vv6CZhjUID33LNW9Vcn/4HxzIPj+Z483I5peChSEW2zfUCeCCOYvER1L6IylWOkzrYPD
         K0NQtiqc3K1MfAD2h7m1mbNRbgWU97hykmf5PgqFGl+F5TDijzvPBnn740oELyfoSxN6
         +Yig==
X-Forwarded-Encrypted: i=1; AJvYcCUjvkxlv/AmVy3xpEe8m3tguq/VGMj76Eernb20gyfHIzdXvNlV3ltMMaiqQTDOJN4qN2MlhycwIw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1PVfWIblFBx4MVqJjL5ZZEftOIch/sd8dxy5Xk6CFyUJE78/W
	BG46YfLGpGWvmP/wQa+kYOKZBH7oC05L7UAV0V0utTKfDReqoSEbGG82OjM+dmcdJpHk8IOZnaz
	1oWc7fDZFD521mSx0O3dX3tDTmW75WkqTjDQMfEROki5AW5EbXD2sMFmbtA==
X-Gm-Gg: ASbGncsOUbZlCDYqR58OEHDjSKkbEreCm9P8nyY5XssdncLx54lBFfloBHta/SNojOk
	ISF9vWJGckuRg9cqC+9hFpcFYgeiDsKwhDra25jQ7ngmkhMmvP3bGJD8fxBDvpRfStdjRMHSTDa
	YdtwDGneaIJ8fu0jQ88acw/KQ5MmoP/XM0xw==
X-Google-Smtp-Source: AGHT+IGqrJmtGm+y80TfkZ9qC6RzIIVW40VlzSH0k6DOy6nN+ldVjeL4cXPRTWEI/C6+tWZ4/q4Eo/InDg514PrPZMk=
X-Received: by 2002:a05:6902:e02:b0:e7d:5e41:a8a4 with SMTP id
 3f1490d57ef6-e7d5e41bb16mr2195411276.16.1747826975411; Wed, 21 May 2025
 04:29:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ab0476382e3342161beda94a45ddadb49b026dcd.1747760015.git.robin.murphy@arm.com>
In-Reply-To: <ab0476382e3342161beda94a45ddadb49b026dcd.1747760015.git.robin.murphy@arm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 21 May 2025 13:28:59 +0200
X-Gm-Features: AX0GCFsr2OpsfVkwDXkGW00v2KHCahRA4NOOOfoEOLpP7qgAYz-trCH0jo8qvFs
Message-ID: <CAPDyKFpT9B55kfGYHzOmb4_cvE-jDMajXBzqB1HLvVB_D+Nokg@mail.gmail.com>
Subject: Re: [PATCH 1/2] firmware: smccc: Stub out get_conduit()
To: Robin Murphy <robin.murphy@arm.com>
Cc: heiko@sntech.de, mark.rutland@arm.com, lpieralisi@kernel.org, 
	sudeep.holla@arm.com, linux-pm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 May 2025 at 19:10, Robin Murphy <robin.murphy@arm.com> wrote:
>
> Various callers use arm_smccc_1_1_get_conduit() to guard their
> arm_smccc_smc() calls - since the latter is already stubbed out to
> support optional usage in !HAVE_ARM_SMCCC configs, do the equivalent
> for the former as well to make life easier.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  include/linux/arm-smccc.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
> index a3863da1510e..97dc4d47c664 100644
> --- a/include/linux/arm-smccc.h
> +++ b/include/linux/arm-smccc.h
> @@ -315,7 +315,14 @@ enum arm_smccc_conduit {
>   *
>   * When SMCCCv1.1 is not present, returns SMCCC_CONDUIT_NONE.
>   */
> +#ifdef CONFIG_HAVE_ARM_SMCCC_DISCOVERY
>  enum arm_smccc_conduit arm_smccc_1_1_get_conduit(void);
> +#else
> +static inline enum arm_smccc_conduit arm_smccc_1_1_get_conduit(void)
> +{
> +       return SMCCC_CONDUIT_NONE;
> +}
> +#endif
>
>  /**
>   * arm_smccc_get_version()
> --
> 2.39.2.101.g768bb238c484.dirty
>
>

