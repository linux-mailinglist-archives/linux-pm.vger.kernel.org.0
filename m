Return-Path: <linux-pm+bounces-24068-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47332A6164D
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 17:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 875433BD7A8
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 16:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C817202F88;
	Fri, 14 Mar 2025 16:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Ds8hAQyp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zQ32XetI"
X-Original-To: linux-pm@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A09E802;
	Fri, 14 Mar 2025 16:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741969930; cv=none; b=EGE3e+Dga0QsfzQxAefGIDT/s6TOYosSePuvXMirhqG4mSqCCzW0MuJA4p6WH4zBlcjR8TvPWGukxZ9KwZVurkCGymdKq6fQpiBiF+4UVj1T5oDYh62Fb/247jI8qz9W7x/wnIJ7W0w5PLTmJCu7GeCs4cYzp/kkvUmt3o339zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741969930; c=relaxed/simple;
	bh=10MsDaA2MWO7mJVfaYGM9nyxBpTtfK7KG7Gxr7EwaWU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=U1PnqEvBBLMvHoIjEo1nUDYGEPxy9vTWh/Eg5TO2wwtzbkSLhxTfxtK6uLsog0W21i7NhSUHNlneQxz7FvKPB6Q/BHvCyGqqGTJAD8bb3i2Q7nWnwuSOxO3zDc8KOzE53umDGFC/obgvmeWvlMyRSPb1v8KcgcUYYr+jOVu1AuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Ds8hAQyp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zQ32XetI; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 0306E1382C9D;
	Fri, 14 Mar 2025 12:32:06 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Fri, 14 Mar 2025 12:32:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1741969925;
	 x=1742056325; bh=FD2VJEjIz3gradIbfAYuUXm+xccGXY9Qu6gKId/0kC4=; b=
	Ds8hAQypRK544JDNwLw2u6IIKcvUUa7R6ntosZ2MidyztlHRcZAgSqW4RjC1TIaW
	ouIT4yIAeAAH8mDQ7cIGDPArduGkUyL3XBfaRL4iDq1PYytB2ygGeeWxTo4IYKSl
	I/OqFnCXkuPHHTYLio2Nm4nnUuqolSmU65rNyvIyp0Xc3qec/vTwrW4UtMHhien6
	Derm6xcyOv1cRM7BfGcgYpQazwapUXrVnhWxImzWw+mbgEyKV964FVCWRy5gegPs
	y0YkNYDoqopNCfbt/QUtIPiVySKvQZf8IGxcW5yGuzWPQmbWo33yu0y7EV6cLkYJ
	B4D4WR36R+TwEvxM10uEbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741969925; x=
	1742056325; bh=FD2VJEjIz3gradIbfAYuUXm+xccGXY9Qu6gKId/0kC4=; b=z
	Q32XetIAN2hHDJkpQSZkyzo/rpF+XhB/mjKToLE5z+Da39DIHBMDocuA2OyhTw6t
	Sko/3rbfsp8fimUg/m3DrwTpv0hWYMrnNL8/wFAHym5LrmKg0MXG+WnWQKxiTzce
	XlGRD+GPUrSg+WU+9zeaoKvcM45VBDIzMjSxt+BAG6Yro1DDRkJX9M3uvdLQrave
	Ir+p6tWvV3h9jIzc6nH/zcb6MMooaBQ99Yuc7/d62fKpqZCjvQDaxaTez1xUHONv
	dL8YhMlY11F/G4sjFhr46GG5kGudzxFpF3bhJqCKinp+QVjN6OjzZjJOOCkE1DRi
	2aLZjtsxJh8x/+hJcLG6A==
X-ME-Sender: <xms:BFrUZ7IR0aZo9ff3gW_0UwYjioNzF6cQV45M3gc9b4t_0VMc1321eA>
    <xme:BFrUZ_KQ-NAnmPC2Em-Ct44pCbIrvUGk_9vZxc-fn5cGvJ8ClLkerYKGKBSQ3Av4h
    I5eXWvAFbLDPw74SiI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufedufeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhepgfdtveffgfejfeevteeggffgffeggfdugeek
    feffudejfedtgfffheefffetheefnecuffhomhgrihhnpehmrghnjedrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghr
    nhgusgdruggvpdhnsggprhgtphhtthhopedvledpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtoheptggrthgrlhhinhdrmhgrrhhinhgrshesrghrmhdrtghomhdprhgtphhtthho
    pehmrghrkhdrrhhuthhlrghnugesrghrmhdrtghomhdprhgtphhtthhopehflhhorhhirg
    hnrdhfrghinhgvlhhlihessghrohgruggtohhmrdgtohhmpdhrtghpthhtoheptghrohhs
    qdhqtghomhdqughtshdqfigrthgthhgvrhhssegthhhrohhmihhumhdrohhrghdprhgtph
    htthhopehsfigsohihugestghhrhhomhhiuhhmrdhorhhgpdhrtghpthhtohepvghllhhi
    ohhtsgefudejsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnuggvrhhsshhonheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehkohhnrhgrugihsggtihhosehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:BFrUZzt7h746867z5VifeUIhVN1E38o_umyheLXKiBuuv3sOJ8W9CQ>
    <xmx:BFrUZ0bmreGz-c0iuhwSVG1gAW5Fu08jueAgw6FyIHnhaQ4-1vL52Q>
    <xmx:BFrUZya0uYzuClpPwBes8mBgGOCLlWngSb3i6tHbNY5WzzhxZH38Ig>
    <xmx:BFrUZ4B02kq7vWkUblhxQNH79MJIe3sXWjc629hWgepC8f_h3xe6wg>
    <xmx:BVrUZzEQbjCOZOC9YcdgK3OeEJsVGZgHKtQqkCKLsbhcr-6pmgnOX31Z>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A7C6F2220072; Fri, 14 Mar 2025 12:32:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 14 Mar 2025 17:31:44 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
 "Elliot Berman" <quic_eberman@quicinc.com>
Cc: "Bjorn Andersson" <andersson@kernel.org>,
 "Sebastian Reichel" <sre@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Vinod Koul" <vkoul@kernel.org>,
 "Andy Yan" <andy.yan@rock-chips.com>,
 "Mark Rutland" <mark.rutland@arm.com>,
 "Bartosz Golaszewski" <bartosz.golaszewski@linaro.org>,
 "Olof Johansson" <olof@lixom.net>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Will Deacon" <will@kernel.org>, cros-qcom-dts-watchers@chromium.org,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Konrad Dybcio" <konradybcio@kernel.org>,
 "Srinivas Kandagatla" <srinivas.kandagatla@linaro.org>,
 "Satya Durga Srinivasu Prabhala" <quic_satyap@quicinc.com>,
 "Melody Olvera" <quic_molvera@quicinc.com>,
 "Shivendra Pratap" <quic_spratap@quicinc.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 "Florian Fainelli" <florian.fainelli@broadcom.com>,
 "Stephen Boyd" <swboyd@chromium.org>, linux-pm@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, "Elliot Berman" <elliotb317@gmail.com>,
 "Elliot Berman" <elliot.berman@oss.qualcomm.com>
Message-Id: <a9d8d9aa-f63c-481e-b051-a3da0adb3c66@app.fastmail.com>
In-Reply-To: <Z9QQw6BcE7IXzu+r@lpieralisi>
References: 
 <20250303-arm-psci-system_reset2-vendor-reboots-v9-0-b2cf4a20feda@oss.qualcomm.com>
 <20250303-arm-psci-system_reset2-vendor-reboots-v9-2-b2cf4a20feda@oss.qualcomm.com>
 <Z9QQw6BcE7IXzu+r@lpieralisi>
Subject: Re: [PATCH v9 2/5] firmware: psci: Read and use vendor reset types
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Mar 14, 2025, at 12:19, Lorenzo Pieralisi wrote:
> On Mon, Mar 03, 2025 at 01:08:31PM -0800, Elliot Berman wrote:
>> From: Elliot Berman <elliot.berman@oss.qualcomm.com>
>> 
>> SoC vendors have different types of resets and are controlled through
>> various registers. For instance, Qualcomm chipsets can reboot to a
>> "download mode" that allows a RAM dump to be collected. Another example
>> is they also support writing a cookie that can be read by bootloader
>> during next boot. PSCI offers a mechanism, SYSTEM_RESET2, for these
>> vendor reset types to be implemented without requiring drivers for every
>> register/cookie.
>> 
>> Add support in PSCI to statically map reboot mode commands from
>> userspace to a vendor reset and cookie value using the device tree.
>
> I have managed to discuss a little bit this patchset over the last
> few days and I think we have defined a plan going forward.
>
> A point that was raised is:
>
> https://man7.org/linux/man-pages/man2/reboot.2.html
>
> LINUX_REBOOT_CMD_RESTART2 *arg command, what is it supposed to
> represent ?
>
> Is it the mode the system should reboot into OR it is the
> actual command to be issued (which is what this patchset
> implements) ?
>
> LINUX_REBOOT_CMD_RESTART "..a default restart..."
>
> It is unclear what "default" means. We wonder whether the
> reboot_mode variable was introduced to _define_ that "default".

I think the reboot_mode predates the 'cmd' argument: linux-2.1.30
introduced LINUX_REBOOT_CMD_RESTART2 and it already had
the warm/cold/bios/hard options for i386 reboot. I think the
argument went unused for a while after it got introduced though.

> So, in short, my aim is trying to decouple reboot_mode from the
> LINUX_REBOOT_CMD_RESTART2 *arg command.
>
> I believe that adding a sysfs interface to reboot-mode driver
> infrastructure would be useful, so that the commands would
> be exposed to userspace and userspace can set the *arg command
> specifically to issue a given reset/mode.
>
> I wonder why this is not already in place for eg syscon-reboot-mode
> resets, how does user space issue a command in those systems if the
> available commands aren't exposed to userspace ?
>
> Is there a kernel entity exposing those "modes" to userspace, somehow ?

Don't know one either.

>> A separate initcall is needed to parse the devicetree, instead of using
>> psci_dt_init because mm isn't sufficiently set up to allocate memory.
>> 
>> Reboot mode framework is close but doesn't quite fit with the
>> design and requirements for PSCI SYSTEM_RESET2. Some of these issues can
>> be solved but doesn't seem reasonable in sum:
>>  1. reboot mode registers against the reboot_notifier_list, which is too
>>     early to call SYSTEM_RESET2. PSCI would need to remember the reset
>>     type from the reboot-mode framework callback and use it
>>     psci_sys_reset.
>>  2. reboot mode assumes only one cookie/parameter is described in the
>>     device tree. SYSTEM_RESET2 uses 2: one for the type and one for
>>     cookie.
>
> This can be changed and I think it should, so that the reboot modes
> are exposed to user space and PSCI can use that.

Can we try to call them 'arguments' rather than 'modes' while discussing?
I think it's way too easy to confuse them otherwise.

>> +	psci_np = of_find_matching_node(NULL, psci_of_match);
>> +	if (!psci_np)
>> +		return 0;
>> +
>> +	np = of_find_node_by_name(psci_np, "reset-types");
>> +	if (!np)
>> +		return 0;
>
> Related to my initial question above. If LINUX_REBOOT_CMD_RESTART2 *arg command,
> is the actual reset to be issued, should we add a default mode "cold"
> and, if SYSTEM_RESET2 is supported, a "warm" reset mode too ?
>
> It all boils down to what *arg represents - adding "cold" and "warm"
> modes would remove the dependency on reboot_mode for resets issued
> through LINUX_REBOOT_CMD_RESTART2, the question is whether this
> is the correct thing to do.
>
> Comments very welcome.

It would make some sense to me to treat all psci reboot as "warm" and
not do anything here if reboot="cold" is set: those would have to
be backed by a hardware specific driver.

A related problem is how to determine when to use UEFI reboot: at the
moment arm64 tries the UEFI runtime interface before it even attempts
any of the notifiers, so PSCI reboot won't ever be used if UEFI is
present.

     Arnd

