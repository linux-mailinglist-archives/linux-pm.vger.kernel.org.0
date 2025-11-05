Return-Path: <linux-pm+bounces-37483-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D93A6C38145
	for <lists+linux-pm@lfdr.de>; Wed, 05 Nov 2025 22:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5ED1534D838
	for <lists+linux-pm@lfdr.de>; Wed,  5 Nov 2025 21:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D90A2BE7AB;
	Wed,  5 Nov 2025 21:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mwd51ZFq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X+H35vH8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A832DF6F7
	for <linux-pm@vger.kernel.org>; Wed,  5 Nov 2025 21:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762379109; cv=none; b=Pc8bkrb4a6n6awZHDNPUmNH0VcU9IHHfc4nLO1LGKq3IY3qkoGI2SH6c9BrUNu6fKzCscX6AZGDFwykIywtJzUS8CHuckLLmBLgMTgoJkqgnXK4PcDY0Tj2BiUx0sTHq7OA2oh+QncxA75NZulLPq/oPz4TB87hsgRVNEueTqHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762379109; c=relaxed/simple;
	bh=sTpvEH7MtMYQ441h2hg3yomOuLMbsslLNNuXcPZ8oPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tOSzEz3OwSXL5eINVU6ovWUhGEPSXCfj6ms1DDIqDh+1WA+J7VlRnEbdburxBEIksgGjXcxPE3QP1GD/YTwOUESEB080/DoGtO23UycigBUSbgaiyBDiHBOdJqjoNPRQg0cYwHsp6CgfaKtWlZhmngXNWnXcRVqOuXKPvZzAWNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Mwd51ZFq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=X+H35vH8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A5KF2Q91738544
	for <linux-pm@vger.kernel.org>; Wed, 5 Nov 2025 21:45:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	d510Wyf9q4AIKtlBHb+XTDxyOHGNm5yfHON6dl5a5HE=; b=Mwd51ZFqBoaL8Bkc
	7Jpfo/6YbJLtj1eXBUGOf+hL5XkLONMs5nrx8Np2MkKpCMsv9VS7SYFeQsQjqcgs
	CXR0+3+fyCmA7ju8A9wm2Lfw0KSuFPLo5Vu72bz/KO7szgtUXvCksv2oY4b4ddrd
	pvMO/C1AauxvK2U45jMe4J581cXGE1mNJsytlTpELv0KmTjglbWoiCnCkSvnzaG1
	P4PogAs/qMSjxOIz4F80PFOC/Yo9Y7fOs9sgvcsWoGuBPGn76m2v266geGMJgYXK
	+garMy1vlr2/qpzuNZKdxQp1eWB6RSXuwTI01UzdBjl1RyW/gYys78Ww9MV1FcwH
	LJNRfg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8an3rsek-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 05 Nov 2025 21:45:06 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4e88c912928so7740801cf.0
        for <linux-pm@vger.kernel.org>; Wed, 05 Nov 2025 13:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762379105; x=1762983905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d510Wyf9q4AIKtlBHb+XTDxyOHGNm5yfHON6dl5a5HE=;
        b=X+H35vH8T4w5FRXECc1QLWe0MGTb6JFKEJi11AEerZcx9RwlVsdDLGpSCbcVNXEbVz
         Bb1WW7wjEWn48xqMLIfjVslQEfie0zKEFrJiX9aVECzlhHUUjS9z+g4wAOGhL0XwU+Yz
         CGj2vB2ficYmME019bWodrzuQz57rE8ibGAyF4o2iajZBpbqL65aR92T7YJ5sO1cRFAz
         /6tXwjIHFmHSiD0GDx5QvKR8FBSa6c1OeS/S4lBamWZvBKDVgFWMWzO4hV/A+Mw7sazD
         MxFxv3wj7B0hHTZphQ7YMSadWXfLnk8VF0hSYoBrs7l7JYbKs4NBqPtJ5gnuG5C49xKl
         2pDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762379105; x=1762983905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d510Wyf9q4AIKtlBHb+XTDxyOHGNm5yfHON6dl5a5HE=;
        b=p/1id66r5yP4jKYsq8hENH4NueLzq7UOWpFdZqApDpGhwGKuBakCY9S/NhpSEy+Qn/
         QouX3nGhH5nStKw3UNsx+QjnlBBdDIn44mMpkB3QDasTsY9GDhhR8xayHN2HC6eDCwJQ
         l+KgajTyJhJyovPMPQwut302aH2FWIezzrTykaRGhv+sJYvlM+cjdB0krAQ/wkbUg4Hx
         W6sqqxuyK1q/OKN500DVtlarz604Bu/ern/aZJ/nfgklte0IimLzznbtZA9rhi29eEyR
         e5s7dKrfp//aWAk8I+60UA6OZGCpsX7ziGdyJsE2LD3YzI0+rfzjMZIIJ2RQnbBBMPfn
         gCIw==
X-Forwarded-Encrypted: i=1; AJvYcCXZbFN0FmB80nO1FD7XWz5B/MrWLmPZpzlSD0LQIUSvEo1OERjdjR5bMQmq7Lf9CsO5OBb8F92mkA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8ac+vN5Tb9gYLuBTiXRcF5/gsZYGmTJh2cEpsIo98DPmc74Rc
	8WZcn1cRY26Lch0k52GlTOqm85flMuXogqh1Tp0QYw+C0k31cGFs0zHcvbI35C8GaLHg37LzgY1
	Dd8u5Z3AaYbLttm4BLKxhsygPlZQVaEP/mnn3zxBOBI3ZqoSD4KVv+wxglBERpxfjaDWl77l9b3
	zv96tQXRCEZFXamuwdCl//NQL7wk1tCMw3IXiyZvGPASvBcRw=
X-Gm-Gg: ASbGncvUUeJ+Mxhjv9qND2V1AlEd0fEfHFuxJFE9HbUaY9wodxXY7gPLqGuF6J6YfBw
	742zrYE8/jungBWgMQej6WOZ4KXmAPX4HeHz3vp3EjPBHFsTlCBed0MrNvi+eX+Zca+bq9ipMnJ
	Hy+DN/Mbpzc6+pidQQ8F8PkcbFvwiE8AJMaGseA9ZVpGe+KLElfkonttx0IXvwt16YddXmSjV3+
	mVhfBbrMIRRXVHJ
X-Received: by 2002:a05:622a:250f:b0:4e8:8c61:9541 with SMTP id d75a77b69052e-4ed72333ca7mr74105221cf.15.1762379105406;
        Wed, 05 Nov 2025 13:45:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFaI1ZzQY8wIv5ErLg/yOX3vvhB1oIeyOrna6TahfJhs8U5kaqahfMijiajL20qAT+T+bTQzZ83az4hjZX+b84=
X-Received: by 2002:a05:622a:250f:b0:4e8:8c61:9541 with SMTP id
 d75a77b69052e-4ed72333ca7mr74104741cf.15.1762379104947; Wed, 05 Nov 2025
 13:45:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103182006.1158383-1-loic.poulain@oss.qualcomm.com>
 <20251103182006.1158383-3-loic.poulain@oss.qualcomm.com> <740b9e7c-59bc-4a35-a268-526d92db372c@oss.qualcomm.com>
 <CAFEp6-12qN0=cv5=tPeVq3bVDLkaQDHLLCVQY4dtCTSvx+dPOQ@mail.gmail.com> <c1269f38-ab90-40d1-b5d3-39f546829d6c@oss.qualcomm.com>
In-Reply-To: <c1269f38-ab90-40d1-b5d3-39f546829d6c@oss.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 5 Nov 2025 22:44:53 +0100
X-Gm-Features: AWmQ_blKZDvJVEdUC2MqtJTQo81_2u9Bgl_-8p4Aiib23NEgqjzvd8wNzge29C0
Message-ID: <CAFEp6-1+inMhsgjSqAZ+UDBMuNc9DA-jXFyqB=gkvYpSzW9Ukg@mail.gmail.com>
Subject: Re: [PATCH 2/5] power: reset: qcom-pon: Add support for WARM reset
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: krzk+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        robh@kernel.org, conor+dt@kernel.org, sre@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=W981lBWk c=1 sm=1 tr=0 ts=690bc562 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8
 a=tqTozfVIN-WULQYvaOEA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: 44ZSIpc3e45ZugwdnWvPlnw44j1w_BM2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDE3MSBTYWx0ZWRfXzJ7OlXCUwSsp
 KlXKHhwkxq2eumYcg/N7XqJWO2wF2mDH8rB8qI5tvB7oeF8gfORNEt5qUssPDmxwsPJWH/HSR4/
 T2UhRD3bskKzWYnzYkVFas3UjvIJpbIsm8NPLEQgxsHmjQwlUAs2zau0DFGJzMRQCHQTpG9z4bi
 jhQQkc1TRfTy0iMLuYtynddnApbjCyPzLLvEFMU1zgfrfgLLTEQ5Iu3ArhxM6yLPFdh6hG97dL2
 s1fnQJk4Mk8E4NqBspOWxecz2XG+maFjFY8+D74qZxGomFSxvgqb/gHpdwdcc4mJtRnlNND4jdk
 BKUFqjlAvv0+vAKblnHiE5kiRGn1LQC4bNuEkYjY+rLzAu7arpPSQlCGuDyoFbG/GKG6thfhmGh
 WQxWJHH1VsMCH+o/ABZMrJD/iQPlww==
X-Proofpoint-ORIG-GUID: 44ZSIpc3e45ZugwdnWvPlnw44j1w_BM2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_08,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511050171

Hi Konrad,

On Tue, Nov 4, 2025 at 4:20=E2=80=AFPM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 11/4/25 4:01 PM, Loic Poulain wrote:
> > Hi Konrad, Krzysztof,
> >
> > On Tue, Nov 4, 2025 at 12:50=E2=80=AFPM Konrad Dybcio
> > <konrad.dybcio@oss.qualcomm.com> wrote:
> >>
> >> On 11/3/25 7:20 PM, Loic Poulain wrote:
> >>> This mechanism can be used when firmware lacks proper warm-reset hand=
ling,
> >>> for example, when the PSCI SYSTEM_RESET2 function is not implemented.
> >>> It enables the warm reset functionality via the PMIC.
> >>>
> >>> This fallback is only enabled if qcom,warm-reset property is present.
> >>>
> >>> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> >>> ---
> >>>  drivers/power/reset/qcom-pon.c | 47 ++++++++++++++++++++++++++++++++=
++
> >>>  1 file changed, 47 insertions(+)
> >>>
> >>> diff --git a/drivers/power/reset/qcom-pon.c b/drivers/power/reset/qco=
m-pon.c
> >>> index 7e108982a582..684e9fe9987d 100644
> >>> --- a/drivers/power/reset/qcom-pon.c
> >>> +++ b/drivers/power/reset/qcom-pon.c
> >>> @@ -19,12 +19,20 @@
> >>>
> >>>  #define NO_REASON_SHIFT                      0
> >>>
> >>> +#define PON_SW_RESET_S2_CTL                          0x62
> >>> +#define              PON_SW_RESET_S2_CTL_WARM_RST    0x01
> >>> +#define PON_SW_RESET_S2_CTL2                         0x63
> >>> +#define              PON_SW_RESET_S2_CTL2_RST_EN     BIT(7)
> >>> +#define PON_SW_RESET_GO                                      0x64
> >>> +#define              PON_SW_RESET_GO_MAGIC           0xa5
> >>
> >> Going back to msm8974 where the SPMI arbiter first showed up, these
> >> values are all seemingly valid, so I think we can drop the dt property=
.
> >> The restart reasons are set in stone too, and you can find more of the=
m
> >> in the register description.
> >
> > Yes, but this should only apply when the platform firmware does not
> > support warm reset via PSCI, right?
> > Making it unconditional would override the PSCI implementation even
> > when warm reset is supported.
> >
> > The point is that psci_sys_reset() executes a cold reset if warm
> > reset isn=E2=80=99t available. Therefore, our PMIC reboot notifier must=
 have a
> > higher priority than the PSCI handler.
> >
> > So maybe the alternative could be to introduce an additional reboot
> > handler in psci, with the lowest priority, so that warm reset can have
> > a chance to run either from the psci main reboot handler or from the
> > PMIC reboot handler before falling back to cold reset?
> > [PSCI-handler]->[other-handlers]->[PSCI-cold-reset-fallback-handler]
>
> This seems like a common enough problem, perhaps the framework could
> accept EOPNOTSUPP or similar and try to delegate further, coming back
> with a normal restart or so, if unsupported. Trying to make a special
> contract between qcom-pon and psci silently will be very fragile
> otherwise.

I tested the following, as described above:
https://github.com/loicpoulain/linux/commit/5c34ea54e1a21ff1192c3c341877b24=
eff5f80b4
The only special 'contract' is the handler priority.
If you can elaborate on another/better approach, that would be helpful.

>
> >> That said, we're circumventing PS_HOLD this way - is that intended?
> >
> > Well, we don=E2=80=99t have direct control over PS_HOLD since it=E2=80=
=99s managed by
> > the firmware in our case. That=E2=80=99s why I considered using the PMI=
C
> > software reset as an effective way to achieve this warm reset.
>
> Hm, so is there no longer a way to assert it by writing to PMIC
> registers?

PS_HOLD is a SoC signal, and we can maybe assert it via the
MPM_PS_HOLD register through the msm-poweroff driver if needed (well,
if access is allowed from a non-secure world).
However, this would also require coordination with the PMIC driver to
select the correct PS_HOLD action (shutdown, cold reset, warm reset).
For that reason, I=E2=80=99d prefer to keep PS_HOLD based logic abstracted =
by PSCI.
Using the SW_RST PMIC register allows us to perform a reset without
additional signal handling.

> >> And do we need to take any special care where there's more than one
> >> PMIC onboard to make sure that the SoC gets properly reset?
> >
> > Good point, this likely only matters if the other PMIC reboot handler
> > performs the same type of reset and their actions overlap.
>
> I think there used to be some logic in the older days where Linux would
> manually go over all PMICs with a PON and send a reset to them. Maybe
> that's too old for this platform though.
>
> Konrad
>
> > In that case, I may need to remove the mdelay from this handler.
> > Additionally, if we adopt the PSCI change discussed above, the system
> > will fall back to a cold reset when a PMIC-based reset isn=E2=80=99t po=
ssible.

Regards,
Loic

