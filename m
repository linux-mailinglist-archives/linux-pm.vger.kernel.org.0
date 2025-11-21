Return-Path: <linux-pm+bounces-38375-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADDCC799F5
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 14:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id A65C22D9BA
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 13:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5953034EEFB;
	Fri, 21 Nov 2025 13:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=louisalexis.eyraud@collabora.com header.b="YXfjgUMi"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D5234EEED;
	Fri, 21 Nov 2025 13:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763732181; cv=pass; b=uwVw7Knb/AEUQTuD5R36LsKSIS2GYnueNB/ThHH3Nm26bY6Wx2VmN8jaPFyx0EVS7KPritk3wfADjDRp2hopB0QmvKi6tcAEfXHoFfy7yHuVpAUHCLD19ckwmMQN1M21Kl1xecVKdniL21am23uYmUAvCjr+tAdA1yXcXP32uGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763732181; c=relaxed/simple;
	bh=GfQ8ML+9zX+PK2tlDn4aSrum6K9QYEf8Ms24Kz5hj9w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QDGq5ecSj7WEoXehwBxUvel8L//wjfKf57Xu/3Tz/0Inb64OATzSev3XQaGnHT4T/mzYGLZJN1fAh/j4BfScG1276LVcY35tqTezDw4qPYsrznlBVMi72mSh4L2I/AVDM1Z/t4fOt9qoKQw/gPwgs/VEHSpqOp3e2R4x3Z+5x2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=louisalexis.eyraud@collabora.com header.b=YXfjgUMi; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1763732154; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=e74KFJ9vgz6b7ewcQ7f+S6Y5PMn78ts9kOwvCErWbdDYE4SIyWbscAAry8pkQQfrMWOIwqIcbZ9+D2Iy156DDaPIWmRX8Sj+ot0DYUzOcbyY2pFg8i4Q0PiAccmOxDpYhWHIACiiAge3sOtKsqECQOGVjFI1Qku5jESw0Tq4MWk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1763732154; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=efH9Agej6Z9Q3tfyl7rJRxdmC7o9Bt18Qr1lcQtX8mc=; 
	b=YA1Ny9ZNwPA2FUgRm2gbSvX+4S/mTCW5tfW7gXxIOP4YdtH/V3QPTNOToRxn6kac1Hg97WDJUSJfu7blPXn5QCGQ/FdoFih5kwVn4O+SHb/h45JgG3haD3sTFuLXLFXv2OZ1Heyf4gsnD7krYPaqQ/is8fp/jX893nJpnSoD91w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=louisalexis.eyraud@collabora.com;
	dmarc=pass header.from=<louisalexis.eyraud@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763732154;
	s=zohomail; d=collabora.com; i=louisalexis.eyraud@collabora.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=efH9Agej6Z9Q3tfyl7rJRxdmC7o9Bt18Qr1lcQtX8mc=;
	b=YXfjgUMiM1VsxigPCn65uyQOmegLHes3Ns4fqUi3yiOMpA5SFVI938rbr6iDe0y7
	L+/l3di69KmJtcCFI2+aYo8mz31rZkoUCHaykAKfh6xheIXwClq0ObTtfNzj3c/hPl1
	IcUNkYSggpnkS5dlDSmdnqHax9h1wg7N5J3gzWhQ=
Received: by mx.zohomail.com with SMTPS id 1763732152616682.0078621223064;
	Fri, 21 Nov 2025 05:35:52 -0800 (PST)
Message-ID: <07011558548dfc88fb237b7d21d43a6bc25dd0fd.camel@collabora.com>
Subject: Re: [PATCH - URGENT] pmdomains: mtk-pm-domains: Fix spinlock
 recursion in probe
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	ulf.hansson@linaro.org
Cc: matthias.bgg@gmail.com, nfraprado@collabora.com,
 irving-ch.lin@mediatek.com, 	wenst@chromium.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, 	robh@kernel.org, krzk@kernel.org,
 conor@kernel.org, kernel@collabora.com
Date: Fri, 21 Nov 2025 14:35:47 +0100
In-Reply-To: <20251121125212.43093-1-angelogioacchino.delregno@collabora.com>
References: <20251121125212.43093-1-angelogioacchino.delregno@collabora.com>
Organization: Collabora Ltd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

Hi Angelo,

On Fri, 2025-11-21 at 13:52 +0100, AngeloGioacchino Del Regno wrote:
> For some reason, of_find_node_with_property() is creating a spinlock
> recursion issue along with fwnode_count_parents(), and this issue
> is making all MediaTek boards unbootable.
>=20
> As of kernel v6.18-rc6, there are only three users of this function,
> one of which is this driver.
>=20
> Migrate away from of_find_node_with_property() by adding a local
> scpsys_get_legacy_regmap_node() function, which acts similarly to
> of_find_node_with_property(), and calling the former in place of
> the latter.
>=20
> This resolves the following spinlock recursion issue:
>=20
> [=C2=A0=C2=A0=C2=A0 1.773979] BUG: spinlock recursion on CPU#2, kworker/u=
24:1/60
> [=C2=A0=C2=A0=C2=A0 1.790485]=C2=A0 lock: devtree_lock+0x0/0x40, .magic: =
dead4ead,
> .owner: kworker/u24:1/60, .owner_cpu: 2
> [=C2=A0=C2=A0=C2=A0 1.791644] CPU: 2 UID: 0 PID: 60 Comm: kworker/u24:1 T=
ainted:
> G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6.18.0-rc6 #3 PREEMPT
> [=C2=A0=C2=A0=C2=A0 1.791649] Tainted: [W]=3DWARN
> [=C2=A0=C2=A0=C2=A0 1.791650] Hardware name: MediaTek Genio-510 EVK (DT)
> [=C2=A0=C2=A0=C2=A0 1.791653] Workqueue: events_unbound deferred_probe_wo=
rk_func
> [=C2=A0=C2=A0=C2=A0 1.791658] Call trace:
> [=C2=A0=C2=A0=C2=A0 1.791659]=C2=A0 show_stack+0x18/0x30 (C)
> [=C2=A0=C2=A0=C2=A0 1.791664]=C2=A0 dump_stack_lvl+0x68/0x94
> [=C2=A0=C2=A0=C2=A0 1.791668]=C2=A0 dump_stack+0x18/0x24
> [=C2=A0=C2=A0=C2=A0 1.791672]=C2=A0 spin_dump+0x78/0x88
> [=C2=A0=C2=A0=C2=A0 1.791678]=C2=A0 do_raw_spin_lock+0x110/0x140
> [=C2=A0=C2=A0=C2=A0 1.791684]=C2=A0 _raw_spin_lock_irqsave+0x58/0x6c
> [=C2=A0=C2=A0=C2=A0 1.791690]=C2=A0 of_get_parent+0x28/0x74
> [=C2=A0=C2=A0=C2=A0 1.791694]=C2=A0 of_fwnode_get_parent+0x38/0x7c
> [=C2=A0=C2=A0=C2=A0 1.791700]=C2=A0 fwnode_count_parents+0x34/0xf0
> [=C2=A0=C2=A0=C2=A0 1.791705]=C2=A0 fwnode_full_name_string+0x28/0x120
> [=C2=A0=C2=A0=C2=A0 1.791710]=C2=A0 device_node_string+0x3e4/0x50c
> [=C2=A0=C2=A0=C2=A0 1.791715]=C2=A0 pointer+0x294/0x430
> [=C2=A0=C2=A0=C2=A0 1.791718]=C2=A0 vsnprintf+0x21c/0x5bc
> [=C2=A0=C2=A0=C2=A0 1.791722]=C2=A0 vprintk_store+0x108/0x47c
> [=C2=A0=C2=A0=C2=A0 1.791728]=C2=A0 vprintk_emit+0xc4/0x350
> [=C2=A0=C2=A0=C2=A0 1.791732]=C2=A0 vprintk_default+0x34/0x40
> [=C2=A0=C2=A0=C2=A0 1.791736]=C2=A0 vprintk+0x24/0x30
> [=C2=A0=C2=A0=C2=A0 1.791740]=C2=A0 _printk+0x60/0x8c
> [=C2=A0=C2=A0=C2=A0 1.791744]=C2=A0 of_node_release+0x154/0x194
> [=C2=A0=C2=A0=C2=A0 1.791749]=C2=A0 kobject_put+0xa0/0x120
> [=C2=A0=C2=A0=C2=A0 1.791753]=C2=A0 of_node_put+0x18/0x28
> [=C2=A0=C2=A0=C2=A0 1.791756]=C2=A0 of_find_node_with_property+0x74/0x100
> [=C2=A0=C2=A0=C2=A0 1.791761]=C2=A0 scpsys_probe+0x338/0x5e0
> [=C2=A0=C2=A0=C2=A0 1.791765]=C2=A0 platform_probe+0x5c/0xa4
> [=C2=A0=C2=A0=C2=A0 1.791770]=C2=A0 really_probe+0xbc/0x2ac
> [=C2=A0=C2=A0=C2=A0 1.791774]=C2=A0 __driver_probe_device+0x78/0x118
> [=C2=A0=C2=A0=C2=A0 1.791779]=C2=A0 driver_probe_device+0x3c/0x170
> [=C2=A0=C2=A0=C2=A0 1.791783]=C2=A0 __device_attach_driver+0xb8/0x150
> [=C2=A0=C2=A0=C2=A0 1.791788]=C2=A0 bus_for_each_drv+0x88/0xe8
> [=C2=A0=C2=A0=C2=A0 1.791792]=C2=A0 __device_attach+0x9c/0x1a0
> [=C2=A0=C2=A0=C2=A0 1.791796]=C2=A0 device_initial_probe+0x14/0x20
> [=C2=A0=C2=A0=C2=A0 1.791801]=C2=A0 bus_probe_device+0xa0/0xa4
> [=C2=A0=C2=A0=C2=A0 1.791805]=C2=A0 deferred_probe_work_func+0x88/0xd0
> [=C2=A0=C2=A0=C2=A0 1.791809]=C2=A0 process_one_work+0x1e8/0x448
> [=C2=A0=C2=A0=C2=A0 1.791813]=C2=A0 worker_thread+0x1ac/0x340
> [=C2=A0=C2=A0=C2=A0 1.791816]=C2=A0 kthread+0x138/0x220
> [=C2=A0=C2=A0=C2=A0 1.791821]=C2=A0 ret_from_fork+0x10/0x20
>=20
> Fixes: c29345fa5f66 ("pmdomain: mediatek: Refactor bus protection
> regmaps retrieval")
> Signed-off-by: AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com>
> ---
>=20
> This might not be the best fix to perform, and I have Cc'ed Rob and
> Krzysztof for them to have a look at the spinlock recursion issue,
> as I think it either has to be fixed, or the affected function has
> to be removed (or both, actually - in any case, if not fixed, this
> could backfire, and I'm not sure that the only function that shows
> this issue is just only of_find_node_with_property() or if others
> also do; at least, nothing else on MediaTek machines as of now).
>=20
> Counting that this makes *all* MediaTek machines to be unbootable,
> I'd prefer this fix to get merged immediately - so that it lands
> in v6.18 (which is at rc6 at the time of writing).
>=20
> That - because I think that resolving the source of this issue will
> take a bit of time and research - and I really don't want the LTS
> kernel to be broken on all MediaTek devices.
>=20
> Note: When I initially tested the commit pointed out in the Fixes
> tag, it was working with no spinlock recursion - I don't clearly
> remember what kernel version was that, but I think it was some
> linux-next around v6.16 or v6.17.
>=20
> =C2=A0drivers/pmdomain/mediatek/mtk-pm-domains.c | 18 +++++++++++++++---
> =C2=A01 file changed, 15 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c
> b/drivers/pmdomain/mediatek/mtk-pm-domains.c
> index 407b4a7aba10..721224c89865 100644
> --- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
> +++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
> @@ -1006,6 +1006,18 @@ static void scpsys_domain_cleanup(struct
> scpsys *scpsys)
> =C2=A0	}
> =C2=A0}
> =C2=A0
> +static struct device_node *scpsys_get_legacy_regmap(struct
> device_node *np, const char *pn)
> +{
> +	struct device_node *local_node;
> +
> +	for_each_child_of_node(np, local_node) {
> +		if (of_property_present(local_node, pn))
> +			return local_node;
> +	}
> +
> +	return NULL;
> +}
> +
> =C2=A0static int scpsys_get_bus_protection_legacy(struct device *dev,
> struct scpsys *scpsys)
> =C2=A0{
> =C2=A0	const u8 bp_blocks[3] =3D {
> @@ -1027,7 +1039,7 @@ static int
> scpsys_get_bus_protection_legacy(struct device *dev, struct scpsys *s
> =C2=A0	 * this makes it then possible to allocate the array of
> bus_prot
> =C2=A0	 * regmaps and convert all to the new style handling.
> =C2=A0	 */
> -	node =3D of_find_node_with_property(np, "mediatek,infracfg");
> +	node =3D scpsys_get_legacy_regmap(np, "mediatek,infracfg");
> =C2=A0	if (node) {
> =C2=A0		regmap[0] =3D syscon_regmap_lookup_by_phandle(node,
> "mediatek,infracfg");
> =C2=A0		of_node_put(node);
> @@ -1040,7 +1052,7 @@ static int
> scpsys_get_bus_protection_legacy(struct device *dev, struct scpsys *s
> =C2=A0		regmap[0] =3D NULL;
> =C2=A0	}
> =C2=A0
> -	node =3D of_find_node_with_property(np, "mediatek,smi");
> +	node =3D scpsys_get_legacy_regmap(np, "mediatek,smi");
> =C2=A0	if (node) {
> =C2=A0		smi_np =3D of_parse_phandle(node, "mediatek,smi", 0);
> =C2=A0		of_node_put(node);
> @@ -1058,7 +1070,7 @@ static int
> scpsys_get_bus_protection_legacy(struct device *dev, struct scpsys *s
> =C2=A0		regmap[1] =3D NULL;
> =C2=A0	}
> =C2=A0
> -	node =3D of_find_node_with_property(np, "mediatek,infracfg-
> nao");
> +	node =3D scpsys_get_legacy_regmap(np, "mediatek,infracfg-
> nao");
> =C2=A0	if (node) {
> =C2=A0		regmap[2] =3D syscon_regmap_lookup_by_phandle(node,
> "mediatek,infracfg-nao");
> =C2=A0		num_regmaps++;
I've tested your patch on top of a v6.18-rc6 kernel with a default
config. My Mediatek Genio 350-EVK (MT8365), 510-EVK (MT8370) and 1200-
EVK (MT8395) boards are all now booting without issue.

Tested-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

Regards,
Louis-Alexis

