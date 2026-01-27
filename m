Return-Path: <linux-pm+bounces-41526-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EM3MCoiieGmGrgEAu9opvQ
	(envelope-from <linux-pm+bounces-41526-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 12:33:28 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BF393A32
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 12:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFDF5302590B
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 11:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD4B347BC7;
	Tue, 27 Jan 2026 11:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Yt2Rq4KF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JqWV/qg1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FC1346E58
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 11:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769513601; cv=none; b=vDy/5fZc4rtGCHMP/70LazPjKO44TEQsPhClxL3kH8+B1mlvgXlRx2zgQRTl7wg5AM6adOEpY3dRtEYLLd8NjI6wYu9wqMStAFwTy4YVVbnAlFQPzfWs9n6gUMOarW1Cf9fzKKolhTjQn5t2d/ZAio5DDCcySMMhrbttTC3qhFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769513601; c=relaxed/simple;
	bh=wA+LLjAn/JqZmxJSfDsa0fsJhBB1aHPQMAUOiZx0Nrk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Eb6OqbgUsWO2OxwaOgpA1Nh2guk5EnLHIFaKAZ/FXf31J5prVhdqEctcoau7+JofjhL+gwKXQKlNUYE5Y6mwQpvSH/xp7W9Qln4JbnG5GQSIhiN91GF+XPwqjZOFVJ+nFdApnC6QtFVOJKc3Hcd4WFeid5tuEdJZBDfUxv2jQeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Yt2Rq4KF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JqWV/qg1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RAkLh73714705
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 11:33:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t5UFrsJlmEMjhkirRlXooFxQ2NogXuA5MgfcqF/u9Bo=; b=Yt2Rq4KFtBMupUop
	Jk1bY3pffgoDQE+lZrLaqy+wJqj6lOzBFht/sr8/2LkEdiNtFqswsD5JweF5ZPFr
	1VL0jS1FWvwG9kj4EDY0Qx9clQU6gCyFxVJnYM17A3QHjx7r0KUErnCDBWI6GAYR
	xorCJEbuw2GrNowm619EBF7bLNfsqEXvtnmyikyjUWNu2/NW2RGSy+ZA3U0G7zg5
	b8WC9WxuoQj4B1LQ+PzB0yKI6pPm7saSVVq93RQ3Qb2RLozxkLgAbvzMx2F2DlrX
	/Jh1X6+Lxb3/yCoTDGGEUsdisn9ayuOEWsF29IDmE9xEXHU3PKbLt423IMsOdwAg
	2k1GNA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxdv0at6e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 11:33:18 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c6de73fab8so175535385a.3
        for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 03:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769513598; x=1770118398; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t5UFrsJlmEMjhkirRlXooFxQ2NogXuA5MgfcqF/u9Bo=;
        b=JqWV/qg11eFjb/IIvzIGYGEc7m9ZqTPzpw6ZJKQ4Vjocb5hq60WYhK6alKjL2qWRak
         0IIiu19W5haKhL0RYqMujVeE67XusL3bOfjCzpxMfSC7OFWdn9IF2RO9Wkhl733IifUg
         nR6FpiETbOyiYL1c2yaqtvZlR9Yn29xMNK+7bNTLwoNTGshvH5bO6+MBz8OHw2YqCup7
         F46ABKYmofNSTj3So0pxB0FzcWTnU9du6GWCTnMapM3P/u6o2QzZDMT0D9zg3sMYt3hJ
         0aEG9ov1iPscTvE1GqPZr1fvYjxB+FcEZfUcQyTCkR4L982FBpNfv8Jx9lHu0DynaFd1
         oc8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769513598; x=1770118398;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t5UFrsJlmEMjhkirRlXooFxQ2NogXuA5MgfcqF/u9Bo=;
        b=ajNlKkvJ3H3h4MYe4FDlsW13DcpqznGbMh2yg0XeZdyxCYfl8rRbUW1QatmdDN1gM2
         QosubXoLjnJfKIIsYzHhfmtsZV/xeY9QxwcDn3C0dJ1nSe3TiPwTLnxaHnPfPKSCZgiO
         A4TU82Kc5Go5aGXXyTRi8QSUpayX9NJDchwridyBk4Vvq9NVAqd/IcFSJZtdQi+sTBcb
         mn9N9M4HPLgExtx4CrdI8JZib5B5KU8YyPaKsyEx9Mo0kkz32wcjLq27vvGLcI3kEVWP
         CVO3OOFkYuz1XHAnkkPWxIO3j6uMWXFuKM7DNJrEb8MVzb6y5ssApdmkKFjBOlQf0XRI
         /GhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQVYlsM8AJl0k6eDrEsrd8mGXxVRKJd8Zj7BHR/GXX0uRGnFFUwJcu/Mpt9cMAiLmbi2+C+yeJ6g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzeGexhi+PVdsvFSIKwd8q3LhFgEU8lXEfUc3+Ix9dop1nn06u2
	S2Gn7+iLk4bXVkabIYR6OPrtl9Y9u4NgITQ8K0fNnQjGBw6DD7cGT5/mfWIn/qdyBHqNgdPHhwP
	pJZYO52ZcSPZqBOr4BsB/58E3rS65hJP2KOWGh+og/QBkTeAl3Zl4eIGu+XbOUQ==
X-Gm-Gg: AZuq6aIqGSXgGJS8LhGpDWpxYPIGANVOAKag6hJ8vSvmwzBXgjJXwD8lsHAKYE1Rq4T
	axwqENPK5gbVDv312+ddbAy2AOleI6kK4Nc5EzhKYG/jFJrRx11KUfQttXT9UnOeMGOYLhcozi2
	32ZuHvzV3s9UgdEgXU6RsPYPz9O2tqSqJG9s4MAdlSFlElD6jkofcjeDW3Oahw17C8JMU25xU2T
	kVBaG195INrqkQkap3xw8CHrgomwb6DoP4Of82XLroORVz9VtQfLJrWzwZu5uo8GufeAHgHqB4O
	wgqGeAGRivyqhkXX9zNnYZuiDUB6TteM6YFA5UNRmBDQtIND+cQfLqvzNHoFuoV9Bh4avJppVDZ
	2jGxMJNH8/DXEZjP2arHmA/QacHHOZGCQ35OLtAqDR3ti5gCmzg+f+djjBk0nnl/gf/U=
X-Received: by 2002:a05:620a:7014:b0:8a2:568c:a88b with SMTP id af79cd13be357-8c70b939a85mr113301585a.11.1769513597865;
        Tue, 27 Jan 2026 03:33:17 -0800 (PST)
X-Received: by 2002:a05:620a:7014:b0:8a2:568c:a88b with SMTP id af79cd13be357-8c70b939a85mr113298885a.11.1769513597347;
        Tue, 27 Jan 2026 03:33:17 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8af61bf723sm576003266b.8.2026.01.27.03.33.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 03:33:16 -0800 (PST)
Message-ID: <be8dc80a-7943-4a2d-af98-6337059986a9@oss.qualcomm.com>
Date: Tue, 27 Jan 2026 12:33:14 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: interconnect: document the RPMh
 Network-On-Chip interconnect in Mahua SoC
To: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
References: <20260127-mahua_icc-v2-0-f0d8ddf7afca@oss.qualcomm.com>
 <20260127-mahua_icc-v2-1-f0d8ddf7afca@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260127-mahua_icc-v2-1-f0d8ddf7afca@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: AnnVVR3hCauVcouG_Z2jt7q_0chT4xFh
X-Authority-Analysis: v=2.4 cv=SvedKfO0 c=1 sm=1 tr=0 ts=6978a27e cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=rt5WFD0YkmQnycq5PrwA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: AnnVVR3hCauVcouG_Z2jt7q_0chT4xFh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDA5NCBTYWx0ZWRfX6U3JTw5ke+U0
 o/0rZEvWQuRHxDfZftqde8LvVzWPMncADp5ZmTFSF7a2A1qXGyBJiZFLHkA1J713r2ZGPomQGO0
 XBck/CSxvWWS9TX3Rx54SaAnbwvoBxUjWGWZZAP3shC0r1oQa3W0jGL0XFoWM+Qiex4Bcp5nTLK
 WQin2wNtkduAFl2uVaJLGDlU/xqNXI8Jkr+RLDd7+BA5dykFuvv93GH/zrI7aGbpMwfx9NxCARL
 XJ+51g5hfrdmWk0P9hQNMye2JnMTcX6ppG9KDDgm7NjV3jFdGe9WYRh3Ov1aYtpMP+IAQUCIFIE
 95zeTUAcizBI8KLLr5GkSmyKYI/NQRQ9kyXYV1xxumral+G+seQJ1O9TE+UD0LcCxzCZ0T0LKAV
 3nuD9fhkW+LMt+Ajb7CK1GOQ4CYS8p8NYxI/Nli4tFSS8SbDjOwHAEq7vYmefvWpfhXIf9bfiOP
 ehc/ky8lQvZy7UhbIww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-27_02,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270094
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41526-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 97BF393A32
X-Rspamd-Action: no action

On 1/27/26 4:22 AM, Raviteja Laggyshetty wrote:
> Document the RPMh Network-on-Chip (NoC) interconnect for the Qualcomm
> Mahua platform.
> 
> Mahua is a derivative of the Glymur SoC. Many interconnect nodes are
> identical and continue to use Glymur fallback compatibles. Mahua
> introduces SoC-specific configurations and topologies for several
> NoC blocks, including CNOC, HSCNOC, PCIe West ANoC/Slave NoCs.
> This updates the existing Glymur yaml schema to include Mahua-specific
> compatible strings, using two-cell "fallback" compatibles wherever
> the hardware is identical with Glymur.
> 
> Co-developed-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> ---

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

