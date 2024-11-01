Return-Path: <linux-pm+bounces-16878-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A43B9B941A
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2024 16:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 918F51F21B30
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2024 15:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BF21B5821;
	Fri,  1 Nov 2024 15:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ph5IbnT3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27ADC19F43B
	for <linux-pm@vger.kernel.org>; Fri,  1 Nov 2024 15:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730474002; cv=none; b=pf3aabrYNGzUzMlgGHgmkVi3X7/2fkCXmL8Y4mbQQHwz3NZSMRnzF6It3IffcR0u3a5cNs2PznrY4A1dJrBm5d97dm/1Yc1UQG64fs5Qib9wxHvZVfMuinOP+izT5yTSsM2XS3OJeDIwqkPjHwh98YFS+EPxhiTvFTpXpUI58So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730474002; c=relaxed/simple;
	bh=osRQ+RZWLj+AYM7cQ5yilscfwVziBpxY2XO0bulRGCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XC1TMXq2aCs8dCOwOr6gpoTwMzeeew9I6cOF8xg3wbGU7MOsvhJGVyYOMRGNSXualSnSFuTB6KV7KCSkslqqf/Sfe94bsoVdgADD4Ylws7CRquXc61TO8x5FGxRShFrSsKsww26agouAmz8LJacS0bXMh1DHSt6bu39V1dtxBwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ph5IbnT3; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6e59a9496f9so22724747b3.0
        for <linux-pm@vger.kernel.org>; Fri, 01 Nov 2024 08:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730473998; x=1731078798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zES54kMlytNhC3JsT3i+sHG7GrPK9sMY0hGKr+MdDxU=;
        b=Ph5IbnT3Pt0XjfF259YYlx8jLxcPJJQfU7k0OJITnF6GiaT5ztm+Yvo6gP5rL8Hw5I
         3AJRKKBCOOfqA2CsEDb2uQSL4WkoXHJxpr9W0nIPLokz6GXSvAnPftsO+2Kj74qYQxJ3
         NGs/IQbhakWalJSQeNtaUKtSLA4FBsQ9IM2gjG4OwUHobBeBUdiMwgkb/1n5WUlDAdup
         CoWl6QTPG7u+kKYmuRJmUI7nBX+R0eT9CRqU0GCeU1fEU1Bslfp9HfivcCDutJtU/XpV
         7Or2T+lj3q8noxbqNLiD4FlOzCetnMl0w6Ubgv64MdNVoOJBX6zmWm6IG+Yg92yNJFml
         cZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730473998; x=1731078798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zES54kMlytNhC3JsT3i+sHG7GrPK9sMY0hGKr+MdDxU=;
        b=GmWVtGKHlPNH6QLV7+T0BIA8glHoxZr5Cemq3F+NC8DYTx9n5xlUHC3dwfrFgaXDiz
         DiOv1RxEtHc7dbVQ/6gbvHgJ6/3LoXyuQJb+RAcFUVxCwLktsqrsXv9GNet01zSWT8mk
         xKIy/nznkcKTRO6uhwoU9vB2CTnuWbLyKD1G2Onpjxwq8vCU8bUqzHpCJZ7PjbMLWAHF
         aWi7mUDgsdg26rS8e0/NOtxxeIkK0M+ubJsbNHzXAbltAvnOLkn7psiGGl7z8PW6y473
         dO3+EsB+mu1qy6R9fbZtRShYWmkVT28JI+uUde5715bW14x36CdMxbgpwVnun7G5WnDg
         0MMg==
X-Forwarded-Encrypted: i=1; AJvYcCXQwCwNYAiqBh1hPsUbizDyHjgtFDgpapALfNJsN17J9lGq7ukgNgtcRO65DdGjweMdiK0dfG3Oug==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ+R2PbU/S9zDuxrlotWa1hLJGo/JNxlkw0TBaf3BYk8HNTCCq
	UE/JSG82hHeGYWjPSQJfPUN4+u9+pQDIUDYfHqP1OkXAPIArgXgE6snxSc2eKS0Nv7k7zUwWLos
	PPE/hhquT82rinz0suwb/gVlfqOswwEpV9QkBhA==
X-Google-Smtp-Source: AGHT+IEEamT/xKfAUGaesopTqBWT/apP4Kv+VG3xjRY9Ma5/g0qbUEyYkaFlkP7mkqQPtRAKMQNzTMNQ1ycdAb3IcSo=
X-Received: by 2002:a05:690c:6303:b0:6db:ddea:eab4 with SMTP id
 00721157ae682-6ea52551b4cmr88354767b3.37.1730473997897; Fri, 01 Nov 2024
 08:13:17 -0700 (PDT)
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
 <98e0062c-aeb1-4bea-aa2b-4a99115c9da4@rock-chips.com> <CAPDyKFogrPEEe1A3Kghjj3-SSJT2xEoKfo_hU7KZk+d9bZxEYQ@mail.gmail.com>
 <90ff835d-f3b2-4b7c-aa1a-575e231a57e6@rock-chips.com>
In-Reply-To: <90ff835d-f3b2-4b7c-aa1a-575e231a57e6@rock-chips.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 1 Nov 2024 16:12:41 +0100
Message-ID: <CAPDyKFouCV3hCcJ9VuS0App34YyBd6vVNSJr6JZbYGGpffwaWA@mail.gmail.com>
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

On Mon, 21 Oct 2024 at 02:43, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> =E5=9C=A8 2024/10/18 18:03, Ulf Hansson =E5=86=99=E9=81=93:
> > On Fri, 18 Oct 2024 at 11:20, Shawn Lin <shawn.lin@rock-chips.com> wrot=
e:
> >>
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
> >> Yes. Each time entering sleep, we teach FW if it need to turn off or
> >> keep power-domain, for instance "hba->spm_lvl < 5 ? 1 : 0" , 0 means
> >> off and 1 means on.
> >
> > I see. So you need to make the call each time when entering the system =
suspend?
> >
> > Or would it be okay to just make it once, when the spm_lvl is changed?
>
> Thers is no nofity when changing spm_lvl.
>
> >
> > Another way to deal with it, would be to make the smc call each time
> > the power-domain is turned-on, based on spm_lvl too of course.
> >
> > Would that work?
>
> Yes, that works. Another option is to cache power-domain states and
> check spm_lvl locally. If it doesn't change, we skip smc call.

Apologize for the delay! I needed to think a bit more carefully about
how to suggest moving this forward.

My conclusion is that we need to extend the PM domain infrastructure
(genpd in particular), to allow drivers to dynamically inform whether
it's okay to turn on/off the PM domain in runtime.

There is a similar thing already available, which is to use dev PM qos
along with the genpd governor, but that would not work in this case
because it may prevent runtime suspend for the device in question too.
I have therefore cooked a patch for genpd, see below. I think you can
fold it into your next version of the series. See also additional
suggestions below the patch.

From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 1 Nov 2024 15:55:56 +0100
Subject: [PATCH] pmdomain: core: Introduce dev_pm_genpd_rpm_always_on()

For some usecases a consumer driver requires its device to remain power-on
from the PM domain perspective during runtime. Using dev PM qos along with
the genpd governors, doesn't work for this case as would potentially
prevent the device from being runtime suspended too.

To support these usecases, let's introduce dev_pm_genpd_rpm_always_on() to
allow consumers drivers to dynamically control the behaviour in genpd for a
device that is attached to it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/core.c   | 34 ++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h |  7 +++++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index a6c8b85dd024..e86e270b7eb9 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -697,6 +697,36 @@ bool dev_pm_genpd_get_hwmode(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_pm_genpd_get_hwmode);

+/**
+ * dev_pm_genpd_rpm_always_on() - Control if the PM domain can be powered =
off.
+ *
+ * @dev: Device for which the PM domain may need to stay on for.
+ * @on: Value to set or unset for the condition.
+ *
+ * For some usecases a consumer driver requires its device to remain power=
-on
+ * from the PM domain perspective during runtime. This function allows the
+ * behaviour to be dynamically controlled for a device attached to a genpd=
.
+ *
+ * It is assumed that the users guarantee that the genpd wouldn't be detac=
hed
+ * while this routine is getting called.
+ *
+ * Return: Returns 0 on success and negative error values on failures.
+ */
+int dev_pm_genpd_rpm_always_on(struct device *dev, bool on)
+{
+       struct generic_pm_domain *genpd;
+
+       genpd =3D dev_to_genpd_safe(dev);
+       if (!genpd)
+               return -ENODEV;
+
+       genpd_lock(genpd);
+       dev_gpd_data(dev)->rpm_always_on =3D on;
+       genpd_unlock(genpd);
+
+       return 0;
+}
+
 static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
 {
        unsigned int state_idx =3D genpd->state_idx;
@@ -868,6 +898,10 @@ static int genpd_power_off(struct
generic_pm_domain *genpd, bool one_dev_on,
                if (!pm_runtime_suspended(pdd->dev) ||
                        irq_safe_dev_in_sleep_domain(pdd->dev, genpd))
                        not_suspended++;
+
+               /* The device may need its PM domain to stay powered on. */
+               if (to_gpd_data(pdd)->rpm_always_on)
+                       return -EBUSY;
        }

        if (not_suspended > 1 || (not_suspended =3D=3D 1 && !one_dev_on))
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 45646bfcaf1a..d4c4a7cf34bd 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -260,6 +260,7 @@ struct generic_pm_domain_data {
        unsigned int rpm_pstate;
        unsigned int opp_token;
        bool hw_mode;
+       bool rpm_always_on;
        void *data;
 };

@@ -292,6 +293,7 @@ ktime_t dev_pm_genpd_get_next_hrtimer(struct device *de=
v);
 void dev_pm_genpd_synced_poweroff(struct device *dev);
 int dev_pm_genpd_set_hwmode(struct device *dev, bool enable);
 bool dev_pm_genpd_get_hwmode(struct device *dev);
+int dev_pm_genpd_rpm_always_on(struct device *dev, bool on);

 extern struct dev_power_governor simple_qos_governor;
 extern struct dev_power_governor pm_domain_always_on_gov;
@@ -375,6 +377,11 @@ static inline bool dev_pm_genpd_get_hwmode(struct
device *dev)
        return false;
 }

+static inline int dev_pm_genpd_rpm_always_on(struct device *dev, bool on)
+{
+       return -EOPNOTSUPP;
+}
+
 #define simple_qos_governor            (*(struct dev_power_governor *)(NUL=
L))
 #define pm_domain_always_on_gov                (*(struct
dev_power_governor *)(NULL))
 #endif
--=20
2.43.0

Furthermore, I believe the way forward could be like this:

*) The arm smc call to inform the FW whether it's okay to turn off (or
not turn off) the PM domain for the UFS controller really belongs in
the genpd provider. More precisely, from the corresponding genpd's
->power_on() callback, we should send the smc call that prevents
power-off and in the ->power_off() callback we should send the smc
call that allows power-off again. No matter of what the spm|rpm_level
is set to. If you think caching of the state is important, I suggest
looking into that as an improvement on top.

*) In the UFS controller driver, we should call the new
dev_pm_genpd_rpm_always_on() to control whether the PM domain should
remain on during runtime or is allowed to be turned off.

*) In the system suspend callback, based on the spm|rpm_level (I guess
only one of those levels is really needed?), we may call
device_awake_path(). This can prevent genpd from turning off the PM
domain during system suspend in those cases when that is needed. See
genpd_finish_suspend() more details. Also note that, the genpd in
question also needs the GENPD_FLAG_ACTIVE_WAKEUP bit set for it, if
not already.

Kind regards
Uffe

