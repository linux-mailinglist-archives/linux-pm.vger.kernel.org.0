Return-Path: <linux-pm+bounces-36663-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CADB8BFD530
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 18:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5007E358AB6
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 16:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C3F2BE036;
	Wed, 22 Oct 2025 16:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JuYJQ8qD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE1729A9E9
	for <linux-pm@vger.kernel.org>; Wed, 22 Oct 2025 16:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761151070; cv=none; b=KOuOdcDHRykN96oaqpSNJX9cYzNScKB+spvIaztqQ5zTksJ7lJ3Apwz2j8dR03IZC1dQCGYzLrTQTNDbTtHruSG7jii2TNu2famFdBBk/AfvpnXSWp2ZFXXYDRJW4SwIQ4MPYI5aZvbnkl9RHidxhDh/sr3lpFytHF4HcvaC17s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761151070; c=relaxed/simple;
	bh=Wp81GXNND1wh0U/9s1mWBF/bhNhNGUm8w8X0YEP7PN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L4a61hHE2yXj85fDEwcgjmt8t9qgLpfI1QnLDlGSZf/P9S3MHiIMujGzp/UCiJtgDr8NUJ7HTUs7T1eof+I0PqJ8K4iKatiWZVObNK27bvWD6yZnIlWxY3sTx98W4zTLRhhOz6B8wLwKvAkUV74JIQtX4FhJ0pBOsJ4vqodcJgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JuYJQ8qD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MA6A60018585
	for <linux-pm@vger.kernel.org>; Wed, 22 Oct 2025 16:37:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G7pD8+/3i8mH4YAFD2vcdS7fmM7cM/hpU5EdelDxdTU=; b=JuYJQ8qD35fiYRZm
	UMIJfR+oFwFQsFqisGFDdPpfc8nvX8Wn11Ta9qiJmEfhKtMrjG/BBzkAQckpvMQN
	j67p+fSpkezld1rLvXZQz2unRg+UdSHOzkotJoCUN5HZ1g5Db8bDuhp5z+EpmZ54
	N7KCwVKZ7vgl05ciHFkt6P3O3R1OIXfTVBfCU0oeGGCkjGIhVnTewQzKYtSBPr33
	v19PYN3yciLpxIRBkSdJCJUTEUETZpQMZvKeSXOA/Se2eNVfGVMB667BHXo2FQVf
	rD4j3afLL70RBSDSCc7vLe2g+xisqJgkqjcyFrCYaRQkvMIUanJNgCAbFRcg6cD9
	J7joXg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v469nc0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 22 Oct 2025 16:37:46 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-826b30ed087so21450666d6.2
        for <linux-pm@vger.kernel.org>; Wed, 22 Oct 2025 09:37:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761151065; x=1761755865;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G7pD8+/3i8mH4YAFD2vcdS7fmM7cM/hpU5EdelDxdTU=;
        b=dFvmmzZ6VH2YZBH5WyhuB5aHPbyp7rADdt77oFSW8dv5IfKWev5KiY6OKT8TSgX6HH
         poXIgTnsUZngRgJRoENLVWNEDhNM8+SOFwJB21vbmTcD7LWmIWIJvgOrCg1CDjOCdRHA
         SvsCcxXYm/1kY12gWiwAsvd4rrNKO5dzNo+huXYFwWzQJgu4LAqxCOtRycon4fkrZjG2
         ZJoccL1IfmyL7VyQjtOk5KySaULhW3NYNadyt0IJCFaD3b2+F670HglKNaiES+HJZDbJ
         Fb56MGxr72ffIv70btvo+x+Lp3ZVgIFNzhN+NXvZJ0FGoyBc7twP3b1kyA9erNt3A5dG
         Oj8g==
X-Gm-Message-State: AOJu0YyN3v79rqIIHQ0PV94bymL8FbuTtc7pBbJAIYnmHA7pdPpiOq9y
	SdQPFD6wqinpZgYfo4VJVIenIqvSASB1Xqr5bTF/RimJQ9/agpFCRht6qrkR0N9dBlbMr/gpmxB
	Ijs5pb0VgZ5YVOU6XmXZKbxXcOO1OtOTrFo7SJcV8Cxnx2mPcITH8nEQUb/6B3A==
X-Gm-Gg: ASbGncvi3HGHgRdLgNoV1Dcm3fi2qBSnPcbHiS4dumgmRKvYSgTar+P7DP+KnoI1WFY
	k3UANxwKeWnxvSSRJ7QfcsB+NfWvifNLND7jNB13k6NGN4ESlYyENNQwyxCgF+0NIa+cXHBoFaT
	ZEP5gR9Ocy0LEbt/pTEUBD7jgWBAD3daJTfH38FRO4wBSoYs4ZuzH2nX6t51tniOGpWq0FSnjOS
	RKWuLdGxZD00GOZGWaSkeAXO0x/Mz0Cz1IKMLUwGURfUrgKUzJ4tbzDAnbspzbU042vqoGURmLR
	NVYK+M1x2lO22sCi1wGOYm7TB15wTFhN1q7c2GtlupHOvOdqZfFM+zs7cWjCQEVM2R2noGcdWlp
	qUsjRshrXd4KJ4LuoJsm79hRpju4IJYRvIFJsL0HM2Dqcz0fAUUAXJ5VF
X-Received: by 2002:a05:6214:f04:b0:789:e48a:fc05 with SMTP id 6a1803df08f44-87de71558bcmr59531166d6.6.1761151065498;
        Wed, 22 Oct 2025 09:37:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERyQqnqCN17TiFnnIPLzVxcq0nEWVQWZk7kbvp4BBdWHyCyaz+jWM4LC9xAGgeQALkVVWWcw==
X-Received: by 2002:a05:6214:f04:b0:789:e48a:fc05 with SMTP id 6a1803df08f44-87de71558bcmr59530626d6.6.1761151064778;
        Wed, 22 Oct 2025 09:37:44 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c48ab560esm12216643a12.12.2025.10.22.09.37.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 09:37:44 -0700 (PDT)
Message-ID: <f0f1219b-672e-4793-8501-ea31e7cc9575@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 18:37:41 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] PCI: qcom: Use frequency and level based OPP
 lookup
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20251013-opp_pcie-v5-0-eb64db2b4bd3@oss.qualcomm.com>
 <20251013-opp_pcie-v5-5-eb64db2b4bd3@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251013-opp_pcie-v5-5-eb64db2b4bd3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Fd9NuYmsIIr5RzHCcN3gaytJrhY8efV2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAzMiBTYWx0ZWRfX86l2Yz7fjubL
 Wcn8WYmSs2eRNKrHupYnmZVTVTjo8J5gqzclzf60o/mbGP6VWRESHPhVW61a/yhaArht/dt1UCM
 GdYMjUvgdUQ2ZtLC0rUSHN03TnezOCjdFAnac16Gcy1rnFRz3VnDMyHb/ALYCFf4Soc4vISwJyA
 RKspUD6+GQdLFqJUEuMismsJLFwS6f/kDOrmrxKJlv4gnRcyhAAQl8jPhhdh7nZs+gFW+RDMPu+
 XsZBObkWsYGgbIUieVJrv3BTbAJrKV1FoigsZOsS99X1BNbO/TqTeQTqhWVgVC99LfRu6RUPQ0s
 k4tiwEUtwZR36F2IT1mfFPdMjJ04c2MnHVUwGmfX9cQVAYxXA1LinhrxkDATxefGyTJPaErzxY2
 /qPAL3ZSshiBMj3E2pEIXnKvcMPWjA==
X-Authority-Analysis: v=2.4 cv=U8qfzOru c=1 sm=1 tr=0 ts=68f9085a cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=M-jGJTmE-ygQmRKCDXMA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: Fd9NuYmsIIr5RzHCcN3gaytJrhY8efV2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_07,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180032

On 10/13/25 12:53 PM, Krishna Chaitanya Chundru wrote:
> PCIe link configurations such as 8GT/s x2 and 16GT/s x1 may operate at
> the same frequency but differ in other characteristics like RPMh votes.
> The existing OPP selection based solely on frequency cannot distinguish
> between such cases.
> 
> In such cases, frequency alone is insufficient to identify the correct OPP.
> Use the newly introduced dev_pm_opp_find_key_exact() API to match both
> frequency and level when selecting an OPP, here level indicates PCIe
> data rate.
> 
> To support older device tree's where opp-level is not defined, check if
> opp-level is present or not using dev_pm_opp_find_level_exact(). if
> not present fallback to frequency only match.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 805edbbfe7eba496bc99ca82051dee43d240f359..03b3a1d3a40359a0c70704873b72539ffa43e722 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1565,6 +1565,7 @@ static void qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)
>  {
>  	u32 offset, status, width, speed;
>  	struct dw_pcie *pci = pcie->pci;
> +	struct dev_pm_opp_key key;

You need to zero-initialize this, or it'll explode the second
struct dev_pm_opp_key {} grows

Konrad


