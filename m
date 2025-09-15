Return-Path: <linux-pm+bounces-34698-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D956B586B9
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 23:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5D3416D4C0
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 21:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3142C029D;
	Mon, 15 Sep 2025 21:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="wkvea9OY"
X-Original-To: linux-pm@vger.kernel.org
Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD062DC78E;
	Mon, 15 Sep 2025 21:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757971612; cv=none; b=h+PhxaotZcCeXwn5E3InePPIaISAbyk5XO0JtRtZHT2W/P9yF2Qs4b5GAtbfatmkq0gGbrRslzdshdScz35lsSFqCqp4NEKD92IQQhZOHZzRQ0kEagG9SmLjDQV1gYKpHwvrztjhmOEXw5Nr9ayS9OekPRxgC8mSYHO86QhEMo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757971612; c=relaxed/simple;
	bh=F1ipfS8UGPGTKCo2J4DQxAs8vmHs6cZPnkAiHnP/5Hg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UoCDZL23NdMf7/9WGJcJK2KTB+YR+PmVGFHfzeMssT55706lmrS+RFqQ/0bA+x07OUKMsJXqCyQzSBVTF2Ind3vHiQjFFxd/mgAylbs2xpt719C6UEQkPrqmjEuL+FQXPuozoVGu2CtxyZMTwjEtYldtu2Q47MKuGiIBNN9E8vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=wkvea9OY; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4cQdQK606Vzm0ySc;
	Mon, 15 Sep 2025 21:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1757971607; x=1760563608; bh=23miGv/7QuDmfuZP+/ZrmchU
	VWkCWSYajP4qSG4TBvQ=; b=wkvea9OYD7LrQtPQZS+KNEDFppoqKn1W/cjEM0q5
	ZuPeio2I25eY5AGxpk5XMasEYEwIUI9/547r2FOruI9PYelB1PKKA4iKezmP0N68
	A15uemDg1FK2vfFCa6iYWftjQwsXeuk6tP2cyELgBN9cfQ+FQIKaBrRh6iMvla7j
	91NxQa0g7E7XlqtIS77eQenkEv/UvetMICX+tKIxMt1tdLmjLuy6s8L3k+Ka9QiG
	Y+If7nWmgX4nkFz1/ZjPxr9oXtl/xQELWy5Z4AjqZXHdG29dVVrLPtfk9FPMrCBX
	E3nyrheu/lSgb6/c03+OwBd0gwpwsrs4LuqZLqiZEJitnA==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id BaI7MOOtGWAV; Mon, 15 Sep 2025 21:26:47 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4cQdQ51p48zm0yT2;
	Mon, 15 Sep 2025 21:26:35 +0000 (UTC)
Message-ID: <191ca54f-0faa-4615-967a-7b4c86d59e0e@acm.org>
Date: Mon, 15 Sep 2025 14:26:34 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] block: add support for device frequency PM QoS tuning
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
 <20250914114549.650671-3-wangjianzheng@vivo.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250914114549.650671-3-wangjianzheng@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/14/25 4:45 AM, Wang Jianzheng wrote:
> +#ifdef CONFIG_PM
> +static void blk_mq_dev_frequency_work(struct work_struct *work)
> +{
> +	struct request_queue *q =
> +			container_of(work, struct request_queue, dev_freq_work.work);
> +	unsigned long timeout;
> +	struct dev_pm_qos_request *qos = q->dev_freq_qos;
> +
> +	timeout = msecs_to_jiffies(q->disk->dev_freq_timeout);
> +	if (!q || IS_ERR_OR_NULL(q->dev) || IS_ERR_OR_NULL(qos))
> +		return;
> +
> +	if (q->pm_qos_status == PM_QOS_ACTIVE) {
> +		q->pm_qos_status = PM_QOS_FREQ_SET;
> +		dev_pm_qos_add_request(q->dev, qos, DEV_PM_QOS_MIN_FREQUENCY,
> +				       FREQ_QOS_MAX_DEFAULT_VALUE);
> +	} else {
> +		if (time_after(jiffies, READ_ONCE(q->last_active) + timeout))
> +			q->pm_qos_status = PM_QOS_FREQ_REMOV;
> +	}
> +
> +	if (q->pm_qos_status == PM_QOS_FREQ_REMOV) {
> +		dev_pm_qos_remove_request(qos);
> +		q->pm_qos_status = PM_QOS_ACTIVE;
> +	} else {
> +		schedule_delayed_work(&q->dev_freq_work,
> +				      q->last_active + timeout - jiffies);
> +	}
> +}

The above code is similar in nature to the activity detection by the
run-time power management (RPM) code. Why a new timer mechanism instead
of adding more code in the UFS driver RPM callbacks?

> @@ -3161,6 +3211,8 @@ void blk_mq_submit_bio(struct bio *bio)
>   		goto queue_exit;
>   	}
>   
> +	blk_pm_qos_dev_freq_update(q, bio);

Good luck with adding power-management code in the block layer hot path
... I'm not sure anyone will be enthusiast seeing code being added in
blk_mq_submit_bio().

Thanks,

Bart.

