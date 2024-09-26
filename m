Return-Path: <linux-pm+bounces-14843-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0065987A3A
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 22:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 149F7B21005
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 20:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68391181B87;
	Thu, 26 Sep 2024 20:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lunnova.dev header.i=@lunnova.dev header.b="KMpCJPLv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pLnniWVU"
X-Original-To: linux-pm@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B8E282FA;
	Thu, 26 Sep 2024 20:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727384209; cv=none; b=YgZbv3j7D7w7G5J4xRzV3IqLA8SC6axgVjGYzy8zApULfvkRDUj/F1OS400avCOzzkgjtF0MKA+JYd8RzsRFFsMB23qKAgx0jMOTCQyM4dIENTI1fwMU97aGFfR85eob8yqErWEEacJHEk6JKHd5vL6MtSeNy7vjHVF62c7PAoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727384209; c=relaxed/simple;
	bh=nCTe6xxgFafPRrhXtLLOil5UTMuKeSLdkKeeEkFsivc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=BvF53l0Vj8RpR1cHCTtcOYFnLTUI3eJQTGtyecHzgMJoAJX5SpAwOaKyVR4tNKd/2HDOusOR0aNutaoBmG0Hb+CW3XWYiIlHxFQidFUK1DEswz05XkAXF2V6RIgO5aLnPVkt7wfOOI/pGlgI8Hcd94Vm1x1HI1DCJ2UkrxoCInQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lunnova.dev; spf=pass smtp.mailfrom=lunnova.dev; dkim=pass (2048-bit key) header.d=lunnova.dev header.i=@lunnova.dev header.b=KMpCJPLv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pLnniWVU; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lunnova.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunnova.dev
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 9467013801FA;
	Thu, 26 Sep 2024 16:56:45 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Thu, 26 Sep 2024 16:56:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lunnova.dev; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1727384205;
	 x=1727470605; bh=Jbyef7Ry4FiH3z6OqiBS5SR02boeDGnaYLC8FiS59Kk=; b=
	KMpCJPLviVcs3IEWU832tsrpE9vWuXPgDa7iRuP05tN45SskaxIVYNApyL9JQko7
	/V+hhLkuRFzlue2bOASheazAK6sAdAD0CG7bxMlAx3wLHNPfasALZOv+Xvffz9C4
	7yQl5j3IkF46lHi9xKkPh6GetlGvsJaqTrnO/aWExnHKXPJsubrYGl5rAmu8cU7z
	cZu1eD14Ao0yb38YFAG/6vxw3bel8MnkPVa/+2DRZlmt5meuv7JtY6XZJJ9OPHEB
	q6Vz6qbkXJ+s8x/PtpcqsDs6w9n0dQN4GSWPDt1Aw5CnIhYVbNvR/APWLiqm87RA
	ci+qMdnEw36BsV2cO1J3EA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727384205; x=
	1727470605; bh=Jbyef7Ry4FiH3z6OqiBS5SR02boeDGnaYLC8FiS59Kk=; b=p
	LnniWVUCVoY/31idWJMmTiEn1fNUFXyMyT+BUUtL1uczqJSYEEcdcarB8SK3O0/F
	t4SU2GgH2ZLJYd3MDGqhLteZ5ret4/D1qAexsTyOPDEhcnTdREviEip5GN44WS/a
	r5hA+EQFLrhrtDZ0tKze4WaoYObkk1VpK93XM+Ddbv9WYO4XY+ecf5RHt8NsiZak
	sVd97Q2+P7b1suLbFRdPGyWiGOBnu66NQ+jwcrCPobrXd0L5nqWI2LPWpY0js3/Y
	Wa0ojaohCGfnsfR+lQIKkYc8BRQWfkaRJjCEa8HmuZibjO+cI9y82JX1v8BpCOft
	k8lQJfMtcUSeTLTN7ZhNw==
X-ME-Sender: <xms:jcr1ZrUDD-9MtIG867VJq-zres9hbWu_NYuvp1-UJ1uvccXbc5To-A>
    <xme:jcr1ZjlOi-8IGnNS4ycYjH1LE5VlBSP7eOGiF9Twq8aWTqEt4K-F9mgwe0qHiSbvH
    k9mdOkPpEw9HgLYmiM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtjedgudehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdfnuhhnrgcupfhovhgrfdcuoehlihhsthhssehluhhnnhhovhgrrd
    guvghvqeenucggtffrrghtthgvrhhnpeejheffueeghffgueettddugeeffeejvddufefh
    udejveeutdfhteeileeliefgkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehlihhsthhssehluhhnnhhovhgrrdguvghvpdhnsggprhgtphht
    thhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopedttddutdejtdekvdesud
    eifedrtghomhdprhgtphhtthhopeigihgrohhjihgrnhdrughusegrmhgurdgtohhmpdhr
    tghpthhtohepghgruhhthhgrmhdrshhhvghnohihsegrmhgurdgtohhmpdhrtghpthhtoh
    epphgvrhhrhidrhihurghnsegrmhgurdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgv
    rhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqph
    hmsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:jcr1Znbcg6gdTCH-ZeCCF8aPTZIq_4qlMY6AzT3vcKByNRtXdyx0qA>
    <xmx:jcr1ZmVO4g363bLubcYvtXvY4Vu-Gnj66tqYbfMqt2HCne8f9-o8jQ>
    <xmx:jcr1ZlnjKVM4LGhGjoTmbYv6_OaKlmFEcPJ734JWxdaU8VbG_pY5IA>
    <xmx:jcr1ZjdfClB02-TUDxhLHG-CycyQRUUcxtwjoeQOMvnuAgNgIIyWWQ>
    <xmx:jcr1ZouCsr8JIfPuTLOGKvUWk8FrUUQu81SF-pAzVoxQU-El86b0Fi_A>
Feedback-ID: i41c648a4:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4ADCBBA006E; Thu, 26 Sep 2024 16:56:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 26 Sep 2024 13:56:21 -0700
From: "Luna Nova" <lists@lunnova.dev>
To: "Gautham R.Shenoy" <gautham.shenoy@amd.com>
Cc: perry.yuan@amd.com, Xiaojian.Du@amd.com, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, "David Wang" <00107082@163.com>
Message-Id: <df99663b-23bd-43ac-b277-cd6700f16809@app.fastmail.com>
In-Reply-To: <87v80jbjpj.fsf@BLR-5CG11610CF.amd.com>
References: <20240730140111.4491-1-00107082@163.com>
 <87zfpxsweb.fsf@BLR-5CG11610CF.amd.com>
 <2f793cc8.a13d.19108df0a58.Coremail.00107082@163.com>
 <87v80jbjpj.fsf@BLR-5CG11610CF.amd.com>
Subject: Re: [Regression] 6.11.0-rc1: AMD CPU boot with error when CPPC feature
 disabled by BIOS
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Gautham,

I'm seeing the same message on a server board with an EPYC Rome 7K62 CPU.
CPPC is set to enabled in the UEFI firmware settings.

Kernel: 6.11.0 (6.11.0 #1-NixOS SMP PREEMPT_DYNAMIC Sun Sep 15 14:57:56 UTC 2024 x86_64 GNU/Linux)
Board: Gigabyte MZ22-G20-00 Rev 1.0 (in a G292-Z20 Rev 100)
UEFI Firwmare: R23_F01 (2021-09-06, latest available version at time of this message)
AGESA PI Version 1.0.0.C.

CONFIG_ACPI_CPPC_LIB=y
CONFIG_X86_AMD_PSTATE=y
CONFIG_X86_AMD_PSTATE_DEFAULT_MODE=3
CONFIG_X86_AMD_PSTATE_UT=m

$ cat /proc/cmdline
initrd=\EFI\nixos\z16gakzlwypxbjzm5y93x10cjmxjvial-initrd-linux-6.11-initrd.efi init=/nix/store/cqhw9x7w7dc3avwri4i2lk0mgc31arll-nixos-system-tsukiakari-nixos-24.11/init sysrq_always_enabled fsck.mode=force loglevel=4 audit=0 amd_pstate=guided amd_pstate.shared_mem=1 amdgpu.lockup_timeout=10000,10000,10000,10000
$ sudo dmesg | grep pstate
amd_pstate: min_freq(0) or max_freq(0) or nominal_freq(0) value is incorrect
(Repeats for each core)
amd_pstate: failed to register with return -19
stage-1-init: [Thu Sep 26 20:04:53 UTC 2024] loading module amd_pstate_ut...
amd_pstate_ut: 1    amd_pstate_ut_acpi_cpc_valid  success!
amd_pstate_ut: 2    amd_pstate_ut_check_enabled   success!
amd_pstate_ut: 3    amd_pstate_ut_check_perf      success!
amd_pstate_ut: 4    amd_pstate_ut_check_freq      success!

It seems odd that amd_pstate fails to load but amd_pstate_ut reports success for all checks.

> it appears that the CPPC version on your platform is v2 which does not
> advertise the nominal_freq and the lowest_freq. In the absence of these,
> it is not possible for the amd-pstate driver to infer the
> min/max_freq. Which is why the driver bails at this later stage.

> The way around it is to add a quirk for your BIOS as done in this commit
> from Perry:
> eb8b6c368202 ("cpufreq: amd-pstate: Add quirk for the pstate CPPC capabilities missing")

Perry's patch you referenced as an example above targets the same 7K62 CPU but requires one specific BIOS version.
Should I submit a patch adding the version on this system to that quirk?

I'm confused by the quirk code: it's called "AMD EPYC 7K62" but it matches by BIOS revision and doesn't check the CPU model.
An earlier version of the quirk included `boot_cpu_data.x86 == 0x17 && boot_cpu_data.x86_model == 0x31` to check the model; it now uses the nominal frequencies for a 7K62 regardless of the CPU model if the BIOS revision matches.

Best,
Luna

