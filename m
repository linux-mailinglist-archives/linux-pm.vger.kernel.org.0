Return-Path: <linux-pm+bounces-8454-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBFD8D602A
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 13:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5052E1C237EC
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 11:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011FD156679;
	Fri, 31 May 2024 11:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DxsIJKJO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rhn4VRIB"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D8A156672
	for <linux-pm@vger.kernel.org>; Fri, 31 May 2024 11:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717153325; cv=none; b=fc6Fy4+VxXQSigDK+8ok5Q1lPheJkeIWSnWYbG4s0DF5hxMB+h4clX7W1xYZ/ddUYCsgdwo6CSZQNqyH2RamSXXGLpc8P5VQNYN2t7PudoqHMlUcOadW/QyXvhENj3kUfyUI8v4BXhKV1+s7v4nFdsl+lQukQdSWYIP8fZkBm/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717153325; c=relaxed/simple;
	bh=jzL3hfpxmXneUGW/UYHOJgn5/fmNs5xLODecMz63oe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cRCzfta/VxfNggAK1rWzXi9VO1YY7R+YzLYdARQAKA8ZQwDBto8MG+X9VmA0dc86KMD4s6xaB5II0fRqVpFTQrYiiXFetFUU4yKuYcgA1o93UwPE5qr8LwPiHWD4RLUDTWCqT5IJ7nR0ZuUhmwpAityFlOfRegb1l200UPStpT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DxsIJKJO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rhn4VRIB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 31 May 2024 13:02:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717153322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DeRURr3mqoNqeC3e7tZqYgYygcoQRvurqbWOr4DRWGQ=;
	b=DxsIJKJOKs+TkqgYuYr4VN8AK5yLuNmGCrPh5Oig0/isfd4Ad0JEVhk44vTf2eZH/yUZLv
	SsDNSjypE50eJHGduLYnrVkCNIB28/JkJCDB1/THEermmOUydyapNgWoC1Rk/+Ps6ZrUaL
	We120mGjvzV2sTsnkq7komYvruUXZZpej+IWuKdpF+85aGoQkAhhmOIbpBxruf5ee+daiX
	40VnekPVFoF8tia3yZngB27uW4dlcxGy/uiVVMKoFu66bTigJi900rIo/XWodmKHanejXt
	YdIGCK2mAlPoztOmoTgCxzcytOvLDrPLj/Op5i79qwTFcW+xDFSbsivgca6rVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717153322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DeRURr3mqoNqeC3e7tZqYgYygcoQRvurqbWOr4DRWGQ=;
	b=rhn4VRIBg11e3D/17F4+uOqumttt5k3mCKbmnkEQa9pvJ2hufRSLG/rPmvGE5ktoHXyf9w
	WetYFS39LQaLrRAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: intel_pstate_get_hwp_cap on wrong CPU
Message-ID: <20240531110200.CtBSN_p4@linutronix.de>
References: <20240529155740.Hq2Hw7be@linutronix.de>
 <ca47b6f812175ea60f6ad615274223aa7fee295d.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ca47b6f812175ea60f6ad615274223aa7fee295d.camel@linux.intel.com>

On 2024-05-29 16:08:19 [-0700], srinivas pandruvada wrote:
> Hi Sebastian,
Hi,

> On Wed, 2024-05-29 at 17:57 +0200, Sebastian Andrzej Siewior wrote:
> > Hi,
> >=20
> > this just popped up:
> > > [ 6538.614568] unchecked MSR access error: RDMSR from 0x771 at rIP:
>=20
> Please check if the attached change fixes?

it should based on the callchain. Let me test it in a few=E2=80=A6

Would you mind letting
  /sys/devices/system/cpu/intel_pstate/num_pstates

reporting something sane? Not 4294967285 but 0 for instance? Would that
make sense?

But
=E2=80=A6
> From f85a83508ef029bceaf9192cb648d66f32b61d02 Mon Sep 17 00:00:00 2001
> From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Date: Wed, 29 May 2024 15:30:49 -0700
> Subject: [PATCH] cpufreq: intel_pstate: Fix unchecked HWP MSR access
>=20
> HWP MSR 0x771 can be only read on a CPU which supports HWP and enabled.
> Hence intel_pstate_get_hwp_cap() can only be called when hwp_active is
> true.
>=20
> Reported-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Did Sebastian _Reichel_ report it, too?

> Closes: https://lore.kernel.org/linux-pm/20240529155740.Hq2Hw7be@linutron=
ix.de/

Because this my report ;)

> Fixes: e8217b4bece3 ("cpufreq: intel_pstate: Update the maximum CPU frequ=
ency consistently")
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Sebastian

