Return-Path: <linux-pm+bounces-7800-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B60E8C4F0D
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 12:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCEB41F212A3
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 10:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D191386C8;
	Tue, 14 May 2024 09:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="gLhPoCXh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350A21386B5
	for <linux-pm@vger.kernel.org>; Tue, 14 May 2024 09:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715680249; cv=none; b=btxhCvgvV1jCvUz48nH7OHdW+Oh/3VORgr23iDsDfbzeU8AgBhJfrwHJtWNTKf610F00gfyUuk3iRh2sxuQ9bFbipucIe64Y1ZjpU0/vzXjCGa535/OY44vgE10sedzHA9oi9rYSl50eNeYXIiCaP278JG4L//ku53oclqs9N34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715680249; c=relaxed/simple;
	bh=TCkx6SaxQ1bT0hwpMFkeJTA63KBdnOB9RyvhqZLO2qY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dDDgHPtZkpqUYoMdbgVJtWJ05qn9cdgY80nmdaOVOd0+TkEp43pdOr9tHLLUQCRjDWztElNrJzKnZXZq3/qlR70iJ/XXA/x4zlthFwNKwxlmTrgTAYi2R2MfbAwzKJb/A/d9RUJ9X/y67igJCmm46IBOCcrK+19WL9Qv3mD+9xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=gLhPoCXh; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3c997f50805so1921941b6e.0
        for <linux-pm@vger.kernel.org>; Tue, 14 May 2024 02:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1715680246; x=1716285046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wKHm6XT5EYm6vl/df7llbv2ZznYvQVbeTCwxvcThXU=;
        b=gLhPoCXh74TKJF46R2uNADuVzoDDobTXPFvICkjTqHemUIlkrZ04pow8cDTLxFzrQ/
         Zn4r745jQulc6tYvCPUPT8v8wLl3yfER42aEcM98c+4+QmDtREUELOPLU17r+WZn8r7x
         qRn9Wv/1I4NzNix4Lu4twgRBUKjxIpdfj/Sb/7xFncQR0I5X2HHOtraWaL547peP+a0R
         O3/sq35ubxHeQ4ymEIZ1mA7Xoh5ZmXyc0PhB706rWN20bZUZ2ZmAJ+nRUGnLfpzSXbUW
         jWPaDfOHRNRIsDtXuTmlBErsrolx2O9EqqpwpWf9FWrkP1UJytUhFuOMbD5k1houMCxf
         rhKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715680246; x=1716285046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0wKHm6XT5EYm6vl/df7llbv2ZznYvQVbeTCwxvcThXU=;
        b=vMA6ASg9uboGEVwWgRcRj9HxSe4Me/oySkh1qDlgZH2iLUzZn/NLywoOr7corlHTWU
         dB+QFH+LTPVaq6wnlhvVAwt1trw+wV3gA7yfL/YKv25ODpjL5gupwmsklEmqyG7PBcRq
         pXqP9tOL+YU0FU33ni9P0i41hnx27fHdkFY7HtId9OMFQHvG86fKXRyBpPshWYHJat2D
         ujprepz2okiXGZ9/06jPtCffTx2F8Uyoo5QEqMTe/IQGcEN2UDasVuoNZz9+gDMIe4ix
         ccNqDeBQO5BZEVb40/e+QK1LjAIlfIqxh434CPUu+QV+JMF4Na4sGGLSerG6gAcl3wdV
         ao0A==
X-Forwarded-Encrypted: i=1; AJvYcCXu61zMrJv9rclFcyXD6GNtppyge+LHAXNhyO5GsTbiqRmKf6vD8rbCBv+/qcBMlbI9kYOWgtUlK2sKFI5z9pvbhcvFVCc0lBY=
X-Gm-Message-State: AOJu0Yy6vBYmNVkBkCygouK5x794YGVtsv5qK5CGi5SnRExxZ9FI56Uo
	nx8ybHDbjMnDkNaogqhKTIuQvzQRd/0wGORZ2M1Qx7qeQt9gCHjXm1zuyq1UCXS4XMMBAgnII0p
	4DguTdkiD3EcAzVLyMXRjFpnDnEQEYMBYHe9wVg==
X-Google-Smtp-Source: AGHT+IFZlGka49AMpZnqeQG/0/xoWz38eoC8WUNBIFRNqyMEzju7A9//UVdvie1NQ5rKtQlwZbm11YMHm3N4CSBDIj8=
X-Received: by 2002:a05:6808:3099:b0:3c7:21b4:6e1 with SMTP id
 5614622812f47-3c996c688b8mr6596851b6e.2.1715680244711; Tue, 14 May 2024
 02:50:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226065113.1690534-1-nick.hu@sifive.com> <CAPDyKFph3WsZMmALnzBQKE4S_80Ji5h386Wi0vHda37QUsjMtg@mail.gmail.com>
 <CAKddAkDcdaXKzpcKN=LCCx9S4Trv+joLX2s=nyhzaRtM5HorqA@mail.gmail.com>
 <CAKddAkC6N=Cfo0z+F8herKTuJzCyt_MA0vWNbLCr6CbQnj0y8g@mail.gmail.com> <CAPDyKFr_M0NDH0gaunBpybnALOFfz4LpX4_JW2GCUxjwGzdZsg@mail.gmail.com>
In-Reply-To: <CAPDyKFr_M0NDH0gaunBpybnALOFfz4LpX4_JW2GCUxjwGzdZsg@mail.gmail.com>
From: Nick Hu <nick.hu@sifive.com>
Date: Tue, 14 May 2024 17:50:34 +0800
Message-ID: <CAKddAkC5CRX+ZTh=MgzPYU72SY13+AQYhknhV_CC+=XX9=DKyg@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: riscv-sbi: Add cluster_pm_enter()/exit()
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: palmer@dabbelt.com, anup@brainfault.org, rafael@kernel.org, 
	daniel.lezcano@linaro.org, paul.walmsley@sifive.com, linux-pm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	zong.li@sifive.com, Cyan Yang <cyan.yang@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ulf,

Thank you for your valuable suggestion.
I sincerely apologize for the delay in responding to your message. We
have diligently worked on experimenting with the suggestion you
provided.

As per your recommendation, we have incorporated the "power-domains=3D<>
property" into the consumer's node, resulting in modifications to the
DTS as illustrated below:

cpus {
    ...
     domain-idle-states {
           CLUSTER_SLEEP:cluster-sleep {
                        compatible =3D "domain-idle-state";
                        ...
            }
     }
     power-domains {
            ...
            ...
            CLUSTER_PD: clusterpd {
                    domain-idle-states =3D <&CLUSTER_SLEEP>;
            };
     }
}
soc {
      deviceA@xxx{
             ...
             power-domains =3D <&CLUSTER_PD>;
             ...
      }
}

However, this adjustment has led to an issue where the probe for
'deviceA' is deferred by 'device_links_check_suppliers()' within
'really_probe()'. In an attempt to mitigate this issue, we
experimented with a workaround by adding the attribute
"status=3D"disabled"" to the 'CLUSTER_PD' node. This action aimed to
prevent the creation of a device link between 'deviceA' and
'CLUSTER_PD'. Nevertheless, we remain uncertain about the
appropriateness of this solution.

Do you have suggestions on how to effectively address this issue?

Regards,
Nick

On Tue, Apr 30, 2024 at 4:13=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> On Mon, 29 Apr 2024 at 18:26, Nick Hu <nick.hu@sifive.com> wrote:
> >
> > On Tue, Apr 30, 2024 at 12:22=E2=80=AFAM Nick Hu <nick.hu@sifive.com> w=
rote:
> > >
> > > Hi Ulf
> > >
> > > On Mon, Apr 29, 2024 at 10:32=E2=80=AFPM Ulf Hansson <ulf.hansson@lin=
aro.org> wrote:
> > > >
> > > > On Mon, 26 Feb 2024 at 07:51, Nick Hu <nick.hu@sifive.com> wrote:
> > > > >
> > > > > When the cpus in the same cluster are all in the idle state, the =
kernel
> > > > > might put the cluster into a deeper low power state. Call the
> > > > > cluster_pm_enter() before entering the low power state and call t=
he
> > > > > cluster_pm_exit() after the cluster woken up.
> > > > >
> > > > > Signed-off-by: Nick Hu <nick.hu@sifive.com>
> > > >
> > > > I was not cced this patch, but noticed that this patch got queued u=
p
> > > > recently. Sorry for not noticing earlier.
> > > >
> > > > If not too late, can you please drop/revert it? We should really mo=
ve
> > > > away from the CPU cluster notifiers. See more information below.
> > > >
> > > > > ---
> > > > >  drivers/cpuidle/cpuidle-riscv-sbi.c | 24 ++++++++++++++++++++++-=
-
> > > > >  1 file changed, 22 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidl=
e/cpuidle-riscv-sbi.c
> > > > > index e8094fc92491..298dc76a00cf 100644
> > > > > --- a/drivers/cpuidle/cpuidle-riscv-sbi.c
> > > > > +++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
> > > > > @@ -394,6 +394,7 @@ static int sbi_cpuidle_pd_power_off(struct ge=
neric_pm_domain *pd)
> > > > >  {
> > > > >         struct genpd_power_state *state =3D &pd->states[pd->state=
_idx];
> > > > >         u32 *pd_state;
> > > > > +       int ret;
> > > > >
> > > > >         if (!state->data)
> > > > >                 return 0;
> > > > > @@ -401,6 +402,10 @@ static int sbi_cpuidle_pd_power_off(struct g=
eneric_pm_domain *pd)
> > > > >         if (!sbi_cpuidle_pd_allow_domain_state)
> > > > >                 return -EBUSY;
> > > > >
> > > > > +       ret =3D cpu_cluster_pm_enter();
> > > > > +       if (ret)
> > > > > +               return ret;
> > > >
> > > > Rather than using the CPU cluster notifiers, consumers of the genpd
> > > > can register themselves to receive genpd on/off notifiers.
> > > >
> > > > In other words, none of this should be needed, right?
> > > >
> > > Thanks for the feedback!
> > > Maybe I miss something, I'm wondering about a case like below:
> > > If we have a shared L2 cache controller inside the cpu cluster power
> > > domain and we add this controller to be a consumer of the power
> > > domain, Shouldn't the genpd invoke the domain idle only after the
> > > shared L2 cache controller is suspended?
> > > Is there a way that we can put the L2 cache down while all cpus in th=
e
> > > same cluster are idle?
> > > > [...]
> > Sorry, I made some mistake in my second question.
> > Update the question here:
> > Is there a way that we can save the L2 cache states while all cpus in t=
he
> > same cluster are idle and the cluster could be powered down?
>
> If the L2 cache is a consumer of the cluster, the consumer driver for
> the L2 cache should register for genpd on/off notifiers.
>
> The device representing the L2 cache needs to be enabled for runtime
> PM, to be taken into account correctly by the cluster genpd. In this
> case, the device should most likely remain runtime suspended, but
> instead rely on the genpd on/off notifiers to understand when
> save/restore of the cache states should be done.
>
> Kind regards
> Uffe

