Return-Path: <linux-pm+bounces-34694-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1ECB5866F
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 23:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD9A51AA450D
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 21:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A444299928;
	Mon, 15 Sep 2025 21:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="V9M3mHny"
X-Original-To: linux-pm@vger.kernel.org
Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC8E21ADA4;
	Mon, 15 Sep 2025 21:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757970820; cv=none; b=ZVHPerex1mFsX4EodBkITwfyCZpaLdFIr5xc70j73eMAjFKi2ySsYYV0vU9mBNJW2kGhLRBYC+BkSLBv+sVDJ14iin20LcC7NZSAFMocrr+lyJKv9FQIIHMVM4gRkSVSs/XoK3vG1YAr4QVGFDNKTPKKL1uXbNiRzp+ARFwL9U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757970820; c=relaxed/simple;
	bh=b7j6GZi412ueow51HzKyXGMlHBRPqzhaWxnJ8uOLJis=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iQ6oKuiena0iQq/gD2X4EeqNWsR0YueLYuR5epFHhMMhoShDYmRCzjyAH0T2f8Nln0yw8D0sIbjM4CFFfxL/s6gnLzofGyZIb96vXDac8DqwQS/50ONUBf/ZpMYa6fGd1KXpKUnU6TaD4xGCD2E5REZaau1zyCeSRHlIjWMrWn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=V9M3mHny; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4cQd750Y9bzlgqym;
	Mon, 15 Sep 2025 21:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1757970814; x=1760562815; bh=MZofNrSVrRxRHA0wbrVBt74B
	lOQHfAgc3sQoZn9Cj6k=; b=V9M3mHnywilQ2XJ/fnoyGOf4D/BAKWqEAvvy7aSD
	xMSUAy/sIrrDW8MKDX6TMJe4RcOHYsd5YJyu8M3NapN3kmF9OGbHcIga+gkCtRH8
	6X9/fVOEaCBDXZLyvVfYZlU1TBnjxV9iRSA8quPGNqSvHHLafw05rKXpbVzukt0J
	6umug0CgPuT2bZHnoNooxK2PzsAhyvgDdZdAYwW+VMmjr/kMZzvlmQkD14VPPdTd
	11bE7HGs6Vax8AZ9xy5CrQtP4rDyoNgf8RGaiGeV1PyJ278abFfuVDr34dIYDecG
	H6HIZLbtnA37XoQVT2vNyAR6PAbvSnlcPsuDfNvdoboJvQ==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id aDwpiAhHXHrd; Mon, 15 Sep 2025 21:13:34 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4cQd6r24Q8zltKFh;
	Mon, 15 Sep 2025 21:13:23 +0000 (UTC)
Message-ID: <de099236-8c97-4ecc-9af7-740f09c2b0b2@acm.org>
Date: Mon, 15 Sep 2025 14:13:22 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] block: device frequency PM QoS tuning
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
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250914114549.650671-1-wangjianzheng@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/14/25 4:45 AM, Wang Jianzheng wrote:
> Now, the patches provided here intruduce a mechanism for the block layer
> to add constraints to device frequecny through PM QoS framework, with
> configurable sysfs knobs per block device. Doing following config in my
> test system:
> 
>    /sys/block/sda/dev_freq_timeout_ms = 30
> 
> This constraints is removed if there is no block IO for 30ms.

Why a new sysfs attribute? Is this attribute really necessary? How are
users expected to determine what value to write into that attribute to
achieve optimal results?

Thanks,

Bart.

