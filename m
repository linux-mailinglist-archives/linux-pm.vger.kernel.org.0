Return-Path: <linux-pm+bounces-16903-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 060899BA55B
	for <lists+linux-pm@lfdr.de>; Sun,  3 Nov 2024 13:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57E86B218B3
	for <lists+linux-pm@lfdr.de>; Sun,  3 Nov 2024 12:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51CA17624D;
	Sun,  3 Nov 2024 12:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hJVBPcwC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B21156C40
	for <linux-pm@vger.kernel.org>; Sun,  3 Nov 2024 12:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730635352; cv=none; b=R94qLkaLl9OFahAbuMzrfG1qLnwGTC7BZtieWETaPRJfHumyyMPSvCClklfTNYdMzyxQT1l21Qb6BZ2IvkgZr5u5Jg7Tp0kw+yUwH+/oSFCZdkyqraFBIYLWuKhpqIo0zGgPsHthXgD0bLiheFvP8x4jsZy5tUt2KEUyCBhCnVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730635352; c=relaxed/simple;
	bh=EkfjY6qc7ZZqItUKau0nuoSNvJIwoZnbsM2jci2CLJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UepmhdsvlVamPMQ8aFUQ+r01v1VHv5p3ADbino5knkiHXRwTKu9s0bwMmlNn4QbO6KX6Np+IYUldWaTIV7SMl/YRjP/lpfilk13P0aq86dBlVih2NrsmWUFF33GA3aducOc40iaJc2O3Nhe475DK4nMxLkyILdWjECHYwNk8Ku4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hJVBPcwC; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-720d01caa66so1699257b3a.2
        for <linux-pm@vger.kernel.org>; Sun, 03 Nov 2024 04:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730635350; x=1731240150; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FUkXMfCkR70Uh4iKdLC2cSNlr1iFRoDLX5iaBLAzooI=;
        b=hJVBPcwCsw9LtJIDvKkvMshxn8/MJmw86JwpnKPSUfM/9it8j1U/IrfUjfVylwpqk8
         xAUzTaT22wSdlTyqF87Lm3+eB2KkLp1j8Is3eSCN5PiIEJtI80cIAlf+mCgupZMkVSsK
         8Hoiuq0OsbWyl5R0MtNf/w9GB++4FcP9ZX3b4Sqs5goxJk4rvyGfzheNXAc3aAYopmAe
         RxkL3WhDU/u0M0EXCNwtXPGJk4Nj5f0wftuYcDIxEcJVNPMlCLuAbkOHZIhv6XxBLzOe
         HjW1XUniGkBOHl1xGOSPmHywNh69vXjcrVbWN9g3Yc3ytCxEpgyXJQRkWjJksqTG6TQI
         K50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730635350; x=1731240150;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FUkXMfCkR70Uh4iKdLC2cSNlr1iFRoDLX5iaBLAzooI=;
        b=PqRk4mEY/mdllg+UCMdl7oi6ySMVWB7HIoGTLn2CLTs8NKSHyiAtFgLXyjdtO0/FXH
         gD9SG/pTxzQN9HKUeMLC+FA0UuVJi5nGz/Q+TiH2S9FHXEA8jYTtwVE3q3z3ARfw5P+y
         nSW9GpOlEMwmP/WE6nzlwSu/BkEiTTAgraNBPL19e43891EWdOzxKxtmP1R5Q4xLaZL3
         oZ9ilVxWiiUkKRBJ3t7VCWzyfG5zwWRkSkg3i1G8CoUiqH+MgOg/2t2f8D2A7b1a12CH
         Pu/C20g1cao8egImiJmTHC9o+EnnmUN0oe4d6abaap3NjWcZUYPCOiZQSO0Nxt7iGeO9
         6SVw==
X-Forwarded-Encrypted: i=1; AJvYcCX5dFWa/GPfAFyQJnuuNHKZYtEBJyFl169K9kzfOG209IzxZ5570v9U/9lqfdx/HseiMNfz3/eZ6w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzC5vRSoSdmPb5mKMu+RxSd5SqYlPwA0gFIgYyBjKq22O7HMR/S
	MUZpjsQ7iHbW7ziDqxaAWyBfyaIcr1puiunr0cJaBwKRW3JIk/agwK6RxBQXuQ==
X-Google-Smtp-Source: AGHT+IG67vE3Hy81Qa1sXK1wXZ0XGN5eh5NVCE1J0d5f1x/U0tyMLbeT3PWIyJgXlJE+GgOJ+sNXFQ==
X-Received: by 2002:a05:6a21:920b:b0:1d9:6ea3:9741 with SMTP id adf61e73a8af0-1db91d440eemr17725699637.4.1730635349968;
        Sun, 03 Nov 2024 04:02:29 -0800 (PST)
Received: from thinkpad ([220.158.156.209])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee459f8ee9sm5215196a12.72.2024.11.03.04.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 04:02:29 -0800 (PST)
Date: Sun, 3 Nov 2024 17:32:23 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	YiFeng Zhao <zyf@rock-chips.com>, Liang Chen <cl@rock-chips.com>,
	linux-scsi@vger.kernel.org, linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 5/5] scsi: ufs: rockchip: initial support for UFS
Message-ID: <20241103120223.abkwgej4svas4epr@thinkpad>
References: <1728368130-37213-1-git-send-email-shawn.lin@rock-chips.com>
 <1728368130-37213-6-git-send-email-shawn.lin@rock-chips.com>
 <CAPDyKForpLcmkqruuTfD6kkJhp_4CKFABWRxFVYNskGL1tjO=w@mail.gmail.com>
 <3969bae0-eeb8-447a-86a5-dfdac0b136cd@rock-chips.com>
 <CAPDyKFo=GcHG2sGQBrXJ7VWyp59QOmbLCAvHQ3krUympEkid_A@mail.gmail.com>
 <98e0062c-aeb1-4bea-aa2b-4a99115c9da4@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98e0062c-aeb1-4bea-aa2b-4a99115c9da4@rock-chips.com>

On Fri, Oct 18, 2024 at 05:20:08PM +0800, Shawn Lin wrote:
> Hi Ulf,
> 
> 在 2024/10/18 17:07, Ulf Hansson 写道:
> > On Thu, 10 Oct 2024 at 03:21, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> > > 
> > > Hi Ulf
> > > 
> > > 在 2024/10/9 21:15, Ulf Hansson 写道:
> > > > [...]
> > > > 
> > > > > +
> > > > > +static int ufs_rockchip_runtime_suspend(struct device *dev)
> > > > > +{
> > > > > +       struct ufs_hba *hba = dev_get_drvdata(dev);
> > > > > +       struct ufs_rockchip_host *host = ufshcd_get_variant(hba);
> > > > > +       struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
> > > > 
> > > > pd_to_genpd() isn't safe to use like this. It's solely to be used by
> > > > genpd provider drivers.
> > > > 
> > > > > +
> > > > > +       clk_disable_unprepare(host->ref_out_clk);
> > > > > +
> > > > > +       /*
> > > > > +        * Shouldn't power down if rpm_lvl is less than level 5.
> > > > 
> > > > Can you elaborate on why we must not power-off the power-domain when
> > > > level is less than 5?
> > > > 
> > > 
> > > Because ufshcd driver assume the controller is active and the link is on
> > > if level is less than 5. So the default resume policy will not try to
> > > recover the registers until the first error happened. Otherwise if the
> > > level is >=5, it assumes the controller is off and the link is down,
> > > then it will restore the registers and link.
> > > 
> > > And the level is changeable via sysfs.
> > 
> > Okay, thanks for clarifying.
> > 
> > > 
> > > > What happens if we power-off anyway when the level is less than 5?
> > > > 
> > > > > +        * This flag will be passed down to platform power-domain driver
> > > > > +        * which has the final decision.
> > > > > +        */
> > > > > +       if (hba->rpm_lvl < UFS_PM_LVL_5)
> > > > > +               genpd->flags |= GENPD_FLAG_RPM_ALWAYS_ON;
> > > > > +       else
> > > > > +               genpd->flags &= ~GENPD_FLAG_RPM_ALWAYS_ON;
> > > > 
> > > > The genpd->flags is not supposed to be changed like this - and
> > > > especially not from a genpd consumer driver.
> > > > 
> > > > I am trying to understand a bit more of the use case here. Let's see
> > > > if that helps me to potentially suggest an alternative approach.
> > > > 
> > > 
> > > I was not familiar with the genpd part, so I haven't come up with
> > > another solution. It would be great if you can guide me to the right
> > > way.
> > 
> > I have been playing with the existing infrastructure we have at hand
> > to support this, but I need a few more days to be able to propose
> > something for you.
> > 
> 
> Much appreciate.
> 
> > > 
> > > > > +
> > > > > +       return ufshcd_runtime_suspend(dev);
> > > > > +}
> > > > > +
> > > > > +static int ufs_rockchip_runtime_resume(struct device *dev)
> > > > > +{
> > > > > +       struct ufs_hba *hba = dev_get_drvdata(dev);
> > > > > +       struct ufs_rockchip_host *host = ufshcd_get_variant(hba);
> > > > > +       int err;
> > > > > +
> > > > > +       err = clk_prepare_enable(host->ref_out_clk);
> > > > > +       if (err) {
> > > > > +               dev_err(hba->dev, "failed to enable ref out clock %d\n", err);
> > > > > +               return err;
> > > > > +       }
> > > > > +
> > > > > +       reset_control_assert(host->rst);
> > > > > +       usleep_range(1, 2);
> > > > > +       reset_control_deassert(host->rst);
> > > > > +
> > > > > +       return ufshcd_runtime_resume(dev);
> > > > > +}
> > > > > +
> > > > > +static int ufs_rockchip_system_suspend(struct device *dev)
> > > > > +{
> > > > > +       struct ufs_hba *hba = dev_get_drvdata(dev);
> > > > > +       struct ufs_rockchip_host *host = ufshcd_get_variant(hba);
> > > > > +
> > > > > +       /* Pass down desired spm_lvl to Firmware */
> > > > > +       arm_smccc_smc(ROCKCHIP_SIP_SUSPEND_MODE, ROCKCHIP_SLEEP_PD_CONFIG,
> > > > > +                       host->pd_id, hba->spm_lvl < 5 ? 1 : 0, 0, 0, 0, 0, NULL);
> > > > 
> > > > Can you please elaborate on what goes on here? Is this turning off the
> > > > power-domain that the dev is attached to - or what is actually
> > > > happening?
> > > > 
> > > 
> > > This smc call is trying to ask firmware not to turn off the power-domian
> > > that the UFS is attached to and also not to turn off the power of UFS
> > > conntroller.
> > 
> > Okay, thanks for clarifying!
> > 
> > A follow up question, don't you need to make a corresponding smc call
> > to inform the FW that it's okay to turn off the power-domain at some
> > point?
> > 
> 
> Yes. Each time entering sleep, we teach FW if it need to turn off or keep
> power-domain, for instance "hba->spm_lvl < 5 ? 1 : 0" , 0 means
> off and 1 means on.
> 

We had a requirement to notify the genpd provider from consumer to not turn off
the power domain during system suspend. So Ulf came up with an API for
consumers, device_set_wakeup_path() setting the 'dev->power.wakeup_path' which
will be honored by the genpd core. Will that work for you?

PS: The API naming suggests that the device will be used in wakeup path, which
may not be true here but the end result will be the same.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

