Return-Path: <linux-pm+bounces-7862-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FB88C60A3
	for <lists+linux-pm@lfdr.de>; Wed, 15 May 2024 08:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1849B20E6F
	for <lists+linux-pm@lfdr.de>; Wed, 15 May 2024 06:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4679C3A8E4;
	Wed, 15 May 2024 06:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="ivbAdywh";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="r4QALbQT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCF13B1AC;
	Wed, 15 May 2024 06:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715753576; cv=none; b=aDLKLJt3C7/jAyxqTUvDT6OEpPShqs9A/mlkSSfkxIqUpldBIMdJ5OdeGEBvJqMXt82xcbdmn2Yie8KKJYiMb3Bj12Ji6zZWaxmPe4pSAu9ChShQaJBZdC2k5154bn6jt/K2dkdx8DgUMmNE9oUcnuFknINI5/0XhmntFVCvtzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715753576; c=relaxed/simple;
	bh=ST1KBgIBdQUGMWs9K1MnA4oRBE3vKwC0vJ3GkqMiD2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TgbNxLt6hFCQ8CSjWXcm+L9ohFyq/Dtj2u3fCKUtENGhHt0/onvTI+ypgjx30HqcpJmSrwwf5g+niQ9Yqh+IJcASFzVS6lR3gxVpeCQ6nVAb0G3YfFbBYO41pckDg4vPpgenmu3/2BQXvzcCXgi0gEzuFYqwuhVLDhv0EJUYyMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=ivbAdywh; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=r4QALbQT reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1715753573; x=1747289573;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ni1BtX8uUfNH+eqIsiz5T/zzcUFH/m6Iqk/eL5FxXCw=;
  b=ivbAdywh4Flptes0Ou+Zo5Y77hJMfO5PoZ834GIYdP+FySiMW7N4MMBa
   AoATROi5xYlVXTRhO75re/r9MntiN5ej8wbEGMWAu3+0BbXbM/asE61dV
   x2dB63P+yG40UcBBFXkg9kHhAu2VkeE4JWWSj29fR8pekIjx577yFOtyL
   C3wIuLvp6Aw18B5Oip/9onqH2Jffwgt1cZCq/yBXvLRbWdmH2FTYtJ5X+
   WVNaik3OZhcpvXse3sJB+GfTLoAUDf5EhAOrtxfmzaJ6reBa5BICTRIvv
   ABVkLzVFzKtiFcOTGzMQKxTqZU4rg7gLq+K1HhqEX4Lzy/PCydmAZMqt6
   w==;
X-CSE-ConnectionGUID: sSsNmdUXTuqGs3G2OXkj4w==
X-CSE-MsgGUID: yzGRMvqBQUqlUMiIv32CiQ==
X-IronPort-AV: E=Sophos;i="6.08,160,1712613600"; 
   d="scan'208";a="36904601"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 15 May 2024 08:11:37 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2B3721712BF;
	Wed, 15 May 2024 08:11:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1715753493;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Ni1BtX8uUfNH+eqIsiz5T/zzcUFH/m6Iqk/eL5FxXCw=;
	b=r4QALbQTiUzJGjSHwsQrHvJLIVFxpJ/jBUeoqAx8k8n9WYRaSOx6shLe55Yc0+1Dr8R6tG
	VvTStgp8Vvsj0SgMHG+e+DlkOY+hUHUUEBZTZT9PYKBCgBiRU7vFEzCukZHJ+Bfb4wpQEf
	/4V2rVBb//cd+sTH6qela5tc6Erw0ertc3SfKYXJy4/MTOUCPnYmysw72xn0lRGCKOT3X7
	UexgKLtI3FMJSkIdJE8j6T43czpFD4ZLfVBxyIt4JQJiu7WTuH6XBBSA6cvpmf1c7dGIIS
	BYuDzbmPn1TdToS58RT1lrenH7Ccwi3qqRmTh30o8mFvYVI6QnleX5R08asptA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>, Adam Ford <aford173@gmail.com>
Cc: ulf.hansson@linaro.org, heiko@sntech.de, u.kleine-koenig@pengutronix.de, geert+renesas@glider.be, rafael@kernel.org, linux-pm@vger.kernel.org, abelvesa@kernel.org, peng.fan@nxp.com, mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, imx@lists.linux.dev, shengjiu.wang@gmail.com, frank.li@nxp.com, mkl@pengutronix.de, linus.walleij@linaro.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] pmdomain: imx: gpcv2: Add delay after power up handshake
Date: Wed, 15 May 2024 08:11:35 +0200
Message-ID: <9618306.DvuYhMxLoT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <CAHCN7xLoW2Nydhc3y-X1ieb7-UZTm=ap1O1eSLE31LawmfRZOg@mail.gmail.com>
References: <1715396125-3724-1-git-send-email-shengjiu.wang@nxp.com> <CAHCN7xLoW2Nydhc3y-X1ieb7-UZTm=ap1O1eSLE31LawmfRZOg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Last-TLS-Session-Version: TLSv1.3

Hi,

Am Mittwoch, 15. Mai 2024, 00:08:21 CEST schrieb Adam Ford:
> On Fri, May 10, 2024 at 10:15=E2=80=AFPM Shengjiu Wang <shengjiu.wang@nxp=
=2Ecom> wrote:
> >
> > AudioMix BLK-CTRL on i.MX8MP encountered an accessing register issue
> > after power up.
> >
> > [    2.181035] Kernel panic - not syncing: Asynchronous SError Interrupt
> > [    2.181038] CPU: 1 PID: 48 Comm: kworker/u16:2 Not tainted 6.9.0-rc5=
=2Dnext-20240424-00003-g21cec88845c6 #171
> > [    2.181047] Hardware name: NXP i.MX8MPlus EVK board (DT)
> > [    2.181050] Workqueue: events_unbound deferred_probe_work_func
> > [    2.181064] Call trace:
> > [...]
> > [    2.181142]  arm64_serror_panic+0x6c/0x78
> > [    2.181149]  do_serror+0x3c/0x70
> > [    2.181157]  el1h_64_error_handler+0x30/0x48
> > [    2.181164]  el1h_64_error+0x64/0x68
> > [    2.181171]  clk_imx8mp_audiomix_runtime_resume+0x34/0x44
> > [    2.181183]  __genpd_runtime_resume+0x30/0x80
> > [    2.181195]  genpd_runtime_resume+0x110/0x244
> > [    2.181205]  __rpm_callback+0x48/0x1d8
> > [    2.181213]  rpm_callback+0x68/0x74
> > [    2.181224]  rpm_resume+0x468/0x6c0
> > [    2.181234]  __pm_runtime_resume+0x50/0x94
> > [    2.181243]  pm_runtime_get_suppliers+0x60/0x8c
> > [    2.181258]  __driver_probe_device+0x48/0x12c
> > [    2.181268]  driver_probe_device+0xd8/0x15c
> > [    2.181278]  __device_attach_driver+0xb8/0x134
> > [    2.181290]  bus_for_each_drv+0x84/0xe0
> > [    2.181302]  __device_attach+0x9c/0x188
> > [    2.181312]  device_initial_probe+0x14/0x20
> > [    2.181323]  bus_probe_device+0xac/0xb0
> > [    2.181334]  deferred_probe_work_func+0x88/0xc0
> > [    2.181344]  process_one_work+0x150/0x290
> > [    2.181357]  worker_thread+0x2f8/0x408
> > [    2.181370]  kthread+0x110/0x114
> > [    2.181381]  ret_from_fork+0x10/0x20
> > [    2.181391] SMP: stopping secondary CPUs
> >
>=20
> The imx8mp-beacon board suffers from this as well, and I can confirm
> the patch also fixes it.  It might be a coincidence, but the etnaviv
> NPU also enumerates more reliably now too.

I had a similar local hack/workaround for NPU startup. This patch address
both issues.

Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
=2D-=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
http://www.tq-group.com/



