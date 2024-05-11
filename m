Return-Path: <linux-pm+bounces-7743-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA1D8C33BB
	for <lists+linux-pm@lfdr.de>; Sat, 11 May 2024 22:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D1621C20E2A
	for <lists+linux-pm@lfdr.de>; Sat, 11 May 2024 20:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEAF208B8;
	Sat, 11 May 2024 20:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAII72gg"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF39C17588;
	Sat, 11 May 2024 20:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715459214; cv=none; b=uzutWNHILB8TNQVTWpodr5r2DFuLkazBU++1Rh4hRVaiX+nPHEmNe4vVNkVU/OI2ogBcLoOl/RSGt07WhaZfTAPMbxpL3dV8q8pEH4apP4LSvI16Y2TfZy9EdhP9MDFVZfpNoGElHtv0z/FdtW0ZHMXkyKCZ92H675L/jHqPjgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715459214; c=relaxed/simple;
	bh=5xvvB0fPX+qfaMVaLVDZwsVQhtJBPvVdJUhRNhQEjOs=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Jyx0fECLDSbJzhQnV8RC5I84DwTDyeJYHF/5Di8WjGNF6b8vzRaBj6k25lDERBWV+6qxj7hlhHiULq/UO80n994HPU3dPtvZplUUllcsfwPSt8KFiE7ENbtEcDQoxc2gsuHonadWaf8LDzZGaQ8K76nHY7X0DmzHiLCEYOHXM9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAII72gg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 102ABC2BBFC;
	Sat, 11 May 2024 20:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715459214;
	bh=5xvvB0fPX+qfaMVaLVDZwsVQhtJBPvVdJUhRNhQEjOs=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=HAII72ggPAnsWui9ENdsgbejSCkKXvusZa1lGVA5uIC/yHu0AEKTJAO+QSFsEjYQs
	 5XVzSx1x6YAlq43ry3VCYxvMr9hGydVKY+XoyK3cf0//C7QLc9telG8+5CYRIL5N2G
	 +g1S4QKKr9bU/fd72C3gP4VMIY3zmbkq3nzaNyitwPDzRQDy6xr4U35AtLbyRhDVeb
	 88/iaTELTAYgFX51zQRnAvUFf7ycuk/p9qJdtjzajgeVgCn4vT3xHCS4d686wZ9ezx
	 4EJ55F56Q0JtiXD6fVDhC5yXwDyI2+mRDqK+ktIAS/ZYvC318mEOKgDj/OBpmHWSy8
	 DABRQtVB3as0g==
From: Kalle Valo <kvalo@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,  Ingo Molnar <mingo@redhat.com>,
  Dave Hansen <dave.hansen@linux.intel.com>,  "Rafael J. Wysocki"
 <rafael@kernel.org>,  x86@kernel.org,  linux-pm@vger.kernel.org,
  linux-kernel@vger.kernel.org,  regressions@lists.linux.dev,  Jeff Johnson
 <quic_jjohnson@quicinc.com>
Subject: Re: [regression] suspend stress test stalls within 30 minutes
References: <87o79cjjik.fsf@kernel.org>
	<20240511184847.GCZj-9j2sh1Akpt9iS@fat_crate.local>
	<20240511184945.GDZj-9yaOEWqf1ng8u@fat_crate.local>
Date: Sat, 11 May 2024 23:26:49 +0300
In-Reply-To: <20240511184945.GDZj-9yaOEWqf1ng8u@fat_crate.local> (Borislav
	Petkov's message of "Sat, 11 May 2024 20:49:45 +0200")
Message-ID: <87h6f4jdrq.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Borislav Petkov <bp@alien8.de> writes:

> On Sat, May 11, 2024 at 08:48:47PM +0200, Borislav Petkov wrote:
>> On Sat, May 11, 2024 at 09:22:43PM +0300, Kalle Valo wrote:
>> > Here's the diff between broken and working .config:
>> > 
>> > $ diffconfig broken.config works.config 
>> > -CALL_PADDING y
>> > -CALL_THUNKS y
>> > -CALL_THUNKS_DEBUG n
>> > -HAVE_CALL_THUNKS y
>> > -MITIGATION_CALL_DEPTH_TRACKING y
>> > -MITIGATION_GDS_FORCE y
>> > -MITIGATION_IBPB_ENTRY y
>> > -MITIGATION_IBRS_ENTRY y
>> > -MITIGATION_PAGE_TABLE_ISOLATION y
>> > -MITIGATION_RETHUNK y
>> > -MITIGATION_RETPOLINE y
>> > -MITIGATION_RFDS y
>> > -MITIGATION_SLS y
>> > -MITIGATION_SPECTRE_BHI y
>
> ... and if it started with -rc4, I'd try this one first.

I'm not sure if this bug started with -rc4, let's say somewhere between
-rc3 and -rc6. I'll start with disabling MITIGATION_SPECTRE_BHI and then
I'll disable them one by one. But that has to wait next week, tomorrow
is Mother's Day in Finland.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

