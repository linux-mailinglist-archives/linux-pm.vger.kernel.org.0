Return-Path: <linux-pm+bounces-14054-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D03D975C75
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 23:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D28F9285E08
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 21:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5D6155759;
	Wed, 11 Sep 2024 21:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nUmWm1bv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6194D2EAE5
	for <linux-pm@vger.kernel.org>; Wed, 11 Sep 2024 21:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726090336; cv=none; b=pVZXZnZnGn4rpfLcoRMmp3QH0aU/UgZhCYS+4bq4W1iHndkO57PmsJjJev+R2g5c34NNBt184ssEX22Cu0gtbgay3hdFnZ8Vuy8+P1KxZH2V9HCQ9eqlcHVPq3SjTutvOZL8lCKbqS329fpYNTm9q3GGmJF+3yeRg9W0F/nPWlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726090336; c=relaxed/simple;
	bh=plORcOTuVEPJ+MsdfJHV1BfJY7x844i6ennLD+BS/Tw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dkEcPoG0Ub+xXUu4mWXtYoP1oYIRVR8ZPTJHOfsxgTLFYn7fTd356VyvMXS/qXruI+k0D+Uvui1frryPipoH7zirszrXXsp9O+1wdoAXYKs2Wao0M6J3TaWgCn6KnbjorualcRTiS6hV2ujNoAShcqMvek0cb3r9U5dBosuQ9I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nUmWm1bv; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6b41e02c255so12376657b3.3
        for <linux-pm@vger.kernel.org>; Wed, 11 Sep 2024 14:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726090334; x=1726695134; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G0tls9TSeYZiERk0YKTQyn2qIGVoqsjolT5VS8LI/f0=;
        b=nUmWm1bvwptiIt8nbBwLh4zPA9MX3ncI4rCNfpuP67JOqWNsDuzl3keMeSOJYdKP9J
         wSHjZIy3l1MHMIhBsYIoiSaiY/LhzRt4btQTIHX2rJ3Rv+ak7kxxMdS1SwQA0CI6M9h+
         o9/5sEGKVRxgj8ipPB6sXhEFML82KG43wr8MkWm1XbxqEmhGscOaMWmOAB3/OCNaDj4x
         +j4BhCjckJs+A5fL9NhIFtQTNKk/5AhhGEU0xOwTpN5/muiKB79g3i8sbWUmhzBqlrSO
         YP6+heRusn8Be/WTrGQmvNBXrBYvbIMHVQDyE+nR4UdpCSvBZLN+7B3EF+ErTsgxl6SL
         Dt7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726090334; x=1726695134;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G0tls9TSeYZiERk0YKTQyn2qIGVoqsjolT5VS8LI/f0=;
        b=hH0CeWm5QwpBrkjFqxCwSlu3aZHbKl9xxAdIU0LxL8GQDVinrKTAD+ZB5C8QsiP3mC
         95/WR582IP79xDGLCVVTMHgSgIhyFHca12PZWq1k6RS7TJKaZ6UEyEv0bKOH3UhhurjZ
         IDLno4zxE1d4aCUep+SfReANosNkeKHfV8tOJIbR6/nE6eHGfjcq7PMIxDlUkkUPLjd/
         nRbwFFBsbpL4NwrKURlnRCACdBoygW0pomJ8+ywAOC6xm0SuLdW0fqXtLMZX6NjmIl8g
         LSZ3k8cq+p+ZS5YtbUztHfOAN/Jn8lctw/ILUYukGhPDF6fQtE510Kja/8xERJTFytbX
         KNjQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/S3YFTAmtHAbLguGAAp1FaqCD/Qq725VQI3bqfjFBHRn/r9SGNY/MWgAcNc/B5MswW2khi5fYWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxgDS1/S4mWlH3WT2Io+dTFiglun/fNZJjkkhpodo3/1nUXY4a7
	0I8SUFx8a1zKexvv+d7PikZ0T8PUTOu36GVAPgC3Y9FXHaNdUCeMgHINbwjqS/3P1qIyrFVKKjO
	ayg==
X-Google-Smtp-Source: AGHT+IEy+FRcMZPJBM3QoM9Z+sg7QH9U7zKXbfsEXEPeme3vnncS+gSnDv69FtYTijg/Y2YEp+Ue2yOV1RA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:529:b0:e1d:96a7:c9b1 with SMTP id
 3f1490d57ef6-e1d9dc2cfd7mr1264276.6.1726090334323; Wed, 11 Sep 2024 14:32:14
 -0700 (PDT)
Date: Wed, 11 Sep 2024 14:32:12 -0700
In-Reply-To: <2E1344D0-E955-4E15-9766-73E3DAA73634@nutanix.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <DA40912C-CACC-4273-95B8-60AC67DFE317@nutanix.com>
 <Zt9IeD_15ZsFElIa@google.com> <2E1344D0-E955-4E15-9766-73E3DAA73634@nutanix.com>
Message-ID: <ZuIMXFVcjVUbf9j9@google.com>
Subject: Re: KVM: x86: __wait_lapic_expire silently using TPAUSE C0.2
From: Sean Christopherson <seanjc@google.com>
To: Jon Kohler <jon@nutanix.com>
Cc: "kvm @ vger . kernel . org" <kvm@vger.kernel.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, 
	"kyung.min.park@intel.com" <kyung.min.park@intel.com>, Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024, Jon Kohler wrote:
> How about something like this for the regular ol=E2=80=99 PAUSE route?
>=20
> Note: the ndelay side would likely be a bit more annoying to handle to in=
ternalize
> to KVM, but perhaps we could just have delay library return the amount of=
 cycles,
> and then do the loop I=E2=80=99ve got as a separate, KVM only func?
>=20
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -1627,16 +1627,39 @@ static bool lapic_timer_int_injected(struct kvm_v=
cpu *vcpu)
>  static inline void __wait_lapic_expire(struct kvm_vcpu *vcpu, u64 guest_=
cycles)
>  {
>         u64 timer_advance_ns =3D vcpu->arch.apic->lapic_timer.timer_advan=
ce_ns;
> +       u64 start, end, delay_by =3D 0;
> =20
>         /*
>          * If the guest TSC is running at a different ratio than the host=
, then
> -        * convert the delay to nanoseconds to achieve an accurate delay.=
  Note
> -        * that __delay() uses delay_tsc whenever the hardware has TSC, t=
hus
> -        * always for VMX enabled hardware.
> +        * convert the delay to nanoseconds to achieve an accurate delay.
> +        *
> +        * Note: open code delay function as KVM's use case is a bit spec=
ial, as
> +        * we know we need to reenter the guest at a specific time; howev=
er, the
> +        * delay library may introduce architectural delays that we do no=
t want,
> +        * such as using TPAUSE. Our mission is to simply get into the gu=
est as
> +        * soon as possible without violating architectural constraints.
> +        * RFC: Keep ndelay for help converting to nsec? or pull that in =
too?
>          */
>         if (vcpu->arch.tsc_scaling_ratio =3D=3D kvm_caps.default_tsc_scal=
ing_ratio) {
> -               __delay(min(guest_cycles,
> -                       nsec_to_cycles(vcpu, timer_advance_ns)));
> +               delay_by =3D min(guest_cycles,=20
> +                                          nsec_to_cycles(vcpu, timer_adv=
ance_ns));
> +
> +               if (delay_by =3D=3D 0) {
> +                       return;
> +               } else {
> +                       start =3D rdtsc();
> +
> +                       for (;;) {
> +                               cpu_relax();
> +                               end =3D rdtsc();
> +
> +                               if (delay_by <=3D end - start)
> +                                       break;
> +
> +                               delay_by -=3D end - start;
> +                               start =3D end;
> +                       }

I don't want to replicate __delay() in KVM.  If the delay is short, KVM sho=
uld
busy wait and intentionally NOT do PAUSE, i.e. not yield to the SMT sibling=
(s).
Because unlike most uses of PAUSE, this CPU isn't waiting on any resource e=
xcept
time itself.  E.g. there's no need to give a different CPU cycles so that t=
he
other CPU can finish a critical section.

And again, entering the guest so that the vCPU can service the IRQ is a pri=
ority,
e.g. see all of the ChromeOS work around paravirt scheduling to boost the p=
riority
of vCPUs that have pending IRQs.  Not to mention the physical CPU is runnin=
g with
IRQs disabled, i.e. if a _host_ IRQ becomes pending, then entering the gues=
t is a
priority in order to recognize that IRQ as well.

> +               }
>         } else {
>                 u64 delay_ns =3D guest_cycles * 1000000ULL;
>                 do_div(delay_ns, vcpu->arch.virtual_tsc_khz);

Whatever we do, we should do the same thing irrespective of whether or not =
TSC
scaling is in use.  I don't think we have an existing helper to unscale a g=
uest
TSC, but it shouldn't be hard to add (do math).

E.g. something like:

	delay_cycles =3D kvm_unscale_tsc(guest_cycles,
				       vcpu->arch.tsc_scaling_ratio);
	delay_cyles =3D min(guest_cycles, nsec_to_cycles(vcpu, timer_advance_ns));

	if (delay_cycles > N) {
		__delay(delay_cycles);
		return;
	}

	for (start =3D rdtsc(); rdtsc() - start < delay_cycles); )
		;

And then I also think we (handwavy "we") should do some profiling to ensure=
 KVM
isn't regularly waiting for more than N cycles, where N is probably somethi=
ng
like 200.  Because if KVM is regularly waiting for 200+ cycles, then we lik=
ely
need to re-tune the timer_advance_ns logic to be more conservative, i.e. er=
r more
on the side of the timer arriving slightly late so as not to waste CPU cycl=
es.

