Return-Path: <linux-pm+bounces-17446-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D309C5EB6
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 18:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 992121F22063
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 17:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FBD20EA2D;
	Tue, 12 Nov 2024 17:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CyZrv9MG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EB620D51D;
	Tue, 12 Nov 2024 17:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731432001; cv=none; b=TzOiKcfLQQo38P1HHka3ADA45iLK4SXuF8QdKL/+f/LXLXO4MIIiRPgb8SE0vhg8Jd1uqJyWEw5H4AY/uyqzXH9gNbcMNw/CLp2OchhgNccsKLFMfbJ6uum8u6eGJssmQr0gsJBVQn/w0yN8FAvjX/AXBsiZgYjseJ+6TXeSmRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731432001; c=relaxed/simple;
	bh=WLVOfxqes1xc6tPBqvZff21GY8qOJvM0DeYgwViWALM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b5Y3uQPWFlN+Eu2fp9LIXufPW+vRogrbHY2KgF+z3Y5rtVHxu+TtyqYzalfnxwDGP9+JeRRBpLo4Tku6CrQGVGioezlcrqtzL5mwmp4ijJh0FD/m12OufAsthsdVlEUHG/aayZ14I12ZchDzk/YsK8ZRsNgEkEQgUAkOSlBmEQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CyZrv9MG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D933C4CECD;
	Tue, 12 Nov 2024 17:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731432001;
	bh=WLVOfxqes1xc6tPBqvZff21GY8qOJvM0DeYgwViWALM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CyZrv9MGookTYoVLPGHnA9463Vw96aWB1Y5hzIo/d7BXLAL8IxQOZ/Bkq/B4bwZm+
	 RYgaIlDvET8ZTAzJjVsqboZOsB4kXJq8srd3YccdvW6zhYsqjKrZN5i04r33LkVDS1
	 Dz/nODORvkdfTCm+dY+8q2xAFGcoW8yuL0IDB8GeyvqKZDbGJLfIvfJwAXBptKerhF
	 LuLo0WFS9xRsMXKGProcWh7O2e9rqQCNoLmFy2f5GwR7RemNx4E6AM3UbVcjGIXIBX
	 4ro9tWq6HRkLq5ktF8Uktj/liMiiLuOa10+2pnnsA6/zRXc40mgQOdK+W1/RRyDXXP
	 QbRQsdiXLGWPw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tAuYW-000000007i6-1ILX;
	Tue, 12 Nov 2024 18:19:56 +0100
Date: Tue, 12 Nov 2024 18:19:56 +0100
From: Johan Hovold <johan@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Sibi Sankar <quic_sibis@quicinc.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	jassisinghbrar@gmail.com, dmitry.baryshkov@linaro.org,
	linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	konradybcio@kernel.org, linux-pm@vger.kernel.org,
	tstrudel@google.com, rafael@kernel.org
Subject: Re: [PATCH V5 0/6] firmware: arm_scmi: Misc Fixes
Message-ID: <ZzOOPJ_gI9TGadzV@hovoldconsulting.com>
References: <20241030125512.2884761-1-quic_sibis@quicinc.com>
 <CAPDyKFoY8CnxF7JXzkT9_WXyM-TJhW4kmTw=H8NEzch32N1_7Q@mail.gmail.com>
 <ZyJeuVIbWkohymW5@pluto>
 <20241106071215.jhnzcn4vkdfr3peg@bogus>
 <CAPDyKFr-pmXEhgUgCapzQX3Hn_UAM632TaG8SdkQXaCn5-y42g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFr-pmXEhgUgCapzQX3Hn_UAM632TaG8SdkQXaCn5-y42g@mail.gmail.com>

On Tue, Nov 12, 2024 at 04:56:26PM +0100, Ulf Hansson wrote:
> On Wed, 6 Nov 2024 at 08:12, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > On Wed, Oct 30, 2024 at 04:28:41PM +0000, Cristian Marussi wrote:
> > > On Wed, Oct 30, 2024 at 05:19:39PM +0100, Ulf Hansson wrote:
> > > > On Wed, 30 Oct 2024 at 13:55, Sibi Sankar <quic_sibis@quicinc.com> wrote:
> > > > >
> > > > > The series addresses the kernel warnings reported by Johan at [1] and are
> > > > > are required to X1E cpufreq device tree changes to land.
> > > > >
> > > > > [1] - https://lore.kernel.org/lkml/ZoQjAWse2YxwyRJv@hovoldconsulting.com/
> > > > >
> > > > > Duplicate levels:
> > > > > arm-scmi arm-scmi.0.auto: Level 2976000 Power 218062 Latency 30us Ifreq 2976000 Index 10
> > > > > arm-scmi arm-scmi.0.auto: Level 3206400 Power 264356 Latency 30us Ifreq 3206400 Index 11
> > > > > arm-scmi arm-scmi.0.auto: Level 3417600 Power 314966 Latency 30us Ifreq 3417600 Index 12
> > > > > arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16
> > > > > arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16
> > > > > arm-scmi arm-scmi.0.auto: Level 4012800 Power 528848 Latency 30us Ifreq 4012800 Index 15
> > > > >
> > > > > ^^ exist because SCP reports duplicate values for the highest sustainable
> > > > > freq for perf domains 1 and 2. These are the only freqs that appear as
> > > > > duplicates and will be fixed with a firmware update. FWIW the warnings
> > > > > that we are addressing in this series will also get fixed by a firmware
> > > > > update but they still have to land for devices already out in the wild.
> > > > >
> > > > > V4:
> > > > > * Rework debugfs node creation patch [Ulf/Dmitry]
> > > > > * Reduce report level to dev_info and tag it with FW_BUG [Johan/Dmitry]
> > > > > * Add cc stable and err logs to patch 1 commit message [Johan]

> Sorry for the delay. I have picked up the remaining patches from this
> series. All applied for fixes and by adding stable tags to them,
> thanks!

As I reported here:

	https://lore.kernel.org/lkml/ZyTQ9QD1tEkhQ9eu@hovoldconsulting.com/

I'm seeing a hard reset on the x1e80100 CRD and Lenovo ThinkPad T14s
when accessing the cpufreq sysfs attributes.

Sibi tracked it down to the first patch in this series ("firmware:
arm_scmi: Ensure that the message-id supports fastchannel") and
reverting that one indeed fixes the reset.

Unfortunately this was only discussed on IRC and was never reported in
this thread.

Ulf, could you please drop the first patch again until we've figured out
how best to handle this?

Johan

