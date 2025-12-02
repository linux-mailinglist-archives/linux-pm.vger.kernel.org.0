Return-Path: <linux-pm+bounces-39026-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58063C99B39
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 02:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17F513A3DDC
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 01:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D5119CC0C;
	Tue,  2 Dec 2025 01:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="SQyy5e7e"
X-Original-To: linux-pm@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0774136672;
	Tue,  2 Dec 2025 01:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764637600; cv=none; b=RF/OSDOqMMHXXTzYLEZ0AikPNFpXlQpYUjTZ0l8yH6vNHeS0AHCZgbbL+UsEQKHBrV8GUMKQdDDxCzlPoCcLPvpscSuR2X6mheAtuygqV476n/4NsO2Xt+nTWCH9KxZpRZgj3o6lsLocpo1p49p8P8L0GRtxRScXWfQuoBilawE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764637600; c=relaxed/simple;
	bh=3Fu/lbsZlTLTL+WXuZTh+YjQGMzLyHIJz2bxbR+MgOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pEvegJrfyj41cqsM2YsHixZ5QWrOpO/36oRjMMAr9ZEUoKbKojNGiDc22VG7PbtXVeJxflDx4ZARBSeIH+4FkUuWidGr/AwBq6QdoHudg/s6iLzb2NVsw62cfplnWs3Og2rrL5r/XaguJjwsw312cvOLBAztIJj/NIrIMOoAUSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=SQyy5e7e; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4dL2fP1XZQz1XM6JG;
	Tue,  2 Dec 2025 01:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1764637595; x=1767229596; bh=c/hQhxsDkL+Dyk4zP1jAOgn1
	OHEb64wa6VQaog2c1xc=; b=SQyy5e7eBh8oxF8XmvOIB5EL+EubNtcQjOmbYkbL
	+bDi8rZysAC8mynVLyYrqypzRun0VCeuRjJUseh62VxnnZD8QJessLQX7Lu6PMby
	G1rJzNB2MWzM3Y6gsXMVwLnhUSXMmZ/maOxKLIQbPtV0n5Eik9mTdOI7JDsuCm6f
	J0Bg0iWW2PiVqPXhJrCzy/hDkFqe+wVCwM+7tHTvj4kM0ar9eD7O47HD3kr4zNMb
	a6j5PiAE7/bu9W3sBj/6lhodjjorInrtiyn9ZnmdbLzUF71rKeOi9j7XtIdp96uw
	Lme3eWpPttBkBGoVPltnyg7ULMuktd1GKzTyIouSqhpjVA==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 6JtUo2xFsGvk; Tue,  2 Dec 2025 01:06:35 +0000 (UTC)
Received: from [100.68.218.127] (syn-076-081-111-208.biz.spectrum.com [76.81.111.208])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4dL2fJ0rp6z1XM6J9;
	Tue,  2 Dec 2025 01:06:31 +0000 (UTC)
Message-ID: <a461add5-95a0-4750-8d66-850cce2fe9fb@acm.org>
Date: Mon, 1 Dec 2025 15:06:30 -1000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] PM: sleep: Do not flag runtime PM workqueue as
 freezable
To: "Rafael J. Wysocki" <rafael@kernel.org>, YangYang <yang.yang@vivo.com>
Cc: Jens Axboe <axboe@kernel.dk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 Ulf Hansson <ulf.hansson@linaro.org>
References: <20251126101636.205505-1-yang.yang@vivo.com>
 <82bcdf73-54c5-4220-86c0-540a5cb59bb7@vivo.com>
 <CAJZ5v0hm=jfSyBXF0qMYnpATJf56JTxQ-+4JBy3YMjS0cMUMHg@mail.gmail.com>
 <6216669.lOV4Wx5bFT@rafael.j.wysocki>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <6216669.lOV4Wx5bFT@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/1/25 11:58 AM, Rafael J. Wysocki wrote:
> So I've been testing the patch below for a few days and it will eliminate
> the latter, but even after this patch runtime PM will be disabled in
> device_suspend_late() and if the problem you are facing is still there
> after this patch, it will need to dealt with at the driver level.
> 
> Generally speaking, driver involvement is needed to make runtime PM and
> system suspend/resume work together in the majority of cases.

Thank you for having developed and shared this patch. Is the following
quote from the Linux kernel documentation still correct with this patch
applied or should an update for Documentation/power/runtime_pm.rst
perhaps be included in this patch?

  "The power management workqueue pm_wq in which bus types and device 
drivers can
   put their PM-related work items.  It is strongly recommended that 
pm_wq be
   used for queuing all work items related to runtime PM, because this 
allows
   them to be synchronized with system-wide power transitions (suspend 
to RAM,
   hibernation and resume from system sleep states).  pm_wq is declared in
   include/linux/pm_runtime.h and defined in kernel/power/main.c."

Bart.

