Return-Path: <linux-pm+bounces-31636-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A4DB16588
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 19:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE3B93AD95C
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 17:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1167248881;
	Wed, 30 Jul 2025 17:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="KfRAx0F9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WHzSHeMP"
X-Original-To: linux-pm@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BA5EEBA;
	Wed, 30 Jul 2025 17:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753896731; cv=none; b=PAS8936pRMcULlxx7EUNa113+NoR9wDNfP2zX3B6Z79mw5unpJ4LgsgTtL2K2ZWgpa62wQ44ouSmosTA9K3AOzh3MoKmzRS8CZdS/eevfj3Jx3WjtupLE0O4dm0ECVIL93GzVbR1GQFd/WU7YAdtmp587H2MEFDaymt3ojApkoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753896731; c=relaxed/simple;
	bh=j83rhuadkSf764RQr36uK9h4N/5BeZkA5cSdiBfbJps=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=HIAZz3bMi4tXo99UItl4SXmzpK0fET/qYq3uaYwZ4i3x5mZdSRe8ocoSjM2Eta6cnl/WvmbbkXW9VMLBrjvc7af54EHiku0RLu+EPhWglq5oS/9/TIpaHHzYeJhUDImoQYtVvb8HYhV2P/zJMDKu6XTABEDafXrlk6uQ7F112UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=KfRAx0F9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WHzSHeMP; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 373B51D0072A;
	Wed, 30 Jul 2025 13:32:07 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Wed, 30 Jul 2025 13:32:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753896727;
	 x=1753983127; bh=FrHvCL86NTqIeIXqqveuapZXFtcxgLyI0phgD1y5qhE=; b=
	KfRAx0F9Xs75XSfLmAibLMEPU8y2lITs1ww//Ie9depgBY4VykMHI0haY1mA+j0h
	Am+HMz3PJ9JQWKZPuw6HCCwdxEWak/lr2flm06ppnxslvhp0u+nmDgfS0yq/sxRm
	rCE8WF9oZRQPWneIChsWjja4p1VbvwrcIISq02LGiJ2bcfGM/qG8iNPQbCUrFBJR
	szViXaS408oFZ1d31/6ARhWDaI0yPA4YgO8BLZbanz65kazXIfl5ClDnGD4a5uJd
	yOXbk72l52vw7O6R/6Hvz6EAeaQ83EMSDUcYGnWkykCx7diE5wod+pf1YH2VIK0B
	g8nBr85TdPSvR5YbiyNE/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1753896727; x=
	1753983127; bh=FrHvCL86NTqIeIXqqveuapZXFtcxgLyI0phgD1y5qhE=; b=W
	HzSHeMPYLikGA2Hxm8f+dM7xH4xEZ3AHcnmKvMUOAfgt8v8h3rUUiPp0gAtngs83
	Viu0sghkMwCFFSzdOuoMalyc86bgZuC3Fxy0QB1Fg/gFoPq4wIDviWx5hROez17B
	BrNb5WlEdpam1zk31mSnvtk1NmSnw6DmukHC/8RcGIml+2l2iqTZH16kr0IySBvc
	sjCbPL7PzBBbXB1FHTuLG5bvBrwj/9uOMQO1IrmuTAAGPKIlanIlMjQIpqvPSAl6
	2ZccOmDBudTU1xe+D2EGyslVitmy2NYT1+DBr7wejYTuHQ7ZmGfT/Jl9l4u76EoA
	YB46JMVf3TyCrobxxS8EQ==
X-ME-Sender: <xms:FVeKaLWJXTQoddk-B5fMRxk0o_J9cvs4ZTAZdU8RGcZm-L6RtLORKg>
    <xme:FVeKaDlcXoYmJGFEYcojfvDIp9b5qDKesd8Aj-WN3-07sqmeLAPF0oJlsJw6y5iOQ
    CkQYDF2DIqitwrFD_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelkeehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpedvhfdvkeeuudevfffftefgvdevfedvleehvddvgeejvdefhedtgeegveehfeeljeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopedvledpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepshhouhhvihhkrdgthhgrkhhrrghvrghrthihsegrrhhmrdgtohhmpd
    hrtghpthhtoheptggrthgrlhhinhdrmhgrrhhinhgrshesrghrmhdrtghomhdprhgtphht
    thhopehmrghrkhdrrhhuthhlrghnugesrghrmhdrtghomhdprhgtphhtthhopehsuhguvg
    gvphdrhhholhhlrgesrghrmhdrtghomhdprhgtphhtthhopehflhhorhhirghnrdhfrghi
    nhgvlhhlihessghrohgruggtohhmrdgtohhmpdhrtghpthhtoheptghrohhsqdhqtghomh
    dqughtshdqfigrthgthhgvrhhssegthhhrohhmihhumhdrohhrghdprhgtphhtthhopehs
    figsohihugestghhrhhomhhiuhhmrdhorhhgpdhrtghpthhtoheprghnuggvrhhsshhonh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:FVeKaDuAfdIO_iGt1QPOYtiwfGQ-pAv9670yxyCWmxR5LpX6fMQi5Q>
    <xmx:FVeKaMLKze5sQiDoY9NlwDFYigiF2DPgevfMeiwFCGkEWw8Mgi2haw>
    <xmx:FVeKaMk2QP5I7zDxaw21V4IKd_FWf-rl00_CoBA9iwguB8Qv6l0LwA>
    <xmx:FVeKaDksrpwIemRS9oMC5PPeu_Wnnsld29fhXaiezuRN1sr67kWQ9A>
    <xmx:F1eKaHi9YhMXWL0IpIiIb0TWX_M_HJQxaNyT072MS32My-VY2-YiwnGM>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 93DAA700068; Wed, 30 Jul 2025 13:32:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tc37f4eafbf89ea7c
Date: Wed, 30 Jul 2025 19:31:44 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 "Shivendra Pratap" <shivendra.pratap@oss.qualcomm.com>,
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
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>,
 "Florian Fainelli" <florian.fainelli@broadcom.com>
Cc: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>,
 "Mukesh Ojha" <mukesh.ojha@oss.qualcomm.com>,
 "Stephen Boyd" <swboyd@chromium.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 "Elliot Berman" <quic_eberman@quicinc.com>,
 "Srinivas Kandagatla" <srini@kernel.org>
Message-Id: <592902f1-549f-47c5-9ef4-b5c7ef2c9a47@app.fastmail.com>
In-Reply-To: <34c52c88fd8fcbf68c453c1e94e4cd6294becff1.camel@linaro.org>
References: 
 <20250727-arm-psci-system_reset2-vendor-reboots-v13-0-6b8d23315898@oss.qualcomm.com>
 <20250727-arm-psci-system_reset2-vendor-reboots-v13-7-6b8d23315898@oss.qualcomm.com>
 <b45b157593f1865a402f4098cdeafc298a294c6d.camel@linaro.org>
 <b92c164f-c6df-a2c0-1416-67652a01b179@oss.qualcomm.com>
 <34c52c88fd8fcbf68c453c1e94e4cd6294becff1.camel@linaro.org>
Subject: Re: [PATCH v13 07/10] firmware: psci: Implement vendor-specific resets as
 reboot-mode
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025, at 17:23, Andr=C3=A9 Draszik wrote:
> On Wed, 2025-07-30 at 18:33 +0530, Shivendra Pratap wrote:
>> On 7/30/2025 2:14 PM, Andr=C3=A9 Draszik wrote:

>> 1. For this, both commands will be defined in the psci->reboot-mode D=
T Node with the arguments that
>> =C2=A0=C2=A0 are defined and supported by the firmware.
>> 2. Further, such requirement will now be taken care by the underlying=
 firmware that supports
>> =C2=A0=C2=A0 PSCI vendor-specific reset. When we call into firmware w=
ith vendor specific reset arguments,
>> =C2=A0=C2=A0 firmware will take care of the defined HW writes and war=
m/cold reset as per the mapping of the
>> =C2=A0=C2=A0 defined arguments. Firmware and the Linux kernel here ar=
e in agreement for executing the
>> =C2=A0=C2=A0 vendor-specific resets.
>
> So that means
>
>     echo warm > /sys/kernel/reboot/mode
>     reboot bootloader
>
> and
>
>     echo cold > /sys/kernel/reboot/mode
>     reboot bootloader
>
> can not be distinguished.
>
> The firmware can not know whether or not cold or warm reboot was
> requested in this case by the user.

My feeling is that this is fine: the /sys/kernel/reboot/mode
interface is not really used on anything other than 32-bit
arm and x86 machines, and the way it is specific as
cold/warm/hard/soft/gpio is not that useful.

I think for the purpose of the new code here, we should talk
about reboot "commands" instead of "modes" to avoid confusing
between the global "enum reboot_mode" variable and the
firmware interface for reboot modes as listed in DT.

    Arnd

