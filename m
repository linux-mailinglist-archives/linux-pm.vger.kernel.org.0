Return-Path: <linux-pm+bounces-14572-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5E297EC41
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 15:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19C861C2117E
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 13:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165821993BB;
	Mon, 23 Sep 2024 13:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gTufOe9T"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763A71990DE
	for <linux-pm@vger.kernel.org>; Mon, 23 Sep 2024 13:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727098148; cv=none; b=ce9gLoJlwZnrLY7RLE2TFExx/3CX17D3v81iO4K0WUOs8nC+ryRE+FN0ZYexrINx6MUtJNv/tXkBZuJoKAzopNTKrwNmgisUSaPPGoIPBwVXMedU3qBjmGkedZj53LLyaECzLKGk/eH55pC8QVUYZliqlc9uYkPqim0zgVGuhVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727098148; c=relaxed/simple;
	bh=msEb1X/nEcnG4bk7IVMn+Wb47RheqIVhxYd4dGOLXqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jiCOeQppDz5P52YNTXJBi1v3LCUG2q0TyiCH56WkWDfZiDsAkd0hO1HHQ1Re6KFP6OPi76x5Fz/WJqdQeeLFz+c0DzyRiyQASIqxyShlPuvTYD+z02XP7M0nqWUOue0nyGKvUu1LTfyD6UQNmPnZmbF67V2+12h3el+RMX35Cjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gTufOe9T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727098145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=20s6lwzO5vISgIlU0MNWzFQNkl/acYGCSCT2Efes/80=;
	b=gTufOe9TtrxJEG7KmYKS+VhvfalUuZARjFdZ4XXH28Pi4Cww9vEtbFSM1EDHLSTvKtfUTo
	LAtQ5zF9ANNUTKXkx0j+445P3GRcCIad7UQYR5uV+Kc16JhGw6lpv3CxN6oI1u7YGlZOh1
	GwOiWK61tSpcDlVkQY4h+2lOOO6uBbk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-ZWOi8O4-MVOiD0TWo0Mw-Q-1; Mon, 23 Sep 2024 09:29:04 -0400
X-MC-Unique: ZWOi8O4-MVOiD0TWo0Mw-Q-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7a9b41d95efso863362285a.2
        for <linux-pm@vger.kernel.org>; Mon, 23 Sep 2024 06:29:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727098143; x=1727702943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20s6lwzO5vISgIlU0MNWzFQNkl/acYGCSCT2Efes/80=;
        b=ECc7RclkBti6HjIjoL0E05bLqlMwi647JtROS4U2dlIFuKMDmzgPFa9bE1qXIr3WHG
         8JmY6uGube4Or4iKeAqdNtvBQHr5Bbyrp8R12cXtStBmWKPA9lQ5K7IhOvAdEHfZyGzY
         /9JL8efQokSY7PkngRXgRmIar4E5AVZE1iVXEtX3nIaOmI0zSe4dViwDw0AlkHzwwoiC
         SgHr7A1VF7+LmtFSI6BCAQp0/wtQ61Fq3nq5JxBH9KIt0OQW2swqPJkvzJIyVo01wZyf
         sUHuo76SSN00Jbi7raDyyq6tbjU0AMK0zf/dvaNzXL1L4tRMLzkRKzlLCeJuyjxGCcBH
         4o8A==
X-Forwarded-Encrypted: i=1; AJvYcCWqZwGY+re2OwOo65QGZzYaUsjVd5VvppDFsUZMt9KHXeB89Ma+EzlSK6mp/aLdPTb3NVS5aTNtvg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0jSgCh4BGCi7z+pdFQf2yqfuBJy/MfUHBJruKURCA4PZgbu2I
	4YhKlaDEalksj7HWoUnqhKkoBQY32q4Ybkk1jdRTUb60yJQb5msJubXN3gA0bZZ2ZoaXUXcgHw9
	YYCZJFRps5TSomGtAXWHZ5ZuNe/63ce1w/2yajit86wgs5yIZ9wKFba1B
X-Received: by 2002:a05:620a:3712:b0:79f:932:86e3 with SMTP id af79cd13be357-7acb80aacecmr1706616085a.19.1727098143615;
        Mon, 23 Sep 2024 06:29:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFproagSsXayd2M9HgYrmHoDPKeKrL4pq64vG6McfTTSNTepO4s2SGJNiff5R+iIxsC799C0A==
X-Received: by 2002:a05:620a:3712:b0:79f:932:86e3 with SMTP id af79cd13be357-7acb80aacecmr1706614185a.19.1727098143204;
        Mon, 23 Sep 2024 06:29:03 -0700 (PDT)
Received: from rhfedora ([71.217.60.247])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7acb08c13c4sm482204485a.98.2024.09.23.06.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 06:29:02 -0700 (PDT)
Date: Mon, 23 Sep 2024 09:29:00 -0400
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Shuah Khan <skhan@linuxfoundation.org>, linux-pm@vger.kernel.org,
	Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, John Kacur <jkacur@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>, Arnaldo Melo <acme@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: Re: [PATCH v3 2/4] pm:cpupower: Add SWIG bindings files for
 libcpupower
Message-ID: <ZvFtHM5465aOYX24@rhfedora>
References: <20240905021916.15938-1-jwyatt@redhat.com>
 <20240905021916.15938-3-jwyatt@redhat.com>
 <0ff4937d-0e51-4d67-9b8a-d2bf1bebe1fb@roeck-us.net>
 <CAHk-=wjVpftmPF3SopywFgQ+uzgdScTPWTxmq7HwinVqwbue3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjVpftmPF3SopywFgQ+uzgdScTPWTxmq7HwinVqwbue3w@mail.gmail.com>

On Sun, Sep 22, 2024 at 08:39:28AM -0700, Linus Torvalds wrote:
> On Sat, 21 Sept 2024 at 14:23, Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On Wed, Sep 04, 2024 at 10:19:09PM -0400, John B. Wyatt IV wrote:
> > >
> > >  .../bindings/python/raw_pylibcpupower.i       | 247 ++++++++++++++++++
> >
> > This file is deleted when running "make mrproper".
> 
> Yes, please don't create files called '*.i", "*.s" or "*.o".  We
> assume they are generated files (the result of the preprocessor, the
> compiler, and the assembler respectively).
> 
> And yeah, obviously "*.i" and "*.s" and not _usually_ seen, because
> they are only steps on the way to "*.o", so maybe they aren't _quite_
> as obvious as some "*.o" file would be, but they are very much
> standard naming, and we have build rules for them (ie "make
> kernel/exit.i" will create the pre-processed result of exit.c).
> 

My apologies. This was reported and fixed with this patch by renaming
the file to '.swg'. '.swg' is the second filename extension used by
SWIG.

https://lore.kernel.org/linux-pm/20240913201705.7764-1-minhuadotchen@gmail.com/

-- 
Sincerely,
John Wyatt
Software Engineer, Core Kernel
Red Hat


