Return-Path: <linux-pm+bounces-30931-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D84FB07B56
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 18:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B23DD5082A3
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 16:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162362F5475;
	Wed, 16 Jul 2025 16:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UKOpyroF"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671FC2C158E
	for <linux-pm@vger.kernel.org>; Wed, 16 Jul 2025 16:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752684000; cv=none; b=Mh5Fiwft3dZPIKsAX90tQB1ftNkGSOsRpkMsPEsdnab9G/FTNZf63bbiBJ1ABM42JUGgWsT4fTT0f/PKpNTMFGoQuNjXrQnjHjQGDjGcg8YrzLqX20L3xIqsJkN26BKYlBZzAh/PV4TIr3Q+t5S6fxe8s/uQTvlKjbNI9Bza/M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752684000; c=relaxed/simple;
	bh=pfZR/2u7W8/6HgT9wLum9rQ1ZFFBE2W4KpQ2JWvSvwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=laFspGj0kpm3q4AZw61GBhF+Mm0SNz4kJ3q+tpfNh/NFIcgbkUEDc9qjg7hGFvjcRi7pZuTzK3PlVjYHqX6kpPIQ3rIGTfewI97VHCQVtAhrY2nubvEeccdyHhC13ExMI0glFgfzHXOH5JDXd1jzsk6RAH0mcYK/bVlmNqZomug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UKOpyroF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752683997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MWm03jBczOfqH0toUNXJ1+5OAe5fFoVsbG14rgdUNFU=;
	b=UKOpyroFXcRNRVJmzq3JsSNMCtVkxQMa+6bzMPjfIGGF3aSOHJvns5XoWxYr++CubEwb1R
	gckiXgThIwsr1R+fdTFwQhMS7QzCpKMUxcPqZ8tKvGC+kdYTwGOfSg90GwGEPMLvde7SZ5
	4m8xAwxV/MZ6ek5mECHmN7VYiYEOEr4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-npuIb313OTW1IVpwICBB7g-1; Wed,
 16 Jul 2025 12:39:52 -0400
X-MC-Unique: npuIb313OTW1IVpwICBB7g-1
X-Mimecast-MFC-AGG-ID: npuIb313OTW1IVpwICBB7g_1752683991
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C06CF1800447;
	Wed, 16 Jul 2025 16:39:50 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.32.192])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 4045618002B6;
	Wed, 16 Jul 2025 16:39:46 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 16 Jul 2025 18:39:00 +0200 (CEST)
Date: Wed, 16 Jul 2025 18:38:55 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "rafael J . wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	len brown <len.brown@intel.com>, pavel machek <pavel@kernel.org>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] PM / Freezer: Skip zombie/dead processes to reduce
 freeze latency
Message-ID: <20250716163854.GE16401@redhat.com>
References: <20250716062639.1528066-1-zhangzihuan@kylinos.cn>
 <20250716062639.1528066-2-zhangzihuan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716062639.1528066-2-zhangzihuan@kylinos.cn>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 07/16, Zihuan Zhang wrote:
>
> @@ -51,7 +51,15 @@ static int try_to_freeze_tasks(bool user_only)
>  		todo = 0;
>  		read_lock(&tasklist_lock);
>  		for_each_process_thread(g, p) {
> -			if (p == current || !freeze_task(p))
> +			/*
> +			 * Zombie and dead tasks are not running anymore and cannot enter
> +			 * the __refrigerator(). Skipping them avoids unnecessary freeze attempts.
> +			 *
> +			 * TODO: Consider using PF_NOFREEZE instead, which may provide
> +			 * a more generic exclusion mechanism for other non-freezable tasks.
> +			 * However, for now, exit_state is sufficient to skip user processes.

I don't really understand the comment... The freeze_task() paths already
consider PF_NOFREEZE, although we can check it earlier as Peter suggests.

> +			 */
> +			if (p == current || p->exit_state || !freeze_task(p))
>  				continue;

I leave this to you and Rafael, but this change doesn't look safe to me.
What if the exiting task does some IO after exit_notify() ?

Oleg.


