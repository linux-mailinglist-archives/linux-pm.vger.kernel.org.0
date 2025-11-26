Return-Path: <linux-pm+bounces-38740-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DC3C8B753
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 19:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6460A357E41
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 18:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A04E31283D;
	Wed, 26 Nov 2025 18:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="WtE9dbTf"
X-Original-To: linux-pm@vger.kernel.org
Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B64286400;
	Wed, 26 Nov 2025 18:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764182457; cv=none; b=dT36aaLWqiXy8VDyekQDtPdzVY0V5wdTCt1O40YSsxEMXlowBdd2TBwMBNVh0SRPZn+6yLYiLiQcfIYUF+qjCsb6xVFPu08MslHA3m/f2Hw3hZKpIc+EDGLJDLbAzK0Zc8gvuCP/FlSsyV4U7uhuwwuwFyvqnNK3T7fjU7j5w74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764182457; c=relaxed/simple;
	bh=5jLS1N/2ywUk86CuNRXBOI15IpbaXR6QtQfFQQBoXog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lxEk23ccf3SMLQ3bqFpGgqD0C5jbQ0NU2jwllFcNrVNbqXylY0J7CfQD6F9iHFxzzNjAsLb16/InYoFwkrt8MFug+dVSnGkCOHUSDgYa/C1uB4rIe43gdUTdaYlDiYY3FV4fKBFTf0AezTulanyruty3Z4mDHkll16rSLBKq7lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=WtE9dbTf; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4dGpKf1xmzzlgqjY;
	Wed, 26 Nov 2025 18:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1764182452; x=1766774453; bh=LBr/H9thucmkz+XG3TYqhVuu
	Nh3PUalzinUiqZMAjPU=; b=WtE9dbTfZj+tkEHajz+1hPmAZfFx2vNNJ72XGaSN
	NjVFi8BTCAgQ5yl0xzTob95FArYB9uOaqxJ17EDYX+28tlJbtoNr2FvyB0LHISzo
	G7Pb+561nDvAWKUuKViFIuPxtVFm+r/C8c17f056d1UbPSgdvMuwYXM3JFDsBiF9
	jFux+xO/eXtEq/J3jbVA/6huZ3suPtzTnOM8VDd8XDt1O/6AalW6Cw3uRzIAu7oZ
	FyhMLhur+7ej4E3Gleb/ez13wIbwiOrh2NNX13c6+8BIZSuIsEpDvTL7RXtVcGtk
	7s3jDArioqd75tu9PIY/wBrhR0F4tpFoSSv3NgyK4IPc+g==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id IIEdmQhFngAr; Wed, 26 Nov 2025 18:40:52 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4dGpKJ3xFzzlgqjQ;
	Wed, 26 Nov 2025 18:40:35 +0000 (UTC)
Message-ID: <6df79ec0-f5b3-4d75-95b1-03e488d45e7f@acm.org>
Date: Wed, 26 Nov 2025 10:40:34 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PM: runtime: Fix I/O hang due to race between resume
 and runtime disable
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: YangYang <yang.yang@vivo.com>, Jens Axboe <axboe@kernel.dk>,
 Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20251126101636.205505-1-yang.yang@vivo.com>
 <20251126101636.205505-2-yang.yang@vivo.com>
 <CAJZ5v0i1YLiri9oiiq2W6_KSbqGuWOqdrMPrOf=do-DdW=_rfA@mail.gmail.com>
 <1a2d2059-0548-4c5f-a986-5081447c3325@vivo.com>
 <CAJZ5v0iSgrLzsjh+bvF2=rxxhYcBetJ6V-joWaQud4ahkm1GkQ@mail.gmail.com>
 <9b6e7d55-6a1f-490e-98c7-3c04f85f7444@acm.org>
 <CAJZ5v0hJw0WdHpqgUc5bz5qCSUNNKHg7i5-sNYeZcDYwRj21qw@mail.gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAJZ5v0hJw0WdHpqgUc5bz5qCSUNNKHg7i5-sNYeZcDYwRj21qw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/26/25 7:41 AM, Rafael J. Wysocki wrote:
> As it stands, you have a basic problem with respect to system
> suspend/hibernation.  As I said before, the PM workqueue is frozen
> during system suspend/hibernation transitions, so waiting for an async
> resume request to complete then is pointless.

Agreed. I noticed that any attempt to call request_firmware() from
driver system resume callback functions causes a deadlock if these
calls happen before the block device has been resumed.

Thanks,

Bart.

