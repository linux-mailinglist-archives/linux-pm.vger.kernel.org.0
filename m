Return-Path: <linux-pm+bounces-37536-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A57F9C3C7CA
	for <lists+linux-pm@lfdr.de>; Thu, 06 Nov 2025 17:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C37101887BFE
	for <lists+linux-pm@lfdr.de>; Thu,  6 Nov 2025 16:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8D434CFB5;
	Thu,  6 Nov 2025 16:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ed/MdcYF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADC02D6E53
	for <linux-pm@vger.kernel.org>; Thu,  6 Nov 2025 16:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762446598; cv=none; b=mvAyBEmUyI1S2d8UYd1IMKnLzImEUB5UFG0ZKIYCVcFOdqDomfZvLbYDHonpQ5xUOlqSCu/OMB9oO9ElHCHqhpleX0SDT5lrDMZbpKsF6bV+pPtUIyyvbhV10ssOHQ/+abKyDPyW2qpFG2vCuFTeODnDdRcNIM/EupoI1XegLkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762446598; c=relaxed/simple;
	bh=jEkS0wS9JdICTaCzYvZx0OjcAUCfKSnRc9lNZ08RGwQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BMAGTWY+K7mS9/l36ePtpvtUF/zOZG1Ohr8f72JgkuC8XWVlL7FMBlFBRcoOL988kdQRHCo5crLy6CtotJU9EiXotZASe7FRiCWY5VCWAYRHFTiaWihKWFF9QW6nOm3+lZIk92J549vJfrKO2eCG1KjxxR3PHZNIhpPiGnnaHuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ed/MdcYF; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-33be037cf73so1365128a91.2
        for <linux-pm@vger.kernel.org>; Thu, 06 Nov 2025 08:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762446596; x=1763051396; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EMufvlKZanMTIZvbWWJIkNimyApBJZflYRWdIy87U/A=;
        b=Ed/MdcYFf0bE13i+lCUqEh61uYXZIRFsVri+LZVomCRwmAuWXJVvLQ6mrDubJbKC/U
         vgzdb5uvdJai6GSmlEbySoX2SUCrdlDoz2F9sx1SWdbzdQb1CUxPXT/gtK8D1XUm+uXo
         j0rAiZJ0MNULiHXmz1XEGw05ynjQVlhBxUGfxDUKihjbB22zhlJodUfyutsQ2QKzHe/B
         hA6rKMfalhvvFRHacfP1Ml7PV6yUAAlVMMDPtTvKJ+rNXJHvAsUQu7bL0GCDGXaUQfwp
         vXAO6e7LM+ffXLxPJcsgLhhaDz+7HRmkQkGY8eqQcBvoTaaUIefuchT0dpju/c1ZhgCM
         x+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762446596; x=1763051396;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EMufvlKZanMTIZvbWWJIkNimyApBJZflYRWdIy87U/A=;
        b=GqP70LBeFkaji2i14NSs8dzNSeXHLm/BhHSCYQzY3kNKIFGtpu6Gs0lHeju1QGzmcM
         I+/IOHWoBHc2kp6gav52Nm1G6buA6FIm3588RW7TASFAqZdwOkwGBFGdx1pUqBtJ5gwJ
         RSZfshr1cybJwMzC2fCPPCNzblbrx5Etuzi84TMv7LapriT3vaLbs+WEZJsJVmj6vIMy
         N283gmdRtzry1GFa0SLhs5jubMV3h41cLAwaD68T0Zzx3uLXKKdcBblvd41fPL/XAPtA
         Z5Jz9UKUBZfS5ZDYHARuGT0+IH6d/WT/6vE2mXz39kfXGfsOAgqyd3YfeAyU7CcJFqkt
         kljQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzeY/tDjSvkuH57cTJ63q6jkzLlp7nfg9TCvxCbmwdwuMqUX7nvninWiCoUerG7Xeq6grufQApoQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YygeQnSt/ufkqnlmiAhgCx8+UebWbAQLOTDhOoTGg+GL/VSuKCy
	5mUWJFvdz3ZvzcZQfHgVLsPpN2JtDBXvD4J4oMAL7+bsSrbprvd00ZcW
X-Gm-Gg: ASbGnctJX5qn0RYYHbMWtTavfzuubTG0HGEiG9XDIgfIz2pN8sPDEP2OmB/K3qNkgoW
	7pSu7c8g1ZQjtAtkxymruC/vX1zzoh/Xo6K29fA68Q0OzPJOdW+MiX/E7780ZLR9f4iuKSgGD5F
	jYhw+72iDKAfeXYN2GetwyJUpfiAu05GVXKby3jqTNqCJ12Q5aTuI09hprMBNJnWITFIMeEwDvm
	5QrJPHHUOOlxAVaeAouls0mIWuTH/c3euViSGMKivYTrixEBDuW8adEencWvX0WJaz2fVcvFuvm
	+1Bg8cZffnJraEGku0cNl6zRiuYIf4zBt21bAcmvT9Z0Hni93dIWkNxV6+1OJigVFDVw/bi9z0D
	2YHQ9scSrxtjGzWcpXVnQBPOPMRcJhS2Lk4cyxO94IODvbZPTSxQU3B8SUGmETEWETnJQM9ujuJ
	h+cFocAsmk7+ipV9YGksCua4AdJWV07GIjR2SGwPD2Zv+H1DY0HPVCEARQHOCcp2sHMMYBAw==
X-Google-Smtp-Source: AGHT+IG+/YJFa+iN7B35iE0D3sOPdQh3iyKV5sn/uuCGaHI5yvaeFznbvQBUEeV5BmhRnHB0H5TLTA==
X-Received: by 2002:a17:90b:3607:b0:341:abdc:8ea2 with SMTP id 98e67ed59e1d1-341abdc8fdemr6666428a91.37.1762446596409;
        Thu, 06 Nov 2025 08:29:56 -0800 (PST)
Received: from ?IPv6:2401:4900:88f4:f6c4:12e8:f050:511d:31f3? ([2401:4900:88f4:f6c4:12e8:f050:511d:31f3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a68ad143sm6652545a91.3.2025.11.06.08.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 08:29:55 -0800 (PST)
Message-ID: <67e28fadf4c20433c964d13d96dafe3514457656.camel@gmail.com>
Subject: Re: [PATCH RESEND v3] checkpatch: add uninitialized pointer with
 __free attribute check
From: ally heev <allyheev@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>, Geert Uytterhoeven	
 <geert@linux-m68k.org>, linux-doc@vger.kernel.org,
 workflows@vger.kernel.org,  Joe Perches <joe@perches.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Andy
 Whitcroft <apw@canonical.com>, Jonathan Corbet <corbet@lwn.net>, Dan
 Carpenter	 <dan.carpenter@linaro.org>, Dan Williams
 <dan.j.williams@intel.com>, David Hunter <david.hunter.linux@gmail.com>,
 Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn	
 <lukas.bulwahn@gmail.com>, Nishanth Menon <nm@ti.com>, Shuah Khan	
 <skhan@linuxfoundation.org>, Stephen Boyd <sboyd@kernel.org>, Viresh Kumar	
 <vireshk@kernel.org>
Date: Thu, 06 Nov 2025 21:59:33 +0530
In-Reply-To: <221c2b9b-4809-48d8-af7d-f290d1c2a7fa@web.de>
References: 
	<CAMuHMdV+12MoAGNHC9kf==Bt0cLuJ39Fs+W61DN67sE_p-u=og@mail.gmail.com>
	 <221c2b9b-4809-48d8-af7d-f290d1c2a7fa@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1+deb13u1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-11-05 at 10:18 +0100, Markus Elfring wrote:
[..]
> * Do corresponding source code analysis requirements indicate a need
>   to perform data processing with other programming interfaces than regul=
ar expressions?
>=20

not sure about other source code analysis tools, but checkpatch
predominantly uses regexes

> * How do you think about to mention the possibility once more that scopes
>   can be reduced for affected local variables?
>   https://elixir.bootlin.com/linux/v6.18-rc4/source/include/linux/cleanup=
.h#L142-L146
>  ...

The docstring talks about interdependency issues caused by assigning to
`NULL` which are very rare

Regards,
Ally



