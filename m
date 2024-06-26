Return-Path: <linux-pm+bounces-10048-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9142B917EA0
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 12:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CB481F26F9C
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 10:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0648F17E91D;
	Wed, 26 Jun 2024 10:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Q62gMyFh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8244917B515;
	Wed, 26 Jun 2024 10:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719398661; cv=none; b=FJR05SB2hl3pMTf9ypqG3ha5peXayFIMj+Ac3PvHYWLaPUQDdXuTmCor1X+oMANN18NpeMl3ADyF4RvDYB17AOISTwXedII0+YcOmchDoYgKpmVXAdPuZ/QuD+WnjIZeChE+LkW4t+FWH9v+yBeBGzYwJFPOIkmCzh0LGOQKd+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719398661; c=relaxed/simple;
	bh=R3GRbyGx9M/Hr1OVX2dpxLLQAI7cK3ppn/bP+mhwYmo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A456MZTad7rp7rP9nwTc5HEKG4X2u+kEf+l8JOnI7jjnBUZcfu8RwSYZOeQwrtRA8Nb6TIf40V7PCkzScSJMOX9pfi0SqTQZvWoOe3LTsiJ4JAgjxciiHbkSYdjvQB7xeDRcmISOgOTpknn89kjyr81/yoHFVW5nTXCvEOydLGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Q62gMyFh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45QAfUiE023737;
	Wed, 26 Jun 2024 10:44:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=vguv0t621FLX2XUylRpzIQ2j
	7OgLYF8Khqo1WBObp2A=; b=Q62gMyFhRW/PfqBj3yiGbu5lwyKazW2A2u9O6F85
	cR75opeY/wtBmEixla4iULdq0LKXjX01UzDW8KVYPXffJWNlyKKg3blI4LjqGpf7
	YsEnUYjUnKxJLuq0SP2yHzReV9jbvu05O5l1sqf/07i5QN4DIF0ucB+Gix1Auvvy
	ufO8ppmOkeh9680vTY/MuSo4B9WGt8SS/a36xK9dX21WvaGDKYjsqPhfkZlacDq3
	Y6uYPOaCN6Z+7N/BRScz4n1bvqOwa215QO7vwyNwlGmM+4jW+3QMlzalCwAtQvKk
	kTva4KUBq5ey+q4Pbb4Ww2Br7syNW2FdIWzK1hl70HVUlw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywp6ys9pn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 10:44:13 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45QAiCgU001685
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 10:44:12 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 26 Jun 2024 03:44:06 -0700
Date: Wed, 26 Jun 2024 16:14:02 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <angelogioacchino.delregno@collabora.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <ulf.hansson@linaro.org>, <quic_sibis@quicinc.com>,
        <abel.vesa@linaro.org>, <otto.pflueger@abscue.de>,
        <quic_rohiagar@quicinc.com>, <luca@z3ntu.xyz>,
        <quic_ipkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 0/7] Enable CPR for IPQ9574
Message-ID: <Znvw8hLozRvWo0Ng@hu-varada-blr.qualcomm.com>
References: <20240624050254.2942959-1-quic_varada@quicinc.com>
 <5xgjszacvtnjftygwvtonb4npspaceutnvnnniebxntii4tmud@xag2c6j2svqa>
 <ZnkXJWXI/mfP/vG+@hu-varada-blr.qualcomm.com>
 <ncfhv75xjnuz4bdkhzqmiqrg3khez57bwcvrhp6unmwxrlol7o@etkokfnjuuru>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ncfhv75xjnuz4bdkhzqmiqrg3khez57bwcvrhp6unmwxrlol7o@etkokfnjuuru>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 05w_-6934JLRQNeQCr-mK1byMQXusmqZ
X-Proofpoint-ORIG-GUID: 05w_-6934JLRQNeQCr-mK1byMQXusmqZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_05,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=693 bulkscore=0
 phishscore=0 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406260081

On Mon, Jun 24, 2024 at 11:02:35AM +0300, Dmitry Baryshkov wrote:
> On Mon, Jun 24, 2024 at 12:20:13PM GMT, Varadarajan Narayanan wrote:
> > On Mon, Jun 24, 2024 at 08:39:55AM +0300, Dmitry Baryshkov wrote:
> > > On Mon, Jun 24, 2024 at 10:32:47AM GMT, Varadarajan Narayanan wrote:
> > > > This series tries to enable CPR on IPQ9574, that implements
> > > > CPRv4. Since [1] is older, faced few minor issues. Those are
> > > > addressed in [2].
> > > >
> > > > dt_binding_check and dtbs_check passed.
> > > >
> > > > Depends:
> > > > 	[1] https://lore.kernel.org/lkml/20230217-topic-cpr3h-v14-0-9fd23241493d@linaro.org/T/
> > > > 	[2] https://github.com/quic-varada/cpr/commits/konrad/
> > >
> > > Please include [2] into your patchset.
> >
> > Did not include them because Konrad has agreed to post them this week.
> > And, I don't have an MSM8998 target to test those changes.
>
> At least CPRh-related patches should have been included, so that we
> could review and comment them.

Have posted v3 including the patches that I had added on top of Konrad's
changes (skipped 2 of them as they are rebase of Konrad's patches to
top of tree linux-next), and addressed other review comments too.

Please review.

Thanks
Varada

