Return-Path: <linux-pm+bounces-40037-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 213F8CE9406
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 10:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B48623011A5F
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 09:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B552D24A7;
	Tue, 30 Dec 2025 09:44:30 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9B227A47F;
	Tue, 30 Dec 2025 09:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767087870; cv=none; b=WJRruR4qissOBBRaCg8XepCeQc4vbJp6vzg0PfjvqxqWVlKcFGmNu8Q/qv3kAA+QkLGFSsQUsF+fZ6SkFEFRaGYO3PwWV3UXGck4mRtOykFoE55LSzJviraRrlzE2PfOXGbNqvk6JzZ8wiD7p6AJ/vD90up6R+ul0UweWUcHAu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767087870; c=relaxed/simple;
	bh=gQoHoP5LwK5SZnMkEbhkE4lFRqcVpDxpUMGekE8E5II=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o/8H3n0LHEDmLn+3YJZEOHGhMACI8szu3RTeFV7c/wImXavBGMwb5BoxykJjV30/9EqOfdx0/FGmadYqdEbIddisisT4QVdSTWJtXf/UTkDlYFxcduQ7ocPKtjtrCJkm1Fl6sYC72XiOpdW7JI0KvQR54qWTpkpOn/2IFoNjkms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F038F497;
	Tue, 30 Dec 2025 01:44:20 -0800 (PST)
Received: from [10.57.10.231] (unknown [10.57.10.231])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A1E733F63F;
	Tue, 30 Dec 2025 01:44:24 -0800 (PST)
Message-ID: <849b576e-9563-42ae-bd5c-756fb6dfd8de@arm.com>
Date: Tue, 30 Dec 2025 09:44:21 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for 6.19 0/4] Revise the EM YNL spec to be clearer
To: Changwoo Min <changwoo@igalia.com>
Cc: kernel-dev@igalia.com, linux-pm@vger.kernel.org, horms@kernel.org,
 pabeni@redhat.com, rafael@kernel.org, netdev@vger.kernel.org,
 edumazet@google.com, davem@davemloft.net, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org, lenb@kernel.org, pavel@kernel.org,
 donald.hunter@gmail.com, kuba@kernel.org
References: <20251225040104.982704-1-changwoo@igalia.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20251225040104.982704-1-changwoo@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Changwoo,

On 12/25/25 04:01, Changwoo Min wrote:
> This patch set addresses all the concerns raised at [1] to make the EM YNL spec
> clearer. It includes the following changes:
> 
> - Fix the lint errors (1/4).
> - Rename em.yaml to dev-energymodel.yaml (2/4).  “dev-energymodel” was used
>    instead of “device-energy-model”, which was originally proposed [2], because
>    the netlink protocol name cannot exceed GENL_NAMSIZ(16). In addition, docs
>    strings and flags attributes were added.
> - Change cpus' type from string to u64 array of CPU ids (3/4).
> - Add dump to get-perf-domains in the EM YNL spec (4/4). A user can fetch
>    either information about a specific performance domain with do or information
>    about all performance domains with dump.
> 
> This can be tested using the tool, tools/net/ynl/pyynl/cli.py, for example,
> with the following commands:
> 
>    $> tools/net/ynl/pyynl/cli.py \
>       --spec Documentation/netlink/specs/dev-energymodel.yaml \
>       --dump get-perf-domains
>    $> tools/net/ynl/pyynl/cli.py \
>       --spec Documentation/netlink/specs/dev-energymodel.yaml \
>       --do get-perf-domains --json '{"perf-domain-id": 0}'
>    $> tools/net/ynl/pyynl/cli.py \
>       --spec Documentation/netlink/specs/dev-energymodel.yaml \
>       --do get-perf-table --json '{"perf-domain-id": 0}'
>    $> tools/net/ynl/pyynl/cli.py \
>       --spec Documentation/netlink/specs/dev-energymodel.yaml \
>       --subscribe event  --sleep 10
> 
> [1] https://lore.kernel.org/lkml/CAD4GDZy-aeWsiY=-ATr+Y4PzhMX71DFd_mmdMk4rxn3YG8U5GA@mail.gmail.com/
> [2] https://lore.kernel.org/lkml/CAJZ5v0gpYQwC=1piaX-PNoyeoYJ7uw=DtAGdTVEXAsi4bnSdbA@mail.gmail.com/

My apologies, I've missed those conversations (not the best season).

So what would be the procedure here for the review?
Could Folks from netlink help here?

I will do my bit for the EM related stuff (to double-check them).

Regards,
Lukasz

