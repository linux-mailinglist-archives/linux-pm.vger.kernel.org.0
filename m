Return-Path: <linux-pm+bounces-7949-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C858C8C34
	for <lists+linux-pm@lfdr.de>; Fri, 17 May 2024 20:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8EDD2845FA
	for <lists+linux-pm@lfdr.de>; Fri, 17 May 2024 18:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED6112FB08;
	Fri, 17 May 2024 18:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CAJXcxHI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93ED41FC8;
	Fri, 17 May 2024 18:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715970134; cv=none; b=YEP8JVoBa/tFVaO6JvYZYwETa7ZRY94145YKyNzS6i8KGPFv73NyZHxGvhKrBbH6Y9eRPkQtR/wp1de3wPW8AgPWWmdYFk/0sZVVhfSTvRdvItaV+g2AA+1DGv4K2V9e8IJYi0PiXLoHjxIeGY8HU0rLpfeXzIB7OhwBHqtUdrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715970134; c=relaxed/simple;
	bh=EwkmU5I4ug4JOYE7xX0QXVZ/KNP0gdUYZGWe5VRcPLI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ql+qTSO90hkBbsb35jogh5wcRaQA0oTf7Z/FJA6TOqTvu2uzWN9w07uLPcMMy93Jq3ikD++GMVR+adKv8p+tHFZVDIAKeNcueQnVJjUlaXLfdmB/68QE3F0gXRjNQTnabVjPcZ05yityBCrQrtm5IFNqMq4PlLMuBW2G5+D0x6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CAJXcxHI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B16C5C2BD10;
	Fri, 17 May 2024 18:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715970134;
	bh=EwkmU5I4ug4JOYE7xX0QXVZ/KNP0gdUYZGWe5VRcPLI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=CAJXcxHIx8NJrDAea5sluXd0jcn3DnG/W72bOyKcI1cSxur8crcoakSNzVoCMFbL/
	 mc+INzNvgdbxXuefnmlya83RELKQzzADN+TFJHAFTMmkokP9MwG6sMw6DS6WQfFzF1
	 0tXMOCvMbiNPE1kHyB6dAqQMvuLL7g+pgC4oevh0uIKazXiiQHy0UaiTH09rE7yaKD
	 rwN56OpPecWDy+sNZesU1Wit5dzy8qhyLTLIA8f+VgycIaTw7YEQhjohyEBtyBcrZn
	 hl6CNHmVAHPmM8pRMC6W4kGakVqQsvCZhV4O+h9JkVq+C5Z5CnMjGCu2QgThDIk0dp
	 RrGItsdQVObYw==
From: Kalle Valo <kvalo@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,  Thomas Gleixner
 <tglx@linutronix.de>,  Ingo Molnar <mingo@redhat.com>,  Dave Hansen
 <dave.hansen@linux.intel.com>,  "Rafael J. Wysocki" <rafael@kernel.org>,
  x86@kernel.org,  linux-pm@vger.kernel.org,  linux-kernel@vger.kernel.org,
  regressions@lists.linux.dev,  Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: Re: [regression] suspend stress test stalls within 30 minutes
References: <87o79cjjik.fsf@kernel.org>
	<20240511184847.GCZj-9j2sh1Akpt9iS@fat_crate.local>
	<20240511184945.GDZj-9yaOEWqf1ng8u@fat_crate.local>
	<87h6f4jdrq.fsf@kernel.org> <878r0djxgc.fsf@kernel.org>
	<874jb0jzx5.fsf@kernel.org>
	<20240514160555.GCZkOL41oB3hBt45eO@fat_crate.local>
	<87msoofjg1.fsf@kernel.org>
	<20240517172603.GEZkeTK246tBvGEtgF@fat_crate.local>
Date: Fri, 17 May 2024 21:22:09 +0300
In-Reply-To: <20240517172603.GEZkeTK246tBvGEtgF@fat_crate.local> (Borislav
	Petkov's message of "Fri, 17 May 2024 19:26:03 +0200")
Message-ID: <875xvcfgdq.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Borislav Petkov <bp@alien8.de> writes:

> On Fri, May 17, 2024 at 08:15:58PM +0300, Kalle Valo wrote:
>> So the weird part is that when the bug happens (ie. suspend stalls) I
>> can access the box normally using ssh and I don't see anything special
>> in dmesg. Below is a full copy of dmesg output after the suspend
>> stalled. Do note that I copied this dmesg before I updated microcode so
>> it will still show the old microcode version.
>
> Does that mean that you'd still see the stall even with the latest
> microcode revision 0xf8?

Yeah, no luck with that. I have more information in my other email.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

