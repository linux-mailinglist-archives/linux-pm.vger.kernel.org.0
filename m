Return-Path: <linux-pm+bounces-30693-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA2CB01F63
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 16:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D66717C018
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 14:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B682D29B7;
	Fri, 11 Jul 2025 14:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="WDGJzIpw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kf5ZIUcC"
X-Original-To: linux-pm@vger.kernel.org
Received: from flow-b7-smtp.messagingengine.com (flow-b7-smtp.messagingengine.com [202.12.124.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552B36ADD;
	Fri, 11 Jul 2025 14:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752245097; cv=none; b=FtDhBpfcmCeE3SZTiex3QKGjUlDSY7LhOIUIIJ+EHjhzQbUiXJwlLroQZG0Ef3ZPvmFh4FFGsoUevIZGU6uIoQkQE3H6BapWrz8zdsy8LoJYf9QHPIdjkzNZbeFCh0tovOs3yR5hDGqoDwJzNKp1zXUsaRHKfrONWiSgtocpTlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752245097; c=relaxed/simple;
	bh=tE17wqTp5bia7rZXKcjZwP/QLaLxvidWPP68VRIypG0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=TXDCKHbB5ExbRT3gk5UQ9Mvkw4ffktaFIlWVsxHgTZYARrN10+zYuPwHtBx9A/yhAsJ20M2KHtMsuAfIB/zKHSZJqrI8/Qs7e1+VXx6+m1CP5U+02nAq18zh5zHtTm4eoZcC4EfwiyutNuMzsZwcYVJB2b29i/tJMr49CKES+jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=WDGJzIpw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kf5ZIUcC; arc=none smtp.client-ip=202.12.124.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id ECDA41300588;
	Fri, 11 Jul 2025 10:44:51 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Fri, 11 Jul 2025 10:44:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752245091;
	 x=1752252291; bh=hkFSXr7AU4WvmRzO82oca+vfaj/I9fJ285U+GlYMs4Y=; b=
	WDGJzIpwx45Q6sqhljeaGH2cOTdluGUt24Ot4wUGxawP4eTO1H9k4pflkdGWEvB3
	VWNVb6H3IA5D6yP6J6o65PYmbVtj0XG7bDroUx5Mrfo8u5atRVyv5+krwpkb0XI0
	W8VMgEB2O1WYBsRFlOhqPv9wSsp3SlUP9hzhulqdKbUQxKHSZ6XPNcQffiekdA2E
	ewOAoROdJ68hKcSmbBg147lb7m1RY446qKkssUPRLSbgOfdNZg8CgasIxYV/tLs3
	81S8lriNz7Ybj+/QTXe7Ib4sdjo3Ox77REKYHRXCyi8fqkqTq9Fp9tBEGv7Vi2rA
	u0ozRr7nQSZ982SS69XSQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752245091; x=
	1752252291; bh=hkFSXr7AU4WvmRzO82oca+vfaj/I9fJ285U+GlYMs4Y=; b=K
	f5ZIUcClhfndy6bg0ErwfbauVr1PYBBIIEkkX0qMxOE6m9/I9BqyEg7lDZQIbaJD
	24DJw98ecPKnEZZZ+4J04iSq1mbYn75GAA8dntf2p6cQMTsh1wNi+vycdNRRFcJm
	GxECjfikZJFsfksv3qHQDNLyiVk4o4GWqc3BRk+W8t65kPasbxP358C5naNbYe68
	GmAiAuYtwlGIKqiVPtsiV/JhgByRsgLtIlrpIvDftAfQSYGX2Jh5f9OhpoFx0Gwd
	Kubx5EeitgcW7c54xY4XVUAzFvUyKCFZVgZim8Gh7u7ipCeB+LSVdZk+mNcdGBTe
	nufnpqtsC6TbjwU3pn2XQ==
X-ME-Sender: <xms:YCNxaFZClDNB8V8d2nAY_Ew4n9dxS66oEtyoWWiM3qBWaC9jhuGo0A>
    <xme:YCNxaMae9yxxOrDU5MguHRWe4ID5My4nit7k0UfizUfavF3zgEwVdu61IxG90rZTG
    mjD0D4KKsWAaNWMm0M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegfeeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeegfedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepshhouhhvihhkrdgthhgrkhhrrghvrghrthihsegrrhhmrdgtohhmpd
    hrtghpthhtoheptggrthgrlhhinhdrmhgrrhhinhgrshesrghrmhdrtghomhdprhgtphht
    thhopehmrghrkhdrrhhuthhlrghnugesrghrmhdrtghomhdprhgtphhtthhopehsuhguvg
    gvphdrhhholhhlrgesrghrmhdrtghomhdprhgtphhtthhopegrlhgvgigrnhgurhgvrdgs
    vghllhhonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepsggtmhdqkhgvrhhnvg
    hlqdhfvggvuggsrggtkhdqlhhishhtsegsrhhorggutghomhdrtghomhdprhgtphhtthho
    pehflhhorhhirghnrdhfrghinhgvlhhlihessghrohgruggtohhmrdgtohhmpdhrtghpth
    htoheprhhjuhhisegsrhhorggutghomhdrtghomhdprhgtphhtthhopehssghrrghnuggv
    nhessghrohgruggtohhmrdgtohhm
X-ME-Proxy: <xmx:YSNxaF0GQ2fa_1SuFfOdOhuhu0Zy36UfpH2r-1ugIAx3Raw8Lckepw>
    <xmx:YSNxaHx6LIEqH4Y9FZ15zgykV3RRQn0SymX0zo76bvrZzyGy6X62gw>
    <xmx:YSNxaN6C-9gfSyFHrY25SMmGx_DUe4WBzIiGs4pI1tGLmBcVJAj_Tw>
    <xmx:YSNxaA-8DMjc745DJxU5J0QF345BoWMq-R8duUpQzgRO49VjxMVCaQ>
    <xmx:YyNxaHIvxWMwaZjAcDljwq14_YEVEBsGlu7kFX79ffc30VsP2_yKMSEg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DC056700065; Fri, 11 Jul 2025 10:44:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T7b8765a73c29189d
Date: Fri, 11 Jul 2025 16:44:28 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Shivendra Pratap" <shivendra.pratap@oss.qualcomm.com>,
 "Rob Herring" <robh@kernel.org>
Cc: "Bartosz Golaszewski" <bartosz.golaszewski@linaro.org>,
 "Bjorn Andersson" <andersson@kernel.org>,
 "Sebastian Reichel" <sre@kernel.org>,
 "Sudeep Holla" <sudeep.holla@arm.com>,
 "Souvik Chakravarty" <Souvik.Chakravarty@arm.com>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>,
 "Andy Yan" <andy.yan@rock-chips.com>,
 "Mark Rutland" <mark.rutland@arm.com>,
 "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
 "Olof Johansson" <olof@lixom.net>,
 "Konrad Dybcio" <konradybcio@kernel.org>,
 cros-qcom-dts-watchers@chromium.org, "Vinod Koul" <vkoul@kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Will Deacon" <will@kernel.org>,
 "Florian Fainelli" <florian.fainelli@broadcom.com>,
 "Elliot Berman" <elliotb317@gmail.com>,
 "Stephen Boyd" <swboyd@chromium.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 "Alim Akhtar" <alim.akhtar@samsung.com>,
 linux-samsung-soc@vger.kernel.org, "Wei Xu" <xuwei5@hisilicon.com>,
 linux-rockchip@lists.infradead.org,
 "Baolin Wang" <baolin.wang@linux.alibaba.com>,
 "Sen Chu" <sen.chu@mediatek.com>, "Sean Wang" <sean.wang@mediatek.com>,
 "Macpaul Lin" <macpaul.lin@mediatek.com>,
 "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>,
 "Ray Jui" <rjui@broadcom.com>, "Scott Branden" <sbranden@broadcom.com>,
 bcm-kernel-feedback-list@broadcom.com,
 "Nicolas Ferre" <nicolas.ferre@microchip.com>,
 "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
 "Elliot Berman" <quic_eberman@quicinc.com>,
 "Srinivas Kandagatla" <srini@kernel.org>
Message-Id: <454c8361-151e-42b3-adfc-d82d2af62299@app.fastmail.com>
In-Reply-To: <cdadd6cf-18c9-15c7-c58a-b5d56b53452a@oss.qualcomm.com>
References: 
 <20250710-arm-psci-system_reset2-vendor-reboots-v10-0-b2d3b882be85@oss.qualcomm.com>
 <20250710-arm-psci-system_reset2-vendor-reboots-v10-2-b2d3b882be85@oss.qualcomm.com>
 <20250710224740.GA15385-robh@kernel.org>
 <cdadd6cf-18c9-15c7-c58a-b5d56b53452a@oss.qualcomm.com>
Subject: Re: [PATCH v10 02/10] dt-bindings: power: reset: Document reboot-mode cookie
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Jul 11, 2025, at 14:32, Shivendra Pratap wrote:
> On 7/11/2025 4:17 AM, Rob Herring wrote:
>> On Thu, Jul 10, 2025 at 02:45:44PM +0530, Shivendra Pratap wrote:
>>>    All mode properties are vendor specific, it is a indication to tell
>>>    the bootloader what to do when the system reboots, and should be named
>>> -  as mode-xxx = <magic> (xxx is mode name, magic should be a non-zero value).
>>> +  as mode-xxx = <magic cookie> (xxx is mode name, magic should be a
>>> +  non-zero value, cookie is optional).
>> 
>> I don't understand the distinction between magic and cookie... Isn't all 
>> just magic values and some platform needs more than 32-bits of it?
> Need two different arguments. Will try to clarify a bit below.
> PSCI defines SYSTEM_RESET2 vendor-specific resets which takes two
> parameters - reset_type and cookie. Both parameters are independent and
> used by firmware to define different types of resets or shutdown.
> As per spec:
> reset_type: Values in the range 0x80000000-0xFFFFFFFF of the reset_type 
> parameter
> can be used to request vendor-specific resets or shutdowns.
> cookie: the cookie parameter can be used to pass additional data to the 
> implementation.

I don't see any distinction here either. As Rob says, you have to
get both 32-bit numbers from DT in order to get the desired reboot-mode,
and you have to pass them both to the firmware when rebooting.

The distinction between cookie and magic value may be relevant in the
context of the psci specification, but for the Linux driver, this is
really just a 64-bit magic number.

     Arnd

