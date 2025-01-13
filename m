Return-Path: <linux-pm+bounces-20298-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54383A0B13D
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 09:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BDC43A1259
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 08:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73D3233134;
	Mon, 13 Jan 2025 08:36:31 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3DB232366
	for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2025 08:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736757391; cv=none; b=DI76rbeIXATOSOOz1A2ByvSmWWJBHO5Ei6ybT3oA82FomXqv40ubbNlKM9z9jbbTd+SrhF9Mdu7yUpYWt6aIaIw47trR+T6TP0OA5NXz9uElYltaIFq3c4PsYmBid+EfFmOnNR9s4hh1+98rj++Y4UlZDl6riiQsWu1tfJarU7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736757391; c=relaxed/simple;
	bh=3e8WusOB57fYKu6J5ZEVwbCJZdPgpnWZb5Bpt1bpmBU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LBL0R2kPwMq/OTLU45cAIAdC/lzC3TRGn0jfc0C5AAy9wrhEBxpMEfrJaXZwpUC7WAOnFmOfN2ASzy8lfcrMuvuvdIBm5Jro0f5rDoWXHkFPWltJ6tsu0sqDsBbhaAzc7GXnHS5I5vmTtCwANOldgaE+9wyd0mU/5BbG0zxSGsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1tXFva-0004xj-W3; Mon, 13 Jan 2025 09:36:07 +0100
Message-ID: <1eddf262170a616eb0e154e909eee65432188ffd.camel@pengutronix.de>
Subject: Re: [PATCH] pmdomain: imx8mp-blk-ctrl: Add a missing judgment
From: Lucas Stach <l.stach@pengutronix.de>
To: Xiaolei Wang <xiaolei.wang@windriver.com>, ulf.hansson@linaro.org, 
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
 festevam@gmail.com, ping.bai@nxp.com, aford173@gmail.com, peng.fan@nxp.com,
  marex@denx.de
Cc: linux-pm@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Mon, 13 Jan 2025 09:36:05 +0100
In-Reply-To: <20250113045609.842243-1-xiaolei.wang@windriver.com>
References: <20250113045609.842243-1-xiaolei.wang@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

Hi Xiaolei,

Am Montag, dem 13.01.2025 um 12:56 +0800 schrieb Xiaolei Wang:
> Currently imx8mp_blk_ctrl_remove() will continue the for loop
> until an out-of-bounds exception occurs.
>=20
afb2a86f002b ("pmdomain: imx8m[p]-blk-ctrl: Suppress bind attrs"),
which is in -next disabled the possibility to unbind the driver from
userspace, which I guess is the only way to hit this code. But maybe we
actually want to support unbind someday and as long as the code exists,
it should be correct.

Can you rephrase the commit subject to "add missing loop break
condition" or something along those lines? With that:

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> pc : dev_pm_domain_detach+0x8/0x48
> lr : imx8mp_blk_ctrl_shutdown+0x58/0x90
> sp : ffffffc084f8bbf0
> x29: ffffffc084f8bbf0 x28: ffffff80daf32ac0 x27: 0000000000000000
> x26: ffffffc081658d78 x25: 0000000000000001 x24: ffffffc08201b028
> x23: ffffff80d0db9490 x22: ffffffc082340a78 x21: 00000000000005b0
> x20: ffffff80d19bc180 x19: 000000000000000a x18: ffffffffffffffff
> x17: ffffffc080a39e08 x16: ffffffc080a39c98 x15: 4f435f464f006c72
> x14: 0000000000000004 x13: ffffff80d0172110 x12: 0000000000000000
> x11: ffffff80d0537740 x10: ffffff80d05376c0 x9 : ffffffc0808ed2d8
> x8 : ffffffc084f8bab0 x7 : 0000000000000000 x6 : 0000000000000000
> x5 : ffffff80d19b9420 x4 : fffffffe03466e60 x3 : 0000000080800077
> x2 : 0000000000000000 x1 : 0000000000000001 x0 : 0000000000000000
> Call trace:
>  dev_pm_domain_detach+0x8/0x48
>  platform_shutdown+0x2c/0x48
>  device_shutdown+0x158/0x268
>  kernel_restart_prepare+0x40/0x58
>  kernel_kexec+0x58/0xe8
>  __do_sys_reboot+0x198/0x258
>  __arm64_sys_reboot+0x2c/0x40
>  invoke_syscall+0x5c/0x138
>  el0_svc_common.constprop.0+0x48/0xf0
>  do_el0_svc+0x24/0x38
>  el0_svc+0x38/0xc8
>  el0t_64_sync_handler+0x120/0x130
>  el0t_64_sync+0x190/0x198
> Code: 8128c2d0 ffffffc0 aa1e03e9 d503201f
>=20
> Fixes: 556f5cf9568a ("soc: imx: add i.MX8MP HSIO blk-ctrl")
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> ---
>  drivers/pmdomain/imx/imx8mp-blk-ctrl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c b/drivers/pmdomain/im=
x/imx8mp-blk-ctrl.c
> index e3a0f64c144c..3668fe66b22c 100644
> --- a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
> +++ b/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
> @@ -770,7 +770,7 @@ static void imx8mp_blk_ctrl_remove(struct platform_de=
vice *pdev)
> =20
>  	of_genpd_del_provider(pdev->dev.of_node);
> =20
> -	for (i =3D 0; bc->onecell_data.num_domains; i++) {
> +	for (i =3D 0; i < bc->onecell_data.num_domains; i++) {
>  		struct imx8mp_blk_ctrl_domain *domain =3D &bc->domains[i];
> =20
>  		pm_genpd_remove(&domain->genpd);


