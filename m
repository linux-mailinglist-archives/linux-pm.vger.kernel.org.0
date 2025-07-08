Return-Path: <linux-pm+bounces-30406-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39649AFD957
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 23:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2787A1C26F30
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 21:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B533242D68;
	Tue,  8 Jul 2025 21:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTYar3in"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23F52248AC;
	Tue,  8 Jul 2025 21:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752009170; cv=none; b=EYjPWZlGhGpX2dnMNUIFgdmvuyyw4kDJKnU5MGDvDdOe5htldNSstjJXWMmQ2du8OVN6aZ3MvlrQBZ0pv5Ug+4G9jmZmkKVHpVEuAkEVdXFcPE+nTorD1XCz2kLSv8qYpHuWVdXH1Fa5Xw4PgXICEQS/gXZEtTP6Rl0Q51j7Tr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752009170; c=relaxed/simple;
	bh=K4/mhorGXlQlibx/zxFoJM84RWBgByZh+f2WBBkRw/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fBloDYplNxOHKHlI4KWsjfC+lZxQ2Lh68U+Af8rhWCQK9Ct4mMz4KQ89y0IUV5Sxl4lK6/KOy4uG2u1tqY5iZmzc5sroFvw3oAtoVk0ykeVR3FhWPb0hVXjtBIeavpxn9aK99p4Kuv2ujOCXwd/SGospKilXJjr+fO5nJgy0Ips=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lTYar3in; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE6FC4CEF1;
	Tue,  8 Jul 2025 21:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752009169;
	bh=K4/mhorGXlQlibx/zxFoJM84RWBgByZh+f2WBBkRw/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lTYar3inYh2MSpFvvrCbv/Oodl2UGAfXQJMvwTFv3e297kUVCwY1B4Umbl5hURNmT
	 fECE3wvW6QLT+9o8LZ7Y4hkeuFx7khE2Tf2rqB3eC1oU4uz0bZqN+DGKjIXB8wbxEY
	 +tWR3zkDeRaIs9UMzvOsady6aLP/+PTjq83aJI0oqOvWz7Xs90ql//ls03I22pG05R
	 RGyy+KZX+hOsIRnt9tijTtqtH5PmVr6okt8A67hCiPq9H5pPDE8ocEBv+oODKW9VfB
	 f4XkwX6oqFOlNCxHVO4/al7fTRV8Fe/zBcDSU8JyCqsJeh5PpuW7AedZyTC9eFnKnl
	 HhhiM8b7YMVoA==
Date: Tue, 8 Jul 2025 17:12:46 -0400
From: Sasha Levin <sashal@kernel.org>
To: Willy Tarreau <w@1wt.eu>
Cc: Pavel Machek <pavel@ucw.cz>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	patches@lists.linux.dev, stable@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	Nat Wittstock <nat@fardog.io>, Lucian Langa <lucilanga@7pot.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	rafael@kernel.org, len.brown@intel.com, linux-pm@vger.kernel.org,
	kexec@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 6.15 6/8] PM: Restrict swap use to later in the
 suspend sequence
Message-ID: <aG2JzsVKuBkFcXj9@lappy>
References: <20250708000215.793090-1-sashal@kernel.org>
 <20250708000215.793090-6-sashal@kernel.org>
 <87ms9esclp.fsf@email.froward.int.ebiederm.org>
 <aG2AcbhWmFwaHT6C@lappy>
 <aG2BjYoCUYUaLGsJ@duo.ucw.cz>
 <20250708204607.GA5648@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250708204607.GA5648@1wt.eu>

On Tue, Jul 08, 2025 at 10:46:07PM +0200, Willy Tarreau wrote:
>On Tue, Jul 08, 2025 at 10:37:33PM +0200, Pavel Machek wrote:
>> On Tue 2025-07-08 16:32:49, Sasha Levin wrote:
>> > I've gone ahead and added you to the list of people who AUTOSEL will
>> > skip, so no need to worry about wasting your time here.
>>
>> Can you read?
>>
>> Your stupid robot is sending junk to the list. And you simply
>> blacklist people who complain? Resulting in more junk in autosel?
>
>No, he said autosel will now skip patches from you, not ignore your
>complaint. So eventually only those who are fine with autosel's job
>will have their patches selected and the other ones not. This will
>result in less patches there.

The only one on my blacklist here is Pavel.

We have a list of folks who have requested that either their own or the
subsystem they maintain would not be reviewed by AUTOSEL. I've added Eric's name
to that list as he has indicated he's not interested in receiving these
patches. It's not a blacklist (nor did I use the word blacklist).

https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/ignore_list

-- 
Thanks,
Sasha

