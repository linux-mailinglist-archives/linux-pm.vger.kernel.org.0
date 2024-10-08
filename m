Return-Path: <linux-pm+bounces-15355-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F79E9953D1
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 17:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E903AB21FEB
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 15:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26781E008E;
	Tue,  8 Oct 2024 15:52:35 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5A93BBDE
	for <linux-pm@vger.kernel.org>; Tue,  8 Oct 2024 15:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728402755; cv=none; b=VrgPPmKsCPtvT/yEIQrHy/IomriutUXAY1cLvXWVyZ0vnNqvOExMJbFVqE3yy0yqiRGCRB597DB7+7ry1k49wlxBSg79B17IYOhozDktGOvG/f4NeWvcMN15EmhOe2QHbZeW2/m+6luHHgENy3w5MHMpvRRUDoLe380ztWytT1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728402755; c=relaxed/simple;
	bh=7pirjy+jOY6XMziFKRyws/AqPW4k3VyV4m42JkFBf+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=br7E0gue01dy4mFQChrU1lYedYCkpaSpfo0DgIs+SOYN5YZ7Da3Ku8pXxKVP060IivChhkmoVuKNNV8hDSeq7bh12M67ZFoDFb4tMn/0m82jprTd6stqWHWr0LHqT90yV1q97rLk+9xcMokCbdsbZlgO0KledKPM0dfJrIh1qtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA48FDA7;
	Tue,  8 Oct 2024 08:53:02 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.77])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E0FA3F73F;
	Tue,  8 Oct 2024 08:52:32 -0700 (PDT)
Date: Tue, 8 Oct 2024 16:52:30 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Vivek yadav <linux.ninja23@gmail.com>
Cc: linux-pm@vger.kernel.org, lpieralisi@kernel.org, ulf.hansson@linaro.org,
	Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: ARM64: Where do I get CPU Sleep states parameters ?
Message-ID: <ZwVVPtVXxX4rGFbx@bogus>
References: <CAO6a-9-cp7CazJ4+-b3gwD2Q5n4SaA=5=Ps3ycJ9Xq_ZidDB+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO6a-9-cp7CazJ4+-b3gwD2Q5n4SaA=5=Ps3ycJ9Xq_ZidDB+A@mail.gmail.com>

On Tue, Oct 08, 2024 at 08:46:52PM +0530, Vivek yadav wrote:
> Hi @all
>
> Recently I was exploring the CPUIdle menu governor. I found out that
> there are CPUIdle states. These C- states are defined in the device
> tree based on these `cpu-idle-state` parameters. The menu governor
> makes intelligent decisions. So it can save precious power resources.
>
> I had one custom SoC which had a CPU `arm,cortex-a55`. Now I am
> looking for CPU properties i.e exit_latency, entry_latency and
> min-residency.
>
> Below there are two different SoC using the same arm,cortex-a55 CPU. But
> they are using different values.
>
> Q.1: There are entry | exit | min-latency-us. Where will I get all that
> information? I searched into ARM manuals but I did not get it ? Please
> point me in the right direction if you know about this.

It is completely SoC/platform or even board specific parameter. One needs
to measure it for that configuration and then populate the value in DT.

> Q.2: It looks like every SoC is using any value ? Why is there no fixed
> latency time ?

There can't be a fixed value that works across platforms as the value
is depends on various characteristics of a given platform.

> Q.3:  What is the meaning of ``arm,psci-suspend-param`` ? Where do I get
> this information? It is some fixed value.

Even this is not fixed, but if you follow some guidelines in the spec,
you can have a fixed pattern based values. But that is completely optional.
The firmware may choose a value compliant to the spec and you just put that
in the DT for OS to use it when entering the required state.

> Q.4: Is it necessary to add  ``local-timer-stop`` ? In ``config`` file we
> are providing information about the CPU periodic tick whether we want to
> use a tickless governor or not ?

Again it depends. The DT bindings explain all these IIRC. Anyways if you
CPU local timers(it will be mostly architected timer on arm64) gets turned
off when the CPU enters the C state, then you need to add this boolean
property.

>
> FILE NAME :::   ``arch/arm64/boot/dts/mediatek/mt8186.dtsi``.
>
> ``` <Code Block>
>                 idle-states {
>                         entry-method = "psci";
>
>                         cpu_ret_l: cpu-retention-l {
>                                 compatible = "arm,idle-state";
>                                 arm,psci-suspend-param = <0x00010001>;
>                                 local-timer-stop;

It is unlikely a retention state will have its local CPU timer turned off
but it may be true on this platform. I don't know.

>                                 entry-latency-us = <50>;
>                                 exit-latency-us = <100>;
>                                 min-residency-us = <1600>;
>                         };
>
>                         cpu_ret_b: cpu-retention-b {
>                                 compatible = "arm,idle-state";
>                                 arm,psci-suspend-param = <0x00010001>;
>                                 local-timer-stop;
>                                 entry-latency-us = <50>;
>                                 exit-latency-us = <100>;
>                                 min-residency-us = <1400>;
>                         };
>
>                         cpu_off_l: cpu-off-l {
>                                 compatible = "arm,idle-state";
>                                 arm,psci-suspend-param = <0x01010001>;
>                                 local-timer-stop;
>                                 entry-latency-us = <100>;
>                                 exit-latency-us = <250>;
>                                 min-residency-us = <2100>;
>                         };
>
>                         cpu_off_b: cpu-off-b {
>                                 compatible = "arm,idle-state";
>                                 arm,psci-suspend-param = <0x01010001>;

These psci-suspend-param looks like they have followed the recommendation/
example in the specification.

--
Regards,
Sudeep

