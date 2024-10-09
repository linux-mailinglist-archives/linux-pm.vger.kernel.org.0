Return-Path: <linux-pm+bounces-15398-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E70F996B86
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2024 15:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AB8A28305B
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2024 13:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC4F192D80;
	Wed,  9 Oct 2024 13:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vTRAmYFh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94883192B6D
	for <linux-pm@vger.kernel.org>; Wed,  9 Oct 2024 13:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728479741; cv=none; b=fesDI17y/zpoH/ryK1ZxAQOBr62NQ4n+36MptnOVFHd1gcWoXfm3rDBeYu70jOMidhS+W4FZ71MnK+rHeyd2tRAGyZ7i4LxofRPkGnajp4556P3SFziZg09vxnPk65Y7wD97L5HaGLNbGU4fRStmpJ9KDyTiSzbJ8O1rNo0kkr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728479741; c=relaxed/simple;
	bh=a/g/KSMW6CmKID3bt4x5A8ciB/In9mNPhttKBVqxwd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QZUwpz1AJa9Vu4zIggKWyWRjU4PcMIZhnpMwb0y+Xp+Qll38OhU1gD7Jr6izRuYWtsWMBZ/Zhg4fQj8ox4J1RfakMlyiyltRF18zj8q7T7BpNCsxRAoTUWAhXe0Gtdzs0yLiCthrfjcjjpIqsSiScP/3xpCzGlgk60ByVnl78t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vTRAmYFh; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e28ea358f65so780482276.0
        for <linux-pm@vger.kernel.org>; Wed, 09 Oct 2024 06:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728479738; x=1729084538; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X/BVh51Wei3dZ71+FMVXs9o7VKFoyrGm7h9GIR6kEtE=;
        b=vTRAmYFht/6gtE3EfOPePLxI7aJqqRSor3wPT3b9v9SPIfsSaDHxeBqnFCw77sTj1j
         vPk9a4fdpd+n/k3ICHYOKVrl18e2yhXregPVwLiTN7xpvkzVXOiSJh7K7iNBYp9Oh3cp
         zZuZ3NgiBNyPDY2cL5sJajnZiTMySkl70b8TAibMV1B4Ur8vrKzOScMZejcwAMzFlzUP
         VSr22scPyCzKIpkkiu3Xdl799I02aywApVnZdTqUe2zUNs90+TNoh3BwuSokcfu52HWA
         nTCFaXfh74V5uMs54ed5c2WgWZvSBDVUDm8cajaEqp+RzLiYMfkdaPL4qEuKy5OiuqUB
         8+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728479738; x=1729084538;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X/BVh51Wei3dZ71+FMVXs9o7VKFoyrGm7h9GIR6kEtE=;
        b=wQy72RFrq7CPR0d/nnkGCHsjNo2cdcP3SZa17DoTQTF9+HggGLZlezVyEJD5Z9Y5ew
         weKz1PVNiemRSDf72njh+R2PjFnxrYEGO590qe/Io2vHb614C3StUWuV2AQlhviutWJr
         ZBWUi/BxsPQABiY6mCMVuCgdNRix8Bt59R3IwqvEQxr9IHOb0U5RwtzW06KueKw/Vp25
         /iyXYTf3Gtihwf0V4HoHnQUohXShWdW/ASFjfpgljjY9P+2ClDP4lfvV6J4X3AX0yPKx
         ASfUL4MJQyOk9FirALrJ7FfRgMxGzF12ZxqA6f5cOa/NuRVX5Eod2RGJCeht5B2zFyJT
         oiEg==
X-Forwarded-Encrypted: i=1; AJvYcCUmSCxS1C4DbKHT5pYVMlHQgOpv0VGMec5bjolOaToSZRj3JBiqYUg12ym5EoazeGmjMtQNSrhWvg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4t7HHxs8IUm12tDpvGHuchJVwKkMPDQfQmvkNkP/mSWMmP2wC
	jkIaAeahsVcT5ySWrbrB9xqOvsMshwj3PFuI2rPIHedlaW+SLAhajfFA5FBxYEAs9cXUvsF5Nkl
	xSc/mw8BiqDp/sIWhW4v6SBqG+sI9h+nJ4IBGvA==
X-Google-Smtp-Source: AGHT+IHp9MRWyf8+0EngQ/HGstXTs67OY8NhmDANMfWbtr8KbjZARvSO50M8FTVHd6rQq5UIIfOKejL4W5ObG6+T/7A=
X-Received: by 2002:a05:6902:18d3:b0:e0b:4cb6:ec53 with SMTP id
 3f1490d57ef6-e28fe348682mr1747706276.3.1728479738519; Wed, 09 Oct 2024
 06:15:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1728368130-37213-1-git-send-email-shawn.lin@rock-chips.com> <1728368130-37213-6-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1728368130-37213-6-git-send-email-shawn.lin@rock-chips.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 9 Oct 2024 15:15:02 +0200
Message-ID: <CAPDyKForpLcmkqruuTfD6kkJhp_4CKFABWRxFVYNskGL1tjO=w@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] scsi: ufs: rockchip: initial support for UFS
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Rob Herring <robh+dt@kernel.org>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Avri Altman <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>, 
	YiFeng Zhao <zyf@rock-chips.com>, Liang Chen <cl@rock-chips.com>, linux-scsi@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

[...]

> +
> +static int ufs_rockchip_runtime_suspend(struct device *dev)
> +{
> +       struct ufs_hba *hba = dev_get_drvdata(dev);
> +       struct ufs_rockchip_host *host = ufshcd_get_variant(hba);
> +       struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);

pd_to_genpd() isn't safe to use like this. It's solely to be used by
genpd provider drivers.

> +
> +       clk_disable_unprepare(host->ref_out_clk);
> +
> +       /*
> +        * Shouldn't power down if rpm_lvl is less than level 5.

Can you elaborate on why we must not power-off the power-domain when
level is less than 5?

What happens if we power-off anyway when the level is less than 5?

> +        * This flag will be passed down to platform power-domain driver
> +        * which has the final decision.
> +        */
> +       if (hba->rpm_lvl < UFS_PM_LVL_5)
> +               genpd->flags |= GENPD_FLAG_RPM_ALWAYS_ON;
> +       else
> +               genpd->flags &= ~GENPD_FLAG_RPM_ALWAYS_ON;

The genpd->flags is not supposed to be changed like this - and
especially not from a genpd consumer driver.

I am trying to understand a bit more of the use case here. Let's see
if that helps me to potentially suggest an alternative approach.

> +
> +       return ufshcd_runtime_suspend(dev);
> +}
> +
> +static int ufs_rockchip_runtime_resume(struct device *dev)
> +{
> +       struct ufs_hba *hba = dev_get_drvdata(dev);
> +       struct ufs_rockchip_host *host = ufshcd_get_variant(hba);
> +       int err;
> +
> +       err = clk_prepare_enable(host->ref_out_clk);
> +       if (err) {
> +               dev_err(hba->dev, "failed to enable ref out clock %d\n", err);
> +               return err;
> +       }
> +
> +       reset_control_assert(host->rst);
> +       usleep_range(1, 2);
> +       reset_control_deassert(host->rst);
> +
> +       return ufshcd_runtime_resume(dev);
> +}
> +
> +static int ufs_rockchip_system_suspend(struct device *dev)
> +{
> +       struct ufs_hba *hba = dev_get_drvdata(dev);
> +       struct ufs_rockchip_host *host = ufshcd_get_variant(hba);
> +
> +       /* Pass down desired spm_lvl to Firmware */
> +       arm_smccc_smc(ROCKCHIP_SIP_SUSPEND_MODE, ROCKCHIP_SLEEP_PD_CONFIG,
> +                       host->pd_id, hba->spm_lvl < 5 ? 1 : 0, 0, 0, 0, 0, NULL);

Can you please elaborate on what goes on here? Is this turning off the
power-domain that the dev is attached to - or what is actually
happening?

> +
> +       return ufshcd_system_suspend(dev);
> +}
> +
> +static const struct dev_pm_ops ufs_rockchip_pm_ops = {
> +       SET_SYSTEM_SLEEP_PM_OPS(ufs_rockchip_system_suspend, ufshcd_system_resume)
> +       SET_RUNTIME_PM_OPS(ufs_rockchip_runtime_suspend, ufs_rockchip_runtime_resume, NULL)
> +       .prepare         = ufshcd_suspend_prepare,
> +       .complete        = ufshcd_resume_complete,
> +};
> +
> +static struct platform_driver ufs_rockchip_pltform = {
> +       .probe = ufs_rockchip_probe,
> +       .remove = ufs_rockchip_remove,
> +       .driver = {
> +               .name = "ufshcd-rockchip",
> +               .pm = &ufs_rockchip_pm_ops,
> +               .of_match_table = ufs_rockchip_of_match,
> +       },
> +};
> +module_platform_driver(ufs_rockchip_pltform);
> +

[...]

Kind regards
Uffe

