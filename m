Return-Path: <linux-pm+bounces-41674-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIFaNjEye2kVCQIAu9opvQ
	(envelope-from <linux-pm+bounces-41674-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 11:10:57 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FD6AE695
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 11:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 66280300611B
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 10:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A843806B7;
	Thu, 29 Jan 2026 10:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y7k/FHt/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K4JLPL8c"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFB334CFD6
	for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2026 10:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769681453; cv=none; b=leqznEz2ji1GQK6zcFx5KUp65yl+WhtY2sQM5oinV0ThNiyJgo5RYtb056S7XWwzvMnSeu0K9vT52CVkvt6XdeYL884aHMb123V1e99k6wC9apGQ7gVvR96JFE8xKzhPKuuayuphYvUJH/IKtagCOPmuyovNPrVXH2/pwmsFiHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769681453; c=relaxed/simple;
	bh=LuZRuTg9fMuEEloEdXRAtWRlDocJ1QarEDNgCjqMgbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A+X47cYrp7CK8MIQVGB8rSJbMse8bCGpCn6OVfdJhx6Jtk5z7kJ6K003GbpiLryHWY+HizEavuzKcMlIqJFF9oVEjXoYsvLzUWEgp4ZynW6g4cRrU2ouVSU/vfio/1ZSr6qIshuov4CujSfzp7rbc/4/LveqGl/blEXT7aSTtjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y7k/FHt/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K4JLPL8c; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60TA1Eh22373376
	for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2026 10:10:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	alAfcCd/Ehd7s5xHRU4AhlsJz4CsaVXmql0CQt5+ogc=; b=Y7k/FHt/Ssxmtu53
	LPsBEjZ2ykGkMewziYT0ibwhc3FkVNYC0pBYzTMeGA0ii7EgE2vbzWckt2y5kK6J
	S2J5t0VbAnbKUjcrumXl56G5/QXBX9OV51kKg3TM9fXPW4ustZA45VyJvcUyV24O
	LrGxeQ14gYpBdZVky4t3MizYIott3NgFDYLGTWEDpsHanjFFEwGzTUrBUCrQ3sRZ
	u70pDUR3kpelkkdxdK+LCMEP+B/HHaJq4xOM5lRpbZMk5dzdLVak4TH3U450cBu2
	MaM3XrB8Gfd1D6K1ndSLCqfUuhjxK6FfSVV706yiuKWvJZyn7zKG8unqjqxkvMQs
	m5WN1g==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bypk22wgg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2026 10:10:50 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34c5d203988so1459981a91.3
        for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2026 02:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769681450; x=1770286250; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=alAfcCd/Ehd7s5xHRU4AhlsJz4CsaVXmql0CQt5+ogc=;
        b=K4JLPL8c17ccpD1bsW6/8YyL425Y+UKN1ypxieFSAia7BWIAXiB/9IqtYh/AR/a3V7
         I4EcQNDG7796lcM9T4AUx25kfGw2XymCC4St4VtPxOOmefMNIssn8bXnQFFqDmhZjs6e
         Qt2zl83+k/pqIXFhbmEbt2NAavI4mIjQAp8doZ9kC9lp4foJmcVAhZyTtbWAbUmofxH1
         you+tywnch9ed+U7o6DwGqhoCliWlNkPGasfl7EQKrWLZmkJDSeBjuBPcajzjkohG39v
         Ye5mbFVFWevcDfzhc0jTzkHhwsWJaNq82LPnKEei+erNNITdxHkWG48u52Aj6xvy+98u
         3glg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769681450; x=1770286250;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=alAfcCd/Ehd7s5xHRU4AhlsJz4CsaVXmql0CQt5+ogc=;
        b=uZAbNYkJEJ4Cg8/v0V6ydjXxQ9rTLi3Rnzxc62aVdVgFIOFR1/o+Wx1yhlqdk6OKLr
         hjppJY1shAE2ZQJ73V5wY8ReMWxML9s6A7QX9d2lG31pmhBpDrDmFkvc8CN3IAuTev1F
         AVMHAuOdLlJvkeKRyAikVMOZ6rCrFHQy095+NDY/FigAuKzBjRA2o8d5QmUrhqmEr2FW
         d77L9nrslvb5JvtgMKbRyHymSPe7rgeTOJIvtAFKdIh4aN+w6hzwVfl0N6LkPF3NFmQH
         G2AoVHsM9Y/tnbEmYPR5kovWRmM1pjImQInB9BRcjuHGA8S14WXwnz2mUcybUF0e4MZu
         UbHA==
X-Forwarded-Encrypted: i=1; AJvYcCWiMDH1DEubScMkqls4v5qyrHBM6IX9P4B9X7G4Q9UVsRNabUiHdrX9qsZC3dgOoWs1amOs2xvC+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJFQGPOM22CuVURrbvQue96yG0On2abmBUQlXay9UG8Ls5MzeA
	1QNsYIiROcIphsfLmvPaZiX0Rqs+niGXMCTGTeEuidRVmlXeIPNGFAnpmfBr680nWQs5DD8YP95
	g1/pMZbC2X7QztfcwxZPWQvw+oQRctHakEQO6sVGfCjhI+tp1AW8NkP/KQXiDSQ==
X-Gm-Gg: AZuq6aIULEnKxYmCuuGAPRoHD/fSWY8QavpjZzlKsOHJrOTeNMhnErglyuQ2R+AjKJD
	wUViFzhPMtbELc+IQCmBfyeQ76q94CyJaXZuG9Y9rvWPLkEtlIBE/uU6kDrBmyUPax4Uy8ai3Ea
	S23AV29ZRkEjo0OFdlJ9wR2z/KcZbdV7RhO0WEBUTgsvzTfaKJYSqHZKq9E3MEoxICobp7PhKQl
	wA9y5XV1l1MSwcB8BvA4uROTAhslCSUI8fLla+2dwCx5FD9MMvT4NFj+fD4fk9Ysv16fcXU6j/Y
	1qzdW7L5dC4fvuBTdAyC2/r0EoHaoxOAnACaoTr2gxf8E3jHGD5m2ls3OMivlaMS2qu+Z/pHh0f
	JaeYHtvZ09otykLwbwqlrU6cCPQ3wzKcN6calm6ddjg==
X-Received: by 2002:a17:90b:3901:b0:353:e91:9b2f with SMTP id 98e67ed59e1d1-353fedcc422mr7778772a91.37.1769681450190;
        Thu, 29 Jan 2026 02:10:50 -0800 (PST)
X-Received: by 2002:a17:90b:3901:b0:353:e91:9b2f with SMTP id 98e67ed59e1d1-353fedcc422mr7778738a91.37.1769681449740;
        Thu, 29 Jan 2026 02:10:49 -0800 (PST)
Received: from [10.217.217.159] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3540f3cc7c6sm4960669a91.10.2026.01.29.02.10.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 02:10:49 -0800 (PST)
Message-ID: <ee02056d-34a4-4300-acab-98fc50c43a0b@oss.qualcomm.com>
Date: Thu, 29 Jan 2026 15:40:43 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: interconnect: qcom,qcs8300-rpmh: add
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
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
References: <20260127090116.1438780-1-odelu.kukatla@oss.qualcomm.com>
 <20260127090116.1438780-2-odelu.kukatla@oss.qualcomm.com>
 <5b62fc63-314e-40a0-a975-9df75ec49e9a@oss.qualcomm.com>
Content-Language: en-US
From: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
In-Reply-To: <5b62fc63-314e-40a0-a975-9df75ec49e9a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=PfvyRyhd c=1 sm=1 tr=0 ts=697b322a cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=hncvHjIp_o2DDOFygSEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: JzIzRDRk2LNPY-CSYKBrs7Md6II_orcu
X-Proofpoint-ORIG-GUID: JzIzRDRk2LNPY-CSYKBrs7Md6II_orcu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDA2NiBTYWx0ZWRfX8LH3b5dYhJ/k
 izWQ8TTXy9Z89/3l5LSfMUJNWkiYv6rffOp52FkYk/wQqyX8+JhA7tAWzXtM0s5Ks3k96Qwi11s
 otx5oLZr96qdy691TSs6P1TxhBUhYN8XCrqYhKvp+VDSc81i2qvpnpa+kAuoACSwx9PDQWK9que
 gbBL20ejQR5rCPfS6KTwQ1d34tdqWI7zXzxb67vjcOcT4zd7vo0gZHqoTGdqCZyDbOwTD0LjVL6
 RNscLxnDYy/yxRGbuHVFiEC4BbZadn1fqezilbyDO4h8HVTakggaasnuXBU0yUQDmjng1+hVpIu
 auiU7M3TNkm46jDlDOAMJk7cPioL6mBlrgd1k5HxVS9hTmMr5hRnGO8UbAssfaw27eSF1tdTRhh
 rgdCUEoZ3NysOVb+fiqO4WjhJ6p0icjewx15qZoAg6ZFUQKr4OVWeZr6m3MaTrHEZn/CEZ/a/DV
 nLIGFKVNUzDxCziLXww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601290066
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-41674-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[odelu.kukatla@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 15FD6AE695
X-Rspamd-Action: no action



On 1/27/2026 4:24 PM, Konrad Dybcio wrote:
> On 1/27/26 10:01 AM, Odelu Kukatla wrote:
>> Some QCS8300 interconnect nodes have QoS registers located inside
>> a block whose interface is clock-gated. For those nodes, driver
>> must enable the corresponding clock(s) before accessing the
>> registers. Add the 'clocks' property so the driver can obtain
>> and enable the required clock(s).
>>
>> Only interconnects that have clock‑gated QoS register interface
>> use this property; it is not applicable to all interconnect nodes.
>>
>> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
>> ---
> 
> [...]
> 
>> +            - description: aggre UFS PHY AXI clock
>> +            - description: aggre QUP PRIM AXI clock
>> +            - description: aggre USB2 PRIM AXI clock
>> +            - description: aggre USB3 PRIM AXI clock
> 
> LeMans has one more USB3 clock here, but it also happens to have
> 1 more USB3 host, so that checks out
> 

Thanks for the review, Konrad!

On aggre1 noc, QCS8300 has only a single USB3 path, which corresponds to
the clock in the binding. LeMans includes an additional USB3 host block,
and therefore has an extra USB3 related clock that QCS8300 does not
have. The difference reflects a real hardware variation between the two
platforms.

>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - qcom,qcs8300-aggre2-noc
>> +    then:
>> +      properties:
>> +        clocks:
>> +          items:
>> +            - description: RPMH CC IPA clock
> 
> LeMans also has ufscard clk here
> 

For aggre2 noc, QCS8300 does not integrate the ufscard controller
present on LeMans, so that clock is not part of the QCS8300 hardware.
The only QoS relevant clock on this node for QCS8300 is the RPMH CC IPA
clock, which is why only that one appears in the binding.

>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - qcom,qcs8300-gem-noc
>> +    then:
>> +      properties:
>> +        clocks:
>> +          items:
>> +            - description: GCC DDRSS GPU AXI clock
> 
> and lacks this one
> 
> Are there actual reasons for these differences?
> 

The gem noc QoS interface on QCS8300 requires the DDRSS GPU AXI clock to
be enabled for QoS register access, so it is listed in the binding. The
difference is therefore due to SoC level differences.

Thanks,
Odelu

> Konrad


