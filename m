Return-Path: <linux-pm+bounces-19560-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 952FD9F8D24
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2024 08:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B7687A296D
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2024 07:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268741946C8;
	Fri, 20 Dec 2024 07:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bRcQGZ3v"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266581304B0
	for <linux-pm@vger.kernel.org>; Fri, 20 Dec 2024 07:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734679354; cv=none; b=XkUHDa5sFMZuF1vHqV/qaO0+15xQt1mIRMXzTeeZ6V5Jd9uMG6PCPBUN/uPfEFsiPUKkpw7sR3jN1NebLU/ErKsea2FvGh90UPG+WuM5SZPesPjprsztFijmhc0tm5P8f1IvDZ9xSg2QRPXLHrIlC0SFrvMiFfI9F1E6WjcTzLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734679354; c=relaxed/simple;
	bh=mD0SSobIGbBT5eejdQTqxB+QHJJCwWIlX7PTGwwLltQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLF3VhaABJrPlf2KX5PHpdIPeQ2bzFZwXsmtvNdyIb/VyRxCw5wI+ewx6bm6Hl8B/IiIa7pdU/7Nji8bhbzFHzA17OcX/Qofo6j1br+gYGxszh+CM6phJrCFFMP1k4tDkVRhJ/Z05gDCP9c11hKJXU9YmwBF10rhSWhQ1uiwnjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bRcQGZ3v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734679350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VV1GAbU6vs/Ml1xhCadOL44dM9zTf3oC8kpgBVJ9ouw=;
	b=bRcQGZ3vEO8upouDA2q+oT8Ehz2tdfdn1fM4brJ9BSdeVi2TfuuQgPDEbLmr7Gao2e0cuN
	6makcYIfy5xglsaDxF2lXVUzhzA3DmFoo8fefCqEXZJFyXNGKU6m+oGs2yD8bNC6QI3Qh8
	TpMPYFQX35EliK/39p4KZxtTGfl7NZQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-r-LCiKK2MmeyGdwoo16F7g-1; Fri,
 20 Dec 2024 02:22:25 -0500
X-MC-Unique: r-LCiKK2MmeyGdwoo16F7g-1
X-Mimecast-MFC-AGG-ID: r-LCiKK2MmeyGdwoo16F7g
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0BD7B195608C;
	Fri, 20 Dec 2024 07:22:24 +0000 (UTC)
Received: from localhost (unknown [10.66.37.175])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5A1B719560A2;
	Fri, 20 Dec 2024 07:22:21 +0000 (UTC)
Date: Fri, 20 Dec 2024 15:22:17 +0800
From: Baoquan He <bhe@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ming Lei <ming.lei@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
	Linux PM <linux-pm@vger.kernel.org>,
	Kexec Mailing List <kexec@lists.infradead.org>
Subject: Re: Does anyone actually use KEXEC_JUMP?
Message-ID: <Z2UbKdmmgd/IzMoz@MiWiFi-R3L-srv>
References: <4968818.GXAFRqVoOG@rjwysocki.net>
 <d29738023f117bbd4031579443e0c2f8f1f78592.camel@infradead.org>
 <87h673zkhr.fsf_-_@email.froward.int.ebiederm.org>
 <E64227FF-E6A2-4E2C-85F3-EF1D9EFEC91F@infradead.org>
 <87bjxbzdyq.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bjxbzdyq.fsf@email.froward.int.ebiederm.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 12/16/24 at 12:21pm, Eric W. Biederman wrote:
> David Woodhouse <dwmw2@infradead.org> writes:
> 
> > It isn't broken. I know of it being used a few million times a week.
> >
> > There are corner cases which have never worked right, like the callee
> > putting a different return address for its next invocation, on the
> > stack *above* the address it 'ret's to. Which since the first kjump
> > patch has been the first word of the page *after* the swap page (and
> > is now fixed in my tree). But fundamentally it *does* work.
> >
> > I only started messing with it because I was working on
> > relocate_kernel() and needed to write a test case for it; the fact
> > that I know of it being used in production is actually just a
> > coincidence.
> 
> Cool.  I had the sense that the original developer never got around
> to using it, so I figured I should check.
> 
> Mind if I ask what you know of it being used for?

I am also very curious about the use case and asked David in other
thread, while David didn't tell. Not sure if it's one company's
confidential information. We may want to know what it's used for to
evaluate if it's a generally useful use case, or an unintentional
testing.

> 
> I had imagined it might be a way to call firmware code preventing the
> need to code of a specific interface for each type of firmware.
> 
> Eric
> 
> 


