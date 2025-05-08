Return-Path: <linux-pm+bounces-26898-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AEB3AB0057
	for <lists+linux-pm@lfdr.de>; Thu,  8 May 2025 18:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 017C77A684C
	for <lists+linux-pm@lfdr.de>; Thu,  8 May 2025 16:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F544280A5E;
	Thu,  8 May 2025 16:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mf8+PqQV"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9846526FD88
	for <linux-pm@vger.kernel.org>; Thu,  8 May 2025 16:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746721403; cv=none; b=c41LmfPyDWo7aSOAiGCctRIyAEJRjSBmzx/tz9xxlV/wrlPt7zj9+uQFDlJ2Fy02s9SuWj0Fns7GLlaHd9FfIah8pjuUjCCHLtDMxq9SOAYFs8mUQuSM42UfCFD9aLozHw+uIRexF7FwOIOKe7uHFI87kM1HSt9wcYHyh3ro/ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746721403; c=relaxed/simple;
	bh=Bxi3jK7hjkP+UIRNZ1hN9gUVnl0yDp7q1TkT41ugEhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rNtYiq5a8j8NcvfLFUvqjA1nccPyza3fwK7r1vaCt213ldW6Ilf854epnrbFkmEFruqhCafg0dg1Sj8CndlQivvJgji/53jZFXZcmQFwQZVU/kmHNHDi+obVk1lfg25nqFPU1fxF+oy6Mu+823ij5KjVbGnWa50Gt9OtdtlLEoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mf8+PqQV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746721400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wJX4DMTSZqe1XJz7zQgtAPGngWPUrdqF5xo7achpeek=;
	b=Mf8+PqQVZHH5FdS02JCcG51Pk6ZAzuyRZyUG5b2VYha26H4t3FEd9js/2Bl6iR4ZMP8uzr
	5zlaAFfUwrf4V4s6Ae9Oso3hz6yrJOiCjXH8BCupktodfKd1p1easWhCiHQrVl/PcQa0NX
	N89n+W/3ifM6hwkw/WO0khzpW8RHoRA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-IjTU0-WTMqC9cOST2__XOg-1; Thu, 08 May 2025 12:23:19 -0400
X-MC-Unique: IjTU0-WTMqC9cOST2__XOg-1
X-Mimecast-MFC-AGG-ID: IjTU0-WTMqC9cOST2__XOg_1746721399
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c5d608e6f5so282552585a.0
        for <linux-pm@vger.kernel.org>; Thu, 08 May 2025 09:23:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746721398; x=1747326198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wJX4DMTSZqe1XJz7zQgtAPGngWPUrdqF5xo7achpeek=;
        b=h7o+t2MZzkL9heg0Vn7daJ3PH5TnjGjLSJFO8bKHtCTDztRkw5GcN82cs+HQ7cDDzX
         O/NVWXfIPPT9B004b06GW4xFFI7SzrMe36xBBLGIymA20xeUPzUPn3PS/G1fFGx6KcOE
         M3WUCVNK6eupPbhsieeym3v/vj7VpoKmcJxekPnnZQKwzwxrXbtBTB8jS/0seNsD1TSO
         1e+ycTfikP7qEERAZ8eknwcmcZx/DX07vj9tnxNhpDGmfUNbFWDOTww+Vkd61YOwdVpN
         jZ14sZF+kJLBwX9FBVfkdhEjf0DF3FQOABV7TXLuR6PB4HnuJrqFjDW1Js7TVlqgq0W9
         /XQA==
X-Forwarded-Encrypted: i=1; AJvYcCVunUw7yaZf0ntG+FZsOpT5COPjrfDGVK8Ap/8jk9R3pjsvGLyUzt7WiSAK9ZO1bB0cZwFAC/0ZPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgzq+wm8F/IBxSjXTEy0Sra7pXw/lnCIwlGpgdpZtKUbBifo6H
	tMfrRlPCf+a69ARFNx7LerAIlyqx0+4Robu8zmMgyGm+SxBb2ThHLRYQ13ex2mD9nDgeyW1uyak
	2tdpVlRVLyscbTSPE9GxjO6y3hrfwBxSinS5AmrB4eQ5BG9su4qqB1zBQOmYnthDVL7s=
X-Gm-Gg: ASbGncvRO1wtEXQAciwyQg+wmhRNXH8qbEiycdp087YR8v90iA0BPzxqXI+ELd+frz2
	T3oxmeH53QStn9lVOPdLGYtx74gLCo/SlahD5/rSOtpmMUkmJzve/o3Cwe6yDCsWg75m6kW089c
	rSUHaDbINdER/z0vUZAGU6pYG8582KvUxaYX5i8FsKfZjC7kbS4e82wTp580aBqe0CAvcnZ4j7q
	mgojscDDUoYVNGGtCh1H3OTSrcMDKMzsTvZRFgpCfxhtFT4EhDOkUpgF3lYa+dhUEE5Nwmb0ubn
	Cq9kRf/I
X-Received: by 2002:ac8:7f45:0:b0:476:74de:81e2 with SMTP id d75a77b69052e-4922786613amr119301761cf.43.1746721387351;
        Thu, 08 May 2025 09:23:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZUvAevPpesan+hnIM3V1iwmsa595S7pWlmOKoS5fbhEOSwBSPKWL5ZUmE4ZsfX/7+ftGXPg==
X-Received: by 2002:a05:620a:4713:b0:7c7:827b:46bf with SMTP id af79cd13be357-7cd01157860mr39652585a.39.1746721376066;
        Thu, 08 May 2025 09:22:56 -0700 (PDT)
Received: from thinkpad2024 ([71.217.63.131])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4945259bd7bsm112291cf.65.2025.05.08.09.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 09:22:55 -0700 (PDT)
Date: Thu, 8 May 2025 12:22:54 -0400
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Francesco Poli <invernomuto@paranoici.org>
Cc: Thorsten Leemhuis <linux@leemhuis.info>,
	linux-pm list <linux-pm@vger.kernel.org>,
	Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v2] cpupower: add a systemd service to run cpupower
Message-ID: <aBzaXqz4TQkHxJjV@thinkpad2024>
References: <20250425151024.121630-1-invernomuto@paranoici.org>
 <b36a5385-dea0-48bc-8555-e073f62cb6dc@leemhuis.info>
 <20250508001857.ef90d07f43868b2b12c2f432@paranoici.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508001857.ef90d07f43868b2b12c2f432@paranoici.org>

On Thu, May 08, 2025 at 12:18:57AM +0200, Francesco Poli wrote:
> On Wed, 7 May 2025 10:07:33 +0200 Thorsten Leemhuis wrote:
> > /etc/default/ is to the best of my knowledge (everyone: please correct
> > me if I'm wrong!) a Debianism and on rarely used (or maybe not at all,
> > not sure) in distros unrelated to Debian.
> 
> I thought that /etc/default was used in other distros, as well, not
> only on Debian-derivatives...
> 
> For instance on [RedHat] Enterprise Linux and (consequently) on [Rocky]
> Linux for [GRUB], for [useradd], and so forth...
> 
> [RedHat]: <https://access.redhat.com/solutions/3185891>
> [GRUB]: <https://docs.rockylinux.org/books/admin_guide/10-boot/#the-grub2-bootloader>
> [useradd]: <https://docs.rockylinux.org/books/admin_guide/06-users/#default-value-for-user-creation>
> 
> What do others think?

You are correct about it not being Debian family specific.

My Fedora install has the following: google-chrome  grub  pcscd  useradd

Citing RHEL 7 or a clone of RHEL 8 is outdated information fyi. RHEL will
usually follow it's upstream, which is Fedora.

> 
> > So I'd say it's a bad choice
> > to place that file. Why not put it simply straight into /etc/ ?
> 
> Because /etc/cpupower.conf makes me think it's a configuration file for
> cpupower, rather than for the cpupower.service that runs cpupower at
> boot.

Despite reviewing it, in retrospect, it makes me think the name of the
file should be different instead; perhaps cpupower-service.conf ?

Trying not to do bike shedding [1] for you as a new contributor, but
I do feel changing the filename would make it much more clear at a
glance, especially if it is moved to /etc.

[1] https://en.wikipedia.org/wiki/Law_of_triviality

If packagers would like to keep /etc/default clean I do not see a reason
not to. Not sure where else it would go besides /etc or /etc/cpupower; 
/etc/systemd/system seems specific for systemd unit files.

> 
> > Side node: the config file is also basically a template, which makes me
> > wonder if it should land in /usr/share/doc or something like that anyway
> > so users take a look at adjust it to their needs. But it's just a
> > thought, I have no strong opinions with regards to this.

> Well, I would prefer to have a configuration file in the right
> location, ready to be edited by the sysadmin.

Agreed. Also, that seems to be for readonly info and this file is
intended to be modified to have any effect. Plenty of programs place a
default configuration file in /etc or a subdirectory.

-- 
Sincerely,
John Wyatt
Software Engineer, Core Kernel
Red Hat


