Return-Path: <linux-pm+bounces-15387-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A44996788
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2024 12:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C886EB21005
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2024 10:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC52218D658;
	Wed,  9 Oct 2024 10:45:21 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CFD17C7CC
	for <linux-pm@vger.kernel.org>; Wed,  9 Oct 2024 10:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728470721; cv=none; b=WBfI9Jp7x74xShIqtTAMOtfpv292k6JuW66otXNS4OYXxq9sF2poPU0USFi6QqBxN0nm2vbW24TeICUyDnU6KW82824pPkkhNLii1lgiKzTxfMgUTL3IV+oNFbtU4FeN+aYINiqD22Lh6uu7OJpcylmoxwSWUyxuUBPfDv85N84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728470721; c=relaxed/simple;
	bh=/L/wlpeabUbvg27h4GCPWZbC0VS25xvv1ryvsUKZs44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G0/eAseT6lA6KxbnFNXVsYWhTGGpaXs7NsgHbnUjjc15FYRaEBHwKOqE3hYcqT8zJwBFbpcBxHeNe0UkDhmE1xRMQmmCB12p3+8+6e3JYSnMNrOmaOZaaAuzv2Gg+lXTpRx7rZrbrnGy0Hp0FD0x7eTe78yTy6GIcwxiVJaCKqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F575FEC;
	Wed,  9 Oct 2024 03:45:49 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.77])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 94F373F64C;
	Wed,  9 Oct 2024 03:45:18 -0700 (PDT)
Date: Wed, 9 Oct 2024 11:45:15 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Vivek yadav <linux.ninja23@gmail.com>
Cc: linux-pm@vger.kernel.org, lpieralisi@kernel.org, ulf.hansson@linaro.org,
	Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: ARM64: Where do I get CPU Sleep states parameters ?
Message-ID: <ZwZeu_0hKiBPstp2@bogus>
References: <CAO6a-9-cp7CazJ4+-b3gwD2Q5n4SaA=5=Ps3ycJ9Xq_ZidDB+A@mail.gmail.com>
 <ZwVVPtVXxX4rGFbx@bogus>
 <CAO6a-98koymFJM3X1QDdoybz+SdR_g+C5=vbt_BjS=dYOQJBAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO6a-98koymFJM3X1QDdoybz+SdR_g+C5=vbt_BjS=dYOQJBAg@mail.gmail.com>

On Wed, Oct 09, 2024 at 07:47:18AM +0530, Vivek yadav wrote:
> >> Hi @all
> >>
> >> Recently I was exploring the CPUIdle menu governor. I found out that
> >> there are CPUIdle states. These C- states are defined in the device
> >> tree based on these `cpu-idle-state` parameters. The menu governor
> >> makes intelligent decisions. So it can save precious power resources.
> >>
> >> I had one custom SoC which had a CPU `arm,cortex-a55`. Now I am
> >> looking for CPU properties i.e exit_latency, entry_latency and
> >> min-residency.
> >>
> >> Below there are two different SoC using the same arm,cortex-a55 CPU. But
> >> they are using different values.
> >>
> >> Q.1: There are entry | exit | min-latency-us. Where will I get all that
> >> information? I searched into ARM manuals but I did not get it ? Please
> >> point me in the right direction if you know about this.
> >
> >It is completely SoC/platform or even board specific parameter. One needs
> >to measure it for that configuration and then populate the value in DT.
>
> One needs to measure it means there are tools to measure CPUIdle time
> OR  do you mean these latency values need to be fine tuned by developer
> via hit and trial method. Which suits the SoC/board.
> Please correct me if I am wrong.
>

I wouldn't say trial and error. It involved trying to hit worst case scenario
and taking some timing info on the platform(via trace or whatever suits best
on the platform and the firmware running). E.g. Can you access cache memory on
DRAM in such a way that achieves maximum dirty cacheline ? Some power
measurements by forceful wakeup so that you can get better tuned value for
minimum residency.


--
Regards,
Sudeep

