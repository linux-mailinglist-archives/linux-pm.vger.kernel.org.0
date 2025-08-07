Return-Path: <linux-pm+bounces-32026-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED860B1D1AA
	for <lists+linux-pm@lfdr.de>; Thu,  7 Aug 2025 06:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C41767AA966
	for <lists+linux-pm@lfdr.de>; Thu,  7 Aug 2025 04:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B681EB5FE;
	Thu,  7 Aug 2025 04:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nAKs73uJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE96A15624D;
	Thu,  7 Aug 2025 04:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754541530; cv=none; b=hBbiLV31bBm/kWUoz62EPWidZ60LSjK9CtuBoQvl0JjSTNFrYdKnmMeZbjXIyMDr9wx6zDORd4WYbkm4OoSMf9vo5PNGPUlahFXjxb1VHINa6nUbxmKSAIW9t/psxXLBegR6fs5pJwsajaUT6MBEeA/XgRtQ7V3jJ3T/3iEClsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754541530; c=relaxed/simple;
	bh=oeNPa5TVrpkGMGYTKy9xRknrP7CuBl7m6/5rkTjeuBw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/XfL06TFp5Vf0pQuH2vrU/E+tamWMAIYI3eFZ54TO5hwzLNqnbaYCzCmQR4dvstkIo/HaNgjxQN+gbJ7LBboM+KsYD/0bG+cWijT6zx8Mi/XLusIKyuQgI+gco/NmK6jaVfsP8Q8JSGy3Qb1RV7FqpffjN5AnbabiP7wdJwOsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nAKs73uJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 577225c9019554;
	Thu, 7 Aug 2025 04:38:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=7PJAO7jsB4C4aNkssIY6PS8I
	opO4EUYICROrgeu88pk=; b=nAKs73uJqIw+JKe6jiTM558NPWDsD5J2TnWNAZBS
	HTcrpa7qu7ddDyNj9PTe9fw3Z8W7zIMFKbMwHiDG2zymL+nXs6TR+dFQq9KXTIIF
	mwzuQ4Pkz12R/zNafVLDcznNje3yYWPto6eQgz9RLdadFJs1x/+RozdLpwt7Aqfm
	O8BjNner/pcS3Q67PKdA6Zcu/IN30WlI7aGFgnZLe6VZeb3fgckXc1cTBteLEPo6
	czx/IBoIqK39fjNwwHGstMKnW2HXztrjwfNrwmF15W/O9vwlFMA9HSEw35MoI4Y9
	WRKQXxlPCVsGVV8Fgo7PvKMJWrzWxeLIb2FW0QUci5v1tg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpy6vyw0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 04:38:44 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5774ci16030961
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Aug 2025 04:38:44 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 6 Aug 2025 21:38:38 -0700
Date: Thu, 7 Aug 2025 10:08:34 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <konradybcio@kernel.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <ilia.lin@kernel.org>, <djakov@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>,
        "Sricharan
 Ramabadhran" <quic_srichara@quicinc.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        Md Sadre Alam <quic_mdalam@quicinc.com>
Subject: Re: [PATCH v6 1/4] dt-bindings: clock: ipq5424-apss-clk: Add ipq5424
 apss clock controller
Message-ID: <aJQtyouomCxI8Rfa@hu-varada-blr.qualcomm.com>
References: <20250806112807.2726890-1-quic_varada@quicinc.com>
 <20250806112807.2726890-2-quic_varada@quicinc.com>
 <70bd9beb-2f7f-4132-88a4-8d81d70ac50b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <70bd9beb-2f7f-4132-88a4-8d81d70ac50b@kernel.org>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: RuPmWPQNJ8tZiKS3DYDQi90MNWBMXzh_
X-Proofpoint-GUID: RuPmWPQNJ8tZiKS3DYDQi90MNWBMXzh_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfX5m0KuM0ECCFM
 uhSbQjoT/4Ac1WV7rVfpTa08wEa/03BUc1k74IQG4EPdFBMKBKsVtW5H0xq13EEOBMGpQ+l3iOI
 lSA75eHaz7yapF9tVCAeNr6BmY037Czr89x5xIqCcj2pXqf92Qh82n3AL0+Bi9T/LOxszQQSduQ
 gvRjEFqETzMU/eacDy5zi5+8rUaWnt2p6ACzeaVBvmiWpEsYME/IlVpnABmlzQHAwEuLhd9fonC
 /P4A25kdEPLJvHRemyiw6IaqKknuEZ85kg3J0nmI88qIS18bRYZ7MGlfFjKiINvMtOegJvTAyXA
 VqzeCqQZSi7vpJS5k5+ppUumVPwM2JEfxZjOhp0cGa4bkO+qJ8B1N/7Ns2CbZI5w7Y9II69ap0X
 tbDfJ8IX
X-Authority-Analysis: v=2.4 cv=LNVmQIW9 c=1 sm=1 tr=0 ts=68942dd4 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8
 a=KKAkSRfTAAAA:8 a=pgpCuyf8vpdT2N1z9QMA:9 a=CjuIK1q_8ugA:10
 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_05,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508060009

On Wed, Aug 06, 2025 at 01:47:34PM +0200, Krzysztof Kozlowski wrote:
> On 06/08/2025 13:28, Varadarajan Narayanan wrote:
> > From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> >
> > The CPU core in ipq5424 is clocked by a huayra PLL with RCG support.
> > The RCG and PLL have a separate register space from the GCC.
> > Also the L3 cache has a separate pll and needs to be scaled along
> > with the CPU.
> >
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> This is oddly placed. Did you use b4 that it appeared here?

b4 places like this

	Co-developed-by: Md Sadre Alam <quic_mdalam@quicinc.com>
	Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
	Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
	[ Added interconnect related changes ]
	Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
	Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Since I haven't seen Reviewed-by coming after Signed-off-by, Was not
sure if my Signed-off-by should come before or after the Reviewed-by.
So, manually placed it there. If this is not ok, will use how b4's
placement itself and post the next version. Kindly, let me know.

Thanks
Varada

> > Co-developed-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> > Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> > Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> > [ Added interconnect related changes ]
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
> > v6: Add 'Reviewed-by: Krzysztof Kozlowski'
> >     Drop 'clock-names'
>
> Best regards,
> Krzysztof

