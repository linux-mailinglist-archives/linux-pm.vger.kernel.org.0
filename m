Return-Path: <linux-pm+bounces-28771-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F182ADA6F4
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 05:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85C49189091B
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 03:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C0314F104;
	Mon, 16 Jun 2025 03:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="F8OPrjJ1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8055D5103F
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 03:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750045655; cv=none; b=Ii3/tdDKX2kLTA4xvPQBp4grM3hUlIHeuB5u1I09bly28Cf8OaecTnc/qzduUzEjW1UQ1AfZ13zEb8gwtVRSVAUOFNJZOHwxGT2viu4/pY8I8369Hy6Aj+60eEInfDiVID5Q3P/orTnBxU0JifmKrEEWyctM8PNUiKSqceaLqu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750045655; c=relaxed/simple;
	bh=oAPyorFVGnQcUaYRbcaf+X+aO7UokUBQs9yAd751ZT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZl1kwL43EW0u+8cCP3hPNlmElB+C4HImbLOaRIqf0jtmYfdn5SEtI+66fGhpQHYdt/9LJZQrfBt7TKEjw+3oagFbtiqPmmINKkoaLE/93h+nkuh9PjKung0XXosXGIW0uSRHrIreCPn3t3e0Frmkm2MGVANb6EDGFTQxPOXFrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=F8OPrjJ1; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2350b1b9129so27188535ad.0
        for <linux-pm@vger.kernel.org>; Sun, 15 Jun 2025 20:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1750045652; x=1750650452; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yvQ7KncdCkryYhQ6UYHiV8AcfEt99sLfw37M+fTpmcE=;
        b=F8OPrjJ1S1whsTxc8AIpcvsQAkiuo/RBI80JpibZygVyJ4QQPV8gG2YzJI8wUce3CA
         zQTCIoB2fE281IB6oFh8NQ5uTsLfowtGWGy3motGTDqkLWp/KEKhrP5D1KpxFf+BFVnE
         pJpKdLF6ibivU33NTckd+61XeSsvyni7lFKtDJIa6JHd+3TjgjnnfLStaykPy9Spr9oO
         OvW6DI56v5aCAkG1m10IbE/V/b58XbclToHnW5xFffarJrftLrSbKmlJOWu/WcMZh9Ca
         kQmCJbkx0yVzSynOp0dMV5xVONGJcmRgAdp9Hp83++CqnWppRcpSclh8ew/PPOVE/Tvr
         I0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750045652; x=1750650452;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yvQ7KncdCkryYhQ6UYHiV8AcfEt99sLfw37M+fTpmcE=;
        b=wI+qVsPKdXKCxjKfskmu3DKn3ZW0vRL2xFk8qcAwl4YJOjKvQAJUxy2FnJfzZuPScl
         ELU0JL1bgyjfDWDP2fTQl6nH8B1cq62k7QBeFCu7iER1ZGoEq1AOyngoxV/2w5zLGrI+
         iWur3fuZ4I5DR1M693tlDrJQyZUcmMG1E8CXnom3LkRMRGyDwaF/54WCA5hed2mK1Gf+
         N0uMWG3VuoFBZvV1alZ/Uy57WbvYn8KZZqizZWZCsZA5vhjl/f8oLl8Hi3zuOFrZy822
         wN7vsWVXicDwD7vnzUUkNUmjqpnCttwJ+M8UvTTl33H8S7aWmIPr9JPMOb/zanbjMqJz
         +4gg==
X-Forwarded-Encrypted: i=1; AJvYcCUXOIG1Y2NK2ZtMBXNQ2nMYSr5PaTQCfIQsPYyHZEONegjfV826+QhmMrPYCq5DNUBUb+6BNnRgUw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzkKwog1e16tVOIFZGY8Wy8j3W89qDpszl34qf9W4dIzykleBeu
	jQwuBFFzBQe/3YLeD5G6F3THHJPyIY3EcmyH/NOmno+Bt1KsWsKovRR40wfq9B8K1zg=
X-Gm-Gg: ASbGncv8+e8n/ERjxB5Cwcks4yR3KFD+vWFfPQVyZeI+yA1+tOJfolMQ9CSCByy0PJf
	t/DI4vgQjqz4z7krkSSy2HEn5IZVLYwIoX9lkfO3XF1SvAZOT+OxUqJQFfQOBWZh4INME0AlzuY
	7tljSonoZ8JQCIo1PxJxbB5/TPKoPc3lDXJ+yi4M0eOAY+IsZvbNINM0aO0PuPVcP6wlVfvwJlf
	j2xzIyPgqq5mkU1PFclR1+x8ZSW1wLMHjCqK1qkzwL/RFouY3z1dxvPTGWKUeSU0W0/v4ebaRpV
	DaGrygR+EnkdMbLACro+WtpEnc17wWlyWfsAllX4TpxS5/lHTU0dzvAcA5710NjyJSdqmWFO1+e
	tY32Rxa587AAfh4QSbsN5wAnFc9u/ZYc=
X-Google-Smtp-Source: AGHT+IHYu/FwcX7YLaKOx5VReMxqHPp8iD/ta3wBGnoP/HCC6DuKvKSDmh33M+/gwPrD4abjPDdP9Q==
X-Received: by 2002:a17:902:e747:b0:234:d292:be8f with SMTP id d9443c01a7336-2366b32e55bmr121483435ad.1.1750045652463;
        Sun, 15 Jun 2025 20:47:32 -0700 (PDT)
Received: from mozart.vkv.me (192-184-162-253.fiber.dynamic.sonic.net. [192.184.162.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365dea8ff7sm51388655ad.171.2025.06.15.20.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 20:47:31 -0700 (PDT)
Date: Sun, 15 Jun 2025 20:47:29 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: "dedekind1@gmail.com" <dedekind1@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>
Subject: Re: [PATCH] tools/power turbostat: Fix build with musl
Message-ID: <aE-T0cZsdoCZOD_Y@mozart.vkv.me>
References: <7edd4c688111a697cfe913c73d074738b3d1dffb.1749833196.git.calvin@wbinvd.org>
 <17f85f0bfa5446b86188616349b17d02fe207c22.camel@gmail.com>
 <7325c49d7d2c407f7391ed30e3a7e0c8898bf5cb.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7325c49d7d2c407f7391ed30e3a7e0c8898bf5cb.camel@intel.com>

On Monday 06/16 at 01:31 +0000, Zhang, Rui wrote:
> On Fri, 2025-06-13 at 20:45 +0300, Artem Bityutskiy wrote:
> > On Fri, 2025-06-13 at 09:54 -0700, Calvin Owens wrote:
> > >     turbostat.c: In function 'parse_int_file':
> > >     turbostat.c:5567:19: error: 'PATH_MAX' undeclared (first use in
> > > this function)
> > >      5567 |         char path[PATH_MAX];
> > >           |                   ^~~~~~~~
> > > 
> > >     turbostat.c: In function 'probe_graphics':
> > >     turbostat.c:6787:19: error: 'PATH_MAX' undeclared (first use in
> > > this function)
> > >      6787 |         char path[PATH_MAX];
> > >           |                   ^~~~~~~~
> > > 
> > > Signed-off-by: Calvin Owens <calvin@wbinvd.org>
> > Reviewed-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> > 
> May I know how to reproduce this?

Hi Rui,

Just build turbostat with musl as libc, here's a quick chroot repro that
works on my Debian laptop:

    wget https://gentoo.osuosl.org/releases/amd64/autobuilds/current-stage3-amd64-musl/stage3-amd64-musl-20250601T163943Z.tar.xz
    mkdir tmp
    sudo tar xf stage3-amd64-musl-20250601T163943Z.tar.xz -C ./tmp
    wget https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.15.2.tar.xz
    sudo mv linux-6.15.2.tar.xz tmp
    sudo chroot tmp /bin/bash
    gentoo / # tar xf linux-6.15.2.tar.xz
    gentoo / # cd linux-6.15.2/tools/power/x86/turbostat/
    gentoo /linux-6.15.2/tools/power/x86/turbostat # make
    gcc -O2 -Wall -Wextra -I../../../include -DMSRHEADER='"../../../../arch/x86/include/asm/msr-index.h"' -DINTEL_FAMILY_HEADER='"../../../../arch/x86/include/asm/intel-family.h"' -DBUILD_BUG_HEADER='"../../../../include/linux/build_bug.h"' -D_FILE_OFFSET_BITS=64 -D_FORTIFY_SOURCE=2 turbostat.c -o /root/linux-6.15.2/tools/power/x86/turbostat/turbostat  -lcap -lrt
    turbostat.c: In function 'parse_int_file':
    turbostat.c:5567:19: error: 'PATH_MAX' undeclared (first use in this function)
     5567 |         char path[PATH_MAX];
          |                   ^~~~~~~~
    turbostat.c:5567:19: note: each undeclared identifier is reported only once for each function it appears in
    turbostat.c:5567:14: warning: unused variable 'path' [-Wunused-variable]
     5567 |         char path[PATH_MAX];
          |              ^~~~
    turbostat.c: In function 'probe_graphics':
    turbostat.c:6787:19: error: 'PATH_MAX' undeclared (first use in this function)
     6787 |         char path[PATH_MAX];
          |                   ^~~~~~~~
    turbostat.c:6787:14: warning: unused variable 'path' [-Wunused-variable]
     6787 |         char path[PATH_MAX];
          |              ^~~~
    make: *** [Makefile:23: turbostat] Error 1

Thanks,
Calvin

