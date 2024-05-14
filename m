Return-Path: <linux-pm+bounces-7859-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6818C5D7E
	for <lists+linux-pm@lfdr.de>; Wed, 15 May 2024 00:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77401282B34
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 22:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98106181CF2;
	Tue, 14 May 2024 22:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkv8/6lO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB60181333;
	Tue, 14 May 2024 22:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715724516; cv=none; b=knr0KrPiEZPc4ohx4Bh+p2xBfLGwzS6vDkbhpedMjMppfBGfQwgWtbeFWjD/IGgxxHtbr8qZF0ifBg03gZgSz+6dTvUlsTSOPfb7h2HwVARmSewlRxDkhwh+IFC2iTHKxhU/gLkOefk6pURzcoOiREv03BPDRwOe7pRdyDD9/rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715724516; c=relaxed/simple;
	bh=3mV67Ormp7F5oiTt1MWDRh8eXDI7s+aKtl2sVrW4Khg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nk9WEVV4Q7KEUs1oqmQ1DR4Z0yUut6/JHz9cTSsGEHr2mK22Z0crgLOUwWQJpLNajzL75KaQiM7Ir/jNXjta7a/u2xVw7VaTHGEW2DgMbb6Oh67Xe2ePt9UrcMzHokA7oIO1P4kADsAzFbR/7qi3F79j8OYGyCDvHG6NN1xSxvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkv8/6lO; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5f415fd71f8so4756451a12.3;
        Tue, 14 May 2024 15:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715724513; x=1716329313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XuRLCp8VtYUQRATbO4IEMxwbmMHW0kcBJ0ksfK6yUzU=;
        b=dkv8/6lOyO5EZ2R/F42pVaioWyl+p+gpu+wXSkSo6vlunT4qJ8m34kYWytGM8sBqkV
         nuydT5sg7WjtMmlVadA6RAJztLacbs4//3gVPlUBu91iYi0g5dAUvTMD4ZzQe4fHGTXw
         7wiajhTK7behKt8+X4CoUKjbnP/Cp1R6ZhUgYG4RjZAWwHMJT0j6WIeua/63CxGOjAYL
         B4lt607BmwJCCZSZ85zKAZkZYO+kvbsxsPJW/g5OUBoMmbcE0hCCrL1YSlTF5c10Pg/y
         sOGPQur4WsjjL9sUJlkxsV80pqnysJY1fymkfA378teoFov22zBY+jWzXq6tKSFBJRu/
         sEvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715724513; x=1716329313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XuRLCp8VtYUQRATbO4IEMxwbmMHW0kcBJ0ksfK6yUzU=;
        b=OgTtTU6Rai534GIlF0yZWnCeNc1/EyJAUQJgezNHU6uOQ6Fi7BiFKsYUxbpGaKukLe
         e4YOxoOvM4xnaddWvSDhLFcI3oRI4IwnI3nxH5WfdjZOs2qwXRdmD84hBi7r46klNMKp
         V2Wp3+sOXJphIdK26txBmh/EZ1zIucDoOdhicR5fE3wzxKCQ3ubhQa1rSHJpKcYnQ1B9
         Q0j0ElLF1czpT5QVHAfV24RwbaSPjtAunPQYJRzs5K2K4MdlLL854pkRmN/7ZjaLR9EX
         jrHJImDov92bidhE1QbS/O86hXVz7fXQDHfiqHm8ql2ctDCNzTO2Uqx/kSZ+aTkSi+vw
         /PfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIdEiwMyUnVSxNOCHAP2LIaTVgG5lgknYe5VUVULPz2CCbMqbwu5EqZjO6C3P037kfAyfYzuV+PIUMiMnTBUScijj0IQ5NyBpGs6EvXQj+7ocTtxHMHZ5Qs/m8uLWGqHtXgwUAMJ8lLZHciHNZrHLjxMadO3TOhGQA70W/2Cfe3Hg=
X-Gm-Message-State: AOJu0Ywdu5XQuMVQbX4CzRGz7xOHCcQKI2EfwUPx4H3DwRPW9WaAaO+0
	wyQYU2OMqZQqFc9DDtRvP0N7s0Kn9mIHdViId2cjnVq2kOaoKwwb/pS4m6Q36k8pF4pW9n5wDHD
	cqaW+n1XssmNwTRtYXbmBVcteV3ejWw==
X-Google-Smtp-Source: AGHT+IFNb7Lyxt+AmA9hK0cAEPKXsq+F7bj3UYaUaS25Vr8EtpIoVNPce7DtM5S+0ADADXeItV979+3908GXTlM0xjw=
X-Received: by 2002:a17:90a:db54:b0:2b6:3034:4ae9 with SMTP id
 98e67ed59e1d1-2b6ccd6bceemr11216551a91.35.1715724512886; Tue, 14 May 2024
 15:08:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1715396125-3724-1-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1715396125-3724-1-git-send-email-shengjiu.wang@nxp.com>
From: Adam Ford <aford173@gmail.com>
Date: Tue, 14 May 2024 17:08:21 -0500
Message-ID: <CAHCN7xLoW2Nydhc3y-X1ieb7-UZTm=ap1O1eSLE31LawmfRZOg@mail.gmail.com>
Subject: Re: [PATCH v3] pmdomain: imx: gpcv2: Add delay after power up handshake
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: ulf.hansson@linaro.org, heiko@sntech.de, u.kleine-koenig@pengutronix.de, 
	geert+renesas@glider.be, rafael@kernel.org, linux-pm@vger.kernel.org, 
	abelvesa@kernel.org, peng.fan@nxp.com, mturquette@baylibre.com, 
	sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, imx@lists.linux.dev, 
	shengjiu.wang@gmail.com, frank.li@nxp.com, mkl@pengutronix.de, 
	linus.walleij@linaro.org, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 10:15=E2=80=AFPM Shengjiu Wang <shengjiu.wang@nxp.c=
om> wrote:
>
> AudioMix BLK-CTRL on i.MX8MP encountered an accessing register issue
> after power up.
>
> [    2.181035] Kernel panic - not syncing: Asynchronous SError Interrupt
> [    2.181038] CPU: 1 PID: 48 Comm: kworker/u16:2 Not tainted 6.9.0-rc5-n=
ext-20240424-00003-g21cec88845c6 #171
> [    2.181047] Hardware name: NXP i.MX8MPlus EVK board (DT)
> [    2.181050] Workqueue: events_unbound deferred_probe_work_func
> [    2.181064] Call trace:
> [...]
> [    2.181142]  arm64_serror_panic+0x6c/0x78
> [    2.181149]  do_serror+0x3c/0x70
> [    2.181157]  el1h_64_error_handler+0x30/0x48
> [    2.181164]  el1h_64_error+0x64/0x68
> [    2.181171]  clk_imx8mp_audiomix_runtime_resume+0x34/0x44
> [    2.181183]  __genpd_runtime_resume+0x30/0x80
> [    2.181195]  genpd_runtime_resume+0x110/0x244
> [    2.181205]  __rpm_callback+0x48/0x1d8
> [    2.181213]  rpm_callback+0x68/0x74
> [    2.181224]  rpm_resume+0x468/0x6c0
> [    2.181234]  __pm_runtime_resume+0x50/0x94
> [    2.181243]  pm_runtime_get_suppliers+0x60/0x8c
> [    2.181258]  __driver_probe_device+0x48/0x12c
> [    2.181268]  driver_probe_device+0xd8/0x15c
> [    2.181278]  __device_attach_driver+0xb8/0x134
> [    2.181290]  bus_for_each_drv+0x84/0xe0
> [    2.181302]  __device_attach+0x9c/0x188
> [    2.181312]  device_initial_probe+0x14/0x20
> [    2.181323]  bus_probe_device+0xac/0xb0
> [    2.181334]  deferred_probe_work_func+0x88/0xc0
> [    2.181344]  process_one_work+0x150/0x290
> [    2.181357]  worker_thread+0x2f8/0x408
> [    2.181370]  kthread+0x110/0x114
> [    2.181381]  ret_from_fork+0x10/0x20
> [    2.181391] SMP: stopping secondary CPUs
>

The imx8mp-beacon board suffers from this as well, and I can confirm
the patch also fixes it.  It might be a coincidence, but the etnaviv
NPU also enumerates more reliably now too.

adam

> According to comments in power up handshake:
>
>         /* request the ADB400 to power up */
>         if (domain->bits.hskreq) {
>                 regmap_update_bits(domain->regmap, domain->regs->hsk,
>                                    domain->bits.hskreq, domain->bits.hskr=
eq);
>
>                 /*
>                  * ret =3D regmap_read_poll_timeout(domain->regmap, domai=
n->regs->hsk, reg_val,
>                  *                                (reg_val & domain->bits=
.hskack), 0,
>                  *                                USEC_PER_MSEC);
>                  * Technically we need the commented code to wait handsha=
ke. But that needs
>                  * the BLK-CTL module BUS clk-en bit being set.
>                  *
>                  * There is a separate BLK-CTL module and we will have su=
ch a driver for it,
>                  * that driver will set the BUS clk-en bit and handshake =
will be triggered
>                  * automatically there. Just add a delay and suppose the =
handshake finish
>                  * after that.
>                  */
>         }
>
> The BLK-CTL module needs to add delay to wait for a handshake request fin=
ished.
> For some BLK-CTL module (eg. AudioMix on i.MX8MP) doesn't have BUS clk-en
> bit, it is better to add delay in this driver, as the BLK-CTL module does=
n't
> need to care about how it is powered up.
>
> regmap_read_bypassed() is to make sure the above write IO transaction alr=
eady
> reaches target before udelay().
>
> Fixes: 1496dd413b2e ("clk: imx: imx8mp: Add pm_runtime support for power =
saving")
> Reported-by: Francesco Dolcini <francesco@dolcini.it>
> Closes: https://lore.kernel.org/all/66293535.170a0220.21fe.a2e7@mx.google=
.com/
> Suggested-by: Frank Li <frank.li@nxp.com>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Tested-by:  Adam Ford <aford173@gmail.com>

> ---
> changes in v3:
> - move change to gpcv2.c, as it is more reasonable to let power driver
>   to handle such power issue, suggested by Frank Li
>
> changes in v2:
> - reduce size of panic log in commit message
>
>  drivers/pmdomain/imx/gpcv2.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/pmdomain/imx/gpcv2.c b/drivers/pmdomain/imx/gpcv2.c
> index 4b828d74a606..856eaac0ec14 100644
> --- a/drivers/pmdomain/imx/gpcv2.c
> +++ b/drivers/pmdomain/imx/gpcv2.c
> @@ -393,6 +393,17 @@ static int imx_pgc_power_up(struct generic_pm_domain=
 *genpd)
>                  * automatically there. Just add a delay and suppose the =
handshake finish
>                  * after that.
>                  */
> +
> +               /*
> +                * For some BLK-CTL module (eg. AudioMix on i.MX8MP) does=
n't have BUS
> +                * clk-en bit, it is better to add delay here, as the BLK=
-CTL module
> +                * doesn't need to care about how it is powered up.
> +                *
> +                * regmap_read_bypassed() is to make sure the above write=
 IO transaction
> +                * already reaches target before udelay()
> +                */
> +               regmap_read_bypassed(domain->regmap, domain->regs->hsk, &=
reg_val);
> +               udelay(5);
>         }
>
>         /* Disable reset clocks for all devices in the domain */
> --
> 2.34.1
>
>

