Return-Path: <linux-pm+bounces-43085-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KImOJDIWnWkGMwQAu9opvQ
	(envelope-from <linux-pm+bounces-43085-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 04:08:34 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 112161814E0
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 04:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B2B6F3064904
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 03:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9CA28CF77;
	Tue, 24 Feb 2026 03:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="GjQVQi75"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541E2283C87
	for <linux-pm@vger.kernel.org>; Tue, 24 Feb 2026 03:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771902503; cv=pass; b=ErP7ftipvLzXz9eVjUSXbmO9eoF5whWfccyAmk61AL6u8Lc3bQpLWv1OEAl6uMVIdqu4z8g5i0Twk2vv4jrkh6ZuIww3Nm7tkLu6+tp3EpCSEdCEHl8M3NJIEs1U7iWAzwJCPzM0iw+qr78Zk1jE/JdsFYCxKAqDV7jLN3qE4mQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771902503; c=relaxed/simple;
	bh=MB3cu4Hjbrcw6vQYy3xqvFyNo4jM11gJv2VecpsQoq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U89w3sM3J7AcZCZaOvHBivSuqZDDVAPpVzrVVwRYF2EJysNtMAzxoHw+WUOcQbidqg5JSrSBZtuRIa3IAcooT+3AntqHoteg9c9YKFYGcykAe1OejfrxJFB7MnOJ2b/1FpSYerPn0CdSxHTru0gHHC7SxKTnRIiSYKcFE6TyqJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=GjQVQi75; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7947cf097c1so46232577b3.2
        for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 19:08:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771902500; cv=none;
        d=google.com; s=arc-20240605;
        b=gFAa1ZsC15ZLL6UQ7y0jomhfEwr0ZxIj2mHosDLCeOP5Xie6kUXGWWG9KtB+hbX/Pd
         sX88eRA8V9lCYu5T5rqb61PmpOz8eO0omVPzwl/6yOKqvR9SYWN85EYB/Rh0f1DykloK
         pxZGW/iddj9FNNOI2jKqigzy6Zh5KFr3rWe51HdiqQ/KhlUlTyKI9t5BsPIB7betCcLE
         cwbiG5NJAnBP0OMY3vVVVnzWA5fJkaitK0pxvWRR8ZCae/XeUUOfX3sFR1m9BoaesUbK
         l1x38KhZrRE+QFe9ve4kjgpS5JRN3oMiE87Bb0ws7PQKtwEjcFH93C4y3gp31sasapKq
         LqxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BycvdGp/z9gEQo1VCtrRiWndisDEJHCvcJytLoYubq4=;
        fh=nc5jIPF5+vyhhTWioBE0FsfXM/7ek3gExjwAI8BF3Mc=;
        b=S6ISRUn1kNXWyNr5UDFkAtYbNSTsq330n7iM08uaQSS1WXMhUywLAcH0HtNQmBbhsb
         jXbGx6Xfhc3eIp+3J2VD8UOZQKchxCppe0xY09TjDoEo4VzplO5MDhYX40zwhdfzMhYc
         VmIdyYAIbXP6kWyRIU8sGaBeK4c9opHKh0KUTzy9na3pTH1UmvMCui5r2hNIZ3gEDuwP
         GuQAQPBZhiaCl9aLK0+iBtmHv+AaW2zKSkEcCkrnjSlPTGWYbHks0bM02SI8ANCeJvJU
         zvvzYKYdbfhrO3VlseViO4c4cvxXgcgCP0syZfXqDQuR5L/sHF6tR+lgcE33zLtm8fOK
         lrNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1771902500; x=1772507300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BycvdGp/z9gEQo1VCtrRiWndisDEJHCvcJytLoYubq4=;
        b=GjQVQi75Qrb1V6GFiI+vya1/j0D+A7y+MWtEDHWjWt3r52NZr37nFE7aSYFIKT4v1A
         s0RZUdQBOaTGtCQwdxBGJgRDr5vR3X2JRYSKaXaAbo/p7nkQCi9NEyJ16BYpRvjxHz9+
         MCN/Xqd60wRpyx4hH9KcgDvThnbBELEaIkjLYFm1koEGIvGmhZ4IN/DaRmTE+RaOHn9U
         qSRHy4igKiJcwzFedfbflM2ox4quCYOy9jwJvyg3qUy9IF/G9lpT+ux3GAFFB5IshX4c
         4wct84x3J0uTzAUwC5STUwNxMo+A9xKi9/kpNTIJWm4+wL7RzQAAdgtgZUxU8g2ufhEW
         rzEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771902500; x=1772507300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BycvdGp/z9gEQo1VCtrRiWndisDEJHCvcJytLoYubq4=;
        b=YMjyCO2J9GCOp1l95Avh90zDO/Sjx4XtKA1foplldfjK2rV5xEOHW00UDzbQQZkkET
         zvqFmUL2LH3x/UBdOPrpNgdSPtrm5lYORU7ymtBi6DzqQuFSDCV4YSjjlFdinxfworW+
         sZvdq+qV5CRTf55CHRF2EjnN+O6CnfxM4XJIw8cc2ogeGvLxGplpgVIF/CXucYmPqB1f
         oBTStecivmoPA4LZZtC4HbrH7F+IjkmciBBKMMpCt+sxAHPXLV1pssptAmyNAzUOQEA1
         9h9JJx3QgUfhprMZg4MDy6mGB9MdCnNi6mqaLvPV31TtFEa2YBJ2q+XCC69YwpH8cZt7
         e0UQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKj7BQysvf6Nug30GuTD6X71G7xT52Lk1h6TY9upGJ8X/nzCgLYE8cwZoxyu+nUt93xYJsJQk/sg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwOmFRDroXUEFcIg9pJjOwMvsjJ39ZOZbmh9YxuEIozrGzf6M3E
	YhIlaRLAUX1esbc3eHTRHZ1XLd/abKWtMPiX8/Mdooa6Y8zHzXQB+xLsDvposisae5FZnJzYNBo
	/HjRI8whAvIAHq2eP8a6eVvH+NwxsUJ2teFmcR//l5w==
X-Gm-Gg: ATEYQzyY0yXNdYbEOslE8zdx54vqswFQTyxWd8BI9p+vjgqrl3XCc/A2ZtB3NJnDo9k
	dZXtHxYIvnSua86NsHqfM1P4wjfGOJh1mY3bkmslPRQHPyvGTI2fzCp2g//DOIJAej7MAhWDWQA
	0TpRgznm4PzvCRs4lrllEoaWq63obvKK7c+57DAZWaG6r+RovYsJ8dUBtuqhiETyK7BRRS5V+1a
	M2+54W/Ww9z3qJNkfH6bNUzXgvKMYpc3SmxFzNx3AwFYURlojtPDSvKaYZTGBBSJK0m06ddxLEa
	pIWGllyJ5w==
X-Received: by 2002:a05:690c:4984:b0:794:ffc8:659 with SMTP id
 00721157ae682-79828cf7240mr96664067b3.12.1771902500382; Mon, 23 Feb 2026
 19:08:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108-sifive-pd-drivers-v4-0-2a523d7d51a0@sifive.com>
In-Reply-To: <20260108-sifive-pd-drivers-v4-0-2a523d7d51a0@sifive.com>
From: Nick Hu <nick.hu@sifive.com>
Date: Tue, 24 Feb 2026 11:08:09 +0800
X-Gm-Features: AaiRm51hYev0P2yjDadOZi7PKWo_siHtRuCOZQk8OpSAHm9eqQ7TOSuLU00jpjU
Message-ID: <CAKddAkDKzFewnDVJ8x-oCn=xO72Ps8GevatL3wgmQwiErtqPSA@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Add SiFive power provider driver
To: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Anup Patel <anup@brainfault.org>, 
	Samuel Holland <samuel.holland@sifive.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Cyan Yang <cyan.yang@sifive.com>, Nick Hu <nick.hu@sifive.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[sifive.com,reject];
	R_DKIM_ALLOW(-0.20)[sifive.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43085-lists,linux-pm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nick.hu@sifive.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[sifive.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sifive.com:email,sifive.com:dkim,infradead.org:url,infradead.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 112161814E0
X-Rspamd-Action: no action

Any feedback on this?

On Thu, Jan 8, 2026 at 4:58=E2=80=AFPM Nick Hu <nick.hu@sifive.com> wrote:
>
> This patchset introduces the SiFive power provider driver, which sets up =
a
> generic power domain (genpd) provider to coordinate with the RISC-V SBI
> CPU idle driver.
>
> To enable this coordination, split the power domain initialization out
> of the RISC-V SBI CPU idle driver. This allows coordination between
> power domain management and CPU idle states on SiFive platforms.
>
> Changes in v4:
> - Split the power domain initialization out of the RISC-V SBI CPU idle
>   driver in PATCH 1
> - Refine the commit messages of PATCH 1 and PATCH 3
> - Rename cpuidle-sifive-dmc-pd.c to cpuidle-sifive-dmc-domain.c
> - Rename SIFIVE_DMC_PD_CPUIDLE to CONFIG_SIFIVE_DMC_CPUIDLE_DOMAIN
>
> Changes in v3:
> - Update the explanation for the absence of the SoC-specific compatible
>   string.
> - Drop the smc3/tmc3/cmc3 bindings.
> - Separate the genpd init and the idle driver init. The genpd remains
>   functional even when the idle state is absent.
> - Address the warning from the kernel test robot
>
> Changes in v2:
> - Add the driver for SiFive TMC, CMC and SMC
> - Drop the `sifive,feature-level` property
>
> Nick Hu (3):
>   dt-bindings: power: Add SiFive Domain Management controllers
>   cpuidle: riscv-sbi: Work with the external pmdomain driver
>   cpuidle: Add SiFive power provider
>
>  .../devicetree/bindings/power/sifive,tmc.yaml |  58 ++++++++++
>  drivers/cpuidle/Kconfig.riscv                 |  11 ++
>  drivers/cpuidle/Makefile                      |   1 +
>  drivers/cpuidle/cpuidle-riscv-sbi.c           |  46 ++++----
>  drivers/cpuidle/cpuidle-riscv-sbi.h           |  20 ++++
>  drivers/cpuidle/cpuidle-sifive-dmc-pd.c       | 102 ++++++++++++++++++
>  6 files changed, 220 insertions(+), 18 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/power/sifive,tmc.ya=
ml
>  create mode 100644 drivers/cpuidle/cpuidle-riscv-sbi.h
>  create mode 100644 drivers/cpuidle/cpuidle-sifive-dmc-pd.c
>
> --
> 2.17.1
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
>
> ---
> Nick Hu (3):
>       cpuidle: riscv-sbi: Split PM domain init out of the cpuidle driver
>       dt-bindings: power: Add SiFive Domain Management controllers
>       cpuidle: Add SiFive power provider driver
>
>  .../devicetree/bindings/power/sifive,tmc.yaml      |  58 +++++++
>  MAINTAINERS                                        |   2 +
>  drivers/cpuidle/Kconfig.riscv                      |  25 ++-
>  drivers/cpuidle/Makefile                           |   2 +
>  drivers/cpuidle/cpuidle-riscv-sbi-domain.c         | 176 +++++++++++++++=
+++++
>  drivers/cpuidle/cpuidle-riscv-sbi.c                | 178 ++-------------=
------
>  drivers/cpuidle/cpuidle-riscv-sbi.h                |  29 ++++
>  drivers/cpuidle/cpuidle-sifive-dmc-domain.c        | 124 ++++++++++++++
>  8 files changed, 423 insertions(+), 171 deletions(-)
> ---
> base-commit: f0b9d8eb98dfee8d00419aa07543bdc2c1a44fb1
> change-id: 20251207-sifive-pd-drivers-66de65108b1c
>
> Best regards,
> --
> Nick Hu <nick.hu@sifive.com>
>

