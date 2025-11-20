Return-Path: <linux-pm+bounces-38291-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FBCC736E2
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 11:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 874D9346348
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 10:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF2E2ECEB9;
	Thu, 20 Nov 2025 10:15:19 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962D6309EED;
	Thu, 20 Nov 2025 10:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763633718; cv=none; b=bmgD4zHM9Tj6nvDU2/AZzzR5Dwo/67CpffqaZC0xD4jnVrt7mUaYi/3zUzkKpBuZxhtO0oCZlHJiaXKtOiqTwxeqtJo+XZqeHA+AWGI9YSJLwBoi+oV69zZFjIKNLx3HliIQirGz6DyS3wGlLwF4A6qdAAn+Ty6Z8tlB2F3FXjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763633718; c=relaxed/simple;
	bh=loXVUfGAR8yZeg6xGd/+FmzKfQ1bBsRPt2WRS8k3xvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RmxAN1yp+aBxts0+pWXg3eIkGdQ1L9Nc4SWu4hsNUbAlPC7De0c1Gswc8UQsvFjR1sA+w4qXmiZTBAc3bEH/NDujsCN5zHq2DUIyzIUzNp8F6Zb8IBjBJZ5Rc2fPoz4f5C37s7JrWzoQwSxuE+FryZuuz62Qqgbrxwhn8myfRVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8EB57339;
	Thu, 20 Nov 2025 02:15:08 -0800 (PST)
Received: from [10.57.69.158] (unknown [10.57.69.158])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C70F3F740;
	Thu, 20 Nov 2025 02:15:13 -0800 (PST)
Message-ID: <86d759a5-9a96-49ff-9f75-8b56e2626d65@arm.com>
Date: Thu, 20 Nov 2025 10:15:11 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: stable 6.6: commit "sched/cpufreq: Rework schedutil governor
 performance estimation' causes a regression
To: Sergey Senozhatsky <senozhatsky@chromium.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Yu-Che Cheng <giver@google.com>, Tomasz Figa <tfiga@chromium.org>,
 stable@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>
References: <q2dp7jlblofwkmkufjdysgu2ggv6g4cvhkah3trr5wamxymngm@p2mn4r7vyo77>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <q2dp7jlblofwkmkufjdysgu2ggv6g4cvhkah3trr5wamxymngm@p2mn4r7vyo77>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/25 04:45, Sergey Senozhatsky wrote:
> Hi,
> 
> We are observing a performance regression on one of our arm64 boards.
> We tracked it down to the linux-6.6.y commit ada8d7fa0ad4 ("sched/cpufreq:
> Rework schedutil governor performance estimation").
> 
> UI speedometer benchmark:
> w/commit:	395  +/-38
> w/o commit:	439  +/-14
> 

Hi Sergey,
Would be nice to get some details. What board? What do the OPPs look like?
Does this system use uclamp during the benchmark? How?
Given how large the stddev given by speedometer (version 3?) itself is, can we get the
stats of a few runs?
Maybe traces of cpu_frequency for both w/ and w/o?

