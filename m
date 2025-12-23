Return-Path: <linux-pm+bounces-39871-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F01CD9CAC
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 16:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 65B5E3008057
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 15:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DF73502B8;
	Tue, 23 Dec 2025 15:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="4BObmR1z"
X-Original-To: linux-pm@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2373502B4;
	Tue, 23 Dec 2025 15:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766503797; cv=none; b=K4/keehlhtKqkNlmuNVGqCxx7VyNjVerzTDJ7ikLfd7VPNjgstfUDhOPppCKY20Mbp93RDf+0Qzig479aM/lCZKmAmyIa1qDlpm7tNxtZPd/45Z8uJ7iWV0GTudkW0yqVixRm/Z1f8OD0DlRrMfAC0+2V2Yxztn9JSpT+/rJblc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766503797; c=relaxed/simple;
	bh=+glxbiWBpZRqAPrD3N7LiX7llCM/ySgT5zAKvFSZoi4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hh9IIawnAic8B0QdqDYeZdDSt8eWMpxll2VrnwG3cPQsfhYuTwGhW8qrVmWusrvfqjkzFQbyYJ6QNueSeJFSEnMtbVFC636GhasNCzYFdcV2DRxEsSviokqALbJr75cGOV5iRMySn1g5oODMbqHvyrOXm8GyPJKFQB2M7byFKQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=4BObmR1z; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4dbJpj2DpBzlskkV;
	Tue, 23 Dec 2025 15:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1766503787; x=1769095788; bh=eyHzFGrQcYn1KFN3S/LI+LqU
	UXYAcKhjjmnMGus/zfI=; b=4BObmR1zt9sVHnVIFuQvoV17ZdcGC1TCxUxH2trG
	3416ZKIfht7Da4t4D3+s2rEZKOk/hLPskQMHsWYZI98Dx9OsqSHeBu2ty656U+wV
	EGg0/jdv1/8pcS7zH2pozrv3e/jZppGjDBm6d45jydRTVZPc/qGAxqm0ePHAkJUl
	ST4hFm14VTduWqr65X09tjt1QR8E7WZ0FYnRv5p+JTVG9DtP8+m4TFTsaE9y2B9Y
	WlS+Z7+9Z45c6RPsxwLc1cb+F8LXQ//1D4HqJR33J/JiL7q/w9rpGg/VZtv8Ha+/
	CfTztcOzOvn1B8zveHRanbm6ds2XJ2afxoCZ59Yp3t8lWw==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id tyWs604suY3A; Tue, 23 Dec 2025 15:29:47 +0000 (UTC)
Received: from [172.16.2.244] (92-71-251-62.biz.kpn.net [92.71.251.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4dbJpZ6J4Kzlsb49;
	Tue, 23 Dec 2025 15:29:42 +0000 (UTC)
Message-ID: <bade326b-f32b-4e90-aa2f-af7db26c4461@acm.org>
Date: Tue, 23 Dec 2025 16:29:39 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 20/23] scsi: ufs: core: Discard pm_runtime_put() return
 values
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ulf Hansson
 <ulf.hansson@linaro.org>, Brian Norris <briannorris@chromium.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org
References: <6245770.lOV4Wx5bFT@rafael.j.wysocki>
 <2781685.BddDVKsqQX@rafael.j.wysocki>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <2781685.BddDVKsqQX@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/22/25 9:31 PM, Rafael J. Wysocki wrote:>
> The ufshcd driver defines ufshcd_rpm_put() to return an int, but that
> return value is never used.  It also passes the return value of
> pm_runtime_put() to the caller which is not very useful.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


