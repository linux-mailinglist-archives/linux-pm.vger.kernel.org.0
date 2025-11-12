Return-Path: <linux-pm+bounces-37816-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A385C51E35
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 12:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE2051885767
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 11:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF37E264627;
	Wed, 12 Nov 2025 11:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HWMCUqVR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KwwDovIy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2315B24BBE4
	for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 11:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762946191; cv=none; b=OPvFXwEhZPuOLDQhfME0HRAzzlmDHbJ+UVJixJKGj2+fXW8P0ybJDD7LNLwD/YpenN2TPeXdt3ZVRRgW6ru0WarN7bhQnHdOhLJy0a3fW1sGySM3zFU7BOsbRygLkqELyDzMkXP6ml0VEfR7AlnFcg8H2yaVtNqQ/pRV3ED2ysw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762946191; c=relaxed/simple;
	bh=2RbCPxBXrvXGXOedZj1/8RpYrvzys0WCnNhRvJnhUuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rN5OkliG162d+ReDJ6OK69cBZ75PZdDopmr9ANKl3NQTJndTHKnQSHhj+yK2s4AWK7QVeKhYqJbR0G3QtJlDFx2KoTfNGpnOeUjCftW4OTd37A0/PzRKy7+mcpJ/iLVRjwiB8ecd+evx6ctCj3qChuW7018JqgkD1k+wn/nf2mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HWMCUqVR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KwwDovIy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AC9ggAp1109097
	for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 11:16:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NoxDKOeccwe0hHKDuDC3QJhQ4gtuxY2B4MV4Ct21dd4=; b=HWMCUqVRnQp66ell
	L7R9KwvxD1Kp/G6e47U0iQ0l3KxXSUxZOHdNTwYp/Sy/JXGfVeH7ehZJ773Bdsad
	VN3P6AuBjMscsrsodKaIBZAIa3lz7YuIeZdqfUDpI7WXqAdL4cm5augKiXnzfJrd
	2Fx0HCUuMCi7SqDxMFrwriMWlPnCJixKcZESi3SkXD99tf6g8Au7Fn/+5CNFQ6BJ
	wAnyHqXyvzoYA2ddjdkXA2DmKCLtmaASvO8dihAIFHKeVritIUQsy6LJknQa3zTt
	xpBj2iz1lj2qVMAhRTeL/vcuMSF6bLO0kWhovVB7+QFhaB3sI/DkbUy+XE8uxLXp
	6pdAAw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acqum08rx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 11:16:28 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-88237204cc8so20991716d6.2
        for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 03:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762946188; x=1763550988; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NoxDKOeccwe0hHKDuDC3QJhQ4gtuxY2B4MV4Ct21dd4=;
        b=KwwDovIyV4rEbx7c73OBB1JYEeiQa+CU4sAiDx90LnSikRbQrbSJp3VCUs+ut6+T+D
         8Hw80IYvWOECad26r9W1c1YWJAKqCELuM3TkU+tEiWoOSAwZK1jR0oICRKrpwKMzsVX5
         FJFBgBX+5qZBwnqwk+zM5L+qPFjcPI/pMUqMb5pAyJPOlUBwIwbyFbhDkloirAkC92cI
         yZB7BWCa+zYJWteeXpP7usd8z3EnchpRjuBQ6kuc4G8Pk848EaCfQLjxZFa4qtnAn6xh
         MOBJwctqhJX914ryp6pKMFRoasl+ZcF51xrTRpLIfCBRobpus86Z+d4Ksi7XzYtoWU/O
         xlzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762946188; x=1763550988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NoxDKOeccwe0hHKDuDC3QJhQ4gtuxY2B4MV4Ct21dd4=;
        b=s4Et82aQPpY1WWA9FviDotp/hvAQMfdYyXjPBg+9okUL+sXfPYV2bgyrvqN9b2pZKS
         brOfyLpc5n62OcP+WXeqNomPQwa+LL1+kDyXhJl6xP0naKy2J26ABNeBCWe9OOuEbFaI
         NDJXYmKGLCjPdua6yXshv1Dw9MOtA0RqShwUAv92EjINF7OvFpbI0JzTbXnAohacxKgQ
         C+saLtVyUEnTa1I41GP9zXJf/6lDGIvyEnTM+y22SJArvrucqypNQj6+AyALeN7TByBe
         eaFg28f4dxkfIHFGb7wXDZGxvu0k1S2JCsbt987vMbd6bo8NZIQfmy7aSVUnYOIrZbuG
         RwCw==
X-Forwarded-Encrypted: i=1; AJvYcCUUcvEunTUl1aFFAl45e2mdNsek6HMzOwlXtpYL6bAROVd7wHAKe14zN1DpGIy0cewNEwwOtXuhFQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDH9HDi7eyR7J8J9AX88FskkO/pD6q117tUuXrfbYZa8OfNS2t
	0eiLbvwAC918uNY48sN7+6k7/HxID9730ZuBszymKBX7AfkeOhYLxxqyI9sHeHT/q0G/lRVmzlN
	e6Pq5gkMDGi9GDUCrNOQdZxOgNr2KHXBtlIk96MxMdci+5euY4jCSJB9QxDLDheu3wvRGaeTLRj
	/YvGWSojdVI88jMKBr3+I8Tu9Tf99Z2lPadZGj
X-Gm-Gg: ASbGnctBdy21/UKiyvcQcSx5bOSh/hdPCYfJCTCNz5IBL4Hyfl7Oma1Yb5+bUmEWVOx
	zUBNxm0QwSDl3ZmPNJqWwBR5qGIYX85GFyPVtjHPbnmXSrE0lEmMwTUOSkCBxFpYpwdXJ14Nx6S
	bKW88+5wAQY7xJtiUGRIxJJUFeOniJGYnYu116vNQYra0WeEzmU/pPHXg105tajbTSNHD67fBt4
	LGjpPAjuq13kM3mzQ==
X-Received: by 2002:a05:620a:17a4:b0:89f:5a59:bf30 with SMTP id af79cd13be357-8b29b84978cmr310115485a.78.1762946188269;
        Wed, 12 Nov 2025 03:16:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEbFMkRlXTnyauzcsrT9L1dZMT8pmOX8XA3fFrhIrcGJfg7RI6eB1RHXioVGWBqcn68+pLzUTvJit6HnES/i0c=
X-Received: by 2002:a05:620a:17a4:b0:89f:5a59:bf30 with SMTP id
 af79cd13be357-8b29b84978cmr310111585a.78.1762946187783; Wed, 12 Nov 2025
 03:16:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103182006.1158383-1-loic.poulain@oss.qualcomm.com>
 <20251103182006.1158383-3-loic.poulain@oss.qualcomm.com> <740b9e7c-59bc-4a35-a268-526d92db372c@oss.qualcomm.com>
 <CAFEp6-12qN0=cv5=tPeVq3bVDLkaQDHLLCVQY4dtCTSvx+dPOQ@mail.gmail.com>
 <c1269f38-ab90-40d1-b5d3-39f546829d6c@oss.qualcomm.com> <CAFEp6-1+inMhsgjSqAZ+UDBMuNc9DA-jXFyqB=gkvYpSzW9Ukg@mail.gmail.com>
 <6daf722b-6b1b-4c91-b108-74793d930319@oss.qualcomm.com>
In-Reply-To: <6daf722b-6b1b-4c91-b108-74793d930319@oss.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 12 Nov 2025 12:16:16 +0100
X-Gm-Features: AWmQ_bkmppPZqTvg4YgUg-M0KbsuBOPKkMsqNwJWI4AM834g9wwfM8l1Kra8Vug
Message-ID: <CAFEp6-0sbDj0C9KAMxq1mrGO9jGz4YDMqnf1AGVU49PyGzLi8w@mail.gmail.com>
Subject: Re: [PATCH 2/5] power: reset: qcom-pon: Add support for WARM reset
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: krzk+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        robh@kernel.org, conor+dt@kernel.org, sre@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDA5MCBTYWx0ZWRfXyg1rRP4Dw5+k
 r4yETMiFVk1VeR0lrGSoIxcVh9ZzKSfxb62XM7tkZwDymBkoiAEABE9+KgjlxAzgJSI4icDaGeA
 6hwA89qkIh1JGjyD5MDhlZPrNMZDHtX9dQyYUyLM/OjLm4pgzlOW8yND0zsbwVGzVHUsr41AFRL
 1YPnaQoZpQpAhO8TYu2VilYbXkWviWzYjzqJSnQtxOebwzW0HafxzytcF6c6b46lD9dQS50p+1q
 4LQXilulrZLf6770hFIJYSbAYCudLLKOe9QdI3E1ngu4+5hDic/VOISeyaEgoAguTCygWPVy6rT
 Ng7syLI6fCPI5PS14tJfKk0gT3gX+tdg7eIzAsSubbqh34BIIvBk/zxt6xS1sfn0ad3m47PMPe6
 2IT666qZFeBMEw9E/961aKhJoby4qA==
X-Proofpoint-GUID: xeegcW8cV_CsmDQtL5BavQ3fc9Nt8I9M
X-Proofpoint-ORIG-GUID: xeegcW8cV_CsmDQtL5BavQ3fc9Nt8I9M
X-Authority-Analysis: v=2.4 cv=KeTfcAYD c=1 sm=1 tr=0 ts=69146c8d cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8
 a=g6XIpITSSIbtmoP3y8UA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120090

Hi Konrad,

On Thu, Nov 6, 2025 at 1:50=E2=80=AFPM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 11/5/25 10:44 PM, Loic Poulain wrote:
> > Hi Konrad,
> >
> > On Tue, Nov 4, 2025 at 4:20=E2=80=AFPM Konrad Dybcio
> > <konrad.dybcio@oss.qualcomm.com> wrote:
> >>
> >> On 11/4/25 4:01 PM, Loic Poulain wrote:
> >>> Hi Konrad, Krzysztof,
> >>>
> >>> On Tue, Nov 4, 2025 at 12:50=E2=80=AFPM Konrad Dybcio
> >>> <konrad.dybcio@oss.qualcomm.com> wrote:
> >>>>
> >>>> On 11/3/25 7:20 PM, Loic Poulain wrote:
> >>>>> This mechanism can be used when firmware lacks proper warm-reset ha=
ndling,
> >>>>> for example, when the PSCI SYSTEM_RESET2 function is not implemente=
d.
> >>>>> It enables the warm reset functionality via the PMIC.
> >>>>>
> >>>>> This fallback is only enabled if qcom,warm-reset property is presen=
t.
> >>>>>
> >>>>> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> >>>>> ---
> >>>>>  drivers/power/reset/qcom-pon.c | 47 ++++++++++++++++++++++++++++++=
++++
> >>>>>  1 file changed, 47 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/power/reset/qcom-pon.c b/drivers/power/reset/q=
com-pon.c
> >>>>> index 7e108982a582..684e9fe9987d 100644
> >>>>> --- a/drivers/power/reset/qcom-pon.c
> >>>>> +++ b/drivers/power/reset/qcom-pon.c
> >>>>> @@ -19,12 +19,20 @@
> >>>>>
> >>>>>  #define NO_REASON_SHIFT                      0
> >>>>>
> >>>>> +#define PON_SW_RESET_S2_CTL                          0x62
> >>>>> +#define              PON_SW_RESET_S2_CTL_WARM_RST    0x01
> >>>>> +#define PON_SW_RESET_S2_CTL2                         0x63
> >>>>> +#define              PON_SW_RESET_S2_CTL2_RST_EN     BIT(7)
> >>>>> +#define PON_SW_RESET_GO                                      0x64
> >>>>> +#define              PON_SW_RESET_GO_MAGIC           0xa5
> >>>>
> >>>> Going back to msm8974 where the SPMI arbiter first showed up, these
> >>>> values are all seemingly valid, so I think we can drop the dt proper=
ty.
> >>>> The restart reasons are set in stone too, and you can find more of t=
hem
> >>>> in the register description.
> >>>
> >>> Yes, but this should only apply when the platform firmware does not
> >>> support warm reset via PSCI, right?
> >>> Making it unconditional would override the PSCI implementation even
> >>> when warm reset is supported.
> >>>
> >>> The point is that psci_sys_reset() executes a cold reset if warm
> >>> reset isn=E2=80=99t available. Therefore, our PMIC reboot notifier mu=
st have a
> >>> higher priority than the PSCI handler.
> >>>
> >>> So maybe the alternative could be to introduce an additional reboot
> >>> handler in psci, with the lowest priority, so that warm reset can hav=
e
> >>> a chance to run either from the psci main reboot handler or from the
> >>> PMIC reboot handler before falling back to cold reset?
> >>> [PSCI-handler]->[other-handlers]->[PSCI-cold-reset-fallback-handler]
> >>
> >> This seems like a common enough problem, perhaps the framework could
> >> accept EOPNOTSUPP or similar and try to delegate further, coming back
> >> with a normal restart or so, if unsupported. Trying to make a special
> >> contract between qcom-pon and psci silently will be very fragile
> >> otherwise.
> >
> > I tested the following, as described above:
> > https://github.com/loicpoulain/linux/commit/5c34ea54e1a21ff1192c3c34187=
7b24eff5f80b4
> > The only special 'contract' is the handler priority.
> > If you can elaborate on another/better approach, that would be helpful.
>
> Thinking about it again, it'd be difficult to grab some sort of a handle
> to the ""parent"" reboot mode, so what you propose here is good
>
> >>>> That said, we're circumventing PS_HOLD this way - is that intended?
> >>>
> >>> Well, we don=E2=80=99t have direct control over PS_HOLD since it=E2=
=80=99s managed by
> >>> the firmware in our case. That=E2=80=99s why I considered using the P=
MIC
> >>> software reset as an effective way to achieve this warm reset.
> >>
> >> Hm, so is there no longer a way to assert it by writing to PMIC
> >> registers?
> >
> > PS_HOLD is a SoC signal, and we can maybe assert it via the
> > MPM_PS_HOLD register through the msm-poweroff driver if needed (well,
> > if access is allowed from a non-secure world).
> > However, this would also require coordination with the PMIC driver to
> > select the correct PS_HOLD action (shutdown, cold reset, warm reset).
> > For that reason, I=E2=80=99d prefer to keep PS_HOLD based logic abstrac=
ted by PSCI.
> > Using the SW_RST PMIC register allows us to perform a reset without
> > additional signal handling.
>
> Yeah of course we should use PSCI where functional and available
>
> I think PS_HOLD used to be fully manual on old (msm-3.10) platforms
> through PMIC registers. I see that e.g. msm-4.19 has an SCM call to
> (de)assert it. There's also a "halt PMIC arbiter" call.
>
> (via drivers/power/reset/msm-poweroff.c)

Yes I could try the SCM call to deassert PS_HOLD, is it something we
should prefer over PMIC soft reset?
Asking because the implication would be a more complex solution
(though not yet tested):
- Adding reboot mode support in qcom-scm to activate ELD mode
- Adding reset-notifier in pmic driver to modify PS_HOLD action to warm-res=
et
- Adding reset-notifier in qcom,scm (of lower priority than PMIC)
doing the actual SCM ps-hold deassert
- Ensuring that PSCI is still used for cold-reset and warm-reset when
supported...

Regards,
Loic

