Return-Path: <linux-pm+bounces-31413-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B90B11762
	for <lists+linux-pm@lfdr.de>; Fri, 25 Jul 2025 06:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E3765A1F3B
	for <lists+linux-pm@lfdr.de>; Fri, 25 Jul 2025 04:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC4D218EBA;
	Fri, 25 Jul 2025 04:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WxLYRf+o"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A1D4C83;
	Fri, 25 Jul 2025 04:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753417143; cv=none; b=aouCgjXVj0Y44qvCPD3bhNWFt7juYVuXZXi0qZK+5pk0y7FaD14NajxwlfmcgeMBY1zX7Jf8FjnxkpaYC3NkNHN/n9ow+4wsX+6+o9Ta2UFUFs5B4CPcl77K3a3k6WI4NyPnCQqbubDa0ClrDIyzgSTVx89ho3N8abrvluSHX4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753417143; c=relaxed/simple;
	bh=g1aDJWjOkWNwnIq5x6LnbqOtD31oH9lR+AgkfVnB93s=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G8qHDkEEIJCTRGe1/26IehcaWwOYGpxzWJAnTzCCmVqvxD5mf5gSREqp849pwMliyRjIA0hqxPRJpMhXpjvafmcuM7zVUELKatj9kIpNas0l0D0FLFlngJ+IgvrAhU56rASSrWg4zOzWWnz5zvK4cwqrAAYM/M0ZT+AKnfMyy0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WxLYRf+o; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56OLmVIF009335;
	Fri, 25 Jul 2025 04:18:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Tlv+F7fsCTtMIea6rPvY6FhY
	V4OOI+NyNZ9VIr4Thuc=; b=WxLYRf+oQL2HF3QBsnTkgzIR60brxENI4vkz9Bgf
	LPRN13NkAA8F2I1RswUe/9GQAOa//pVmsKfpn9kRlt2OlgtyAX+GAk47R97kiHur
	BwD4+vjOTkSwHpsyNh9FNYuMv5k/IgJMR2KnNYQTbVWgjzvXuSmQvODTBA2MLlWM
	yOwz03v7oQYXsP4HndPRf/Gd31cYHLSxKx1aQz8SG6LvVrOGIWfN6D4H2HLbEb+z
	pgeh27OxIx9rwJNQ+ABiFNCEhc4vC0VPA/gYKEpkTYaC1uVXAoFnYWMrfjrPiYOf
	NKsRck2MTif1rKUO97DmGp9gsb9sRil4S7ZAvzMzP+61WQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 483w2t0rx2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 04:18:55 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56P4IstF020187
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 04:18:54 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 24 Jul 2025 21:18:49 -0700
Date: Fri, 25 Jul 2025 09:48:45 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <konradybcio@kernel.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <ilia.lin@kernel.org>, <djakov@kernel.org>,
        <quic_srichara@quicinc.com>, <quic_mdalam@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: clock: ipq5424-apss-clk: Add ipq5424
 apss clock controller
Message-ID: <aIMFpW6yH9IRmyqj@hu-varada-blr.qualcomm.com>
References: <20250723110815.2865403-1-quic_varada@quicinc.com>
 <20250723110815.2865403-2-quic_varada@quicinc.com>
 <20250724-remarkable-kind-ibex-3bb86c@kuoka>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250724-remarkable-kind-ibex-3bb86c@kuoka>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=BMKzrEQG c=1 sm=1 tr=0 ts=688305af cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8
 a=COk6AnOGAAAA:8 a=gEfo2CItAAAA:8 a=UXIAUNObAAAA:8 a=HD4o69LU_PO5Mj1lfZQA:9
 a=CjuIK1q_8ugA:10 a=bFq2RbqkfqsA:10 a=TjNXssC_j7lpFel5tvFf:22
 a=sptkURWiP4Gy88Gu7hUp:22 a=a1s67YnXd6TbAZZNj1wK:22
X-Proofpoint-ORIG-GUID: 46DBbXXfpUfL5-9phqL9eQuNHb2apaeM
X-Proofpoint-GUID: 46DBbXXfpUfL5-9phqL9eQuNHb2apaeM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDAzMyBTYWx0ZWRfX0N8mOsQquu40
 EkM4XN2NzsWNCySs8tW0AQsYmy2CXi4k0G9acy5ijPySJjtuWBBh93ZeRxwTRsETWEBStDeIcLp
 NEWkbX7D6RqEr/pkBsaYv8mfbXVxEAcK6PQMveIHt/4lKBG9BkAl2NILTQXZOucDcOr2JuVp24m
 s9VibtnmeAL4ykg+6WpQVIlEVHlFCZB7CtJ1Ay3pTSGPbpFnWqdT9tw5SuhqMtb3Pq3Wej6rmd1
 MHtKzVbOcxQHIdJM6Fu7PW813XtVBr+xbdrGGxkDXgKbUQ8Y0fg+4yF9mieJRq3QG35n4/7HchE
 F7LhTjh+HY8pnt/ro4qndKlS3XQnnlbO5+INfyunyYJ9maCVdgMxeLeFvkdWJYz8eYq9eX+ZIZe
 kCwbAP5BhEU4DZ6GcP1fszEQG7r0Olj4K4lKZVD2yFhW+CXo9qsIt1YoHUWhFIG3/wwaWVYe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_01,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507250033

On Thu, Jul 24, 2025 at 10:14:01AM +0200, Krzysztof Kozlowski wrote:
> On Wed, Jul 23, 2025 at 04:38:12PM +0530, Varadarajan Narayanan wrote:
> > From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> >
> > The CPU core in ipq5424 is clocked by a huayra PLL with RCG support.
> > The RCG and PLL have a separate register space from the GCC.
> > Also the L3 cache has a separate pll and needs to be scaled along
> > with the CPU.
> >
> > Co-developed-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> > Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> > Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> > [ Added interconnect related changes ]
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
> > v2: Add #interconnect-cells to help enable L3 pll as ICC clock
> >     Add master/slave ids
>
> and v1 was where? I cannot find it in the inbox, no lore links.

v1 - https://lore.kernel.org/linux-arm-msm/20250127093128.2611247-1-quic_srichara@quicinc.com/

Will add this while posting the next version.

> > ---
> >  .../bindings/clock/qcom,ipq5424-apss-clk.yaml | 61 +++++++++++++++++++
> >  include/dt-bindings/clock/qcom,apss-ipq.h     |  6 ++
> >  .../dt-bindings/interconnect/qcom,ipq5424.h   |  3 +
> >  3 files changed, 70 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/clock/qcom,ipq5424-apss-clk.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/clock/qcom,ipq5424-apss-clk.yaml b/Documentation/devicetree/bindings/clock/qcom,ipq5424-apss-clk.yaml
> > new file mode 100644
> > index 000000000000..abb9eb78d271
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/qcom,ipq5424-apss-clk.yaml
> > @@ -0,0 +1,61 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/clock/qcom,ipq5424-apss-clk.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Qualcomm APSS IPQ5424 Clock Controller
> > +
> > +maintainers:
> > +  - Sricharan Ramabadhran <quic_srichara@quicinc.com>
> > +  - Md Sadre Alam <quic_mdalam@quicinc.com>
>
> Are you sure? Why they do not send their code then? Usually sending
> other poeple's code means they do not care or moved on or changed jobs.

They changed projects. Shall I append myself to the above list
or replace them with myself.

> > +
> > +description: |
>
> Do not need '|' unless you need to preserve formatting.

ok.

> > +  The CPU core in ipq5424 is clocked by a huayra PLL with RCG support.
> > +  The RCG and PLL have a separate register space from the GCC.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - qcom,ipq5424-apss-clk
>
> Missing blank line

ok.

> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    items:
> > +      - description: Reference to the XO clock.
> > +      - description: Reference to the GPLL0 clock.
> > +
> > +  clock-names:
> > +    items:
> > +      - const: xo
> > +      - const: gpll0
>
> You do not name the inputs according how provider calls them. You name
> them based on the INPUT. pll? source? bus?

Will check and update.

> > +
> > +  '#clock-cells':
> > +    const: 1
> > +
> > +  '#interconnect-cells':
> > +    const: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - clock-names
> > +  - '#clock-cells'
> > +  - '#interconnect-cells'
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/qcom,ipq5424-gcc.h>
> > +
> > +    apss_clk: apss-clock@fa80000 {
>
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

Thanks for the feedback. Will post a new version addressing these.

-Varada

