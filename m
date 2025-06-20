Return-Path: <linux-pm+bounces-29167-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F62BAE2077
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 18:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D75634C1F35
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 16:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4FA2E8E16;
	Fri, 20 Jun 2025 16:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oAfEnH0L"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D21B1F03C7
	for <linux-pm@vger.kernel.org>; Fri, 20 Jun 2025 16:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750438643; cv=none; b=Sbh+BIXqRSenS5wHF05kGD/qtpUaQ0Cjlo61nOw80r5C9ymqiB7Gw/kYimjckcrS02pBtoD//CZzpg/UvrySTowe0SzAd6EvQIfm8bU5wxAMaSr7Binm5fPyv2POKkn0wDRG1H2mwk94PMICOcmh2X5R9YWfsg2t30ATaJpSpTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750438643; c=relaxed/simple;
	bh=MTRrTMjk8gJcugrmcAJwb6WUoNgM0oitaPnoUyoLBzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oxGbr1c/NeVNY66Gs7li8K10AH8IoTCM1TVEY7LRruaG2F6JMKG1QvExZ9ylnAx0xY8tRwVjJAepZIP45oXaMuWmKXmL1cTklqcpuA+RzXQfPbHkjQ0a3lroBIaX/eohi4z5uJ9xl0d5o2DhB8OfKL+8y+kf9O0iiSzMZCUlN28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oAfEnH0L; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55KFRcqG024347
	for <linux-pm@vger.kernel.org>; Fri, 20 Jun 2025 16:57:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aH6iMtS8aVt02x/4hZJymbYmKZmSzX/zk1qluora9rA=; b=oAfEnH0LeNoYXcQg
	pwuWt1tSnKPkXXf4mHqj8b9TJ6Ohyu3Q5HWpqu4/l5sfVdYi8ZcqiWGhGqhWEi2X
	r6wl7sKefFcrg2/DVvRmqLKvuxJjmQryvzXjuWqE7BGa0V3nQBdlnobojfNhf17B
	dqC/FDBjSqqKq9ItL0Q4EeeOubnM9EP8vSz3DtEzWL19aXJ1WiuzsF32jaPk2Lar
	EdadcvY+jANazamAoA3jHCmKQzx2tgSOwXEZ4fVVAgVCs6gvF7SjkE9PokrO+maL
	ywHCBkRsDpWnIZ2St+vNFoslTt7DCdxAB0q4qacwtflCnpWs2DXmb0Bjb/5IBzwG
	AYtQFA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47daa4r75s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 20 Jun 2025 16:57:19 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7d0976a24ceso58528285a.2
        for <linux-pm@vger.kernel.org>; Fri, 20 Jun 2025 09:57:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750438639; x=1751043439;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aH6iMtS8aVt02x/4hZJymbYmKZmSzX/zk1qluora9rA=;
        b=xUArPQH1o8uxvjG4X+ta3e16kLgG5C+oIvAx20zOiR8+Z/oKPx1T9aTmP+bCdnub4U
         Dk1pIVEKuvu19Rshe8xB11SfkGDSns6zcAiG1rCA0VI01ui3Bi547VZhcQqRnb1rUIDu
         lNKnBht4sVOCfPxM/Am9Vkg0MbtCqagdtp8/caqAf2txaKm1+9Um6aHDoKbxy+51uvaM
         8Y5QszoCx+RJdWF9ZRt5bhqk2UhYkgFMzSJ/XYaZbOm/dcIFpcPzKwMHZBQqsjW4RIMU
         5fkQUtGkMDP+8Ot3qCmbB8q+UjwsDlMJe9ymZrKqbdkI1I9qIJyeJkbYNC30Al/aPtwy
         Ljdg==
X-Forwarded-Encrypted: i=1; AJvYcCULlA3f3bO57oT4SHN0PhniINcUQy/qu5XSp0ftOCXx/DYQ6KaFVDd5knAWV/BYN2cMiiWVcNf9Sw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRUns1/2YwpL31ef5H01yQD8nvqhRthV08rlzKuUjeop7e7gH2
	GYGqBVllE17sI3qvOkPXruZXsorVsqjgh2cRco3nt1UXbqneAFRbeglUx9M8V/T3qsuJwB0gqsx
	r37zraHr325MEoKfvCFKkMrfQQuhZ326K5F9D4ExSamGyl8dqdz9bPorll1JqPQ==
X-Gm-Gg: ASbGncs/3Xnpp7JgbAqmu3F6Pf1MboUwpTRVh7jY+LevC+TaG6f+3HV/EOzLP/l1ErL
	dKdWopGe975qK1ctespaMe7YX5uy6KGpalKLzn/FcXEyBNc5EvGVw1XLTA3zjgpkF+XQpi3frEf
	l++IjpSoYyBCdxeeZSVCEqVIQyRO/XzWg8ZkS3zT2xkvhOTBLuDPga4dhJvAe6QTW/tlV8UjvXa
	RF5/JpTOkTbz6f9by50BitLFQPTIi5fI+pvPax/Xor14MFZ9+tPPo7Vtuy86Mq+ddAWWy5XQC9O
	vil3ebIcJpjbmTECE8kN6Z6yEXeDbVEaa38JyKtPysHFus4/+sMihonf9yfv0nN5v+Y2LAm1h20
	xzys=
X-Received: by 2002:a05:620a:448a:b0:7d0:aafd:fb7a with SMTP id af79cd13be357-7d3f98d9073mr176485385a.4.1750438639106;
        Fri, 20 Jun 2025 09:57:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpK+Z1a/STaxapcURqJfzeDBgLN77XcEzNViOUOIZ1OptR6KagVRbX/aeElcpv1q7LaDkYfQ==
X-Received: by 2002:a05:620a:448a:b0:7d0:aafd:fb7a with SMTP id af79cd13be357-7d3f98d9073mr176484185a.4.1750438638761;
        Fri, 20 Jun 2025 09:57:18 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0541b7242sm186984066b.118.2025.06.20.09.57.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 09:57:11 -0700 (PDT)
Message-ID: <d045d7c2-87c0-4f4e-a853-7a3a3c5f596e@oss.qualcomm.com>
Date: Fri, 20 Jun 2025 18:57:07 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] power: supply: qcom_smbx: respect battery
 charge-term-current-microamp
To: Casey Connolly <casey.connolly@linaro.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-hardening@vger.kernel.org
References: <20250619-smb2-smb5-support-v1-0-ac5dec51b6e1@linaro.org>
 <20250619-smb2-smb5-support-v1-6-ac5dec51b6e1@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250619-smb2-smb5-support-v1-6-ac5dec51b6e1@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: L1WtxvFPrNkfUqbXWPWhHUC8DqXJqlxV
X-Proofpoint-ORIG-GUID: L1WtxvFPrNkfUqbXWPWhHUC8DqXJqlxV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDExOSBTYWx0ZWRfXx+HAV/Hnj8hL
 Kxr8oPA3mb3W/AeKAU+72ukhWlgCjuls2Os2UD2pkj1yvKx7gFTpdn9McHyuoyPk74HTNa/D1Rg
 UlYoHLbGbIpaJM8+QCXx+nnWIHQXOYkIUPPkq+EcmELoSo44qNsT+2ffTlkD6IRAve1kkGEvCx8
 Poj3bHKkfqDRvBHp/90PPqB3u8UrOkTVot5Ij8PnDHgLzZreIW3WcF9Rva986MVgZkpH/a7Mzs7
 l0pILjaAvGyfwHPxsVZ/mB8XUOl8OwY30NbGIZcAQ+yf1YCQkOX0nUHn0kZ4eAdrklEIwxHB8Mh
 qJgMvWRvONbcREfxE2t7Z7/zCxxfACUpaLaeatWwX7T8JsQfj3qv4zzKPdLKeP/T5ZUy1XrkazO
 YnfxCkCdfHwz85vtGsildu4//kgdMfquqhtXYLuyAwO6cjCm6sr+8oHMtr6/PLOUCCGL9aUL
X-Authority-Analysis: v=2.4 cv=KphN2XWN c=1 sm=1 tr=0 ts=685592ef cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=KKAkSRfTAAAA:8 a=PGWYFjC4ci8_ood58tIA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_07,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=857 mlxscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506200119

On 6/19/25 4:55 PM, Casey Connolly wrote:
> Respect the max current limit set on the battery node, one some devices
> this is set conservatively to avoid overheating since they only have a
> single charger IC (instead of two in parallel).
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---

The subject references a different, similar-sounding property

The change looks ok

Konrad

