Return-Path: <linux-pm+bounces-32514-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55593B29D57
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 11:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 172D6178E44
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 09:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7C030DD0E;
	Mon, 18 Aug 2025 09:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q+rKIoVd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552EB2367DA
	for <linux-pm@vger.kernel.org>; Mon, 18 Aug 2025 09:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755508368; cv=none; b=Ud7hsp8lz3hmWpGK75Ui/iFS0VL9RooaVKqHJ8yBHrgxQQtQ8ysSfiB64dQGk1viP/dPUZA0jh3ZWGe51XQCgwgEHNvAWAM5/+5HmOWaWt4Ys/mJHI5vlZkUbNutnYPfF6I0NgY5aAoVyOE7w2FsluZdPyPIdRIvw/97jOjoqnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755508368; c=relaxed/simple;
	bh=hoKhlgCsaez47ChkXd4smB04QyZuLTl2dlMho/S4q3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ils/EgKcl44TAF7m71sG0E8v3CY78NOLR660793mSgtsyrXJvTpvwsmOUAoRYfVlZ2ycapzNFwPDSi1P7WcLmlRcHAFJBWVehBwNnPS8mmI0DOz94hVJfqNS/9VCsDTD30w3cdua5t+7fNyqdsb3P2O/jKT2KlyouT4TdOEUCY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q+rKIoVd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57I8IvZX031445
	for <linux-pm@vger.kernel.org>; Mon, 18 Aug 2025 09:12:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	miHpGFSXBHte0kT1H33Cn6X49n9fxBNnCXyhZUBomfg=; b=Q+rKIoVdHK+xGXOh
	j9QMZbRQI9sy3NazN30IbbQoelMBHTflj4aFO0bnzu3L9Lm3ZnmNTMXz9xMuy7Pl
	uAVaXwM5rgT4A3f7x60WkOINsZ1romHkqwAPkPaMeteGwCywoKDWd/Q82X3veSOg
	lPrOGEg6sBF6oEPLujhwPau1oFHUjAWtSOsq5D7Nq9Xpk5DFQS4hwWDpbwSi1RAV
	DnpnJ7/W4+Q8JbwEB10ECvAGt2mYlY9sFzbwzXSWWFEaEiTC26Y35LNZYSFMDKAl
	lFzfvPWom2RQwly5WDkIZPA2QBdyQjFB2ZT4v3Ve4Tfvn4ujo44z9Ck+3yjtD13h
	PqoR/w==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jjrfv17j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 18 Aug 2025 09:12:46 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24458297be0so94774625ad.3
        for <linux-pm@vger.kernel.org>; Mon, 18 Aug 2025 02:12:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755508366; x=1756113166;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=miHpGFSXBHte0kT1H33Cn6X49n9fxBNnCXyhZUBomfg=;
        b=O005bcMt8NbdOYazevUm7m70O1A4kdlB8IzvHggGDnHG0PvrDdun1qIRUNvn+STNDL
         PvltIyZn6/2ZLGU35pFNz8xWRZpjZZjOlh0o3p+7ehEsbu4kq7ODv9tYRk+rGlbCzVSu
         Bm80R2/CIyM7LJxD2GSv1ytbZd24u81zrGY9yOLlM2l8YNrpkjsiuaY5ZMVeZr2XjKCB
         g3L/dG2TyGKgGQGnW2UaCp0mlc3dAEMpCHbYoR5QlosEXtUMB+mpsg6iR/O4OH4Mae6u
         yuAU2pe/bWNf0BPffFIOZBzBJ8fGySGalnFvTvCO93bOLRI7b7HKaORjRkUWn91mfP37
         CCTw==
X-Forwarded-Encrypted: i=1; AJvYcCXdvng4mEe2r4PjdQwKn4bVQ+AEPcF/mqN2m89N27LGk+QI5/FSsmdBseHycxyoF6wL4OTj6EiZwg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOb1/E/bx780PqY5djNB4RLKRr+HTB/slG/3LGtdWSZIQMRL/9
	Xrv2Vk46pEZyEkkMGAy38b7gH72oTu6EVfE7kmqNLf33yBmXApdeZyxh1yopB1K3TbZSGo6uSGD
	LHb8/kb2gsMBOSMmFvHjfDUiMHGjQ0uhXrAJExlKj0CuQxp26IU1KQHoK0oXXHg==
X-Gm-Gg: ASbGncsZSekpvY/CBH6vWOSlT4Ji8S2/d9L0IBLJBlRdLhC9A5qsVDW8dMHDdEJbjuP
	nnBSvto78P8yEht6bMkHrpD6ChXUi8H+m5ajv2iLzs/eMDGgw7QlK7bLWWxL+LwNuXXjy3n6DTh
	SzRzOTM6WKR7Vb0Jpm+H+3+K87RJg1CB/gz1UE5fmqcxIzq9OkXx9dN2W88c/lKbdvsGQ2tev0z
	GqjACjHJg/C/AkXTauSLBCvlCJlBEQVdMpXxysVk2JGhZcwgKvcYqicxXCXDozIp+Znn3hE5lH7
	t9l4pR6m0691DQRTe5JEtQCE/34yw8pyNwsOsTwpqCl1ma12DOYn3uZRB3ell8d3lG0Aznoxrid
	mcNXO
X-Received: by 2002:a17:902:f68b:b0:242:d721:b019 with SMTP id d9443c01a7336-2446d94ecd6mr204860185ad.38.1755508365635;
        Mon, 18 Aug 2025 02:12:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGI+ZnayBkfh1I+LDsy5uA5eP/A0aBudlcf26OZjn8mHjvl9WanZtIa98AhhG0B3aE2tNRFYw==
X-Received: by 2002:a17:902:f68b:b0:242:d721:b019 with SMTP id d9443c01a7336-2446d94ecd6mr204859675ad.38.1755508365189;
        Mon, 18 Aug 2025 02:12:45 -0700 (PDT)
Received: from [10.218.15.248] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d510f07sm74995495ad.96.2025.08.18.02.12.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 02:12:44 -0700 (PDT)
Message-ID: <14d0e02e-350c-42bc-93b5-c81e11b3bd5d@oss.qualcomm.com>
Date: Mon, 18 Aug 2025 14:42:39 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/2] dt-bindings: interconnect: Add OSM L3 compatible
 for QCS615 SoC
To: Krzysztof Kozlowski <krzk@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Sibi Sankar
 <quic_sibis@quicinc.com>,
        Odelu Kukatla <quic_okukatla@quicinc.com>,
        Mike Tipton <mike.tipton@oss.qualcomm.com>,
        Imran Shaik <quic_imrashai@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250804061536.110-1-raviteja.laggyshetty@oss.qualcomm.com>
 <20250804061536.110-2-raviteja.laggyshetty@oss.qualcomm.com>
 <3b79dc0c-0bcd-47d0-ab10-ba1514466d65@kernel.org>
Content-Language: en-US
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
In-Reply-To: <3b79dc0c-0bcd-47d0-ab10-ba1514466d65@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: gUpST-b1KafRgnlWZ2sq6vAgffo4c46A
X-Authority-Analysis: v=2.4 cv=YrsPR5YX c=1 sm=1 tr=0 ts=68a2ee8e cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=smnEWK7FS6KibTvaVXoA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAzOSBTYWx0ZWRfX+k8rkPJsiJ9B
 eTrGf54iBISvbG7qI4j2vMURAJtpIPpvWwRL9eWIktRrzpnvjyGNqMcJwpZMbDMzuUm+0754tQz
 moyMGYdsZsHnPv60QhzQa1mvdldmgL0BvIAeqZKXvd/oOo2HIOjZXnehkOuWh8zFFT2/vkaJwgo
 4wtTKVorkLlzQ8L0r3idKp4125neGzk3NN/gV+pj/XDeA3705BKyYn/uRQ6uoy9eEt9S0Qrinkd
 676wQrUaeLGJSuxTEkHo6LORLxyGdiGj6bk2s7aEd4+ERZHf2MOvEy9vArcg9Ac2qDNMO0oOzKr
 N/NBVJ6U0VWSA74dYp78AmY9BMHyNm/UiTgtZuHp5rmr6WNG+pdWa9JJ3osGgC1chAEFzUIb/K0
 aEDyHoJm
X-Proofpoint-ORIG-GUID: gUpST-b1KafRgnlWZ2sq6vAgffo4c46A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501 phishscore=0
 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160039



On 8/4/2025 11:56 AM, Krzysztof Kozlowski wrote:
> On 04/08/2025 08:15, Raviteja Laggyshetty wrote:
>> Add Operation State Manager (OSM) L3 interconnect provider binding for
>> QCS615 SoC. As the OSM hardware in QCS615 and SM8150 are same,
>> added a family-level compatible for SM8150 SoC. This shared fallback
>> compatible allows grouping of SoCs with similar hardware, reducing
>> the need to explicitly list each variant in the driver match table.
> 
> Drop last sentence, it is completely redundant. Do not explain to us how
> DT works. We all know that.
> 
Sure, Will drop the fallback explanation in next revision.>>
>> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
>> ---
>>  .../devicetree/bindings/interconnect/qcom,osm-l3.yaml        | 5 +++++
>>  1 file changed, 5 insertions(+)
> No, slow down, this conflicts with other patch and makes your entry
> duplicated. Just squash both commits.
> 
The conflicting patch 
https://lore.kernel.org/all/20250711102540.143-2-raviteja.laggyshetty@oss.qualcomm.com/
got picked into v6.17-rc1.

Thanks,
Raviteja

> Best regards,
> Krzysztof


