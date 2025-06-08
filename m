Return-Path: <linux-pm+bounces-28224-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5EE5AD1318
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 17:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D87B188B279
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 15:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4D316CD33;
	Sun,  8 Jun 2025 15:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0+t4l0I"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7945B13AC1;
	Sun,  8 Jun 2025 15:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749397851; cv=none; b=t/Jn7x2JMhGHrEp10gBudcheq7bsNcklMAzJKdw0EhfuQZgplGB5Ek7Cd/+yR/dazGCcfM+GN3evk3VtH11/HfPILXCWSYHm1RaYc+6RbYEPIt1dZ6spJ1RNuhZkdoQRHIQOaxFsBVBCWh9po1PlYdrp9Xoxg2P3laIbvLGcXcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749397851; c=relaxed/simple;
	bh=ld66+8SPUF5eKkfV5/4/6/qekk9HAbDZ/uR2gvnokE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0gP0b481mZKRQUO5SZYPfyy+1epHC8VevSaxJIy8XnEx4DrDjCy2o9usl4o4ql2EwM/8SF36Blokq73iJ+mTAFzdycSxSm0eYFJ9wG5z9tMIiqIGdZkbTdhAMNILIEVy88hL6rUK5I4yZDLoCwFh6b/35b5JBkRiwXyAcF8PYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0+t4l0I; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-adb47e0644dso777801866b.0;
        Sun, 08 Jun 2025 08:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749397848; x=1750002648; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mawc/hjEIEP4GahIikXDvnZC+zUB4+YLU7y4fFNxo+0=;
        b=O0+t4l0IBUU192wh9dd6nZfNcBe6tRV0BPCtiIVtb9TijvIBko/M9JIcuyFTuwpr4e
         pJ0CfrYQniQn6XDhiJw7/yeY4SMqGSBoSF1WEr3R8w5SeqcelZb9hHc+q/v+0wGu5yhK
         HkHEuUYK+hjsGwqyjRyW9SR1MyCDKogyWTwE/ASciOvkWNBPpjJMIt9wHHkxb9KWz+UL
         wayPBXNQNgeFO0oHJoIPs7rSK+JJ5GECaXTgzdAGN1tC1foshYWSzzMdhgsNhevKfKsN
         B6yEvbHpMHcVIQEfQDpt7k0w4vTZ/kaeuOr18tFi0L8KkSL0zylqOnrYcTJH7YPjqR0+
         TJlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749397848; x=1750002648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mawc/hjEIEP4GahIikXDvnZC+zUB4+YLU7y4fFNxo+0=;
        b=v+5bmPSNnFd8wvX+krfASxhxXc0oMuGYC/afXsL0BMkQx4o2wtVwN9bPF3X3daKbAe
         ee+YjMFnu+KydVrikCOnBvvLTF9WOzqGzMG5+pYVl3rz85xW+BpNnwlXXoCNQgwz6dwe
         MW9HBjZM3WkOuN6rytwWwmcw2JPQKXxaagiy9hcs+2fLBXIPpd5nlMS/Q3Qp4MXIArzf
         sYHwhucFSNGlcPaMdBpWg0cQwwA1zMvzt2lEnJS0YXrdMOyAU2vducb55oAolAao7dcv
         46XbFAZ3iFBaaC/A+hAr8hlkL4bXc8/5c4HoqIdpZkMQcKqLR24QlqZPnPehpR88GaLO
         HTRA==
X-Forwarded-Encrypted: i=1; AJvYcCUuA0Dpfyw1s1AwFFH09ZLcRnoCEei8njhzFb54RMhbeVzGm+tb5lhhLp5WPAsDajD3h+HFPO1czDo=@vger.kernel.org, AJvYcCXh4XdarG5eB3YhaBgYKHfwZiCQmi1vCEc5rJDtyTm6OBmsBTxY9fX1Z5q8xszrYKkjd/NFkgLFO+SoorA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgdDlxMIBWZqx0/2jQYjt5DhsSAbokUe4WmNIeuNXPY0qZkNyn
	GK5UMCius7iRkcsYRWPMh1RPRoEY6IS8WRyIK84CyBTbhqUjTKSYZOaJ
X-Gm-Gg: ASbGncupze9bt8402ZBRoljRjlf9Te+zD1MU4mRDqFZE7370MYD23Zx4oTmpq5TWHbx
	Dt9eq46ywFT3uIMCb7Qfh9ea3fFNC/6L0REeYdu0laNAqPaPH3C/5MUjmfD1Ic/kOoslN7NhQ5O
	z9D3rBlYwvykkAf+SBLYZMudn2b4NlY0rRbgC6rxB26JZgsbRdOMZePVWix4xE2kepcpUJnc0zK
	sZ108rtSRAGGA9uRulzw0A+hAGhPUUARXxzf/1tZjNGG3Kx5lwqyUpmFoomMUwsm6pKfV/b8sWq
	5m3C0Loj7+U9octIl4zQhNBqE49M26uY8qoJ9OwcDfLLV1vsxYEhr1oQEEEauOripzE=
X-Google-Smtp-Source: AGHT+IH1a7k2SlTTME9RiKmu2TSHuf5P++u1/KhfTj8OVZsWfdSp1kkhb3YRrJfUvAKQ7HGUKPLiFQ==
X-Received: by 2002:a17:907:9726:b0:ade:4121:8d2d with SMTP id a640c23a62f3a-ade4121a183mr483102866b.20.1749397847367;
        Sun, 08 Jun 2025 08:50:47 -0700 (PDT)
Received: from f (cst-prg-65-195.cust.vodafone.cz. [46.135.65.195])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1dc1c4c9sm430116666b.108.2025.06.08.08.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 08:50:46 -0700 (PDT)
Date: Sun, 8 Jun 2025 17:50:33 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: zhangzihuan <zhangzihuan@kylinos.cn>
Cc: David Hildenbrand <david@redhat.com>, rafael@kernel.org, 
	len.brown@intel.com, pavel@kernel.org, kees@kernel.org, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, 
	vschneid@redhat.com, akpm@linux-foundation.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [RFC PATCH] PM: Optionally block user fork during freeze to
 improve performance
Message-ID: <5mj4mc7asiplmgbqyl2uaw5cdpt6dpdrhtapi63dcrowozcwuq@c4cxyaxwe6aw>
References: <20250606062502.19607-1-zhangzihuan@kylinos.cn>
 <0030581f-d50a-48f4-86f5-58e7883f705d@redhat.com>
 <6350624c-7293-43de-8788-e52a236d91fb@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6350624c-7293-43de-8788-e52a236d91fb@kylinos.cn>

On Sun, Jun 08, 2025 at 03:22:20PM +0800, zhangzihuan wrote:
> One alternative could be to block in kernel_clone() until freezing ends,
> instead of returning an error. That way, fork() would not fail, just
> potentially block briefly (similar to memory pressure or cgroup limits). Do
> you think that's more acceptable?

So I had a look at the freezing loop and it operates with
tasklist_lock held, meaning it already stalls clone().

try_to_freeze_tasks() in kernel/power/process.c contains:

	todo = 0;
	read_lock(&tasklist_lock);
	for_each_process_thread(g, p) {
		if (p == current || !freeze_task(p))
			continue;

		todo++;
	}
	read_unlock(&tasklist_lock);

I don't get where the assumption that fork itself is a factor is coming
from.

Looking at freezing itself it seems to me perf trouble starts with tons
of processes existing to begin with in arbitrary states (not with racing
against fork), requring a retry with preceeded by a sleep:

	/*
	 * We need to retry, but first give the freezing tasks some
	 * time to enter the refrigerator.  Start with an initial
	 * 1 ms sleep followed by exponential backoff until 8 ms.
	 */
	usleep_range(sleep_usecs / 2, sleep_usecs);
	if (sleep_usecs < 8 * USEC_PER_MSEC)
		sleep_usecs *= 2;

For a race against fork to have any effect, the new thread has to be
linked in to the global list -- otherwise the todo var wont get bumped.

But then if it gets added in a state which is freezable, the racing fork
did not cause any trouble.

If it gets added in a state which is *NOT* freezable by the current
code, maybe it should be patched to be freezable.

All in all I'm not confident any of this warrants any work -- do you
have a setup where the above causes a real problem?

