Return-Path: <linux-pm+bounces-29724-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B49E2AEC396
	for <lists+linux-pm@lfdr.de>; Sat, 28 Jun 2025 02:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 232A64A8028
	for <lists+linux-pm@lfdr.de>; Sat, 28 Jun 2025 00:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC13E17BD6;
	Sat, 28 Jun 2025 00:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJrmjpis"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367682F1FCB;
	Sat, 28 Jun 2025 00:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751071514; cv=none; b=cXxNAWjZ/xVrAFObtXmtSalQUSsnxeh3UyUXF5Nvwjga4HBbgRGC/iCVoeKan8j33eVY/wJe9ppthSNs8oq2vCOs20BXqM2n2nGzQt9kZfj9RvK4rrAfmjUwjGeE0vYpBZu8K0LIuxI56xNbDpsuWr6H5loKfLR23g0a7JewuzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751071514; c=relaxed/simple;
	bh=wNXPr6j6qIt3yN494uH7t892R8sxDK8th5KMR9ZzEjA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=jMlHnzlRozeAOMfOI6BsT2p68tMVUC9obbCBJ8t3DgnMfoM44aJ3dPttgcBZ6sFUSgOBBvBUBTCGdS+QaugGBDzHRcC2Nj8KIjQmOD7+HTZsBnz5qS1xVYWcNkQZDlovLxpLM7J0kZAs47vQD/gIYFtAwfYxy5j6J9Bv+fvnc0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJrmjpis; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6fb3bba0730so42974596d6.0;
        Fri, 27 Jun 2025 17:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751071512; x=1751676312; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gni73V/Z5W3IX9I64Bo/7/EXs814tRFIzOUmFV7Yem0=;
        b=hJrmjpisTri/VIvqa8KGvFEILWaLkRVekb88c8xq+2PSFdxCKqNGtMq6NLyY4jiDM0
         QDmV8vkdY+wsXUfjqVtovta+Viu7pKWO/L784OXv+Lqxwm/anZc8eLD4UJK777hjThdA
         qRkrc7rEsQaJ3US+e0Dk/H6JYmdGKiHlT0y8Mg6a+eCFDYXmUyUhie0ni5dSHj7ixidw
         a/XV5CcCyTxmaiVqDt9UsVkqbGQ/znCqymAOSFUC7mOwW8dQcjFzuiwiRauEcCVNFTua
         RCWFvbunFpLioOlWvVEDLYqqCnaEVHhEQdtUN0RLOFEINlltkchWPjMlnHkas0TPpnJo
         qTdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751071512; x=1751676312;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Gni73V/Z5W3IX9I64Bo/7/EXs814tRFIzOUmFV7Yem0=;
        b=eNtE3qPs7QEjWWKTwsyKYNaXwP1CbOJCz1V07s5qsWYXey9XpWRbE6s29kth//s3JK
         HCUM9PaGhEI67cEzCr769jj3FuAyMsU8Gsy/ahOU7zYYhOJaJ4Nn/H2A3KaCl+fZs/+d
         V99nxBqtXY3gDWO+clmpW+yydzn1ZfLvohym8rocYJH21l/K+s0gcdnEf6AiMmOGOYKT
         7+w6/71cAbgFECavsoI3g4EAKgFG/icdObA9DUljgDJnmWY/ZLRkNUrzXFoL3NytnlVx
         9jWUAe9uE9Y29cgHIQSo6uSt0i3uVtVqsBRyUVY4AZsZszh2ydufz2sWNOKM4rOmrQ0r
         Hspg==
X-Forwarded-Encrypted: i=1; AJvYcCWFerHsqmH1QBCDMw0TGWcEDIMLycrqwQ9iCtnI59AgLOAUvU7DIPU2XK0G1gdU6GiT6JLniFFsND630b6reTAAG6D3YQ==@vger.kernel.org, AJvYcCWxmCxM+t7ut1+ys1nOjao6xjuyMZ7pSGtgA41hxLmQBFI4P1jB5W6rgc1orz8O9bY2ThnT0EPt+A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6xuKu/0MgSvCP/URwfnGMIz7PJf85YOjLOTq4/pXoeSkfqHnH
	mAjB7/ztWLB2nU8OkgH2vutppA2ec/JuI/8mQYZDjp5o/rLnAM4lRce5
X-Gm-Gg: ASbGncvsGKe4Ff9iXoFZct2TTM8BMxXDMd44eFIJV6IsFkzxbXM2csxVl62jPACuQ2y
	1DljOENOyFZDGnVaqIb/jDlHyCU5Z1iqM3Q2URllEFg0WsnhqIILgD0KL7qs+pGtAd2F1SvtPHH
	0+cgfuj2Z/7zNMydT/6/PzTW3KIQ8vnCoWc1+kftdJn/sVGIeIbH7V8MB7le5aLPbtrnvKf7E3E
	EZa7HWUAu0L2NKPOK81IUGFzliZUo3uvs/aXw9komGfqk1CQPgqLdPNzMtNAszxLptVMEmN60h1
	S0vfi2lmM6QC6IaOczqzXgeBPSprcPDZHSZmkAyMU9pcA+KiFSrKS5Q=
X-Google-Smtp-Source: AGHT+IG8nn20ljc4lXvPohRP8hs6OdF87pXPsRwizTvEaBGR8hb6ODtmJOK0TbWs9BxjkgZi/j9bmA==
X-Received: by 2002:a05:6214:3485:b0:6fd:364f:a2db with SMTP id 6a1803df08f44-6fd7536dd3amr142881636d6.9.1751071512102;
        Fri, 27 Jun 2025 17:45:12 -0700 (PDT)
Received: from localhost ([181.88.247.122])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd772e349dsm29178136d6.68.2025.06.27.17.45.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 17:45:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Jun 2025 21:45:09 -0300
Message-Id: <DAXR1M1W2XFZ.3H2AWUO3N1X5E@gmail.com>
Cc: "Armin Wolf" <W_Armin@gmx.de>, "platform-driver-x86@vger.kernel.org"
 <platform-driver-x86@vger.kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Daniel Lezcano" <daniel.lezcano@linaro.org>, "Zhang
 Rui" <rui.zhang@intel.com>, "Linux PM" <linux-pm@vger.kernel.org>
Subject: Re: HP Omnibook Ultra Flip 14 - power profiles
From: "Kurt Borja" <kuurtb@gmail.com>
To: =?utf-8?q?Benjamin_Hasselgren-Hall=C3=A9n?= <benjamin@benis.se>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <GXa7F-PA_8BE7nlK9r8dkdSv7c-DW52GvOUiyYHQ6RyoZDxIpNAocWDPYQDeS7WEZeUisqQH_bqmgSV-eaRmuw5r68MGKxyU9X_4Erd0RYQ=@benis.se> <1037e223-a6ad-4d12-9619-f69a29cecba1@gmx.de> <5I8UDmgF_DcJBmBE0zgCXjuvmmhLamDCHkpnkAwRjSAkCa5xcFUvU-SmAeymxTajjDPR8avuW55RxOjhd8idK6jLy-hz8i-Ma3RHSaFy2Gs=@benis.se> <9642ad7e-3e57-45f9-bfd9-beac3e55418e@gmx.de> <GXC8NQl6AY_N7nQAOCRLt7SDGjFNll_TnqQyzYnP_b1weGkRqITOR-kHKcM66lPonOCo9xO2nSWXr7yycwfFuKmjRMtXVlJKya8-qvvkGik=@benis.se> <de8321ce-e595-460a-81d7-f7dae8a7b790@gmx.de> <X-40AqXfdmQw5shUOk3VSaHSXmwJYWHPmDDMLyGUH6GpMt56ty5SbNg8EVfyI_uC9J07uqZ2TtGJmmpB_x8-xpcVOw29fnKzJZ4n9L0x78A=@benis.se> <9439ec38-aadd-4aac-ba51-a8786ba50239@gmx.de> <DAXK1634VYQI.1PEUCTQIYAF3Y@gmail.com> <jCZyBwYNgVSM_Qk2XkfweZRlZNiSh06WVUBqya9leWoWXAmNFL9fdbgBX038OzfQUEaGE5PU8yhtJL2zq_PRW67FmLYTnoK_SPUPmzoTdco=@benis.se>
In-Reply-To: <jCZyBwYNgVSM_Qk2XkfweZRlZNiSh06WVUBqya9leWoWXAmNFL9fdbgBX038OzfQUEaGE5PU8yhtJL2zq_PRW67FmLYTnoK_SPUPmzoTdco=@benis.se>

On Fri Jun 27, 2025 at 5:49 PM -03, Benjamin Hasselgren-Hall=C3=A9n wrote:
> Hi Kurt,
>
> I do not experience the same error messages as in the bug report - no err=
or message at all. It respons to changing power profile without any errors.
> I also tried 6.12 but same behaviour as 6.15.3 (just getting some gpu gli=
tches - problably because of Lunar Lake).

Can you paste the output of `cat /sys/firmware/acpi/platform_profile` on
Linux v6.12?

>
> I am trying to understand how power profiles work - I guess on a high lev=
el it's controlled by uefi and the profile is set by the OS? Or is it more =
complicated than that?=20

Yes, as quick overview. Power profiles are usually a capability of
individual devices. Drivers of these devices expose this profiles to
userspace through some predefined interfaces. Then your DE enviroment
exposes this to you.

KDE and Gnome use power-profiles-daemon. This program controlls mainly
two kernel interfaces: CPUFreq and platform-profile (there may be more).

You can read about CPUFreq here [1], although I don't know much about
it. The platform-profile interface may be used by any platform driver -
in your case this is the hp-wmi driver.

This driver exposes some firmware defined profiles to sysfs trough the
following paths.

	/sys/firmware/acpi/
	/sys/class/platform-profile/

You won't find the latter in the Linux LTS version though. You will find
documentation on these paths here [2] and [3] respectively.

PD: Please, avoid top-posting in kernel mailing lists, interleaved style
is very much preferred [4].


[1] https://docs.kernel.org/admin-guide/pm/cpufreq.html
[2] https://docs.kernel.org/admin-guide/abi-testing-files.html#abi-file-tes=
ting-sysfs-platform-profile
[3] https://docs.kernel.org/admin-guide/abi-testing-files.html#abi-file-tes=
ting-sysfs-class-platform-profile
[4] https://en.wikipedia.org/wiki/Posting_style#Interleaved_style

--=20
 ~ Kurt


