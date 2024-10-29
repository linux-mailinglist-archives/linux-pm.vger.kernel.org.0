Return-Path: <linux-pm+bounces-16679-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B939B52A3
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 20:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CF2F1F24C57
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 19:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB69F20720C;
	Tue, 29 Oct 2024 19:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="j9x5KITd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908761FF618;
	Tue, 29 Oct 2024 19:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730229629; cv=none; b=dko4L0Uqoo940netzxCbrlPkzKRRDhcFVw8ymRsXHkDB8EfB+rFDyJxk7fet2C1sUW04/r8kdOsFzGMtxiIJ6vcbcpVB83vEqlBfP8z3Jo2Zo8PE8AVgrHiyASzTRM4LZZaxjMjlOJztfKy/0pO7SyLB1+ErMqpkasyvKc1JBvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730229629; c=relaxed/simple;
	bh=DIVX3zlLSMuV6KZ3uFcJsCv++6D+TogaTb5DnwOoF54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DRFChhVf3aw0chQO0FAjVScV8EunCw1pQcP5x7O+31fT8QW2jDWOKKCefphHQYwwD8YMKbF70I3MC2qgWbiv+Qh4JUDEK07lQN3viVnXxW6H6XEZMNtTxoVbpIgY5gA/4mn4MtgTf9zw9UBG/3Mq/HJsEShQbvA2+yIOEAz7WJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=j9x5KITd; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3264840E015E;
	Tue, 29 Oct 2024 19:20:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id bI3prSb8HlZh; Tue, 29 Oct 2024 19:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730229621; bh=AMd1l3kOY3K1E+tqlgPUoHcC2Z4JGEphSAoYvZ1VHHI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j9x5KITdYYBFh9WoyeKJXyv/KcwopGvI0ROQEv5NanbdT8t38ivdmPT72CPMKUiAU
	 Z2X8NNu/IdB+T4zVK9Nde8Lj9ngCMAwrKCJfI0ZRCjvr36h6v79XPeRlXu8VWeBJ7Y
	 mRebQ/fSGiEA+BrEiwf1aoryxXbwpv3kGqxwah5BOFDqkhVTK6FINc+K5c+aHXyuNi
	 uJti2LOT7amMGgzoKOvOzEVdlgM03H6kwui7fWqxras7oCswdQemL6l91S3u+E5uZT
	 7h1aNV0zSRxktQOjwITIoWqHe6TNlC2YTTs1vHNYKukeoFP8hLHtiitHNYYqDu6Rws
	 2MWlWuqjvSs8tqhkNAjNHGPzPvOi5ME6u4pAGfFMfEWtQsjBgyc9QycxZc8LeT4hYV
	 uLsa1apVTcY1XlXcCd6cYeMziX49GCjnkZKv+z967OzJWpt5M7Fb0h8e5YaKhCYWEC
	 G+fqIqMOiDmg/YKduCx7XUiXMbZd3MnubGbdkmw0vNN55Adp+BaB2qdorw7uTXerGG
	 yRzXS2QGXtGvqFRqG+PM2Y8X6CMSMgyQaUikoQNO6A1LfVN/DCi5LZINUicv3OUnZQ
	 IIHlDy7LYvfclsA/hWBv84KVdeg3ReFzsmMyP5VCBopPnD5l2PYcND4HVVYFMsDUKk
	 SQ13aJEjZezqdti262p904R4=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E1FB440E019C;
	Tue, 29 Oct 2024 19:20:09 +0000 (UTC)
Date: Tue, 29 Oct 2024 20:20:08 +0100
From: Borislav Petkov <bp@alien8.de>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	x86@kernel.org, "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH v5 00/13] Add support for AMD hardware feedback interface
Message-ID: <20241029192008.GZZyE1aOAUamb7jF4R@fat_crate.local>
References: <20241028020251.8085-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241028020251.8085-1-mario.limonciello@amd.com>

On Sun, Oct 27, 2024 at 09:02:38PM -0500, Mario Limonciello wrote:
> Mario Limonciello (4):
>   MAINTAINERS: Add maintainer entry for AMD Hardware Feedback Driver
>   cpufreq/amd-pstate: Disable preferred cores on designs with workload
>     classification
>   platform/x86/amd: hfi: Set ITMT priority from ranking data
>   platform/x86/amd: hfi: Add debugfs support
> 
> Perry Yuan (9):
>   Documentation: x86: Add AMD Hardware Feedback Interface documentation
>   x86/cpufeatures: add X86_FEATURE_AMD_WORKLOAD_CLASS feature bit
>   x86/msr-index: define AMD heterogeneous CPU related MSR
>   platform/x86: hfi: Introduce AMD Hardware Feedback Interface Driver
>   platform/x86: hfi: parse CPU core ranking data from shared memory
>   platform/x86: hfi: init per-cpu scores for each class
>   platform/x86: hfi: add online and offline callback support
>   platform/x86: hfi: add power management callback
>   x86/process: Clear hardware feedback history for AMD processors

...
Applying: Documentation: x86: Add AMD Hardware Feedback Interface documentation
.git/rebase-apply/patch:140: new blank line at EOF.
+

<--- and below.

warning: 1 line adds whitespace errors.
Applying: MAINTAINERS: Add maintainer entry for AMD Hardware Feedback Driver
Applying: x86/msr-index: define AMD heterogeneous CPU related MSR
Applying: platform/x86: hfi: Introduce AMD Hardware Feedback Interface Driver
.git/rebase-apply/patch:57: new blank line at EOF.
+
warning: 1 line adds whitespace errors.
...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

