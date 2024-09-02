Return-Path: <linux-pm+bounces-13362-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C8C968E6E
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 21:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD14C1F23B67
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 19:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5845919CC3E;
	Mon,  2 Sep 2024 19:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="IwtmzsYC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-43167.protonmail.ch (mail-43167.protonmail.ch [185.70.43.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487B51A3A9C
	for <linux-pm@vger.kernel.org>; Mon,  2 Sep 2024 19:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725304901; cv=none; b=EqM/6h/h+ywLZUkXG3Vu36TjrHGtQTpkjtURguE7XpAxZUc53Xm6SywVp9URVQw5V1uueqcN5MnOZW0cSy0WcltNX5xg/sKkcj0wwIuQqqgoG5SNHppBHJwOBvX7UKYByrbtm8i71xs10LI/ysX1INGQNVLH+mMf98gmVKUIAT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725304901; c=relaxed/simple;
	bh=LuE9mRYXcbYgc7yUuEmieQnltwYni1kd/AdQPOr8aXk=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=eWHwhwYyaQQDN02OmSGJZk75tff+DoD9roDbNvSp7Sueh234332d0DNtEJVtZPh1nWLG+ZlYzDmvqKDj/3yBWwhGccu/d8Q2aBupVhL4WWWH6YpWX+5XeA/E5HO4+GcXHzJ/VpMLmU9XvQRWCwFLHfgsmZwZHjIytq0Q1JIzaAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=IwtmzsYC; arc=none smtp.client-ip=185.70.43.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1725304892; x=1725564092;
	bh=/cxje7cWITxsAyELVRDqwEMAnBWLI0sSrL0z2LlvtHk=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=IwtmzsYCBR7JePSgqoLk4rRMOSezUyu+27cxoT5L6HrJqQ33LJHYeKBG7fdmYjaZS
	 2KfXBvW8MMqYgpZtPZj5qGn9oNvDTrFg88YJe8+4JRarO1G+IdsLW/XyWLzhkmS98e
	 K4Z9GD7wLsFy2emAavBSxmj4075Y1D7KeLrezM2gM9wTUWMEo5IijVS6ApmK8k3RNI
	 3MAJneH9XZY6PPFMSvldR76g0k7HdP2bxG9FIsFhicFJFjgrTfh5YpFXHfqYqqp/9L
	 Uzm3vFSAT7qWzBBX0cv/1Ea1fugM9X5m/kb0B/O2YcG8TYXhsCL/SCy52Rx4y11ZER
	 aa0l4ZixEb55g==
Date: Mon, 02 Sep 2024 19:21:27 +0000
To: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
From: John <therealgraysky@proton.me>
Subject: amd-pstate-epp: CPU freq never hits minimum level booted into OpenWrt but does under Arch
Message-ID: <rc3yUl_FpebZCJhCPscpyJ2UtuKGSwB7B4E4mr4OjdrJFIkftiWJvWrRBwXzMfqICV_NZWqMvyey5Iw3XqyhIhQ3k9beU2p_V8NARfUdQ-M=@proton.me>
Feedback-ID: 47473199:user:proton
X-Pm-Message-ID: 6ab83f79991b4a1de15ebb3699e0c3f6219cac8b
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I have a mini PC based on an AMD Ryzen 7 5800U APU dual booting Arch Linux =
and OpenWrt (snapshot).  When booted into Arch, the cores idle at the minim=
um frequency of 400 MHz with amd-pstate-epp/active.  When I boot into OpenW=
rt with amd-pstate-epp/active however, the lowest frequency the cores will =
drop down to is 1,383 MHz.

As a test, while booted into OpenWrt, I stopped every running daemon and st=
opped all network interfaces.  Checking CPU% in htop showed more or less no=
thing using the CPU that might be keeping it from reaching 400 MHz.

The kernel version for both distros are in parity (currently 6.6.48), but d=
o differ in their respective configs.  I am wondering if kernel config opti=
ons might be to causing this or if there is something else that can be chec=
ked.

# cat /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
powersave
# cat /sys/devices/system/cpu/amd_pstate/status
active
# cat /sys/devices/system/cpu/cpufreq/policy0/scaling_driver
amd-pstate-epp

