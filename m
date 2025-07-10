Return-Path: <linux-pm+bounces-30597-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 488E5B006AD
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 17:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B2186405E5
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 15:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE33D2749C5;
	Thu, 10 Jul 2025 15:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="K5IayD9K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IgqoPP0F"
X-Original-To: linux-pm@vger.kernel.org
Received: from flow-a4-smtp.messagingengine.com (flow-a4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C9351022;
	Thu, 10 Jul 2025 15:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752161419; cv=none; b=fy2INEodJlThGZgPigvkYymaTYGPFzv2JPT2AhT7Mec3Ulo7Mf8DXcnkoKBOyzKn0Q0cJx+Udqqkb5RzhoUWGPdMp6Cn8N54YMP5kUEbk1cNi+3fjfBzM5CphXhWRZOeZfTZUFRswhXX1sbjatamSCtmGnKY+BfRzCFjAzo0WZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752161419; c=relaxed/simple;
	bh=Hx5gJn2ZSzuiEXr2+guVv+VH2sDXh3KjJ4gfQXoVnu0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=uAKVa5QyUxQtfrrOTmzRSOgCNgrC92rC2Z1+I6EDy1XloJcRrgxmsKRt2f0Qa11YjEHP2m/u50mje3qTwe4ZbPeVtQs3mRfOBMDQKamgt+yfc/WXa8fxwa8632F1eNUrCWn0B/UuWxfrBwHVBfS71njfel9tHDYJ/hLGg8wGr7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=K5IayD9K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IgqoPP0F; arc=none smtp.client-ip=103.168.172.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailflow.phl.internal (Postfix) with ESMTP id 381A81380AE6;
	Thu, 10 Jul 2025 11:30:15 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Thu, 10 Jul 2025 11:30:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752161415;
	 x=1752168615; bh=AYtsN1wjDw19ZCXecXpxbhgdbQXxdI7F+9XO8m7p4xo=; b=
	K5IayD9KBwVg1gILQlSHYjf3udls02vXkLBpptYge5R+R+Moivx7JYjl22TYks76
	MJH8LbhDcOvzsXHLaH85qaQHcqY0f6SKi4ujBYQGy4grm/wrr8E1uukFfTUvsCx7
	oPoshtq8kYgxKCx2jpvviQzA+BOtLvWSzl0/TFsmOoFmlUOYpgMVZSTdO/9Egv6g
	5H3Ts+my98W9tTSPwVOy8lpK1KcGMrhrJMjcNAaS8+JeBye5rYpvv8jwE4IoKtuM
	XhhrmHSFQtTrc2u/JTvdANK9onwYdaVuf3y5vQhTFrDGJHXAKxCs1ooAZNisUVMl
	tndsI+Stljm31W/4Xva6Lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752161415; x=
	1752168615; bh=AYtsN1wjDw19ZCXecXpxbhgdbQXxdI7F+9XO8m7p4xo=; b=I
	gqoPP0FBDqcwRSh6zLWTt/Z9BnBvNur3PAewb6oFv36a9jh72PICHYk9wxH2eKrF
	XjxUIlP+0KJncy+Enab0Ew2aFOKt+biVNHRGnw+eBQhVHSXZ+35PKxBdkj9tRALN
	HYZ3gIYEaWptzFjZeM8FAaY0Y8AZ3zcG7zuhTtfC2gDcbMQGlv4UDeMy5wJyrB8K
	nATDeSL1ZVsNMRITcODUQseF5pxaAv58JsFc34HNi89sxrk8YZ/9HhZXqMdkld8C
	9lCrmBM0g7M3Q2Jvt37Mzqu8RlMo9CO1wtfNaz0Z7n0RPhQqywCOS/+IcUIv36Xe
	E0ByL9bZvLnNDk98Dv4rQ==
X-ME-Sender: <xms:hNxvaP5PqC6uCz7DJF3Lf-he7nvOHA0FEA0lrKjfK2VEP1AopHSxew>
    <xme:hNxvaE5fpl_KeVc_G6wPTalZ8ewClXZijQQuODRJLAqp0tcTf-G2ovY-a4NNobMiy
    PhHRIep95lV-GAIrbw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegtdekudcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:hNxvaMVwMJ0kPtzMweGlqJFxtR32fCcqUjL93mxuIoFwYXvrvnK2-Q>
    <xmx:hNxvaMQ4vAzsbERXmbYESjJdniu1wS8rDqBkbmHGY2L4P478HeYn2w>
    <xmx:hNxvaIY3hERQ_hAy6KJIT2EFKx6z6XywTN0s7LmuU9zrS1399KoI_A>
    <xmx:hNxvaJeXcJ6YZPcxekqGAUX2QhMHZOy96w_vkJJZnkICTsn0o7RYyg>
    <xmx:h9xvaDX66XzA7KOwRJMm5KxJ8ZoExCuGvUSKgaK-nhr9G3NxT5ubYWGd>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 80820700068; Thu, 10 Jul 2025 11:30:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T1700ebcd39f54138
Date: Thu, 10 Jul 2025 17:29:36 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Shivendra Pratap" <shivendra.pratap@oss.qualcomm.com>,
 "Bartosz Golaszewski" <bartosz.golaszewski@linaro.org>,
 "Bjorn Andersson" <andersson@kernel.org>,
 "Sebastian Reichel" <sre@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Sudeep Holla" <sudeep.holla@arm.com>,
 "Souvik Chakravarty" <Souvik.Chakravarty@arm.com>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Andy Yan" <andy.yan@rock-chips.com>,
 "Mark Rutland" <mark.rutland@arm.com>,
 "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
 "Olof Johansson" <olof@lixom.net>, "Konrad Dybcio" <konradybcio@kernel.org>,
 cros-qcom-dts-watchers@chromium.org, "Vinod Koul" <vkoul@kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>,
 "Florian Fainelli" <florian.fainelli@broadcom.com>,
 "Elliot Berman" <elliotb317@gmail.com>
Cc: "Stephen Boyd" <swboyd@chromium.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 "Alim Akhtar" <alim.akhtar@samsung.com>, linux-samsung-soc@vger.kernel.org,
 "Wei Xu" <xuwei5@hisilicon.com>, linux-rockchip@lists.infradead.org,
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
Message-Id: <12c9a69c-7e27-4d43-9b1b-542e735176ec@app.fastmail.com>
In-Reply-To: 
 <20250710-arm-psci-system_reset2-vendor-reboots-v10-3-b2d3b882be85@oss.qualcomm.com>
References: 
 <20250710-arm-psci-system_reset2-vendor-reboots-v10-0-b2d3b882be85@oss.qualcomm.com>
 <20250710-arm-psci-system_reset2-vendor-reboots-v10-3-b2d3b882be85@oss.qualcomm.com>
Subject: Re: [PATCH v10 03/10] power: reset: reboot-mode: Add optional cookie argument
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Jul 10, 2025, at 11:15, Shivendra Pratap wrote:

>  static int reboot_mode_notify(struct notifier_block *this,
>  			      unsigned long mode, void *cmd)
>  {
>  	struct reboot_mode_driver *reboot;
> -	unsigned int magic;
> +	struct mode_info *info;
> 
>  	reboot = container_of(this, struct reboot_mode_driver, reboot_notifier);
> -	magic = get_reboot_mode_magic(reboot, cmd);
> -	if (magic)
> -		reboot->write(reboot, magic);
> +	info = get_reboot_mode_info(reboot, cmd);
> +	if (info) {
> +		if (info->is_cookie_valid) {
> +			reboot->write_with_cookie(reboot, info->magic, info->cookie);
> +		} else {
> +			if (info->magic)
> +				reboot->write(reboot, info->magic);
> +		}
> +	}

I don't quite see why we need two possible callbacks here, could
this be done with a single '->write' callback when you either
add another argument, or extend the existing 'magic' value
to 64 bit?

There are only a couple of drivers that provide this callback,
so it should be easy to just change them all at once.

     Arnd

