Return-Path: <linux-pm+bounces-8104-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC29D8CE587
	for <lists+linux-pm@lfdr.de>; Fri, 24 May 2024 14:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA50BB2095A
	for <lists+linux-pm@lfdr.de>; Fri, 24 May 2024 12:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C2786628;
	Fri, 24 May 2024 12:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="u+FkYJZ+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6F53BBDE
	for <linux-pm@vger.kernel.org>; Fri, 24 May 2024 12:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716555274; cv=none; b=jH96yu9+Tr0ICCYQUD73zqeUOjnjr1ojR7xtggyiBF0jiEtZfWPlLiD8jLf25yJc0/8ry/jsrJMukIUReBc4SAM65ThAqnBdDXJvGCRocMnXt0aDmEcvCDVdFDjPGGT7p3OLCTVoqFd9/zsK+LoMj673Eunfay3VkbHsrfpcIrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716555274; c=relaxed/simple;
	bh=2Q87jTyD/yahS92t5urdkFnj9lWgA8pkg+6R0zo54pM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XSfUfZVMNasjtQoZlgXOrJqZgGw4eubw1bw4PJCErXM6Q6k/DVIMaqETkFyPF1lFfv9r25qXvr6+ps2AVS8sfN+3I4qtDd3PYWmzIsupXb13n2bgp8uFH6J4WULR3kReIKDpjrHOAdVDuO8mVhYdi+8PHEve+aH0hi8nxiSWbNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=u+FkYJZ+; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-36ddf683ad7so23754605ab.2
        for <linux-pm@vger.kernel.org>; Fri, 24 May 2024 05:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1716555272; x=1717160072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MxmDLiLsd5ua2H7Oam6e1zqnDQkQ25mJBA16oWnpxYY=;
        b=u+FkYJZ+VJyMo2mGe63D+Dp/95+eDIx/MnSo623ZuYzp8yzHNbzGjTt730HJYfRIln
         zHeNSLvLpgL+zaCFzTswgHStVvyP4goL6BSS9s0H29t8oCR2BqKEQIgUiqiZ9EdZrhVK
         +gM3xNR0JYKsubmaxrNWK7nxAei9amlxZQs5t+47XXVBMXy0oKKYhed/mWVoeX3PIY8A
         6YcUGC19YbNjigXAGhGy7gHFjsDi4cvgPg3WHcvRCsQGpYeRhbHRvgnNtUoOGT1OUc+A
         gMcz+MByevlTbxxdw28feWsCF6Mha86G/izo3GWrM7TLbOaFPlGnt6m8KBOXUABrY2hQ
         ihrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716555272; x=1717160072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MxmDLiLsd5ua2H7Oam6e1zqnDQkQ25mJBA16oWnpxYY=;
        b=Ci4Ta7WA/sMA4UaVmCzXbKLS42CWT+/V3rfUduhfviBFR+OfX+OhqlHksQGqE7unfC
         ojjo0C0XNbRC3Y8dTCjngNfM+Z4hEiYhqVIsiEhFlv1lZ6pOIwm3bbtSt+hNvAs8LbtF
         bDcMM6MiwZxvqkTjoa50lZe8ufJWfQhycR78ffqUq5t2AtFjV8U8bEzxsioDGNbkfGif
         vEHu0iapG6vPj2H38qUGUGOaZwJtoQW+LwX5RIhJBfPYn2/cUGSn0JRpZIi5+53Oi0cZ
         KKpvmJ8duY/LdfcaNPxUQ+UKE88SOrvRSirc4cY193+PXTnuDu/nr3rXT8piIfK9ZubV
         TY4w==
X-Forwarded-Encrypted: i=1; AJvYcCXrxdomUj38ph90wvZZU3C4OcCafv38na7wnn2KyndBl3ukahuZas3aKntIMGT3LPiD1ghQYezmLjOjm0/Ca6bVALpXN2ZoV5I=
X-Gm-Message-State: AOJu0YwEZi1FXIk1N/QVfWK8cmX33PjvYk80oMPZjcX20m7IhEnmRxnW
	NXSZvsE6xDa1gUczpNCb8/BqpV3MSo+QKdbm4+ukveVubSQmlhHq66aEQbGC/7Xy0QeLE0/Bl8B
	jd5GjudBtShJ85CKWgZvO+zWnHU6ntQYP4+2BDw==
X-Google-Smtp-Source: AGHT+IG706oHtTX6EHJGP+6O0ueOX8hKEYHRAtlMxjdpa5kaBBkruy70OydInrBDfoTThdPlUAB7QfD2yRnjk92tjac=
X-Received: by 2002:a05:6e02:1a09:b0:36b:2731:83ce with SMTP id
 e9e14a558f8ab-3737b2c5874mr24957655ab.8.1716555272176; Fri, 24 May 2024
 05:54:32 -0700 (PDT)
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
 <CAKddAkCQOvnci-bzKx1pBUJh5t1uPT-wNXGH1WyqDyb5qR_Scg@mail.gmail.com>
 <CAK9=C2V2xYwi4wK2+e=z7NF8Ph7+LxvWh4J4TmQrbVfSfpO-Ag@mail.gmail.com> <CAPDyKFo6PiWmwtHTfRCWK95RgQShfuR+G2cZm0D1Ad-at_MWmg@mail.gmail.com>
In-Reply-To: <CAPDyKFo6PiWmwtHTfRCWK95RgQShfuR+G2cZm0D1Ad-at_MWmg@mail.gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 24 May 2024 18:24:20 +0530
Message-ID: <CAAhSdy3VVbOjMZR_De3D6hC0XwgjwpRzxU=Xpf=OOULfTYOxOw@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: riscv-sbi: Add cluster_pm_enter()/exit()
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Anup Patel <apatel@ventanamicro.com>, Nick Hu <nick.hu@sifive.com>, palmer@dabbelt.com, 
	rafael@kernel.org, daniel.lezcano@linaro.org, paul.walmsley@sifive.com, 
	linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, zong.li@sifive.com, 
	Cyan Yang <cyan.yang@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 4:11=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> On Fri, 17 May 2024 at 06:39, Anup Patel <apatel@ventanamicro.com> wrote:
> >
> > On Thu, May 16, 2024 at 9:40=E2=80=AFAM Nick Hu <nick.hu@sifive.com> wr=
ote:
> > >
> > > Hi Anup
> > >
> > > On Wed, May 15, 2024 at 9:46=E2=80=AFPM Anup Patel <anup@brainfault.o=
rg> wrote:
> > > >
> > > > Hi Nick,
> > > >
> > > > On Wed, May 15, 2024 at 5:45=E2=80=AFPM Nick Hu <nick.hu@sifive.com=
> wrote:
> > > > >
> > > > > Hi Anup,
> > > > >
> > > > > Thank you for your guidance.
> > > > > After enabling the debug message, we found a way to solve the pro=
blem
> > > > > by the following steps:
> > > > > 1. Add a compatible string in 'power-domains' node otherwise it w=
on't
> > > > > be the supplier of the consumers. (See of_link_to_phandle())
> > > >
> > > > Hmm, requiring a compatible string is odd. Where should we document
> > > > this compatible string ?
> > > >
> > > Sorry, this is my fault. I didn't include some updates in
> > > of_link_to_phandle(). This led some misunderstandings here.
> > > You are right, we don't need it.
> > > The supplier will be linked to the CLUSTER_PD node.
> > >
> > > > > 2. Move the 'power-domains' node outside the 'cpus' node otherwis=
e it
> > > > > won't be added to the device hierarchy by device_add().
> > > > > 3. Update the cpuidle-riscv-sbi driver to get the pds_node from
> > > > > '/power-domains'.
> > > >
> > > > By adding a compatible string and moving the "power-domains" node
> > > > outside, you are simply forcing the OF framework to populate device=
s.
> > > >
> > > > How about manually creating platform_device for each power-domain
> > > > DT node using of_platform_device_create() in sbi_pd_init() ?
> > > >
> > > Thanks for the suggestion! We have test the solution and it could wor=
k.
> > > We was wondering if it's feasible for us to relocate the
> > > 'power-domains' node outside of the /cpus? The CLUSTER_PD might
> > > encompass not only the CPUs but also other components within the
> > > cluster.
> >
> > The cpuidle-riscv-sbi driver expects "power-domains" DT node
> > under "/cpus" DT node because this driver only deals with power
> > domains related to CPU cluster or CPU cache-hierarchy. It does
> > make sense to define L2/L3 power domains under
> > "/cpus/power-domain" since these are related to CPUs.
> >
> > Moving the CPU "power-domains" DT node directly under "/" or
> > somewhere else would mean that it covers system-wide power
> > domains which is not true.
>
> I understand your point, but I am not convinced that the power-domains
> need to belong to the "cpus" node. Ideally, the power-domain describes
> the power-rail and the interface to manage the CPUs, this can surely
> be described outside the "cpus" node - even if there are only CPUs
> that are using it.
>
> Moreover, moving forward, one should not be surprised if it turns out
> that a platform has other devices than the CPUs, sharing the same
> power-rail as the CPU cluster. At least, we have that for arm/psci
> [1].

For non-CPU power domains, we are working on a messaging
specification (RPMI) [1]. The supervisor software might have
direct access to a RPMI transport or it can send RPMI messages
via SBI MPXY extension [2].

If power-rails on a platform are shared between CPUs and
devices then the platform can:

1) Use SBI HSM for CPUs and use RPMI for devices. The
DT bindings for device power-domains based on RPMI are
still work-in-progress. If there are multiple supervisor domains
(aka system level partitions) created by SBI implementation or
some partitioning hypervisor then the RPMI messages can be
arbitraged by SBI implementation using SBI MPXY extension.
The SBI MPXY extension also allows sharing the same RPMI
transport between machine-mode (firmware) and supervisor-mode.

2) Use its own platform specific power-domain driver for both
CPUs and devices (basically don't use the SBI HSM and RPMI).
In this case, there won't be any controlled access (or arbitration)
of power rails across supervisor domains.

>
> >
> > I suggest we continue using "/cpus/power-domains" DT node
> > only for power domains related to CPU clusters or CPU
> > cache-hierarchy.
> >
> > For system wide power domains of SoC devices, we can either:
> > 1) Use device power domains through the SBI MPXY extension
> >     via different driver
> > 2) Use a platform specific driver
> >
> > >
> > > We also look at cpuidle_psci_domain driver and it seems Arm doesn't
> > > create the devices for each subnode of psci domain.
> > > Is there any reason that they don't need it?
>
> We don't need it for arm as we have a separate node for PSCI and its
> power-domains [2]. Moreover, we have a separate driver that manages
> the power-domain (cpuidle-psci-domain).

Unlike the ARM world, we don't have any DT node for SBI in
the RISC-V world because the SBI is always there. Due to this,
the SBI HSM CPU idle driver (this driver) currently looks for
CPU "power-domains" under "/cpus" DT node because the
SBI HSM extension only deals with CPU states.

>
> [...]
>
> [1] arch/arm64/boot/dts/qcom/sc7280.dtsi (search for "CLUSTER_PD")
> [2] Documentation/devicetree/bindings/arm/psci.yaml
>
> Kind regards
> Uffe

[1] https://github.com/riscv-non-isa/riscv-rpmi
[2] https://docs.google.com/document/d/1Ivej3u6uQgVdJHnjrbqgUwE1Juy75d4uYCj=
WrdNjeAg/edit?usp=3Dsharing

Best regards,
Anup

