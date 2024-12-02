Return-Path: <linux-pm+bounces-18316-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 652CC9DFABC
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 07:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A71F1626FD
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 06:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFBF1F8AE2;
	Mon,  2 Dec 2024 06:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rFYnVibo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F991D6DB5
	for <linux-pm@vger.kernel.org>; Mon,  2 Dec 2024 06:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733121144; cv=none; b=E/sYNpa1QKvXOkXx4h6+I2slmGJ5IvxeBp19o0nodZuy3DNSayZVtES2iaH6WBtUeUL+3EwfwQIQZ0wzRc2xP3gPd/Yv0BndNJaara8goAODffNpHR8YUW5g414W6lv9D/5PM+wbAgdvI5fn4EZol5e3KRKvNyGNefELsC0JIM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733121144; c=relaxed/simple;
	bh=QQLnYmKvGqFJ7sA2gHqV0Upd6Bo/7oU8H7gUN18PrYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NEZFS5UP7rTVh8N6ffn+OeQTChDjT/hbkgSdffvKJX0a10qwxB/o5Jh5bvYdi8Hjpo/nypAosGLgf3KQacXGZo+mtHGtZol5s7udzaPes06kGD3qR/Nywk8EaWih12NOan5sXhXS17Vn5lbo2sY5zD6OQtQ8r+6E8Z5xmBvLnWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rFYnVibo; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21290973bcbso37478145ad.3
        for <linux-pm@vger.kernel.org>; Sun, 01 Dec 2024 22:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733121142; x=1733725942; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QaAjXlMahWaPPK8kYZPf2znqjEQMRsE6lGjRgJChzrk=;
        b=rFYnViboTz63rorSBARNeVPsXGYa8+3OZUe0OflwbmEi1EtVtfRfFp8QeT0S8eHefx
         dNI6Ch0J+kjlJJDBxyhNOJPBLpC5L57iTm4motjKL2Rv9DR7V2eJH++alH3vs0gz4isK
         G6jsfenRn9LXlg2Q8qtgVEP1hZeDFX60kIr9EKtvVkfi/yI7+9KNOeNa2xNV1TH3a22b
         5j+NTabCaFh2Vap0r+vgh2x1F/20T7/kR47snLV6DfcoPT2RGnmVAbl2t/SZGfj0cGt2
         fm9pISuddgwNVNDWewMMJ9uTfNnQlzpyCUcNuflz9TyRH+wcTopIYIbmQ+lRCx9G7VS/
         ay3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733121142; x=1733725942;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QaAjXlMahWaPPK8kYZPf2znqjEQMRsE6lGjRgJChzrk=;
        b=YekgeEnIlmNs+IUwlmNS2aq1ewsnREpqgWbl+2PykH7FICorMg9tp49qgow60tXEG6
         xlnZ2FixFbrlULPmGLfUIvEZGfv+qcsL/Jcq+dD5XX6L0DY5eVWA02uucmpbHSuJN4Ab
         SkvtTsgK0KZSjGV3WgPppAMp08hv06PbHCQkd8vwNVmDYu7ynMnSlpQzEbzRUkkPSxVd
         8dWgtAwNfqcXwMNHa1S9u2O00ehySGcW1NYS+p/6pufgoeqRu+Run14gU9lNIdbLrQkQ
         YXHGLzEaOSniArysBobBoo14Gq1ia049l11vN/JiWDQGa8M0R2xUQxz+D2daS67uLEwN
         pAGA==
X-Forwarded-Encrypted: i=1; AJvYcCVTpZlsg4LZwwEgChoz7YhtgfIHFsXEXFGbsMZ98bmcuwr1udgUnh4JyUUdIajq6JXB+aPNQ5rejg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwacHPt4JJt6UM3Snkw3n7MP+M8FK+ZTJXYsckpgRMVRROniXyf
	dO8o+2MBoe85ToF4vjYzilWPJHmqejBnk1TrI8++7bd5xcLNlQG1r7u88skAqJs=
X-Gm-Gg: ASbGncsCNWscyeNb6tzi+edVF91hTimq1k++2ASIOz2ztjMmuJ2FicmVPwNFFpUG/2+
	L0GhClkSKtNmgWkgWpV7rNXm1uoeUa0wWNbvfDS4XtTXtEHCb64QugpfZ5YwvpJ3QU8R247xLMw
	2hblWElgO9AKEaaDkPWETjW53CYNp6qhPKFYBShN1U0O0S7ZEi3GhByAuqZKvd8x/3/A761wEN3
	G9ryYE/mjGk42iwL+pody0nK2IjvXLtB/utpM1DCwG7s3Ac+x58
X-Google-Smtp-Source: AGHT+IGYhjUoHDCLwzmR+4DgTs9bkKuenJfFo+6JvE40VkbLu5HidScSvlyxpJil/9dg5jbAH9nNVw==
X-Received: by 2002:a17:90b:3c11:b0:2ee:b4d4:69 with SMTP id 98e67ed59e1d1-2eeb4d40232mr6275373a91.35.1733121142397;
        Sun, 01 Dec 2024 22:32:22 -0800 (PST)
Received: from localhost ([122.172.86.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee72dea03dsm4216447a91.27.2024.12.01.22.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 22:32:21 -0800 (PST)
Date: Mon, 2 Dec 2024 12:02:19 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] opp: core: Fix off by one in dev_pm_opp_get_bw()
Message-ID: <20241202063219.evknbyimnldqrymn@vireshk-i7>
References: <41ae307c-f6ff-49fb-a962-eb488152de71@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41ae307c-f6ff-49fb-a962-eb488152de71@stanley.mountain>

On 30-11-24, 13:07, Dan Carpenter wrote:
> The "opp->bandwidth" array has "opp->opp_table->path_count" number of
> elements.  It's allocated in _opp_allocate().  So this > needs to be >=
> to prevent an out of bounds access.
> 
> Fixes: d78653dcd8bf ("opp: core: implement dev_pm_opp_get_bw")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/opp/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index d4a0030a0228..09a1432561f6 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -121,7 +121,7 @@ unsigned long dev_pm_opp_get_bw(struct dev_pm_opp *opp, bool peak, int index)
>  		return 0;
>  	}
>  
> -	if (index > opp->opp_table->path_count)
> +	if (index >= opp->opp_table->path_count)
>  		return 0;
>  
>  	if (!opp->bandwidth)

Applied. Thanks.

-- 
viresh

