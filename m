Return-Path: <linux-pm+bounces-11738-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D459428F6
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 10:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 320671C21A87
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 08:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0571A619D;
	Wed, 31 Jul 2024 08:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pAY9rbDD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vzJunEWV"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AA91AA3D8;
	Wed, 31 Jul 2024 08:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722413753; cv=none; b=trNEqpaW3fxfrFmHKw8OgF4MUj83z0di4blv/d6DDCi06fMHVdDYaHjT2HAqVDBLeAEEohXSeqAw1Q8MCZw4Lrk+WdbjYiYkhoZCAIbU086U+KspIirk43yTBXbT0+tuCVTsIGyYj0qdc4yBudGj0D/TXc9cPdk3gIW+z91ujTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722413753; c=relaxed/simple;
	bh=ujDUydSBlYsg5GrmI0xaTxj5ebbYblUl2PX35n6FkHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NIuL73N/4aGSirZiuFCEIAj1Jua300cQRG3Mx/lV41oU0M+yEPvcHneyXSuCPajjbTBXkjuTvgkDMnxt93x99GjoWoocx0Hb/Htck9VZIh4qqRUcqeeDAplf4N6evkFLm2RyRTImHbuCBJa7q5kpeqh1+sydC3NdIySAZ2Atjxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pAY9rbDD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vzJunEWV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 31 Jul 2024 10:15:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722413747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wHfpDFKYfXVSLFvs3jCaqIecOI4X865C7851E2FUNDg=;
	b=pAY9rbDDLe1l+dSc90w1xJGp1M2SMJ/8HAE/033J/dGSBKgY4e2pPmvBK8vV5MOyAxKiUU
	JN2hrAMxzzoWSmtQVPYt5VLzNxPpvDAzOXtrJtnRZiveytLkfYMGCK56WNyL9UyFiNbfkM
	8ifFUTtUd3hFh71yHnscGF+S2vXertQiPBm1E+tHqlfPxLK1KiagnNUAyPdXYMqKbUvwgA
	6yAqbnjga8skHZv2Sq8CznRu1VqGBdeHxWYuw/Y489yP/9LJDKbi8TQ6WrjFf6eK1mRDTe
	ul/I86Ad/owDrb2bcQwQjLojXNwhC3SR+Xl224Fzgmphi8nmNcdHHLFvmm48iA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722413747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wHfpDFKYfXVSLFvs3jCaqIecOI4X865C7851E2FUNDg=;
	b=vzJunEWV58BM7hh3ifhyzihplE5GpLl3bYbiCG8CvmluTbUYpQuAqqqHwhPtrC0JT+9kbp
	d4jD73b7w7sx+oAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Nikunj Kela <nkela@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>,
	Maulik Shah <quic_mkshah@quicinc.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-rt-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] pmdomain/cpuidle-psci: Support s2idle/s2ram on
 PREEMPT_RT
Message-ID: <20240731081545.lKpm84qE@linutronix.de>
References: <20240527142557.321610-1-ulf.hansson@linaro.org>
 <20240708135310.3VRFnmk1@linutronix.de>
 <CAPDyKFo6hE9BPgS7Bhe259Mxki-KBZDYyMkaBPFuznETbZhGkQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPDyKFo6hE9BPgS7Bhe259Mxki-KBZDYyMkaBPFuznETbZhGkQ@mail.gmail.com>

On 2024-07-09 17:31:12 [+0200], Ulf Hansson wrote:
> 
> Thanks for taking a look and for providing your thoughts. Can I
> consider that as an "ack" for the whole series?

Yes.

Sebastian

