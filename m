Return-Path: <linux-pm+bounces-42497-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEo7AthejGmWlwAAu9opvQ
	(envelope-from <linux-pm+bounces-42497-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 11:50:00 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DA81239C0
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 11:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 829C930C1176
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 10:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4622B9A4;
	Wed, 11 Feb 2026 10:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P3EwdaaX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F9836A017;
	Wed, 11 Feb 2026 10:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770806764; cv=none; b=maDu6wGPGPEJbZ4A/IA2v1kuNIus3sufzVkpfeRDAFdgL8bAbZVTvTKA4ZQuLTB8u0dlqG0E1gYZo0KkegMc3oZ5oobpR7uDP7pTO3vnmmvlw8MFsVRUgYbGReCxxxB++tanU4LBan8cHtLBIjrfJuLpmPtEJNieADM8wwPf6qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770806764; c=relaxed/simple;
	bh=6kLNCUzPnnrmSxD+Tfi8kpoj2JkDjprt+LGUGRETJH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WUYLKusAlXFiCrGVuXb0Cu5YOO25O2tzsULpYS+/mszwT3WLyK1MjhM34tWPi9G2pyy8k6WYs5QWtVqlCfCtz505IkjSG93LaNzfMHybCWQcyHzEO1FgQZnvgzlX/yGAhS/6u2hf5Qzmw2t/eGttPoLh4YYVRD4irisZMM+Y0e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P3EwdaaX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61BAHutH2298192;
	Wed, 11 Feb 2026 10:41:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=UjAZ/MQ+umwMOQCo5OjPHtG+
	eMszJF/jPuw+mTP+2T4=; b=P3EwdaaXryLQNikmUvodIRPgc991uOaSvYj5koL9
	14hjQYyNphF1S3B+Vale1stD5lcG2lyrBcJpZApSKtdGzot0Y/i6GzjLge/wrHct
	jut/Bmp9sc1p4DdEfnbahpO74ekh+c+617Swp8yUVFQz5PI3u5gvFVztCaWhGTwX
	W9S4O8gKyJUvWrsUWe2NSVLy3/zWfnKoHMm2hcnRRrVDQ5NhfoNOSeeIGCBIhM9y
	z9JoSfx1nRqnmmA4UpHNzM0nsDh0HRTQFKinO1+qu66p5u186S83g/bEK1zDk9hy
	DHHrFpfLqq7uABgc7wmB6WspKLvl6Iza9Vpd6HnGvIZ/hw==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c8qvq82dh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Feb 2026 10:41:58 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 61BAfsp3002582;
	Wed, 11 Feb 2026 10:41:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4c5xfmr9ke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Feb 2026 10:41:54 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 61BAfsq8002577;
	Wed, 11 Feb 2026 10:41:54 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-kotarake-hyd.qualcomm.com [10.213.97.140])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 61BAfs8i002573
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Feb 2026 10:41:54 +0000
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 2389607)
	id 661A7AF5; Wed, 11 Feb 2026 16:11:53 +0530 (+0530)
Date: Wed, 11 Feb 2026 16:11:53 +0530
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
Message-ID: <20260211104153.r6xz7ya5emxa36cp@hu-kotarake-hyd.qualcomm.com>
References: <20260209-add_pwrkey_and_resin-v2-0-f944d87b9a93@oss.qualcomm.com>
 <20260209-add_pwrkey_and_resin-v2-1-f944d87b9a93@oss.qualcomm.com>
 <b0ade3b3-f2b3-4dbe-9e21-920bbda1d077@kernel.org>
 <20260210082612.3xakor2yo4h3dbra@hu-kotarake-hyd.qualcomm.com>
 <b9c7aa89-b260-42aa-a85d-9e596e78e419@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9c7aa89-b260-42aa-a85d-9e596e78e419@kernel.org>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: VluMIBZfOqN1PCm-WjblBR1Fgp1m7zn1
X-Authority-Analysis: v=2.4 cv=Q77fIo2a c=1 sm=1 tr=0 ts=698c5cf6 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=8E9PgiLlRWQXEfnqiEYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: VluMIBZfOqN1PCm-WjblBR1Fgp1m7zn1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDA4NyBTYWx0ZWRfXy+Q2vJe22SLd
 NIcev3bbTD7QPzRi+gGS3bd/qeZMSUaS93dE7oN1kTTe38804VG0rYQ/pyMovGtb7RragHmbUn2
 YOAS09wL8Gb28ConTA79PPKhq/qmAmnU8CU54yWUUWCoixwru5vuFrTHBfmifpJfGsPPCy6wPMb
 AIFjWnTWE2IPgUFfVl6bKC/Bo3CEBXZ93yMY3/EU4RvBCkazuOFj8BKHexpdohBJaRbG3hyw2Wd
 la5ZduJ7kizrxfn5+0VDUNF0VO9A3IM0Pw65+u3Ngi3RKWWmf0xG5RULwMTwkOWCXRrs6iSej1c
 zsvEpNaK2APM2YpMx5cRghaLW9dAVJPtEx3YF+0iN96E46AV1PiZHKx/AOymdvo42zoPtfuIoZu
 ywDbmW43WgTfi63i6gZ5nPr4yNhYPlRnqK6JOa78Q0LQHNFpSFlpqHp76LY4Ux2/1cdFuHah9kT
 mam2bZqUPLtZfhzG+3A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602110087
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42497-lists,linux-pm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,sonymobile.com,vger.kernel.org,oss.qualcomm.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,hu-kotarake-hyd.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rakesh.kota@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: A0DA81239C0
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 09:32:18AM +0100, Krzysztof Kozlowski wrote:
> On 10/02/2026 09:26, Rakesh Kota wrote:
> > On Mon, Feb 09, 2026 at 02:49:24PM +0100, Krzysztof Kozlowski wrote:
> >> On 09/02/2026 14:23, Rakesh Kota wrote:
> >>> Add the compatible string "qcom,pmm8654au-pon" for the PMM8654AU PMIC.
> >>> The PON peripheral on PMM8654AU is compatible with PMK8350, so it is
> >>> documented as a fallback to "qcom,pmk8350-pon".
> >>
> >> Drop everything after ,. Do not explain WHAT you did. We see it.
> >>
> >>>
> >>> While PMM8654AU supports additional registers compared to the baseline,
> >>
> >> full stop.
> >>
> >>> there is currently no active use case for these features. This specific
> >>> compatible string reserves the identifier for future hardware-specific
> >>> handling if required.
> >>
> >> All the rest is irrelevant or even wrong. We do not reserve identifiers.
> >> If you want to reserve something, then I need to reject the patch.
> >>
> > Hi Konrad Dybcio,
> > 
> > It appears that Krzysztof Kozlowski has concerns regarding the
> > compatible string reservation for future use cases, noting that
> > identifiers should not be reserved in this manner.
> 
> So do not reserve identifiers but submit bindings reflecting REAL
> hardware being used.
>
Yes, there is a real hardware difference between the PMK8350 and
PMM865AU PON peripherals. The PMM865AU PON is leveraged from the PMK8350
PON and includes extra features, but those features do not have any
active use cases for now.

If you are okay with the new compatible string, I will send V3 and fix
the commit message suggestions.

> > > So, could you please help ACK my first patch-set instead?
> > https://lore.kernel.org/all/20260122-add_pwrkey_and_resin-v1-1-a9fe87537816@oss.qualcomm.com/
> > 
> 
> First patchset is wrong. You already received comments on that.
> 
> Best regards,
> Krzysztof

