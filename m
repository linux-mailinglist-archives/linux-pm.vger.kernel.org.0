Return-Path: <linux-pm+bounces-5087-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B9487F3C3
	for <lists+linux-pm@lfdr.de>; Tue, 19 Mar 2024 00:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8AC2282FD8
	for <lists+linux-pm@lfdr.de>; Mon, 18 Mar 2024 23:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F525BAE4;
	Mon, 18 Mar 2024 23:04:06 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FACA5A7B6;
	Mon, 18 Mar 2024 23:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710803046; cv=none; b=ZueQLPCVHB1lA46YkVHCHfsFAuetPxyu+wa4RNEJScFMB8Qil6SuICItHSMlB/faZWaihLhLry9B5pTxD0S6YN/w4kb/osYPLJXWbtJYUdgk0v+t1c5J2tTqza3iGdL4bdPiaRYxaOpnlgA+CTm/6wmvId/yYTbKmO9B4a9rdXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710803046; c=relaxed/simple;
	bh=dEnUrdYzB2esJ0bP5FqG8zL7R+wdwRz0lvaq+6mDJp8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kOQWso/1yX67NYmWZi2Z7VZiCSJHgMVD9xo+hRGvvj+uALzqtCJBkPAQat934QOcSuCg89RM/TqamdY4iyKKOkYYdbwvrLyxftaK75/nKgWX94VyU1gyWmwPRCD3dlqfu785uGsN7hMghgtbFRDdDXyiWhyYwJ9UU1wnEyWMpj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8ADA9DA7;
	Mon, 18 Mar 2024 16:04:32 -0700 (PDT)
Received: from minigeek.lan (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 392793F64C;
	Mon, 18 Mar 2024 16:03:55 -0700 (PDT)
Date: Mon, 18 Mar 2024 23:03:33 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Amit Singh Tomar <amitsinght@marvell.com>
Cc: Yangtao Li <tiny.windzz@gmail.com>, Viresh Kumar <vireshk@kernel.org>,
 Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Brandon Cheo Fusi
 <fusibrandon13@gmail.com>, Martin Botka <martin.botka@somainline.org>,
 Martin Botka <martin.botka1@gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH v2 8/8] arm64: dts: allwinner: h616:
 enable DVFS for all boards
Message-ID: <20240318230333.72c1b6ed@minigeek.lan>
In-Reply-To: <8425a1a2-8453-b705-2c14-a846fa05ae21@marvell.com>
References: <MW4PR18MB5084E8C6D673B73FC208190BC62D2@MW4PR18MB5084.namprd18.prod.outlook.com>
	<20240318105153.2c666647@donnerap.manchester.arm.com>
	<8425a1a2-8453-b705-2c14-a846fa05ae21@marvell.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Mar 2024 00:41:33 +0530
Amit Singh Tomar <amitsinght@marvell.com> wrote:

Hi,

> >>
> >> With the DT bindings now describing the format of the CPU OPP tables, we can include the OPP table in each board's .dts file, and specify the CPU power supply.
> >> This allows to enable DVFS, and get up to 50% of performance benefit in the highest OPP, or up to 60% power savings in the lowest OPP, compared to the fixed 1GHz @ 1.0V OPP we are running in by default
> >> at the moment.
> >> [Amit] Could you please elaborate, what test were run to see 50 % performance benefits?  
> > 
> > Currently all H616 boards running mainline firmware and kernels run at a
> > fixed 1GHz CPU clock frequency. If you happen to have a good SoC (bin 1 or
> > 3), this patchset will allow you to run at 1.5 GHz, which is 50% faster.
> > So anything that scales with CPU frequency should run much quicker.
> >   
> Okay, it would be interesting to see results of some benchmark here.

But why? This is not a performance optimisation, it's adding a missing
feature, because the CPU was locked to 1 GHz before, for safety
reasons, due to missing thermal and DVFS capability. Now it's able to
run at up to 1.5 GHz, as specified.
If you are upset about the bold claim, I can just remove it from the
commit message, it was just a heads up that we were leaving a lot of
performance on the table at the moment.

Posting absolute performance numbers is a tricky subject, legally, so
please run your own: http://www.netlib.org/benchmark/linpackc.new
$ musl-gcc -s -static -Ofast -o linpack linpack.c -lm -march=native -fno-math-errno -funsafe-math-optimizations
$ gcc --version
gcc (Debian 12.2.0-14) 12.2.0
# echo userspace > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
# echo 1008000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed
$ ./linpack
# echo performance > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
$ ./linpack
$ dc -e '3k $high $low /p'
1.498

Cheers,
Andre

