Return-Path: <linux-pm+bounces-41766-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKszDa5zfGmAMwIAu9opvQ
	(envelope-from <linux-pm+bounces-41766-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 10:02:38 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F4AB8B0A
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 10:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC18B30166E0
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 09:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7013F34F48C;
	Fri, 30 Jan 2026 09:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Eb9NxTH+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G53nNpaT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B492E62A8
	for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 09:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769763752; cv=none; b=JqkmX1Fg0eVvH9YkCWMS4uKOOBX+r5qGCcuv7viNqPHrJriLocy6/FCC6E8vUMuPOLHd6yCm5Ta86e73WbAFAOtY4u3wgUCCCiADW71KMHhl4P9qpTCdkHjzWq4hoyjYLwXfZg0dOaPlYLzI0ksFCc38qi4fCZQw+gMaxSgOvqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769763752; c=relaxed/simple;
	bh=lZiSX+GOYyeK2cTNnF3jCVDKcBgdZYADrsppgbY6DXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WANHV0P2rA0sNq0f7tSS4ySQBOVGldB0g8cq6QEb6PQigI20klBFi5UpeOcE5jmbOB+GB9aCOl6fOU4Gc5b8Or566Pw5+FoLgk2lygGD+s5WSa9kqWzpc/QSLnWHJwHGG98GnYUq2VceKnz5l387puHCc/2pjDKWFijAS7m7MX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Eb9NxTH+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G53nNpaT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60U3Vlqg1488285
	for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 09:02:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=FhNCWjY3XGEmd/v1YHMV6HTP
	pNss/Cza9IpYt0QL/as=; b=Eb9NxTH+6KfJnKF34JJuyKclr4xcsWqZNJKnnZNM
	NushvzY/rgfDhP+kPT/GPoghIBvjizGIYV68rInCvBm1jFtALiF6uvtVFjUPo8Vt
	5OUCiE2sgLUkhl414EqCXwiRjLpZ9FujtM8aswkWBlBKE6KdLznn/K7F9jKe6jI6
	j81lNM1hJrkepcGrWQb4E//RUFJ2y5cRqLj2jJXJHAAec5i97LxaPN4S/YaJ34QY
	XD7qZi3/8cwbMKdCIssWDLJM4Bz4iZmADgI2NbeAK8+oBkdvPO3Z9pOB7q08m/yE
	1uc7ALjyNF/t4Vuz1VmxPxZkzHC/KUUBN50JciKgNKUdTw==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0bp3thb9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 09:02:29 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-5f535184cc5so1707854137.1
        for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 01:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769763748; x=1770368548; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FhNCWjY3XGEmd/v1YHMV6HTPpNss/Cza9IpYt0QL/as=;
        b=G53nNpaT+0QE5/fvG7uRYWJ967qJvE4dOmCVFEgv0XqnGUHyQRlqEwzW37/0iNw53T
         7E/UGQhk/pHsvWAkI+8gporBt6nWD+P7fon9WIfnYK3rmvcqf4TnCONN/pmRacJvae/F
         AXGsemZkwmNjjA9k9Cf81fheFH8tL3avWr8nIOXPwvFFckaBcDlpSLuOa3CjW7xdS8CK
         fl4ZLni4TcxnBTLWSwZe/I+QHUj6ygKQv1Q8JuZ52mnxYtgKYNd9focZ9NqBY0df3iMz
         kW1y5VRewShy1dH6YgszAjLyt1Eoffy4bqtcqi6gIQDzqhgkWPupB8T0mHIrifBCwTnl
         UZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769763748; x=1770368548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FhNCWjY3XGEmd/v1YHMV6HTPpNss/Cza9IpYt0QL/as=;
        b=RUCXg5LQZ9D41EInZm8Nx6pAr4QVlXiNHb5BuP2Oox/s9UEeXsevB5gKtQe/XpR/+o
         yR5CDkD7agaFBIvhLIV4R9dGhInAT6HZ1beAH9NUl00WT+UFxcwv5uuMkU8hNXlFXFwg
         BosPTXkEMFM/icozhiPzw+Duef12UFj2OV9mIO3Wfy6jvwHA/Bg6OLHSDo3icoV4W7p0
         ZajCmG0pXhfkgM+PDebcJ1efODpP/g4yXUCenx9fUt5o+h0chSorplOEywCAxRhJ75pv
         ll91GSxQfAx7qyqgEgNatCWWC+p2tHcOyaQ54gJojJMbtPZAKsj6qoCmiWIa/cba3kGM
         8/JA==
X-Forwarded-Encrypted: i=1; AJvYcCURPfdpmU66QWI+7XkXwBpISqDTJBQ4CnUx+oOIDTsTsX8MIAxX6MErT7QorA8kmuGB8zFLB3swng==@vger.kernel.org
X-Gm-Message-State: AOJu0YwYzPRN47S1DXFT7L4WnM57L/k2x+2/ZSh3n21GqyhMsA492/Lm
	PL3rEFBAIdQ4OAr4DdZrpVgicCJQ1tUScwf4eTr0mf+l5Jea+YKssSXw1Ur2Hh9iWROiHlrP2fq
	v3mUzOOXciciM6/HJsnBycSVv5v296gLmbjfKeOCRIDdHA6vX7emRhSmxZzJGyg==
X-Gm-Gg: AZuq6aIZunmUdE/82E15eXt6u7gbUon849IlGos61b0q/jJG07jkqxLaTMW+FqC80ho
	jiQnX4sglOYTikheQUcNV6IeSweSflW11Rp6XxVYqdEiftzba0QennT3EsLDox845PaVCyGr2/B
	+76tsA8YlsqKcjgsFTMYp72DWylizaIzhAwcNTKVlYiWXZx96Z29eDs0EL1RZtQBW+IIo8syR4+
	sAr9xeB0rXLGU6TNs56wJte9HMicguR2+NcK+HqmwMl9WQG1tmDcVU3xFm+m0o+hnF14AcrMA+1
	aiid6gXyK7aaxreEDgW8B6JBRU/nHIRLrYpF/yS1RlGhme0jwpr7+DcjD6Hl41k1Q0YT7WByrJS
	UmD4Ri4XOsWaFfxk4WVbdL1JwWs29X7saZd/bhuei7Od9Nmg4Gj/O6aObd1VKD6A1dd4PczcV6i
	YvWnCtGE3OrXp8dJZCUslBzNY=
X-Received: by 2002:a05:6102:32d3:b0:5f0:2451:5f5 with SMTP id ada2fe7eead31-5f8e245778emr597245137.7.1769763748229;
        Fri, 30 Jan 2026 01:02:28 -0800 (PST)
X-Received: by 2002:a05:6102:32d3:b0:5f0:2451:5f5 with SMTP id ada2fe7eead31-5f8e245778emr597237137.7.1769763747798;
        Fri, 30 Jan 2026 01:02:27 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e07481b67sm1645717e87.16.2026.01.30.01.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 01:02:27 -0800 (PST)
Date: Fri, 30 Jan 2026 11:02:25 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Cc: andersson@kernel.org, mathieu.poirier@linaro.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, rui.zhang@intel.com,
        lukasz.luba@arm.com, konradybcio@kernel.org, mani@kernel.org,
        casey.connolly@linaro.org, amit.kucheria@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        manaf.pallikunhi@oss.qualcomm.com
Subject: Re: [PATCH v2 2/8] dt-bindings: thermal: Add qcom,qmi-cooling yaml
 bindings
Message-ID: <6zoth72n4pgzmfafv2sqhhsyiqz727t5wnrono4jicvxxhzu4n@bdw5643qieov>
References: <20260127155722.2797783-1-gaurav.kohli@oss.qualcomm.com>
 <20260127155722.2797783-3-gaurav.kohli@oss.qualcomm.com>
 <k3q5hsdsxhtf2yxibyqzzldhgrbv366n3rd6wdcoju7gcksiu3@uplmllaihm7h>
 <09298c37-4cbf-4486-b720-5e96cc08a1ab@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09298c37-4cbf-4486-b720-5e96cc08a1ab@oss.qualcomm.com>
X-Proofpoint-GUID: Wy178zcSTNbMi4PNtZNMETrdltp_bpk-
X-Proofpoint-ORIG-GUID: Wy178zcSTNbMi4PNtZNMETrdltp_bpk-
X-Authority-Analysis: v=2.4 cv=d6T4CBjE c=1 sm=1 tr=0 ts=697c73a5 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=je_95Jt8qlmsa4y-PKoA:9 a=CjuIK1q_8ugA:10
 a=-aSRE8QhW-JAV6biHavz:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDA3MSBTYWx0ZWRfX4OMVtih5+Ok0
 tnkEgrompgThTBzAhB9sof3eJ8IpVFA/Z+irN+eIux3bHZ8R+n+kEoBeuTXqOV8iS9KhJVJF48F
 X45rqq4X1lKzpM+OK4QA+T3yQvXSnT92od2uVd76zgJgpkgbZj4HRFDiy9QbhDMRcevC5/KZXG0
 /2nfs3U3zGdscit9wae7PrJ7+xN1g1adS7/+cEq6qzWoiE/IhY6SclrFaIpKFrFKNXiaqSDhN/4
 Jrdk7G098OBR22WMs1HudXnyBFlaWCp4mPbIyKXZsS/LoiNqE4SatKoYkz2gx+tRrYXLv9kyqPc
 41qb2+K+zGRjyLgQ36AGN8y8LBTIezvWHgUOyMfzzHtdd/VcWHBYbeLSqZ5kEzlQAHtLls+sOZm
 6SBFWqmcfCd/XcFH6ryAXApW+kMhnOqdaLvSueoYEB3sRh1mxT6Wj3TRftwObbyH0uDZmpOA5vK
 XtWQlBtDtHEBGc2Mf9Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_03,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 malwarescore=0 clxscore=1015 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601300071
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41766-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E7F4AB8B0A
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 12:38:52PM +0530, Gaurav Kohli wrote:
> 
> On 1/29/2026 6:15 AM, Dmitry Baryshkov wrote:
> > On Tue, Jan 27, 2026 at 09:27:16PM +0530, Gaurav Kohli wrote:
> > > The cooling subnode of a remoteproc represents a client of the Thermal
> > > Mitigation Device QMI service running on it. Each subnode of the cooling
> > > node represents a single control exposed by the service.
> > > 
> > > Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> > > ---
> > >   .../bindings/remoteproc/qcom,pas-common.yaml  |  6 ++
> > >   .../bindings/thermal/qcom,qmi-cooling.yaml    | 72 +++++++++++++++++++
> > >   2 files changed, 78 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
> > > index 68c17bf18987..6a736161d5ae 100644
> > > --- a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
> > > +++ b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
> > > @@ -80,6 +80,12 @@ properties:
> > >         and devices related to the ADSP.
> > >       unevaluatedProperties: false
> > > +  cooling:
> > > +    $ref: /schemas/thermal/qcom,qmi-cooling.yaml#
> > > +    description:
> > > +      Cooling subnode which represents the cooling devices exposed by the Modem.
> > > +    unevaluatedProperties: false
> > > +
> > >   required:
> > >     - clocks
> > >     - clock-names
> > > diff --git a/Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.yaml b/Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.yaml
> > > new file mode 100644
> > > index 000000000000..0dd3bd84c176
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.yaml
> > > @@ -0,0 +1,72 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/thermal/qcom,qmi-cooling.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Qualcomm QMI based thermal mitigation (TMD) cooling devices
> > > +
> > > +maintainers:
> > > +  - Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> > > +
> > > +description:
> > > +  Qualcomm QMI-based TMD cooling devices are used to mitigate thermal conditions
> > > +  across multiple remote subsystems. These devices operate based on junction
> > > +  temperature sensors (TSENS) associated with thermal zones for each subsystem.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - qcom,qmi-cooling-cdsp
> > > +      - qcom,qmi-cooling-cdsp1
> > If I read your schema as you've it written, then ADSP, SLPI and modem
> > also can have _CDSP_ cooling device. Seems like an overkill.
> > 
> > Please take care to describe cooling devices for all DSPs at once and
> > describe them properly.
> > 
> 
> Thanks for review.
> 
> All the target supported in this series are limited to CDSP, so i will
> update the binding to describe
> 
> only the CDSP.

Why are you limiting yourself to just CDSP? I don't think there is a
significant difference between CDSP and other DSPs from the cooling
point of view.


BTW: could you please also fix your email editor, it inserts extra
unneeded newline characters.

> 
> 

-- 
With best wishes
Dmitry

