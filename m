Return-Path: <linux-pm+bounces-10969-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F069B92E49B
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 12:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A48141F20FF1
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 10:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA97B15884B;
	Thu, 11 Jul 2024 10:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ihAzPdsc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF9E152189
	for <linux-pm@vger.kernel.org>; Thu, 11 Jul 2024 10:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720693530; cv=none; b=G6G29pToDcZ1XpsvrPssCadgCf7pbpBdvTCgdfcFrd/YKKcIGXhprEcxsk4vTDSlYQ6awxm67rWf457k1RvtmypAyTYg/AeM47XzDDrQZnM6r7kEWRTR2/H+1beLAb67z83eICN9yi2DP3oeOfi1dFyeDKMju//u0dYHG2a3ik8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720693530; c=relaxed/simple;
	bh=6AB7niHpnfz+QrIJ2+DtEZgS9F/0Gd/0DVciQLOxiac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=skpE1VA8Zifvi4KFGv74nP0aStYbKFkqSyydE3MsaI1S1mapO4czTpE+GqMvlrxDvJDeGbuPwAy6HjXC4T9SUZwJvfFSeZ2VFzNp9OCRqCx5dFjLW93oEr9dvQDB51y8AsJxAfFoSnYMIpW0MsPvA7oJKgCHepos+Qer2UVSfRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ihAzPdsc; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dfab4779d95so782074276.0
        for <linux-pm@vger.kernel.org>; Thu, 11 Jul 2024 03:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720693528; x=1721298328; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DlpZ/OTR5qscLu5EXWghVwW22SxuPFyQQtYdKuqc7g8=;
        b=ihAzPdscnmERr8gpfrIOKowlwYKmTzxebbssJEAbdjiapJuxO7e00wJAj944+h4fJB
         U9S89hTywxRWFo3HoklxfdW44NhNkfdJ7nT2agqI98cVEU2mIPAF9GmdwYq+y0m1SUG/
         dIf3a4/eYNPvQMfZNfKWKx5AkLG32AsILVs63VX5/Mn4JJNVK21iBvvomGy4iysl86lU
         ESM4h8H0ZEEh2xTY2ppRyLN7a2cCtIUGGc2quX4/1XCfLLymbYmCWVQWac271LVW6x8a
         iRnJShy3e2EoM/4ISjnFgV0uHyTWBzqXfJZGyCW9r+JH4k5ezyy9U1AakfVUN17cnPD4
         XS8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720693528; x=1721298328;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DlpZ/OTR5qscLu5EXWghVwW22SxuPFyQQtYdKuqc7g8=;
        b=l06JQyeJXlLqnaXSp+oVEqsRIy9of7SqWreq2AyNChNO/syvKxnjb79rjsg20/PAi0
         6Xuc8DeQOOujPIeP45HDxYj2JUqgMYCiOQxspoxlNweFKAs9fYfglatxZwxb/eZGomCz
         /eynZdikCj+A+fur1AuNmVqgUyZm3OXw0uGr+LIyRJmTXuB0mAK7dR4sM3qhXGW0v1ek
         BKjYBS9VuW2Ox4sKnlRD0XkHDM2TumVqLtj1YviHb87wmj3MZUnuuNl7VfF1bKPW0eZN
         QR7O/CDp1uPKG+eZhro57p9ydug/ALYn4i+TghBmilPseV8Ppk/e6RvrFkm+5EQg8k+a
         wGhA==
X-Forwarded-Encrypted: i=1; AJvYcCV66OwaO91vBFZysoxF/ereXWOsmRriNA5Abbq+i14fT8JThqhgL24LPgn5NWptxdZeU9tkf+gjF4ntQvCt39dMZq+/oJ3TAEY=
X-Gm-Message-State: AOJu0YwfzZhQI+0MVwaDjsPl1nOMuaUFfY+UBqueYMyejP6/tXmmuwSB
	4r8hfdmYQ5OLvYbY2fFwib6ts/QCIjPmETc3extL3idE9a74svZJ/uGFFAllZWNce3DvvkZHhDN
	CJ4WrI8x9enk0Y6N618M5Xr+m95qX96T6vAR+aw==
X-Google-Smtp-Source: AGHT+IFn8JNB8GDuOWveohh4ChMy4uvZD9tdOFkxkLXLEOa387JXIWvPEeAZNjgDWQDzVWwMg1p4oYxsvRqB24furag=
X-Received: by 2002:a25:154:0:b0:e03:4666:6a5a with SMTP id
 3f1490d57ef6-e041b07d3e0mr9847464276.39.1720693528061; Thu, 11 Jul 2024
 03:25:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619140849.368580-1-ulf.hansson@linaro.org>
 <20240619140849.368580-7-ulf.hansson@linaro.org> <20240626063726.zsnj7iasl4y7ic2d@vireshk-i7>
In-Reply-To: <20240626063726.zsnj7iasl4y7ic2d@vireshk-i7>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 11 Jul 2024 12:24:52 +0200
Message-ID: <CAPDyKFqOdG9t0OU=k1u0=yk0vUhNSpidCKqvxMu0q6KQd26dkg@mail.gmail.com>
Subject: Re: [PATCH 6/7] OPP/pmdomain: Set the required_dev for a required OPP
 during genpd attach
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Nikunj Kela <nkela@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Jun 2024 at 08:37, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 19-06-24, 16:08, Ulf Hansson wrote:
> > @@ -2393,8 +2392,7 @@ static void _opp_detach_genpd(struct opp_table *opp_table)
> >  static int _opp_attach_genpd(struct opp_table *opp_table, struct device *dev,
> >                       const char * const *names, struct device ***virt_devs)
>
> I was expecting that we can get rid of this routine completely and OPP
> core won't be required to handle this anymore.

Yes, it's the next step. To enable that, I will first need to move the
current users of _opp_attach_genpd() to use the new
dev_pm_domain_attach_list() instead.

It's pretty straight forward, but I decided to make that as a step on
top of the $subject series.

Kind regards
Uffe

