Return-Path: <linux-pm+bounces-32243-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA86B240D1
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 07:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B94BE1AA0EB6
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 05:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B762BF3F3;
	Wed, 13 Aug 2025 05:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iaheEKzP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D26293C71
	for <linux-pm@vger.kernel.org>; Wed, 13 Aug 2025 05:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755064545; cv=none; b=W9kJaTIRnu1cOeuy0YlNUzqtOofRpu44j2V0n4ugZuTrbWaNKIWLjrDBOjCwQSPMIr9iXaKg1IagPV1FQ7EP+sw01iBFzWixqNajaDFDtNe+G9lFdeNmjvcpIYQ0ENhCZVM83EBH79mkaRbWC9n/xZFi8tq5zZbNYzxrXOzhp0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755064545; c=relaxed/simple;
	bh=3+UCjNp2P71sZESLCJbR548hn2AjfdJICXkD9Womauo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hj3BYTxXeKExYsReS68bOXsNQ37tdVrvOJ+VI4lKC7IUqob+VyKsQ/7tY2MMxurEFwLDEhyvplNehcWUJcVq4OQbCPkwF5NnvG/QiohCpkFRcSEVvjVrLnOkWsmvdFaJFtn1Vz1BdaEtfz/vH2Y13gSoCdITgiXxYoshC8fU3Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iaheEKzP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57D3no1L019026
	for <linux-pm@vger.kernel.org>; Wed, 13 Aug 2025 05:55:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3KHpx4xczwyhMGyk6W3OmOsK7r2nQtCAjXkX3DDdjW4=; b=iaheEKzP4zWC+epU
	VC6Wu0l3O5LUjPqmaHAiXiztUZF0i/NBaRlsEJzvvLvS1Cb7y5FeWt4LVLZ20fh/
	kKBhTFlIGLQLbzkKqrqYgR72GBFW+jxwsaHQ3XG799rVXT3tRa8vSeSf6ZmAWnuU
	FV8f0aVh1OBM/J4G1KGaPCP9NtwayK/B0uW4nlKoe9f10vnxZvssKTKq4Vd5uwlm
	EvpnRBeco+YFDLhDAe11i2JHtjHGH4sJ08FDgqMW17qf/4L3pmM2Do6/Fo7g3Qi7
	m0gsUuyLnoxNMmt/n/Ta2HXTii5YYHhRG8mGeyQHsKZtQnC5vXLcLpFKz0qEQSFZ
	qBcnRg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fem4ek59-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 13 Aug 2025 05:55:42 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-240b9c0bddcso59894445ad.2
        for <linux-pm@vger.kernel.org>; Tue, 12 Aug 2025 22:55:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755064542; x=1755669342;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3KHpx4xczwyhMGyk6W3OmOsK7r2nQtCAjXkX3DDdjW4=;
        b=an6Nvzdjf5JwjmPRRhNUmBbXuObxnkqz3+Qtsek3hhI0vEGvmb3URHxHNSeA4JE2NW
         n/CkegT+d7VjPN80G71HeNzFrRDqPzJhUPMSodYDOhGwBSPJVtZ2WfAENSe3rZd9lfDZ
         10rOyGpia3h1pbu1JMGHHZRa+yzXhf3QPOkrjyaw+KhBdUDTh2XpXuG6MHgcw4dtllix
         k/Jn+RBZqIwXllKcEJlTOa2AKW/kQzR8q+nejT2xyhrBhm6HpOm5X26LMcu2kjnTA2HY
         tySpMkD1cPlgRKzFWodvsPVEJKjDbugjX21/wOY+3QcyV6Mh6RSLpVNZ4VnlUwvyhfFU
         a7zA==
X-Forwarded-Encrypted: i=1; AJvYcCUBcM6peMeYj2npfMuURTmt5mv/qBTQvlOL4sjT57wfBJbmfWS5ew3xKY68qxr4EkHskp5gKJ0XVA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzARcVbFruyHeUxXzmVKMZ3l7/rqN2IN1d5qSRo7aRopCQkXkWm
	0gygsZSLvcXeAiYyo8G7/naMOE3U6J5z7eJ3uRVsvXlLBkcEzBAX/XkUiwRlYHZukQEl1u8XXSb
	zWuyiNR/sR2SOul48IyfPchHqmRmE5YNYvymwBdBbb4Q6nKizMK2yEGhJv5CF/A==
X-Gm-Gg: ASbGncteghL07y1BZdnmO2Lc6181sI+cdineUCxaVFkxMGRfYIJvC2b+/IA4GwbGfhZ
	bfWbi/CrvXVHE8AwbJ7Hs67PrHVVwffF+5eTwwjRP/RZBji8xsJ7kHu/NFKvRI9+hZWFOZgo9Tk
	3Y475uoQvelGXsKPQ84zsouBYEEvATMsrmBG7c2VUVfY6MtZMQ+yDhfZpYLFwh++6KeGOj6alkw
	Vzq07J3JR5WpSoWSFttcAmt5jEXJq/SJv7OKfhMVhhGN6lSRxCZOlceLubhPE6D2uREA6w7aXDv
	nrMGWlhe6V5MO94hC0puM6Y6oSg7wyLrEgl82l9dpQKQsR1EWPNM6UeEDAzY4xi0nDv3N7A=
X-Received: by 2002:a17:902:dace:b0:240:3e40:43b8 with SMTP id d9443c01a7336-2430d238147mr29979465ad.53.1755064541635;
        Tue, 12 Aug 2025 22:55:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjeZLj43GZgvnhVo3O62NOP4Bml3NVZ5MjTOxx/SHNJD2XfpLuuuU0j95oZyQKtcn4cXkmyA==
X-Received: by 2002:a17:902:dace:b0:240:3e40:43b8 with SMTP id d9443c01a7336-2430d238147mr29979135ad.53.1755064541187;
        Tue, 12 Aug 2025 22:55:41 -0700 (PDT)
Received: from [192.168.1.7] ([223.230.83.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef48fbsm316527015ad.36.2025.08.12.22.55.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 22:55:40 -0700 (PDT)
Message-ID: <28b97952-1b67-411f-a7fb-ddd558739839@oss.qualcomm.com>
Date: Wed, 13 Aug 2025 11:25:35 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: interconnect: add clocks property to
 enable QoS on sa8775p
To: Krzysztof Kozlowski <krzk@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
References: <20250808140300.14784-1-odelu.kukatla@oss.qualcomm.com>
 <20250808140300.14784-2-odelu.kukatla@oss.qualcomm.com>
 <90b51e31-3217-4483-bb5b-ec328665a723@kernel.org>
Content-Language: en-US
From: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
In-Reply-To: <90b51e31-3217-4483-bb5b-ec328665a723@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: MtX6s0CGRmsX5JksjYHwxj1yt1-liGmr
X-Proofpoint-ORIG-GUID: MtX6s0CGRmsX5JksjYHwxj1yt1-liGmr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA2OCBTYWx0ZWRfXyKQyXsV/Q/WE
 Nurx14BsODlVTtGAcYrldkYDKmZEpJS/hi0s+LuhnCRUVs22wOzSJVHyYv1GjEAXtE4ESw55tVU
 wtNXVYjpzaonP8xpwzzIo5Dg3/GtVwOaiXBgnLwCuWCjQNYFiJ65dKNrbt7grqBxTOqnryeffAo
 jccO4niDr/D+PzOuuCz6rGMxpmSbWlIuwYaMO9GqDN2LTV257gig5F3aDTO9nN0jVEyWX8liqVd
 xNtCxJBve1cqHwjYuDHlRfblq8oaR32RGyRmxAP+OwZor2jt8Kx+gK8fJxNC3dQmEwxUluXtWSO
 GhM9/JDUaKqQlXZkbbH+xolPQlXSLkSgQ4emIQBZzJtguXN+o6+2KnwE3bvMHW1XvGkGY8+GLou
 2Yph32AL
X-Authority-Analysis: v=2.4 cv=YMafyQGx c=1 sm=1 tr=0 ts=689c28de cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=SiMmawhtwnuHYgKqZ0PRSA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=_8-003QpdazN-62OuQ4A:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0
 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110068



On 8/12/2025 3:47 PM, Krzysztof Kozlowski wrote:
> On 08/08/2025 16:02, Odelu Kukatla wrote:
>> Add reg and clocks properties to enable the clocks required
>> for accessing QoS configuration.
> 
> 
> Nothing here explains why EXISTING hardware is being changed. I also
> remember big discussions and big confusing patches regarding sa8775p
> (its rename, dropping/changing all providers), and this patch feels like
> pieces of it without proper justification.
> 
Thanks for the review.
I have added description in cover letter, i will add here as well in next revision.> And this is hidden ABI break, no justification, no mentioning either.
> Again we are discussing basics of ABI breaking patches?
> 
If you are talking ABI break if we load old DT which may lead to crash, we have .qos_requires_clocks flag which takes care of skipping QoS if required clocks are not enabled.we have addressed this issue through https://lore.kernel.org/all/20240704125515.22194-1-quic_okukatla@quicinc.com/ 

> Best regards,
> Krzysztof

Thanks,
Odelu

