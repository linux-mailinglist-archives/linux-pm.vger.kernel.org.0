Return-Path: <linux-pm+bounces-38986-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D83A2C9854A
	for <lists+linux-pm@lfdr.de>; Mon, 01 Dec 2025 17:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5585A4E1C61
	for <lists+linux-pm@lfdr.de>; Mon,  1 Dec 2025 16:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0078333506A;
	Mon,  1 Dec 2025 16:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="ePxi+MMQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9642D3EE5;
	Mon,  1 Dec 2025 16:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764607277; cv=none; b=TLwZ1I70tOex3rD21qOQ2AINExnJt74hkz1rBI6Wq/6oFf/3au5tGjH6ukC6auM1cXSCVmHBS40N9jcogIy9dGh42tq1iMwQOUDjMs/wrv7mBOKj+dP4NRqfMpzgdT31jtd7m5kKN0m4rG0r55LeHJfgaYIwlZWXbBSQq82YnhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764607277; c=relaxed/simple;
	bh=n22mnFCgra1/kvX/LOrq5Q9GpeVWXaFZcXBEOu6M1Eg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aZa7evxKrHdjvcDU4aOUe0jzkkbraKI96XjFwhqVC3JbRfg9Stec+Vzo4BbmQ5iTvfICQVpvgawPyVudfHZHpITp7ujoI/w7Xs1NkX9FhEb5XrH5HYBFmOdURczkBjpvwYuVsc14mtvrlwVAsN7w5USTTzXiXJmLES2w/AdgLno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=ePxi+MMQ; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4dKqR909WPzlfdfG;
	Mon,  1 Dec 2025 16:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1764607267; x=1767199268; bh=3vVBwXrJtJdYRLetKTxZMknj
	ratsHtr1hXr8mQzjG9E=; b=ePxi+MMQbPOI2ikZ9v/trKzLSXJmMCd6TSBJvSYz
	oiChBBqtXhmM7YWrVpJfaX4FBZyihLFiFjo1xpvEmBXJRWYe6JxEgpzUjYuWDaMV
	alg9vI3LVzpldubd82ckCJDbnQnAzV97VS54ag3FA/YB3B88yqCJVO1XA5OsJhcP
	/ibh55n8nMZD/Qk4DLdlc/wfsxJoQkZT8oqEwt4+Wg9B1Q8dS6vvxjCGvSAj4Nk1
	2ASQRXebzfmFwZVWEY9QQFNRk8FSwvQTyfZUx1EnNm1ezX6cfi9SfI5C5ArzxgM3
	JsycvjjpqDgflBe0EiVICMWdx4i27VbtsUlzIB29HUFDXg==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 68gd_yU59Up3; Mon,  1 Dec 2025 16:41:07 +0000 (UTC)
Received: from [10.46.6.249] (unknown [156.39.10.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4dKqR432YWzlfddm;
	Mon,  1 Dec 2025 16:41:03 +0000 (UTC)
Message-ID: <9e0301fe-9a22-4f5f-b42d-3bd3bae8d6da@acm.org>
Date: Mon, 1 Dec 2025 08:40:59 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PM: runtime: Fix I/O hang due to race between resume
 and runtime disable
To: YangYang <yang.yang@vivo.com>, "Rafael J. Wysocki" <rafael@kernel.org>
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
 <9b6e7d55-6a1f-490e-98c7-3c04f85f7444@acm.org>
 <CAJZ5v0hJw0WdHpqgUc5bz5qCSUNNKHg7i5-sNYeZcDYwRj21qw@mail.gmail.com>
 <6df79ec0-f5b3-4d75-95b1-03e488d45e7f@acm.org>
 <4f4dea0a-21b1-438c-94ae-9a785ad42569@vivo.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <4f4dea0a-21b1-438c-94ae-9a785ad42569@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 11/27/25 3:29 AM, YangYang wrote:
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 66fb2071d..041d29ba4 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -323,12 +323,15 @@ int blk_queue_enter(struct request_queue *q,=20
> blk_mq_req_flags_t flags)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 * reordered.
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 */
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 smp_rmb();
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 wait_event(q->mq_freeze_wq,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 (!q->mq_freeze_depth &&
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 blk_pm_resume_queue(pm, q)) ||
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 blk_queue_dying(q));
> +check:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 wait_event(q->mq_freeze_wq, !q->mq_freeze_depth);
> +
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (blk_queue_dying(q))
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return=
 -ENODEV;

This can't work. blk_mq_destroy_queue() freezes a request queue without
unfreezing it so the above code will introduce a deadlock and/or a use-
after-free if it executes concurrently with blk_mq_destroy_queue().

Bart.

