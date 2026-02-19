Return-Path: <linux-pm+bounces-42867-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCHMCn7rlmkzrAIAu9opvQ
	(envelope-from <linux-pm+bounces-42867-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 11:52:46 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EAD15E009
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 11:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA8593021989
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 10:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF0B2FFDD6;
	Thu, 19 Feb 2026 10:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C7G4IOoM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4453922B8AB;
	Thu, 19 Feb 2026 10:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771498362; cv=none; b=q7cswtMcJGFxf9gLGMmf+F1YlYrz895V3A771DE/2v620r4qiibrGFco8rE778zZryckDaYsHFTe0A2h4OzFVOcMU4L8iyXXErkoF6CF/wK4A5heHbsmzdV9CcvTiUsvIBsRCWkPhxlkZV7/pG6C8QGBhA4d/QjGD9en7S337Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771498362; c=relaxed/simple;
	bh=LORl+bUSoUdmkpx/jKGtHR9M1Shmifwuz9wq4O1UTmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EMd5Je/EbwglMeH0zuWlA8Xqo/WqzbPxBi5Dp2tdnhJSgicjatC8ZdA7EUqzaK5NqOrKQD6PwepVjh/YlvmIvI+YND1oZLoRYBqgvxniOMPRgLSZoItlX4TIWmiILioG/J08Og8/J3NCLcc6nJCbkgtI+oYmjPV6zWILCxTvWbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C7G4IOoM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61INlM8B1923821;
	Thu, 19 Feb 2026 10:48:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=4RMi/YQncr+pwT51AQ04T0yT
	QxNOtLkQkdcg4MlJ1WE=; b=C7G4IOoMDdzC/M19+0ciJKovUjKYZAw5tPhEHoOO
	KGe28lSaJ3ZAB+8X09o9BUpFC0UNy6zjZldIp3Wf1POf2gIMLwB8iPlj+pm1v1Bo
	5EgXnW2NriWJVMZ2kEl63Jv8qzzJIU0byXSCoY1eJcbIzfTdwGrZ9ZsReDJXdcO3
	YRQxD60/Xkz97bN3p/eYc0EMkBTU+owS29XZGufpS64QbgvgkvUY/d57FdQrlkB1
	BYC1RECsbV9T5EIJLyQFH18f5exJZK55QFBZCU1biOPLanAerfoixU1GHGx2anyq
	46XY6yjW7x9+wWIXLdU/bhCgdWTzy+uGUYLssk+3iE7yPA==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cdqdg9b9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Feb 2026 10:48:37 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 61JAmX32029952;
	Thu, 19 Feb 2026 10:48:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4caj4mts3n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Feb 2026 10:48:33 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 61JAmX6S029946;
	Thu, 19 Feb 2026 10:48:33 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-kotarake-hyd.qualcomm.com [10.213.97.140])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 61JAmXSL029908
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Feb 2026 10:48:33 +0000
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 2389607)
	id 66457AF0; Thu, 19 Feb 2026 16:18:32 +0530 (+0530)
Date: Thu, 19 Feb 2026 16:18:32 +0530
From: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
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
Message-ID: <20260219104832.3fe5tlnvjqus7zz2@hu-kotarake-hyd.qualcomm.com>
References: <20260209-add_pwrkey_and_resin-v2-0-f944d87b9a93@oss.qualcomm.com>
 <20260209-add_pwrkey_and_resin-v2-1-f944d87b9a93@oss.qualcomm.com>
 <b0ade3b3-f2b3-4dbe-9e21-920bbda1d077@kernel.org>
 <20260210082612.3xakor2yo4h3dbra@hu-kotarake-hyd.qualcomm.com>
 <k2eu6lvokuh6pilmipztfqufffkmxa3zylsxz4lad45ow255no@fvocedpr3qwp>
 <bd10782b-444c-417b-bf27-9fc6a2117567@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd10782b-444c-417b-bf27-9fc6a2117567@oss.qualcomm.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: O_B0_HT_HC8ds47G87GYpJwC-1cBO9es
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDA5OSBTYWx0ZWRfX+IhjAYD/7mZE
 Wcc1jH9I2DqzAWEQHb/ssedbW74oouRPUqV+hfdIMxRwa+/1DUR3lp6dahmiBDOd/UC/BG1k1ST
 pCOg6x44Z3WPYPPUs5+chNMGaU2t35iMTU+Qf+Xi0UT6owWdPWPSfiUmY+othguDgIULMd5W6xZ
 jWVAAs1tlTtaFU+8hZckBXONC3Rfql9hQI4DeQEuWHWtzC/yWrBB2dZFkWu9seHdhHzaSmnrXs1
 Xj/ERPHyBwlCPnurMNqtVsRZQqSPN0L0Z+O3PO+RkfU329QwC4H0m67dVTOnYJlYTXqZn6uamXv
 5jzSprtulCECOg+x1A3ce095YDaFB9sbCZkP0es9SOobB0EChe7ApqqDYBhjNtpzsPCLkVtFagG
 UkOnW6Z2Z3YMu+tvDZbYmg8FOp8NAaIc/8K4/fVRj2aTTKOsI9mMfrdhCv4FI9kMlc1QEsqJp2S
 4Z6zLgfzLR4yUt99N2A==
X-Proofpoint-GUID: O_B0_HT_HC8ds47G87GYpJwC-1cBO9es
X-Authority-Analysis: v=2.4 cv=W/M1lBWk c=1 sm=1 tr=0 ts=6996ea85 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=F1rKFM7Bf0xR_-QgnswA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_03,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602190099
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,kernel.org,gmail.com,sonymobile.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-42867-lists,linux-pm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hu-kotarake-hyd.qualcomm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:url,qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: 97EAD15E009
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 01:27:29PM +0100, Konrad Dybcio wrote:
> On 2/13/26 7:17 PM, Dmitry Baryshkov wrote:
> > On Tue, Feb 10, 2026 at 01:56:12PM +0530, Rakesh Kota wrote:
> >> On Mon, Feb 09, 2026 at 02:49:24PM +0100, Krzysztof Kozlowski wrote:
> >>> On 09/02/2026 14:23, Rakesh Kota wrote:
> >>>> Add the compatible string "qcom,pmm8654au-pon" for the PMM8654AU PMIC.
> >>>> The PON peripheral on PMM8654AU is compatible with PMK8350, so it is
> >>>> documented as a fallback to "qcom,pmk8350-pon".
> >>>
> >>> Drop everything after ,. Do not explain WHAT you did. We see it.
> >>>
> >>>>
> >>>> While PMM8654AU supports additional registers compared to the baseline,
> > 
> > I can't find PMM8654AU either on Qualcomm.com or in the catalog. Is it
> > an actual name for the chip?
> 
> Right, I would like to see some clarity on that too.
> 
> I see there's a PMM8650AU and there's two variants of it, perhaps that's
> one of them?
>
To clarify, PMM8654AU is a different PMIC from the PMM8650AU, though
they do share the same PMIC subtype.

We are specifically using the "PMM8654AU" name because that is what has
been defined and used in the upstream pinctrl-spmi-gpio.c driver
compatible. To ensure consistency with the kernel driver
representation, we are maintaining that naming convention here as well.

regards
Rakesh kota
> Konrad

