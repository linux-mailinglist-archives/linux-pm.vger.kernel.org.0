Return-Path: <linux-pm+bounces-15066-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EEF98D411
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2024 15:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CF0D1F220FC
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2024 13:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C111D040A;
	Wed,  2 Oct 2024 13:12:42 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CD91D0405;
	Wed,  2 Oct 2024 13:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727874762; cv=none; b=jxuXzfle2WMK01oqehQkI28ccsustfCQWn48xtZcy8iqihLzN+66iuRyo4iLqGmTXRU2qT2YGWzwYqrqYGD5q//KhKl3Nnf8UjdP/IxdFwPXPz6zHGZzaUrejz0RMzo1mxLF/5Vqz/I2b+0l6/CFAyuIsk3fRGWfyDxH8WWyoUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727874762; c=relaxed/simple;
	bh=N5L2g8EwRhDy40p6yC3kh/7gBJsJYmiCjSyNDb5bxGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bAQXdY1SsHsUJHOcERH1jdjD75qcTu9FZcJbjHAUeSv6Og/om2SKH82aBd2MDr21vfZQ4NIeTdudXx0qve7eE4QQCljdaFhxIG8edLaUQ54M1WLcX9C226EIEHIMhv5AUg0yju/gPU2w9rXvBkULtK81W9Zqo5F48htWXfBk8T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-82cdc21b5d8so351132839f.3;
        Wed, 02 Oct 2024 06:12:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727874759; x=1728479559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3pK+kjin/q50hNie7LoR7GwLI4Mu+qAhCcp1BuFD5Sk=;
        b=qqGz21zwnzCKE9pg169rIuLfJbeEI2nxadsVGIsaN5xlB4tfitOAjc3RloMbe9caRp
         V2kSBpEmHJWz5Fx+6zO5SpR1HQA5MDwUQhC/2KexTWbZBe5IU51lUfYGQ4hrcuX1f48W
         +n17D4/mm14d3sir1APqFHRnuDfTf735WB7SMRIvJIY58hN+DgaFuj5EGEh2KlcV6x+c
         IZDc03nj1zdALv5U7zh1G3qmkVua/WJSaqe10PlKKso+X/ZLN3hVTQrbdzdqrm2ERwbI
         0NVb8+gQlyv4Z76shaQpAp8ICdmbG2ePogTP3Kp1oV8El/KwFpvdbHIX7pc6S2MHeqmR
         j51w==
X-Forwarded-Encrypted: i=1; AJvYcCU+PtPNBo3McA+FdJnRDYXinwaFsdSUSh3TJMwYsIkVnXZ6RgyC5MECWeRN7e0Ce4d2FpCht547n/QUnAuE@vger.kernel.org, AJvYcCUMqsDa0B0IiWjcNpJj3lMXQKH3mW5pUyp0QaPBhH6syGXVWFkslgUet25nUH+GLsmIPkxBFJUl57s=@vger.kernel.org, AJvYcCUzI+IMTsRUIyNUQszvXFcCVsTSChaE8ppPCYaADiDBDXfjxzlp/2fkOF2YfN0XsQma2BQ0/SGGkqU3@vger.kernel.org
X-Gm-Message-State: AOJu0YwRUEXNYjjPnOavT2auXqWezkis0VpgggLiTtJScE+UDTaKdGKv
	fReCpf40Jy5/AWsOuGa6PIoQpFZe08Dhp8Sttq2Z3npT/U2hNJYKdy3bOLDR
X-Google-Smtp-Source: AGHT+IEXJFaYVsp+6GM9OHy3IQpWxTUEfeldBleDRf4fej7JZnXRaZ9gmFa4ZnqGMuvzNHMM1T1TsA==
X-Received: by 2002:a05:6602:2b0c:b0:82a:a693:2736 with SMTP id ca18e2360f4ac-834d8484c12mr350658839f.9.1727874758797;
        Wed, 02 Oct 2024 06:12:38 -0700 (PDT)
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com. [209.85.166.52])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d8888c31f3sm3082224173.115.2024.10.02.06.12.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 06:12:35 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-8325044e388so309917439f.0;
        Wed, 02 Oct 2024 06:12:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWHSsfuH+c6rIaqRRNjh9aEYNoSGm0AgJ3EfROOXisrSAYjUnvZwV8aWf6EI91Z4A239Ym3/jAkrQ4=@vger.kernel.org, AJvYcCXSKxETQqG/nLEBAkx6hCEmS+zbZAN7XpZI5D+1UDY/8YAQGabsc+8ijMOZeUzT0u829hoWz6r2n/g1DebW@vger.kernel.org, AJvYcCXgE36yISfnD4qEXt4iR+CAkERnENoMr02FfrTHU12r7VuWRcFShu5sNgWJylkdWYML8g+82VG0JEzt@vger.kernel.org
X-Received: by 2002:a05:6602:134f:b0:82c:f30d:fc9b with SMTP id
 ca18e2360f4ac-834d853a0eemr362057239f.13.1727874755504; Wed, 02 Oct 2024
 06:12:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240919091834.83572-1-sebastian.reichel@collabora.com> <CAPDyKFpWYnqLGdxXc4Wvt_3MNsYkCpRfTJMeUddZzpKTwnY4Rw@mail.gmail.com>
In-Reply-To: <CAPDyKFpWYnqLGdxXc4Wvt_3MNsYkCpRfTJMeUddZzpKTwnY4Rw@mail.gmail.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 2 Oct 2024 21:12:20 +0800
X-Gmail-Original-Message-ID: <CAGb2v65LCyd8tMHLruCFb4Sd_oAXmAHWRMOKcQZHkOvuZxROmA@mail.gmail.com>
Message-ID: <CAGb2v65LCyd8tMHLruCFb4Sd_oAXmAHWRMOKcQZHkOvuZxROmA@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Fix RK3588 GPU domain
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Elaine Zhang <zhangqing@rock-chips.com>, 
	=?UTF-8?Q?Adri=C3=A1n_Mart=C3=ADnez_Larumbe?= <adrian.larumbe@collabora.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, devicetree@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 7:00=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org>=
 wrote:
>
> On Thu, 19 Sept 2024 at 11:18, Sebastian Reichel
> <sebastian.reichel@collabora.com> wrote:
> >
> > Hi,
> >
> > I got a report, that the Linux kernel crashes on Rock 5B when the panth=
or
> > driver is loaded late after booting. The crash starts with the followin=
g
> > shortened error print:
> >
> > rockchip-pm-domain fd8d8000.power-management:power-controller: failed t=
o set domain 'gpu', val=3D0
> > rockchip-pm-domain fd8d8000.power-management:power-controller: failed t=
o get ack on domain 'gpu', val=3D0xa9fff
> > SError Interrupt on CPU4, code 0x00000000be000411 -- SError
> >
> > This series first does some cleanups in the Rockchip power domain
> > driver and changes the driver, so that it no longer tries to continue
> > when it fails to enable a domain. This gets rid of the SError interrupt
> > and long backtraces. But the kernel still hangs when it fails to enable
> > a power domain. I have not done further analysis to check if that can
> > be avoided.
> >
> > Last but not least this provides a fix for the GPU power domain failing
> > to get enabled - after some testing from my side it seems to require th=
e
> > GPU voltage supply to be enabled.
> >
> > I'm not really happy about the hack to get a regulator for a sub-node,
> > which I took over from the Mediatek driver. I discussed this with
> > Chen-Yu Tsai and Heiko St=C3=BCbner at OSS EU and the plan is:
> >
> > 1. Merge Rockchip PM domain driver with this hack for now, since DRM CI
> >    people need it
> > 2. Chen-Yu will work on a series, which fixes the hack in Mediatek by
> >    introducing a new devm_regulator_get function taking an DT node as
> >    additional argument
> > 3. Rockchip PM domain later will switch to that once it has landed
>
> I have just queued up 2) on my next branch.
>
> My suggestion is to skip the intermediate step in 1) and go directly
> for 3) instead, unless you think there is a problem with that, of
> course?

I don't think we were expecting things to get merged so soon. And IIRC
Sebastian went on vacation after Plumbers for two weeks.

ChenYu

