Return-Path: <linux-pm+bounces-27813-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01304AC806C
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 17:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 333129E57C5
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 15:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B392253BD;
	Thu, 29 May 2025 15:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFff80ln"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF89317CA17;
	Thu, 29 May 2025 15:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748533157; cv=none; b=ltEJnafrTToYOdgVYsE50o467JRgfFCSceI6LJsarwzrlihBJRHoTz31ky+0GxiQF8gwAJsiKNElAVsV39lDB7N/AV/73E4wGa8gXqwNlInEoS5V2R/mcVi/bd/B8XVJzUsd8aqZW4zAtgyNiBCR88a7nIPn4yJtQzUbxOE49/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748533157; c=relaxed/simple;
	bh=UbBEkDTqfCnw2EjxfZQ84gGilGk3fYxKQMJvf8QLxcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ld1RHR13xGf/n3eEOXC27OxmTpAJm+6Qwe19Q7nkSGBBN7gBcOmRTRyi1osvifWrO4Y3JqWNjygbTMp29l8oy9GxkSq3xWZZyEGTsOYxX6bCsswwqB/YE0SJ+l8V8xejIwAqkWwP0YRSxyJP7WTcIkcGJSLrVAPbKIvbELNtSsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFff80ln; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D02AC4CEF4;
	Thu, 29 May 2025 15:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748533157;
	bh=UbBEkDTqfCnw2EjxfZQ84gGilGk3fYxKQMJvf8QLxcE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mFff80lnzxHR7RS0Hc3pkb4fH6tyID2OeIHENae9Um5YWSDz/XEyQBnWVi6DD+hAh
	 3xqZZeqrkyvnB2jHkCdA0hfyPatFrupCM7szi+xKNTiMltW01GOP526jmTx2EGQG9o
	 R+O983chHHNusx5VIo4uq2HG2vCQjn8GGdMmwHntYNHw4qM3lPj5g1dAXjmhQvdpTc
	 wnrAhbGXBuVdN6tYI1moTr1mIsZW035tjZBmgDpfFbL65ObMzGrr4nZ10l+4xvGjoh
	 0tVZbSv+Xtz+wWND4dxuyGW6ZFF7qWuhM4HEx8UqHLQ8GvGm5SFqOuEgPR65jKmLig
	 gKC6V4Lhver6Q==
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3f6aa4b3a7fso332860b6e.3;
        Thu, 29 May 2025 08:39:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVA4EbCK9a1zP6MHWb7Fyom9VSwI3pyfLZ95131Gj19VoPDDX1wMyay7bMrq0WEqd4z2d/z+DwsYJE=@vger.kernel.org, AJvYcCXPr2J5oY/BoccQ08h2/Vo6xaAyc6g/GYa1slZAuHkch0o64w2OrIvSYt/SIYRJjq2as5VLzAWNK0gwg1o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw8Xprxu5fdn178aTtdna4RDyYFd5CUmlTU6xhMB6wYIxQIiwH
	SHnI4wspzVEhiJNzVbvvJnlvfjZ7/wwNbUeiOLA9LmpfYUrBcc50uhU52EkTH4jnnLkO1B5clqJ
	P0ehcme07Z+jzmUgvWBhzfYAGx/3ifEs=
X-Google-Smtp-Source: AGHT+IG4F1W+PV4zM3LJSstsPJcaGOnwY+4l7KCJA7VYQOchRNIEJJqiRTIZpcHM+LzTr6Bck5mQO3YsBwoAFF0hrd4=
X-Received: by 2002:a05:6808:3383:b0:3f4:222f:da5e with SMTP id
 5614622812f47-406707ad56emr1240419b6e.23.1748533156557; Thu, 29 May 2025
 08:39:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2006806.PYKUYFuaPT@rjwysocki.net> <12674167.O9o76ZdvQC@rjwysocki.net>
 <a72c38b2-c52f-446a-bf0f-2bae7d6021f8@intel.com>
In-Reply-To: <a72c38b2-c52f-446a-bf0f-2bae7d6021f8@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 29 May 2025 17:39:05 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gbk33DutXy_F=teCqD28jn_Ob8unfpKZoaPzqkNzwHMQ@mail.gmail.com>
X-Gm-Features: AX0GCFv5ajOaun-_pCkfkruCRRnIZTLoF7qAe37EjMsjTpMa39Ns22D_Qa-Stgk
Message-ID: <CAJZ5v0gbk33DutXy_F=teCqD28jn_Ob8unfpKZoaPzqkNzwHMQ@mail.gmail.com>
Subject: Re: [PATCH v2] Revert "x86/smp: Eliminate mwait_play_dead_cpuid_hint()"
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, x86 Maintainers <x86@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Len Brown <lenb@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Ingo Molnar <mingo@redhat.com>, 
	Todd Brandt <todd.e.brandt@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 29, 2025 at 4:25=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 5/29/25 06:40, Rafael J. Wysocki wrote:
> > This issue is hard to debug and potentially dangerous, so it needs to
> > be addressed as soon as possible in a way that will work for 6.15.y,
> > hence the revert.
>
> Ugh.
>
> I don't like the idea of reintroducing known buggy code. But the revert
> does seem like the lesser of the two evils.
>
> Seems like we should revert this for the time being and then try to fix
> it properly again.
>
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>

Thanks!

Applied.

