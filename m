Return-Path: <linux-pm+bounces-41522-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id c12wJVOZeGk9rQEAu9opvQ
	(envelope-from <linux-pm+bounces-41522-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 11:54:11 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 782A593361
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 11:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D96BF300463F
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 10:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EE83451AF;
	Tue, 27 Jan 2026 10:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oCvf6tJ7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WixY8IQz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7082341654
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 10:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769511250; cv=none; b=n2d2Ny5FN1ljN9+HTEO8w+Mt7M7mMSkbRdg3uBR2scf14Jj0NBo6gDy9yt4hqMuH3xVgH9VlbGHfY971DjI635o453EFtz4y9RhxAXRJudrl2ohUfP1Untf/gUF8SUP90tPnoZPU/fqOx0pZ228TGj7IpUDUHIwcI+GpY1/diA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769511250; c=relaxed/simple;
	bh=3lYC2VXEZvD4zHtMTiboYcP1RkNOiAaEefn0klNs7gQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ss8FxgGYRWEdlb3o0a7y7Cirn/wcxedmCdb9d0HzbR5fjtuxObDUFgMShj/AQSrUCNhk2FxUJZL1IVBbw84bSQoapvzdNV+m5u+vwoTOINWGIbJ2MRDPBLrJeH5ZFoThj1ROb9jFutPMPQY7+sRbAud+bYjEbbl3B3e8PhRbO0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oCvf6tJ7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WixY8IQz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RAnqgs700163
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 10:54:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vYuSWdmfhxQX6yuMdRBnfuP4ch7+j1djxAq3/I6J3HI=; b=oCvf6tJ77bApei1a
	yr1Jwb9SAPf3KNeqq3SpFygXHryxYKaZQ7AR6yLyTz/Of1ltmRjNX35DVXkmqxnS
	xpkMpwmu+Re1PxfG58NFwKADAGrG0n2fLSAeMSl/J5nxfvCM2nJMjtBvLB8I/pio
	SSlceBlXMoY7z+mbYK83k448j0QMF1i8HsIRxmWHeZPGHV38Is5LRM5DifbJLtmH
	ZsOi54GfcDV1ZKutWwoLJNkOnVrg9Gb5iUvjO+0D7rF+c4GtVtPpSlyYixWhVnOc
	FnP7ZJEiu3a6ZMFyVPfh6QkOiyjCZrzJdRJI9e4W6qd0go9Rh250X/6ZYSfUfBM0
	MYZqYQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxew3tfjr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 10:54:07 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5014549e7d6so17014621cf.0
        for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 02:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769511246; x=1770116046; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vYuSWdmfhxQX6yuMdRBnfuP4ch7+j1djxAq3/I6J3HI=;
        b=WixY8IQz6t3FgIubz8tD1EgN3psDMkizMmTTyWiKO7u2vNOfeY5j7oPRsMMLPnfHO+
         jvAcYGdATewoBCZq1IW6rAP9bJ6I+vuhMDNjFlZoPA6h03Ifs5lJL7fICV7Lrlru/NN5
         3HLthegfTD4NV5MWwCrQ6Xb05VTrO/3UJpszVXbCIA7CGAoiEeR4OUUsc4Si2g96bvIN
         8ZLcb/Ua64IHXXPrh409ypVpPvNMditoAA/qV9aPCumkOjK/vyJ6NfWJX0uf56lCzCkd
         Rt4SV8xjcp17WranE7QtC1adn59LU64UqfRJJug4BtqwGkhGRN6400naRA3ymLKarxg6
         hSuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769511246; x=1770116046;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vYuSWdmfhxQX6yuMdRBnfuP4ch7+j1djxAq3/I6J3HI=;
        b=IzBdB9XI8nop1aB/iJYqbIat8kxodeQg2sU2Crv8x45nzjQInvXiwxAcGP5WgmDFFO
         YO+TWmWbpauv9F9MxQsvPntxYnjp2TWViJzVSeuVLkHyiDmTCp9vQ+HfE0vMWQwRfZQl
         fOEJxgaswHlMUsCp153fO/VuKs6CQJrkYolGriH+9SGjWrYF1vCOH+VH4CuNY40hcHUu
         c8IfFpufDOw7Fp9OgbDJevPQapXzrrfItqpcoVv7fRlZ68oSb8uFkxGjht+xMkClxi7Z
         2QcILH+NRdi7J+Ve8L9S31a+56D/AXmctmPsigz7Pxms3V3cVdbEBIvZlRqhr7sTPgN0
         8yeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEDrs5OEXN/VzGz7l4ycU2idUg5AhUoRJvbPFPdoQhG8VNQtg9lKtspX27xJqICF5GI1BXLvXDRA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwI9VW5q1A8ftu1bIcoW/omFkATiuu7mZA8p6ank5xYAdJJdoqV
	3ilkGwW5eVgx/GCea8Bq+m23P5aEQM6z7/gHP95oh1CQBVKHePLr/qbG4K9NzleEjP3GInIlbXA
	mn58f0ycMhK9aRgHX+wla5nggMFSW8ZkpmA6DDAGebG1n7zrbHjcLW8iZLL1xaTe0MOLxCg==
X-Gm-Gg: AZuq6aITpeBMeKbue2VWQ4QFLU1teRXNVBEkGAfnw6LCjtQwAgkgHUjnsChsJ3iwHLB
	FgdjcGADovsjxkrALAffDwQ8AFhklkPwVBKAivimPefO4Rtmkvuy+vzFTtTOyPfdrrxY/KPSzd3
	8aDWdSrbh83guEGpeG/el6f4jugczer1+OeI2BalitjA+SqZRrUSrgq7HVrwFB/3+ymqObjy0OW
	qH4rlYmVUUT+aY1aHrns2B5s8yr4jJZG2fTc1rE8/jQ/c0ePqg7xTmq/uTKE0P3EaCez75JpuE6
	5dOW7JpCwRJrkrBbqYNP1hjAa4miwk8mJi+B2e+5EDPAmZNDgnQh8fe6DYX4uFtyMI6i1y82lWk
	aFzgfvVFDjbhb0Asz3oqlDnwRNj6VliARP6u+gYnoy5GYhVh41J3Ok3gUCLxmpsocGuY=
X-Received: by 2002:ac8:5a49:0:b0:4fc:989e:f776 with SMTP id d75a77b69052e-5032f89a76cmr9794781cf.4.1769511246070;
        Tue, 27 Jan 2026 02:54:06 -0800 (PST)
X-Received: by 2002:ac8:5a49:0:b0:4fc:989e:f776 with SMTP id d75a77b69052e-5032f89a76cmr9794511cf.4.1769511245685;
        Tue, 27 Jan 2026 02:54:05 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6584b3e0a8esm6187574a12.5.2026.01.27.02.54.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 02:54:05 -0800 (PST)
Message-ID: <5b62fc63-314e-40a0-a975-9df75ec49e9a@oss.qualcomm.com>
Date: Tue, 27 Jan 2026 11:54:02 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: interconnect: qcom,qcs8300-rpmh: add
 clocks property to enable QoS
To: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260127090116.1438780-2-odelu.kukatla@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: OV-u1tCRe5d9Kf0PKoI0lPUnFHcSTvM1
X-Proofpoint-GUID: OV-u1tCRe5d9Kf0PKoI0lPUnFHcSTvM1
X-Authority-Analysis: v=2.4 cv=J8CnLQnS c=1 sm=1 tr=0 ts=6978994f cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=AbLP64ttnd7elSJatLQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDA4OSBTYWx0ZWRfX/U0DVPRaLgxQ
 ljNNODCZrN26HaxhyYaNWbUUz+AOw4y68lNpLnBBwwCL+6nM4OUbacb3BgRO6w5wjBkgPgP08RF
 8DLBlOk6ZWlFqNDYjlafqTevcfEGBHX3CpR9lrdnvUQIiS9mHGmlkh/nGQMBXkHT36yMy7ynpUe
 qIaKzZCN14Q5XREfIc9P+cfiXE+eKwOcHuAejNvWOqbfkZZJPvfiwpA2GDTgbPlzZSdLJeo5Umr
 cO4v5Adyqwf8kFJRPS53bCnbEszUebvoYPtsxw8dv4Kn9zqAI/AwPGVyMC5B/Er+dkSB8/JSk+7
 OWRHzglDYkY0OcnlYJensJYb1NorXJ5Cmsrk9oU6zqK5qErijE/BJmK6RhMA87P9+ANLxROzG/0
 DJMjONiUWd95+VNpheGnCGUCvMKcwbbHMUD3hgJ3wMi+AtqFueSW3wzw7/uv+LYy3nDaAX8vhfv
 q3Oaz5JVUeDPNvCvGTw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-27_02,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270089
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-41522-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 782A593361
X-Rspamd-Action: no action

On 1/27/26 10:01 AM, Odelu Kukatla wrote:
> Some QCS8300 interconnect nodes have QoS registers located inside
> a block whose interface is clock-gated. For those nodes, driver
> must enable the corresponding clock(s) before accessing the
> registers. Add the 'clocks' property so the driver can obtain
> and enable the required clock(s).
> 
> Only interconnects that have clock‑gated QoS register interface
> use this property; it is not applicable to all interconnect nodes.
> 
> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> ---

[...]

> +            - description: aggre UFS PHY AXI clock
> +            - description: aggre QUP PRIM AXI clock
> +            - description: aggre USB2 PRIM AXI clock
> +            - description: aggre USB3 PRIM AXI clock

LeMans has one more USB3 clock here, but it also happens to have
1 more USB3 host, so that checks out

> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,qcs8300-aggre2-noc
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: RPMH CC IPA clock

LeMans also has ufscard clk here

> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,qcs8300-gem-noc
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: GCC DDRSS GPU AXI clock

and lacks this one

Are there actual reasons for these differences?

Konrad

