Return-Path: <linux-pm+bounces-43573-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGzoLqcWqGlTnwAAu9opvQ
	(envelope-from <linux-pm+bounces-43573-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 12:25:27 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 633E41FEF02
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 12:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 942A63002306
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2026 11:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F90A3A8741;
	Wed,  4 Mar 2026 11:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V6s0UtRu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BB43A874A
	for <linux-pm@vger.kernel.org>; Wed,  4 Mar 2026 11:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772623525; cv=pass; b=hFK4ZiQfWKfbAZfWuJtglVEYzMwjhU0B1D+3f1Gm+46SRAvWAUjOZqB/lDc5pY47d/WXubtc+A47yfo1fE9l/LZgRK55zs2d7Rk0xpQKfmq7ZX41YSdCIm6isSRMbfT/o7jZ1vn8Qfcy467/7MyFTcZDahUtV7SXhar6nM5qhZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772623525; c=relaxed/simple;
	bh=MGVNt7Zv077AR1/6k+SSxZzDXAKG2uIqldi8aMY2xso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZD/xelVpneSCoiQQKQyX7XHdDfPLiTFbx1oUNToXOe/zqaDSzImV+pqshonzBbV9lIlgvcO62j5oGiRoTnOYK2VqyOveeTpPvxnxBCmBPvAbSPfZSbW0glKDqbKInAPOtF+QcpKSrdlpI0ABpnGpugRSGFV5bhhu6dnaBPc2SLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V6s0UtRu; arc=pass smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-38a2f92fab4so4752751fa.2
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2026 03:25:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772623522; cv=none;
        d=google.com; s=arc-20240605;
        b=ZmgiRAQBEe3dnJhMjuW7wESFPQ7ZHMOZ5v5gV5GVou+fYgZMIBKbkdXHue2FhD9otR
         3HeLyDFjW99h/N7sNXTgc2J23aThxW4n3n5E9+rOOHWfBCN+4xLYaEvRsiGcb0AZLsKx
         pPQYaDZDulvxq0sY0z6S+ij7nJ4LyjfRwXXOTheAzzfWC7+fZA3+LYsWFoqV5dLk+Pya
         ZDxeoObWTaXRGg34L4SjrQimygHdvjEe2TXc6hSDviwkQ6jYuaXAkms365hEW5ZaBtSU
         egcgIM3iIAk2m7VSwFr8IH215OY3lH5D/Q1TO2V3gY0z6BeJYvbzlNWVty8ArmMKzoPg
         sTvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jqB5j+E4DSf4EbBKzvqlflmatvTKbzzjeiwDCgjc31o=;
        fh=ir1uRjvs8wKHLGB7g5X8z2nWu5IL8yvRWPdvW23svfk=;
        b=FM4ENwchK6Lw9Y0xRBUzEi3OdKrppe/Yb77JpvKVqDpAZGiwDJUroKCZcrA/GmUrmc
         Ew0c3JNU+3ubDNvMb6T9ZBsbWd5VNXWe0SgnuezxnQOo6dEKfpoNm0lE4sJEQdnDgyPX
         Jijyy5oiIELnGIFNpChWQwI+QzAexiX/ODJtmlFcEsJpK0YUMRYuO2o150uF6ckBsevt
         ljsPSsF1IY3cIAnAtdYoqgHE8GjH8hTaFpkHxRz/TKWMEmIfZNDYzphoAzjNCWigg+3s
         As1MiqcrVE7PzAHBVyfA/MzV2a+FMkplBGGk67C5fpYlZPcGAWV+koLU0sIEAUHlup+A
         988A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772623522; x=1773228322; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jqB5j+E4DSf4EbBKzvqlflmatvTKbzzjeiwDCgjc31o=;
        b=V6s0UtRujNl/XjhEZJmovto9kDVGiJTPPR1b/xeweJ/Bc1TDzQFeO0GopBaX8i56cg
         ErIXI0hKu1bobTLQc2tD6gtINqAfn5cugOzZDZgM8VbgeeuspX4U6sP3XDAOEIPNxNQx
         9DR3yejUHZD42RJ2sdXMO2DzWhSGEcC/vfqgMSqAbMCQudKmCLehN8cWSud+/2hXKKR+
         uMloTMu+bEjaxSVM11mwwBZQcysRhK73OOUXejLyuUfj3xfJcEowLnu1JtkKebPe2Rx1
         kuQIHCb5oCbG0CS+IZYQxguV/gAPMzjfx2JetwnRePWqVXx66tplpmzSYM9XoO6plhlb
         xZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772623522; x=1773228322;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jqB5j+E4DSf4EbBKzvqlflmatvTKbzzjeiwDCgjc31o=;
        b=puaaYpRkyisvnS5d3SZ/MKnTcWYx4i1Zb+g70im/pfoxLLeiLuZ5YZgs3XgFcskGla
         Q9t5MEGss76TL3qdZPg73jmDnGPnK6NNd2OkhNS2Rx2WUnLlE0K8HQDDgfiDZ1YuKewS
         dTMcM2AjyfoB/3WatTe5efZ8VbhI5/9kDV/swLNolvAr7ROCpP4mWKNTvfdbYkmsyRow
         4nEbK59l8yH9Vbnu6GyqCdTl7njXyRkMOwYjGAiWtyoAtWG2zEzixC912JQ6keqrh1P6
         ZH6dvGX5QXolrM/wWcZj5+Xwtq6jdpFkEJfU2xS3vevhWAeNhNYc/mLan0bkLWOgCeZz
         Wnxg==
X-Forwarded-Encrypted: i=1; AJvYcCU6HadTnUf/d9PBvaXQSstLEhDzXiSc8jt+g9+1YMLH0gWfnHrc73QTGTPaQNtFy04bEQm/EqqC4g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpozquM8FaivIGYGHqORJ0j40mPthBKzit8RpD1WWjZ50GTRwQ
	L3PVg6X7JbrWFJGxZqBTghbpKqvHdQ2S4yl7t8cIGgsBgDIfLaj3GTJNl8Ki6syzst1He+INWo7
	NMp+fqqaMxcTeclzNGmX7XZkTka4frlNAs6qr715ksQ==
X-Gm-Gg: ATEYQzytBZiVRirx6aGOInTmF/4PtJln1/9qVbJ6c/5ERenVXKuEdxbfzFvJAEuXY9f
	+0t0K2LbxRXtZDTDCeQQYnrFQBlyU5Dg8r+8N78477Xg5oOf2TUupW4kakMUOsIVwinveKEqUBm
	fBdJXYvN0i+vYb3C64GOstQ0qVkOtbme9skHjTvKJ/KGExP0m/wT3j+mxKqo9rAswozotYfPoic
	uWr+PENGAxNhtyGAMJBeYoJfngfnJt2+qA4AGRYt95ROUafmyPpTJdqvX1ox542dkhWB3bvLf2m
	maRSt310
X-Received: by 2002:a05:651c:1541:b0:382:fccd:f999 with SMTP id
 38308e7fff4ca-38a2c7bc7c6mr16035541fa.25.1772623521873; Wed, 04 Mar 2026
 03:25:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1771988101-49877-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1771988101-49877-1-git-send-email-shawn.lin@rock-chips.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 4 Mar 2026 12:24:45 +0100
X-Gm-Features: AaiRm50bUQu-RI-pXbdDTdDQj139yGzcF2dqA4SgUmdK1yk7k6TutZG0mI55cco
Message-ID: <CAPDyKFrG1GFPPa=H0pnvX-+SpwD30vad8YYsBp7tZd5H_huxUA@mail.gmail.com>
Subject: Re: [PATCH v3] pmdomain: rockchip: Fix PD_VCODEC for RK3588
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Finley Xiao <finley.xiao@rock-chips.com>, Frank Zhang <rmxpzlb@gmail.com>, 
	linux-pm@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.com>, 
	Detlev Casanova <detlev.casanova@collabora.com>, Heiko Stuebner <heiko@sntech.de>, 
	linux-rockchip@lists.infradead.org, stable@vger.kernel.org, 
	Chaoyi Chen <chaoyi.chen@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 633E41FEF02
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[rock-chips.com,gmail.com,vger.kernel.org,collabora.com,sntech.de,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-43573-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid,linaro.org:dkim]
X-Rspamd-Action: no action

On Wed, 25 Feb 2026 at 03:55, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> From the RK3588 TRM Table 7-1 RK3588 Voltage Domain and Power Domain Summary,
> PD_RKVDEC0/1 and PD_VENC0/1 rely on VD_VCODEC which require extra voltages to
> be applied, otherwise it breaks RK3588-evb1-v10 board after vdec support landed[1].
> The panic looks like below:
>
>   rockchip-pm-domain fd8d8000.power-management:power-controller: failed to set domain 'rkvdec0' on, val=0
>   rockchip-pm-domain fd8d8000.power-management:power-controller: failed to set domain 'rkvdec1' on, val=0
>   ...
>   Hardware name: Rockchip RK3588S EVB1 V10 Board (DT)
>   Workqueue: pm genpd_power_off_work_fn
>   Call trace:
>   show_stack+0x18/0x24 (C)
>   dump_stack_lvl+0x40/0x84
>   dump_stack+0x18/0x24
>   vpanic+0x1ec/0x4fc
>   vpanic+0x0/0x4fc
>   check_panic_on_warn+0x0/0x94
>   arm64_serror_panic+0x6c/0x78
>   do_serror+0xc4/0xcc
>   el1h_64_error_handler+0x3c/0x5c
>   el1h_64_error+0x6c/0x70
>   regmap_mmio_read32le+0x18/0x24 (P)
>   regmap_bus_reg_read+0xfc/0x130
>   regmap_read+0x188/0x1ac
>   regmap_read+0x54/0x78
>   rockchip_pd_power+0xcc/0x5f0
>   rockchip_pd_power_off+0x1c/0x4c
>   genpd_power_off+0x84/0x120
>   genpd_power_off+0x1b4/0x260
>   genpd_power_off_work_fn+0x38/0x58
>   process_scheduled_works+0x194/0x2c4
>   worker_thread+0x2ac/0x3d8
>   kthread+0x104/0x124
>   ret_from_fork+0x10/0x20
>   SMP: stopping secondary CPUs
>   Kernel Offset: disabled
>   CPU features: 0x3000000,000e0005,40230521,0400720b
>   Memory Limit: none
>   ---[ end Kernel panic - not syncing: Asynchronous SError Interrupt ]---
>
> Chaoyi pointed out the PD_VCODEC is the parent of PD_RKVDEC0/1 and PD_VENC0/1, so checking
> the PD_VCODEC is enough.
>
> [1] https://lore.kernel.org/linux-rockchip/20251020212009.8852-2-detlev.casanova@collabora.com/
> Fixes: db6df2e3fc16 ("pmdomain: rockchip: add regulator support")
> Cc: stable@vger.kernel.org
> Suggested-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Applied for fixes, thanks!

Kind regards
Uffe


>
> ---
>
> Changes in v3:
> - drop tags
> - rework it for just changing PD_VCODEC(chaoyi)
>
> Changes in v2:
> - collect tags
> - correct TRM section(Sebastian)
>
>  drivers/pmdomain/rockchip/pm-domains.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
> index 997e93c..44d3484 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c
> @@ -1311,7 +1311,7 @@ static const struct rockchip_domain_info rk3576_pm_domains[] = {
>  static const struct rockchip_domain_info rk3588_pm_domains[] = {
>         [RK3588_PD_GPU]         = DOMAIN_RK3588("gpu",     0x0, BIT(0),  0,       0x0, 0,       BIT(1),  0x0, BIT(0),  BIT(0),  false, true),
>         [RK3588_PD_NPU]         = DOMAIN_RK3588("npu",     0x0, BIT(1),  BIT(1),  0x0, 0,       0,       0x0, 0,       0,       false, true),
> -       [RK3588_PD_VCODEC]      = DOMAIN_RK3588("vcodec",  0x0, BIT(2),  BIT(2),  0x0, 0,       0,       0x0, 0,       0,       false, false),
> +       [RK3588_PD_VCODEC]      = DOMAIN_RK3588("vcodec",  0x0, BIT(2),  BIT(2),  0x0, 0,       0,       0x0, 0,       0,       false, true),
>         [RK3588_PD_NPUTOP]      = DOMAIN_RK3588("nputop",  0x0, BIT(3),  0,       0x0, BIT(11), BIT(2),  0x0, BIT(1),  BIT(1),  false, false),
>         [RK3588_PD_NPU1]        = DOMAIN_RK3588("npu1",    0x0, BIT(4),  0,       0x0, BIT(12), BIT(3),  0x0, BIT(2),  BIT(2),  false, false),
>         [RK3588_PD_NPU2]        = DOMAIN_RK3588("npu2",    0x0, BIT(5),  0,       0x0, BIT(13), BIT(4),  0x0, BIT(3),  BIT(3),  false, false),
> --
> 2.7.4
>

