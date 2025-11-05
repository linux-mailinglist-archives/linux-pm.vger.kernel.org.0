Return-Path: <linux-pm+bounces-37479-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A130AC37AD5
	for <lists+linux-pm@lfdr.de>; Wed, 05 Nov 2025 21:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D68503BCB93
	for <lists+linux-pm@lfdr.de>; Wed,  5 Nov 2025 20:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992FF33291C;
	Wed,  5 Nov 2025 20:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H+ja5aDU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Gg5J5Cdb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2FA2F28FC
	for <linux-pm@vger.kernel.org>; Wed,  5 Nov 2025 20:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762373893; cv=none; b=UHbJ44gNSXfH49aBmMTn2KsC8vad9GAVIClAslhcoIf68xgm70io6NNl0QIVHeJLQTkss7JC94xyoxf0eajc3KMgRcaOSM0FcxhLEpP3BlyxMgU9pK1L3m4GY+Dsh3n3oE9NlP+TuYCCh2ALxwNtLKpD81VBErri/yah5Uj6h8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762373893; c=relaxed/simple;
	bh=eZRekEh3HwONE3jQUKo6gZdFTvSDFxxM2XeygklXRC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jem5SjZ/ZgqFBDvitKOJ1OmdJJzIkwmFIk2VaslFGxdlZuFmXlLkujzg+Esy3tlQFtiejAvY8J0B+21mF8tk++80e56gXEV9FQJSFasJXqHFHJN7NPxHIM7Z5wmGsToF7kW9yBX1UK3KkCKUF1LLeMF29N19/ZL/t8MpFXsKIdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H+ja5aDU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Gg5J5Cdb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A5KEs5w1804564
	for <linux-pm@vger.kernel.org>; Wed, 5 Nov 2025 20:18:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mVMNUsAndpmo/afDJ79jdAjzVssUiGR4aZoBZnoV3VQ=; b=H+ja5aDUPL7gcsV0
	vqTNiO/I6mni83MlNqPxvpQ23u8CmLbSEJh4+0RpjLy3Z2ney4SxzDyPCkO2CSBr
	TKJeHnkBnGGnFwiAjIdJ0XczKrxFwOS7Ljt76cO4LoOkzbNnWV+zBiHXhkv2lzbA
	s0Y3t9NErT2TdMQSs/Vld1476z+/V+lk3O5eK7x+uraTeI+cZ/RGNJcLxEDWYp9b
	rV2LW4PQVscM4CkJbk8oxMu9X9bz9Fbi387z6DCPnfRPGTMvbRMT1+T/pwuZSFKH
	fXfJ7abGp7qU2jHp4YAec4tagizXVt966GhmuhCkyHBTddPwt9V51QYc/bXsEGpo
	SdTpLA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8c8s87nk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 05 Nov 2025 20:18:10 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4e88c912928so5701411cf.0
        for <linux-pm@vger.kernel.org>; Wed, 05 Nov 2025 12:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762373890; x=1762978690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mVMNUsAndpmo/afDJ79jdAjzVssUiGR4aZoBZnoV3VQ=;
        b=Gg5J5CdbvOxXmpP9JulGUuFb1jhYvjkClJhvvtOdvJEibCScxO+e803L3TJkicnS3E
         +e2r1bsMhk2QKVTVe9Thj2TX/E4D+pXjd3ghq6D1Yhwt4Bzv6gNsVQ/+PV2YD6D/7/WK
         5+km291pQu51B6DTwjfj3bhP2GNGO2xQv3Wm7gEGfSXr9TvqkqAH91Gptmx0cP4V9VRy
         rncf17C2pyhrM/oNsSMS3GKY+dXyWcwNLcuNfNWl/iTpuItgPidEu1n271gZTdlOB9S5
         XgGnQ8MT7dvolAgEjYhD3NHeY0Gflnmu7Mda4PJbVt7BwKf4e2DO2Tf87oknsC0Anric
         IAnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762373890; x=1762978690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mVMNUsAndpmo/afDJ79jdAjzVssUiGR4aZoBZnoV3VQ=;
        b=hOxvVbhi89OFYwMtTZa+rOYLnZoonIFF1sfmRSRuRJf2EqHAPF01gEtWZTNyxnbByt
         FtqopcR1glIhF53B/Ub9famtY4w3ZJagS1TtiWJPQCWLFRTzlwJtU+c8LsVddIx9TfPy
         Lu4IR93yIC8xueP9BGwdivQFLDVKxWtypTFWv3bbTlNnIBqhRswTSEKw9JQ8Zki85/Fq
         BMDfxbfLnc41qPyxAayT3d2RuuqNpBG37NGCP5pGUMcT7Rqpj+xNwjZd0HgspSPeVEFc
         ZpFsNma+w9UQspT+2DQ1dxFTdgE86wlRnUxPcQpjqTcN2Vv+f9vjG850KtTSkDw2t/P7
         z9KA==
X-Forwarded-Encrypted: i=1; AJvYcCUrM2Nn6XVJ22ti8i0/s6kYtzM+vE5XvAE9bKNh+VoKfYSCDMSxKfCSnWLKPZfqgVSFSQex6bNxJg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl2qRVzupu+fUzdBf/TA/85xHUvL31ZrPhZymmNkuXXQOMzK7o
	5pDAu4xreTpfBDcsZUIJpx9r7hbnbVe4dnbMYY7Nmd45AdLv9WCnZ8zp3ZBRJAAN2k4r/e/9JG9
	D7PdpEEZIDGZFE5QJ62bKMtaVuWZMSl15y7SGt5OkpWz7kbcnWBoDpIxoWL8uoXxsPMPrq1NoBk
	mtJklNPC11NyEzROgAuLBXcWdOiMGtbrybyYqn
X-Gm-Gg: ASbGnctDbYZhsvoNf1aR704WXVjp4+vXstbBs99qP1BDVJVM9gx7rTWQtYMQbKZiHlJ
	SBtbJbThm5ObJDI7aCSD9gVG91SVpbhRTR6dt40TWg3Xf5pWbo8vjus5DNtUQIi6mr7PUcrRf24
	90IZXsub3I2swfuWL9/Xw/LotF0PsCQqYdD2KHuxJrJVop8gtwiAOyEyK9Cg5UJgqW5th0BX0f/
	/jzPiBc9Lji4Jzw
X-Received: by 2002:a05:622a:1886:b0:4ed:64ee:b946 with SMTP id d75a77b69052e-4ed72333348mr51703901cf.9.1762373890113;
        Wed, 05 Nov 2025 12:18:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFknbGL8kDYadqiGGxH48R8FaOno64y50cF374SF4ia9AEJDBcUfCkCTNspvhX/pYvSffhCWkWgrW2OaHtB9nM=
X-Received: by 2002:a05:622a:1886:b0:4ed:64ee:b946 with SMTP id
 d75a77b69052e-4ed72333348mr51703511cf.9.1762373889645; Wed, 05 Nov 2025
 12:18:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103182006.1158383-1-loic.poulain@oss.qualcomm.com>
 <20251103182006.1158383-4-loic.poulain@oss.qualcomm.com> <aqoxdaq72prkeqwxmmohlmbpx7icuc32sej7did6vt6rzrgfib@bvmt7ppkvloc>
 <CAFEp6-2GGA2gvBKfO0fZemVmJmjQpTQEJ0vLfEewfhHKOYQGSQ@mail.gmail.com> <be0a418b-5e8f-4895-a3b8-482b6ad6a40e@oss.qualcomm.com>
In-Reply-To: <be0a418b-5e8f-4895-a3b8-482b6ad6a40e@oss.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 5 Nov 2025 21:17:58 +0100
X-Gm-Features: AWmQ_bkV1EiNnXP-IZWkGBXUSPax1s7heO54hBldRL1TWbKl8UzCsFgnGQYPesE
Message-ID: <CAFEp6-1qPw7vdqYNKYv00M1sDo0HhEPgrHuEZAJ5vabErR7ChA@mail.gmail.com>
Subject: Re: [PATCH 3/5] dt-bindings: firmware: qcom,scm: Document reboot mode
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, konradybcio@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        sre@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDE1OCBTYWx0ZWRfX522s22h0HyJk
 ZtRzYzB4Pu2JKQfJn1Cmf5LgrLUyR2OoPBS/oX4MEdAw04blNUpboUTVrcmBXkjhSTqilrC9nK3
 zOUK2DBbtDEM9gisJx600/E6aqwqjwtQ60XovcNBcYyr2vefeKPXMnlMvAOxiT0cKl3tLmfQ/9H
 rIyUyJABA7lszCfaJtp5tTLI85d6BUeaCV3KUxTzzS8lV5R3XDOn2cCwncsybkXD0OUULHwa9KT
 VO+2jilGsfL/F6xvqXf5NdPVZmDu+WP8khXabyPumTpLOsfN0ynJ+N7v90x1PNfAp3ZwhXpxN6t
 4aGgd60ty7LV5KEYP9eEny7562+deUes1DzL2GXgSvEaZgExL9Xvko1QjkUu9Nhads161XPZ7HH
 U2RMBv2+zMTIKTTcmDn3sf5D5o3dhw==
X-Authority-Analysis: v=2.4 cv=RLu+3oi+ c=1 sm=1 tr=0 ts=690bb102 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=hOEl-9L8IPZEmPzWKaAA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: qH9CVed-hGHKCmvVf7EmhJljtUY-lNv9
X-Proofpoint-GUID: qH9CVed-hGHKCmvVf7EmhJljtUY-lNv9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_07,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511050158

On Wed, Nov 5, 2025 at 10:44=E2=80=AFAM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 11/4/25 10:19 PM, Loic Poulain wrote:
> > On Tue, Nov 4, 2025 at 3:12=E2=80=AFAM Bjorn Andersson <andersson@kerne=
l.org> wrote:
> >>
> >> On Mon, Nov 03, 2025 at 07:20:04PM +0100, Loic Poulain wrote:
> >>> SCM can be used to support reboot mode such as Emergency Recovery Mod=
e.
> >>
> >> "such as"? Do we have any other useful bits in here?
> >
> >  I heard we may have different EDL modes supported like USB or SD
> > based EDL, but I don't know much about the details.
> >
> >>
> >>>
> >>> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> >>> ---
> >>>  Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 4 ++++
> >>>  1 file changed, 4 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml=
 b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> >>> index b913192219e4..c8bb7dacd900 100644
> >>> --- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> >>> +++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> >>> @@ -121,6 +121,10 @@ properties:
> >>>            - description: offset of the download mode control registe=
r
> >>>      description: TCSR hardware block
> >>>
> >>> +patternProperties:
> >>> +  "^mode-.*$":
> >>
> >> I'd only ever expect mode-edl =3D <1>. Do we have additional modes tha=
t
> >> warrant the generic nature of this?
> >
> > We may extend this to mode-ramdump if it makes sense, but as of now
> > it's indeed only edl, will fix it.
>
> Would adding ramdump here be a matter of:
>
> + mode-ramdump =3D <0xmagic>

Not in its current form, I=E2=80=99ll need to slightly adjust the qcom,scm
driver mask for the reboot mode and also prevent the dload inhibit
during reboot. I can include these changes in v2 if that would be
helpful.

Regards,
Loic

