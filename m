Return-Path: <linux-pm+bounces-42869-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJBBNDbylmmYrQIAu9opvQ
	(envelope-from <linux-pm+bounces-42869-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 12:21:26 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7661815E3BD
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 12:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD959300E70D
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 11:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3918933E344;
	Thu, 19 Feb 2026 11:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b/imHo6R"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA03333436;
	Thu, 19 Feb 2026 11:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771500082; cv=none; b=c9jYEIFLmDbAbOtPCL3AfZVjvTBUjwD4Tp31d0cAK5Fa54BmT38gJwwt5zQVvO65QNGTSiTxAYbAy5NdqI8OuHyOoEVP1WW2EhT6FryNNY8i6qYQE7V6qaajmHo7tX6XOiJfawValZpP5/o3MKHHRGUkeSm3q/6d0OBGC0EqxJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771500082; c=relaxed/simple;
	bh=dZ+3acLBq4rBqlFy6Qr+aS22dVtEI3izvRsGEfSFWJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PIiyuCxHc/Xn6tURE/GaqYxT0TR87OaVK6468C/XogJAcos+MHios8JBeiVvnRaevtmc68jiluR7fpk/tMTShnH+bAm5l6TVSd45nSi5WAocJ/prlOei96nm6NAorwWWN7hrzv6lTphBqHiCLiJph6169KXuaF4oHFEQUYgoxB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b/imHo6R; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61J1EjDH159736;
	Thu, 19 Feb 2026 11:17:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Y1SSWoAHofv6pH9W0OsVcK0g
	V6Q24n1i8718W8aszjM=; b=b/imHo6RW+RuzuYGM2QC9xTx3VxuSVooQFum4gUF
	9zGP1CPc/vkbRONs372rKMJb4/crm7cd9nzhOhP2tpeMBtlntVuOf0Z444rx8s5R
	WQ/X+zvjzogUJiItTNTMAFZmP+Wws7/Nv13Ub6AWC72ARqFdEyCMfvTDBpsNvslf
	L1qU/w6Jy6YLBKgsiwQWDr4F1bKBnCLawHWsb41lfCLNZevRSpIXZCEv/2L6zfIF
	iLE8dXx+qGhLMeqArZt//sN55rS25+ouaMo8rRf1TPN5HBjga4elEmCeTYoRkKRg
	8NJ83MrLVIx137so51EaHAzXcH/KTcymBEKd1S4gNGwWqQ==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cdrpg97k6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Feb 2026 11:17:15 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 61JBHBWn031718;
	Thu, 19 Feb 2026 11:17:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4caj4mt3up-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Feb 2026 11:17:11 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 61JBHBMT031711;
	Thu, 19 Feb 2026 11:17:11 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-kotarake-hyd.qualcomm.com [10.213.97.140])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 61JBHBd7031710
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Feb 2026 11:17:11 +0000
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 2389607)
	id A4A2EAF0; Thu, 19 Feb 2026 16:47:10 +0530 (+0530)
Date: Thu, 19 Feb 2026 16:47:10 +0530
From: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
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
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: monaco-pmics: Add PON power key
 and reset inputs
Message-ID: <20260219111710.dnkvzyomwsswy3hs@hu-kotarake-hyd.qualcomm.com>
References: <20260209-add_pwrkey_and_resin-v2-0-f944d87b9a93@oss.qualcomm.com>
 <20260209-add_pwrkey_and_resin-v2-3-f944d87b9a93@oss.qualcomm.com>
 <253ca948-07cd-4ded-8e15-619589f2d314@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <253ca948-07cd-4ded-8e15-619589f2d314@oss.qualcomm.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1TeQbGthztLLhBkN7D-yD7QE7TpesyJp
X-Authority-Analysis: v=2.4 cv=JrL8bc4C c=1 sm=1 tr=0 ts=6996f13c cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=93yULV4EQqDBAtbZ-kMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDEwMyBTYWx0ZWRfXxyB5VBGua09a
 Oakm/2inzXAIu0B/pivTCl2dzJMDnRrsqSCd57zMGcUFhV+z5mROXiXPGHk1zXU1KXo3NxCR02k
 XkFbqzK4ufV9a9XH+7IPEiEFMOYxfxQ6L6iOCvsiMxJcfanwlDU85DJLNOMTlOjX197SdLf/yj/
 OQj3bgzrD05qerhRB/JMOOySNPWpXoTzCBJhE7KxMkDaIPHhkHxUQpH0CcA6gEUflQ6XiqZhdhq
 +eBcyrw3q34Lj7YJaRtkBmP9Kp7LddzN7fHB27FqqO/ye1aZ/8IbqvbMGI9nyWO6hvRirmyaJhJ
 oSiQNvWLxgMb7EC02xTG2idEN7pkS6xjjYuA5JIk7oeZJbA+eMIxGaAEvuaPTPRFyF6oRTQ2h+a
 K5H5wjTFQzSZTBWlZETDyYuCN+FENFqZs5bItVGs2wBjArbUT1i3p5sQUihYjmtM4JETcCyPDE4
 GwTnzsMrXjydROlMTKA==
X-Proofpoint-ORIG-GUID: 1TeQbGthztLLhBkN7D-yD7QE7TpesyJp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_03,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602190103
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,sonymobile.com,vger.kernel.org,oss.qualcomm.com];
	TAGGED_FROM(0.00)[bounces-42869-lists,linux-pm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,0.0.4.176:email,hu-kotarake-hyd.qualcomm.com:mid,qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rakesh.kota@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 7661815E3BD
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 01:30:19PM +0100, Konrad Dybcio wrote:
> On 2/9/26 2:23 PM, Rakesh Kota wrote:
> > Add the Power On (PON) peripheral with power key and reset input
> > support for the PMM8654AU PMIC on Monaco platforms.
> > 
> > Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
> > ---
> >  arch/arm64/boot/dts/qcom/monaco-pmics.dtsi | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/monaco-pmics.dtsi b/arch/arm64/boot/dts/qcom/monaco-pmics.dtsi
> > index e990d7367719beaa9e0cea87d9c183ae18c3ebc8..182c2339bb11af40275050a36c4688227e89497a 100644
> > --- a/arch/arm64/boot/dts/qcom/monaco-pmics.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/monaco-pmics.dtsi
> > @@ -13,6 +13,26 @@ pmm8620au_0: pmic@0 {
> >  		#address-cells = <1>;
> >  		#size-cells = <0>;
> >  
> > +		pmm8654au_0_pon: pon@1200 {
> > +			compatible = "qcom,pmm8654au-pon", "qcom,pmk8350-pon";
> > +			reg = <0x1200>, <0x800>;
> > +			reg-names = "hlos", "pbs";
> > +
> > +			pmm8654au_0_pon_pwrkey: pwrkey {
> > +				compatible = "qcom,pmm8654au-pwrkey", "qcom,pmk8350-pwrkey";
> > +				interrupts-extended = <&spmi_bus 0x0 0x12 0x7 IRQ_TYPE_EDGE_BOTH>;
> > +				linux,code = <KEY_POWER>;
> > +				debounce = <15625>;
> > +			};
> > +
> > +			pmm8654au_0_pon_resin: resin {
> > +				compatible = "qcom,pmm8654au-resin", "qcom,pmk8350-resin";
> > +				interrupts-extended = <&spmi_bus 0x0 0x12 0x6 IRQ_TYPE_EDGE_BOTH>;
> > +				linux,code = <KEY_VOLUMEDOWN>;
> > +				debounce = <15625>;
> 
> FWIW we tend to disable RESIN by default, as it's not as ubiquitous as
> the power key and only assign the keycode in board DT, since it may
> commonly be reused for either of the volume keys (or something else
> entirely)
>
Ok, i will disable the RESIN key by default and remove the assigned
keycode in the next patch revision.

regards
Rakesh Kota

> Konrad

