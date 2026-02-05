Return-Path: <linux-pm+bounces-42139-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJVeOch4hGk23AMAu9opvQ
	(envelope-from <linux-pm+bounces-42139-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 12:02:32 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BA2F19B4
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 12:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 118B9302E785
	for <lists+linux-pm@lfdr.de>; Thu,  5 Feb 2026 10:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2413A9D82;
	Thu,  5 Feb 2026 10:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r3QJn9Au"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74842D191C
	for <linux-pm@vger.kernel.org>; Thu,  5 Feb 2026 10:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770289017; cv=pass; b=SJeiS/UB1QZJ6Hs4IMn9JXw2t5hZTok4toHP8ABj5AVxsED+l4hS6mKeJwgJBEEwC0espKodBVemtGcPMkQ3qzS5kC/zW4SI3ZY1gYfEgrQgU8EW2r1fVuzRYQYR2IO7dsi1/K3m3e4lMIxLTRc5CoFyHwIWwjLyjsHBE0rVU3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770289017; c=relaxed/simple;
	bh=rdUw3AFuPOHnbcRaTblDVekN4mvjS2EkFVEW4KiTE7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DJf6BXtRjc97w31XtER72mM7N7sexO0dNXkCzlrg4I19nDEc7BKTlJ/wimGLvDmIy8xjPyIL0MRwObTRyQHJAKG0vm7QsmyqvvvFW5J/z3jQ6Jb9mtWFTenvK8+D7vwQoNffWUxXmjjli8gQXYSoi2qkzP1b7Cj22Z/o3lwxcsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r3QJn9Au; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-59b77f2e43aso2174582e87.1
        for <linux-pm@vger.kernel.org>; Thu, 05 Feb 2026 02:56:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770289015; cv=none;
        d=google.com; s=arc-20240605;
        b=kj56BAenJB+M/8kTOhmv1QjBE0Ju9U2eVAjfmRuts6TOIhZMzyRwp0OM3iGTtb2djr
         p8wE6mNp+inLGt34rfV+rAxBnCwpPjkRfzYqqb5ikzX91kjzz96c9xKR9s/qOdbWqwyC
         XgFMPxcVYjF3HzZkSvmkomLOUJxMFIGec8/uf0jDJbwInCfZ0+YlSks7ffFPRPut0sOu
         tqoOxO5GlTtANMZObjS3yRFo65NyGDfK18FXhyHaRhULwN8lW/DvDR6ZSC3Rhr0emVeU
         svlIrocn+oVyDVxPsinZ8t8UnmvKg1QhbQsxTgSqEqkKpTFKYCRi9zMqwp8ZvK1Ge8CW
         kwNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=QRs6tGXQrB9J2BI16cCWeV+WhaT3GC747fgM7MhPTRQ=;
        fh=aQZ9gKg/JSZsdx/mhqH400jJ0DF3VtUoKskQwRBUBPY=;
        b=hnRdy9e+/QbqhhRYcj0BFYsyocR09B3a2uejqRAPCgJy1/VQtRzNgeCJ7eDJmZJCOE
         q4c+Mh7ZW+X0uXDfowmEVmTnhQwAvnVx6bJQzD6k9P+2+xVI/4ZhRF9U0BG9Hz4RI5Hq
         /pKMGiqxL+Ecltx9N8MdsWJsuoi7tCxgZUSb+/4R6dPlf0JIm6PpNQrMKgXuz/s0gtQ8
         vU6dXIMr6C4YN0iqAfMbDvY7ZiGHv+tIm8Sx8f/HhoaoSiE/Xc9T8k7TqZaX9UeJ5iwl
         2N6kELPuyyW5Jz8BHUW8K5fTll9wepImvpcmJT1xTAgmPtGd9YevdLMNU2xItcVW9oxO
         ROng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770289015; x=1770893815; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QRs6tGXQrB9J2BI16cCWeV+WhaT3GC747fgM7MhPTRQ=;
        b=r3QJn9AuaO7+NNwThuZp+GDKD5+NcqCRM2dlwHlfKylFkL9pQfwealoLHomvCM9IU8
         C3MfeepRs9IYa+e2xV/L/zRZ/JtUJur1fZHzNziTVpRanl1qYOJdGv5tmLnemhhoL//m
         gBCs3Ur5LQJOoR8GDS8qIcZVtY0h7IfLFCZstNUaOn2LiwmQTP+98ZwjLCjhucbYxFPR
         QbpV0j+9nOk6r7BhjLOVeV2VSySgEe1F88vJN4gmKtBdJjSaQZJ63a4KfEn9dhkcgnRJ
         M7JHn+unxG5MWCYhSWfF5HWaY1o+zAQc6zKKjanGFiL9hpgST6ysPNjig0rNWMn5c7Ff
         7vbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770289015; x=1770893815;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QRs6tGXQrB9J2BI16cCWeV+WhaT3GC747fgM7MhPTRQ=;
        b=Tw8ta5RLRF5dGQ+clmA3ke4ODcsHAHIcaGvFWr6WP1HSUgZGm7OnqiMZfAHTGAa2bG
         jgreM6RfIqSV0GfBCtpounqb/6Cu3p7QaS2QvXu6u5pmNENXRzrkt8mOdZ0C9ASldv3D
         EQ8ggfunrhoUCGtpxG9JuMgzJYr8/AcHDBgchl1zg/bxSjlSwmxxx3ru6oMMwOpmsJRo
         TW/VZK8T+cNZwLEwGZrGYxGR6HfR3dCm7Gyq9k2MR6IJUz/MoEVM32UxVeHv78jInK/E
         AjrtBNqK4fy/8MnVM5Wtf61zdk53PY0c9l8OB3JulY+gpEpDIMvi9qTaiHGIEvOvGdeO
         vvpw==
X-Forwarded-Encrypted: i=1; AJvYcCUB8zxyIk0RBcua9B+wFf/w+yaFUonP2bhw6uibQnBtA5hUJB1qL+1N8pGAioPYMK3NKwvoH5pmYw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx66wrHt35oQQSMSdGuD9mpSXTdgzl8E0PdQ5yeH+hq5/37Zxb4
	owOLSaKbf89U3mSHOaNNjjrT2V9u+3CEWq/FgVldCDDQ0dvkKJljqnxvxxDMH78NUHAy1XGF5Mn
	FB6dC/mX67lJBG8zmOxLP51cobbdyl/AQU+++TJ+pXQ==
X-Gm-Gg: AZuq6aLjuqW3M/EG1TLpbyaAF928whkFsa84NNAxirGVeAiVQkbvSeCj6yrsPcArhSe
	6ckw+l7S5u66iKCpeJAxDSaiufiEZ58LEr3+LRZXfi+GapWzJgw/Tje/YjDGT5X3ejmL9w59Lkb
	PydINIaBdJStUk5j/5CoRtaEZn9AlGFXWO/rAZjiINznlJoHjxdc3AE5cEog/4AvXjpS/ExHppV
	kCGgyGWOGRuHmXcA8iwa2mGl1Dl6qDnEc/9POGSheVwHHnodwfRpjp81nKOSVNcoxHiH1+YlNlG
	MTphhJM=
X-Received: by 2002:a05:6512:3b97:b0:59e:34d7:71de with SMTP id
 2adb3069b0e04-59e3c7aebcbmr907332e87.3.1770289014684; Thu, 05 Feb 2026
 02:56:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204111142.2147646-1-xu.yang_2@nxp.com>
In-Reply-To: <20260204111142.2147646-1-xu.yang_2@nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 5 Feb 2026 11:56:17 +0100
X-Gm-Features: AZwV_QghMMjFzpm5iyBrMMXiBy65oxzfHB7MKyQxNEi6CPDg3zrNZG9JA-o8bxM
Message-ID: <CAPDyKFqocghs2ucVpAz=9vErxSpCO=54RBdQg3ttoqf9t=-tYg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] pmdomain: imx8mp-blk-ctrl: keep gpc power domain
 on if blk-ctrl pd is on during system pm
To: Xu Yang <xu.yang_2@nxp.com>
Cc: Frank.Li@nxp.com, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, peng.fan@nxp.com, jun.li@nxp.com, 
	rafael.j.wysocki@intel.com, a.fatoum@pengutronix.de, ping.bai@nxp.com, 
	shawnguo@kernel.org, l.stach@pengutronix.de, linux-pm@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42139-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nxp.com,pengutronix.de,gmail.com,intel.com,kernel.org,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:email,linaro.org:dkim,nxp.com:email]
X-Rspamd-Queue-Id: 72BA2F19B4
X-Rspamd-Action: no action

On Wed, 4 Feb 2026 at 12:10, Xu Yang <xu.yang_2@nxp.com> wrote:
>
> Current design will power off all dependent GPC power domains in
> imx8mp_blk_ctrl_suspend(), even though the user device has enabled
> wakeup capability. The result is that wakeup function never works
> for such device.
>
> An example will be USB wakeup on i.MX8MP. PHY device '382f0040.usb-phy'
> is attached to power domain 'hsioblk-usb-phy2' which is spawned by hsio
> block control. A virtual power domain device 'genpd:3:32f10000.blk-ctrl'
> is created to build connection with 'hsioblk-usb-phy2' and it depends on
> GPC power domain 'usb-otg2'. If device '382f0040.usb-phy' enable wakeup,
> only power domain 'hsioblk-usb-phy2' keeps on during system suspend,
> power domain 'usb-otg2' is off all the time. So the wakeup event can't
> happen.
>
> In order to further establish a connection between the power domains
> related to GPC and block control during system pm, register a notifier
> to power_dev, so that GPC power domain will know that block control power
> domain is on and will not power off itself.
>
> Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
> Fixes: 556f5cf9568a ("soc: imx: add i.MX8MP HSIO blk-ctrl")
> Cc: stable@kernel.org
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

Applied for fixes and by amending the commit message a little bit to
make it clearer, thanks!

Kind regards
Uffe


>
> ---
> Changes in v2:
>  - add notifier to support wakeup needs
> ---
>  drivers/pmdomain/imx/imx8mp-blk-ctrl.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c b/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
> index 34576be606e3..56bbfee8668d 100644
> --- a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
> +++ b/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
> @@ -65,6 +65,7 @@ struct imx8mp_blk_ctrl_domain {
>         struct icc_bulk_data paths[DOMAIN_MAX_PATHS];
>         struct device *power_dev;
>         struct imx8mp_blk_ctrl *bc;
> +       struct notifier_block power_nb;
>         int num_paths;
>         int id;
>  };
> @@ -594,6 +595,20 @@ static int imx8mp_blk_ctrl_power_off(struct generic_pm_domain *genpd)
>         return 0;
>  }
>
> +static int imx8mp_blk_ctrl_gpc_notifier(struct notifier_block *nb,
> +                                       unsigned long action, void *data)
> +{
> +       struct imx8mp_blk_ctrl_domain *domain =
> +                       container_of(nb, struct imx8mp_blk_ctrl_domain, power_nb);
> +
> +       if (action == GENPD_NOTIFY_PRE_OFF) {
> +               if (domain->genpd.status == GENPD_STATE_ON)
> +                       return NOTIFY_BAD;
> +       }
> +
> +       return NOTIFY_OK;
> +}
> +
>  static struct lock_class_key blk_ctrl_genpd_lock_class;
>
>  static int imx8mp_blk_ctrl_probe(struct platform_device *pdev)
> @@ -698,6 +713,14 @@ static int imx8mp_blk_ctrl_probe(struct platform_device *pdev)
>                         goto cleanup_pds;
>                 }
>
> +               domain->power_nb.notifier_call = imx8mp_blk_ctrl_gpc_notifier;
> +               ret = dev_pm_genpd_add_notifier(domain->power_dev, &domain->power_nb);
> +               if (ret) {
> +                       dev_err_probe(dev, ret, "failed to add power notifier\n");
> +                       dev_pm_domain_detach(domain->power_dev, true);
> +                       goto cleanup_pds;
> +               }
> +
>                 domain->genpd.name = data->name;
>                 domain->genpd.power_on = imx8mp_blk_ctrl_power_on;
>                 domain->genpd.power_off = imx8mp_blk_ctrl_power_off;
> @@ -707,6 +730,7 @@ static int imx8mp_blk_ctrl_probe(struct platform_device *pdev)
>                 ret = pm_genpd_init(&domain->genpd, NULL, true);
>                 if (ret) {
>                         dev_err_probe(dev, ret, "failed to init power domain\n");
> +                       dev_pm_genpd_remove_notifier(domain->power_dev);
>                         dev_pm_domain_detach(domain->power_dev, true);
>                         goto cleanup_pds;
>                 }
> @@ -755,6 +779,7 @@ static int imx8mp_blk_ctrl_probe(struct platform_device *pdev)
>  cleanup_pds:
>         for (i--; i >= 0; i--) {
>                 pm_genpd_remove(&bc->domains[i].genpd);
> +               dev_pm_genpd_remove_notifier(bc->domains[i].power_dev);
>                 dev_pm_domain_detach(bc->domains[i].power_dev, true);
>         }
>
> @@ -774,6 +799,7 @@ static void imx8mp_blk_ctrl_remove(struct platform_device *pdev)
>                 struct imx8mp_blk_ctrl_domain *domain = &bc->domains[i];
>
>                 pm_genpd_remove(&domain->genpd);
> +               dev_pm_genpd_remove_notifier(domain->power_dev);
>                 dev_pm_domain_detach(domain->power_dev, true);
>         }
>
> --
> 2.34.1
>

