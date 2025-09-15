Return-Path: <linux-pm+bounces-34697-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C2FB58692
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 23:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CF337A92CD
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 21:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F282BEC57;
	Mon, 15 Sep 2025 21:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="OjjO4xIP"
X-Original-To: linux-pm@vger.kernel.org
Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B50D1DB95E;
	Mon, 15 Sep 2025 21:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757971225; cv=none; b=RtDbkkwqjZO8NXO/RmjIiXfXgknIzqls21nPzYHHFB+ydef9GZYn8JT7qSIpEG1ZwjexyGNSCKzO1mwTRmm5IZz0Id44Z/URlsyhNEE6iNT9sf1sLBPcFkXPOWM5f6EjlqCLtUhvbybsLbWbaZSC6S/NDjdj/hsuVHFyNrXcbeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757971225; c=relaxed/simple;
	bh=f58/b7yV2x5rpzB0Y5TRwwYqR5RkcYg3q7BpprX3nS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MVO7Vz3iB2azISjh5PeWsB9iN5vwesCAj3zXtqvtutTIWxz8CqSyIF042WleqItMZRggtVM9bLzwe/c3BhXGB3rHUzL4o2JM5K4dYvEZmUdnScYvo05Y+xCXKpKZpmz0cDI/x0B0sAVktd8yVvdPSJ4uqQSvytLgJ/QXxmsKbqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=OjjO4xIP; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4cQdGv20jGzltH70;
	Mon, 15 Sep 2025 21:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1757971220; x=1760563221; bh=1YsImEJ8KY5xc8Yvi4EEa0dg
	Mjg/tAk0qeWCsYpfois=; b=OjjO4xIPxgW99q2LPF/Qow22DpVXG1EDFtPaWYOv
	woQHRlSioqUuM1v1QFvj5uhwLP1sm+bgRV6e2CR3P/9ZuZnfq5iJN5NsKWBBpV4X
	6CM6w1RqPyRiV/J2wDYS5Oe1EuiAFOcE19EzJt57J3tLv7vVwHt+nTLkndvkLmRm
	rGwh/oB2/eol9huTM/YtAZPHTFZB+6opJivDK2rcMeIfLtrlrHfhHXod9X1l/uNy
	vLj7oxd/q7Z8kFadPaByuUs4gHdpCQEzgGER27OuAzYojswU7/0JRvFkj5R/BaTa
	XP1iLTriRAjRZpotrD/3eq6xDCDqvAXXqtHrC7UlX5n5XQ==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id hZGj7X9H7u8E; Mon, 15 Sep 2025 21:20:20 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4cQdGg2NxJzlsxCp;
	Mon, 15 Sep 2025 21:20:10 +0000 (UTC)
Message-ID: <dd78b859-5f1b-499c-9578-03b8a18418cc@acm.org>
Date: Mon, 15 Sep 2025 14:20:09 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] scsi: ufs: core: Add support for frequency PM QoS
 tuning
To: Wang Jianzheng <wangjianzheng@vivo.com>, Jens Axboe <axboe@kernel.dk>,
 Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Peter Wang
 <peter.wang@mediatek.com>, Bean Huo <beanhuo@micron.com>,
 "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
 Adrian Hunter <adrian.hunter@intel.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20250914114549.650671-1-wangjianzheng@vivo.com>
 <20250914114549.650671-4-wangjianzheng@vivo.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250914114549.650671-4-wangjianzheng@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/14/25 4:45 AM, Wang Jianzheng wrote:
> +	if (!shost)
> +		return;

Please remove the above if-statement and make sure that the
initialization order guarantees that hba->host is set before
ufshcd_pm_qos_freq_read_value() can be called.

> +	shost_for_each_device(sdev, shost) {

Why a loop over all logical units? Isn't it sufficient to check the
WLUN?

> +		if (!sdev)
> +			continue;
> +
> +		q = sdev->request_queue;
> +		if (IS_ERR_OR_NULL(q))
> +			continue;
> +
> +		if (q->disk && !IS_ERR_OR_NULL(q->dev)) {

The above three if-statements are not necessary. Please remove these
three if-statements to improve code clarity.

Thanks,

Bart.

