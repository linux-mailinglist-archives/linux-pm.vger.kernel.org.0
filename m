Return-Path: <linux-pm+bounces-36052-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2B5BD8979
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 11:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C41C426EB6
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 09:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FE02F5A01;
	Tue, 14 Oct 2025 09:50:05 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9D02EAD10;
	Tue, 14 Oct 2025 09:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760435405; cv=none; b=UeReyUtrpwgvSULfhdBwBbuQJIEllSg+f9FwBXUDV9fkWW+vvRCqcRR8VpXdxbS/rWw2g4A+Q5FA3VpfZK1iWL7M8zEX3p28yqqMQxqgJmcCUeI3RfhHuXI3EIuzyiqenyuRri3vDI/jwQNA/Gwy2GsSYrK71AN+eFCaKcB/h0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760435405; c=relaxed/simple;
	bh=mPTNqxO/sGSrbmTMekx3Kj5pKBunj3cwknfyZd7hG1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kvt35nQ7AWofPD42GiNb8QZu+l6romgVQ16fRqztRuI147TcTVc+kXRW8KisfGduFKD3BLP40SAQRS/+6lt+6MVnQEevmv99V9ehzQlV6kUds0EjRvF5/C2OISRfH4AFOncDWLKJtwwV3AxEDcrb6eyoxwopa0O7ganHvRKPR10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A7151A9A;
	Tue, 14 Oct 2025 02:49:55 -0700 (PDT)
Received: from [10.57.66.74] (unknown [10.57.66.74])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 113473F66E;
	Tue, 14 Oct 2025 02:50:00 -0700 (PDT)
Message-ID: <08529809-5ca1-4495-8160-15d8e85ad640@arm.com>
Date: Tue, 14 Oct 2025 10:50:02 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: stable: commit "cpuidle: menu: Avoid discarding useful
 information" causes regressions
To: Sergey Senozhatsky <senozhatsky@chromium.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Sasha Levin <sashal@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Tomasz Figa <tfiga@chromium.org>, stable@vger.kernel.org
References: <36iykr223vmcfsoysexug6s274nq2oimcu55ybn6ww4il3g3cv@cohflgdbpnq7>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <36iykr223vmcfsoysexug6s274nq2oimcu55ybn6ww4il3g3cv@cohflgdbpnq7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/14/25 08:43, Sergey Senozhatsky wrote:
> Hello,
> 
> We are observing performance regressions (cpu usage, power
> consumption, dropped frames in video playback test, etc.)
> after updating to recent stable kernels.  We tracked it down
> to commit 3cd2aa93674e in linux-6.1.y and commit 3cd2aa93674
> in linux-6.6.y ("cpuidle: menu: Avoid discarding useful information",
> upstream commit 85975daeaa4).
> 
> Upstream fixup fa3fa55de0d ("cpuidle: governors: menu: Avoid using
> invalid recent intervals data") doesn't address the problems we are
> observing.  Revert seems to be bringing performance metrics back to
> pre-regression levels.

Any details would be much appreciated.
How do the idle state usages differ with and without
"cpuidle: menu: Avoid discarding useful information"?
What do the idle states look like in your platform?

