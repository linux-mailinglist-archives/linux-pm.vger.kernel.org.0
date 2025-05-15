Return-Path: <linux-pm+bounces-27191-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C86FAB7EB3
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 09:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F3563AB550
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 07:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D57612CD96;
	Thu, 15 May 2025 07:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dzr0cIvr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WPQc3xvl"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E140D1B960;
	Thu, 15 May 2025 07:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747293563; cv=none; b=OR25G3v1KteGo7XzseIZRN4dI/eUyZFuIMBZ4ED3efQOciyccQuTHV+IlIy+ufTIdv/Zd6K15TXGcYTAmvGCoUWh6YXeMBT2iywSbZHcqo+oBFWCnnU3Ob19Mi8JWb+CflSSVOnWz7ZLdLHHxr5zvHj4PN2p8I+ehtmXmL6yW5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747293563; c=relaxed/simple;
	bh=un43Rmr7pThpelAYiq373H0+K8u+aZOSIfYm0dwc0YM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P3IkrTcxflGSbHIK7gchGq/GfyvQ4v9/q1Z2PeuN8kiKVpTZ5kaRU7B1uHP5xT8MPH0DOYSlYTwk5RHrarzW/XwUV8vld5Cf82EWEJzNzNidlswHEQhfZi5r4ClXOlJhHLa1wAlAGYztcOmpqvig8q8BUQQV9Rr0ToTCPszXSUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dzr0cIvr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WPQc3xvl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747293558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6D07CqThBr8ECVgNpKkQgHMewXWhEO/lS7W8K+zKG1M=;
	b=dzr0cIvrDO9a5IxS6gXJH+20QhY54+m1fbYW4/1nVO27UB0OaiMAhT1f4ge/y3nGCXCorr
	EH8/EJLjeG6GjQekYPY+BavJV84oN9u2xOSlEOr6nBjk2nb3Meue8Ut2qzoISw/Zhgn4jF
	bPLMZpiFgayPt0gl/GurlF+lgHD2y0abYOTALvyDdryQqYkoLQXweoe/cBC6sFvUtuM7Ys
	5Oe3odFCHy3U/fWanUTp3sO4tN2lJkLzygmXCJKyc57KSxYsV78BmBQz5sfxV0keCYJ5lF
	2a+DQHmWIm0x4NhVLYVogiubDkqELsM7saFOWCHZ49xYRbkeKVUMcUns2Q4DHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747293558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6D07CqThBr8ECVgNpKkQgHMewXWhEO/lS7W8K+zKG1M=;
	b=WPQc3xvl8nzGkuu5aDYjIdp2pLWc0Ds1i6m5/PgOyC8LhlGLtTYap4TCtxwExaYZnsQsW0
	pjcAmIIjvm8vmaDQ==
To: Shivank Garg <shivankg@amd.com>, Ingo Molnar <mingo@kernel.org>
Cc: mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, luto@kernel.org, peterz@infradead.org,
 rafael@kernel.org, pavel@kernel.org, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 sohil.mehta@intel.com, rui.zhang@intel.com, yuntao.wang@linux.dev,
 kai.huang@intel.com, xiaoyao.li@intel.com, peterx@redhat.com,
 sandipan.das@amd.com, ak@linux.intel.com, rostedt@goodmis.org
Subject: Re: [PATCH RESEND 4/4] x86/apic: Fix W=1 build kernel-doc warning
In-Reply-To: <51fbdbcd-a895-43b0-bb59-aa3361d77cad@amd.com>
References: <20250514062637.3287779-1-shivankg@amd.com>
 <20250514062637.3287779-4-shivankg@amd.com> <aCRMpba5mp5YvmY3@gmail.com>
 <51fbdbcd-a895-43b0-bb59-aa3361d77cad@amd.com>
Date: Thu, 15 May 2025 09:19:17 +0200
Message-ID: <87o6vuibnu.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, May 15 2025 at 12:03, Shivank Garg wrote:
> On 5/14/2025 1:26 PM, Ingo Molnar wrote:
>> This is incorrect and is based on a misunderstanding of what the code 
>> does:
>> 
>> DEFINE_IDTENTRY_IRQ(spurious_interrupt)
>> {
>>         handle_spurious_interrupt(vector);
>> }
>
> The kernel-doc tool doesn't handle macros properly.
> Can I change it to a normal comment instead?
> or if a kernel-doc comment is required how should I make it correct?

Fix the stupid tool and leave the comment alone.

