Return-Path: <linux-pm+bounces-31389-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF19CB10DEC
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jul 2025 16:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8547188AC85
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jul 2025 14:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44F82E542A;
	Thu, 24 Jul 2025 14:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="JKU2CX+F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JoCnefbw"
X-Original-To: linux-pm@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06917242D8B;
	Thu, 24 Jul 2025 14:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753368253; cv=none; b=GFeWoCTInPWO0zYZzbfs2ljpShT4GeTOi0nJR91nAwSm0Go5d16n2eXRpHIp+pOzt6IuUTNUF36pZOQmGz0VD+VEZHsNVtruEWgYp4eHPQZop3ikqLterVuyeF2r0CUTFnnGufftuq2acEd1+T2OcVKj1qp3uyd8fEFF9hqH4mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753368253; c=relaxed/simple;
	bh=v8Ucrw2n+yihght+34Qwy6z3bm5qRWlJ9gePLzXKPXc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=KwDv+zHD0WT8n2BE8i6XRwItFKoP+4jXcy0PpcUM8fhmO+Bj8bKWRgTgVxNmxNPOFt3fC7PcvYXrGkPWEn8RfZfr8aATiJPjkGDC6zR1AeakLUcLyDAXEp+ZWakEzjD0hrz1SW1vfmNALoKZfJiLFZy991TdlhCQSgifgXPh/ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=JKU2CX+F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JoCnefbw; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 47B4F1D0016C;
	Thu, 24 Jul 2025 10:44:10 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Thu, 24 Jul 2025 10:44:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753368250;
	 x=1753454650; bh=JamhdNl4dTJLx3yXRICkjdGl8QlQkTi8DTbesVHoqrc=; b=
	JKU2CX+FGWUagV4JQOeb0mwj5Gk7wI02FowNJey+riPnzuOrcXZv+zS/RULFVj1y
	WSKtvby7WQca8Yw2sb/zancTctCzkwiHGduID6uduyl62gSWX9qD+dZeFW/YHXP5
	PPP27ciLVtuBAHS9FEjzVv/74Qz63/N6/1lwzD8lORakhYjl0ByMDta4otUI89DQ
	VqBsRLcwKWYqbbcOua1TOhqHEBYShZO+GZZwRZBg2a25q1VXuFRD1097/d9iuVnH
	HFIGE527fLMOSTWA6TzQpgfS2rW/yXQ7mRFsSrMHLsfRJs7JUZq1x+a5Lm2La9cR
	vqRD8jn9kldvwNb983LyNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753368250; x=
	1753454650; bh=JamhdNl4dTJLx3yXRICkjdGl8QlQkTi8DTbesVHoqrc=; b=J
	oCnefbw55XPeundRqd0PQD+BfRNfvul2eCqLdxjJ3bzkLTUl3KQU74nKSn+pqEV1
	W6Dv0PU6L8cKo1t+asOs/0xVa8HBsW3KV7U7gYN0BQO/VXkLMgXzbFcXqW90+nr2
	Bxx7L8XLBoZLlX5+IpuEVndWPIvNvMnF82d5fvzzfh2EJU2LR/5CxLY/xcopfRpo
	NLm7kFH9+5KVeKbSAbleo1g15rPPP0p3dxeesnhuqzDawzq639kCcZP/BHqmZEQJ
	4XrFuNUQggb0FybWvV9TvtOnPF3pcqEO+SSP6yQJkoHnEGEt2KkF2gMqDBBfM+92
	JT52c79r0V2cx6gMA/vCw==
X-ME-Sender: <xms:uUaCaHAnPexKnsQ3Dk0AZSqQwKUzAst79JaPGAktrWyzPtpg3oRaog>
    <xme:uUaCaNiGrkqq7Zek8s1bL3jvo7z65E4GbjFgbDjwbZOfLykUG857S1IecTaw98DT4
    dRIZXitepX2-Yi6liI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdektdelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeefvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepshhouhhvihhkrdgthhgrkhhrrghvrghrthihsegrrhhmrdgtohhmpd
    hrtghpthhtoheptggrthgrlhhinhdrmhgrrhhinhgrshesrghrmhdrtghomhdprhgtphht
    thhopehmrghrkhdrrhhuthhlrghnugesrghrmhdrtghomhdprhgtphhtthhopehsuhguvg
    gvphdrhhholhhlrgesrghrmhdrtghomhdprhgtphhtthhopehflhhorhhirghnrdhfrghi
    nhgvlhhlihessghrohgruggtohhmrdgtohhmpdhrtghpthhtoheptghrohhsqdhqtghomh
    dqughtshdqfigrthgthhgvrhhssegthhhrohhmihhumhdrohhrghdprhgtphhtthhopehs
    figsohihugestghhrhhomhhiuhhmrdhorhhgpdhrtghpthhtoheprghnuggvrhhsshhonh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:uUaCaEXZBu6yk1VPDQP0HGcmV22HvohaVuM03F3MAFW1KxfnqJ2c_Q>
    <xmx:uUaCaFABSoVK15_6YA28JsJFg_KWSddstFxVVLYfQ156MD3TWCtPQA>
    <xmx:uUaCaPq5Tt4fWg4StMeBCIXZHnXFgrQDgLb9TXGreupGcu4dJp_cCQ>
    <xmx:uUaCaJ3naF4CHCzmTjC1n9_jhJgTgm1r-0VNDjp-Oc9Y2ARhmBquWQ>
    <xmx:ukaCaDB9fqHd5sczdwjl8ppjqRMePYBL_j59o_OykN9ZilsFfaeSOLql>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id EC469700065; Thu, 24 Jul 2025 10:44:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T8f78d0e2b9c43c44
Date: Thu, 24 Jul 2025 16:43:48 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Shivendra Pratap" <shivendra.pratap@oss.qualcomm.com>,
 "Krzysztof Kozlowski" <krzk@kernel.org>,
 "Florian Fainelli" <florian.fainelli@broadcom.com>,
 "Bartosz Golaszewski" <bartosz.golaszewski@linaro.org>,
 "Bjorn Andersson" <andersson@kernel.org>,
 "Sebastian Reichel" <sre@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Sudeep Holla" <sudeep.holla@arm.com>,
 "Souvik Chakravarty" <Souvik.Chakravarty@arm.com>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Andy Yan" <andy.yan@rock-chips.com>,
 "Mark Rutland" <mark.rutland@arm.com>,
 "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
 "Konrad Dybcio" <konradybcio@kernel.org>,
 cros-qcom-dts-watchers@chromium.org, "Vinod Koul" <vkoul@kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>
Cc: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>,
 "Mukesh Ojha" <mukesh.ojha@oss.qualcomm.com>,
 "Stephen Boyd" <swboyd@chromium.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, "Elliot Berman" <quic_eberman@quicinc.com>,
 "Srinivas Kandagatla" <srini@kernel.org>,
 "Elliot Berman" <elliot.berman@oss.qualcomm.com>,
 "Konrad Dybcio" <konrad.dybcio@oss.qualcomm.com>
Message-Id: <36f62026-9517-42bd-8f9a-92f39fcdc136@app.fastmail.com>
In-Reply-To: <f4725f3f-1b45-ebd2-aaf4-4f986a44eb8e@oss.qualcomm.com>
References: 
 <20250721-arm-psci-system_reset2-vendor-reboots-v12-0-87bac3ec422e@oss.qualcomm.com>
 <beb26682-d2e4-40e6-89ac-87f18c0401d0@broadcom.com>
 <56599da9-0200-72b5-012e-942a1fc954b2@oss.qualcomm.com>
 <a1d3264f-a46a-42c4-b518-a66c8e0b70b4@kernel.org>
 <f4725f3f-1b45-ebd2-aaf4-4f986a44eb8e@oss.qualcomm.com>
Subject: Re: [PATCH v12 0/8] Implement vendor resets for PSCI SYSTEM_RESET2
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Jul 24, 2025, at 16:04, Shivendra Pratap wrote:
> On 7/24/2025 6:18 PM, Krzysztof Kozlowski wrote:
>> On 24/07/2025 14:24, Shivendra Pratap wrote:

>> I strongly insist using compatible as way to find your device, not node
>> names.
> It will look better to switch to compatible. Will define a compatible for
> psci reboot-mode binding and align the patch to use the compatible for sysfs.
> Current patch defines reboot-mode as a property to psci, hope its fine to
> define a compatible for this property like "psci-vendor-reset" or
> "psci-reboot-modes"?
>

How about using the reboot driver name as the identifier in sysfs
instead of the compatible string? That would make it independent of
devicetree.

I had a related idea to provide some namespacing on the actual
reboot syscall parameter, as we have two (or more) orthogonal
concepts here, when there is more than one reboot driver and
drivers support multiple modes.

E.g. you could use

    syscall(__NR_reboot, LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2, 
            LINUX_REBOOT_CMD_RESTART2, "watchdog");

vs

    syscall(__NR_reboot, LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2, 
            LINUX_REBOOT_CMD_RESTART2, "psci");

to pick one of the drivers, or

    syscall(__NR_reboot, LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2, 
            LINUX_REBOOT_CMD_RESTART2, "bootloader");

    syscall(__NR_reboot, LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2, 
            LINUX_REBOOT_CMD_RESTART2, "recovery");

to ask for a reboot from any driver that supports a mode, or
combine the two and ask a specific mode in a specific driver like

    syscall(__NR_reboot, LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2, 
            LINUX_REBOOT_CMD_RESTART2, "psci:bootloader");

   Arnd

