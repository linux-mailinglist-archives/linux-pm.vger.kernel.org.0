Return-Path: <linux-pm+bounces-42410-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPsCDKbsiml1OwAAu9opvQ
	(envelope-from <linux-pm+bounces-42410-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 09:30:30 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C47A8118441
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 09:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F0A6303E2C8
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 08:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67158332917;
	Tue, 10 Feb 2026 08:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZRmlPDWI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C83B17ADE0;
	Tue, 10 Feb 2026 08:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770712225; cv=none; b=XEbiYMIY9wVTz3ghh4PdunaE5YrU7gYSEvlmAMzLNcknRT4xTqOipiojfoxH+XKdEk1NnH1Jj9D1aTq1yI6gs1psS2bRSBIaqNgHtheZ2jz+Pb0qJ6W2zBF4aL8ALYZrpyyE3f20nrjLMqe7F/H0rClv9JgwyeBhbudenl+1d3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770712225; c=relaxed/simple;
	bh=Zhxsh4jqD2iGfUFwe1bJ5ig/+uSTSy+nc1A7oH1FtTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EfQrrX2tDCX52ilJf2S2lLQ5GoXKqnN8B51J1b+F+9pFYZmISW+7+TTHExb+9iJdPgZseu4zfGEfdnaF/O03vOUpZMNiOlr1NtN9lBbdVYpaxDxT3AyKin2LgbW/vo0TejaUfJVmhT0yK4leh5NX+OL7WnrovCc6TtF5MwnzrRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZRmlPDWI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61A7CVXh4003674;
	Tue, 10 Feb 2026 08:26:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=sbVzjCDXvqsUZW3pWzqOIude
	rbfFbpM8HI+FiE/v5OI=; b=ZRmlPDWIgb9WwL1U7zz8yT71v5YnToDzvLM1YDTK
	+is2iqtkEq7TQWziLs5M4oqeb87yGz4HZBdZ2NdDwvQu81TVKB4rfCRmfCSwmfqr
	cGV4FAmbWGAwtnLj+wDykj3CfF1IaYocZqZI0rntOjT+lbebPrVMhgm70VmhkwCg
	m3WUxtmCvZAXs7e64N4KFAuQh4pSeEAHRFXdys0SVeaSd8zcBXLTMjGVFeIKUbPc
	RiSeAN+v8Fv9OXLe8nT1z1k0+FJcTR0T7/dgwdyAAxk1DsJBv2MPFZneypWRQdfb
	3AJtsh4o20p59xiWsl2X1ihjNnNUyspc9LhDciFyT3aIsg==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c7r23hrqe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Feb 2026 08:26:17 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 61A8QEDF015850;
	Tue, 10 Feb 2026 08:26:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4c5xfmdyt3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Feb 2026 08:26:14 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 61A8QDtg015823;
	Tue, 10 Feb 2026 08:26:13 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-kotarake-hyd.qualcomm.com [10.213.97.140])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 61A8QDt9015820
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Feb 2026 08:26:13 +0000
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 2389607)
	id C172BB0A; Tue, 10 Feb 2026 13:56:12 +0530 (+0530)
Date: Tue, 10 Feb 2026 13:56:12 +0530
From: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Courtney Cavin <courtney.cavin@sonymobile.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: power: reset: qcom-pon: Add new
 compatible PMM8654AU
Message-ID: <20260210082612.3xakor2yo4h3dbra@hu-kotarake-hyd.qualcomm.com>
References: <20260209-add_pwrkey_and_resin-v2-0-f944d87b9a93@oss.qualcomm.com>
 <20260209-add_pwrkey_and_resin-v2-1-f944d87b9a93@oss.qualcomm.com>
 <b0ade3b3-f2b3-4dbe-9e21-920bbda1d077@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0ade3b3-f2b3-4dbe-9e21-920bbda1d077@kernel.org>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDA3MCBTYWx0ZWRfX19VYkphytV5q
 aKwC9ytOeR3qKQFmwO7isr/rqm1AgJbh00/0ijrk8dXutNFc9Trxmod0feuSmHDZzJbt2NSCITg
 5WqTGtc+CecBZByz1y09EaM8PghXxOwVQi/M7BRTwMeCa5hdkrRnt0f8xn0/+JKzxUHReIPNpL/
 +tm1SMdVoWfR8j4HpbFP0RQodCaMs0R3+ADdJ8vXWjmiXeuJX2B6jWU1CKksycNh5jyCa85DxCg
 NDWGXEG7JbTVuWEFFR5vjLPL11UYu0ETVl7aoAJvYq2iP+QX8AgsRj9rpgS8/sCK/AtGgwUs1kC
 Su/DF1uCocRF0bDpRMaXN6M1WrKqQ8uG2mswnB2SMQRWLztKR2+75bz8Xi979lqfF+Z3trwZvKy
 uOggreTvVJwEmuUH/0CyKquIQj+8S658O7Hh4C+bCfdUKhsiD/Ic4+TKA0U2PP8Ky8mPq9mlABM
 u+7n5oPnYHau1Gs6YEA==
X-Authority-Analysis: v=2.4 cv=MLRtWcZl c=1 sm=1 tr=0 ts=698aeba9 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=0PwHx77SaBkyMEZrJqwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: MbZH2J2iedD9mveowZ7vAwF6Rr0S0rcz
X-Proofpoint-GUID: MbZH2J2iedD9mveowZ7vAwF6Rr0S0rcz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602100070
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42410-lists,linux-pm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,sonymobile.com,vger.kernel.org,oss.qualcomm.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rakesh.kota@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: C47A8118441
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 02:49:24PM +0100, Krzysztof Kozlowski wrote:
> On 09/02/2026 14:23, Rakesh Kota wrote:
> > Add the compatible string "qcom,pmm8654au-pon" for the PMM8654AU PMIC.
> > The PON peripheral on PMM8654AU is compatible with PMK8350, so it is
> > documented as a fallback to "qcom,pmk8350-pon".
> 
> Drop everything after ,. Do not explain WHAT you did. We see it.
> 
> > 
> > While PMM8654AU supports additional registers compared to the baseline,
> 
> full stop.
> 
> > there is currently no active use case for these features. This specific
> > compatible string reserves the identifier for future hardware-specific
> > handling if required.
>
> All the rest is irrelevant or even wrong. We do not reserve identifiers.
> If you want to reserve something, then I need to reject the patch.
>
Hi Konrad Dybcio,

It appears that Krzysztof Kozlowski has concerns regarding the
compatible string reservation for future use cases, noting that
identifiers should not be reserved in this manner.

So, could you please help ACK my first patch-set instead?
https://lore.kernel.org/all/20260122-add_pwrkey_and_resin-v1-1-a9fe87537816@oss.qualcomm.com/

Best regards
Rakesh Kota
> > 
> > Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
> > ---
> 
> Where is the changelog? Nothing in cover letter explained what was
> happening with this patch, nothing is here.
> 
> >  .../devicetree/bindings/power/reset/qcom,pon.yaml        | 16 ++++++++++------
> >  1 file changed, 10 insertions(+), 6 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> > index 979a377cb4ffd577bfa51b9a3cd089acc202de0c..14b85b0d97da12c756cfe2ce33853501ba4ca46c 100644
> > --- a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> > +++ b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> > @@ -17,12 +17,16 @@ description: |
> >  
> >  properties:
> >    compatible:
> > -    enum:
> > -      - qcom,pm8916-pon
> > -      - qcom,pm8941-pon
> > -      - qcom,pms405-pon
> > -      - qcom,pm8998-pon
> > -      - qcom,pmk8350-pon
> > +    oneOf:
> > +      - enum:
> > +          - qcom,pm8916-pon
> > +          - qcom,pm8941-pon
> > +          - qcom,pms405-pon
> > +          - qcom,pm8998-pon
> 
> Move this one up to to fix sorting while at it.
> 
> > +          - qcom,pmk8350-pon
> 
> And this above pms.
> 
> > +      - items:
> > +          - const: qcom,pmm8654au-pon
> > +          - const: qcom,pmk8350-pon
> 
> Best regards,
> Krzysztof

