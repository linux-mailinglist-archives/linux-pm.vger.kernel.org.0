Return-Path: <linux-pm+bounces-38436-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A78C7FD3C
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 11:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A204F343A69
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 10:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8FB258CD7;
	Mon, 24 Nov 2025 10:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dfH1666S"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EBB221DB3
	for <linux-pm@vger.kernel.org>; Mon, 24 Nov 2025 10:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763979441; cv=none; b=Q0lQ6jkJaX6B1o3HP1fxUlN/afNvgIyYgwA0jdyrBYFbMdtpOTSLz9GftenFrw7vyJWaqaiRIo3p/hCXq7nOK/FyxdsfBdNYWB9OE8VZZr8No2LXVY9C9OtOsGU9L3Nz4Okt5zdCv1KzvgZsSLCa78fZP//Yzpw0NIEj4UTWkcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763979441; c=relaxed/simple;
	bh=MHBAGXB1hhCZDfDID74Z7Pa7LncODFdMyovmD+XGP9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=skvGlqOFjOPNN2IdShCViRnPgIB1OvuB7IJXSMO/3D4ZFSPjRV89fH2mGqPMrUgJ19hYNEhc+6PZpTUm49CQoSa9PGrNJTqwGrzp8uVwNOKLywDkTEdyE9FjGgfDNtwLgWhTg1veqPhtVmccS1qKD5Dm2StKzfQQoHVj+Z7a76o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dfH1666S; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-63bc1aeb427so3264610d50.3
        for <linux-pm@vger.kernel.org>; Mon, 24 Nov 2025 02:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763979438; x=1764584238; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=II8YI3C/iUDdwVikJhgiudHAop3AyyPyPytzzAcj7uU=;
        b=dfH1666SM6H7uRu+CdwCvQa/5lnmTyAtBpRVfE1r6T1UfkSMUfomU2x9+mqtxZ6ZQm
         kRlidC042fX8hQVl9oKwP9eOFWNiV0fOcvoYdijK8qRYxUn1R6HIgyfZPWRldxfJpBTA
         Q47gDjOIgQlMRVpc26zxsiTLr6xKmbQUzE+iL22eFRAnWsSIJP73+n2C9hf/ekRsOM9a
         J1aXtWalGAwj2Hz9pZMh7OuVy28XdBU6DxMg/hwfVCYMk4BIBCLSL1FC0Lyz0xJBR6oF
         NAiq8/6UlyYCt4S+GXlbQgrreERCL8nFNPqrn6xsAnQIkaA7kSrn+Bp1izm/BBC/ehkq
         oz9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763979438; x=1764584238;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=II8YI3C/iUDdwVikJhgiudHAop3AyyPyPytzzAcj7uU=;
        b=RgnjhXkswkcoXo62ckzy8X759chyit+geQNbOG9X8Zu4XiGvxpNtkvhqjriQvFS1z5
         zF0piRpYJ3qrDskKpHdw5lm9xUUy8kswMZNcSuv88NDlAE3P8F1T/gRUrC0I22dIrY/S
         UYeHCe95uO76OG3CQ4dOKIbkWVZlSfWxiZCnSCuJs1Ppbgu4X+5fIbHbuTbE2MrusZSn
         mtJhE2q+yJRuFO5QuuTDR2oa3J0uMk6mdMyuQ8TuNOdNemdmcgx4uCFAL72/fPL2pRLY
         NdLovTMr3kXR6oO29zmqdZZmMsh38OIUTXQHiu0N+6p9lVSoKv63VUW8b0aZn4HQvtQ6
         JpfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgo7sVOeAYaeYx+XqvyL+17zD52CaVmIR0MjR1MCrUHpylJySl9YHdM5elH3/Zws4awuWCJG7m9A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw05UpcALDmbQqJXv7FgXJJ9fjT49yPXGU4cqSFk97aNlsyZKQn
	zlBylp6OGBklAhvQ88KhP3JoWF5aY+ohiKmzZ6X7u0RnmamQDoGK6Q1mB+vXK8iPxj4e1xPbruy
	x9B2hRWnM8qCjINUgbvBqpXgd1ySBezYFmF27JVGgZg==
X-Gm-Gg: ASbGncvEJlAR25W2yFZNT044gx63j2qvHJbEeozWVl7KXCD/LX8NtftVceBrV8dVRAG
	rVh35edN0s7oRxR3htCEI/vfqx0mvmbHAvtxtQIhBEMuRKDqApHsWpKk4cvtDzv9vbGkGrADH3A
	WNWHS21PpEHLKgL+fg/FOn5VW1zLsC8He1Gd8u1raQxGvcMzbIDPhec8YdJkwEvzVXfz4LrYTT7
	EGa7T8af3/wyZ6n8JAE+2ZFzrDLdhqL+Ayl5fFoB8AL+6z480mwK3zGS5U+5sP2SfPlFuMm
X-Google-Smtp-Source: AGHT+IHZKiPR/ZbuRZ0U59HQ+RscPzcZbVdRLvk9GoovnNcNednqmG4npANrIbRzWrLj9FeTBSnrW93KTr0acBSdJJU=
X-Received: by 2002:a05:690e:14c:b0:640:dead:f78 with SMTP id
 956f58d0204a3-64302acadefmr6058059d50.68.1763979437967; Mon, 24 Nov 2025
 02:17:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121125212.43093-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20251121125212.43093-1-angelogioacchino.delregno@collabora.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 24 Nov 2025 11:16:41 +0100
X-Gm-Features: AWmQ_bmRF82IjFCOc91DUmABpVXVUdYe_hVuYPuZC-41JJhfg_bW2drgqfzyHeg
Message-ID: <CAPDyKFp32GafgWBEn=PbVex1MXRo+nBFcVSgLxrqxMtLXnRFSA@mail.gmail.com>
Subject: Re: [PATCH - URGENT] pmdomains: mtk-pm-domains: Fix spinlock
 recursion in probe
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: matthias.bgg@gmail.com, nfraprado@collabora.com, 
	irving-ch.lin@mediatek.com, wenst@chromium.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, robh@kernel.org, krzk@kernel.org, 
	conor@kernel.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Nov 2025 at 13:52, AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> For some reason, of_find_node_with_property() is creating a spinlock
> recursion issue along with fwnode_count_parents(), and this issue
> is making all MediaTek boards unbootable.
>
> As of kernel v6.18-rc6, there are only three users of this function,
> one of which is this driver.
>
> Migrate away from of_find_node_with_property() by adding a local
> scpsys_get_legacy_regmap_node() function, which acts similarly to
> of_find_node_with_property(), and calling the former in place of
> the latter.
>
> This resolves the following spinlock recursion issue:
>
> [    1.773979] BUG: spinlock recursion on CPU#2, kworker/u24:1/60
> [    1.790485]  lock: devtree_lock+0x0/0x40, .magic: dead4ead, .owner: kworker/u24:1/60, .owner_cpu: 2
> [    1.791644] CPU: 2 UID: 0 PID: 60 Comm: kworker/u24:1 Tainted: G        W           6.18.0-rc6 #3 PREEMPT
> [    1.791649] Tainted: [W]=WARN
> [    1.791650] Hardware name: MediaTek Genio-510 EVK (DT)
> [    1.791653] Workqueue: events_unbound deferred_probe_work_func
> [    1.791658] Call trace:
> [    1.791659]  show_stack+0x18/0x30 (C)
> [    1.791664]  dump_stack_lvl+0x68/0x94
> [    1.791668]  dump_stack+0x18/0x24
> [    1.791672]  spin_dump+0x78/0x88
> [    1.791678]  do_raw_spin_lock+0x110/0x140
> [    1.791684]  _raw_spin_lock_irqsave+0x58/0x6c
> [    1.791690]  of_get_parent+0x28/0x74
> [    1.791694]  of_fwnode_get_parent+0x38/0x7c
> [    1.791700]  fwnode_count_parents+0x34/0xf0
> [    1.791705]  fwnode_full_name_string+0x28/0x120
> [    1.791710]  device_node_string+0x3e4/0x50c
> [    1.791715]  pointer+0x294/0x430
> [    1.791718]  vsnprintf+0x21c/0x5bc
> [    1.791722]  vprintk_store+0x108/0x47c
> [    1.791728]  vprintk_emit+0xc4/0x350
> [    1.791732]  vprintk_default+0x34/0x40
> [    1.791736]  vprintk+0x24/0x30
> [    1.791740]  _printk+0x60/0x8c
> [    1.791744]  of_node_release+0x154/0x194
> [    1.791749]  kobject_put+0xa0/0x120
> [    1.791753]  of_node_put+0x18/0x28
> [    1.791756]  of_find_node_with_property+0x74/0x100
> [    1.791761]  scpsys_probe+0x338/0x5e0
> [    1.791765]  platform_probe+0x5c/0xa4
> [    1.791770]  really_probe+0xbc/0x2ac
> [    1.791774]  __driver_probe_device+0x78/0x118
> [    1.791779]  driver_probe_device+0x3c/0x170
> [    1.791783]  __device_attach_driver+0xb8/0x150
> [    1.791788]  bus_for_each_drv+0x88/0xe8
> [    1.791792]  __device_attach+0x9c/0x1a0
> [    1.791796]  device_initial_probe+0x14/0x20
> [    1.791801]  bus_probe_device+0xa0/0xa4
> [    1.791805]  deferred_probe_work_func+0x88/0xd0
> [    1.791809]  process_one_work+0x1e8/0x448
> [    1.791813]  worker_thread+0x1ac/0x340
> [    1.791816]  kthread+0x138/0x220
> [    1.791821]  ret_from_fork+0x10/0x20
>
> Fixes: c29345fa5f66 ("pmdomain: mediatek: Refactor bus protection regmaps retrieval")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied this for fixes, thanks!

Yes, it seems like we may need some additional analysis/fix, but let's
look into that separately beyond this fix.

Kind regards
Uffe


> ---
>
> This might not be the best fix to perform, and I have Cc'ed Rob and
> Krzysztof for them to have a look at the spinlock recursion issue,
> as I think it either has to be fixed, or the affected function has
> to be removed (or both, actually - in any case, if not fixed, this
> could backfire, and I'm not sure that the only function that shows
> this issue is just only of_find_node_with_property() or if others
> also do; at least, nothing else on MediaTek machines as of now).
>
> Counting that this makes *all* MediaTek machines to be unbootable,
> I'd prefer this fix to get merged immediately - so that it lands
> in v6.18 (which is at rc6 at the time of writing).
>
> That - because I think that resolving the source of this issue will
> take a bit of time and research - and I really don't want the LTS
> kernel to be broken on all MediaTek devices.
>
> Note: When I initially tested the commit pointed out in the Fixes
> tag, it was working with no spinlock recursion - I don't clearly
> remember what kernel version was that, but I think it was some
> linux-next around v6.16 or v6.17.
>
>  drivers/pmdomain/mediatek/mtk-pm-domains.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
> index 407b4a7aba10..721224c89865 100644
> --- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
> +++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
> @@ -1006,6 +1006,18 @@ static void scpsys_domain_cleanup(struct scpsys *scpsys)
>         }
>  }
>
> +static struct device_node *scpsys_get_legacy_regmap(struct device_node *np, const char *pn)
> +{
> +       struct device_node *local_node;
> +
> +       for_each_child_of_node(np, local_node) {
> +               if (of_property_present(local_node, pn))
> +                       return local_node;
> +       }
> +
> +       return NULL;
> +}
> +
>  static int scpsys_get_bus_protection_legacy(struct device *dev, struct scpsys *scpsys)
>  {
>         const u8 bp_blocks[3] = {
> @@ -1027,7 +1039,7 @@ static int scpsys_get_bus_protection_legacy(struct device *dev, struct scpsys *s
>          * this makes it then possible to allocate the array of bus_prot
>          * regmaps and convert all to the new style handling.
>          */
> -       node = of_find_node_with_property(np, "mediatek,infracfg");
> +       node = scpsys_get_legacy_regmap(np, "mediatek,infracfg");
>         if (node) {
>                 regmap[0] = syscon_regmap_lookup_by_phandle(node, "mediatek,infracfg");
>                 of_node_put(node);
> @@ -1040,7 +1052,7 @@ static int scpsys_get_bus_protection_legacy(struct device *dev, struct scpsys *s
>                 regmap[0] = NULL;
>         }
>
> -       node = of_find_node_with_property(np, "mediatek,smi");
> +       node = scpsys_get_legacy_regmap(np, "mediatek,smi");
>         if (node) {
>                 smi_np = of_parse_phandle(node, "mediatek,smi", 0);
>                 of_node_put(node);
> @@ -1058,7 +1070,7 @@ static int scpsys_get_bus_protection_legacy(struct device *dev, struct scpsys *s
>                 regmap[1] = NULL;
>         }
>
> -       node = of_find_node_with_property(np, "mediatek,infracfg-nao");
> +       node = scpsys_get_legacy_regmap(np, "mediatek,infracfg-nao");
>         if (node) {
>                 regmap[2] = syscon_regmap_lookup_by_phandle(node, "mediatek,infracfg-nao");
>                 num_regmaps++;
> --
> 2.51.2
>

