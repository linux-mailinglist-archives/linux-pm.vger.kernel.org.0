Return-Path: <linux-pm+bounces-34695-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7B7B58675
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 23:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44E993B8E1B
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 21:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA9629D282;
	Mon, 15 Sep 2025 21:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="SXhgUes3"
X-Original-To: linux-pm@vger.kernel.org
Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E992264BA;
	Mon, 15 Sep 2025 21:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757970943; cv=none; b=jBXfh54Ycc830QIkGitJXQcNBy48QsKviC6epb95EK6UXFJcDVKt2HqsERp1c0koUD87xrR7ZkHRzPF/08m7/Q2HgSCBQhuBCpCqZqGEObYeAEItb2VVB5FeCat2k6SGWa7oJ5tsINa0zaEnu7iYELlQL77HWiA/7owc3/eC7e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757970943; c=relaxed/simple;
	bh=qDQ1tohA3HbprM53H/J9GwJb+U8i9aiiYu1LQIePXJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AFiLvUp3kA2paqFkKNWW6sYGe738sdbIwlDR07ksnixDjLIL4InmWFzv55AC0tW9B8M0cAx3dQl0WO8+XfdS55O4cT+v//sKZve43VTlWgNRUfSe9UJaIuUOn1awjTfs0BaYowe9/JfrokWyR3FR5G+nbmPr09wlkVx7N4ig/ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=SXhgUes3; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4cQd9S58kMzm0ySc;
	Mon, 15 Sep 2025 21:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1757970938; x=1760562939; bh=H1E7sIGYz3CBolGTyUVlAtB+
	G56TZ/puB1NJ9ZnovnQ=; b=SXhgUes3abq4n5n914M/cCg+90XBHoeJ6VIlBlso
	3+WI0/Mm/Svmep4kDoTZ8jKORakGi/9QivfSTNHMfGH8JV80kzyxmcGAcEYgTjch
	OSnc7Rm8bbLNov28Kl1f04N4j7K50S4s9Z59klcdyOrh59G2BbJsWx4RiTJMK8yT
	yTvY1TrB3n/pHACvDrjoD0zuHQMFXUla9b9JjZrWv8BoJG4ZqqcH3NyT0oLFq2XM
	5S5hv90T/40eIc8LJKzkgd7RbYWVyLPUuDKtaKln2AV5uXutFDnGCsf1DvhdOvZy
	ZwD95ECZ8ox23Dch+WpOiQ3marlDzWj9hcK2GbDZFH0LNg==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ViE_q4oKjZis; Mon, 15 Sep 2025 21:15:38 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4cQd9B5hZLzm1743;
	Mon, 15 Sep 2025 21:15:26 +0000 (UTC)
Message-ID: <227f36d8-ca89-486f-b39b-c971e08e20c4@acm.org>
Date: Mon, 15 Sep 2025 14:15:25 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] block/genhd: add sysfs knobs for the device frequency
 PM QoS
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
 <20250914114549.650671-2-wangjianzheng@vivo.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250914114549.650671-2-wangjianzheng@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/14/25 4:45 AM, Wang Jianzheng wrote:
>   block/genhd.c          | 23 +++++++++++++++++++++++
>   include/linux/blkdev.h |  2 ++

If  a new sysfs attribute is added then an entry must be added in
Documentation/ABI/ that explains the purpose of the new attribute and
also how to use it.

> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -213,6 +213,8 @@ struct gendisk {
>   	u64 diskseq;
>   	blk_mode_t open_mode;
>   
> +	int dev_freq_timeout;

The name `dev_freq_timeout` is not sufficient to guess the meaning of
the attribute. Please add a comment.

Thanks,

Bart.

