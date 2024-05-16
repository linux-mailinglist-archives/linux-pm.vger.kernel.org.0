Return-Path: <linux-pm+bounces-7913-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EEC8C786F
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2024 16:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33E11B217D9
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2024 14:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF8A14A097;
	Thu, 16 May 2024 14:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="apXo/w1e"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA81A146583;
	Thu, 16 May 2024 14:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715869982; cv=none; b=rdxvYtL+eKFqkva1mwWafz3SnwR3ZJli9+ZW5zCMvorqsS5sJVodpHbovqjLDQR6btk5WBIFFiJKhOlTOPGGOlueW2bhBmYYpJl6F13PD1YFnmYc00yqyjHGHPweIIg7RZQ5uV0Rf7QQUvV8wsuaXackeoHCkn78l7HhspdVakY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715869982; c=relaxed/simple;
	bh=YSGxDHo3S40XhBcX0j2/tal+VEhClJzUNvlb3qCnLIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IPz35xBW9sZVItf0wOWaLpr86sqYbDSIzeuGScpPnsJDCnRQQeQ4ZfmzPCIWyoO0hiwD327GM5lvPEqSwqDsxDMLgTbUyM33o9mg0DMn4sHt3g0zCx7J3exc/WclmAIHvSnz4Gz1a6iR1pV63S5QSMGn3cF7iWCHIeNVUxwXZDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=apXo/w1e; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715869981; x=1747405981;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YSGxDHo3S40XhBcX0j2/tal+VEhClJzUNvlb3qCnLIc=;
  b=apXo/w1eUkWVaOKEVTa8mFwBufWkQjKb7Cpc4otDanJUVvU6FBwIRCzx
   AtUZyt1BgBN19kq19SoPTmOU5GKEbRUUbPOfwRqz3aqDGfeR3OTjEgAiZ
   WiSdE4jMVCm1YDOJeygcvdzZLMpJGovyuSMbjIapgy2VDl8EBs+eRqb87
   SKHn2l9iLyDEUcXr+jmVopeSjU6AQRkv45aNOpO3H6Qc70wcI4qOg2cNo
   klhFKzX/p0ieQyaaJIKI8S+eqDE0JuzN3fgdtcFyDphSt2zbZH/RQWZVW
   LMaVNRxbZvaOrPl1P0kcIVWZYIA4oQnthWJy4JRfSGHTkLjDzIoby7BHo
   g==;
X-CSE-ConnectionGUID: nhToMylzSfeiGLqrv483EQ==
X-CSE-MsgGUID: +gfU+l0IQQ2NeMFZHYkvqw==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="37362557"
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="37362557"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 07:32:56 -0700
X-CSE-ConnectionGUID: qT3LVgguTjagpzKBkxF5LA==
X-CSE-MsgGUID: eLMovlXtQFGJ1mzLFvc1pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="35879219"
Received: from angaikwa-mobl1.amr.corp.intel.com (HELO [10.212.163.41]) ([10.212.163.41])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 07:32:55 -0700
Message-ID: <ab00d8e5-8400-451e-9435-becb0b3fa80c@intel.com>
Date: Thu, 16 May 2024 07:32:54 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [regression] suspend stress test stalls within 30 minutes
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Kalle Valo <kvalo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, x86@kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev, Jeff Johnson <quic_jjohnson@quicinc.com>,
 Daniel Sneddon <daniel.sneddon@linux.intel.com>
References: <20240511184945.GDZj-9yaOEWqf1ng8u@fat_crate.local>
 <87h6f4jdrq.fsf@kernel.org> <878r0djxgc.fsf@kernel.org>
 <874jb0jzx5.fsf@kernel.org> <feaefaae-e25b-4a48-b6be-e20054f2c8df@intel.com>
 <20240515072231.z3wlyoblyc34ldmr@desk>
 <529C9374-DA6F-49C8-9B32-91741800F8E4@alien8.de>
 <20240515162747.6shmaoelc4mt7nro@desk> <878r0bhvjq.fsf@kernel.org>
 <20240516070315.swz2golcrfp3uvfd@desk> <20240516142513.qqy7wbmja5frizuj@desk>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20240516142513.qqy7wbmja5frizuj@desk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/16/24 07:25, Pawan Gupta wrote:
> On Thu, May 16, 2024 at 12:03:22AM -0700, Pawan Gupta wrote:
>> I am running the suspend test now and will update in the morning if I
>> could reproduce the hang.
> Completed 500 suspend iterations, but the hang is not reproduced 🙁
> I have restarted the test.
> 
> BTW, could you please share your /proc/cmdline? Also, was there any
> workload running with the suspend test? If I could not reproduce it in the
> next run, I will run stress-ng with the suspend test.

I'd suggest two things:

  * Run everything in tools/testing/selftests/x86 in a loop during the
    suspend test.
  * Run perf or something else to generate some NMIs.

Those will ensure the dark corners of the entry code are being
sufficiently prodded.

I also have sneaking suspicion that microcode updates during resume are
the aggravating factor.

