Return-Path: <linux-pm+bounces-16138-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA299A900D
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 21:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 907EF283B3D
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 19:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9641FCC61;
	Mon, 21 Oct 2024 19:41:52 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C3D1FCF44
	for <linux-pm@vger.kernel.org>; Mon, 21 Oct 2024 19:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729539712; cv=none; b=IrZFht5Zw2NNSX2F3doa5og4jQ90jMX3mK8ev4FyrIMh7drYHYX1voTUA9jCS6JXIpzAHLB1oe8qnQm6lI9zMY/q2QveVGnSurABUEfHieTNdAw/BDUrwpnPy2xp+Js6TSl8BWyEQuwHU7iWZvv9VSEjnVS6wVddNdAHpB1N9EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729539712; c=relaxed/simple;
	bh=GYt3EdMuOgOQK87FAMkGz2k/2aJDrbj8jjNtad2F0lk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SablcZ8ASjdnfPr68RpXKS25OPNe+DUDkWDGb1ngI03cMYAdtxkl7FLzB+ruyimcxET3eUxq9udVGLqoDwJ0kgaAGG8ts81MWGd0/n9YWwWl/Z4F+x/EQgV18dmsXBpF/bJnb7LzkYZmjcGEozCwQ2LZtjdP49hBQlelxU4wYkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F462497;
	Mon, 21 Oct 2024 12:42:18 -0700 (PDT)
Received: from [10.57.65.103] (unknown [10.57.65.103])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D2C4F3F528;
	Mon, 21 Oct 2024 12:41:47 -0700 (PDT)
Message-ID: <41b2ca3d-523d-40e3-81d3-5959942d9eb8@arm.com>
Date: Mon, 21 Oct 2024 20:42:57 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] thermal/netlink: Add the commands and the events
 for the thresholds
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org, quic_manafm@quicinc.com, rafael@kernel.org
References: <20241014094309.1430126-1-daniel.lezcano@linaro.org>
 <20241014094309.1430126-2-daniel.lezcano@linaro.org>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20241014094309.1430126-2-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Daniel,

On 10/14/24 10:43, Daniel Lezcano wrote:
> The thresholds exist but there is no notification neither action code
> related to them yet.
> 
> These changes implement the netlink for the notifications when the
> thresholds are crossed, added, deleted or flushed as well as the
> commands which allows to get the list of the thresholds, flush them,
> add and delete.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   drivers/thermal/thermal_netlink.c    | 236 ++++++++++++++++++++++++++-
>   drivers/thermal/thermal_netlink.h    |  34 ++++
>   drivers/thermal/thermal_thresholds.c |  36 ++--
>   drivers/thermal/thermal_thresholds.h |   2 +-
>   include/uapi/linux/thermal.h         |  27 ++-
>   5 files changed, 307 insertions(+), 28 deletions(-)
> 

Since Rafael asked to wait a bit for the other
changes to go first, I will skip the detailed review
of that patch. I will do that after you add that
new locking scheme.

In general the code looks good.

Regards,
Lukasz

