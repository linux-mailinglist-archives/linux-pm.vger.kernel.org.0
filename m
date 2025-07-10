Return-Path: <linux-pm+bounces-30617-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88810B00785
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 17:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A943E169C66
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 15:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86716274B52;
	Thu, 10 Jul 2025 15:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VJHGUBTM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5442713B293
	for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 15:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752162302; cv=none; b=Pntr1QclzQmBpqRdty4TBv6LmMlhBO8ZwCc3d25YadEgdcwljKuXncNiuyVq+Myrl/W5/jKe0HPddwV7hV0QCEtlfEOEsrnRQGnKTPlgdtuqXbHHxGY/WPl6UxF4Q/UK7ybqPf90fNhR/z2YECjjC9ubDo+FHs7/MDxQJgV3org=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752162302; c=relaxed/simple;
	bh=QmujRR/DPSYeyQdUA2QOLtioAeBLj6yZR1ReOaTTl+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4UEojHaZ1/6i2yET3oPrBTqgzilLvmqvv/gk2ejhha2lE9RbAHT0Q0eUmk0oVlmaxOsgMuESkWQ+4dT/ceptxcQNy6uOsqe7+TB3g5WJraG204/4Nx7A+H4+mta1WuFWJj7TjGfBo3+oC8XdMz0a1QyJV5OWCMNtxPZNa/Iq+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VJHGUBTM; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3b49ffbb31bso720266f8f.3
        for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 08:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752162299; x=1752767099; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DfKz8g7IocA8u5rsIUzAiiuZKjZKWsYc3v5k3LQbtY4=;
        b=VJHGUBTMrwMERuPq97dXUa1f3iWn0ttX6YUPPU3Bf64GuLg08iC/mOmzAbhEXMt963
         QFGir/+AUhFavobeK6ga7QThe5y8TidehjGwrxBScWT0W2otPz7JTPBri5eyfdxjxjjr
         WgtGihaGQ5PGjxyWytU04/ZbJQO/eqaiJk+k7ryUN6sA1AuMLIElY7sO2skSx45m+0Y9
         LBjWx+LCYBHgZ9w9mNilyJSpIBGen428HNXQXT2HLuTw/QUE9oQzqf79CRFiKnDtlDM/
         tsyjK76Z6OoZ/uY3qCmIWazs1QCGKjEYMFT0GT3+fPdlIAOuFvHAhs8ixJrWqtpoIKv4
         PGMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752162299; x=1752767099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DfKz8g7IocA8u5rsIUzAiiuZKjZKWsYc3v5k3LQbtY4=;
        b=jtlkOpPHSwu6hmCPoTVLYWfkawbe1YLjw+a2jb829EVr2JRSQQE1VJGMcxhUn381cb
         sY1ZopHgt3A1mz+e+b7DWJs7rfzz1SSJFVabbVMnoXrtDYEyzGhoytAHZD/wjVQUt8cb
         GSsHUiUmmTrLAQWTFGipeoMXmUF3otIaSjcKr3ebFMihi8KPdmZYtxeRFM9bXOdAmD+N
         06KeSPvyK0ehOjFY90VbJPg5zYic+96WJHr8vu7gdkb55/8lzwU6r8LQ6E8ze8ZWRk8B
         bKUcP/2XLHrptpm3PveH17eDxTOLCdP9RNtBDEnRSGbRby78weIO488XccumYQaPB77L
         PJMg==
X-Forwarded-Encrypted: i=1; AJvYcCXhKG3r1tkkTkNyQLjchNt4RWDuhkH7u+TblyRk6rWW1jPB3I7e67nbhblOAcMuvbAt8nvS3F6FdA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWnnOf1phXMUDVUq7i5xDvmAjF06hrKWN6sl9tPeKWF0lCmPa5
	CYDdEmUBO4WqfKfUsIV6t5+teO4BJgYuRgGHGKs88d3XVjrldfivzlbOABhlplIYK34=
X-Gm-Gg: ASbGncsCCGUly0ya+fA8xGOlKHn2mW+Rzg6oI0JMcYLCvqxQWA2WvUf7EW2tCW+df4m
	0OlEi7qeuZbsZnX/zrVsXvJUnkPhM/Aa6h88aE+2TlDU+ioGVvdrtP8PXbShULW6v4ztedPJlB8
	unDPoQQJNHE+7O/Kh/X+0aQKVut08Kgd2yvJ95ZDVEtRJUJDMYuFpQ4qxJsZ2ftitwaH3BQxul9
	PSxWvGDU9D0bMzkzYlNAa7nvzyy2yVS5lWqNEqb1K23ltpT3n+XckrTNltXDxgGnuEAztua3qgf
	IRMMJhmyXfcqhQGBnrWa3z9rKgdroG3M8YowaEbZ3tG2i/kQHXwFWb4LCd7LCtKV
X-Google-Smtp-Source: AGHT+IEi2g5/DN1K+2wwgAq7qMOuInWE+sU8AeJJ+3cUVcc8tWGmi1OpKIHzd2MuXTKU6wOxwERxHA==
X-Received: by 2002:a05:6000:4603:b0:3a4:dd02:f724 with SMTP id ffacd0b85a97d-3b5e4536c3fmr5408824f8f.43.1752162298609;
        Thu, 10 Jul 2025 08:44:58 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d50dcc84sm64914835e9.24.2025.07.10.08.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 08:44:58 -0700 (PDT)
Date: Thu, 10 Jul 2025 17:44:55 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: Peter Zijlstra <peterz@infradead.org>, timvp@google.com, 
	rafael@kernel.org, pavel@kernel.org, tj@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lujialin4@huawei.com, chenridong@huawei.com
Subject: Re: [PATCH next] sched,freezer: prevent tasks from escaping being
 frozen
Message-ID: <2v47s2xlbmuz2mgxk2p7o2q4t343nde6hkyqxpmfgmrjygmrz7@alrwuxvupe36>
References: <20250703133427.3301899-1-chenridong@huaweicloud.com>
 <n23vsu6y6cjf2vwdbfcjl2mj7venvpzpblncoa7adn3q5r4lph@qsfa3deqtamc>
 <f4c4f465-72b9-4682-99e6-c249ecab8572@huaweicloud.com>
 <8dae8006-e63d-467f-bb7c-e8470878e534@huaweicloud.com>
 <20250704075718.GA2001818@noisy.programming.kicks-ass.net>
 <85fc85e8-af92-4d58-8271-9bf4aeb0a63d@huaweicloud.com>
 <bdc5a4d3-6942-4ba2-a13d-35f2e13c0b37@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="paycgh4vipu5nayz"
Content-Disposition: inline
In-Reply-To: <bdc5a4d3-6942-4ba2-a13d-35f2e13c0b37@huaweicloud.com>


--paycgh4vipu5nayz
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH next] sched,freezer: prevent tasks from escaping being
 frozen
MIME-Version: 1.0

On Mon, Jul 07, 2025 at 12:02:47PM +0800, Chen Ridong <chenridong@huaweiclo=
ud.com> wrote:
> I was looking at the WARN_ON_ONCE(freezing(p)) check in __thaw_task and s=
tarted wondering: since we
> already have !frozen(p) check, is this warning still needed? If we can re=
move it, maybe reverting
> commit cff5f49d433f ("cgroup_freezer: cgroup_freezing: Check if not froze=
n") would be a better approach.

I think freezing(p) (the part of global freezer) and cgroup_freezing(p)
should be consistent with each other. AFAICS, the former predicate is
derived from pm_freezing and that is set all the time between
freeze_processes() and thaw_processes(), i.e. it stands for both the
transition (freezing) and goal (frozen).
With that, the warning in __thaw_task() is incorrect and the solution
might be the revert + drop the warning.

(Or transfer the logic from cff5f49d433f only to the warning like
@@ -204,7 +204,7 @@ void __thaw_task(struct task_struct *p)
        unsigned long flags;

        spin_lock_irqsave(&freezer_lock, flags);
-       if (WARN_ON_ONCE(freezing(p)))
+       if (WARN_ON_ONCE(freezing(p) && !frozen(p)))
                goto unlock;

but I'm not sure the warning buys us anything in either case.)

0.02=E2=82=AC,
Michal

--paycgh4vipu5nayz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaG/f9QAKCRB+PQLnlNv4
CD0AAQCwacgAQtPb5lDXkPUYXAxsRthQNUdqxkR0o4AUiOIrLAEA1ffpWdi73UAZ
BXGSp+kJOxD2mYefTfoKzPggWAziwQs=
=VYIq
-----END PGP SIGNATURE-----

--paycgh4vipu5nayz--

