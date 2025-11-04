Return-Path: <linux-pm+bounces-37352-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0C6C307AB
	for <lists+linux-pm@lfdr.de>; Tue, 04 Nov 2025 11:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7C02B4E76EA
	for <lists+linux-pm@lfdr.de>; Tue,  4 Nov 2025 10:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F82314B71;
	Tue,  4 Nov 2025 10:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RZNJVbTo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G1UdCRh3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DE8314A7F
	for <linux-pm@vger.kernel.org>; Tue,  4 Nov 2025 10:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762251832; cv=none; b=fljkQPUAqm2fUZNx2CulKKHHuVV+d5P2oDoMVDF5sLLIgjuUIvPpnZeRnYeVLVrcuhstLQivbblFBDvBT2rNljosRDmyXWoEKftzup2r7FMpbRnrYl4CczNR5yIaHw4FCWhWcOpT1uGT5ZdxnBsRlii5jEUjFpnsgSGto3PRnQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762251832; c=relaxed/simple;
	bh=q9qMwtZAW3c5DEh62FrkMbn/ep1+A9tNPWjOVBB6hts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YAmMGEmrM2gTjp8DcgwBFtqtJZbaGo0CTkAwiQvAyBa14/7vzA0odvMoMqQAVW9rfIzOwI7WFjGKLrshFE9ANws06aMOU2zLytYJ5LVRt2I/jyt3tZVGL3X50NrI2gdNPqclLnBjOwny54l6f/aJF5AKrYT+O/b93R/3V9F3YEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RZNJVbTo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G1UdCRh3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A48fftC1488842
	for <linux-pm@vger.kernel.org>; Tue, 4 Nov 2025 10:23:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g0wnieTQYd6PlV/O1fzaIWKTEzufNimegl24CUN+lIQ=; b=RZNJVbTo/qH9HL5l
	HY7kiVKnn9eV2jhZ0ZrAiu2WiY2kZd/yJmPYdK+EvnnrZd+hbtvu3aNMTPIdsXGz
	7PsXYQlTVOJ7JJzrg2q955vwYdDTDfKTh1fFGrwXs+P0RMKu+gWtsrk2DOXooPm+
	Z0ZznG+TPLAR9kGVo/6f+Q8XhmcOvGcCFqsUO7YYs1WzzbcDPcuSufddKllid9Gs
	tGsO8BMMaQDhR2Mu+aenzM0dZOVBeEErzB6usmrDVJg0BjlAfZRvFyZhHTE3uW+p
	1ollgjg/FeVeM0EVdJu0UKzF1hQ/2Cok+b0ophxfx9YV5oTsD68ZgdCaUsqW0kXk
	BN01Ig==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7c7jgpdt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 04 Nov 2025 10:23:50 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8805713e84fso52081426d6.1
        for <linux-pm@vger.kernel.org>; Tue, 04 Nov 2025 02:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762251829; x=1762856629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g0wnieTQYd6PlV/O1fzaIWKTEzufNimegl24CUN+lIQ=;
        b=G1UdCRh3riyrCSm04DTRvbfI3g/Q1Nd3AskmqEHY+SNSnXnW+hDgOG7KeGNXNytC0N
         hfw6JyRDFfjUaPnBkZqcnZiAgzhEAMCCN3uB5tbo9e7kBt9s/WkIXmBk/x3pON46yaLJ
         q/42mXbmBjjescTunYORv+VIPTEBd2fg10IgPc4k9fnGb4geuxC4vP5juM6GmWPHjp/c
         GlR3V3FAsTC7WtiHhEINfVh88A66jZiBOjDwFxk0WUIhu4AoZzQCC58MM6U+aNoyuAgk
         Av5dqYlCpRCAV52oqVyyMBhVhEWhFSSx9/CwvtFsCQUVYNIFx8drdvMhg3kvC7yAysX6
         OJww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762251829; x=1762856629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g0wnieTQYd6PlV/O1fzaIWKTEzufNimegl24CUN+lIQ=;
        b=wzkOCxC9+P0PxeKHBatj9WXKU3qUgXi3K2EKhGM0MTy6zoDLHpa0fiZbncuO6RDwTc
         HvCCydFEiWmhbXIA73UMPWFBgK/DCNwVe/vIw55fH4DxZI3wcywWlZzJ3eKoFMBNoy2n
         AJWZQ+FX88dTQ/d6qJVP4yaxrS8YRABSuntnvUM8+8ee6M1FjHmS+X370OXPs9VIU3W0
         xS9NNoG9lqp+J16g/meYbPt8qRbSYCuovyVhK//UqP0vZd/RzJ0eB7PHrHOa6YWHkSDZ
         OqcpYI9jG4mKIa/WyOrl5tdf+Gakh9s3vR4Zip1nZkSbPWHxZWUAmd4KreKHoppz99p1
         VmVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrdqPvQV3+GaC9W9gKaOSmhPsTocwPyQpPNFejYz4QzmAhVHoPtKepXMr01ELKtrbdfQMKTdEzfw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5wr4BOLaYiWYKmR8hqV8cmnPeD9oFABwjIV/8w1oqHacnkc/x
	x9+do0K7aLowv4fMjDl9w0OAGokO1RhhZ/u+erXw7xHU6wjJ0goOA5Z1QKkvNoJdmrzLv8NnqtM
	LyLbqYIh+x5V50hRd7LdwvsgJkLhG9yKWXR7NsWPz4SVgKdcoPdlAuDQupty3fpPE4JCQaP8+Pu
	nbAFKDy0CJ2BFMzIypVFWRhBJ+6S83kJpHx/Gs
X-Gm-Gg: ASbGnctWp2d0FP/iTOTvZw6dAi+v7RDuMTiw4ncoLKJs62NK/HccVPbx66cRgTDFnwx
	G/l+xIAj6Te04CnLHtR+3MaIuxaFRx2sZXrGtOeuSzjrH6io6MS0SvJpdNzebCy2Am5CT2UTS48
	HZQbki/26IDGYz7vVDsgGsyvphq0YvDsutF+klzWVnpBmhTzRdJbkoE0tnFGqqM9434pL4XcZe3
	a5d/0rf8vHp94hS9hWKmnmi8Qk9LTQZw4hxxLb40Qy+Xg==
X-Received: by 2002:a05:6214:55c4:b0:880:5edf:d0fc with SMTP id 6a1803df08f44-8805edfd4b8mr53734006d6.44.1762251828937;
        Tue, 04 Nov 2025 02:23:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFr0sEwyaZTxY8f2vag+J7tTIiWriKsoGBuIGWjz3ofTb3smc77gquWEYnErheDN7hvnseToMwJKSJE12/vppk=
X-Received: by 2002:a05:6214:55c4:b0:880:5edf:d0fc with SMTP id
 6a1803df08f44-8805edfd4b8mr53733796d6.44.1762251828526; Tue, 04 Nov 2025
 02:23:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103182006.1158383-1-loic.poulain@oss.qualcomm.com>
 <20251103182006.1158383-6-loic.poulain@oss.qualcomm.com> <z3uy3kx6qx7tcca3psfocrlkrrtumlqyzivrstyxfhbp6lkxti@eeolpv64365x>
In-Reply-To: <z3uy3kx6qx7tcca3psfocrlkrrtumlqyzivrstyxfhbp6lkxti@eeolpv64365x>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 4 Nov 2025 11:23:36 +0100
X-Gm-Features: AWmQ_ble8Tl0B0RAqyd55cThaECsBG5SDXp953QxAOWK8e0Ojn_seswjTiNG6sc
Message-ID: <CAFEp6-2N33RQ8fTPDqx5qvbfALPBNbkLBcvGuX1v-9CYUDw9vg@mail.gmail.com>
Subject: Re: [PATCH 5/5] arm64: dts: qcom: qrb2210-rb1: Add support for EDL reboot
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, sre@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDA4NSBTYWx0ZWRfX9UEJbGT9BUKD
 2k8e6y4ututd67Cfh+CvRucpHnS+fcWUxHSPs6OdNSci3u+dWH+iYGW7ixNCBQjdRPuELWYYAoF
 S5cYJ5FA4xIBFwojTVisWlV0tL2jaFOpXODhnKkRlzD1Y5AJYaBfUP+yzQUY78Rf034w+qyus7Y
 Pj63FX3lWFNQoGVNRGr68LtiKzr2nwGHqCVBZX5+GNL5/qqp/avlxjXRUE0uGaClMP31ISW6L/D
 bTVjDei+PXacnFHG572anAcTpov3WuZH03X8/wzHoDFY5DJg9g4zwlkFuPpRC+sVP/4e8H1cINq
 e7mUWxSB2XaWz9EPOxmA0mqBpQXWqG3blEqA2Lkueu8JHrFhZe3TqWMRGk5wt85oTviEmA4qR9s
 5OKHD16y+5BrSllDZ8WQ3vtMbA1fNA==
X-Proofpoint-ORIG-GUID: NV4SttKJ1IXkr2Q9tBc-F_eD6gKITx7k
X-Proofpoint-GUID: NV4SttKJ1IXkr2Q9tBc-F_eD6gKITx7k
X-Authority-Analysis: v=2.4 cv=DvNbOW/+ c=1 sm=1 tr=0 ts=6909d436 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=FaJMSaSSDYtpzwamVtwA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511040085

On Tue, Nov 4, 2025 at 3:20=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Mon, Nov 03, 2025 at 07:20:06PM +0100, Loic Poulain wrote:
> > EDL reboot mode can be configured via qcom-scm, enabling the platform
> > to enter Emergency Download Mode for recovery purposes. Additionally,
> > we enable PMIC-driven warm reset as the RB1 platform's PSCI interface
> > lacks support for warm reset.
> >
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > ---
> >  arch/arm64/boot/dts/qcom/pm4125.dtsi     | 2 +-
> >  arch/arm64/boot/dts/qcom/qrb2210-rb1.dts | 9 +++++++++
> >  2 files changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/pm4125.dtsi b/arch/arm64/boot/dts=
/qcom/pm4125.dtsi
> > index cf8c822e80ce..5d84a3250481 100644
> > --- a/arch/arm64/boot/dts/qcom/pm4125.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/pm4125.dtsi
> > @@ -15,7 +15,7 @@ pmic@0 {
> >               #address-cells =3D <1>;
> >               #size-cells =3D <0>;
> >
> > -             pon@800 {
> > +             pon: pon@800 {
> >                       compatible =3D "qcom,pm8916-pon";
> >                       reg =3D <0x800>;
> >
> > diff --git a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts b/arch/arm64/boot=
/dts/qcom/qrb2210-rb1.dts
> > index b2e0fc5501c1..70c6c929bbd3 100644
> > --- a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
> > +++ b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
> > @@ -322,6 +322,10 @@ &pm4125_vbus {
> >       status =3D "okay";
> >  };
> >
> > +&pon {
> > +     qcom,warm-reset;
> > +};
> > +
> >  &qupv3_id_0 {
> >       status =3D "okay";
> >  };
> > @@ -510,6 +514,11 @@ pm4125_l22: l22 {
> >       };
> >  };
> >
> > +&scm {
> > +     qcom,dload-mode =3D <&tcsr_regs 0x13000>;
> > +     mode-edl =3D <0x1>;
>
> Why are these a part of the board DT file rather than the SoC DT? I'd
> assume that at least dload-mode is generic to all devices.

There=E2=80=99s no strong reason, it=E2=80=99s firmware-dependent (ROM/XBL)=
. But
indeed, this behavior appears to be common across all QCM2290-based
boards as far as I know. I=E2=80=99ll address it in version 2.

Thanks,
Loic

