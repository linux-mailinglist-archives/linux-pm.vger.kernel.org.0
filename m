Return-Path: <linux-pm+bounces-13201-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B86D965733
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 07:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E766CB21B5A
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 05:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD14152169;
	Fri, 30 Aug 2024 05:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="muRvcvCe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EEF1514ED
	for <linux-pm@vger.kernel.org>; Fri, 30 Aug 2024 05:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724997431; cv=none; b=Hm3e2mBnExFY0JXa1k94+bAQgtY69Wd0RWfzrS1kV7DsY35uW0BE7Kw+8/senI12UTjZAkn6dtlyWvXNuu/WVOamgmMQ7e0pedoN8b7yLVutQk2NYjlCM/bUBvQmBRly/l9YuwVkzPgrF/DXN56zO3FdT5AQli9dQn5xSdxXHyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724997431; c=relaxed/simple;
	bh=EVTXf/DONCxrQFC0k4tFvKek06ZwX1QujVc0QdJjtiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LJtOym284Xersstb9R1kK0SEqFsEUuexpYnR85LbSDWZWDLLWcSuTafNRGZ0Nj/el5STT2ONe2jqvU+oezHohkeo94a51ZC3N+TFoqsQLnGSMNOaNA/SAOFjZVOqg2IB951PpQ5WcQacX2Ath1j0rVeomJYjccQ/tROZRxdjkBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=muRvcvCe; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3df0a54623dso744430b6e.0
        for <linux-pm@vger.kernel.org>; Thu, 29 Aug 2024 22:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1724997429; x=1725602229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+bS4Vcno3eV2Qn/byTVlsNhExHrNUmtKjgh9WYM/zcU=;
        b=muRvcvCeY6dBvd3163VWvs96UcjV67HJDEGM8OHgVj1I5pDRiRCQjxUhc4eWv1EVwx
         n8cZmSaIcGsp1eE/Mta/vr1e9C8FWgBxt6vfSQVVCujOO5eVjSAUTK+eTmsV6peFPHAV
         6BFp9hQg2/7H6kxhkpkSiDtdTClpcDACL7NgI/BInmmWdKvHa7zW7tYBTkM/KCM3WCCR
         a5pk602HA6cWOhyXBKenM1xuOdgJBiExbZeHwVXA/Q3delfJevQv3vSV3Lb2TdqkUrJR
         CTqXbOPYhOrV5ZR0WLhb34zDcwYlE/GT6TDS5vraXMr2CqwsfxmU81U7MDwN/E7kZSmV
         RAdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724997429; x=1725602229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+bS4Vcno3eV2Qn/byTVlsNhExHrNUmtKjgh9WYM/zcU=;
        b=l3UOqN5JPx7GFzmrxh7jAzkuOwktLoSCugnggXoAwE7gFb8w0hKQhfO+WUMQsCyAvP
         2/OqFX4G/1YkLdS1PWeFDmvuARh0L14pf60UdLD7QQKO/nzwHKmy94lUNvaVCIxiJB5p
         3RPiAyLo5EvMTY8ZbxJ4cbq3qDcGWd3Pqx6i2wReYYx9RysiOrI8KXmVEmn23NLf0P1+
         aEOQJwHRlsNswNn+BIL14B9I0W9zitZlcjU1mF7nv/TnKKmp32kviyJ/gttNYuSh9RKK
         aMTRrcI/LVC9Q4IzcTcX0Dtd9bXt5oTB6FHp9R1A028MQ0LjSHob9WR+s7pqzebngl3n
         EEqw==
X-Forwarded-Encrypted: i=1; AJvYcCWJjM8UFPriT+ZPiDXHBl+vOvP+244dgPGcRYy5Xb/ncmOdDLeOtL2mEhabA65RVRFBaFIZquDMfA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6zOXI64N/nJPUTpfVqj5/dS7lWzcFtLOMVUaDcR1pyYvpqqKA
	twcFtUJI6PAeUy+/Kc467Yr/rGh9UE4c0vzuC1pIsB9f45nMuoDaOb/VKfqdFFqvrCGmvixDiue
	f9+j8EIfMuPk9qCPTMc+FXSLHxI0VL3Fk4C//BQ==
X-Google-Smtp-Source: AGHT+IF+bvBOzP8WPuHP2wswdhxLCrRjaJRkPZE2kRmeOLYycfULGuDXQiQa0ow1QrMYQIBLSiVTZE6myPNKH1Jcjkc=
X-Received: by 2002:a05:6808:11cb:b0:3d6:5791:a378 with SMTP id
 5614622812f47-3df05e22510mr5366568b6e.17.1724997428847; Thu, 29 Aug 2024
 22:57:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829033904.477200-1-nick.hu@sifive.com> <20240829033904.477200-3-nick.hu@sifive.com>
 <87o75ba1hx.ffs@tglx>
In-Reply-To: <87o75ba1hx.ffs@tglx>
From: Nick Hu <nick.hu@sifive.com>
Date: Fri, 30 Aug 2024 13:56:58 +0800
Message-ID: <CAKddAkBM6BW9BXYumiG8JzbTFRD1pgp=b0fcb=KBW6ysjPf8Qg@mail.gmail.com>
Subject: Re: [PATCH 2/2] time-riscv: Stop stimecmp when cpu hotplug
To: Thomas Gleixner <tglx@linutronix.de>
Cc: greentime.hu@sifive.com, zong.li@sifive.com, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Andrew Jones <ajones@ventanamicro.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas

On Thu, Aug 29, 2024 at 9:43=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Thu, Aug 29 2024 at 11:39, Nick Hu wrote:
>
> clocksource/drivers/timer-riscv: is the proper prefix
>
> Thanks,
>
>         tglx
>
Thanks, I'll update it in the next version

Regards,
Nick

