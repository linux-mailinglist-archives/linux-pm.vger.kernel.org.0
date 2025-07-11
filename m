Return-Path: <linux-pm+bounces-30707-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCECB022BF
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 19:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12C7717D155
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 17:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A988A2F19A3;
	Fri, 11 Jul 2025 17:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="BNRI7qml";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kg/6aE9g"
X-Original-To: linux-pm@vger.kernel.org
Received: from flow-b8-smtp.messagingengine.com (flow-b8-smtp.messagingengine.com [202.12.124.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEC62EF66E;
	Fri, 11 Jul 2025 17:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752255585; cv=none; b=UFAQa6RP2R/hDRL/tZQN35sICawvQnh7rwhcaxSCSdbFOM0pM3iNZ6YRWJHkH+Mt6pvZqRnR2I1DcfR6tNGha3GgGGkKFGlB/TvnIX78m7DSiYqj8agptnY+yI14X8CW7Iu5gN7u6s6acMdZzmqkXYt3G0HGbg9qvLtDEy8mKgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752255585; c=relaxed/simple;
	bh=dxN5T4WkAVHPoUzZwiY+yrDiSgaHEZLUFT5ip3OenNY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=phJzEtcHALgDBpbKQliNAxbvQOXeah1rCZadEQsuC+cvXYOGf2DmiEMaf/cQ1YzC/mjGc6mJTnFgFV6RIZ9lEtHPm1PCa/iVE4/A8lgAdnrDw/QQyJj1L0tftTT0Q+jrqj4AUrOP1F20iHTrcv8ZsmCzgrxqvMRN5JEvWsc63a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=BNRI7qml; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kg/6aE9g; arc=none smtp.client-ip=202.12.124.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id F0F6C1300AE9;
	Fri, 11 Jul 2025 13:39:40 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Fri, 11 Jul 2025 13:39:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752255580;
	 x=1752262780; bh=/7nAQ8MFihVRjT4v6jCf4oIhuL2he8+p7e3TrE0+kYI=; b=
	BNRI7qml8FGqqjAjz4ECuSXh4sUCbOHlAfr9QmNo21rjBp7/dg/LIiLEY3xEKDYg
	fYjQ7KQL9lbUb4UoeEAhrzrsLxuKPySftGrqE6HRgMhm++bFQDJhzNHSjHy/0fRL
	tOxYfhllkHVoy6G99ytXT5Vm9F2GIJ4efWkE2UcQl5sMP+E1LDC/ytS1YsUnCjvE
	Y1V+Vm1U4IbvoVykZ8hRTHtrUnzXUuDwNikD1FlWtj43IDoCx4eJfuyDj1ZtaViC
	YA1mktP6p/K0wk7tUO7PDcvxTMh812zGXM7QCfj2yostqeHD4py0IqVBv+NGLEBD
	62Bd0eKpqVW/xRTn/tndcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752255580; x=
	1752262780; bh=/7nAQ8MFihVRjT4v6jCf4oIhuL2he8+p7e3TrE0+kYI=; b=k
	g/6aE9gWmA1nQ2IF5rhoo758cBW7YBIcJMB7Gxh3UOcFWttFsFuIiS3oMZGU0tAw
	f8KExaR9ijyYiaWaBux3y0iF7eaI7wGIKf5hbFw8j7nlNRM/ySiN8QKXw30/LPiT
	uw7bf3U8b6mmh3Ln5QZFuQmMM2RI71easRsoDwEu+XV4BbIq/XxXKDsJcrQNjtTV
	1qpyf/j4/hQQ9E78WwRx8NXZT0XIuOFe1MdZlMhkgEZsjotLENbKAD79el/JOXd5
	eYmfznEkTDoUmc2CCp8sugqZLXXyuQzj+kf5Emo+/hLI7xvZjJGflZGy/CxBstHh
	Nn2XRsVbXP/W44n9wKzwQ==
X-ME-Sender: <xms:WkxxaAy6ubjXTr4Nr3GqrLfMPAuOl6P_C6EqtSatLOBP6xBRgcD05A>
    <xme:WkxxaEQbQbfx7KVZqVEZ7vCzymFyNiE2UyyUyKdwb2gB3N44toNbXvmGMgHMNhQtt
    6b8oMf0CLqT2M0uE8I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegfeelfecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:WkxxaOOV1N-8cl8ewsOEadvfG9DMjh2ELghTwN74WNv3Gt0JyYjdHA>
    <xmx:WkxxaIr6oCFMaVmWU7gxOVhY4rm3xw3dXBakD_FIPF7wB40OD4bF_g>
    <xmx:WkxxaNScigY_hlnDbZTVOu3n_jiKONFprcnm_y-D-b4g8TtNSC1wFA>
    <xmx:WkxxaM3NFQKdNmcyxUur-EZMEEThitW_iCEZiwnrKDKhCenUTLnX9Q>
    <xmx:XExxaGAHDmkRJpoC78wbh25FI-BA2SRsBk3w8jQ6FIofe9fmBAXSmU4N>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2721B700065; Fri, 11 Jul 2025 13:39:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T7b8765a73c29189d
Date: Fri, 11 Jul 2025 19:39:17 +0200
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
Message-Id: <b870ed33-7d4f-4b0e-a9ae-b9c374ea854b@app.fastmail.com>
In-Reply-To: <28f277af-9882-2c70-5156-123c95adc2ee@oss.qualcomm.com>
References: 
 <20250710-arm-psci-system_reset2-vendor-reboots-v10-0-b2d3b882be85@oss.qualcomm.com>
 <20250710-arm-psci-system_reset2-vendor-reboots-v10-2-b2d3b882be85@oss.qualcomm.com>
 <20250710224740.GA15385-robh@kernel.org>
 <cdadd6cf-18c9-15c7-c58a-b5d56b53452a@oss.qualcomm.com>
 <454c8361-151e-42b3-adfc-d82d2af62299@app.fastmail.com>
 <28f277af-9882-2c70-5156-123c95adc2ee@oss.qualcomm.com>
Subject: Re: [PATCH v10 02/10] dt-bindings: power: reset: Document reboot-mode cookie
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Jul 11, 2025, at 19:00, Shivendra Pratap wrote:
> On 7/11/2025 8:14 PM, Arnd Bergmann wrote:
>> On Fri, Jul 11, 2025, at 14:32, Shivendra Pratap wrote:
>> 
>> The distinction between cookie and magic value may be relevant in the
>> context of the psci specification, but for the Linux driver, this is
>> really just a 64-bit magic number.
> ok. then if i understand, this binding change for reboot-mode be dropped
> and driver can internally handle the two 32 bit numbers?

Yes, if you can easily keep it internal to the psci driver, that
would work, or you could just change the callback type to take a
64-bit number and leave the interpretation up to the driver.

     Arnd

