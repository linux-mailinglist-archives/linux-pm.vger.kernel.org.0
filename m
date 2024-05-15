Return-Path: <linux-pm+bounces-7876-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8FA8C6ADD
	for <lists+linux-pm@lfdr.de>; Wed, 15 May 2024 18:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EA3AB21A4E
	for <lists+linux-pm@lfdr.de>; Wed, 15 May 2024 16:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E4B2209B;
	Wed, 15 May 2024 16:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eT5MO/e+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C869B13AF2;
	Wed, 15 May 2024 16:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715791632; cv=none; b=JY9Dki69JmPTozSm+sbpReHRxGdiHBbS+V1rqWeShwtWav6SrdOB8i8Y2quHYC4JcyjtM3dWfHUFcdANp6lKZg4cPp+5XF70h2Fogyn3oDu0AauSmeX5IQQIrcepbOEZj8+50f6F5Q5CP2UWDpjFmsGU5rNz0ZLr25cslF8ZkdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715791632; c=relaxed/simple;
	bh=L/odyKRqQsrv3oMwpmj6d9cuWoQyg51kBDJD34sAGr0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=paEtcxi6NHW2lL5ayFm8kFpI4wijLnDdcV/9b1gJw2ggfbrbB0c2kCyfOIVuPhH9dIrhd43L5CkddMfkq9o4BXH7iHWpTFRNrabvPzM+41CM1uWMjq8pp/QvnWqRiec2PkmjgcCli01ihYmJegaoksyao0Q5YYxYgWwqeVaU4Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eT5MO/e+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75DD8C116B1;
	Wed, 15 May 2024 16:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715791632;
	bh=L/odyKRqQsrv3oMwpmj6d9cuWoQyg51kBDJD34sAGr0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=eT5MO/e+DuumA9oMFQ9ZaTktyhxlRRRzWRiIX2wplPGehs2D88jJbyIoc9KnuoIHB
	 JhbaCPaHy8QYnyomzo+zfQ9eq/XILH6OWCj/adi/lrSNoMjib0hgnB1koW+ATZjN6j
	 Kdct0Zf9Bcu7OjZrVpn5Bxrv84X1Pk/50m+9reCOiEPzjG5AIrMMvHO9tMkIfO/s+O
	 VQWFxBhYqAjmovGZWop5fcJfQGLiRHrOwDeuSP90oHeZA9u97Lzz8vQfWa7RcUc9fo
	 /QL8GI07k1GyD8ggSDMu7zr2wLCRRunbrgeK38Iv7Y/YNmmCAHhadC7QAZ+bZFVmn3
	 EV0c+zVCWWhGw==
From: Kalle Valo <kvalo@kernel.org>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>,  Dave Hansen <dave.hansen@intel.com>,
  Thomas Gleixner <tglx@linutronix.de>,  Ingo Molnar <mingo@redhat.com>,
  Dave Hansen <dave.hansen@linux.intel.com>,  "Rafael J. Wysocki"
 <rafael@kernel.org>,  x86@kernel.org,  linux-pm@vger.kernel.org,
  linux-kernel@vger.kernel.org,  regressions@lists.linux.dev,  Jeff Johnson
 <quic_jjohnson@quicinc.com>,  Daniel Sneddon
 <daniel.sneddon@linux.intel.com>
Subject: Re: [regression] suspend stress test stalls within 30 minutes
References: <87o79cjjik.fsf@kernel.org>
	<20240511184847.GCZj-9j2sh1Akpt9iS@fat_crate.local>
	<20240511184945.GDZj-9yaOEWqf1ng8u@fat_crate.local>
	<87h6f4jdrq.fsf@kernel.org> <878r0djxgc.fsf@kernel.org>
	<874jb0jzx5.fsf@kernel.org>
	<feaefaae-e25b-4a48-b6be-e20054f2c8df@intel.com>
	<20240515072231.z3wlyoblyc34ldmr@desk>
	<529C9374-DA6F-49C8-9B32-91741800F8E4@alien8.de>
	<20240515162747.6shmaoelc4mt7nro@desk>
Date: Wed, 15 May 2024 19:47:05 +0300
In-Reply-To: <20240515162747.6shmaoelc4mt7nro@desk> (Pawan Gupta's message of
	"Wed, 15 May 2024 09:27:47 -0700")
Message-ID: <878r0bhvjq.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pawan Gupta <pawan.kumar.gupta@linux.intel.com> writes:

> On Wed, May 15, 2024 at 09:44:42AM +0200, Borislav Petkov wrote:
>> On May 15, 2024 9:22:31 AM GMT+02:00, Pawan Gupta <pawan.kumar.gupta@linux.intel.com> wrote:
>> > Other interesting thing to try is cmdline
>> >"dis_ucode_ldr".
>> 
>> Right, is his microcode revision 0xf4 the right one for that model?
>
> 0xf4 microcode is not the latest one, the latest is 0xf8:
>
> https://github.com/intel/Intel-Linux-Processor-Microcode-Data-Files/blob/main/intel-ucode/06-9e-09
>
> Kalle, can you please try with 0xf8 and see if the issue is still present?

I can't test right now but I'll try to find time later this week, I will
also reply to other emails then.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

