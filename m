Return-Path: <linux-pm+bounces-2211-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7028382DD7C
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jan 2024 17:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA19C28393F
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jan 2024 16:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A573F17BB5;
	Mon, 15 Jan 2024 16:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GD+7GY2Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810B417BB1;
	Mon, 15 Jan 2024 16:17:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED86EC433B2;
	Mon, 15 Jan 2024 16:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705335420;
	bh=T+2sSv2X8aSMaN+ypn7mK/Rq48tUKizTpqsxeAp5JXg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GD+7GY2Y59G0AWjmxmyDueLlKdjD545OB41J37Fcw1V1AbXHiCPvMtkR8ZLBEk+bB
	 o6h6jxgbo4NPaxdPliQlTsqCLFu0z1zw395a8xiF9jQis/ezAcPv7aZ7Nv0g9U2UUz
	 NMFIKVdlIK1EP+dulIVzcKB8z3P233h8iHO5Xh/PiaycNVF17dAJJWbEB2cMaze/uH
	 4bjXRqIJK+NsTTl2B+WhLfTBqxEwPmpuIYpEMqDGu6rsMV1+lzXx4R5BdkJ6SSTxiu
	 XljzFVMlL2IWBqw175nqZ+3m12n+BxQUUkgO/tM1uk7XmhIFT5LpYQg+lyIwaZ2NiB
	 dhQr8W2Z7TSkQ==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2cd81b09e83so53699531fa.2;
        Mon, 15 Jan 2024 08:16:59 -0800 (PST)
X-Gm-Message-State: AOJu0YwOqh8yCg768VnykVmUXKvYDy4vIuBy9JtXyXfs5N2G+x7Nj8X3
	hFIinAF4m4yRENUFLWNYLD1FmjaAfLxf+OGiQg==
X-Google-Smtp-Source: AGHT+IF9uStzXLvMKSDmlonhF6vj8iuop2j6X3GFmK9wutfyiriS22etcNW5wavbcSbXH+5+Z1eNgdixUpHXm6YARF4=
X-Received: by 2002:a2e:9ec4:0:b0:2cd:418:a38 with SMTP id h4-20020a2e9ec4000000b002cd04180a38mr1221350ljk.136.1705335418126;
 Mon, 15 Jan 2024 08:16:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230827115033.935089-1-dmitry.baryshkov@linaro.org>
 <20230827115033.935089-9-dmitry.baryshkov@linaro.org> <20231011154935.GA785564-robh@kernel.org>
 <CAA8EJpqf4Q7wh657==C45Ka8YmmyopkCQnyEFcXkaoRwnCRZLQ@mail.gmail.com>
 <CAL_JsqKwWyoPdt3C0FdsgN087xK0jGyp3PVgiCaETZK9FX2JdQ@mail.gmail.com> <CAA8EJpqNRrpcK50FRLcrSdyHFadU1=6yRqBOCFv=fnTBYJs9=g@mail.gmail.com>
In-Reply-To: <CAA8EJpqNRrpcK50FRLcrSdyHFadU1=6yRqBOCFv=fnTBYJs9=g@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 15 Jan 2024 10:16:45 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJo_5qAocpU9UqkZqGMxCLQ+BT6SgSJh3uTJ+Rrcfo-ZA@mail.gmail.com>
Message-ID: <CAL_JsqJo_5qAocpU9UqkZqGMxCLQ+BT6SgSJh3uTJ+Rrcfo-ZA@mail.gmail.com>
Subject: Re: [PATCH v4 08/23] soc: qcom: Add driver for Qualcomm Krait L2
 cache scaling
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, 
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

On Wed, Jan 3, 2024 at 8:02=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> HI Rob,
>
> Resurrecting old thread, but I think it's better as it has context.
>
> Added driver core maintainers, see discussion points below.
>
> On Wed, 11 Oct 2023 at 21:44, Rob Herring <robh@kernel.org> wrote:
> >
> > On Wed, Oct 11, 2023 at 1:20=E2=80=AFPM Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> > >
> > > On Wed, 11 Oct 2023 at 18:49, Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > On Sun, Aug 27, 2023 at 02:50:18PM +0300, Dmitry Baryshkov wrote:
> > > > > Add a simple driver that handles scaling of L2 frequency and volt=
ages.
> > > > >
> > > > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > > ---
> > > >
> > > > [...]
> > > >
> > > > > +static const struct of_device_id krait_l2_match_table[] =3D {
> > > > > +     { .compatible =3D "qcom,krait-l2-cache" },
> > > > > +     {}
> > > > > +};
> > > > > +MODULE_DEVICE_TABLE(of, krait_l2_match_table);
> > > > > +
> > > > > +static struct platform_driver krait_l2_driver =3D {
> > > > > +     .probe =3D krait_l2_probe,
> > > > > +     .remove =3D krait_l2_remove,
> > > > > +     .driver =3D {
> > > > > +             .name =3D "qcom-krait-l2",
> > > > > +             .of_match_table =3D krait_l2_match_table,
> > > > > +             .sync_state =3D icc_sync_state,
> > > > > +     },
> > > > > +};
> > > >
> > > > As I mentioned in the other thread, cache devices already have a st=
ruct
> > > > device. Specifically, they have a struct device (no subclass) on th=
e
> > > > cpu_subsys bus type. So there should be no need for a platform devi=
ce
> > > > and second struct device.
> > > >
> > > > See drivers/acpi/processor_driver.c for an example. Or grep any use=
 of
> > > > "cpu_subsys".
> > >
> > > Most likely you mean drivers/base/cacheinfo.c. I saw this code, I
> > > don't think it makes a good fit here. The cacheinfo devices provide
> > > information only, they are not tied to DT nodes in any way.
> >
> > They are completely tied to DT nodes beyond L1.
> >
> > >  cpu_subsys
> > > doesn't provide a way to match drivers with subsys devices in the
> > > non-ACPI case, etc.
> >
> > That's a 2 line addition to add DT support.
> >
> > > Moreover, the whole cacheinfo subsys is
> > > non-existing on arm32, there is no cacheinfo implementation there,
> > > thanks to the overall variety of architectures.
> >
> > Humm, well I don't think it would be too hard to add, but I won't ask
> > you to do that. All the info comes from DT or can come from DT, so it
> > should be just a matter of arm32 calling the cacheinfo init.
> >
> > > Thus said, I don't think cacheinfo makes a good fit for the case of
> > > scaling L2 cache.
> >
> > I still disagree. It's not really cacheinfo. That is what creates the
> > devices, but it's the cpu_subsys bus type. Why do you care that it is
> > platform bus vs. cpu_subsys?
>
> I finally found a timeslot to look at cacheinfo. I added support for
> arm32 cacheinfo (which is fine) and tried using cacheinfo devices for
> L2 driver mapping (the RFC has been posted at [1]).
> But after I actually tried using it for the L2 cache driver.  I
> stumbled upon several issues, which I'd like to discuss before rushing
> to code.
>
> First, you supposed that cacheinfo devices land onto the cpu_subsys
> bus. However only actual CPU devices end up on cpu_subsys. CPU cache
> devices are created using cpu_device_create(), but despite its name
> they don't go to cpu_subsys.
>
> Second and more important, these devices are created without any
> attempt to share them. So on a 4-core system I have 4 distinct devices
> for L2 cache even though it is shared between all cores.

I wonder if that's because things are created in CPU hotplug callbacks
and there might be ordering problems if cache devices are created in
another code path.

Also, I think on some PowerPC systems, CPUs can move to different L2
(or L3?) caches when hot unplugged and then plugged. So hotplug
rescans everything. I don't think that would be a problem with this
and PowerPC does its own scanning anyways. Just wanted you to be aware
of the issue.

> root@qcom-armv7a:~# stat -c "%N %i" /sys/bus/cpu/devices/cpu*/cache/index=
2/level
> /sys/bus/cpu/devices/cpu0/cache/index2/level 15537
> /sys/bus/cpu/devices/cpu1/cache/index2/level 15560
> /sys/bus/cpu/devices/cpu2/cache/index2/level 15583
> /sys/bus/cpu/devices/cpu3/cache/index2/level 15606
>
> I think it makes sense to rework cacheinfo to create actual CPU cache
> devices (maybe having a separate cache bus).
> In my case it should become something like:
>
> cpu0-2-unified (shared between all 4 cores)
> cpu0-1-icache
> cpu0-1-dcache
> cpu1-1-icache
> cpu1-1-dcache
> ...
>
> I'm not sure if it's worth supporting more than one instance of the
> same kind per level (e.g. I think current cacheinfo has nothing
> against having two I-cache or two D-cache devices)

Probably a safe assumption. Though I think old XScale CPUs had a 1K
mini I-cache and the main L1 I-cache. I guess that's really an L0
cache though.

> The cpuN/cache/indexM should become symlinks to those cache devices.
>
> What do you think?

Seems like a good improvement to me if changing the current way
doesn't cause an ABI issue.


> [1] https://lore.kernel.org/linux-arm-msm/CAA8EJppCRzknaujKFyLa_i7x4UnX31=
YFSyjtux+zJ0harixrbA@mail.gmail.com
>
> > On a separate issue, I'd propose you move this to drivers/cache/
> > instead of the dumping ground that is drivers/soc/. It's nothing more
> > than a location to collect cache related drivers ATM because we seem
> > to be accumulating more of them.
>
> I thought about reusing drivers/devfreq, it already has the Mediatek CCI =
driver.

Anywhere except drivers/misc/ would be an improvement over
drivers/soc/. devfreq is more tied to interconnects than caches
though.

Rob

