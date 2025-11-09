Return-Path: <linux-pm+bounces-37677-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4ACEC4384A
	for <lists+linux-pm@lfdr.de>; Sun, 09 Nov 2025 05:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60DA03AF7C9
	for <lists+linux-pm@lfdr.de>; Sun,  9 Nov 2025 04:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BA120013A;
	Sun,  9 Nov 2025 04:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+xddn9q"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013261ACEDE
	for <linux-pm@vger.kernel.org>; Sun,  9 Nov 2025 04:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762661094; cv=none; b=E2uNxoWEOlYkmztpFSU6TbMTqBlzkuSv7wjxKaIFM/5ckpZ02jHJvVGDgwbN21Yf4F8GeCGR2RmyThMCcViOKtiTz6M/5ZosKjTRqn2auDqIvETee0xrPwSv26SHb4EkdO3th/ccCnRDYTmEjfs5M5Fe4vLm5hP+xJ4AnS4GQ9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762661094; c=relaxed/simple;
	bh=vy7e0Uz1+HoY2uFB4YSEuZK75o24i9fXUAPPGgAPgzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ovc+lcs7oXPQPnM56xI/9fNfJXsvg4VHipvuMt69IrU6dywtpQnFRQlciCelN5aVQGzGMrbl0o7iD/D58UbYYFCnuWMYfoXXcbSbHsQH70RTsFT7jl1AcSukdkI8v4kkp6ieBFICPhxW4L6v9iFMB/OnoysRYdnfAt1rFyk+p7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+xddn9q; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-295247a814bso25467835ad.0
        for <linux-pm@vger.kernel.org>; Sat, 08 Nov 2025 20:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762661092; x=1763265892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hv9xrZ2yv0nmyGUfiS3/1XZ0Dl71alHT6BglkhqZupw=;
        b=R+xddn9qEX31BHz7cYv01PqV8p25v0QuFsKYxA0C/IQm1XwW7VYxjTb7UlZbTDq3OJ
         jQfTPnjxez/77WZHDQa5r1B1qNsKIOGCwWDevipLCgh17SJ7hYkDK3LtMgjMx+Nv4dPm
         1dXPGRRe2GD+ttMo6PaOcurqjk4tWG6F5sma5iYgFoWTRKf4/mu9WP3mH9YqUCyaJ3ch
         CuxcuUldhHqzd74+mzyODlhoXrm4q3OjvabdigHJj87ILWZckp5/9Vx3CEjSffef2324
         LOAY80tC8ICiyC0GxI3gxlOuBq4VdaFAppeLmKC6gmOMqNGO31DUOF+cPzk8jJ4JqJvq
         Cu4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762661092; x=1763265892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hv9xrZ2yv0nmyGUfiS3/1XZ0Dl71alHT6BglkhqZupw=;
        b=Q1S5+jbJDvVeP9M/GXpVm3cHErRT4Nu+MxEsW0a19btbl3ineE5z/Jnn9Z9QVE+hSW
         oqm4HjmPT0/PCnoR73ZmKUytNo0Z8L2pxeFSlnzuRrzWvzdA+shcOmugUNoGUA8iVg+9
         ADyplbkb3TpxVUNNIP6Tg5/5vrtq0KI24BsdGcxOXLFsEQbo8LGXGe1E32C+h2QTF5XE
         ticU0BWXXLncwfYipRGe6ySeypbfwyDAVh1ehSIXnVDYvSq9FTdoig8hFIXYZfNNX+UE
         NWA1kh3/oG0KFGHDNz/J/JZQvNt4v6AoBgJQ3FDVrZOVAd5FXPEyPVvx/uxdu1Z7rJnS
         VazQ==
X-Forwarded-Encrypted: i=1; AJvYcCVR6c6wqRuGi9vJdMLsTk5dMxxtQng0Tt0nthy76vig5dGoSH2KKIpPv9aiWyGQDTWtgVH9ekQxhw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKgU1Ee7HJ5hF4MzdJJx5zRPn4md/95bVBKP7nzZNSoAF/6HQF
	HIq5rbwnNOqODOjF2Qlv3vGGzxzp1edOlSN3oairGSRWMMyC5OpcoR0KGV9DtTmXIBETRZhCjMK
	2Dk4cS3CyaTlW/8MLwjy9mwJ0dKPBxuqTcnP+pc4=
X-Gm-Gg: ASbGncskazcCnyVmD65HQ9ScCeavjw6UwBOdHBXDsn8+dR0LVoDj7Vt9bG48F8UfBQ0
	izXj6QTKekGzqEDi2aolyIwvkCixZH1o+2AFKZ0wTggNcw/QY+NHd9rK1desVFDUq12J/mly0Yk
	HX0L06mJIrufGHKJ6SZpyHPoJzZtaqeG/h3ohZImF8eOshyCAHiX33TTHrdaBPifBMmUfvciTL2
	J+9JCPWhXDODRlHVwqMWI4Yg6fQ8KADepNF+JIqEmm1w9mZdviyXLnntXxsvp5G4O7EoSemb7B0
	5I7oZAvIQ74Pi9j5u7UYa56Dw626RIiPJq0b6r60RSqp0+0eovbARvUa
X-Google-Smtp-Source: AGHT+IEcGZVVTcMhYTPoqkW+BIztOhsUvcA0pcYzLEUPTNs1B9rap7L/jCYqurq1olrU2M+Ac1pBzPS7A+rk7X+tkU4=
X-Received: by 2002:a17:902:ec8d:b0:295:586d:677f with SMTP id
 d9443c01a7336-297e540d259mr55218165ad.10.1762661092036; Sat, 08 Nov 2025
 20:04:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107074145.2340-1-gautham.shenoy@amd.com> <CAJZ5v0jS_uNRz=3ZQQLsChf2V3UUvhf6BZ+MBL0WMv+rcW4H6w@mail.gmail.com>
In-Reply-To: <CAJZ5v0jS_uNRz=3ZQQLsChf2V3UUvhf6BZ+MBL0WMv+rcW4H6w@mail.gmail.com>
From: Chris Harris <chris.harris79@gmail.com>
Date: Sat, 8 Nov 2025 20:04:40 -0800
X-Gm-Features: AWmQ_bl5lUahx-ddHLXQbQC5JBoYj958vCD7_rQlbtTof8rtQnJKJu5Jt7SEWN4
Message-ID: <CAM+eXpe1inRG9Rbb7y=tGOWrKrQ0nnXut09MEtXwwV35Zc-tCw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] CPPC/amd-pstate: Fixes to limit actions to online CPUs
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Gautham R. Shenoy" <gautham.shenoy@amd.com>, Len Brown <lenb@kernel.org>, 
	Mario Limonciello <mario.limonciello@amd.com>, Yunhui Cui <cuiyunhui@bytedance.com>, 
	Jeremy Linton <jeremy.linton@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Ionela Voinescu <ionela.voinescu@arm.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, I've tested all five v2 patches and have observed no issues in the
use case the bug report was based upon.  I continue to successfully
receive the desired amd-pstate scaling driver when 'nosmt=3Dforce' and
'amd_pstate=3Dpassive' are set.  I've not tested other cases/scenarios
for which the additional hardening/patches may have been intended.

Thank you again for the rapid efforts that went into this solution.

Chris Harris

On Fri, Nov 7, 2025 at 9:41=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> Hi,
>
> On Fri, Nov 7, 2025 at 8:42=E2=80=AFAM Gautham R. Shenoy <gautham.shenoy@=
amd.com> wrote:
> >
> > Hello,
> >
> > This is the v2 of the patchset to restrict certain actions to only
> > online CPUs instead of present CPUs.
> >
> > The v1 of this patchset can be found here:
> > https://lore.kernel.org/lkml/20251105143851.4251-1-gautham.shenoy@amd.c=
om/
> >
> > Changes between v1 --> v2:
> >
> >  * Picked up the Reviewed-by tags from Mario for the first four
> >    patches
> >
> >  * Picked up the Tested-by tags from Chris for the first two patches
> >
> >  * Added a fifth patch to fix calling of cppc_set_auto_sel() for only
> >    online CPUs in the amd-pstate driver code (Mario)
> >
> >
> > Gautham R. Shenoy (5):
> >   ACPI: CPPC: Detect preferred core availability on online CPUs
> >   ACPI: CPPC: Check _CPC validity for only the online CPUs
> >   ACPI: CPPC: Perform fast check switch only for online CPUs
> >   ACPI: CPPC: Limit perf ctrs in PCC check only to online CPUs
>
> The above 4 patches applied as 6.18-rc material.
>
> >   cpufreq/amd-pstate: Call cppc_set_auto_sel() only for online CPUs
>
> And I'm leaving this one to Mario.
>
> Thanks!

