Return-Path: <linux-pm+bounces-42117-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IASaGYIzhGll0wMAu9opvQ
	(envelope-from <linux-pm+bounces-42117-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 07:06:58 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10182EEE40
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 07:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57A003012EA2
	for <lists+linux-pm@lfdr.de>; Thu,  5 Feb 2026 06:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46B33346BA;
	Thu,  5 Feb 2026 06:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N6HnOaTB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BVlxgQK+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E333346BB
	for <linux-pm@vger.kernel.org>; Thu,  5 Feb 2026 06:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770271599; cv=none; b=UEN7XPm/HRXZkrvT2RfrBx6F31P5e4seds3q+N3Pq9qSimUMkZ5QaOluFDOsffzsIUPOLBOcTvs80dr+SDx+oevrZMEcIp6kYWF2T7yHKTapb8aa1LrlPtNAIAJ6Uvuzb7bcJJQD0CaAPclOBFhhayYmDozHR1Bq7gEBd2Fa7Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770271599; c=relaxed/simple;
	bh=W5XmK99bjm5gkQXYYsjSJVpztl6lX2YWiWGLKcFRNYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PlG4DS1JD+IgBo8ZfcEVQQtJWLxtkqD19Zzb7YIyCKLNIFihtzR+6Z/OUoUK73/PR7Ke8fEqCSfFTvV9oLpROIuSSD7lyKz5u1OUiGMVLwkHO9mIHZBYCUT3Y++XQOb4V7zwHKFpeJk57U5J5CC9DcnZyCJ6ttckhR/0z7sP9kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N6HnOaTB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BVlxgQK+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6153dsrn2103227
	for <linux-pm@vger.kernel.org>; Thu, 5 Feb 2026 06:06:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zpUgOaarMxWlFq3fkacO1kxJh4mzQRH7jDigZm9N55Y=; b=N6HnOaTBmWPKif5H
	8f52g1ovv7HZ0jdFxDX0wMVyf+nQ3L6Cnozm1/eoFnBTF2R/L6YsEmtSH4mJm6HR
	yosl+wm5g+Uvj0ks4dfQZrtet2d4sqd7uIZdKcQucGcD5eICSOIoAHbQyGV82h2X
	AKxbX1H9LPIuoYTbp2GJYC6XUyc+vIrpY8ozpGTYwLdSEasGpMFqjrwEFUlDTqzP
	a/Dmko550GjhfZN0im+j1e+9wR1RXxxaVfbdlPduafsUhTT7Ix35VtMc3yuVZxPr
	S08KekwUQ/8QqQqQ30yQpBsPx/O/pYIwWnp1SKAme6LyJksKFPDA+PIM7q0R75v9
	d4Bp/Q==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c44xjk4y1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 05 Feb 2026 06:06:38 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a8c273332cso20335905ad.1
        for <linux-pm@vger.kernel.org>; Wed, 04 Feb 2026 22:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770271597; x=1770876397; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zpUgOaarMxWlFq3fkacO1kxJh4mzQRH7jDigZm9N55Y=;
        b=BVlxgQK+YNS0CBd27iCXgFRvh4gbdbfknqQTc38KPwiuHXCc44e68aMMQGIlJj8r8z
         LHqV3fCo9L3AmTII/MBztOblVlpS+hd/x4vmGlzl+KZQOgaIDUrYpiIcx05J3hckPibO
         d2/viELySa2tlLw/UuErAhUGKrgcXT67hLy1hoH+HS47LuXAdHmkbZf0XwKz86GcJEjE
         8Ds1UCh3PdexY8pQrrUkuvq4pRNo3CVvtftGiOx59NEAPDwyPh1EXHgTkok+eYFjtMK/
         g8bj+Rb8hLzp0tZKPNfRXalarrz4edBM0lQhWdCaj6QVNXAC+uhyiwGS2hf/EzVs0Y8e
         ZXQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770271597; x=1770876397;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zpUgOaarMxWlFq3fkacO1kxJh4mzQRH7jDigZm9N55Y=;
        b=G4GyC/MdrG7xWOrf6gvTAkJkmaxjQnIrEJ5y+2q1BBTHaCEZfop1eE+Dd0KNZXYHK+
         PREaM22lbFhbBJUnS9+/BzIeA2cAPTXeuHW11gWec4r8RAQVAuTcQwsTjEiYzKxoKHyk
         0WwcjYV4SuzxCrGfEzBGejaz/gJUml4YyB9e5Yz2hgzCjLSHF691cUX21Cpa2+9N+x4c
         m7V/+FY4RxW0bpUEAL3NuND1Aos3V889CiRtuNFf+WJjjlJIofdPVAXXYt66rp6wuict
         Xbte5zIUkQYQM9XGZ/gbb8nHfclp0plYWEFASXi7wAFA+A9kJymPR1MLMuyEEMA2MKOf
         6LgA==
X-Forwarded-Encrypted: i=1; AJvYcCWWXWTsjLFvxKGwS93DpoDjGhQYdMyt4aj+RYjSKMQ82a77U5GvEiRBDGr2qX4mU9QWG/GWwdMfag==@vger.kernel.org
X-Gm-Message-State: AOJu0YzoowaqnlhmuVRHokS8QVfTeOkqAFRggMjtlkLn8wf6nO7Nvhje
	7ngzqcdCV3UHnM8EPC94g0Yvi43T82qfQsTwAj5VBrIDC2U4pRKLdJKNs2+KQUyv5+rn6OBLU12
	mq3O1jbxUaEHZuiXj1wmJbVkk4AYv/+iJriMQOQF7P3rtlQNhNPg9lVU1aJ1qNQ==
X-Gm-Gg: AZuq6aL6lsNncjMPjs+3S/oD0qy8/fN5qc85hjOg7PlwbMXm0t4tmpidfthQdKBs6x0
	8dY2aJ116SMN/i8+NbP004BdCo31SGGe/X233QHHAs0POqTCy7shK0X6q3LSjd6PFRBG8uvP1i7
	55S1hsG7gtkti4E35Is5IYthT/ltEHetbzyGmb58bzZrDPpmsKc930KIINLneHpRzC6eFq72UMw
	DUIWoT+jRV0Fkzn1W5GwQIMSscnMhx+mdy6vGWppUPbGCW474mVUtq3nZ1BhE+OaW3M3CZ690Lp
	4KoRHegNds8TJandEBDGz1FnXltWR4EaBj+jhhnVgicZZnjWvCCFLVLIT0wZKd1vqmkytBKbyCS
	UvbDFjmF/8fltMJj6c/aJUHq8Ji61TDJ6X6swuFQ=
X-Received: by 2002:a17:903:3d0c:b0:2a7:683c:afb8 with SMTP id d9443c01a7336-2a933cf2c30mr55092795ad.16.1770271597364;
        Wed, 04 Feb 2026 22:06:37 -0800 (PST)
X-Received: by 2002:a17:903:3d0c:b0:2a7:683c:afb8 with SMTP id d9443c01a7336-2a933cf2c30mr55092505ad.16.1770271596900;
        Wed, 04 Feb 2026 22:06:36 -0800 (PST)
Received: from [10.218.32.38] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a93394e635sm43375165ad.52.2026.02.04.22.06.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 22:06:36 -0800 (PST)
Message-ID: <95d42fb7-2365-46a0-a995-c9cc51b17424@oss.qualcomm.com>
Date: Thu, 5 Feb 2026 11:36:30 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: interconnect: qcom,qcs615-rpmh: add
 clocks property to enable QoS
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
References: <20260202070534.1281652-1-odelu.kukatla@oss.qualcomm.com>
 <20260202070534.1281652-2-odelu.kukatla@oss.qualcomm.com>
 <b37e6569-61e9-4998-8fc0-603b83edfa2a@oss.qualcomm.com>
Content-Language: en-US
From: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
In-Reply-To: <b37e6569-61e9-4998-8fc0-603b83edfa2a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=DtpbOW/+ c=1 sm=1 tr=0 ts=6984336e cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=DimUt8WxFD9JPiqUo1YA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: Nso9StGg1u5alC3m1zQ1J4809QSBqiE2
X-Proofpoint-ORIG-GUID: Nso9StGg1u5alC3m1zQ1J4809QSBqiE2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA0MSBTYWx0ZWRfXzxXk2XuCx2Yb
 EdupcM2zuIBjbX4npVVzCu8klybyIGTR64YafZ+aWavaITcg+KhI09M9Aw7POPLtXdSB6UqlLeY
 1M8OAd9GwwA09G6rF0mPYZ267+2RvTGfeTcsNr02uvntvs8w+VHngxxyR2VfRPDd993XmnOV8pS
 qryL0WOlSVNb/VamrO4G2zq4iWAPg0gFtXARtBafmpyeyWqfX6M1RRjlUegOZKYcYdQ7NDCDqaT
 aHZRx7JekW0qqzSwnLEduS/msEOtEqPOmoNrO79W7Rgmx+AbLt/YIx/dPsaMjQiuy8pXEma+PVL
 sKhMqliKkUTqTuXhX1wMhcCuEzB3oCflyWyoSQgiMrZdondl0IXktWm3UlFdprxsnx+dxttg1xA
 xDKhbNbEI2N79/dgHVuKBmFlG9HOuo0Lr8nahdQcgLF2B3qE/WvdHk9HdPyCvDlVZQTcWY5DM2Y
 1+5Bt2arQoejaW52VIA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_08,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 phishscore=0 suspectscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602050041
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-42117-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[odelu.kukatla@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 10182EEE40
X-Rspamd-Action: no action



On 2/2/2026 4:33 PM, Konrad Dybcio wrote:
> On 2/2/26 8:05 AM, Odelu Kukatla wrote:
>> Aggre1-noc interconnect node on QCS615 has QoS registers located
>> inside a block whose interface is clock-gated. For that node,
>> driver must enable the corresponding clock(s) before accessing
>> the registers. Add the 'clocks' property so the driver can obtain
>> and enable the required clock(s).
>>
>> Only interconnects that have clock‑gated QoS register interface
>> use this property; it is not applicable to all interconnect nodes.
>>
>> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
>> ---
>>  .../interconnect/qcom,qcs615-rpmh.yaml        | 44 +++++++++++++++++++
>>  1 file changed, 44 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,qcs615-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,qcs615-rpmh.yaml
>> index e06404828824..096a9064cc01 100644
>> --- a/Documentation/devicetree/bindings/interconnect/qcom,qcs615-rpmh.yaml
>> +++ b/Documentation/devicetree/bindings/interconnect/qcom,qcs615-rpmh.yaml
>> @@ -34,6 +34,10 @@ properties:
>>    reg:
>>      maxItems: 1
>>  
>> +  clocks:
>> +    minItems: 3
>> +    maxItems: 3
>> +
>>  required:
>>    - compatible
>>  
>> @@ -53,6 +57,36 @@ allOf:
>>        required:
>>          - reg
>>  
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - qcom,qcs615-aggre1-noc
>> +    then:
>> +      properties:
>> +        clocks:
>> +          items:
>> +            - description: aggre UFS PHY AXI clock
>> +            - description: aggre USB2 SEC AXI clock
>> +            - description: aggre USB3 PRIM AXI clock
> 
> Should we also include the IPA clock here?
> 

Thanks for the review!

For QCS615, the IPA clock is already enabled by the bootloader (xBL) and
kept on during the boot‑up stage. Because of this, we do not need to
explicitly enable the IPA clock in the interconnect driver when
accessing the QoS registers.

Thanks,
Odelu

> Konrad


