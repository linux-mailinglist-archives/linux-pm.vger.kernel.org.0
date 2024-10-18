Return-Path: <linux-pm+bounces-15938-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E7B9A3AC7
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 12:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 335CD283927
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 10:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0540A20103B;
	Fri, 18 Oct 2024 10:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F0MXG8dk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCE11EF94D
	for <linux-pm@vger.kernel.org>; Fri, 18 Oct 2024 10:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729245830; cv=none; b=RQh/BwBnsL1yhIOtOHztHUzIh0VrpgI88yMC0ZTko3OuOAoISneo3uIksc5dAI/SFariUEL9VNBDhz/T0q8ef1mHYfoxRHP67QaQIUYwJDcVpdWmhBxqASPncAgUepk1AJY5uaaVSlRpSpJ0VC2esjQxT6XsMcR0O7Srtprm9D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729245830; c=relaxed/simple;
	bh=DWyx/3YGe3huLlMU54X3fY0AM74cinw8tnManxqSsHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZhOjp0ZgGrpi8DukUOV3C5Vd2IMOrjQ997lfObNfPzOinaozDehcWhPuaeFu1Lf1hb4AlCeLhFRgQ/MQhvmTdJR5gwX0zHWhHOetYg0UqK8xaC1oK9xw8P3uud+NDvc+l/5hIctc+EGdY08JCHtCW5E6MGc0V0gn/GoNBFDHnBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F0MXG8dk; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e28e4451e0bso1698715276.0
        for <linux-pm@vger.kernel.org>; Fri, 18 Oct 2024 03:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729245828; x=1729850628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qhb0Ic3bcpMXH2km/HoGTBWj+bbxwR5zeev1bJh+028=;
        b=F0MXG8dkWvpgv2754gONbOH+2MoNpZ8xI8ubjla71ce1L6hCqus6lhWh5jbkj/zVfy
         EIu7vtbugPuhgdhUsmZKljJ3eC58UPRxN5aEy0IQ7MDaqg5+QgovKnSiTFgRy8N2sZEM
         AdfqqIKBgOIIi5IsaEFXKMnlI66BxhakJKOK1ICNXimraMwUDxo64PuwIY8w5OEnkpHi
         Uyk0oYv0jzIjEfOMfXpJwsLCKWDvodPr3xktuna5ga0Beo6igUJvvFlHeb3M0+4S4SsM
         argThhzAolCtpbosvw/tOprHnpkejGhYdgR6Ksaz/79mw3ZzNy/oPwq2cA6fLaGtfSpx
         3G5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729245828; x=1729850628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qhb0Ic3bcpMXH2km/HoGTBWj+bbxwR5zeev1bJh+028=;
        b=D/MEcU7+FCRuTADl5vOz4tIuF9psddMxgqfeppNXU1/p3YGB9ZSNouXxm0e97iesrB
         GJlt1Z/uOzQPwH/L+h7DlUkLD6qXOCuUUzZ+wTjFo8HUmM0zODeCq5j2t6tripDGtNLN
         frHKrtCyeVtrNKWCBWY7IQi0J8GbQyCaWna3RrlcKWZPSwBKUzlxRrmfbJVkwhqtGZDq
         bqI75BQ8Daw9+tVZROxvm43znW8tACyl0wpCN19GRd3hScEbCIrdzm4wbDJxgTRYFGa7
         vcoOYNpU0iQNy/BWU5IDjDnYXBvMdih/hg4e7jDBkFhuMY0XAaulFr+kmMo8LVl6WgLG
         jxFg==
X-Forwarded-Encrypted: i=1; AJvYcCXfMP352Mhlzyy+ouY3EMRgJwpkiZqFxN+wVTehaOwEkMcAxvYFw+PqByvFBjbqr1NHm3VPPnabYw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCXZZCgxuUTIAzsTZNRt5cHl25fwfc6QnP/J40JvMIn6k7APQi
	W/12SApVQAqVlqDOLKOLOFSdsEVvl1BFgjQZ90ZaJhXi21tz7L4/j+L8hZigVBw3+eDZ7i5RyHV
	5it6iMFjU4IMGW9hJxuFc388BNK2YoTT7Ayj7PQ==
X-Google-Smtp-Source: AGHT+IG6+GNKdTTardBqrOSFafCoHKmDQ8VI6s29ziEBvjyDm72unVmqb/41tRAeouig0145z02Jy13eFHz5Np1TynU=
X-Received: by 2002:a05:690c:112:b0:6e3:34ee:6780 with SMTP id
 00721157ae682-6e5bf9e2dd9mr14707267b3.22.1729245827020; Fri, 18 Oct 2024
 03:03:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1728368130-37213-1-git-send-email-shawn.lin@rock-chips.com>
 <1728368130-37213-6-git-send-email-shawn.lin@rock-chips.com>
 <CAPDyKForpLcmkqruuTfD6kkJhp_4CKFABWRxFVYNskGL1tjO=w@mail.gmail.com>
 <3969bae0-eeb8-447a-86a5-dfdac0b136cd@rock-chips.com> <CAPDyKFo=GcHG2sGQBrXJ7VWyp59QOmbLCAvHQ3krUympEkid_A@mail.gmail.com>
 <98e0062c-aeb1-4bea-aa2b-4a99115c9da4@rock-chips.com>
In-Reply-To: <98e0062c-aeb1-4bea-aa2b-4a99115c9da4@rock-chips.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 18 Oct 2024 12:03:10 +0200
Message-ID: <CAPDyKFogrPEEe1A3Kghjj3-SSJT2xEoKfo_hU7KZk+d9bZxEYQ@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable

On Fri, 18 Oct 2024 at 11:20, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> Hi Ulf,
>
> =E5=9C=A8 2024/10/18 17:07, Ulf Hansson =E5=86=99=E9=81=93:
> > On Thu, 10 Oct 2024 at 03:21, Shawn Lin <shawn.lin@rock-chips.com> wrot=
e:
> >>
> >> Hi Ulf
> >>
> >> =E5=9C=A8 2024/10/9 21:15, Ulf Hansson =E5=86=99=E9=81=93:
> >>> [...]
> >>>
> >>>> +
> >>>> +static int ufs_rockchip_runtime_suspend(struct device *dev)
> >>>> +{
> >>>> +       struct ufs_hba *hba =3D dev_get_drvdata(dev);
> >>>> +       struct ufs_rockchip_host *host =3D ufshcd_get_variant(hba);
> >>>> +       struct generic_pm_domain *genpd =3D pd_to_genpd(dev->pm_doma=
in);
> >>>
> >>> pd_to_genpd() isn't safe to use like this. It's solely to be used by
> >>> genpd provider drivers.
> >>>
> >>>> +
> >>>> +       clk_disable_unprepare(host->ref_out_clk);
> >>>> +
> >>>> +       /*
> >>>> +        * Shouldn't power down if rpm_lvl is less than level 5.
> >>>
> >>> Can you elaborate on why we must not power-off the power-domain when
> >>> level is less than 5?
> >>>
> >>
> >> Because ufshcd driver assume the controller is active and the link is =
on
> >> if level is less than 5. So the default resume policy will not try to
> >> recover the registers until the first error happened. Otherwise if the
> >> level is >=3D5, it assumes the controller is off and the link is down,
> >> then it will restore the registers and link.
> >>
> >> And the level is changeable via sysfs.
> >
> > Okay, thanks for clarifying.
> >
> >>
> >>> What happens if we power-off anyway when the level is less than 5?
> >>>
> >>>> +        * This flag will be passed down to platform power-domain dr=
iver
> >>>> +        * which has the final decision.
> >>>> +        */
> >>>> +       if (hba->rpm_lvl < UFS_PM_LVL_5)
> >>>> +               genpd->flags |=3D GENPD_FLAG_RPM_ALWAYS_ON;
> >>>> +       else
> >>>> +               genpd->flags &=3D ~GENPD_FLAG_RPM_ALWAYS_ON;
> >>>
> >>> The genpd->flags is not supposed to be changed like this - and
> >>> especially not from a genpd consumer driver.
> >>>
> >>> I am trying to understand a bit more of the use case here. Let's see
> >>> if that helps me to potentially suggest an alternative approach.
> >>>
> >>
> >> I was not familiar with the genpd part, so I haven't come up with
> >> another solution. It would be great if you can guide me to the right
> >> way.
> >
> > I have been playing with the existing infrastructure we have at hand
> > to support this, but I need a few more days to be able to propose
> > something for you.
> >
>
> Much appreciate.
>
> >>
> >>>> +
> >>>> +       return ufshcd_runtime_suspend(dev);
> >>>> +}
> >>>> +
> >>>> +static int ufs_rockchip_runtime_resume(struct device *dev)
> >>>> +{
> >>>> +       struct ufs_hba *hba =3D dev_get_drvdata(dev);
> >>>> +       struct ufs_rockchip_host *host =3D ufshcd_get_variant(hba);
> >>>> +       int err;
> >>>> +
> >>>> +       err =3D clk_prepare_enable(host->ref_out_clk);
> >>>> +       if (err) {
> >>>> +               dev_err(hba->dev, "failed to enable ref out clock %d=
\n", err);
> >>>> +               return err;
> >>>> +       }
> >>>> +
> >>>> +       reset_control_assert(host->rst);
> >>>> +       usleep_range(1, 2);
> >>>> +       reset_control_deassert(host->rst);
> >>>> +
> >>>> +       return ufshcd_runtime_resume(dev);
> >>>> +}
> >>>> +
> >>>> +static int ufs_rockchip_system_suspend(struct device *dev)
> >>>> +{
> >>>> +       struct ufs_hba *hba =3D dev_get_drvdata(dev);
> >>>> +       struct ufs_rockchip_host *host =3D ufshcd_get_variant(hba);
> >>>> +
> >>>> +       /* Pass down desired spm_lvl to Firmware */
> >>>> +       arm_smccc_smc(ROCKCHIP_SIP_SUSPEND_MODE, ROCKCHIP_SLEEP_PD_C=
ONFIG,
> >>>> +                       host->pd_id, hba->spm_lvl < 5 ? 1 : 0, 0, 0,=
 0, 0, NULL);
> >>>
> >>> Can you please elaborate on what goes on here? Is this turning off th=
e
> >>> power-domain that the dev is attached to - or what is actually
> >>> happening?
> >>>
> >>
> >> This smc call is trying to ask firmware not to turn off the power-domi=
an
> >> that the UFS is attached to and also not to turn off the power of UFS
> >> conntroller.
> >
> > Okay, thanks for clarifying!
> >
> > A follow up question, don't you need to make a corresponding smc call
> > to inform the FW that it's okay to turn off the power-domain at some
> > point?
> >
>
> Yes. Each time entering sleep, we teach FW if it need to turn off or
> keep power-domain, for instance "hba->spm_lvl < 5 ? 1 : 0" , 0 means
> off and 1 means on.

I see. So you need to make the call each time when entering the system susp=
end?

Or would it be okay to just make it once, when the spm_lvl is changed?

Another way to deal with it, would be to make the smc call each time
the power-domain is turned-on, based on spm_lvl too of course.

Would that work?

[...]

Kind regards
Uffe

