Return-Path: <linux-pm+bounces-29683-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2691AEBD4C
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 18:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C7833AE4C4
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 16:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A642EAB85;
	Fri, 27 Jun 2025 16:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bDXLCAQ0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8680C2E54D5
	for <linux-pm@vger.kernel.org>; Fri, 27 Jun 2025 16:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751041648; cv=none; b=M7GHTH945xYnoCacgqVEfJQXHAFUpw1xGL7sFJW7zt7iI5X5AhMEVvAvCTutlk4urjngG2GjLgWFz2fCsdyTTfym2a6XD/kgqctxVBhbtVfa+ENtv7mP3XVw9WeV7c77hscTt6rtjQdrfyqFVj0/vEhs520LoFEW1UnQmWOyvYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751041648; c=relaxed/simple;
	bh=LRgiyfrICsKTlHv9IhC5r+4XBxhCMDaKngyow+IGVj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JjCkS7VoC1B9R9k7j2bRVYRrEN51b/BLlvPyTUC3cZwbFMszqjW04qjRcYQf201x0aksi8WJiyROBfGRX1+fRsjfdKYKsO1gZjC3Kv00sWSXfk78XJ0bTRsbFZQ6nrO2FY7VqLGFN2M/+yKpHtJN+v/c7Zq/A/6hoD3Z47E1dKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bDXLCAQ0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55RC2Mht017801
	for <linux-pm@vger.kernel.org>; Fri, 27 Jun 2025 16:27:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lvYd1deVAhihvBAnBWJn94CrhAU80ERbjP9yegxtMRc=; b=bDXLCAQ0cbgCnzoi
	lm+zHp0o4lGhoQHyD9gxNOKnTFOFDsTWHkH8HmlD5/uBJW4rnl8cXb4Iiurr8HK4
	XWXZUjskbqOFfdlzu8eneXoVRrnHQ0izL8V8U8OGPVNi+/19sBQkKUkT0qngbbsz
	e6H8F3kGVCBMhN9ByxZkXMJfSy/TJnOIRDEDzWtUNA7vCW+VYrAGwBcyNr8ntvII
	HNexMP22VMPgv3qVSUFsSxkjm5C/EVvoDKtIgW4KZ/4PGBIG5DNfUa6r+J3jnP0d
	kzQsq+hYUyJaCEOlqcb7dIarRz7UZeNBOPCWu1nBFcZZieEKow8ZsZwgO1wTFWZP
	yn6sAg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47fdfx5rwx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 27 Jun 2025 16:27:25 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7d09b74dc4bso45133085a.2
        for <linux-pm@vger.kernel.org>; Fri, 27 Jun 2025 09:27:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751041644; x=1751646444;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lvYd1deVAhihvBAnBWJn94CrhAU80ERbjP9yegxtMRc=;
        b=UHgDxxbwTTSqO0JZXxUb6BMBoOvoXoZmDp2CgCKkgn2zNPSaKOQtGvdcGqeNx8/rfN
         yX58tmwl96jQj7On6HtvMaIdTc14anaaKR97oRMmtfqbEHaYRA+4oDEhGiRkE+DY68J0
         fhvAH66TdoMjNQQHXESjcKAouI/AotTRKf/sFU0BBKpzdV4BOUGtlizAdzuplqejsWLx
         /hasLUTInMgHu75GgCwE12BFag6nGK2r69HajErBG24TFydrvMZmf90sy1BT6DkD16tk
         7vIPvUHD/2TXfRrKX+i8eeGboP/UlDZins75R5gbD66TUkufZYDXBH+RuMvhBO/c2uXt
         9mpw==
X-Forwarded-Encrypted: i=1; AJvYcCXORxSKbs1pCH6wi0q1M39QRtcFDtEONL+0wH6EdWCQtb7lyb8fD0UWiifyeLvA4BqQ+QwZzeJVoQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5sGOP4a9/DXa85LdA9iSRzrUK+7C5/Dw6y3e8h+ItdgAId8fy
	Rholp9kOJrY/bNqTVOPabbxBOk7haTHb3RpC9BM8fHNiGSuaMXdrBC1j8oeyUi6iA/7l+eqf30C
	HCBIGL21akP4ZjWGoLpMdtCG6If6KPPPKoZ2k/yWCU/UH2xnaBBnXgdNJiUxL+A==
X-Gm-Gg: ASbGncuJ0gNEJJt7PMO4BPF0lq/RICZLWkvE9iaqTyTpQqcunHfNkbqBWRZR6zv8YDm
	1xbJlu0B0ErNphybDMklId4iQabAAA28UndyoZ2TWHsPxGxCLFvqs9uyuzTDwZJi8/gSUZHEhhV
	oYHTqzZDMukrCGkpV2MWQlDXep8YYPWHUIKOq/KIV37wHVcK30N3Hvw4bQIPRyjbWTBfBoxJeAx
	7fy7dl2Qs5g0NSH7hrKGO+nKgZ/0nCUhNfH5/iyY4SFc3ZFXvagEKPnt8wc8Dn6cNcYe/PpKzrI
	yN5Z6NL3qMZ6pS75vA2VPmFSFOUKzlmTDosMogY+1f1oR85Iqcz4Efu776Oy00bnPTrO3dBGGwY
	1nE0=
X-Received: by 2002:a05:620a:6011:b0:7c0:c024:d5 with SMTP id af79cd13be357-7d44393af52mr224995085a.8.1751041644597;
        Fri, 27 Jun 2025 09:27:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQx+88Ksz4ECZwUoGt+Ed4X8fsAOVBGWYUZ4j8qk+znxirQR95/4sMWkJF3ZwWKFN09XhTLg==
X-Received: by 2002:a05:620a:6011:b0:7c0:c024:d5 with SMTP id af79cd13be357-7d44393af52mr224991485a.8.1751041644137;
        Fri, 27 Jun 2025 09:27:24 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353659e12sm148855366b.40.2025.06.27.09.27.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 09:27:23 -0700 (PDT)
Message-ID: <cd6f018d-5653-47d8-abd2-a13f780eb38f@oss.qualcomm.com>
Date: Fri, 27 Jun 2025 18:27:20 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] arm64: dts: qcom: ipq5424: Add NSS clock
 controller node
To: Luo Jie <quic_luoj@quicinc.com>, Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Richard Cochran <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Anusha Rao <quic_anusha@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, quic_kkumarcs@quicinc.com,
        quic_linchen@quicinc.com, quic_leiwei@quicinc.com,
        quic_suruchia@quicinc.com, quic_pavir@quicinc.com
References: <20250627-qcom_ipq5424_nsscc-v2-0-8d392f65102a@quicinc.com>
 <20250627-qcom_ipq5424_nsscc-v2-7-8d392f65102a@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250627-qcom_ipq5424_nsscc-v2-7-8d392f65102a@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: wE_JMZtuczcJhifvSO9YuNy1qy4emV_I
X-Proofpoint-ORIG-GUID: wE_JMZtuczcJhifvSO9YuNy1qy4emV_I
X-Authority-Analysis: v=2.4 cv=MtZS63ae c=1 sm=1 tr=0 ts=685ec66d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=f6GukiY9ARMaQ3Zrt0MA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDEzMyBTYWx0ZWRfX+NwZMKCQCcuz
 ca2OX5WPXFkzaw2sPXx2ekt7sH0NJKhsrr13M7N2KnGFPd0obX40c2Kn8mIPRrNzqPgr3pkMuf0
 YKHiQwDSVWETF8sgf4Fq6Frkv/tpQ3CrkYP4SkwHrd5JGcv+yvopjNSyCb6PJA9Le+5DpEMHeXl
 M7jWQlRyYwjs+PEorInMlQehkJfs/pUQd050Dfv2DmZsJhzyeUEKu9c8ju1cEo/ocSllbMUdizT
 mB3nQXAGGR5ycHX19U8ZKG2Sl8ImTR2P5kRQ8aEdnHA2mzX0C6kopgrwNyo67g0Fq2xBIpMTN6y
 CT2dCFOUCns7a9WwgboEvTu/o1J4qFmz9AHe8CmURYT5cBi1ejXewiig4j3BewCHSQ0kcvtmzUx
 gd+dK6bWN/OBdv6mgFjaKH3X4lXZVW8/8dMK4VupxJdRqGAdvVhCbjGVWub79RHynlsXIrzH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_05,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 mlxscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506270133

On 6/27/25 2:09 PM, Luo Jie wrote:
> NSS clock controller provides the clocks and resets to the networking
> hardware blocks on the IPQ5424, such as PPE (Packet Process Engine) and
> UNIPHY (PCS) blocks.
> 
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq5424.dtsi | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq5424.dtsi b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
> index 2eea8a078595..eb4aa778269c 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5424.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
> @@ -730,6 +730,36 @@ frame@f42d000 {
>  			};
>  		};
>  
> +		clock-controller@39b00000 {
> +			compatible = "qcom,ipq5424-nsscc";
> +			reg = <0 0x39b00000 0 0x800>;

size = 0x100_000

with that:

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

