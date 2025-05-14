Return-Path: <linux-pm+bounces-27149-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34718AB7348
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 19:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B11B3174F2F
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 17:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B48280CDC;
	Wed, 14 May 2025 17:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d8wXO3cU"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F0A1DE4E3
	for <linux-pm@vger.kernel.org>; Wed, 14 May 2025 17:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747245203; cv=none; b=IHlSoAMgTzuqSbcUDK2Z0Nws8z0FvqqCPBaub3NiU1WWx7rvFdPt/MQ1hDJhruWLkqUZ82Qm2VtzHui8gbiybHpT1YSHbzK/27GkJ/jknt3NNsysMG/coSScKfQ0mN2UJ4fLkIPxWNPzUSdwxhBedqjFpWX6AKW0qZLnL6EBt+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747245203; c=relaxed/simple;
	bh=YpRdDXVfyhLuIrxa1uemGtCh8zWrStokPGT0Y45uHJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=egMHGgfvldxf4bMKJclD18AVMnMryC1uvsiYBB/gkYpCWB1kF67DZnfeaw4DxsgmlAlxpR53dlbBIJ+fR7j7mmFbD3XytyQQZjwXT4do27kxmN45q8XXQni1sw65oAVbW6eaTWK0S4xfC12EEnlINKm/28wCXodjppsp6CYduDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d8wXO3cU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747245199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aUnk0WRhAxcCT0ZheoJMjtoM7W/SncKt5W00jvqREzU=;
	b=d8wXO3cUMKaNxZetqsHFAMZYXgX3BRS9+ykgy5KzCqmMnc/YtsM8cL9zaM9KxQkbo82xK3
	SvJrgSSaixj9P8mTeR3jeeJXSN0qEUGyaUnYGhlUUPVHBffTPiUaPz5lJaQZdcvDxiTRtO
	a3faHIZrpeemImbrDfMAwQSVWN5K6eY=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-IOROWlxuOACi13S0kGlZNQ-1; Wed, 14 May 2025 13:53:18 -0400
X-MC-Unique: IOROWlxuOACi13S0kGlZNQ-1
X-Mimecast-MFC-AGG-ID: IOROWlxuOACi13S0kGlZNQ_1747245197
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-70a5765b8f0so972677b3.2
        for <linux-pm@vger.kernel.org>; Wed, 14 May 2025 10:53:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747245197; x=1747849997;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUnk0WRhAxcCT0ZheoJMjtoM7W/SncKt5W00jvqREzU=;
        b=jrEL8GQSg7NTq8AevvPQ1hqekB2/FzUXEmcHVrWnOFXG7vieGmWJtFaAw5cdZTkqfE
         NgSM89cJyjLZAnq+9igu8cdUZSXoZbdW1yKOdAjMYZZX+VjbJyuwVC/kfRb9z3qQVEQe
         9tuJ7PV5s15AKWKQrXXbkJRSGA+sLKOsC7vwQ7ZHroDKMqsvr6Kn3Xf5cp3mBhQBeUhE
         EhyrswawVOf+XqWWTvgsN1eVmyDi1FShfTYFLFnDvtdBTOfUK220llDNSrYu0PF11Zgi
         7sQEea0T2H3doYvVItHyQvUhblhZUEhMQATLN0/krNh7WBfOb21t0UfzTGW4i8abz9Tu
         v4sw==
X-Forwarded-Encrypted: i=1; AJvYcCUltTAIWlRxMHZvOlEU+FRagBBngY/e0eVtOvuQT/3re0sYI+d9OkvGQe9w2H4EmM6Vp+reWqrh0w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZtOhj8XD0v5h/o6vXp2+bzR7ykj1i1gDTmP6tQ16R6vz7QnhN
	XWwjsRu9E5AHLPUa8Hd+WcX3tZF+Fm2RwzI6xYkD8dGrL3mf82XMNZPsFiI+kd+D1qqBIfmhiu+
	y+iKB3P5MX0s+wltllHlKAgqLZtfqANuyxXFEg47Mm3H48kObTlU5Xy/Q
X-Gm-Gg: ASbGncvu86RHAXvHmNj+05wB6ExZ11dBlDdWq93ZRnow0etgcuKjZ87zG4HhqgKXWh2
	esFjt8x+JMwyXpx7tKsyA2DVt+uQnbNNWRgnErnNXiTSnZ5cwTxp51jFR+LdGdUDZNs7JdYS5LK
	qf7Fy+Ta98uOeLyWak+uKFc/G5jWoRRRDfAWnClmWNu7OUqPW1ZmYgPqDWNbjEah8GRNILGoYl7
	DoiVVMBb/1stwoHviLoVdYT4YfOMdaALDBFR/2ViW71/1zKa9JVfd8yU9EK1K2I4zWG24MvTjBv
	N/PND/odhQ==
X-Received: by 2002:a05:690c:4802:b0:702:5134:aaac with SMTP id 00721157ae682-70c7f10bd68mr66404107b3.2.1747245197569;
        Wed, 14 May 2025 10:53:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGU1Rd0b1LRP0IekOG2NAI2bFtmuIiomJ96ttuF7KNJuYtnWugYBLkcW9i7AoUwN8EwiOEncA==
X-Received: by 2002:a05:690c:4802:b0:702:5134:aaac with SMTP id 00721157ae682-70c7f10bd68mr66403787b3.2.1747245197241;
        Wed, 14 May 2025 10:53:17 -0700 (PDT)
Received: from thinkpad2024 ([2607:fb90:759c:a8a:a83c:a9c:98f4:e3f7])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-70a3d8e123bsm30180727b3.67.2025.05.14.10.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 10:53:16 -0700 (PDT)
Date: Wed, 14 May 2025 13:53:11 -0400
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: "Francesco Poli (wintermute)" <invernomuto@paranoici.org>,
	linux-pm list <linux-pm@vger.kernel.org>,
	Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v2] cpupower: add a systemd service to run cpupower
Message-ID: <aCTYhzqYFNX6D9Vm@thinkpad2024>
References: <20250425151024.121630-1-invernomuto@paranoici.org>
 <16ad2364-0161-4724-90e1-b57559168843@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16ad2364-0161-4724-90e1-b57559168843@leemhuis.info>

On Wed, May 14, 2025 at 02:41:35PM +0200, Thorsten Leemhuis wrote:
> Hi Francesco! Many thx for addressing the issues I brought up earlier
> which now landed in -next, much appreciated.
> 
> Sadly with those fixes in I noticed another issue I missed earlier. One
> from the "small differences between different Linux distributions that
> make all our lives hard". :-/media/
> 
> On 25.04.25 17:07, Francesco Poli (wintermute) wrote:
> > One of the most typical use cases of the 'cpupower' utility works as
> > follows: run 'cpupower' at boot with the desired command-line options
> > and then forget about it.
> 
> > diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
> > index 835123add0ed..9c2b5f71fee1 100644
> > [...]
> > @@ -302,6 +305,14 @@ install-tools: $(OUTPUT)cpupower
> >  	$(INSTALL_PROGRAM) $(OUTPUT)cpupower $(DESTDIR)${bindir}
> >  	$(INSTALL) -d $(DESTDIR)${bash_completion_dir}
> >  	$(INSTALL_SCRIPT) cpupower-completion.sh '$(DESTDIR)${bash_completion_dir}/cpupower'
> > +	$(INSTALL) -d $(DESTDIR)${confdir}default
> > +	$(INSTALL_DATA) cpupower.default '$(DESTDIR)${confdir}default/cpupower'
> > +	$(INSTALL) -d $(DESTDIR)${libexecdir}
> > +	$(INSTALL_PROGRAM) cpupower.sh '$(DESTDIR)${libexecdir}/cpupower'
> > +	$(INSTALL) -d $(DESTDIR)${libdir}/systemd/system
> 
> That last line to the best of my knowledge is wrong on distributions
> like Fedora, where ${libdir} expands to /usr/lib64/ -- which is the
> right path for libraries, but the wrong one for systemd units, as they
> are always stored in /usr/lib/systemd/system (at least on Fedora). Not
> sure what the right fix it, it might be something like defining
> 
> unitdir ?= /usr/lib/systemd/system
> 
> earlier in the Makefile and then using it in the last quoted line above.
> 
> Ciao, Thorsten
> 

Checked the Arch pkgs and my Ubuntu 22.04 install.

Both of them copy service files to that folder as well. The Debian package
is difficult to read at a glance.

The problem is that Fedora installs libraries to lib64; Arch and Ubuntu
(22.04 & likely Debian) do not from what I can tell. This likely is the
reason for that issue I had-I thought I misconfigured something or it
was a bug in cpupower logic.

That unitdir looks like it would be a good suggestion as a quick fix,
but Shuah, how are you feeling about these patches?

I am on mobile data right now due to an internet issue so my ability to
test is limited right now.

-- 
Sincerely,
John Wyatt
Software Engineer, Core Kernel
Red Hat


