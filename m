Return-Path: <linux-pm+bounces-10953-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6AA92DEC6
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 05:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 670452841C7
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 03:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874F4DDDF;
	Thu, 11 Jul 2024 03:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yY5K0paI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35C515E85
	for <linux-pm@vger.kernel.org>; Thu, 11 Jul 2024 03:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720667641; cv=none; b=CiLNX1s/uhVn3aUw8xUsenuEjZabhtl/ax5uyZn0rIfNhStTiRQSQzyXKFUV0vle2uQZijyBYZxUeJSEO/W7Lmyte70L9smHnPcyIimAI5f3SeLu5DmYPBbdmLcnN3aodRAJ3J0THG9T+xvLG4z2q2NdZzFVeJ1SbvfLbcaAAho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720667641; c=relaxed/simple;
	bh=4/rjDrZjvQseFIeCQ6pUuQe8vrNf2gZrF3GvET2y620=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nS8+pgbvwkXOBwTVpUI4jqXT7L2LQ6s4pBhPLRA+JCXCZ8dJj9m+zy0cGVlZ/VcYDZxgPCYksa3mDuZxomYRxWynfSZAEQIvvOZrDSEZQzt4Pa++IK3fX2DfA5pOpsFe0QE7hhPChDCQ1IGyaDpfHMi5/Tq0MZuMgZrW0BmkW2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yY5K0paI; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-38713b03039so1594415ab.0
        for <linux-pm@vger.kernel.org>; Wed, 10 Jul 2024 20:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720667639; x=1721272439; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C1cAFNB7LFS8brCkG4UslgJYtJNg2t3HhgRwEsgG2eM=;
        b=yY5K0paIED2Qqed+wtlK1Ejypg7urYazzxN5R0qeYoKojhnTCiSsONObeCsxxSRNGv
         WBkjacKxEQpFcD5PetE6IEZIHnf+Fca8Cp4nPoyE/qZ0XPpVpBJDKKQRe0Pq44hzFTUr
         h+aaxb8q39T35hMm4n2Fqzuqu0m1ilbYuIT+PKRlXB2tNYhs/zENINXd3GxUHxn5pCBV
         4qK+9nBRi/Yaj7A6Y14Rh3eDVsFPxIIYdjDiunD64FVHJGlZcUyEDkAVNHnJZBMNUu2b
         fZIbTQwi96Q51U3rPgAWkxF/UdyDmaiMu+mQpUuIGp4q3z1jQZLYzI+CjGV/z4LrkFGM
         VF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720667639; x=1721272439;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1cAFNB7LFS8brCkG4UslgJYtJNg2t3HhgRwEsgG2eM=;
        b=RBB62S0C7lJx6BJFkukMIJ/aXQnExFSWv8VLc4fgaTU/nty+uLgBS1c6FhX9W0n/WA
         GxMYihcE0hef/XbmeZgAywK06FQpxRnPlIo8fhKHHKz4rdrQSdb57NabwRV4S5SEIHSd
         Glw5wWYO2iBL591wqOXYdxXM8IfObB62JS7ISiz0dnWnqTx1k6ZlghkC7Sb/QthYtOiN
         IwH4Wky6cd3RTCCB1aHMyiuCrvkJ6NZ45hZ8T6GAB09XCBHVZ0Miq4m/mWpHBvjvraiQ
         yzuamUikoDTdUxaB41keDPAOInU4/J1PxuCR+tE5sUaH3zQz4IXSTcu2A8nb6zSmb/NB
         IYjw==
X-Forwarded-Encrypted: i=1; AJvYcCXjOsF3MzEhINPvsVsuU/x2+abLClMOKIv9hdjiDVx5y0gQ3nKHI4DfoWPHkDFqS9kCpfY8JnZmF6MthqnUONEvg2jFAoyGnBk=
X-Gm-Message-State: AOJu0YwmPGACJd4v4s9S1qztKohMRJ6JOkIm2k+OpZG9Tq/ctU6c2k8C
	1VZmvWY1RlwgDzG2Y9FVlpziaNVwBx9QORx6eRmTIm+UppZloMi67jakPUgd590=
X-Google-Smtp-Source: AGHT+IGUm+zwlcqShrjiCItBYhVUFoaI2EaHQS7ywQwYgbbo7lKpcVSloRYjcAvj6MYYmJB80AKPOQ==
X-Received: by 2002:a05:6e02:1a08:b0:376:3c70:af63 with SMTP id e9e14a558f8ab-38a57215f28mr86224045ab.11.1720667639141;
        Wed, 10 Jul 2024 20:13:59 -0700 (PDT)
Received: from localhost ([122.172.84.129])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-77d6886f92dsm2909972a12.90.2024.07.10.20.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 20:13:58 -0700 (PDT)
Date: Thu, 11 Jul 2024 08:43:56 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>, Nikunj Kela <nkela@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] OPP: Fix support for required OPPs for multiple PM
 domains
Message-ID: <20240711031356.rl2j6fqxrykmqfoy@vireshk-i7>
References: <20240618155013.323322-1-ulf.hansson@linaro.org>
 <20240625105425.pkociumt4biv4j36@vireshk-i7>
 <CAPDyKFpLfBjozpcOzKp4jngkYenqSdpmejvCK37XvE1-WbBY2g@mail.gmail.com>
 <20240701114748.hodf6pngk7opx373@vireshk-i7>
 <20240702051526.hyqhvmxnywofsjp2@vireshk-i7>
 <CAPDyKFoA9O5a6xZ+948QOzYqsRjk_0jJaSxeYRwx=76YsLHzXQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFoA9O5a6xZ+948QOzYqsRjk_0jJaSxeYRwx=76YsLHzXQ@mail.gmail.com>

On 10-07-24, 15:51, Ulf Hansson wrote:
> I think this should work, but in this case we seem to need a similar
> thing for dev_pm_opp_set_rate().

We don't go to that path for genpd's I recall. Do we ? For genpd's,
since there is no freq, we always call _set_opp().

-- 
viresh

