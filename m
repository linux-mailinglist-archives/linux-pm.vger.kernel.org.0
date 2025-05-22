Return-Path: <linux-pm+bounces-27500-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC469AC08EF
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 11:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D88318802A4
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 09:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F188236A79;
	Thu, 22 May 2025 09:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="PMVqI1Db"
X-Original-To: linux-pm@vger.kernel.org
Received: from jpms-ob01.noc.sony.co.jp (jpms-ob01.noc.sony.co.jp [211.125.140.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC63419ABDE;
	Thu, 22 May 2025 09:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.140.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747907201; cv=none; b=d4B+3nk8zF6FvMTRCrV2BZceF3MzTpE+/0JrkGrlpNmo9mveq/xGdbQeSYMl/3PkVDSeA43FDKd+d8K5+85lTOjWKPxzlpAHNIEOX5JOlyrMhs3Ir9Z7GE5E7wjmUG44jwZlD9XymA3VVqKH4meHd12dmjHS/Y80QsDrNLaQs3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747907201; c=relaxed/simple;
	bh=iwyvSkrXpxctGEfHrPn28Dg2OnHVDNuVDHmlyvO+q2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pSPr+7HYknrw9nvLEFteFGihARMBKwHlw2Veu39hMpBU55LJqgroIe6b8HoaYj2qX2iL4SuysPSc8A/pm8dh/FwRqaRiLsweHEygIJ7uModrGJjN91o1iXO5Dsxr1oKb9xNJ7LEEiVoFK9sU9irSlrIuXOA1DAr23e4qINsN1xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=PMVqI1Db; arc=none smtp.client-ip=211.125.140.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1747907199; x=1779443199;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DfbWw3E35fX776QXKTvnDVg3ShsCLZlrkgbY+W4KvCw=;
  b=PMVqI1DbBkLUBvjtTPl61A8kZuZeQ/K4I8Uueg6nX8GObS8VP3KmeG3T
   rHFgFF7MjcldQUVwun/Y0P0BBG5ZRRgtFZbrwge4Tmxqjk1wpLxety2FE
   VXvdlbnvDKjnbA09vkMKkYg3UnVfwdJ7m4ZkpEEY+w43syQHUCCcdypn2
   GRhz8mmj6ByBmC21gsrojbawNR1EeyZ5ulN5JGKB2qnskg5EwOSjyXE4B
   Wz8vVif3ZelawwHSZS9ETVpdhb3c5kTFYAznZxmNjmKRaVEExPsIDg6gy
   luHh1/u8RYKhh2ur6wzLD8ptZcLlVn3OdZnrfMV9cP2EWnxG9r++WhE1w
   g==;
Received: from unknown (HELO jpmta-ob1.noc.sony.co.jp) ([IPv6:2001:cf8:0:6e7::6])
  by jpms-ob01.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 18:46:37 +0900
X-IronPort-AV: E=Sophos;i="6.15,305,1739804400"; 
   d="scan'208";a="562636728"
Received: from unknown (HELO JPC00244420) ([IPv6:2001:cf8:1:573:0:dddd:6b3e:119e])
  by jpmta-ob1.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 18:46:37 +0900
Date: Thu, 22 May 2025 18:46:33 +0900
From: Shashank Balaji <shashank.mahadasyam@sony.com>
To: Russell Haley <yumpusamongus@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-pm@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Shinya Takumi <shinya.takumi@sony.com>
Subject: Re: [PATCH] cpufreq, docs: (userspace governor) add that actual freq
 is >= scaling_setspeed
Message-ID: <aC7yeQvKVQ1No9EW@JPC00244420>
References: <20250522-userspace-governor-doc-v1-1-c8a038e39084@sony.com>
 <15871c67-0d18-430f-935e-261b2cda855b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15871c67-0d18-430f-935e-261b2cda855b@gmail.com>

Hi Russell,

On Thu, May 22, 2025 at 03:50:55AM -0500, Russell Haley wrote:
> If the user asks for the frequency to be set from userspace, the
> frequency had damn well better be set from userspace.

First of all, I agree with you. In fact, before sending this patch, I
was considering adding CPUFREQ_GOV_STRICT_TARGET to the userspace
governor. intel_pstate should handle the rest of it.

> In my opinion, the documentation is correct, and it is the
> implementation in intel_pstate that is wrong. If the user wanted two
> separate knobs that control the minimum and maximum frequencies, they
> could leave intel_pstate in "active" mode and change scaling_min_freq
> and scaling_max_freq.

If intel_pstate is left in "active" mode, then userspace can't use any
of the other governors. Moreover, intel_pstate's min and max frequencies
apply to all the cpus. Whereas, the userspace governor can be set on a
per-cpu basis.

Let's say this is "fixed" by adding CPUFREQ_GOV_STRICT_TARGET flag to
the userspace governor. Then userspace has no way to get back the
current behavior where the hardware automagically increases frequency
beyond the target frequency. At least not without a new interface.

With the current behaviour, userspace can have it both ways:
    - actual frequency = target frequency
    - actual frequency >= target frequency

And the occasional higher frequency shouldn't hurt performance, right?
But if they still want exact equality, with the current interface, they
can do that too.

This consideration is what led me to document the "actual freq >= target
freq" rather than patch it so that "actual freq = target freq".

Thanks

Regards,
Shashank
"

