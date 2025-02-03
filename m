Return-Path: <linux-pm+bounces-21254-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3D9A25386
	for <lists+linux-pm@lfdr.de>; Mon,  3 Feb 2025 09:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A063B1642F1
	for <lists+linux-pm@lfdr.de>; Mon,  3 Feb 2025 08:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195D41F9EC1;
	Mon,  3 Feb 2025 08:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="TrHKyq2+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SOEKWnF/"
X-Original-To: linux-pm@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0E51FBCAA;
	Mon,  3 Feb 2025 08:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738569905; cv=none; b=qtQoRzqr1788iwO9VbuEm+og9qDoj7HpsOiPfyRcSXDvHWGi2s7VrQeb9zDRNkir5nfwZxxuY0uBGghDWYUtOMCO+YiOA1E+TBIVJsJ7z4NUD5YzXCuah8m0fKWOXPnZMXF3iaHsSnosWY/5XyLsboSrzH7BjrB30uPpf1xM80s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738569905; c=relaxed/simple;
	bh=pOoIBWMPlxAEXVhpa/vNGR2RZL2iQJ0g9J5zfWePGBI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=U7Wd2iFav4x6hxSwitqHFRkUo6K7A65Ra/DZwHKYV/xefPdi6BlziNnq5ToJx0/grWuWsc2AE1dLXj4JAm0pTFTO/7IejZcAR3rXf69w3bv3CyiVm5nIL5465J9WT3jzX7kkFVhh2Kp69P3sU1MHlGrk+HhhdJ/yoZRAJI8fAkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=TrHKyq2+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SOEKWnF/; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 493C811400B9;
	Mon,  3 Feb 2025 03:05:00 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Mon, 03 Feb 2025 03:05:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1738569900;
	 x=1738656300; bh=Cs4w7MnakFyEXz0c0O88wfRhQcYkitMC+SwyVkqNaKw=; b=
	TrHKyq2+vO2M5NvHmMVSJOMkWrvYzIlYSQQBqj1Z2b0QcKA44T2fvZm2QMU7T6m2
	QsOfYSj3ENzNhbd2FBOebqWuA9G1dYicSTCub+bJSV1QjZ6VCCKZHPzgXVI8Deux
	FkOPHLlGjJqoARafWFGB7nSvbPXNwQ17dxs+QXuyAHn5Hp6eRnwnsu2FG/6JJVAu
	yW6MWSvKuo32FU9Bs3CrkmtoE6WsyArSurfQfJFB8kzz1SyFKzysIBbYgOP0jsuO
	3h3gD5mBX29QeYS+aVEnlfCjCUtxaeGtv4SA6J50TFJy3yOPTZcu2bJBSbMYzHNE
	iyTC3Po2VeUnKumO7iSFaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738569900; x=
	1738656300; bh=Cs4w7MnakFyEXz0c0O88wfRhQcYkitMC+SwyVkqNaKw=; b=S
	OEKWnF/79gI3dblBs9dz/KaFRt5BxSeYlOxSHi28HTGliPfClxRMSlcN+9XIMK71
	9PbTuxWur6NCCgsfb/IzaZjFMJX4+Hlbxp2hQGxKheXZ+GvMqAKfmzQkbqkVfWmy
	r91b5mpcs6Rcy7gmYIPFwlc15gm5w4dROS7gEGClaPEoA4VcippKh9oyQttQRSsn
	ubH1poNncfl0qjkNjcsLaRSBGqHDkJYKDrUbGTXkcQYSEXVlOuBdf0Z0LDBANYQS
	de+jARWrfwYaVVOcZUJnOVI5/duxbpHxFGdWX4wfYGyt9cOrPaixaymLBOhYcdP2
	2zCFWLaO9tU0XueHCpy5Q==
X-ME-Sender: <xms:q3igZyjZZWn6bVPG7qF7i1NrB27nGTrVpYWC2UjaJ6wOXCfuLlDtvA>
    <xme:q3igZzCCTYoxBzGvILpfArJXAGp8qr9QhLfTy7KmyJ9IfPcn9ZNwleAhEpbYdBhAk
    lliHzTJG-x7_zyTHKk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeej
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpihgvrhhrvgdrghhonhguohhish
    esrghrmhdrtghomhdprhgtphhtthhopegrnhhsuhgvlhhsmhhthhesghhmrghilhdrtgho
    mhdprhgtphhtthhopegrrhhnugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrfh
    grvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehvihhrvghshhdrkhhumhgrrhes
    lhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:rHigZ6HmlyEPWhNDtxRlINQJkcP4mrg9RJorNBbutMSyFP1Vx41bxQ>
    <xmx:rHigZ7REMUYx4dIF-65dpfNwuqh6DGkrBRauAdz7KlsblkgEcR7fQg>
    <xmx:rHigZ_y859BSYaMkkLRbx1NuOLbwOaeCjoIFzIXgohjKGvz_mQlwEQ>
    <xmx:rHigZ557rGcGfuj8cw_c9XLYcZZsi_lwy7cS1OXggpeRDNfUv7FVHQ>
    <xmx:rHigZ2nYG6BkxXFKXZVs_h8iv5NxKjexjzCYpcVcMlPJLLF5jTY5ia4L>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DD36B2220072; Mon,  3 Feb 2025 03:04:59 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 03 Feb 2025 09:04:39 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Viresh Kumar" <viresh.kumar@linaro.org>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 "Christian Marangi" <ansuelsmth@gmail.com>,
 "Pierre Gondois" <pierre.gondois@arm.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <3ccab07b-6cb9-46be-8a8e-e7745f5a951f@app.fastmail.com>
In-Reply-To: <20250122070000.sawplgg5tfhrvdfw@vireshk-i7>
References: <20250122065516.1483301-1-arnd@kernel.org>
 <20250122070000.sawplgg5tfhrvdfw@vireshk-i7>
Subject: Re: [PATCH] cpufreq: airoha: add CONFIG_OF dependency
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Jan 22, 2025, at 08:00, Viresh Kumar wrote:
>> 
>> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
>> index 704e84d00639..9e46960f6a86 100644
>> --- a/drivers/cpufreq/Kconfig.arm
>> +++ b/drivers/cpufreq/Kconfig.arm
>> @@ -18,6 +18,7 @@ config ARM_ALLWINNER_SUN50I_CPUFREQ_NVMEM
>>  config ARM_AIROHA_SOC_CPUFREQ
>>  	tristate "Airoha EN7581 SoC CPUFreq support"
>>  	depends on ARCH_AIROHA || COMPILE_TEST
>> +	depends on OF
>>  	select PM_OPP
>>  	default ARCH_AIROHA
>>  	help
>
> Applied. Thanks.
>

It appears that something went wrong when you applied the fix,
the version that is in your tree now makes no sense:

--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -17,7 +17,7 @@ config ARM_ALLWINNER_SUN50I_CPUFREQ_NVMEM
 
 config ARM_AIROHA_SOC_CPUFREQ
        tristate "Airoha EN7581 SoC CPUFreq support"
-       depends on ARCH_AIROHA || COMPILE_TEST
+       depends on (ARCH_AIROHA && OF) || COMPILE_TEST
        select PM_OPP
        default ARCH_AIROHA
        help

ARCH_AIROHA requires CONFIG_OF, so this change does nothing,
and the dependency is still missing for the COMPILE_TEST case.

      Arnd

