Return-Path: <linux-pm+bounces-20696-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC49A16F38
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 16:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9F4418892E9
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 15:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDD41E5738;
	Mon, 20 Jan 2025 15:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e/SFFPdp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868E61E5714
	for <linux-pm@vger.kernel.org>; Mon, 20 Jan 2025 15:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737386920; cv=none; b=miW/lnuzcUsYudOekP2zoAA37U9P97p0jd45FgGSLiH/DI6qeRcgwzqKx6JyU/r5xnM1cJcYBzthvsV+NoEKkDazVnUCEp5N3xpi7CyEKVU9XJOwxbqXuOnVQ7wO9m91BkMelemhkHtgpPQJDJkfn57w07FOF8RfSirE9IXytd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737386920; c=relaxed/simple;
	bh=VAWkKFMuuvGFwc4lV9U8KFWWhfAs+x3tBpzqXY33AtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2BcQFc4kLe2pBSiLAVzJxQQemrwo3jSQuS79SOUGFIGuH1dB4wjBcxCQbiR0lVQDWXkrp5p6ya+xDjGorEYodcnuqfdqrt5SO1XBvycKbmuOK5kHLQdmm0Slc3mGxLT6I+U5xbOgxh1o1Qi1cH66x2iTa0nVKtXbmURJE6GJlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e/SFFPdp; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2166f1e589cso111107835ad.3
        for <linux-pm@vger.kernel.org>; Mon, 20 Jan 2025 07:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737386918; x=1737991718; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ge/AXIemwm1awQOTNlXpVZkK91To9JlcVieMAvqiKWA=;
        b=e/SFFPdpfCxKnQ9Uhigb5Oa7CjJ6r5xJjQaUJpKjJXzBhBRKQRwV2kHerHuoJGmXBq
         9fcWEIDZwaiM3KYLGKP5pqn2MygkXutilbNUQ6MEbpSlp5LolD4kNH4fwqcS1xLgWPIX
         8BR6Bn5/MWoqlb633frJ8QJLrdM40Cehh6qvgQHZLS+Gt3/G14rDQjDerVpcwoIFNByp
         2bplpGiz/L2BOKUgEWS2jPeKq9dp3MyHT4BAz02cq/oLLy6IVjJIBi8Q4zvsdY8Ohffx
         OfPyV4OIjUG/jZ1alp8WDm2fpxy3AwALDtF9uConNkF7ZZfxFym8JKuj8vul98gDtsrr
         8d8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737386918; x=1737991718;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ge/AXIemwm1awQOTNlXpVZkK91To9JlcVieMAvqiKWA=;
        b=mq+kesLwbuElGXzVO6vMTMZqJYm8kl8d4tupl2dvgt8dLZCjif6CyUO2gDUM4YI3+X
         8f0raz8zCDQLiWAW901c0f4+lQWNQr/H/RsyLVT9nWAzqsoOgp2b3FX2zAE+2xfnMRmg
         BxNvoxfRDYRzS5EMFHp3craFsTZpPtoFK9/Amd9Xjp5XM1KAW9oIlo91zA2vKFkivXbs
         jO+hKyb5YYAjzQ9Wg2U/VvyMbYNcxxcdn+fWtJGy6a35U9cLKbeVzUNuKoX1S6EV7xnt
         TXruiAOqjJf7/nkXPs1t81Y1/O0ty9XyWV81fkZUC2WL3J5FgTinutq/rjrm9Wnq6PLz
         Ltiw==
X-Forwarded-Encrypted: i=1; AJvYcCXNidP+SKVhx6RVt8mj6TMVK7nlQDW5BttL8rHp5O6JulOEUwAHdLsyBY144ciq84lci5yooznIbQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yys4IjrLDwUOSdblNoB4qxPpcJ7BfHgjHMVNtTDcqBM+xCaN6ky
	JIswyXS7XBQgwRaQB0uBVjPlDsbXLd58n8B/wRBMWfo/dRu44UL0Vw6Cn2XJUg==
X-Gm-Gg: ASbGncuR+R8yiBl3FfJm8yoBspjRXnuYyIaQI03oyjOaUbOMG9+BqpAuUX94HyxFxGs
	voY/35jf3jndjip5s6hdRiLL7tjgSgD5+DNLl165fVTFkQbDmEPIAgkpqa/UH4donlv7toi4nVw
	qgaj7eKPWMbPY5LwzT7O6U1QvFO5KgRtU3AZ2e7R0AZsMlYiQscSts1Pib9E9rGahXVZKpjVvnc
	LbcrK0syKK1KNJ1TP3VX3KBbkbsKQhez7muJX4Pi6pdhek+o0HOr5drBox52oAs4YpciMeYaLUz
	WNgYfx0=
X-Google-Smtp-Source: AGHT+IFEYzzBuALfLBnZY/0Oioq2g+BcnanbnfQw4KIaV+WjpwymnqzEgNX6z1yArWAvcbtux5os8A==
X-Received: by 2002:a17:902:e546:b0:216:281f:820d with SMTP id d9443c01a7336-21c3553b6famr223740225ad.11.1737386917771;
        Mon, 20 Jan 2025 07:28:37 -0800 (PST)
Received: from thinkpad ([117.213.102.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2cea2caasm61864755ad.51.2025.01.20.07.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 07:28:37 -0800 (PST)
Date: Mon, 20 Jan 2025 20:58:29 +0530
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
Message-ID: <20250120152829.7wrnwdji2bnfqrhw@thinkpad>
References: <20250113162549.a2y7dlwnsfetryyw@thinkpad>
 <20250114211653.GA487608@bhelgaas>
 <20250119152940.6yum3xnrvqx2xjme@thinkpad>
 <Z44llTKsKfbEcnnI@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z44llTKsKfbEcnnI@hovoldconsulting.com>

On Mon, Jan 20, 2025 at 11:29:41AM +0100, Johan Hovold wrote:
> On Sun, Jan 19, 2025 at 08:59:40PM +0530, Manivannan Sadhasivam wrote:
> > On Tue, Jan 14, 2025 at 03:16:53PM -0600, Bjorn Helgaas wrote:
> > > On Mon, Jan 13, 2025 at 09:55:49PM +0530, Manivannan Sadhasivam wrote:
> > > > On Tue, Jan 07, 2025 at 03:27:59PM +0100, Johan Hovold wrote:
> 
> > > > > > > I just noticed that this change in 6.13-rc1 is causing the
> > > > > > > following warning on resume from suspend on machines like the
> > > > > > > Lenovo ThinkPad X13s:
> 
> > > > > > > 	pci0004:00: pcie4: Enabling runtime PM for inactive device with active children
> 
> > > > > > > which may have unpopulated ports (this laptop SKU does not
> > > > > > > have a modem).
> 
> > > What's the plan for this?  Does anybody have a proposal?
> > > 
> > 
> > TBH, I don't know how to fix this issue in a proper way. I need inputs from
> > Rafael/Ulf.
> > 
> > > IIUC there is no functional issue, but the new warning must be fixed,
> > > and it would sure be nice to do it before v6.13.  If there *is* a
> > > functional problem, we need to consider a revert ASAP.
> > > 
> > 
> > There is no functional problem that I'm aware of, so revert is not warranted.
> 
> I'd argue for reverting the offending commit as that is the only way to
> make sure that the new warning is ever addressed.
> 

How come reverting becomes the *only* way to address the issue? There seems to
be nothing wrong with the commit in question and the same pattern in being used
in other drivers as well. The issue looks to be in the PM core.

Moreover, the warning is not causing any functional issue as far as I know. So
just reverting the commit that took so much effort to get merged for the sake of
hiding a warning doesn't feel right to me.

> Vendors unfortunately do not a have a good track record of following up
> and fixing issues like this.
> 

I'm not relying on vendors here. I am looking into this issue and would like to
fix the warning/issue on my own. That's why I shared my observation with
Ulf/Rafael.

> Judging from a quick look at the code (and the commit message of the
> patch in question), no host controller driver depends on the commit in
> question as the ones that do enable runtime PM just resume
> unconditionally at probe() currently (i.e. effectively ignores the state
> of their children).
> 

Right. There are a couple of pieces that needs to be fixed to have the runtime
PM working from top to bottom in the PCIe hierarchy. This is also one more
reason why I believe that the commit wouldn't have caused any functional issue.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

