Return-Path: <linux-pm+bounces-38726-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6B4C8ABF1
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 16:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B61C64E9897
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 15:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E4A33A6E6;
	Wed, 26 Nov 2025 15:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="JXxvVnaj"
X-Original-To: linux-pm@vger.kernel.org
Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3335E331A55;
	Wed, 26 Nov 2025 15:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764172136; cv=none; b=QjowCDEw4dA9679GwNyVj2yhUUo/3oxrdNPqXqUdfTucTdNi7Mi6qcgZ9nQ5R6/8nZPKiZnXMjCCw6eYIqER2pUSAlWsJtoLsxwarFOQHQ5qm1yTLgcOT7q8C4Jq3g5lH+MvFq9PRrIP9oiC1VbZQb3qHs8rthUGDcJLST7xfwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764172136; c=relaxed/simple;
	bh=XKCHOrUC7lUwfA2lyRiev1RPUU8XOHcokBwQZZTfIMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=St5NuQFjDopZ6SmbRWvUyzFRECb2C5k5Lre1Rb/gVlsueE4VWek2/ZTePfNxOnhVGnCkSRSX2pb2fkOJ28X33NeHGrhhnt+blULucTtylq74jjrTOrokxFaxtvLNZlv1aL56QJz/70N6AcenctxAVqsh+dyWRK+8BWARR8F19aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=JXxvVnaj; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4dGkWB2PCNzm1Hcj;
	Wed, 26 Nov 2025 15:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1764172132; x=1766764133; bh=nidLKHZbzxxAle9niWpnvANE
	hDq+v54g9Sj+5WdX6oY=; b=JXxvVnajL6QHirCbDZ4oF0Gy3Ot9s7JkwmJs4eNv
	bt2QKbCgx/YyE4HvqTvfZlPR/RqaJ/0cXXEma5cHEJnoglywNfl1yTzOeFC2s6cf
	Uma281zxvE7Ar5xHmXjek4OIlZUECxTQQ3szKQ5fwWzrOV5xL1XYEbQ88dryOlkA
	Ry3Hey3zB6Blswf6A9HXfqIGV6Hwy8hMH5L5C600qdzCE3c/hL4R19tlegKRWKAK
	KLR04bFxXe3OV2i4m7WDFT2dBfMp4xFXYX6kH2KmieMBUObwhhmOdWVAUxn1rP98
	ys9lWnFGE1UgT2HYRoDurGdY3izM8d/ytx2Z5fAdFeEAWQ==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 2ApCToxj5203; Wed, 26 Nov 2025 15:48:52 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4dGkVy5RLVzm0c5R;
	Wed, 26 Nov 2025 15:48:41 +0000 (UTC)
Message-ID: <94c6680c-1b86-4cee-8e9c-860daf629b59@acm.org>
Date: Wed, 26 Nov 2025 07:48:40 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] PM: runtime: Fix potential I/O hang
To: "Rafael J. Wysocki" <rafael@kernel.org>, Yang Yang <yang.yang@vivo.com>
Cc: Jens Axboe <axboe@kernel.dk>, Pavel Machek <pavel@kernel.org>,
 Len Brown <lenb@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20251126101636.205505-1-yang.yang@vivo.com>
 <CAJZ5v0jsdsyVd3hPWni1Vj+daQS8PdWJCjboJHHHbBjBMeSxzg@mail.gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAJZ5v0jsdsyVd3hPWni1Vj+daQS8PdWJCjboJHHHbBjBMeSxzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/26/25 3:31 AM, Rafael J. Wysocki wrote:
> Please address the issue differently.

It seems unfortunate to me that __pm_runtime_barrier() can cause 
pm_request_resume() to hang. Would it be safe to remove the
cancel_work_sync() call from __pm_runtime_barrier() since
pm_runtime_work() calls functions that check disable_depth
when processing RPM_REQ_SUSPEND and RPM_REQ_AUTOSUSPEND? Would
this be sufficient to fix the reported deadlock?

Thanks,

Bart.

