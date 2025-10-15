Return-Path: <linux-pm+bounces-36159-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4946DBDD30C
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 09:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0D7264E8D34
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 07:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6D530F803;
	Wed, 15 Oct 2025 07:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GTGvq6sc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550012BE657
	for <linux-pm@vger.kernel.org>; Wed, 15 Oct 2025 07:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760514456; cv=none; b=cC/zIOvu2o4YNKqDpuAt551wK37lsn+StcphzXB30peV4WjURFGkcubTKetMekGQ1jBGj6ZioFdMQUSAR4jXOOueBbDVKoVVCKicmNlLqVFf5Lzyx1ZkLlLwFUgfOKGQ8/PltOfLn6PIJxMvJyrl2U9nOxTP9Dp0shIq9ixsU4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760514456; c=relaxed/simple;
	bh=JBySYm7jCnLNR7S47OJWMx5tSg66aDYRas2A7H3BfRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G2F/Pfu4Nm0aUBxc9G1AY1b4m8b3SDBopjFEVgwEo+6bOUiBCF3iZQi6TsMy5JSNQqiJVxuSv4SN/J3bUrY7F2ICHsDpQdbDtyFP2Vg0tL6aNOyPNQyk9rGU+lfmaBNm5x6fohfSuusOASgu1ZEUmQaLqJhCmCfgY32tmjCSKUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GTGvq6sc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59F2s5Na003381
	for <linux-pm@vger.kernel.org>; Wed, 15 Oct 2025 07:47:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3wzEuS4KgwUf/si4HCRP4Xjfg9FTP53VK8rld0Pt2hw=; b=GTGvq6sc6JxH0BRj
	ATrPrb5KfpdAAosrchw3H6kaMELoxGWp3yqbmmH/y8D0AjUvLOxzprSudsU1bZ+Q
	TxBCCCTKBjaI+EbGlJyNHNMwPGIDwH5Yq/0K58KY45PtKXZtRE0EtZUy/BiR9bdB
	7RfKDLwEGUEoLtyTJztloXRJp5obqdVQWiYMSUyr4qsnc+iyh27XpAyRk+n6bbBf
	i99KG671HDGIGK8V9oiQ+AFQo2ieOzwDQVXf+HCFcS/uAtIJR/bLuJCyUVulwGCF
	iWatMZCyif/690rRFP6oj6A8romXj3CPAjlRaWDSVFR1BzUDFyvbObTo1uhbBSub
	m8pakw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49sua8j4s2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 15 Oct 2025 07:47:34 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-27ee41e062cso141978975ad.1
        for <linux-pm@vger.kernel.org>; Wed, 15 Oct 2025 00:47:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760514453; x=1761119253;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3wzEuS4KgwUf/si4HCRP4Xjfg9FTP53VK8rld0Pt2hw=;
        b=NVIWz0RDKQS7JHyz6Lz/OhLFa9P4G1PhrRCAH77j7R5DF37VawVjMP2xEdOXL3IKbu
         DfPLl16OdOJpCyRJyWvi9Qy1R6+zGNL4RN1nYe1CsRg/4SwCAaiFj3HyyHWPhcEixlaa
         IB3kl1Bp3qTWJHOH2LyLD+SoazOtT+CtFDFek3fJ4GxoyPTOmL530o4fnUWdF3YweSAR
         MNay+wMIsJgbtbxXoqAzjJ+NwUIr6zqrRufZ6bfMP80zeD440COS1d1t30W3iD+k9O+e
         5/2mHzyMMFUyaJDQuhG+WXGpqD3I8hrcGSRbKzPQfUcXKvQbK5/BMp5LQcQiOXfqbKL5
         7WrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeYhxEgQ34wjEMctZ4pLJOuOK0ho83RSdvvSoPpcuhkRo2EXc1ZS472+OAv3UV9vdsLcFjN8D6jg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8oBWZWhMNZ7gPtgDygEuzwJWh2Ib9PNd/2YdRNF76pyh53lke
	uHF57PB23LG7JCASwc/0Vq9aJJ1HcUv5fAOKDVQ7OGaIFAtzRHoFhmxr5WA+aqZQDiWvZGk2wvt
	ptUE04ugWfi1hbqOmSc0LP5YlwCFt9OlYfThD/MkHzwiDQc2CjL91kpmV6HuBOQ==
X-Gm-Gg: ASbGncscR4cb/OH1+S+2gOe8ov8H+XZtByPm5uo0dHgyMkkv4reUD1Txpe9YhvFj5Vb
	lwGJXEYX7N2dKKp4tT4wChJuljZep2bmXvm/a2AESekc/7aZyv9WJYeSoz5Ry/5OvFBPBo01jL2
	lth+cmHyE6GsKX1yTjmYHQgT6cpWOo/+c1HWs2eQk0I9Bp6nQQNGTckjnZDs+CYgV/Hh2agksQw
	6qL+sYwW4a0gEKJF8CHPcWXUo2hz5BO5SHrKmqgKutKqmCsoB4kNyqKmEekkubFbNea6/CXhDAZ
	oBrJRtNIIvtlKmIqf6GusM+n4jMa937gFyoygovPJCbzU9B+aS+ogQmFSfVRMUwz4K+4P2YOYQ=
	=
X-Received: by 2002:a17:903:2343:b0:248:fc2d:3a21 with SMTP id d9443c01a7336-29027290194mr277067305ad.4.1760514452618;
        Wed, 15 Oct 2025 00:47:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhzyOtK2t73BdHuEH9yQdQ6LRCYOnKx0D9BJpdqWj+pdvXaadxnVohWazYDT43ZnK/Q6nPCw==
X-Received: by 2002:a17:903:2343:b0:248:fc2d:3a21 with SMTP id d9443c01a7336-29027290194mr277066685ad.4.1760514451980;
        Wed, 15 Oct 2025 00:47:31 -0700 (PDT)
Received: from [10.216.0.133] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034de658bsm187706535ad.22.2025.10.15.00.47.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 00:47:31 -0700 (PDT)
Message-ID: <1bf62073-fae9-dd49-c908-193c06cdda84@oss.qualcomm.com>
Date: Wed, 15 Oct 2025 13:17:01 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v16 07/14] firmware: psci: Implement vendor-specific
 resets as reboot-mode
Content-Language: en-US
To: Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        John Stultz <john.stultz@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik
 <andre.draszik@linaro.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Umang Chheda <umang.chheda@oss.qualcomm.com>
References: <20251015-arm-psci-system_reset2-vendor-reboots-v16-0-b98aedaa23ee@oss.qualcomm.com>
 <20251015-arm-psci-system_reset2-vendor-reboots-v16-7-b98aedaa23ee@oss.qualcomm.com>
 <3978e740-0589-4872-8f2f-1162084d3818@quicinc.com>
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <3978e740-0589-4872-8f2f-1162084d3818@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: DrtGPmYrw0GMe2aqIzkWaYdUMPekkox5
X-Authority-Analysis: v=2.4 cv=e5MLiKp/ c=1 sm=1 tr=0 ts=68ef5196 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=R8NOTgI61i89tWg-cvsA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE0MDEzNCBTYWx0ZWRfX56CVNgog4im1
 StsW6pd53D66Ql7xtiXom0U2zAxCny9NJe70LElttet1XhgLEk7VKGoslXdFN9o/A8DATV7Eblv
 Ex2nOkMHl0/nIAh74NMAvMgyV6sKKmDRvW9Q7jCgVDcTvpqmx1AsO4NvaEMWtga4wPlAiFlzF0R
 MdosXGtrJgHKumuWWeer/fHy5MRaNDrNzADfc9IenDmgIEiUVSE83VDPikhG0Svyeko0/B/nxSP
 e3GTqoL9p1DnecBXyDsuSc0HMUwy0Czlv8+JLJL+1yjjIQ9JN7tNwJdYn+poJCBXDHuDWzmgMVl
 fUvzNvtZVRrTwsaZdHBCd866qGr7JNumhsQSu9IwE9xjdN6ZsBGdbiK55FpOkUpH0VXTEO8BANT
 atJq8Vb7m2QPFxYZHvwB+YsXdBfElw==
X-Proofpoint-ORIG-GUID: DrtGPmYrw0GMe2aqIzkWaYdUMPekkox5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510140134



On 10/15/2025 12:25 PM, Pavan Kondeti wrote:
> On Wed, Oct 15, 2025 at 10:08:22AM +0530, Shivendra Pratap wrote:
>> +static int __init psci_init_vendor_reset(void)
>> +{
>> +	struct reboot_mode_driver *reboot;
>> +	struct device_node *psci_np;
>> +	struct device_node *np;
>> +	int ret;
>> +
>> +	if (!psci_system_reset2_supported)
>> +		return -EINVAL;
>> +
>> +	psci_np = of_find_compatible_node(NULL, NULL, "arm,psci-1.0");
>> +	if (!psci_np)
>> +		return -ENODEV;
>> +
>> +	np = of_find_node_by_name(psci_np, "reboot-mode");
>> +	if (!np) {
>> +		of_node_put(psci_np);
>> +		return -ENODEV;
>> +	}
>> +
>> +	ret = atomic_notifier_chain_register(&panic_notifier_list, &psci_panic_block);
>> +	if (ret)
>> +		goto err_notifier;
>> +
>> +	reboot = kzalloc(sizeof(*reboot), GFP_KERNEL);
>> +	if (!reboot) {
>> +		ret = -ENOMEM;
>> +		goto err_kzalloc;
>> +	}
>> +
>> +	reboot->write = psci_set_vendor_sys_reset2;
>> +	reboot->driver_name = "psci";
>> +
>> +	ret = reboot_mode_register(reboot, of_fwnode_handle(np));
>> +	if (ret)
>> +		goto err_register;
>> +
> 
> minor nit: np and psci_np reference must be dropped since we are done
> using it.

Ack. Sure. thanks. Will update this.

thanks,
Shivendra

