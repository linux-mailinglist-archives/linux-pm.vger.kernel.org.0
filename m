Return-Path: <linux-pm+bounces-20557-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE61A13E93
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 16:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEBA0188A101
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 15:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C3122CA10;
	Thu, 16 Jan 2025 15:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XGb2KXfR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B824322B8C4
	for <linux-pm@vger.kernel.org>; Thu, 16 Jan 2025 15:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737043115; cv=none; b=e4j065OBUZJRXnJCup4rX+TgsRmNdtlKVRYWaMLR0mgDsHWcjfXy2+La5IdXRoY/WlvtlOvxPKg2/HSqRvr0EzwofO3jaoGaZNmFKww0fEDa7QzR0+Wc+4jKCW03Tnam9rd4OJ9ORXX8cgaMuKk76VJB9DBiQIfq+cPk5E/N3gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737043115; c=relaxed/simple;
	bh=TsAFTtAPHFDWqClgUwsN+5G3GYn9qmIlLxL/HqroH30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NJt0yD+oOTLcDhTZ7k016tbhRiTUC61nYXR3k5M9MVnKiEfeEFSW8N4PdATmfDwaNdAk1bjVn+VJx4wgoWiHuRTYnYhU3WuSj6/QsIwWYUmrtMaNEDUD3UtfL8b1nAMN64sTy2yxXnn9UUBouZ8BmYVRbHLyc6t9nOe7M/EO6zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XGb2KXfR; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e479e529ebcso1571172276.3
        for <linux-pm@vger.kernel.org>; Thu, 16 Jan 2025 07:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737043113; x=1737647913; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xZg7i9Gkt1p2UGCmQVCKIa0P9txKm7ecHDqIrA9B8RM=;
        b=XGb2KXfRVGoR1Eiu2vhPmmbLb2hgGv98FzMH1i/BCE2WlVNjyrK6XSkboDb0+S2R6m
         VwrLtxBm6p/7n1Ivtl3o2OO7KZqbDmRCRSQD4/IDvdgPpoz4tVvtAlpUC9PTkDIAUNpT
         qkSCmD8rAu7ocUUJgPbP8e/4KtcqaUHczLXKmNGhSVPl1ZS1jFZg+3BTbqQrP058bnCs
         2d34r7vb/n845hGfiLdSw5Hkmo65lhMfsVArev4uPOs4/9x9rJ+AMEV6ZwBb+eTqpc3C
         Fc594a6C7iV8EzTzD4JXzI+S1sp7CahklZPtIqDnQvA5BrYTkonhou1sKnWXm96akzn1
         Rm8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737043113; x=1737647913;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xZg7i9Gkt1p2UGCmQVCKIa0P9txKm7ecHDqIrA9B8RM=;
        b=cMFXBig3WnjBxRSKzsMEDfaGsUBvLHAdcvMef/wncVBrG23AjmdJUYBOmEkTndcbrb
         HDeboPXzyylWUJKGRGL/8WD+NsfivYo1ZMk6NkLKRVg1eZIDhR6qe2H3BK0AcKZtPO8x
         P456szWCawXVQmiLUvYyU6WYbBGgiKOV68djgyGTskX85Tm/DbI72U3dpN+IwC8vNzjv
         Ps+oT1ZkIOTYJmpuqtE5XOIajtfRQAfQISNOfR66oSTWXViQ70Aj6T+Hzc8EhW1bDdvZ
         BeSwZfVN4s8MeoxlWSgO5Yw2M7BAKyJ+oGUX5ymrh7xC3EH9W1D6Tzb+vDfRIvLLqqNW
         uCMA==
X-Forwarded-Encrypted: i=1; AJvYcCXwLHmmxR4XekARhuxoMFG8DIEPlqlVY1eynQ5YVToL9PmVaxfDUNuof6a7j6u0+8X4mcgsDSMUxw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+V30HKEF1sqo5St6TUEg1fC+Gh09BoEY6s2YEoHicnTSAysKZ
	sqSOx5EQCWI5NLisbrbbccXLT7brWjAXsAI2mSDyAWKBRvN0nwN16MeQDfO0VNFMvWcgR877lyM
	mqbMEIv+RW0fs2HlFzOArKgFv9/5DRqYW2Vw+hg==
X-Gm-Gg: ASbGncscOGWfRSJi+3iDk9aAfr2QdjQ+09Zh+NL1Jgfc4c8eSO3w/v+p8+B9OvUR8YM
	6DviqsnqIFMTQNV34urMgBlwewA3RhZ/1s5xqVMk=
X-Google-Smtp-Source: AGHT+IG1qVTRfq3rD5NuthhfaJDGZx9itjIkE76nEv6cFISZ83dbq/vsbg+foxsWE2MrG6pQrDxrf7Opr66/DdtZa/k=
X-Received: by 2002:a05:6902:161b:b0:e57:31f1:972e with SMTP id
 3f1490d57ef6-e5731f1a4b2mr20182789276.29.1737043112819; Thu, 16 Jan 2025
 07:58:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115014118.4086729-1-xiaolei.wang@windriver.com>
In-Reply-To: <20250115014118.4086729-1-xiaolei.wang@windriver.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 16 Jan 2025 16:57:56 +0100
X-Gm-Features: AbW1kvYIxEEhaAOaS13it3QYjlHMEzrYgUS_q1Twane_cAE7ZLMDO-j-7TvLw_Y
Message-ID: <CAPDyKFrpwPLjk+fzAC+1=z5rWJ0UiSTndbq2hET64KDcwsNzKw@mail.gmail.com>
Subject: Re: [PATCH v3] pmdomain: imx8mp-blk-ctrl: add missing loop break condition
To: Xiaolei Wang <xiaolei.wang@windriver.com>
Cc: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, Frank.Li@nxp.com, ping.bai@nxp.com, 
	l.stach@pengutronix.de, marex@denx.de, aford173@gmail.com, 
	linux-pm@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 Jan 2025 at 02:41, Xiaolei Wang <xiaolei.wang@windriver.com> wrote:
>
> Currently imx8mp_blk_ctrl_remove() will continue the for loop
> until an out-of-bounds exception occurs.
>
> pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
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
>
> Fixes: 556f5cf9568a ("soc: imx: add i.MX8MP HSIO blk-ctrl")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
> v1:
>   https://patchwork.kernel.org/project/imx/patch/20250113045609.842243-1-xiaolei.wang@windriver.com/
>
> v2:
>   Update commit subject
>
> v3:
>   cc stable
>
>  drivers/pmdomain/imx/imx8mp-blk-ctrl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c b/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
> index e3a0f64c144c..3668fe66b22c 100644
> --- a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
> +++ b/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
> @@ -770,7 +770,7 @@ static void imx8mp_blk_ctrl_remove(struct platform_device *pdev)
>
>         of_genpd_del_provider(pdev->dev.of_node);
>
> -       for (i = 0; bc->onecell_data.num_domains; i++) {
> +       for (i = 0; i < bc->onecell_data.num_domains; i++) {
>                 struct imx8mp_blk_ctrl_domain *domain = &bc->domains[i];
>
>                 pm_genpd_remove(&domain->genpd);
> --
> 2.25.1
>

