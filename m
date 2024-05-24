Return-Path: <linux-pm+bounces-8102-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 381178CE459
	for <lists+linux-pm@lfdr.de>; Fri, 24 May 2024 12:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 802FDB212EF
	for <lists+linux-pm@lfdr.de>; Fri, 24 May 2024 10:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2FD8565F;
	Fri, 24 May 2024 10:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SR+NtTzG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FF785642
	for <linux-pm@vger.kernel.org>; Fri, 24 May 2024 10:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716547302; cv=none; b=jEZfsYNLA6NvKWO9pY2eiaYKvzbI/y9O8yeHxyoO7vI52zvJKwTmiJBCprCCYEZy3iEQpOCAB1GZbaxp8kTIO9dxlptSsLgyfN1RD0XiSYOhBb7VT7UvLNtFdvneTJTitT8k5JbsTVwcPZq6Y1qqJwuGF5oGyDlFhZHCY/VEy8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716547302; c=relaxed/simple;
	bh=Ka9cmTCSiwlHXYTApKkxtTxZ6kn3mKj/2waCvaYF9Qk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FmG/BEYKwPC5bWAfGWUanpfcp98GNjsIpf1gmNZ+N6aTO9Dt/j72mh7BJbeeHHUr02BeEHZ3dSoSOIT9pFxHXMrWr+Rm7ZjEg2SR/CtXlZa2s3DlaROjWYC3rU8ArJ1KhJpp2f1YzScC5J+06IESTbvOAP6CiFeoDya3HKKip4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SR+NtTzG; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-df4e503983fso2888800276.2
        for <linux-pm@vger.kernel.org>; Fri, 24 May 2024 03:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716547299; x=1717152099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wXTrajnU7to/8Kkx0kFyODWqZ7ULlok1jwgmE99WXAc=;
        b=SR+NtTzGoAsNbf65Wp3JmHK4B6WAoi5OkqAPaGpmACESpSOSI6yuguZqhrcKS+xDlY
         zGKPTL1c+rKUAA6KRKdrdwkiYutR/OyLRO/rYNKPAT2gGk64Fe/nlmd8W3iye7KA6ZIM
         W7rD0UKFEP68mEwY+U39iqh2tUDAfLB4Wa1u2EQjuClpGrtPniak0wuPmLRDwumCfyKh
         4bpq5M0Z9Ge8zn1qLWzQLp990Ma+/9F8ub67Y1FuIlSY6NnQ472iEch3/73sxqSd2VIl
         tChseCAcZtMeIpHepaamLiPTgSsBGuTE6+1eBdK+tZ/F5GWt+nekkFr0jR4727PaKIc3
         KSxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716547299; x=1717152099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wXTrajnU7to/8Kkx0kFyODWqZ7ULlok1jwgmE99WXAc=;
        b=iXRMMPy2IbA8nVDV1BSRiNn617Hul1jwMXaYbf+pjaByD3b3YdXixNKwmYZq3PyeTs
         1YnOAvasFql+MetskKSB9AzO2eMQh/tocdEkTjaBv3wktBOCIU0hRIanVR9uX/E8KXOG
         qZXry2/hvsdIud1XR+BBX0/xQ0bUlWPaps3hs3OYnmZx1kugLW9CtcQJQJcC/QyDC1uv
         M1Sl+zla/wkGNUklwZR9CwASPt49bgNZu8ihFLHJWrMiCmPijwtHFVtgtmqMAyW9Vh4+
         xGZc0+8ILsecEXrmcVI5XURvt/M2ah3OlQrfTWstpbETs24Z2J0uetrDmIk2iL7F7DmX
         g/wQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKXTUQ5RdA3nZKwvWpfKXqyJSHoLCmPHsTPw/USQ0X1pYuxorJ0D6lzdylICmAhA6UMennXMd/D2GMtFFyKj9xF2xERmxom6o=
X-Gm-Message-State: AOJu0Yy2DU0TdI56y9OJ9L5ommtXQnHv5TJ8L3LXLqa9jPzFD0H2dSMs
	M85IhVcG0rnPb/9uFgBimYm3ArzJWNtN37tJYfBbqW683VxqyHUkwnMiIQrUa8DOYt/OhDbsK/9
	TOVCJKQz9QO/XITLzYLfatj/ysFCqEfRGmVkyEw==
X-Google-Smtp-Source: AGHT+IEPSpGVjqat8T+RvfksZYTyFP+HqIfWNgQJAU+a4NitDODiB8ZAXvb2En7cAUR5yVuO4qWc2l+8kTvUGGtyN0Q=
X-Received: by 2002:a05:6902:c0d:b0:df4:8ab4:d8bf with SMTP id
 3f1490d57ef6-df7721a50b6mr1984616276.33.1716547299257; Fri, 24 May 2024
 03:41:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226065113.1690534-1-nick.hu@sifive.com> <CAPDyKFph3WsZMmALnzBQKE4S_80Ji5h386Wi0vHda37QUsjMtg@mail.gmail.com>
 <CAKddAkDcdaXKzpcKN=LCCx9S4Trv+joLX2s=nyhzaRtM5HorqA@mail.gmail.com>
 <CAKddAkC6N=Cfo0z+F8herKTuJzCyt_MA0vWNbLCr6CbQnj0y8g@mail.gmail.com>
 <CAPDyKFr_M0NDH0gaunBpybnALOFfz4LpX4_JW2GCUxjwGzdZsg@mail.gmail.com>
 <CAKddAkC5CRX+ZTh=MgzPYU72SY13+AQYhknhV_CC+=XX9=DKyg@mail.gmail.com>
 <CAAhSdy1SDd=VUqDQA0T5n9LwHo=3uGzFq1dUcbDFcB3aBdaioA@mail.gmail.com>
 <CAAhSdy33DcNw+pbDRrR=hBH86kwvu3xZbomQby8XhRXcc-exqQ@mail.gmail.com>
 <CAKddAkBrP2iQBC+aY1Xw5pssBpiQZe4V-6ww5m8hbKP6V0jzLg@mail.gmail.com>
 <CAAhSdy12-_Hdb-WVrs8kyfCy_OQA0p27DS6TOV87dh9HODrU_Q@mail.gmail.com>
 <CAKddAkCQOvnci-bzKx1pBUJh5t1uPT-wNXGH1WyqDyb5qR_Scg@mail.gmail.com> <CAK9=C2V2xYwi4wK2+e=z7NF8Ph7+LxvWh4J4TmQrbVfSfpO-Ag@mail.gmail.com>
In-Reply-To: <CAK9=C2V2xYwi4wK2+e=z7NF8Ph7+LxvWh4J4TmQrbVfSfpO-Ag@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 24 May 2024 12:41:03 +0200
Message-ID: <CAPDyKFo6PiWmwtHTfRCWK95RgQShfuR+G2cZm0D1Ad-at_MWmg@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: riscv-sbi: Add cluster_pm_enter()/exit()
To: Anup Patel <apatel@ventanamicro.com>, Nick Hu <nick.hu@sifive.com>
Cc: Anup Patel <anup@brainfault.org>, palmer@dabbelt.com, rafael@kernel.org, 
	daniel.lezcano@linaro.org, paul.walmsley@sifive.com, linux-pm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	zong.li@sifive.com, Cyan Yang <cyan.yang@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 17 May 2024 at 06:39, Anup Patel <apatel@ventanamicro.com> wrote:
>
> On Thu, May 16, 2024 at 9:40=E2=80=AFAM Nick Hu <nick.hu@sifive.com> wrot=
e:
> >
> > Hi Anup
> >
> > On Wed, May 15, 2024 at 9:46=E2=80=AFPM Anup Patel <anup@brainfault.org=
> wrote:
> > >
> > > Hi Nick,
> > >
> > > On Wed, May 15, 2024 at 5:45=E2=80=AFPM Nick Hu <nick.hu@sifive.com> =
wrote:
> > > >
> > > > Hi Anup,
> > > >
> > > > Thank you for your guidance.
> > > > After enabling the debug message, we found a way to solve the probl=
em
> > > > by the following steps:
> > > > 1. Add a compatible string in 'power-domains' node otherwise it won=
't
> > > > be the supplier of the consumers. (See of_link_to_phandle())
> > >
> > > Hmm, requiring a compatible string is odd. Where should we document
> > > this compatible string ?
> > >
> > Sorry, this is my fault. I didn't include some updates in
> > of_link_to_phandle(). This led some misunderstandings here.
> > You are right, we don't need it.
> > The supplier will be linked to the CLUSTER_PD node.
> >
> > > > 2. Move the 'power-domains' node outside the 'cpus' node otherwise =
it
> > > > won't be added to the device hierarchy by device_add().
> > > > 3. Update the cpuidle-riscv-sbi driver to get the pds_node from
> > > > '/power-domains'.
> > >
> > > By adding a compatible string and moving the "power-domains" node
> > > outside, you are simply forcing the OF framework to populate devices.
> > >
> > > How about manually creating platform_device for each power-domain
> > > DT node using of_platform_device_create() in sbi_pd_init() ?
> > >
> > Thanks for the suggestion! We have test the solution and it could work.
> > We was wondering if it's feasible for us to relocate the
> > 'power-domains' node outside of the /cpus? The CLUSTER_PD might
> > encompass not only the CPUs but also other components within the
> > cluster.
>
> The cpuidle-riscv-sbi driver expects "power-domains" DT node
> under "/cpus" DT node because this driver only deals with power
> domains related to CPU cluster or CPU cache-hierarchy. It does
> make sense to define L2/L3 power domains under
> "/cpus/power-domain" since these are related to CPUs.
>
> Moving the CPU "power-domains" DT node directly under "/" or
> somewhere else would mean that it covers system-wide power
> domains which is not true.

I understand your point, but I am not convinced that the power-domains
need to belong to the "cpus" node. Ideally, the power-domain describes
the power-rail and the interface to manage the CPUs, this can surely
be described outside the "cpus" node - even if there are only CPUs
that are using it.

Moreover, moving forward, one should not be surprised if it turns out
that a platform has other devices than the CPUs, sharing the same
power-rail as the CPU cluster. At least, we have that for arm/psci
[1].

>
> I suggest we continue using "/cpus/power-domains" DT node
> only for power domains related to CPU clusters or CPU
> cache-hierarchy.
>
> For system wide power domains of SoC devices, we can either:
> 1) Use device power domains through the SBI MPXY extension
>     via different driver
> 2) Use a platform specific driver
>
> >
> > We also look at cpuidle_psci_domain driver and it seems Arm doesn't
> > create the devices for each subnode of psci domain.
> > Is there any reason that they don't need it?

We don't need it for arm as we have a separate node for PSCI and its
power-domains [2]. Moreover, we have a separate driver that manages
the power-domain (cpuidle-psci-domain).

[...]

[1] arch/arm64/boot/dts/qcom/sc7280.dtsi (search for "CLUSTER_PD")
[2] Documentation/devicetree/bindings/arm/psci.yaml

Kind regards
Uffe

