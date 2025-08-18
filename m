Return-Path: <linux-pm+bounces-32557-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA89B2AD26
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 17:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C82A684D10
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 15:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B504A27A139;
	Mon, 18 Aug 2025 15:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="iP4Z2NV5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SKC+/2vK"
X-Original-To: linux-pm@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E35271449;
	Mon, 18 Aug 2025 15:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755531672; cv=none; b=TxYG8lEdcvuiUngcmdbVt/CGbz7VNXPcMDJ8+et+EHEZztoUNRTWEvpOZf+3RIMkQJ03YHRTcjkJVtsXx0FeRfS0sVaSpU/96pEmhE45wac4gUmj22fvL8tbSCLDPUeqUi2Vi+I7nBJKu0M0NwWK3CAkLWXUkssdz53BL9NmwY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755531672; c=relaxed/simple;
	bh=ZsEcHhPxn/Ea9qTne3Rrj4zmGzqobeF0bv/BWvcqzD8=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=dNcJePt/PvVst1biYjWpqRVqFuK+Bz+xU4Kqcr5m04/pH5oachOizri4vz3OZu9Ly8iMgLf6X/ioTrgEI7SY+6MYarFyCUy2GIUHI6fRDufO5IJG36a99zycSkBoZWfMWH0NCGuHoMcZXdyLnealuYtSE1iWlKEAMExT0isw6Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=iP4Z2NV5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SKC+/2vK; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 478BC14004D6;
	Mon, 18 Aug 2025 11:41:08 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-12.internal (MEProxy); Mon, 18 Aug 2025 11:41:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1755531668;
	 x=1755618068; bh=vFW6QBRYfsq8CJmexn1lKzszzkLnWWDYygvjmw+xj+o=; b=
	iP4Z2NV5qm/hnVOJxy9SyYLvY/dsXSjjLa6z/jvNu3CAWSnEzYdfi5MCwbCBN/v8
	c2Jr/pr25VFyjUjAvZzv4Sk7rU3kjebgeaJ5wjYQQwaFqWpMt2Dic8tqYxJgOhKB
	GvPZT5SH3URDQkltuODuOwIaPf9IGU0svAfZC8BmCmzUSCKum91coh/adiZQBfD2
	Xkt7xgYLjW32yQEe6zozUwpqU3sJf4RmQnG9twkrw6CdGVL9YhKk3mhImgGsZHeu
	iZk9/fzbL7nLQTyJ0wGV4CPPyowkli7YhOptmxL5aNtqogS+gm0Gk8RnTzSkSoym
	EnpRT+LiiUg7URSHwxv1Jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1755531668; x=1755618068; bh=v
	FW6QBRYfsq8CJmexn1lKzszzkLnWWDYygvjmw+xj+o=; b=SKC+/2vKJ4XGhnf1j
	BdyBnQzLrEGR4Q+j4uhGDqkFECu6nylsjFwI4p0f7hCVBZpfJuuCcHAeuzaJoZ/f
	ZoQC6lrSjybbA5fwOJ/TV9sByTF4NI77pZyVaTfvNcN9ZpEPvyH7qZs9OHj54qV3
	IFF5nFZyUYIBOpBJznbjGuER2nLdsxjrnIW9C0szIcpmbiygidol3tgem+50qskS
	YDUDF9mQcOYSWhBFs79QMIzphEelnHHRLJFKYUXV4uqapb2JP3BtuewW2ltzTzD+
	aQ99MmydkCQSD+zHU64Oe2c4Qa6yL+hpkIquO/4Y5Tc6fIc68d3yq4JJfvvR9+7e
	Bg41A==
X-ME-Sender: <xms:k0mjaOhpLXz-tteDQFX8_BKxIizxChUXrQBYMnAoa0HOXOUurBDvDQ>
    <xme:k0mjaPCjUsbav8FxVbcUOnS5tKdCk2bgBHynOjhDHqP4ucANyPWECF45EZBZpj-5-
    BHxZnNwZHg14owFsK0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduhedvleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthejredtredttdenucfhrhhomhepfdforghrkhcu
    rfgvrghrshhonhdfuceomhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrg
    eqnecuggftrfgrthhtvghrnhepkeffuedtveekjeeukefgleejgeetleduueetudefudeh
    fefhheefleehheffffeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepmhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrgdpnhgs
    pghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepihhrvghnih
    gtrdhrrghjnhgvvghshhesghhmrghilhdrtghomhdprhgtphhtthhopegurghvihgurdgv
    rdgsohigsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepihhlphhordhjrg
    hrvhhinhgvnheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopeigihdrphgr
    rhguvggvsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohephhguvghgohgvug
    gvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehplhgrthhfohhrmhdqughrihhvvghrqdig
    keeisehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:lEmjaCR9TsVzoKeSgABiR6Gxu5h1BflUCI6cBmEebWezIFONMb1HNA>
    <xmx:lEmjaDfZr48tcMm2ZyyaeX-yfYUmHpLA09fZPTYxxMwR1UUFSDH39A>
    <xmx:lEmjaMTnL0zvNyLuHI1_LdV5VzG83wG08eXLCaU3A96hXER_mGqzEQ>
    <xmx:lEmjaHKebXfir9zdhnrRulo918yeLFaQgMDy2Nrzb9zorPG2eBGkuA>
    <xmx:lEmjaEXrVgPwPLARbhTrL8tqfiHM9RoJPGolHKULyiXnZni9rCrRuRIg>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DAC502CE0071; Mon, 18 Aug 2025 11:41:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AIq4ZBvdF6b7
Date: Mon, 18 Aug 2025 11:40:47 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Xi Pardee" <xi.pardee@linux.intel.com>, irenic.rajneesh@gmail.com,
 david.e.box@linux.intel.com, "Hans de Goede" <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Message-Id: <88da5769-1eae-4520-99b0-78a59bdbd867@app.fastmail.com>
In-Reply-To: <20250814195156.628714-1-xi.pardee@linux.intel.com>
References: <20250814195156.628714-1-xi.pardee@linux.intel.com>
Subject: Re: [PATCH] platform/x86:intel/pmc: Update Arrow Lake telemetry GUID
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Thanks Xi

On Thu, Aug 14, 2025, at 3:51 PM, Xi Pardee wrote:
> Updated ARL_PMT_DMU_GUID value. Arrow Lake PMT DMU GUID has
> been updated after it was released. This updates ensures that
> the die c6 value is available in the debug filesystem.
>
> Fixes: 83f168a1a437 ("platform/x86/intel/pmc: Add Arrow Lake S support 
> to intel_pmc_core driver")
> Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
> ---
>  drivers/platform/x86/intel/pmc/core.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/platform/x86/intel/pmc/core.h 
> b/drivers/platform/x86/intel/pmc/core.h
> index 4a94a4ee031e6..24139617eef61 100644
> --- a/drivers/platform/x86/intel/pmc/core.h
> +++ b/drivers/platform/x86/intel/pmc/core.h
> @@ -282,7 +282,7 @@ enum ppfear_regs {
>  /* Die C6 from PUNIT telemetry */
>  #define MTL_PMT_DMU_DIE_C6_OFFSET		15
>  #define MTL_PMT_DMU_GUID			0x1A067102
> -#define ARL_PMT_DMU_GUID			0x1A06A000
> +#define ARL_PMT_DMU_GUID			0x1A06A102
> 
>  #define LNL_PMC_MMIO_REG_LEN			0x2708
>  #define LNL_PMC_LTR_OSSE			0x1B88
> -- 
> 2.43.0

Tested this on my Lenovo P1 G8 and confirmed that it fixed the error message that was seen previously.

Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>

Mark

