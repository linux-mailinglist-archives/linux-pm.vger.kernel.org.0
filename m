Return-Path: <linux-pm+bounces-7875-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 312EF8C6A8E
	for <lists+linux-pm@lfdr.de>; Wed, 15 May 2024 18:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFC651F232EF
	for <lists+linux-pm@lfdr.de>; Wed, 15 May 2024 16:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8005F15665A;
	Wed, 15 May 2024 16:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rhnems0K"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEB5156652;
	Wed, 15 May 2024 16:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715790480; cv=none; b=QzIhj0+OAuOJegSohwCF7z6G4ld9B3fKtq6VrtJolk0wckCd8TiwniIvDD6k1tiUpfEZ8U/bkUkd6G+w6uSU5mngabI1T7HiFYxqTX93agzb9PFHF07RfxVe0iCzaeoHLukfzZbCp3uLDcGyn8AeqHyETxdO0Smmdg8h5E6MVAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715790480; c=relaxed/simple;
	bh=jLTwDE2tM1RrSMLzY08Yl8r39TfnNu26qJx9fvP8zdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j8GCwhrYlm1F8pbk/NywRuKzXhCDdp4iMdJtFvqT6KQWYOMpOKkJkhUXhmrHMS+fJCukro8DkXgdu78vi6FZUE6DT5175AjBmyK2zuND9YJqVzLoQAM4dHcSzEmbR1ywxRV+CGZyw/4c8DLNDOubIX6u7cp7GXaU5ZBFjxgITDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rhnems0K; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715790479; x=1747326479;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jLTwDE2tM1RrSMLzY08Yl8r39TfnNu26qJx9fvP8zdw=;
  b=Rhnems0K+Y8G1c+SF81BL2A0zgZXaQ5NzoqO4FP2Y9gkDhREiufNM6yO
   usMGQb9s8qzKteleSZMqaABsZY1+1ycHaQumbmINuXmXWIsD6Izq0J6Cc
   aYQPTNuDb0rlq8ocDxUW0Qmi8s7JE/IlwCEQbEa1uylq5ld35KQ6IGDAC
   ck7kfYPB2kelbJq4r4hijNQqN4o20eKeIZ6uGOOv5XZcXJ2k6Joujg/pg
   HECrysUuse996a6lms9WrCCorZ14bE+okzJfW4KJb+58mNQ4F3YvpDHld
   C9Jvq3wTrVWvIkigx9y0DuUDJKdvdwKDJ86PrH0YU+eHu7aGPexcsN5A5
   w==;
X-CSE-ConnectionGUID: 1EMRilOWT5+Huc2M3oodRQ==
X-CSE-MsgGUID: bYfVUZH2RY2n8pCdQ3B/Hg==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="29343176"
X-IronPort-AV: E=Sophos;i="6.08,162,1712646000"; 
   d="scan'208";a="29343176"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 09:27:58 -0700
X-CSE-ConnectionGUID: SIbQWgwTQyusvYfSkXdnZw==
X-CSE-MsgGUID: n1X5JlgXRmaFH7/gG0TZhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,162,1712646000"; 
   d="scan'208";a="68571500"
Received: from aalamats-mobl1.amr.corp.intel.com (HELO desk) ([10.209.18.14])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 09:27:57 -0700
Date: Wed, 15 May 2024 09:27:47 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@intel.com>, Kalle Valo <kvalo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, x86@kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>
Subject: Re: [regression] suspend stress test stalls within 30 minutes
Message-ID: <20240515162747.6shmaoelc4mt7nro@desk>
References: <87o79cjjik.fsf@kernel.org>
 <20240511184847.GCZj-9j2sh1Akpt9iS@fat_crate.local>
 <20240511184945.GDZj-9yaOEWqf1ng8u@fat_crate.local>
 <87h6f4jdrq.fsf@kernel.org>
 <878r0djxgc.fsf@kernel.org>
 <874jb0jzx5.fsf@kernel.org>
 <feaefaae-e25b-4a48-b6be-e20054f2c8df@intel.com>
 <20240515072231.z3wlyoblyc34ldmr@desk>
 <529C9374-DA6F-49C8-9B32-91741800F8E4@alien8.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <529C9374-DA6F-49C8-9B32-91741800F8E4@alien8.de>

On Wed, May 15, 2024 at 09:44:42AM +0200, Borislav Petkov wrote:
> On May 15, 2024 9:22:31 AM GMT+02:00, Pawan Gupta <pawan.kumar.gupta@linux.intel.com> wrote:
> > Other interesting thing to try is cmdline
> >"dis_ucode_ldr".
> 
> Right, is his microcode revision 0xf4 the right one for that model?

0xf4 microcode is not the latest one, the latest is 0xf8:

https://github.com/intel/Intel-Linux-Processor-Microcode-Data-Files/blob/main/intel-ucode/06-9e-09

Kalle, can you please try with 0xf8 and see if the issue is still present?

