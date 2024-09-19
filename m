Return-Path: <linux-pm+bounces-14498-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF05D97CE93
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 22:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4F741C21763
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 20:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B9F47F53;
	Thu, 19 Sep 2024 20:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="YrpklKGm"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9CA33981;
	Thu, 19 Sep 2024 20:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726778747; cv=none; b=VKWQDet2+kP+lhcJWBYO+sAillfgSrShx3Q3m0XeZ9HHie0K3Q6ZF/QDn5LjsmnMETQPx/iIPx/cre0RYXShZ9dciBJKJP3dtpSx8Q1MtVyyB3xs7sJbPpnnkPUho0tJnLVKvXSvbjFiyWWJZwQEND513jtQnuF8H/rGkLojLmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726778747; c=relaxed/simple;
	bh=rWoB8DDniZC9CMXjj6dzyRo5ohuieFd6GdzDcQSjb/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ESCK4y6PBrm+iHXQ0mNdPoj96+DiE1DTnIJWtGtJ7kSTzOPqBxdD/njI5nWqqtT6Yu80aACLPUXScQ2Ms6Hl80NJDZAs5x3R77qBWdhskkdc38xMDzwdiHwqFWBTb1MNpJN99ueoh/zfG4GJb/YwQpbgLJiplWSxApyDTXmb1Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=YrpklKGm; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 8DBC02E0A7FC;
	Thu, 19 Sep 2024 23:45:41 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1726778742;
	bh=ssneGvK5ZccGXDivXilQWKNzuFqfS8ixT1Ke3QJlDUM=;
	h=Received:From:Subject:To;
	b=YrpklKGmavjaYNYC1M0CD+Nj6tIXR1VwAJpxMpmKQ+siQoAkBrOpye2hJdo9CV3pq
	 fgXWo0SgipSYHPZI4mZyOhrSkZAWePbr04aVV5nY8VbVLn0c6/8dXLz21ZeGQU0kwy
	 NsDNGbOBz0R6VG4MZvI0/fyl5MjmCj0lhBUOBb/A=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.182) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f182.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f182.google.com with SMTP id
 38308e7fff4ca-2f75c0b78fbso14138841fa.1;
        Thu, 19 Sep 2024 13:45:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCVqTywV69TtE59VF9N14gh6mQJI3yO9UbSXWQi/dNmYPqLRCps20e+p0kAmgRfTtBv+DLH0unactOiM0s35UWKg53H3@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6pmG7+Bci+/A3Xkam8WPGBqwtjPjOTIX/fwKLUFnqq+KcMkQj
	rxvArC9hgxh4RS5eZZB1jKPYVHDVoHay7QbyMbmdMAuypG+wae0XeS2+Zr35OAf1MHKtY9UtFNv
	LJzq4t13iPoNcXy5zLKiDPwi077k=
X-Google-Smtp-Source: 
 AGHT+IEVGMy+brV+GgObTMr987bMLu5LxYQ9BfzH82vhpCVku2NEyAnw6+ARByaqWQs+BVHX1yOntQo5DvVzDioonKo=
X-Received: by 2002:a05:651c:1505:b0:2f7:6653:8046 with SMTP id
 38308e7fff4ca-2f7cb335d0amr4299401fa.25.1726778740929; Thu, 19 Sep 2024
 13:45:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240919171952.403745-1-lkml@antheas.dev>
 <20240919171952.403745-4-lkml@antheas.dev>
 <7c604018-59a3-4b70-83d1-06f0ed858b73@amd.com>
In-Reply-To: <7c604018-59a3-4b70-83d1-06f0ed858b73@amd.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Thu, 19 Sep 2024 22:45:29 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwGSVAExH_9zCCKreC88J0FRU4ZM3RkBk==HvRwCUuuqLw@mail.gmail.com>
Message-ID: 
 <CAGwozwGSVAExH_9zCCKreC88J0FRU4ZM3RkBk==HvRwCUuuqLw@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] acpi/x86: s2idle: call screen on and off as part
 of callbacks
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	luke@ljones.dev, me@kylegospodneti.ch
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <172677874193.1878.8609647443931084995@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

> It seems like it would mostly be a programmer error if it was called twice.
>
> How about something like this:
>
> if (unlikely(WARN_ON(lsp0_dsm_in_screen_off)))
>         return -EINVAL;
>
> You could do something similar with the inverse in the other call site
> too then.

Indeed, under normal operation calling it twice is an error.

2 concerns here: if I make this change just here, the code on patch 2
will make the suspend sequence bail. Is this a desired outcome?

Shouldn't we just keep going? And if we should keep going, does that
include calling Display Off twice?

I am inclined to say the desired outcome is to not call Display Off
twice and to keep the suspend sequence going. In which case, I will
merge your suggestion and remove the bail sequence from patch 2.

2nd concern is that I suspect it is very likely firmware vendors will
want to call this sequence as part of developing devices, so I am
inclined to allow calling the functions back to back. However, that
could be achieved differently, e.g., with a module flag.

> > +     lsp0_dsm_in_screen_off = false;
>
> Doesn't it initialize to false already?  Is this really needed?

More for my peace of mind. I will remove it.

Antheas

