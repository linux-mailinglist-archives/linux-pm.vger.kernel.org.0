Return-Path: <linux-pm+bounces-38723-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 759ABC8AAD7
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 16:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 33A97355D41
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 15:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154F4339B49;
	Wed, 26 Nov 2025 15:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="u6sODHKa"
X-Original-To: linux-pm@vger.kernel.org
Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2292123372C;
	Wed, 26 Nov 2025 15:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764171261; cv=none; b=Y0jLDgL6JR+UtDV5C0D2Go0Gxdvu89BswST9vLZCvIwUU+LjR9U92C4eBsdD+kf+7pMr2dlZIu6JBn2MpgpnFEnZwOgp0jguL8bJe2TrNKrw6RRLI3nk8YluPiUXLCFoiC2A0eROiejux5kWIz0p6zeadZhbbKpQKxmcUADcX/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764171261; c=relaxed/simple;
	bh=paKrs7yXqi9ntWtPsmuVhsk6+zHX1rvw13z0IhPUBUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p+UJvjpZr00ublCpqjw4+sCKMDu2Q/SB4IwT+rGmbI/S7W6DbLXcQNGFsOse3EK7m93TCb9WYgoFx/h8CHuFdTGnU/EoU0LMbcunI1R/gd9FnYXyGum0Zyeo0XZkRJZEj4Iqh04fm0hY2YiKVpN/R3nm5FaRnUrxe7R+TzW1XTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=u6sODHKa; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4dGkBF2Q44zm1Hc4;
	Wed, 26 Nov 2025 15:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1764171251; x=1766763252; bh=XsWD+FfiDmZSdZWNNBeoyZ7+
	as6zrRAU4D5VAHLXwHc=; b=u6sODHKaaW7byFI0aMx5DzmeP+HZ/bFnu48EgdYC
	EozerBCeUvYqI6rWeEw/6LoxnxNSbmbk6Dfmi7OTehWPHOFhNbtuM3o5Vq8WxT85
	yVq5GWSEOyvNxwE2yRir5lLpWSVQJHxVTS5QJoKY1zdNNgB14+SJhWL9FtRaFjPU
	EoxNDxGJgjYu+8/Ias+iTQbnT0cq5Fd9LgPTZ3lM6gauifSBZ6japxoKI5/e0POu
	jYzWcexM+i48YzvwVhyOS/7siOqCd9ZLuZSC7r202ZwTlwVCacyyNMm+jwHpU7um
	OF0CsZcw467b7+xs/7DIzhEY6YgHnox083c6DOvNLVTFvw==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id JFad-4fXKcap; Wed, 26 Nov 2025 15:34:11 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4dGkB118dGzm0XCV;
	Wed, 26 Nov 2025 15:34:00 +0000 (UTC)
Message-ID: <9b6e7d55-6a1f-490e-98c7-3c04f85f7444@acm.org>
Date: Wed, 26 Nov 2025 07:33:58 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PM: runtime: Fix I/O hang due to race between resume
 and runtime disable
To: "Rafael J. Wysocki" <rafael@kernel.org>, YangYang <yang.yang@vivo.com>
Cc: Jens Axboe <axboe@kernel.dk>, Pavel Machek <pavel@kernel.org>,
 Len Brown <lenb@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20251126101636.205505-1-yang.yang@vivo.com>
 <20251126101636.205505-2-yang.yang@vivo.com>
 <CAJZ5v0i1YLiri9oiiq2W6_KSbqGuWOqdrMPrOf=do-DdW=_rfA@mail.gmail.com>
 <1a2d2059-0548-4c5f-a986-5081447c3325@vivo.com>
 <CAJZ5v0iSgrLzsjh+bvF2=rxxhYcBetJ6V-joWaQud4ahkm1GkQ@mail.gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAJZ5v0iSgrLzsjh+bvF2=rxxhYcBetJ6V-joWaQud4ahkm1GkQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/26/25 4:36 AM, Rafael J. Wysocki wrote:
> Well, the code as is now schedules an async resume of the device and
> then waits for it to complete.  It would be more straightforward to
> resume the device synchronously IMV.

That would increase the depth of the call stack significantly. I'm not
sure that's safe in this context.

Thanks,

Bart.

