Return-Path: <linux-pm+bounces-15663-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B15499F285
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 18:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 857361F21E6C
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 16:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D43C1714BE;
	Tue, 15 Oct 2024 16:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehyht9Cw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED641CBA1C;
	Tue, 15 Oct 2024 16:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729008950; cv=none; b=J0Q7ddjRlLUm3hRBL7A5w4+ex7ko/j4hA13QwtxqlFUcyPJ9vwvAS8qVG7vP8IFgLCBVu6fs85fJDCuLEz9rFRwqCcigm2avkEwxOGfWHyORj8S+5ggwjflbRihVe8T1G9NaVJRHA8337jQKeyiQNJ5ZdR8yfqFpCO+nwFvq1/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729008950; c=relaxed/simple;
	bh=kdjCV/zlDMkDLT5nkeYtxpPFoddBt9IfkQ2VoTXNSYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hQeOInl5SK6LL1dh67fbsFdL2Hl6QHbj7p+8FrDDGP0Qxi4ysomq5YHdAdMBIdk0va3NGPvoklEEDEcUzxEzsvOJrsh3szALtpktA/YXJtULhBSf/G60J8+faTskWnu5mlM70syFZlNPPirmj7H+x+x2Z4PYJqe+DZlcnsDYG9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehyht9Cw; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20ce5e3b116so19679885ad.1;
        Tue, 15 Oct 2024 09:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729008948; x=1729613748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rlqq/4vbKLf6v4swjpMGIcHT9LNiP04l8Gv7VE6kNTA=;
        b=ehyht9CwgDpar5CnENBRi5TxypSD0VMNRV7WGUhWJP1jiYSSyyE3tnRJAyRUJA4l0z
         ncX8wAQVA1fK/zOuiiiHcn9liYzFTKhtxpXubTCNDLdfHZGLcn7X3EJYhAePe7/IJRWA
         LqHfYKc3svKkSbAshWX7ZZ6rMoaptkyvickskS+BVUuMNuDlDVKdLNpyB44/EzcUXbko
         TDCBpGIFhcO54GzwRTPvrKJ7L/zDAA+9Ag4DjE6DmweE4g2iZgguyeUXdx+puZ8Lhk4V
         W3gM5U/gR6CQchx6nVabQzX4hIkc6C80G24+k6+pFxaHsGQpVTkXwg4qpIVnoAP28LZU
         MhPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729008948; x=1729613748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rlqq/4vbKLf6v4swjpMGIcHT9LNiP04l8Gv7VE6kNTA=;
        b=GpOMu8SNdMhMaq6JLEjKBnCj8sFzVmYXZ7SPO70ELhzgD+uTdt7oc8bNZH9/nMPN0Y
         zztHlhCNijlsUhyGKpOSE5v4wvysb5h9fS3uvtuuyWcz51rdsw1vYkMdzqdjc5JiJZWR
         RdK4qGNQy77bA2gNIH2+OwXnRL0pGiprU61xeldQA1NQ0wEx/3F0jmRyyk3HfhLo44Vv
         OcyvRrHd9tvsVx4FlivG1zRMV1IINr1djGCxIdSAPY20LoeQTFYe8+QPwUCqarbidPrw
         Xc7i9x5atVuzdJ9ezCmCV5G61rpGXPMgza2qkN3gYI1C7HDcYglH8Sx3qJqOAKhxBblL
         GkbA==
X-Forwarded-Encrypted: i=1; AJvYcCW714V5ZuYYU6xqUlPdJOihqy2PJlV+aQMPN0XagHsR0LXl7o0mTGqxQVFtHzdMtYAqP7pfVILYYvjxmTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU/yJTh5jPiWC49iz624NX2xOtyz3hRQ0qPzraONYy/vx7sJk+
	U9EtbzGzKwrBNZMi3jb+dIE9b2FtWkRJminyOBdms0sH5CxRhgmup+b+kisoWKlzi66rO73G6pc
	BfISwpQugI4l0cK+i8dt9BSOekiM=
X-Google-Smtp-Source: AGHT+IEPGG5+mFO34p5rdrd/+YVHeAKJDQ9ahPqBaOQXBLoaZ7skSk0flYYFX5T11dbUVP8nkVSG/Tmgs3FQ2kACHXo=
X-Received: by 2002:a17:90a:eb13:b0:2e2:d3e9:eb33 with SMTP id
 98e67ed59e1d1-2e3152bd73bmr16960285a91.11.1729008948019; Tue, 15 Oct 2024
 09:15:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO6a-9_aPLCx2CqecQBGbK78_=+-tT44RepPkrBjpkWSvjj4Tg@mail.gmail.com>
 <CAO6a-9-Gd44qiM7obURXwd8hrarZQ_8BpdbQPWQojh+yhO4oRw@mail.gmail.com>
 <5055c0ce-00cb-4319-beac-650436d4ad15@arm.com> <CAO6a-99xVXE-XgnRWMCK5OPC3aYCvhJoGqEbxJOGGy8-yK7W8g@mail.gmail.com>
 <8421fc1b-3d92-4f54-944f-6a612e5741dc@arm.com>
In-Reply-To: <8421fc1b-3d92-4f54-944f-6a612e5741dc@arm.com>
From: Vivek yadav <linux.ninja23@gmail.com>
Date: Tue, 15 Oct 2024 21:45:36 +0530
Message-ID: <CAO6a-99bfA8+23cjg_x-9dBn_bEUsR5K9CS5D5L50YsgC3zavg@mail.gmail.com>
Subject: Re: Fwd: ARM64: CPUIdle driver is not select any Idle state other
 then WFI
To: Christian Loehle <christian.loehle@arm.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>, 
	"krzk@kernel.org" <krzk@kernel.org>, linux-newbie@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,
> My guess would be that state1 can't be entered, i.e.
> entered_state =3D target_state->enter(dev, drv, index);
> returns < 0, in that case the sysfs 'rejected' field
> will be incremented instead of usage and time.
> Is that the case for you?

Yes, I checked your guess was correct. ``enter_state`` value equals to Zero=
.

``#cat /sys/devices/system/cpu/cpu*/cpuidle/state*/rejected``
0 =3D=3D> state_0 CPU(0)
0 =3D=3D> state_1 CPU(0)
0 =3D=3D> state_0 rejected values CPU(1)
600117 =3D=3D> state_1 increasing values CPU(1)
0
854505
0
41756644

> In that case your psci description is probably wrong
> and doesn't match your system.

What do you mean by ``psci`` description ?

I have one node in the device  tree file.

psci {
     compatible =3D "arm,psci-1.0";
     method =3D "smc";
};

On Tue, Oct 15, 2024 at 3:12=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 10/14/24 16:49, Vivek yadav wrote:
> > * # Be careful, this email looks suspicious; * User Impersonation: The =
display name on this email is very similar to an internal user but was sent=
 from an email address not normally used by the person. *
> > Hi Christian,
> >
> >> What is the value of
> >> cat /sys/devices/system/cpu/cpu*/cpuidle/state*/usage?
> >
> > 0 =3D=3D=3D>CPU0 state0 (WFI)
> > 0 =3D=3D=3D>CPU0 state1 (cpu-retention)
> > 408 =3D=3D> these values are increasing
> > 0
> > 38
> > 0
> > 14
> > 0
> >
> >> What if you disable state0 on all CPUs?
> >> echo 1 > /sys/devices/system/cpu/cpu*/cpuidle/state0/disable
> >
> > After executing above command.  CPU Idle state WFI time stopped. But
> > no change in ``state1`` time.
> >
> > ``cat /sys/devices/system/cpu/cpu*/cpuidle/state*/time``
> >
> > OUTPUT:
> > 0 =3D=3D=3D>CPU0 state0 (WFI)
> > 0 =3D=3D=3D>CPU0 state1 (cpu-retention)
> >
> > increasing some time value(23968) =3D=3D=3D>CPU1 state0 (WFI)
> > 0 =3D=3D=3D>CPU1 state1 (cpu-retention)
> >
> > increasing some time value(17512) =3D=3D> now it also not increasing
> > 0
> >
> > increasing some time value(6661)
> > 0
> >
> > ``cat /sys/devices/system/cpu/cpu*/cpuidle/state*/usage``
> >
> > 0 =3D=3D=3D>CPU0 state0 (WFI)
> > 0 =3D=3D=3D>CPU0 state1 (cpu-retention)
> >
> > 408 =3D=3D> now these values also stop increasing
> > 0
> >
> > 42
> > 0
> >
> > 14
> > 0
>
> My guess would be that state1 can't be entered, i.e.
> entered_state =3D target_state->enter(dev, drv, index);
> returns < 0, in that case the sysfs 'rejected' field
> will be incremented instead of usage and time.
>
> Is that the case for you?
> In that case your psci description is probably wrong
> and doesn't match your system.
>
> Regards,
> Christian
>
>

