Return-Path: <linux-pm+bounces-19135-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4743B9EE892
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 15:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7145282A2B
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 14:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C8A558BB;
	Thu, 12 Dec 2024 14:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="SsxpPxyj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B9A8837;
	Thu, 12 Dec 2024 14:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734012968; cv=none; b=QYJvP6giwOWqSv0FwNT+pVB0xsxhkkuKdpaBXKp9vvr71SjkSTXKn59bxBDIoQb9g7TICsuW1w4MzsoJwr3ViwmJfcDuIleCQNdubsbntT1oXiZ7W1i/K7BLQl1oTBX6Enm33wIqZRJW3cPRw2Onv2JwJu6LrjHBGhlWD5r/0xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734012968; c=relaxed/simple;
	bh=088IuPWRDgUJCH0ISxjtKh5CPwEuOvZyXEosCcA4Rag=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WS/8Ba08ItP5BFGqI2wVcir9oxYI4AtYsWSplEi5xj6HcSB+9BpqkOCYkG4xfW3RKg/DsQG12q7J6BId6TR1+RdXpTvrTnwPKc4fBRpMNaYbf8FrhFj8HPQe3DTsL6JJRAGSz9izaX9ce3PI9LBCBAcTKI4h/jzshSQfyvgMdBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=SsxpPxyj; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id BF82B1F93C;
	Thu, 12 Dec 2024 15:10:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1734012608;
	bh=i4gRg92u7heNhpg6vOJodZ+D+uvY+K7mBytkbzc1ihE=; h=From:To:Subject;
	b=SsxpPxyjcrFcPL6GJbAWr7SkbjA2mgIgBDNV7DIZflXRkx+I7LMuOxUnUZalkOSB3
	 XZmQls6x+Wih8xfI0T+xNWN13TqjZ82S72idyiFNajWeU0R5YI74RVL5HSufnBz9Zl
	 jrz0iA26EcpACwydg1+T/okRaMJ45ETJq74ZsU3gjAKTo2+QnJsbB0BJUvqMpTrt2j
	 5/YwGAt1h+qlt2mCL/vRGs2H3fjZ/sHiQXb4wmhgj3KOgxB0ULyADVqFbO9/yW8Iuz
	 Jf4jmOcMJoRjtpvdYV1sSh6sam+Ub+SU+4te43N+Q6ko5IJYYfa0bl60+4fscPB9Sw
	 u/a5cVflb2osw==
Date: Thu, 12 Dec 2024 15:10:03 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: linux-pm@vger.kernel.org, imx@lists.linux.dev
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
	Marek Vasut <marex@denx.de>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>
Subject: imx8m-blk-ctrl: WARNING, no release() function
Message-ID: <20241212141003.GA44219@francesco-nb>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,
on v6.13-rc2 (PREEMPT_RT, if it matters), I have the following warning

[    4.615793] ------------[ cut here ]------------
[    4.615814] Device 'mediablk-mipi-csi2-1' does not have a release() function, it is broken and must be fixed. See Documentation/core-api/kobject.rst.
[    4.618977] WARNING: CPU: 1 PID: 11 at /drivers/base/core.c:2569 device_release+0x80/0x94
[    4.638974] Modules linked in: ecdh_generic ecc etnaviv(+) rfkill libaes samsung_dsim gpu_sched imx_sdma(+) governor_userspace imx_bus dwc3_imx8mp spi_nxp_fspi lontium_lt8912b ina2xx snd_soc_wm8904 ti_ads1015 industrialio_triggered_buffer kfifo_buf lm75 snvs_pwrkey pwm_imx27 nvmem_snvs_lpgpr imx8mm_thermal caam flexcan error can_dev spi_imx usb_conn_gpio display_connector roles gpio_keys fuse ipv6 autofs4
[    4.639073] CPU: 1 UID: 0 PID: 11 Comm: kworker/u16:0 Not tainted 6.13.0-rc2-0.0.0-devel-00040-ga1625b19385c #1
[    4.639082] Hardware name: Toradex Verdin iMX8M Plus WB on Dahlia Board (DT)
[    4.639087] Workqueue: events_unbound deferred_probe_work_func
[    4.639099] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    4.639107] pc : device_release+0x80/0x94
[    4.639116] lr : device_release+0x80/0x94
[    4.639122] sp : ffff80008142b910
[    4.639125] x29: ffff80008142b910 x28: 00000000fffffdfb x27: ffff000005c92180
[    4.639137] x26: ffff000000018028 x25: ffff000000046dc0 x24: ffff800080c43710
[    4.639147] x23: 0000000100000001 x22: 0000000000000000 x21: ffff800080e43750
[    4.639158] x20: 0000000000000000 x19: ffff000007cb06d8 x18: 0000000000000006
[    4.639168] x17: 0000000000000001 x16: 0000000000000000 x15: 0000000000000002
[    4.639179] x14: 0000000000001400 x13: ffff0000000a9110 x12: 0000000000225510
[    4.639190] x11: 0000000000000000 x10: 00000000000009c0 x9 : ffff80008142b790
[    4.639200] x8 : ffff00000013bba0 x7 : 000000000000002d x6 : 000000000113158e
[    4.639210] x5 : 00000001134e0800 x4 : 0000000000000002 x3 : ffff000003b04c50
[    4.639221] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff00000013b180
[    4.639231] Call trace:
[    4.639235]  device_release+0x80/0x94 (P)
[    4.639245]  device_release+0x80/0x94 (L)
[    4.639253]  kobject_put+0xb0/0x214
[    4.639264]  put_device+0x14/0x24
[    4.639272]  genpd_remove+0x114/0x248
[    4.639281]  pm_genpd_remove+0x30/0x58
[    4.639288]  imx8m_blk_ctrl_probe+0x36c/0x540
[    4.639299]  platform_probe+0x68/0xdc
[    4.639308]  really_probe+0xc0/0x39c
[    4.639315]  __driver_probe_device+0x7c/0x14c
[    4.639322]  driver_probe_device+0x3c/0x120
[    4.639329]  __device_attach_driver+0xbc/0x160
[    4.639336]  bus_for_each_drv+0x88/0xe8
[    4.639346]  __device_attach+0xa0/0x1b4
[    4.639353]  device_initial_probe+0x14/0x20
[    4.639360]  bus_probe_device+0xb0/0xbc
[    4.639366]  deferred_probe_work_func+0xa0/0xf0
[    4.639373]  process_one_work+0x148/0x284
[    4.639383]  worker_thread+0x2d0/0x3e4
[    4.639391]  kthread+0x110/0x114
[    4.639399]  ret_from_fork+0x10/0x20
[    4.639409] ---[ end trace 0000000000000000 ]---

and more for other devices, from the same driver.

Just reporting for the moment, in case someone has some ideas or wants to
have a look.

Francesco


