Return-Path: <linux-pm+bounces-1808-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19991823A73
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jan 2024 03:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A529E288181
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jan 2024 02:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7908D5257;
	Thu,  4 Jan 2024 02:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uQ8BOyiO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02CD525E
	for <linux-pm@vger.kernel.org>; Thu,  4 Jan 2024 02:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5f2aab1c0c5so8258937b3.0
        for <linux-pm@vger.kernel.org>; Wed, 03 Jan 2024 18:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704333738; x=1704938538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZBDVHhfPXBsz1dl6LhzU57fMc54pKkm8OgQTIWPCiJY=;
        b=uQ8BOyiOrPTPmOP8NMcngaKAP8mFcCDJd7XQ9DMXsoyk9ViFtm8uOVFFKCNHyqVn+j
         c+Mn+BGByxWHCHXCmiLyi/KLIE0uO8FahbVT1XvfCxYcVciaI8uXx1oWR36fCfjmz85F
         Joes8l0aZxSeSI9j2QyYGIw7Jbf9R/jtxVzP4DZoxZmmjAodTWpKOrUgdUGulWxKJyTI
         Ak/R9tGS1/TsNbbz3ZiImBtZ+sP60Aj9LLZ7MSWZBr90ZRplUEgXu5cilwdDNyGzb17x
         ivvr9aVVfvqrMRWG38Ws5ap+ozrU/nd8d8c6vjXw96KTxQigwAPI8t7a/8IQNbGihUNT
         h/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704333738; x=1704938538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZBDVHhfPXBsz1dl6LhzU57fMc54pKkm8OgQTIWPCiJY=;
        b=YLzlxj7Q0GSF4ALyXlbSQkOxd1gDC1H2AH5SScueCoZtMI2ywCh1+5uT3dCgfJhgar
         cNx/+GfpXACuMtfPc8+eWUyoEzuMP0QfgsATZ2qncN2lZF516QrMF8ZgyhT1Vdsbqoti
         vyekC/lJLsdDijErz9rmkQRU5f7BUP3iywSoTv3YGdK33BjVZREQ5Z5Cos589Vo3yTn5
         ZnkXmHjy0dVFLMzRlVZ9GSxgMi8jaqB29V4aCd5xoVeXRkrPBOhN/p0B9ygXSr1emKWN
         f/ivNloQT6NHMFGVys/5jF0HbAzznbWg+ERV34q2N8CIVRf8nATgSefGcRSAZU23H6op
         HaAQ==
X-Gm-Message-State: AOJu0Yy8FKkJ2EZBRAK4KnwxnEVlgEJC1yGkdt9KkEREq+MUCWoNFpC0
	a50EABv4F3q7P+8cnfHFdjScTfn6VCXPrKSsQQDL2DYtlhzSCA==
X-Google-Smtp-Source: AGHT+IHQ6cXIsXzRc6XakmymCwoA7mv+zss2o4SvQ0KqdNTkZnHNCUPr3fyvzAazRLNXNEDo4i+YVf+M75DFe0sgi5g=
X-Received: by 2002:a0d:e854:0:b0:5d7:1940:3ef4 with SMTP id
 r81-20020a0de854000000b005d719403ef4mr1292274ywe.37.1704333737727; Wed, 03
 Jan 2024 18:02:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230827115033.935089-1-dmitry.baryshkov@linaro.org>
 <20230827115033.935089-9-dmitry.baryshkov@linaro.org> <20231011154935.GA785564-robh@kernel.org>
 <CAA8EJpqf4Q7wh657==C45Ka8YmmyopkCQnyEFcXkaoRwnCRZLQ@mail.gmail.com> <CAL_JsqKwWyoPdt3C0FdsgN087xK0jGyp3PVgiCaETZK9FX2JdQ@mail.gmail.com>
In-Reply-To: <CAL_JsqKwWyoPdt3C0FdsgN087xK0jGyp3PVgiCaETZK9FX2JdQ@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 4 Jan 2024 04:02:06 +0200
Message-ID: <CAA8EJpqNRrpcK50FRLcrSdyHFadU1=6yRqBOCFv=fnTBYJs9=g@mail.gmail.com>
Subject: Re: [PATCH v4 08/23] soc: qcom: Add driver for Qualcomm Krait L2
 cache scaling
To: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Ilia Lin <ilia.lin@kernel.org>, 
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Georgi Djakov <djakov@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, 
	Christian Marangi <ansuelsmth@gmail.com>, Stephan Gerhold <stephan@gerhold.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

HI Rob,

Resurrecting old thread, but I think it's better as it has context.

Added driver core maintainers, see discussion points below.

On Wed, 11 Oct 2023 at 21:44, Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Oct 11, 2023 at 1:20=E2=80=AFPM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On Wed, 11 Oct 2023 at 18:49, Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Sun, Aug 27, 2023 at 02:50:18PM +0300, Dmitry Baryshkov wrote:
> > > > Add a simple driver that handles scaling of L2 frequency and voltag=
es.
> > > >
> > > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > ---
> > >
> > > [...]
> > >
> > > > +static const struct of_device_id krait_l2_match_table[] =3D {
> > > > +     { .compatible =3D "qcom,krait-l2-cache" },
> > > > +     {}
> > > > +};
> > > > +MODULE_DEVICE_TABLE(of, krait_l2_match_table);
> > > > +
> > > > +static struct platform_driver krait_l2_driver =3D {
> > > > +     .probe =3D krait_l2_probe,
> > > > +     .remove =3D krait_l2_remove,
> > > > +     .driver =3D {
> > > > +             .name =3D "qcom-krait-l2",
> > > > +             .of_match_table =3D krait_l2_match_table,
> > > > +             .sync_state =3D icc_sync_state,
> > > > +     },
> > > > +};
> > >
> > > As I mentioned in the other thread, cache devices already have a stru=
ct
> > > device. Specifically, they have a struct device (no subclass) on the
> > > cpu_subsys bus type. So there should be no need for a platform device
> > > and second struct device.
> > >
> > > See drivers/acpi/processor_driver.c for an example. Or grep any use o=
f
> > > "cpu_subsys".
> >
> > Most likely you mean drivers/base/cacheinfo.c. I saw this code, I
> > don't think it makes a good fit here. The cacheinfo devices provide
> > information only, they are not tied to DT nodes in any way.
>
> They are completely tied to DT nodes beyond L1.
>
> >  cpu_subsys
> > doesn't provide a way to match drivers with subsys devices in the
> > non-ACPI case, etc.
>
> That's a 2 line addition to add DT support.
>
> > Moreover, the whole cacheinfo subsys is
> > non-existing on arm32, there is no cacheinfo implementation there,
> > thanks to the overall variety of architectures.
>
> Humm, well I don't think it would be too hard to add, but I won't ask
> you to do that. All the info comes from DT or can come from DT, so it
> should be just a matter of arm32 calling the cacheinfo init.
>
> > Thus said, I don't think cacheinfo makes a good fit for the case of
> > scaling L2 cache.
>
> I still disagree. It's not really cacheinfo. That is what creates the
> devices, but it's the cpu_subsys bus type. Why do you care that it is
> platform bus vs. cpu_subsys?

I finally found a timeslot to look at cacheinfo. I added support for
arm32 cacheinfo (which is fine) and tried using cacheinfo devices for
L2 driver mapping (the RFC has been posted at [1]).
But after I actually tried using it for the L2 cache driver.  I
stumbled upon several issues, which I'd like to discuss before rushing
to code.

First, you supposed that cacheinfo devices land onto the cpu_subsys
bus. However only actual CPU devices end up on cpu_subsys. CPU cache
devices are created using cpu_device_create(), but despite its name
they don't go to cpu_subsys.

Second and more important, these devices are created without any
attempt to share them. So on a 4-core system I have 4 distinct devices
for L2 cache even though it is shared between all cores.

root@qcom-armv7a:~# stat -c "%N %i" /sys/bus/cpu/devices/cpu*/cache/index2/=
level
/sys/bus/cpu/devices/cpu0/cache/index2/level 15537
/sys/bus/cpu/devices/cpu1/cache/index2/level 15560
/sys/bus/cpu/devices/cpu2/cache/index2/level 15583
/sys/bus/cpu/devices/cpu3/cache/index2/level 15606

I think it makes sense to rework cacheinfo to create actual CPU cache
devices (maybe having a separate cache bus).
In my case it should become something like:

cpu0-2-unified (shared between all 4 cores)
cpu0-1-icache
cpu0-1-dcache
cpu1-1-icache
cpu1-1-dcache
...

I'm not sure if it's worth supporting more than one instance of the
same kind per level (e.g. I think current cacheinfo has nothing
against having two I-cache or two D-cache devices)

The cpuN/cache/indexM should become symlinks to those cache devices.

What do you think?

[1] https://lore.kernel.org/linux-arm-msm/CAA8EJppCRzknaujKFyLa_i7x4UnX31YF=
Syjtux+zJ0harixrbA@mail.gmail.com

> On a separate issue, I'd propose you move this to drivers/cache/
> instead of the dumping ground that is drivers/soc/. It's nothing more
> than a location to collect cache related drivers ATM because we seem
> to be accumulating more of them.

I thought about reusing drivers/devfreq, it already has the Mediatek CCI dr=
iver.

--=20
With best wishes
Dmitry

