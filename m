Return-Path: <linux-pm+bounces-16932-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B2A9BB045
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 10:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF313B23CCE
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 09:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC4E1AF0B3;
	Mon,  4 Nov 2024 09:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R0nlh7Jq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E0E1AD3E5
	for <linux-pm@vger.kernel.org>; Mon,  4 Nov 2024 09:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730713943; cv=none; b=U/PQysc72eHjxGgG2avbjQ/AwDoNjWPtEjmUDBkTZGsL62UAtuNa1IFejrq60KWXxRg6L/KyRYhWwJPoULjxSj4TxTMCZKt2Gz3I1xXfy4uJjpGjzMW3OJvb2FM1WUIpXNOTbeFEUM7SaOyFXBFUg+ZF9bOSekGY7P8x8+y2dbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730713943; c=relaxed/simple;
	bh=htvv2ldxMzj1c0babXojfnz7M65rvSO62jWp9rRBuLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UyzSvD/eGVqnndxBnNbDzWYIRaTEstTMrGohsG4rWbsi7t2e5+H322aN/u+w6nXBPINqMN+M2e2f9Alv2xAPDOCr7MEuN/dcXgIitvh/QdS5XuJnPu1TxMH++62Uj9YwhH5Y3MdYc9m+Bx9IQ4Zs0mPzOPel1eLnOypxx8XtZcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R0nlh7Jq; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6e390d9ad1dso32185547b3.3
        for <linux-pm@vger.kernel.org>; Mon, 04 Nov 2024 01:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730713941; x=1731318741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ybC/g10HAfyDHcrJc6E2zJthZS9rSbdAKDgt4jSd7Jg=;
        b=R0nlh7JqQBSsbgUD9In+kgpwzEZ9Hs3v4dTkQjnhLHBxkbXCT8OdoSQ+M2iipfrxCs
         kPKcD/ZFQOKef04LPIozz6Kh8N2O1e6yfgw1xK3q2jrzThuNyq3LCg/SKVPLOFMeb9Gm
         yIWorjmo2Lylf84fSKeFPW8+wSCZP1pPsNPUmy5ufj+qbW67NvboK3v+6hGuTC/jGSUL
         I6ckGS4g75M6Yq4MvHYR2TW4mMsgZur2ki2yeKbX6TNzxd9H8Do4wgQi4AVkKzu17ebT
         HEWbhFYsQwNiJaYdROw0fJYElXK+l7AQJSSOTd8ryhPfFbMaot6GdnxeP1DdIXucdxLV
         F7iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730713941; x=1731318741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ybC/g10HAfyDHcrJc6E2zJthZS9rSbdAKDgt4jSd7Jg=;
        b=uMDX+12v7iyri6I/1W/l2ElbL8d0W+qc3KLkQX+0dkmdw5lNc5/XCTl6t1iDA7jO3u
         uag2rNZqNdy5eMFDFph+eJ4XpTf8qcVs3uBRKNFc3+DVIZcVeSxq0Av91BcOr0YzX1Oo
         7lbkH6GrFpXcy/KYl7Rb3lDrm9rlEQIjmh+9PpFFiaZn4Yd/d57BiWNHUGU784iHv+WQ
         MrXr+BH8RFMNSbeSUCCZWSuGXILHn6DFDrXjhXG+zZ6MPSx2qbWyWxy5ywsudnxEILUV
         4TbKriyKhAZKHMOwNAKCt+3EZwyxh5wrkiwljbZK9ZBknpBXIA+rfcYkzmThbP5LnoXt
         m4pg==
X-Forwarded-Encrypted: i=1; AJvYcCUTcH8BtS2UDlvyqSQfeQGFuHYl4zkvMFKjFiHGH+012MLIYT/pySuxbzZcDndgs+vdUrGCG23jDg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzob3gipR9N7r1TGFItQ9ee1CrfnAFwuPJKkMWVQAImzHM/lq3Y
	/RQj7KBpVTgRlxfUWKThfk1Srj4Hb4eXptgwFwqnMuigs2LO0Z36dvqeD0H6cuCoKM6n1aRW39W
	ZMuhhtp8m7YPABRIHu6H7v3NPwSfG4qpSonc+7A==
X-Google-Smtp-Source: AGHT+IHSdMtnJp6l1SJWZqQt26XqnUQYugn+OdEkAPVBspbyRD2J5UPJxL4Tzt211JmThaoRmsKPftiBRc61oMrL7aQ=
X-Received: by 2002:a0d:e341:0:b0:6ea:6e90:7e3e with SMTP id
 00721157ae682-6ea6e9085cemr56164317b3.14.1730713940978; Mon, 04 Nov 2024
 01:52:20 -0800 (PST)
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
 <98e0062c-aeb1-4bea-aa2b-4a99115c9da4@rock-chips.com> <20241103120223.abkwgej4svas4epr@thinkpad>
 <6f3f2d17-4ca2-44ad-b8df-72986d4b3174@rock-chips.com>
In-Reply-To: <6f3f2d17-4ca2-44ad-b8df-72986d4b3174@rock-chips.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 4 Nov 2024 10:51:45 +0100
Message-ID: <CAPDyKFqMuFMf0+2+mPZaGGtBRfavg0LTkhbrCeqh7kHeqq-yZQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] scsi: ufs: rockchip: initial support for UFS
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
	Bart Van Assche <bvanassche@acm.org>, YiFeng Zhao <zyf@rock-chips.com>, Liang Chen <cl@rock-chips.com>, 
	linux-scsi@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 4 Nov 2024 at 07:38, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> =E5=9C=A8 2024/11/3 20:02, Manivannan Sadhasivam =E5=86=99=E9=81=93:
> > On Fri, Oct 18, 2024 at 05:20:08PM +0800, Shawn Lin wrote:
> >> Hi Ulf,
> >>
> >> =E5=9C=A8 2024/10/18 17:07, Ulf Hansson =E5=86=99=E9=81=93:
> >>> On Thu, 10 Oct 2024 at 03:21, Shawn Lin <shawn.lin@rock-chips.com> wr=
ote:
> >>>>
> >>>> Hi Ulf
> >>>>
> >>>> =E5=9C=A8 2024/10/9 21:15, Ulf Hansson =E5=86=99=E9=81=93:
> >>>>> [...]
> >>>>>
> >>>>>> +
> >>>>>> +static int ufs_rockchip_runtime_suspend(struct device *dev)
> >>>>>> +{
> >>>>>> +       struct ufs_hba *hba =3D dev_get_drvdata(dev);
> >>>>>> +       struct ufs_rockchip_host *host =3D ufshcd_get_variant(hba)=
;
> >>>>>> +       struct generic_pm_domain *genpd =3D pd_to_genpd(dev->pm_do=
main);
> >>>>>
> >>>>> pd_to_genpd() isn't safe to use like this. It's solely to be used b=
y
> >>>>> genpd provider drivers.
> >>>>>
> >>>>>> +
> >>>>>> +       clk_disable_unprepare(host->ref_out_clk);
> >>>>>> +
> >>>>>> +       /*
> >>>>>> +        * Shouldn't power down if rpm_lvl is less than level 5.
> >>>>>
> >>>>> Can you elaborate on why we must not power-off the power-domain whe=
n
> >>>>> level is less than 5?
> >>>>>
> >>>>
> >>>> Because ufshcd driver assume the controller is active and the link i=
s on
> >>>> if level is less than 5. So the default resume policy will not try t=
o
> >>>> recover the registers until the first error happened. Otherwise if t=
he
> >>>> level is >=3D5, it assumes the controller is off and the link is dow=
n,
> >>>> then it will restore the registers and link.
> >>>>
> >>>> And the level is changeable via sysfs.
> >>>
> >>> Okay, thanks for clarifying.
> >>>
> >>>>
> >>>>> What happens if we power-off anyway when the level is less than 5?
> >>>>>
> >>>>>> +        * This flag will be passed down to platform power-domain =
driver
> >>>>>> +        * which has the final decision.
> >>>>>> +        */
> >>>>>> +       if (hba->rpm_lvl < UFS_PM_LVL_5)
> >>>>>> +               genpd->flags |=3D GENPD_FLAG_RPM_ALWAYS_ON;
> >>>>>> +       else
> >>>>>> +               genpd->flags &=3D ~GENPD_FLAG_RPM_ALWAYS_ON;
> >>>>>
> >>>>> The genpd->flags is not supposed to be changed like this - and
> >>>>> especially not from a genpd consumer driver.
> >>>>>
> >>>>> I am trying to understand a bit more of the use case here. Let's se=
e
> >>>>> if that helps me to potentially suggest an alternative approach.
> >>>>>
> >>>>
> >>>> I was not familiar with the genpd part, so I haven't come up with
> >>>> another solution. It would be great if you can guide me to the right
> >>>> way.
> >>>
> >>> I have been playing with the existing infrastructure we have at hand
> >>> to support this, but I need a few more days to be able to propose
> >>> something for you.
> >>>
> >>
> >> Much appreciate.
> >>
> >>>>
> >>>>>> +
> >>>>>> +       return ufshcd_runtime_suspend(dev);
> >>>>>> +}
> >>>>>> +
> >>>>>> +static int ufs_rockchip_runtime_resume(struct device *dev)
> >>>>>> +{
> >>>>>> +       struct ufs_hba *hba =3D dev_get_drvdata(dev);
> >>>>>> +       struct ufs_rockchip_host *host =3D ufshcd_get_variant(hba)=
;
> >>>>>> +       int err;
> >>>>>> +
> >>>>>> +       err =3D clk_prepare_enable(host->ref_out_clk);
> >>>>>> +       if (err) {
> >>>>>> +               dev_err(hba->dev, "failed to enable ref out clock =
%d\n", err);
> >>>>>> +               return err;
> >>>>>> +       }
> >>>>>> +
> >>>>>> +       reset_control_assert(host->rst);
> >>>>>> +       usleep_range(1, 2);
> >>>>>> +       reset_control_deassert(host->rst);
> >>>>>> +
> >>>>>> +       return ufshcd_runtime_resume(dev);
> >>>>>> +}
> >>>>>> +
> >>>>>> +static int ufs_rockchip_system_suspend(struct device *dev)
> >>>>>> +{
> >>>>>> +       struct ufs_hba *hba =3D dev_get_drvdata(dev);
> >>>>>> +       struct ufs_rockchip_host *host =3D ufshcd_get_variant(hba)=
;
> >>>>>> +
> >>>>>> +       /* Pass down desired spm_lvl to Firmware */
> >>>>>> +       arm_smccc_smc(ROCKCHIP_SIP_SUSPEND_MODE, ROCKCHIP_SLEEP_PD=
_CONFIG,
> >>>>>> +                       host->pd_id, hba->spm_lvl < 5 ? 1 : 0, 0, =
0, 0, 0, NULL);
> >>>>>
> >>>>> Can you please elaborate on what goes on here? Is this turning off =
the
> >>>>> power-domain that the dev is attached to - or what is actually
> >>>>> happening?
> >>>>>
> >>>>
> >>>> This smc call is trying to ask firmware not to turn off the power-do=
mian
> >>>> that the UFS is attached to and also not to turn off the power of UF=
S
> >>>> conntroller.
> >>>
> >>> Okay, thanks for clarifying!
> >>>
> >>> A follow up question, don't you need to make a corresponding smc call
> >>> to inform the FW that it's okay to turn off the power-domain at some
> >>> point?
> >>>
> >>
> >> Yes. Each time entering sleep, we teach FW if it need to turn off or k=
eep
> >> power-domain, for instance "hba->spm_lvl < 5 ? 1 : 0" , 0 means
> >> off and 1 means on.
> >>
> >
> > We had a requirement to notify the genpd provider from consumer to not =
turn off
> > the power domain during system suspend. So Ulf came up with an API for
> > consumers, device_set_wakeup_path() setting the 'dev->power.wakeup_path=
' which
> > will be honored by the genpd core. Will that work for you?
>
> Yes, that works. And we may need a symmetrical call, for instance,
> device_clr_wakeup_path() to allow genpd provider to turn off the power
> domain as well.

The PM core clears the flag in device_prepare(). The flag is typically
supposed to be set from a ->suspend() callback, so there should be no
need for an additional function that clears the flag, I think.

[...]

Kind regards
Uffe

