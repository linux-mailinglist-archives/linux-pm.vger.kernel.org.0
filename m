Return-Path: <linux-pm+bounces-37370-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C34C31BEE
	for <lists+linux-pm@lfdr.de>; Tue, 04 Nov 2025 16:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9051A18C4694
	for <lists+linux-pm@lfdr.de>; Tue,  4 Nov 2025 15:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14DC331A7F;
	Tue,  4 Nov 2025 15:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ijYEQYB1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XW6jH35x"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201FD3321A3
	for <linux-pm@vger.kernel.org>; Tue,  4 Nov 2025 15:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762268531; cv=none; b=Cu/O8MocNEwsrEOIIl/AVNn1q7gZ3YNkyxe5lcXGxoEzzNBkJ7MiKK0KG7iHUBHeOlATqs37PQNp5h7oxVVlI1ma28nRluB2lq79/seoXtcipDe/d9Ywkiv70tbveayyxKReT9BOgFkMAhP5GMnpIBprjzpPETY/B/tU7lBi08A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762268531; c=relaxed/simple;
	bh=c8e22kRqSacmwiYHoC8Dyh4yceaOYndzSAF92c/ZUxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RKIWEPCKsvCeNFyqGyV/VsRRDAn11RxTLQwAqh1JE7vH9uTO/xIcFkwgSc/A7/kmYPF+f4w18OeWaZjw41+XUx+mmyNwE9inFI4vHDAatf2lWTH/s1mgpoTQ9KOklhCrnAunuIGBtcb/94im8AhJAl68m76vyVmEjrk6kp39Qis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ijYEQYB1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XW6jH35x; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A4Cfu0v1912097
	for <linux-pm@vger.kernel.org>; Tue, 4 Nov 2025 15:02:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2SxqQqRUHUrLNDT8YiVNiakScX9nCN9ghEx97Z9mYuY=; b=ijYEQYB1w1W2t1ve
	dSiosYrscK/YTorK8lSENmYWMVclTKvllxaoDgoDAKSPNP/d6IA8QxIrubM0sRHz
	VodEEHXAVm7bMtrS3u503FUS6UnAwW6zjt17opwg+myF4QO+GOyrU/ueBa0JWDKv
	X/BmHIR8tpGI3r2lbhkZIC0PzDr+fSEJymNalnbddAO/yk4NcoR8GmGu61DfeUOb
	Lm5bwInlAgEPESdyyFx4mGmdCebGWWdh00CWLldvgLuXVU/jJuRukGT8cWSrZs53
	c/2J0Cu24DncP6rHs+/opvc7IWZKHJ3mOVaFcZ7lFHAzILjOYgA9LvIiztR3LTG5
	Ne99Zw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a70exk9rx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 04 Nov 2025 15:02:09 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-78f28554393so114880176d6.0
        for <linux-pm@vger.kernel.org>; Tue, 04 Nov 2025 07:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762268528; x=1762873328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2SxqQqRUHUrLNDT8YiVNiakScX9nCN9ghEx97Z9mYuY=;
        b=XW6jH35xYhQ3vNyuGwgHktvQILDdDsHJeuKekzV8BKc2nZt6CRpkjXEH0/kkhmhafx
         TepP20NzsRHKBdCeoe+mjyWTSd/VaQHBB4LJTc6eF5+IBzxFT8Zil8GSCmK96w4g1yqF
         d+iTauIt5kQ6tGyF9ioejHxaEJ1u0nJYAIZqBGJiDW+vV/oznWxO3p027ITDHZzq94xw
         LLV7Xhxeyy/WwQsrVr+wpHKRmZzNTgf5BX2K8Ta3vc57N136YRxXH0sPQD5X+v9tkgLG
         gLjLPrfRLKt38yImCFVy7ZtKiH8i8OMEKOLEazbdC54fzoJjyREF7BgWOxJZ/nJCkwdn
         bhVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762268528; x=1762873328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2SxqQqRUHUrLNDT8YiVNiakScX9nCN9ghEx97Z9mYuY=;
        b=UMKaTKTOw2PfzfUr9G4x7x7pIB6Gfuj7tsl01Qw8zaF0YGG6T/V4IaPUsDU2hUnWo0
         FnBdxTf5KJepOXzXVUIrpdepcQN1rZxutyl5XSTZCkAiwCBU0uuHZFmia6Mr8EXFoara
         gmEJOhGWYG0Ez6ZA5c475a2UsEELTiZgwE/8SClpLiP+RO++w6Ok/XstznzBHIyM7psq
         RUg+qvYq83rG3fLsOhuhyIsFseHgmvqHK7TyT0FEdgrU2VHMhz/c8oAammhw/EFG7HrD
         5zeiyum3nycn+FRfI52bpbuTtcFux7vL0JTv0oUyY3rGH8+iYaeuRNLAXX6QLNGCk2Ps
         rozw==
X-Forwarded-Encrypted: i=1; AJvYcCX5I+uDyci2j7E9XJDvpGzx9TuHMDogWKgxOm0DF0WL839OrOGGgbO64sAoFgvn0vwuZuDcMoP5Qw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxXF5Pfzk1WQsBMT/w48oJ/nzHyR/+uf2kSp8N+tsECWXs1oQBC
	BaI8ZiDSjddAO3+VN668SIVFRf7/oxUit1FchB1wtWKhcqc5tBUzlBsrpv83Vu0WObwAAB6evYw
	bdCaY3oWDbJpn69BIvgGOycZ8P8DqygHM7Ii80xRWNoLZg8qFR7JMDnXPA5njsSm3HKVMaHrjJ9
	auDF66xzqLnjUc14L0VKZxmeX3uzqjYxPYe3d6
X-Gm-Gg: ASbGncsY9zWL9AXSSRComKpmN4K12xJsHT4u2QTmOGkeaxRQYZRphAo3o+Vgw2vWh7c
	JHdHMkkrhSxmO4RGUF+VecO0rxmcMUhgLWSyPVumn5Ujjr5KSDl2zY5ifKcfBPJEK1N2NfbgrJd
	XNMiR4OkKsTxt/6TLRj9nDsLjlybBGldHrUGb2cLDN8+hDa2C2wpo2O6rZskMQsjH562Zq9T5ZW
	qiVVvtQsP7t7gxWgA==
X-Received: by 2002:a05:6214:2b0d:b0:87f:bd05:1c89 with SMTP id 6a1803df08f44-8802f48776dmr194432666d6.35.1762268528041;
        Tue, 04 Nov 2025 07:02:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxKN0H4L6vAkfeKG8utrTy+cN39n5ZU9+teK/D0cVGg3veosGw4Et8q8U99gCtvjuWcz3SCBMiw10fyfbVmMs=
X-Received: by 2002:a05:6214:2b0d:b0:87f:bd05:1c89 with SMTP id
 6a1803df08f44-8802f48776dmr194431686d6.35.1762268527234; Tue, 04 Nov 2025
 07:02:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103182006.1158383-1-loic.poulain@oss.qualcomm.com>
 <20251103182006.1158383-3-loic.poulain@oss.qualcomm.com> <740b9e7c-59bc-4a35-a268-526d92db372c@oss.qualcomm.com>
In-Reply-To: <740b9e7c-59bc-4a35-a268-526d92db372c@oss.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 4 Nov 2025 16:01:55 +0100
X-Gm-Features: AWmQ_bl0vq__j_0dS4NGs8HZUDkAYcPOQyYwuXU8uaQnQMR3_bjEbBEjL_JYoxk
Message-ID: <CAFEp6-12qN0=cv5=tPeVq3bVDLkaQDHLLCVQY4dtCTSvx+dPOQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] power: reset: qcom-pon: Add support for WARM reset
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, krzk+dt@kernel.org
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        conor+dt@kernel.org, sre@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=APHuRV3Y c=1 sm=1 tr=0 ts=690a1571 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=KzhPQNux5uk0tbSkIHQA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: pnmY1IcNL7fHE_tqboIXhjqXxnv_1J5L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDEyNSBTYWx0ZWRfX9QMJXHD/KPAr
 fHtkrdIqKzUyrcF9NDbA+Ueu4oxZmMAtEBpHadxnjN42dXLdVgA3j+OogFtXNQNwhZbGIqcXrPc
 uOb8WdGUSSGNkPMgBY9kAI5JGRGjO6wkMSPh138rzq6XSACP/T6gRo2S45Ew1Th1qJXtF1x9eYO
 GP7ww+x0C+ttysYT3iZwmOV2YDtUJlUkzz/SYhnni+iqskZvZlegcQvy/HaG7gkgfENg4ejEytv
 j5k+2OOsT6pGCJmwKYKj5CVXnMeJpERr64Vt04vfbuhB6BS0gvUsPvVSz4+rk5+Kb9GcqM1Bb42
 pyrJCQlCdxNWoAvE3AE6KTFsRHspUtkGgBTdWoxWsTzgNa0JP9F2fFSKIZFnSGDt8rDBKHBy+xr
 vxEPXNvVVvh4w+n99dMT/5do1jkUNQ==
X-Proofpoint-ORIG-GUID: pnmY1IcNL7fHE_tqboIXhjqXxnv_1J5L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_01,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511040125

Hi Konrad, Krzysztof,

On Tue, Nov 4, 2025 at 12:50=E2=80=AFPM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 11/3/25 7:20 PM, Loic Poulain wrote:
> > This mechanism can be used when firmware lacks proper warm-reset handli=
ng,
> > for example, when the PSCI SYSTEM_RESET2 function is not implemented.
> > It enables the warm reset functionality via the PMIC.
> >
> > This fallback is only enabled if qcom,warm-reset property is present.
> >
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > ---
> >  drivers/power/reset/qcom-pon.c | 47 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 47 insertions(+)
> >
> > diff --git a/drivers/power/reset/qcom-pon.c b/drivers/power/reset/qcom-=
pon.c
> > index 7e108982a582..684e9fe9987d 100644
> > --- a/drivers/power/reset/qcom-pon.c
> > +++ b/drivers/power/reset/qcom-pon.c
> > @@ -19,12 +19,20 @@
> >
> >  #define NO_REASON_SHIFT                      0
> >
> > +#define PON_SW_RESET_S2_CTL                          0x62
> > +#define              PON_SW_RESET_S2_CTL_WARM_RST    0x01
> > +#define PON_SW_RESET_S2_CTL2                         0x63
> > +#define              PON_SW_RESET_S2_CTL2_RST_EN     BIT(7)
> > +#define PON_SW_RESET_GO                                      0x64
> > +#define              PON_SW_RESET_GO_MAGIC           0xa5
>
> Going back to msm8974 where the SPMI arbiter first showed up, these
> values are all seemingly valid, so I think we can drop the dt property.
> The restart reasons are set in stone too, and you can find more of them
> in the register description.

Yes, but this should only apply when the platform firmware does not
support warm reset via PSCI, right?
Making it unconditional would override the PSCI implementation even
when warm reset is supported.

The point is that psci_sys_reset() executes a cold reset if warm
reset isn=E2=80=99t available. Therefore, our PMIC reboot notifier must hav=
e a
higher priority than the PSCI handler.

So maybe the alternative could be to introduce an additional reboot
handler in psci, with the lowest priority, so that warm reset can have
a chance to run either from the psci main reboot handler or from the
PMIC reboot handler before falling back to cold reset?
[PSCI-handler]->[other-handlers]->[PSCI-cold-reset-fallback-handler]

> That said, we're circumventing PS_HOLD this way - is that intended?

Well, we don=E2=80=99t have direct control over PS_HOLD since it=E2=80=99s =
managed by
the firmware in our case. That=E2=80=99s why I considered using the PMIC
software reset as an effective way to achieve this warm reset.

> And do we need to take any special care where there's more than one
> PMIC onboard to make sure that the SoC gets properly reset?

Good point, this likely only matters if the other PMIC reboot handler
performs the same type of reset and their actions overlap.
In that case, I may need to remove the mdelay from this handler.
Additionally, if we adopt the PSCI change discussed above, the system
will fall back to a cold reset when a PMIC-based reset isn=E2=80=99t possib=
le.

Regards,
Loic

