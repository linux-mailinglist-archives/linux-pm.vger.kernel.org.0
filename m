Return-Path: <linux-pm+bounces-15623-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D0599D3E6
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 17:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91C83285F37
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 15:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E151ADFFC;
	Mon, 14 Oct 2024 15:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJY9JEAU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05151ABEBF
	for <linux-pm@vger.kernel.org>; Mon, 14 Oct 2024 15:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728920981; cv=none; b=ujlKx1YkATsJ/4kW1Rvemsbsuko1R8c7oV/YhDnFPJDH5uIJ+jNFpCPCf+w7bpQ0MuHYOLwkOlylPoks0zaIod2Nk2Z0KY01AFZNMlmVo8iL2J3yk5J/uqaBhmJKtGiDYbPD9/8xsf8MBP27k3WjsyG+RGwrv5VzwT41bZfLBxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728920981; c=relaxed/simple;
	bh=6Rk+CsJHP/5bU2ebHLle484nqc5+6RIwkQCiFpPLr30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=loLo39bx1NAk2KHeNNCXGrz4ZtlB7AwyX4XxS2SprQeah/IkGrijMpuxm8zjPWN9auDPEWJUe7z3Juu0I8VEybp4+vjCHunkMhRN5mPAB7v0M+4IeBYRNvuFQy2Axh4sR2QGFwoAKKwR0clMk8blBJRp3qX9SoJGWdHtI6GOr6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJY9JEAU; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20cdb889222so12144255ad.3
        for <linux-pm@vger.kernel.org>; Mon, 14 Oct 2024 08:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728920979; x=1729525779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8vvi2k1+xPVR/+IFZrtVc9C6c+JYAf699k6QTmej64=;
        b=CJY9JEAUJ1OZ8Lvg0UslaH8uijDPLabqnNhUZ5hnmzR0x8ho5ZxkCJAHR7DqCN5XU1
         JNDjW8p4XbH3ZgRy7Nmz8UuyergToWwCKS29y6on6FibXClT3bxrPZqQjFjw1a/eKHtm
         8CPVBS2s9i0NToFzfApROzP5TUk0AvUzEFE9rNqFBg+9abna7a4i+rflQHY3KUin9d2B
         G+sqmSCHiIl/eUQ8FDrVvUqh9Lr9a+u6MdhcfWSfc4+MWIkMwzwHRAc3meoPDLZQoLly
         XSIyCkK+R3fHlgbi346uRs5TZ2RZKoqhKt/Dvnn6bUy7la8XCnt0gIsIA39iJjB4TfAz
         zKXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728920979; x=1729525779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w8vvi2k1+xPVR/+IFZrtVc9C6c+JYAf699k6QTmej64=;
        b=s3H8ShRlZdOYIs1dNfUnONGG23a1zP8DyVrVu69mPV0ygZ5/w/CqtRXDAxBWSP7DQR
         kuTx91YNz7o6laeB9VJx1CUFTcS3QDCDGkPmkDcu4bbD43uMjcVFjeVm/GQ6mPoYsQ8w
         4P8PalPTbOENYzGYUl+p6Woj9iTEdHQsyWawuDI9NN57CcZ+7pgbuPKb0wi66BRNjwvH
         qpYbfcFBCzp6cwANp4xGl4Y7VHQFnFkHphIkl+T8KhGWzgDwQB2/8JnoAP/e+qVcAa7C
         GSbebNmkY2IQoHOY/hLtohXFQ1YrZAl3xkHkv09T9L3dobyaSX7gWxMwqszANWOwVi9C
         IxIA==
X-Gm-Message-State: AOJu0YxkEMDkdGJi42fHK8Kcm3fuSkIk7oAAuRsI9cskRTRwSDdfM+au
	Sq0g5uN6vztwBQp8yxnTEVvMppGJLd/8DzUQA+hcaJBb8tdpZFsOghLDBMohPRzh4ImtNB9Gju4
	9Zy3M5fqng8RkaThqvtWP9Nq2X/4=
X-Google-Smtp-Source: AGHT+IF8vtIgUyG+0l7+fos81jwUrtPZe82Svsiss2TtgFzBld4+aevyJdhmzSNUNcnSLbcAnomQEi2tpiltZWurgW4=
X-Received: by 2002:a17:903:240e:b0:20b:7ec0:ee21 with SMTP id
 d9443c01a7336-20ca1434e12mr218909175ad.19.1728920979125; Mon, 14 Oct 2024
 08:49:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO6a-9_aPLCx2CqecQBGbK78_=+-tT44RepPkrBjpkWSvjj4Tg@mail.gmail.com>
 <CAO6a-9-Gd44qiM7obURXwd8hrarZQ_8BpdbQPWQojh+yhO4oRw@mail.gmail.com> <5055c0ce-00cb-4319-beac-650436d4ad15@arm.com>
In-Reply-To: <5055c0ce-00cb-4319-beac-650436d4ad15@arm.com>
From: Vivek yadav <linux.ninja23@gmail.com>
Date: Mon, 14 Oct 2024 21:19:27 +0530
Message-ID: <CAO6a-99xVXE-XgnRWMCK5OPC3aYCvhJoGqEbxJOGGy8-yK7W8g@mail.gmail.com>
Subject: Re: Fwd: ARM64: CPUIdle driver is not select any Idle state other
 then WFI
To: Christian Loehle <christian.loehle@arm.com>
Cc: linux-pm@vger.kernel.org, linux-newbie@vger.kerne, 
	daniel.lezcano@linaro.org, lpieralisi@kernel.org, krzk@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

> What is the value of
> cat /sys/devices/system/cpu/cpu*/cpuidle/state*/usage?

0 =3D=3D=3D>CPU0 state0 (WFI)
0 =3D=3D=3D>CPU0 state1 (cpu-retention)
408 =3D=3D> these values are increasing
0
38
0
14
0

> What if you disable state0 on all CPUs?
> echo 1 > /sys/devices/system/cpu/cpu*/cpuidle/state0/disable

After executing above command.  CPU Idle state WFI time stopped. But
no change in ``state1`` time.

``cat /sys/devices/system/cpu/cpu*/cpuidle/state*/time``

OUTPUT:
0 =3D=3D=3D>CPU0 state0 (WFI)
0 =3D=3D=3D>CPU0 state1 (cpu-retention)

increasing some time value(23968) =3D=3D=3D>CPU1 state0 (WFI)
0 =3D=3D=3D>CPU1 state1 (cpu-retention)

increasing some time value(17512) =3D=3D> now it also not increasing
0

increasing some time value(6661)
0

``cat /sys/devices/system/cpu/cpu*/cpuidle/state*/usage``

0 =3D=3D=3D>CPU0 state0 (WFI)
0 =3D=3D=3D>CPU0 state1 (cpu-retention)

408 =3D=3D> now these values also stop increasing
0

42
0

14
0

Regards
Vivek





Regards
Vivek

On Mon, Oct 14, 2024 at 6:24=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 10/14/24 11:28, Vivek yadav wrote:
> > ---------- Forwarded message ---------
> > From: Vivek yadav <linux.ninja23@gmail.com>
> > Date: Fri, Oct 11, 2024 at 3:14=E2=80=AFPM
> > Subject: ARM64: CPUIdle driver is not select any Idle state other then =
WFI
> > To: <linux-pm@vger.kernel.org>
> >
> >
> > Hi @all,
> >
> > I am working on one custom SoC. Where I add one CPUIdle state for
> > ``arm,cortex-a55`` processor.
> >
> > idle-states {
> >       entry-method =3D "psci";
> >        cpu_ret_l: cpu-retention-l {
> >          compatible =3D "arm,idle-state";
> >          arm,psci-suspend-param =3D <0x00010001>;
> >          local-timer-stop;
> >          entry-latency-us =3D <55>;
> >           exit-latency-us =3D <140>;
> >           min-residency-us =3D <780>;
> >     };
> > };
> >
> > I am using ``Menu governor`` with the ``psci_idle driver`` in its origi=
nal form.
> > After booting Linux I find out that the CPUIdle core is never going
> > inside the ``cpu-retention`` state.
> > To check time spent by CPU in any state. I am using the below command.
> >
> > ``cat /sys/devices/system/cpu/cpu*/cpuidle/state*/time``
> >
> > OUTPUT:
> > 0 =3D=3D=3D>CPU0 state0 (WFI)
> > 0 =3D=3D=3D>CPU0 state1 (cpu-retention)
> >
> > increasing some time value =3D=3D=3D>CPU1 state0 (WFI)
> > 0 =3D=3D=3D>CPU1 state1 (cpu-retention)
> >
> > increasing some time value
> > 0
> >
> > increasing some time value
> > 0
> >
> > What am I doing wrong? Why does ``cpu-retention`` state time not increa=
se?
> > Any pointer will be helpful.
>
> What is the value of
> cat /sys/devices/system/cpu/cpu*/cpuidle/state*/usage
> ?
> Does state1 usage increase?
>
> What if you disable state0 on all CPUs?
> echo 1 > /sys/devices/system/cpu/cpu*/cpuidle/state0/disable

