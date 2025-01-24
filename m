Return-Path: <linux-pm+bounces-20911-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8F4A1AFC1
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2025 06:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 730F33A8BAB
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2025 05:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AC7146A79;
	Fri, 24 Jan 2025 05:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sKUdHu1U"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F1717E0
	for <linux-pm@vger.kernel.org>; Fri, 24 Jan 2025 05:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737695720; cv=none; b=YbgOnmvbTeylmco1f7VCTnKyZY0KHpM0vsZAmxRbV2u1gSjIXhMjtbFHXOdHSf3jWjiGovVl9PhToLPR1JCBBtBptbLathK36pbS2zh5//fb6AMawcny29Kr4ZLQoB6CWDrswKxUy8r3VonwywhF4juNWDBKZDZuRJ1jpFhRMrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737695720; c=relaxed/simple;
	bh=C94Z0eniOrhY8vfSK2Shz75ZMGzMu8k4tzHOc3eDo0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JwxirnfYYMniwggesR/NRVFLWn3XijZZ7zjyhIXY+sEGIWihv/wWkUcbA+B3qAbu8wkBA+Q+pkZlUb9p+RafQqV5iM4a0VaKThQpzSehn41/quTAutgz/FnyuxwPOq8r1CtAJ5XKAFSIHkvIQk40iJgkGZFlMoDbuFx7CSwO3G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sKUdHu1U; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21a7ed0155cso28989205ad.3
        for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 21:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737695718; x=1738300518; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5V8IjvQyQoDv88IF/KIjDx1xtX5os/gbeTbjuMxwHYo=;
        b=sKUdHu1UozfZdnDVbbLT9DjhSSA24jndPO1PJVFU9WaZ5Jv3vrPk0TNsW953poesQO
         /g2ApDpYIN79R+ihLEGORpgbe0PAm36Q+PpiEi4+uW2BIx73bI7555019oOvuQSEHv4s
         LLemgnjCWVogoZgrDU95dQnTSDVJ+Mri6rLv62xLFpV5DE68JT18ro1VbnNB0pcMLHlZ
         c61J0E00KsRfIh7dkk5sr9EpE5TiASGN6/7SbgIM+TeeV+8vdc0TCuG4cPZD2broyb4o
         xdc59wQDpcXKSt8tfug4Um81MGcoxbZheZ3XH1+/L8ZR74BA+JCRs6uw1eFXVVnfmQOi
         OwJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737695718; x=1738300518;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5V8IjvQyQoDv88IF/KIjDx1xtX5os/gbeTbjuMxwHYo=;
        b=RK2m0aRwYZ1dBJ7gPFDH+WeRJ9bFIQKspauehKliMn2hdJKnmBCG2KYeOPQqeq4KFO
         RlMoxL1FshWMGcwxH9FPYZkAK19+nYiNciPTvR0O3Wd1gpONsNEmOi1gtzqdccoCf3cN
         00FOpVC/KjYOJR4G7wMMvrlq1WfHHOYRNMU4SpaDjoh2V/qe6kf3jnJ+mTIgUNT5GJWo
         gxuxPq22wqh70POMkhD036Px+bc0hE4yz50Gx8Jmokb7C03KlB10jgCJGs15rtmVJyDR
         q2Gj0+b5jJSahKV/BX9RaIyUlEuAr/LEcs1NNjP06CYWUBbrsBLHR8tXZxTDHjMe48/5
         WbXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXK4b0Lrn4NyanMkuTUNBZosIoSvQ3wT02LTkaZcsw1nIqODI8SbRGN7nFmZoMBWLQMpjoR4Op0sg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAHFG2LdpTFWA4wwu1u0xRlTo4/HxZNAOoPf2rkotJShyRUcyy
	UXpyE1g+Hk0Jv684N0dA0h3GV0Ljjutypl6HBWcTRIH0y3S0RF1oD94ZAzFgXQ==
X-Gm-Gg: ASbGncvQRomBq9jnFZXCs2CfDlY5XGn1tAqxUzbrJGi7Oj7aF6dd6Dt5t25Dupu7l1K
	1Xca7gsj4529RStn7rwE0kfK6Mj66byeikTtjBvuuXXAeK4MJJCcZEooksIxeb7RGoVa79fYyYZ
	tVE46+UKdhViZmWE2g0gL3c17l16Y3Rneeg4ITmpD+6Oa6DYcj9I3/TXNRV3HFLA9udETc5oR0H
	zrfUqiLVoTe73O+XxQKgoZytYnSIf4fXQpgXQsjqdAJRAOnqNCnGI543CuYadLKEvRiF6Zc8oQE
	O8C/wT4/r4qYFPU=
X-Google-Smtp-Source: AGHT+IEDPeDAS7uVIV0ZkrrydW8dzxtvB6pScgknE489KkEpgCZmqJC4AgG/7nH7vooXPlAoLJr2Sw==
X-Received: by 2002:a17:902:e54d:b0:216:39fa:5cb4 with SMTP id d9443c01a7336-21c3556155cmr444408595ad.25.1737695718282;
        Thu, 23 Jan 2025 21:15:18 -0800 (PST)
Received: from thinkpad ([120.60.136.37])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da3ea2844sm7898155ad.57.2025.01.23.21.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 21:15:17 -0800 (PST)
Date: Fri, 24 Jan 2025 10:45:09 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Johan Hovold <johan@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
	rafael@kernel.org, ulf.hansson@linaro.org,
	Kevin Xie <kevin.xie@starfivetech.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Markus.Elfring@web.de, quic_mrana@quicinc.com,
	m.szyprowski@samsung.com, linux-pm@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [PATCH v7 2/2] PCI: Enable runtime pm of the host bridge
Message-ID: <20250124051509.djzjoml2zcq2xvvz@thinkpad>
References: <20250113162549.a2y7dlwnsfetryyw@thinkpad>
 <20250114211653.GA487608@bhelgaas>
 <20250119152940.6yum3xnrvqx2xjme@thinkpad>
 <Z44llTKsKfbEcnnI@hovoldconsulting.com>
 <20250120152829.7wrnwdji2bnfqrhw@thinkpad>
 <Z4-eufq4M04XHjck@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z4-eufq4M04XHjck@hovoldconsulting.com>

On Tue, Jan 21, 2025 at 02:18:49PM +0100, Johan Hovold wrote:
> On Mon, Jan 20, 2025 at 08:58:29PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Jan 20, 2025 at 11:29:41AM +0100, Johan Hovold wrote:
> 
> > > I'd argue for reverting the offending commit as that is the only way to
> > > make sure that the new warning is ever addressed.
> 
> > How come reverting becomes the *only* way to address the issue?
> 
> I didn't say it was the only way to address the issue, just that it's
> the only way to make sure that the new warning gets addressed. Once code
> is upstream, some vendors tend to lose interest.
> 
> > There seems to
> > be nothing wrong with the commit in question and the same pattern in being used
> > in other drivers as well. The issue looks to be in the PM core.
> 
> After taking a closer look now, I agree that the underlying issue seems
> to be in PM core.
> 
> Possibly introduced by Rafael's commit 6e176bf8d461 ("PM: sleep: core:
> Do not skip callbacks in the resume phase") which moved the set_active()
> call from resume_noirq() to resume_early().
> 
> > Moreover, the warning is not causing any functional issue as far as I know. So
> > just reverting the commit that took so much effort to get merged for the sake of
> > hiding a warning doesn't feel right to me.
> 
> My point was simply that this commit introduced a new warning in 6.13,
> and there is still no fix available. The code is also effectively dead,
> well aside from triggering the warning, and runtime suspending the host
> controller cannot even be tested with mainline yet (and this was
> unfortunately not made clear in the commit message).
> 
> The change should have been part of a series that actually enabled the
> functionality and not just a potential piece of it which cannot yet be
> tested. Also, for Qualcomm controllers, we don't even yet have proper
> suspend so it's probably not a good idea to throw runtime PM into the
> mix there just yet.
> 

There are multiple pieces needed to be stitch together to enable runtime PM in
the PCIe topology. And each one of them seemed to be controversial enough (due
to common code etc...). So that's the reason they were sent separately. Though
I must admit that the full picture and the limitation of not being able to
exercise the runtime PM should've been mentioned.

> But, sure, a revert would have made more sense last week. I guess you
> have a few more weeks to address this now. We can always backport a
> revert once rc1 is out.
> 

Sure. I've pinged Ulf offline and he promised to look into it asap.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

