Return-Path: <linux-pm+bounces-7785-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFCE8C47ED
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 21:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCF562832FC
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 19:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EA27AE5D;
	Mon, 13 May 2024 19:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tYvbkEej"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70493BB30;
	Mon, 13 May 2024 19:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715630311; cv=none; b=ZmLPFHktVMwHWd7mdOegO1IEyYNry7aUiaFrSp/S8/JBZFgjnfjkqz8dPDZovzg2BD7IbZdFiou0rFehxODdTuuwxpgjsjfQnMJaRXTDZHC1Y/v6KhNbkZBxBKWknhSebM5JPfQfg+Y6a5OcJrX0keWprhFqg6UPPT5wTxZ96/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715630311; c=relaxed/simple;
	bh=xRu8CyhGp/dMQMFRPvRlpYQszBroFlUYx9/roPUrmLQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=MhtUQ91il4ncEJ3as8j1UXEa9oFrAvvAtgRnivDGRd7rqatutDPfnNN1N4Z/xbqnPWVyLVVBnMcxwCebTn7BEPckA1Lu1eAVD1KpuAYCs4ubN5d0U31lEcGtyJBY6dJ8Vkf/hERWGVnnVMWcr3ISq0Vl9lWwFjPHQLQsHB1PM3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tYvbkEej; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1390BC113CC;
	Mon, 13 May 2024 19:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715630311;
	bh=xRu8CyhGp/dMQMFRPvRlpYQszBroFlUYx9/roPUrmLQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=tYvbkEejMiE6HhVN/wo0Q4dJ/UzS+ZBdRKQiafF0yjO0c+CrUS3wNJusXwg9sQstV
	 Zw26BkzNRB0XjovtDrDUhb+3U6dSE7NzYLlfhAwKztXDuoZ/TOa1/9DKUYYK/Ed/A7
	 lakvpF/kBK0r0xVn1ow+r6+k078r/6oxLuPf1WihsPDWk6q2TAaaehy3LrKpYJGbNN
	 aXSzwkzTgF2KEyrQrMcScKKfyVHOFVLAXndjtI0xd9ykEcjOOM4tDg8PZK6fwoxV3I
	 +sFPrjtY6XPEft97bVilgdnwMXHYL3cQdPCB1rj9UDMUbn97U7rgwdH27szngUhfq/
	 bTl8y3IvWi6Ig==
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
	<87h6f4jdrq.fsf@kernel.org>
Date: Mon, 13 May 2024 22:58:27 +0300
In-Reply-To: <87h6f4jdrq.fsf@kernel.org> (Kalle Valo's message of "Sat, 11 May
	2024 23:26:49 +0300")
Message-ID: <878r0djxgc.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kalle Valo <kvalo@kernel.org> writes:

> Borislav Petkov <bp@alien8.de> writes:
>
>> On Sat, May 11, 2024 at 08:48:47PM +0200, Borislav Petkov wrote:
>>> On Sat, May 11, 2024 at 09:22:43PM +0300, Kalle Valo wrote:
>>> > Here's the diff between broken and working .config:
>>> > 
>>> > $ diffconfig broken.config works.config 
>>> > -CALL_PADDING y
>>> > -CALL_THUNKS y
>>> > -CALL_THUNKS_DEBUG n
>>> > -HAVE_CALL_THUNKS y
>>> > -MITIGATION_CALL_DEPTH_TRACKING y
>>> > -MITIGATION_GDS_FORCE y
>>> > -MITIGATION_IBPB_ENTRY y
>>> > -MITIGATION_IBRS_ENTRY y
>>> > -MITIGATION_PAGE_TABLE_ISOLATION y
>>> > -MITIGATION_RETHUNK y
>>> > -MITIGATION_RETPOLINE y
>>> > -MITIGATION_RFDS y
>>> > -MITIGATION_SLS y
>>> > -MITIGATION_SPECTRE_BHI y
>>
>> ... and if it started with -rc4, I'd try this one first.
>
> I'm not sure if this bug started with -rc4, let's say somewhere between
> -rc3 and -rc6. I'll start with disabling MITIGATION_SPECTRE_BHI and then
> I'll disable them one by one.

It is starting to look like that MITIGATION_IBRS_ENTRY is causing my
problems. If I enable MITIGATION_IBRS_ENTRY I see the suspend stall
relatively quickly. And then I disable the config I have not been able
to reproduce the problem so far. But as this issue happens randomly I
want to do some more tests to be sure.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

