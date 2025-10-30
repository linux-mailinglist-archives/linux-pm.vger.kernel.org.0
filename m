Return-Path: <linux-pm+bounces-37107-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 836E3C20892
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 15:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CED883B4F02
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 14:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF623218AAF;
	Thu, 30 Oct 2025 14:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="kcl2qSSA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FTuiSQWf"
X-Original-To: linux-pm@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A1418871F;
	Thu, 30 Oct 2025 14:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761833749; cv=none; b=FrgbY2iMHXO0yNq9Xw4Mpp62f0jlFWWU/TnvunU612aYd3ComuWqc8K6Oo+svoy3nECY2ilxuv5iiMDbMMCFrBF2WrJgEmQqloXCRufsUHJQHheIrSyk3Vch72ymQZGO/sKBxZPmOiujgXc7xrUkcxwQAAbPP7SkVPCBB403yxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761833749; c=relaxed/simple;
	bh=F1wgaTOkD9whISVF5RbNhnoqw8bQcf8E1idtCKjXn0c=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=JCvDRXYOzqTm6gB4X5gP9cceGGk0M0j6tkN5lkdNwvJ0I/XYs9sHPZIjxWciv0+OyBLe0bPJ5zl0KA1tb1FGmxy5K+GHTz83joFf89UmnAbLKTJszBndgSRClT5/C6K3VerE9bYc12qNu0rPuoOlEFyg8PPTGZ6DSKnN16CoV6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=kcl2qSSA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FTuiSQWf; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DD36E7A01F3;
	Thu, 30 Oct 2025 10:15:46 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Thu, 30 Oct 2025 10:15:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761833746;
	 x=1761920146; bh=Bcdffpiq94hB8xQFLbaa75mK7VRUJwUPjoKxC4ED+bI=; b=
	kcl2qSSAtF3mZhbe97M6Dj6HgbewNoFG7oN2uarAFQTo8kldZSrCpjYniL6b/H2L
	NhR/VJopzoMIQE3pVYn7qgYXPe4y6Ec663AS7DlxxYbHcjI/USIL09sMyCIUlm1w
	tch9WPw1lm1jaVRzUpLokjU9T1HuMLxeDdNcr2Zv3r0ZMdPK1GYx+8jcLmvfWKxb
	8R+qulj48mXobLodXMFobo0xnTYEGF3gqPaw+nb7IPpkfbl5clQ6D4i7F2w6C2yW
	JI7Js+DI7jPn31/HYb1fd2/cGSckTl1wFqt5wHPXl68PEov14cK5t5RVZOprzRXE
	5JhRrhZckueqBEQ+a0mhHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761833746; x=
	1761920146; bh=Bcdffpiq94hB8xQFLbaa75mK7VRUJwUPjoKxC4ED+bI=; b=F
	TuiSQWfsSlJ2Qc6wFBNF+VLftUhwqWMgKCDSpQ4tL9dt/M07mBUKnpeXvR7P3Gzl
	UeNAIBmQmN8ows+9MKIbQ/eW9KxKj8xCLH4MDsWePBbLkh1v9R2ttP8A5xMm1Clv
	Hx03RaFkzjxengpuFgEpVErD9XuXYViTyCxcTHXJZtBKzzVqaTHo8IT8jDjoW2HY
	zy9g1pYOlpu3ZL2WlEyvQOY6Aw6CYELvk5gVOoXyt3PvXZNrCg1mC2GhxF3tIJVn
	Wwo4v2oCNu6EUq6c16uNcT6J75pnHDQf0PFZ0o8aB16hx4iEkLBVkj+9OgeEds+y
	3nWMEqPriCzh6HXjrYUqA==
X-ME-Sender: <xms:EnMDacAUHjQ7s8n4OT8LC2fLtkaELROheJwYiohd1xq_tCbo6CvADw>
    <xme:EnMDaZUpArReTaVDo1hyFC_b-KvmUsTyd9v1R4pcHLVYo6o2hew9P57dODSAoVTif
    A6vjjpsbMbFDT602GN8fnGTjgoeRLpBg6gVzR_ALh9bLP3SsIZOjw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeikedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopegrnhhsuhgvlhhsmhhthhesghhmrghilhdrtghomhdprhgtphhtth
    hopehrrggrghdrjhgruggrvhesihhnthgvlhdrtghomhdprhgtphhtthhopegrnhguvghr
    shhsohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehilhhirgdrlhhinheskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepkhhonhhrrgguhigstghioheskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hvihhrvghshhdrkhhumhgrrheslhhinhgrrhhordhorhhgpdhrtghpthhtoheprghnughr
    ihihrdhshhgvvhgthhgvnhhkoheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtth
    hopehlihhnuhigqdgrrhhmqdhmshhmsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:EnMDacmlMpuu-l0sMG6dsWHIA9M9MuhWv19inlmsTKU7fKeVmTlcbw>
    <xmx:EnMDadZpfespG7-djx1OOlfUQQwP2vIE0cCFFIHzoyst6fqNDqSuYw>
    <xmx:EnMDaZ7qTl2BO3owF7pdQwXT5AZzG6UCw3mj1hvU5nZ5prreciPqMw>
    <xmx:EnMDafCqChq34ZTQ-aKKxmaCuWZ53_5c1oSxvC_CTrkNpr-r1ADDaQ>
    <xmx:EnMDacNcGCDgKGxuEWMDkx_uAURo653_e9L2XXIVrYarUCQaY5XI1Q0G>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 64074700063; Thu, 30 Oct 2025 10:15:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A8oaPjpzjt_R
Date: Thu, 30 Oct 2025 15:15:25 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 "Christian Marangi" <ansuelsmth@gmail.com>
Cc: "Ilia Lin" <ilia.lin@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 "Viresh Kumar" <viresh.kumar@linaro.org>,
 "Bjorn Andersson" <andersson@kernel.org>,
 "Konrad Dybcio" <konradybcio@kernel.org>,
 "Raag Jadav" <raag.jadav@intel.com>, linux-arm-msm@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <9f41aee8-49a1-4029-8b21-e4eafaa2e224@app.fastmail.com>
In-Reply-To: <aQNvjqJGqFO30JTx@smile.fi.intel.com>
References: <20251029133323.24565-1-ansuelsmth@gmail.com>
 <aQIzoGnvZWYuHuoQ@smile.fi.intel.com>
 <69023512.5d0a0220.3cccb7.8e65@mx.google.com>
 <aQMheocySykpTFDN@smile.fi.intel.com>
 <69033c55.df0a0220.1a33d7.49ff@mx.google.com>
 <aQNvjqJGqFO30JTx@smile.fi.intel.com>
Subject: Re: [PATCH 1/3] err.h: add ERR_PTR_CONST macro
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Oct 30, 2025, at 15:00, Andy Shevchenko wrote:
> On Thu, Oct 30, 2025 at 11:22:11AM +0100, Christian Marangi wrote:
>> On Thu, Oct 30, 2025 at 10:27:38AM +0200, Andy Shevchenko wrote:
>> > On Wed, Oct 29, 2025 at 04:38:53PM +0100, Christian Marangi wrote:

>> drivers/soc/qcom/smem.c:361:35: error: initializer element is not constant
>>   361 | static struct qcom_smem *__smem = ERR_PTR(-EPROBE_DEFER);
>>       |                                   ^~~~~~~
>> make[9]: *** [scripts/Makefile.build:229: drivers/soc/qcom/smem.o] Error 1
>> 
>> You want me to add this to the commit? Or any hint to better reword this
>> so it's more understandable?
>
> Just the first line would be enough.
> And perhaps better naming for the macro, but I have no ideas from top of my
> head right now. Ah, actually I do. We call those either INIT_*() or DEFINE_*()
> with the difference that INIT_*() works like your proposed idea. i.e. returns
> a suitable value, but DEFINE_*() incorporates a variable and a type.
>
> I think the INIT_ERR_PTR() is what we want as a name.

Agreed, that seems better than ERR_PTR_CONST(). I'm still not sure
there is much benefit in using this in static initializers, but
I don't mind it either.

    Arnd

