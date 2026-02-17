Return-Path: <linux-pm+bounces-42746-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDqiCilnlGlFDgIAu9opvQ
	(envelope-from <linux-pm+bounces-42746-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 14:03:37 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3AE314C4F8
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 14:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C842C3068A21
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 13:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CA93358D2;
	Tue, 17 Feb 2026 13:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lYrVuSbr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QS4VC7Kx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670BB30C62E
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 13:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771333237; cv=none; b=TdS9Qy+F+30VnptpVd6uh+zpScKkEqW1DLYnQBCKR5I+dH++SqlpA+uzdqjnOqaVKMcX1JAvkwEvvfJmSqQsJUNV1iKuXQNarbcNPASWP5HAMjwuNg8RvdFZ2wlEQu62X0/sKOQMJ6bVj6Ypif4wn/Lw3tWOfBCN4j5IRBGgMcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771333237; c=relaxed/simple;
	bh=38zneP+037Vy7Mbk+7KlLjFuG+3hjob8r72QOd9MDa0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pTJLvT/e/dsWNZOIHaG0K9y4doBfDe8eqGI0BX/A0FFb8ZOL9Y1rF7LaBO01RODxZ9gAyT5GurAcz9ieMXyq3/TtCes8fzqKYw0h++Na2HlyFqn4JEJHCT/B9aSKT4PCQDujywNvgUb/ihPoCOK7qc+DlIgLQFqJOdlGDE8TQjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lYrVuSbr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QS4VC7Kx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61H9v2SU597257
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 13:00:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n30d7bzwJAIRQwkxdoxxpoTkiSLbasbG65uhCKcM8aM=; b=lYrVuSbrApOLwhCz
	UhDNBwK4CmZi3q98P0SI/cQJyJ9Nh+Q4c3gd8E6ujSRIYDqS1uuyt2d5nV1L2pXu
	mm5UG9uDq6ELDFB8CXb9Jej4KbmPemT+/dG+qL3JdheAAVYjX33VUae1mSP4nvKg
	5S9HobjJ5liRuUHVuqFy/GG2nM7yQBZUOMuvQfzDP0p6yvFQvTxEg7bFTHl7XOS/
	4ufJ6+iBRW5/aMwyhhQ62CzwpE3Zxh1Ix/bKxwyBJkVoV/hBOQfyq+FDy79Fpkhq
	DkXy8nGlQBChooCoIDXqvxCWm5SPPRuzesMib8cK22EqB0vgpUcKSAdt/IIrkKn4
	IyjPng==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cca361vwh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 13:00:35 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8954ab64c65so43035606d6.3
        for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 05:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771333234; x=1771938034; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n30d7bzwJAIRQwkxdoxxpoTkiSLbasbG65uhCKcM8aM=;
        b=QS4VC7KxyAtWWL38fHpN5f6DgMMZuLcemME1QZBaxFcPcrPgtZ5hrvtsJCrjSYvMme
         fupybgd0Bs9Lut3P4g1JdeSvLlX2sMNoKWKz/Fevz04+dDTCoLHKJWdy1wjS+i7mnWsE
         fd6YlDKsrv0FDdkdpNgT1Kwc0YXdAg5A7MgGZWL0ZccWGB3+ZV2JnCdFnwqgoRyBsH07
         DXOftZmm4RMQB2H/365uazXG3GmpTuI7bAP6kMeZZvcB3zdcadCC0b/1NV2Z94c27yF1
         mdzYRaKvImkK/NFoM1JxDJZBBaPjV26MqNysdGb8Erf5B9trusMtZgNhneSxnn+ToZDz
         nUZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771333234; x=1771938034;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n30d7bzwJAIRQwkxdoxxpoTkiSLbasbG65uhCKcM8aM=;
        b=LbuXAU1moWQY+bf77wROECVEN0vZkMjOw3WKYaqHL+7Dy/zYaQdfvu1hDSwgNsb25T
         1az32aa3QaWRe6S6cYxmLx69ct9e67U4ByyP0h4Nuw+LDShm0wzspFpdmhn+qmRoqzd8
         ZalCYBNDv+i6JNriE3CS4PpY7t7OZj1dH34GLL/rnioepn8+khM0DQSl3s6h0luXFOo3
         DAmrwnxRAPR8Vib89rB6bLMAfqvGysf+2Wy9oFuuPdIMI7RRpf5fn1xsXrUfh/L1vFBL
         InS6uCxKMsTMeALTNFdH6dde2ySWX/InEjUHwnCfu5jNkSIHKiM5ofGVD9+oR+oyfXCT
         iQZA==
X-Forwarded-Encrypted: i=1; AJvYcCUjtvtAyG2z6oWHxGqigNAhObqQMEXn8nHaIKlZSYvZySsPqFY3DXVgsWcgt32hDYzZwPc/O0g5LA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzIaRL5tTsDGszsczQEZH7Gh2NNc6IkVt4kavFuvecTSqWwQuaz
	vsS13Iq9wwLlkpikLXZ9iQjkFFiit9Kpv67q5bjRgyH/ITmUXcjyTU1qQ7pK5lFps4zSn3H+r9v
	C2Q1PB8bRKjRtRdEA39mh/P78P9QdVLD41UuH1/3h+rXvBcyUFTcXqcv5XuoRRg==
X-Gm-Gg: AZuq6aLUXtdQN5dKjir1byWoE8oAVwWBp1BapJTusiy8Kb7P0WthZsg/nKh21WDovmp
	APbL7cKZY3zc83OPmnz+PM8bRNty2apPvcGxDwoWH6/xTKnZsdB0VpS4NyGTtP08g5n2Erxbvn5
	jfk7sxE0sznwwIucJ+0bfsV93vOcts4XxelTBq84p9XkfuCcqonL/7HxQZA0t2KnewBpQoo9kqE
	ePklBupCRq1ikL+PqkigfDhL2DNSgl4YXxbqHpF5418P2dXbgUmXfW5ysHQ5YzKkVPmpSRmAoCb
	PSuQVeJe52TDhOnIijEI6nmm3H9cdeZCy0NCJc1wOFNcn7FAWSuI4t4BHNVIpA1RZow30SXZmi+
	DpyAln31nXZbgb5hnVWEX3guC/9gkbSDsejnJ2cS5Vy2ekU13G20sgGTsUM5wh1ITmnNi1P7inB
	EAA90=
X-Received: by 2002:a05:6214:4f03:b0:896:f9ed:be98 with SMTP id 6a1803df08f44-897347ce6f2mr139776066d6.5.1771333234604;
        Tue, 17 Feb 2026 05:00:34 -0800 (PST)
X-Received: by 2002:a05:6214:4f03:b0:896:f9ed:be98 with SMTP id 6a1803df08f44-897347ce6f2mr139775526d6.5.1771333234128;
        Tue, 17 Feb 2026 05:00:34 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fc76b2580sm345885466b.64.2026.02.17.05.00.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 05:00:33 -0800 (PST)
Message-ID: <45683e0f-a49c-4da2-9be6-a79623fe12c5@oss.qualcomm.com>
Date: Tue, 17 Feb 2026 14:00:31 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dt-bindings: interconnect: qcom,glymur-rpmh:
 De-acronymize SoC name
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20260217125819.281209-3-krzysztof.kozlowski@oss.qualcomm.com>
 <20260217125819.281209-4-krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260217125819.281209-4-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDEwNiBTYWx0ZWRfX9mhrCkbgJRR2
 m1f5MDj+Yu/sDAm7oLyO5jPGS8ThtDoCYtJUKELD4sUPMsi3seYdJXASApOJkVb1DjZWjHgmEpo
 Hyv75g/KXz80NZtUzR4DHRdvsDr42gXVqfkf+SRjsn5jYRirCh1LSIq19s7Qa5/XPmc/OOCTbp/
 IjXxRI15CkXbrNqVM0hz51xXfym7SFPu+S6hSMzkxJRyEvdQI1U/RzV0TDLYZdEZPDmmqIuJSV9
 MeEYineHon7ufQxo8O4TcQEfvMwkYzVS9tN4RUFscLt8fvcDSANDh+XGvrPPXX4esAFCDnMfTRG
 pCO6GNb5JpFBkz3pnND0CL8FRtDPIw/wOftpRuzt9o9U7t4TXUhFSapIKgZd47c6Kz8uChglY53
 hismTVNDg0/8LlH3v+JjgPVAy8PgeI4qevzxZZPVHAtLuuCCWe8B21rfqsybZ4F9jRH1eYxOGrg
 9BJHnbpcXc+8n147RFA==
X-Authority-Analysis: v=2.4 cv=b+G/I9Gx c=1 sm=1 tr=0 ts=69946673 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=Rh8BIR2qzSpX2dRZ-WwA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: DZt7iCV2uCUc3J1zmRXoxHndSFCMq7i-
X-Proofpoint-ORIG-GUID: DZt7iCV2uCUc3J1zmRXoxHndSFCMq7i-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602170106
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42746-lists,linux-pm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B3AE314C4F8
X-Rspamd-Action: no action

On 2/17/26 1:58 PM, Krzysztof Kozlowski wrote:
> Glymur is a codename of Qualcomm SoC, not an acronym.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

