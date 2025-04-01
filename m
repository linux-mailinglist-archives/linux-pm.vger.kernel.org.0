Return-Path: <linux-pm+bounces-24681-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C7DA7764C
	for <lists+linux-pm@lfdr.de>; Tue,  1 Apr 2025 10:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48F621889607
	for <lists+linux-pm@lfdr.de>; Tue,  1 Apr 2025 08:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B3C1E9B1B;
	Tue,  1 Apr 2025 08:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3aJCLaU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A652D1E261F;
	Tue,  1 Apr 2025 08:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743495779; cv=none; b=sn6h7KKD83b8DT64SNxwhr5eHRfwl5sOe4RV4XJdxhcGxR81xjg6oklE2W9hzyxFDM6FKuDtKJ0KcdYjAq4aHIcm3sFi6kCb9yWpzJhG/EPKk4lvnlrEKbXiSnLJGVstvjm1WqB8lKgZ411/zPM/MU45ITTWIggPYNH04arlfLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743495779; c=relaxed/simple;
	bh=O0QQJEF18+1rlQZs043LAf4yFZOKmppUTBC2llv9WRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NfH2ozepZhbmUEu2db2bDSoJAXP/EC1Wz+ZIEBXfp/gAQW58/O+WL6hrVr+4X1x4OoI6cOrQ7zzGuibj1ZrJKy9CXZElmH7913cYmPWAqcgQcfuSAveSUgb7Smd6GuxAWjYfWBswp0oSOnt816L01r0Vna/kc4Dye+NqpB/1omo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3aJCLaU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A2AC4CEE4;
	Tue,  1 Apr 2025 08:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743495779;
	bh=O0QQJEF18+1rlQZs043LAf4yFZOKmppUTBC2llv9WRc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H3aJCLaUO6zzX8Z9stF1XQwpJLlyTGC+uYJ1dakhWIF3agcP/5BLLtepziTzajCK1
	 S8a85mi95sIQ7Uix4i9u31YkllaLlwFy18x7AHj3ISHlDZrMj40OfhfcueXObWLfwB
	 DVBPMRz0svKriGcJjI98U43pgNZ/gTDXIhtJjAv5nSDwPFw0AI4Mxkcd8gJdt1e/r8
	 JRl9cWCOIkehMkNwnKrSWYjlWV79JbvvQ6c6cK+TSFmxraAwLdzCCBQ5FDcom+m+FI
	 TE1f2ITwQfjbbQ2FBBJTE4JE1j50A5T02DmJ1IeMaCdbLOxPHNnifpfM2C4ImcwZip
	 FADmhbExd11rQ==
Date: Tue, 1 Apr 2025 10:22:53 +0200
From: Ingo Molnar <mingo@kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	"Xin Li (Intel)" <xin@zytor.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	pavel@kernel.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	xi.pardee@intel.com, todd.e.brandt@intel.com
Subject: Re: [PATCH v1 1/1] x86/fred: Fix system hang during S4 resume with
 FRED enabled
Message-ID: <Z-uiXfz1nOP7jGQv@gmail.com>
References: <20250326062540.820556-1-xin@zytor.com>
 <CAJZ5v0jfak9K_7b=adf5ew-xDiGHUEPSp5ZpAGt66Okj-ovsGQ@mail.gmail.com>
 <148C8753-8972-4970-8951-E2D1CB26D8B0@zytor.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <148C8753-8972-4970-8951-E2D1CB26D8B0@zytor.com>


* H. Peter Anvin <hpa@zytor.com> wrote:

> Just to make it clear: the patch is correct, the shortcoming is in 
> the description.
> 
> I would say that Xin's description, although perhaps excessively 
> brief, is correct from the *hardware* point of view, whereas Rafael 
> adds the much needed *software* perspective.

This part of the -v1 patch was a bit misleading to me:

>> Due to changes in the kernel text and data mappings, the FRED MSRs 
>> must be reinitialized.

... as it suggests that the FRED MSRs will change from before the 
suspend - while they don't.

What this sentence meant is that FRED MSRs set up by the intermediate 
*kexec kernel* are incorrect and must be reinitialized again to 
reconstruct the pre-hibernation state. Ie. there's 3 FRED setup states: 
pre-S4, kexec and post-S4, where pre-S4 == post-S4. Right?

I think the description and comments in the -v2 patch are better in 
this regard.

Thanks,

	Ingo

