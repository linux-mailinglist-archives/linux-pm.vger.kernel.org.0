Return-Path: <linux-pm+bounces-19224-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 012CC9F192C
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 23:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19FD3163951
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 22:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90A7194C77;
	Fri, 13 Dec 2024 22:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lw/7u6Uh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B3A185949;
	Fri, 13 Dec 2024 22:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734129335; cv=none; b=LAiDCwHIew7EGzuz9fs/KqUTD88SVLpizLCHkENZbMcJ7FMGbkz/91YZ5CDEb9E0o3lJ5tRasKQwectMWOxDuHTnN4GuxGKttTgi+UOUNLKjgr8Jn4Du/U/0Awwj6EPgXd0mHKmldEXeMolJgZSNLZbbYzYNiVlj3IRH2MbsVoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734129335; c=relaxed/simple;
	bh=vw+qH5i0lkBOZ2ckAlgUJxFhDb0vwJNcOcsEK3PkAoo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hPQ3RN/82KxHDOueOPSoloqYaPJt+75cxrjWjBD0rWQVbO9680biAsGD5C6gqqPPdg8XeLahYFOkoIILIQmua43dxvItaGrAKE7NnkWLLFMVH4zuAzil6r29F9h813tnmssZJ8sh6llk0PKx+BTpmDDMjqOS8am9eSAxdKubNwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lw/7u6Uh; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4361f664af5so23945135e9.1;
        Fri, 13 Dec 2024 14:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734129332; x=1734734132; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Nc/F2tkTy/1zhey3hd25ZTggBOyx6moY6Op/pgbrdVI=;
        b=lw/7u6UhD6DluX1YKdGfUWN1+1lf2I2t3B3iLijmzPGtI8k79nAy1qbuq6ocJ9SxGz
         LSmCSh5wyoopGmzujBAyJXfn3AABSkNfiI9KO/LZaqgdmZWu1jizNDBSHt8DMKB9uZ0Z
         GKuwD7lnlyHnN0Vxo4nVSPB7E65rAz5Y5RJfg15cdeg8u+6GFrx8mIvMkglFd9asLrs9
         kyB1mTTCwfiRE1wJUefL/syGdsG/cfPk4res1Gkgip9kVdZ1+CC/p1Vb56Mm5ElRSWXU
         VsX9H4c2YtzqyLZYq7j0Wklb3XkBoY3y/XBqBITaZeBAysDqiyg/4ya2qxNEWrk0CURI
         Vdcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734129332; x=1734734132;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nc/F2tkTy/1zhey3hd25ZTggBOyx6moY6Op/pgbrdVI=;
        b=D9uO7iirmaigVNZHajQBjoqGXZnitAaAadVItwfrvU70jmOvf0IXhpGInXfIv9vYNO
         yw0eDvsYM/+nZMkCJctntI7oSndixFqoZu7Wl4xTEksARU4c61FkwrW8nWZDGRaZZqCy
         2dNdhSsT8ree70zJKW0tw6tl2Tawyhu1SGV3UvkeqCdAKCOno+Uglp/MnoRtvb1wTzGK
         qLqcgcW4Rxz9mDzZBIskAruN+JUYkcpVskL9r+XMv2NzFM61psVMCcbAv7mU+e45jPZR
         5M9XtMlOlOfPpq3i/l84Xf+AzIHZMtoHwjOTLNMovuPm5Vfb2MtnAquByO8SjK7UFf67
         Ynqw==
X-Forwarded-Encrypted: i=1; AJvYcCUkOHGQuFu5oixHJ5EZsbOKuuYsMLXeT3PT5mpymrnHt4iCtEU0Vqbp8DY7AELCgGp3Y7ZiSeCsdVE=@vger.kernel.org, AJvYcCWS7IaNPxAp5JidB544z4CRQjbrtiCbg8hAU2TzGcDtppcG+nbgDBDajt870uxvPAPTW7eocSkQ4ld6@vger.kernel.org, AJvYcCXH2tL99yCiapPBPoeirMjKCjcjN52CbxMGfMsks6tQeTIDT5W+kVnNTg0zokbIDkJG7lTSm7oJXOtVnsJM@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0fVZTMfwsv2AmbsnpspcWRcHXDl5ksmP5SzM4eoq1/Jq/vi+5
	SsEF8nZRm9/s4lhaQ6dNncufv71hctjj9liIfG70XIsmUKFWsypm
X-Gm-Gg: ASbGncsGGQZEgjxZKRzZfBSP6SO4V8ckhvronOc8bGw3/5b3N3kgs5bfO2rVPcWBDeV
	oPHQhbYcbc3eEGFhDL2P6x0FC0wjqzX9q9KJdy4aagBOT7CpXX0+D/rDul/xYcBJDPaMKFK5LS6
	IApN08SFyfvLLz3hdKbUzXck0GFc5FPKqS8cYzw1wVy8cQDz/9SZ/lCJYuPmkJGnTDrINJD1w3H
	OzUwidD7PeUXU/yqAZrM0DkdZ90KoB+H92FNCIworX/uuKmgJd1Pvi8MQe4YJeMRHQ5Zd1Uk3Ai
	vGg1rRkSXpoP
X-Google-Smtp-Source: AGHT+IGcJbb2tcyZgOmXn1eIQ0OLAZzDjvv9dXfeVSjQU/Gi2WzJjbPYFyVLfbqMFs7sFQkHgBTLJg==
X-Received: by 2002:a05:600c:c87:b0:431:5df7:b310 with SMTP id 5b1f17b1804b1-4362aa2771fmr33792815e9.8.1734129331830;
        Fri, 13 Dec 2024 14:35:31 -0800 (PST)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4362557c462sm62080235e9.14.2024.12.13.14.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 14:35:30 -0800 (PST)
Message-ID: <675cb6b2.050a0220.149877.5bab@mx.google.com>
X-Google-Original-Message-ID: <Z1y2rYrKD8lu9xle@Ansuel-XPS.>
Date: Fri, 13 Dec 2024 23:35:25 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [PATCH v7 2/2] cpufreq: airoha: Add EN7581 CPUFreq SMCCC driver
References: <20241206211145.2823-1-ansuelsmth@gmail.com>
 <20241206211145.2823-2-ansuelsmth@gmail.com>
 <CAPDyKFovtfR7BiXBfH-79Cyf1=rd-kmOoEnEdMArjGUxSks-Aw@mail.gmail.com>
 <20241213040001.jaqeuxyuhcc73ihg@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213040001.jaqeuxyuhcc73ihg@vireshk-i7>

On Fri, Dec 13, 2024 at 09:30:01AM +0530, Viresh Kumar wrote:
> On 12-12-24, 13:01, Ulf Hansson wrote:
> > On Fri, 6 Dec 2024 at 22:16, Christian Marangi <ansuelsmth@gmail.com> wrote:
> > Hmm, it looks like this needs to be moved and possibly split up.
> > 
> > The provider part (for the clock and power-domain) belongs in
> > /drivers/pmdomain/*, along with the other power-domain providers.
> > 
> > Other than that, I was really expecting the cpufreq-dt to take care of the rest.
> > 
> > To me, the above code belongs in a power-domain provider driver. While
> > the below should be taken care of in cpufreq-dt, except for the device
> > registration of the cpufreq-dt device, I guess.
> > 
> > Viresh, what's your view on this?
> 
> Sure, no issues.. These are all cpufreq related, but don't necessarily belong in
> the cpufreq directory.
>

Problem is really DT schema... I wonder if it's acceptable to push a
name-only driver in pmdomain just do detach from cpufreq. The cpufreq
driver would manually probe the pmdomain. Is it acceptable?

Or do you have alternative solution for this?

-- 
	Ansuel

