Return-Path: <linux-pm+bounces-34896-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D91EFB80FF4
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 18:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B75CB7B3106
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 16:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0AE28E5F3;
	Wed, 17 Sep 2025 16:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZiHXr1VS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EC434BA5C
	for <linux-pm@vger.kernel.org>; Wed, 17 Sep 2025 16:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758126599; cv=none; b=l/0+EcKVM219t5aDKQXWRWN2B1qMrmyql03Ur+TD2Aa7fW+o8yzo6nPc3e9h6bnVgbuHDIqewQDLDzJj7+brwe4JdxqU1ZdJXShX3MoWfMbVIpUAEjbmRZlfYZ/9EMSrQaqwclTgrQ88MWdGkl85vYGg5Kdmpp1hpa/nrPhSWJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758126599; c=relaxed/simple;
	bh=j/kIpr44aITpYwfRH5MGrbeYBzQDUseVMB6E+aFtzw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=htzI4ThQtkTvN4fcQgcyacytpCbWoDdTVVhEv2/O6AtivQU199CGasW0OaKJwl6pK1IjDiLIjlYHNEsJDz4ha5ay6xLXKuLmetqHEHhZH1rOhNZytLYHw1WUPZGtyG1+pd1LxaEOqm6fzLN1UzBP9IDyafQIV7WjvgYkjajTb6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZiHXr1VS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58H8XfUg029750
	for <linux-pm@vger.kernel.org>; Wed, 17 Sep 2025 16:29:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aPbliOpcCjIzayrMLkNw1FIe5VlXIVH9kvQijQYZm20=; b=ZiHXr1VSwLPkG2/M
	uN4aJnP3sUlNJHPGAh3ELOm4kQ4P2lX+AdVXRyMYk27T7PcAAhrVYwvHjtwZjgHF
	uhuOh6Vaga2zVy0qbAVoknjr2A8srxFLICJWEY8Az8eL8D26lVz1ipfyB/knPy+c
	Da0bx9l7qK2KqhohTPupv/taCjPhHh+M1NatXt3JMlxX+kA5Jm3XcYilL/PrlDlP
	9BYLM72CjrJBhFMpW4UwRBQNImIzZL4c+7a75wZVGjDypcZu0PitzLFjaTDDo8p/
	hxNDhMB4Xd2wobqCu7aH/QKoK07FdCpEX5kIu1EemxR72AIlYDL0IDdA+8s9lCkr
	CVrLBA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fy0u4bd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 17 Sep 2025 16:29:55 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-77cb7607cfcso69581b3a.0
        for <linux-pm@vger.kernel.org>; Wed, 17 Sep 2025 09:29:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758126595; x=1758731395;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aPbliOpcCjIzayrMLkNw1FIe5VlXIVH9kvQijQYZm20=;
        b=RMV8IUN7HxDlTZdQOAUHra2TMm8zFIMTMlhoUddxttkRBIKuGqZ4Op55hRKmf5tTMJ
         Lfp3o/ReN9KbjZoHSfXLvZCC8OiKXoLK+59bzLjsq8i+U/839zloqyMc4JW3NeBjUS7n
         EOywaI3/ILmjeVErxRfkVJI80koUtSJbMwyOoNLAFxVrCINigVK1pR12exmvUxuaES6R
         T3QWWBX/GvxVIg8M6CthT57w+MehrPlimhG2Qnvf1QXaqXbCOfTqayZ6WXvqrMEXMAyP
         AKELM76N//cBSvaDlneuVm+y7ir3HH6uwy9MsXkEejWi6b5sXSXgvhPUeDRot3GZYqH3
         3/PA==
X-Forwarded-Encrypted: i=1; AJvYcCWslcqrtuE9IBWPdGUCpMlDTYbKoTnG5NPkOfhk8RB3yz+vY95KoJqgYlVSdvt3Nq4lk6fQUbkWmw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpRU871PtnfRkYMBiy/o8cy9DbtbzWyc/3rA94UH0N7RPuZGpw
	170yCcjN/tCdd9N83+F+fp2j9QkZBv3VZR0mjQNNPVCgQP2SEE2IzM2PJY+myBtz5g9hkK/u8H7
	2vEg18q+a4BB7MkNVrFau3v3vR5+omelO4lBrr/07D6zJ+ShiJZQg0/K2lQeT3Q==
X-Gm-Gg: ASbGncuB1B3iP8K9khvIBOi/ONmZal78rlvf6ecHddCVFl6dT7wJ1k9ILq5u4mG8wYx
	hco6EUIoozPgE+iWOvUcaeJr11qekP/2AYg1Y/f++IxRP9L8kqeLHRYzGgWajUBaNxtOX9GSa7i
	ebFuFZU6LnJ6+N+bZsMlZuSZ3lhzHFFehNdXSI5K8LGgcyXIX/qDT77NW63gbPpqSMkDBN5emo2
	HOUzUyR1HjGn60wAf4XHQtwIhTvzwPKsdMR5RXiXsm6mZ7KhIxScBx2hax3wrAmlf3rxiBPT9Fm
	OsyyM0RoJbQIREuydTKn0dMYqGtt92uBoF4aJBweeSHigdGnO/froytrA7pMfOc=
X-Received: by 2002:a05:6a00:8d0:b0:776:1f45:904f with SMTP id d2e1a72fcca58-77bf9268104mr3162361b3a.28.1758126594840;
        Wed, 17 Sep 2025 09:29:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSAETCbSP3vIIE9VWiyL8Alz3IwaM2MYDhGvePBLrTzg5i1/2OcH9B9+r9HC87lkyc+hFW4Q==
X-Received: by 2002:a05:6a00:8d0:b0:776:1f45:904f with SMTP id d2e1a72fcca58-77bf9268104mr3162319b3a.28.1758126594363;
        Wed, 17 Sep 2025 09:29:54 -0700 (PDT)
Received: from [10.216.34.136] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607b3603asm18872680b3a.84.2025.09.17.09.29.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 09:29:54 -0700 (PDT)
Message-ID: <3c56cd00-770f-019a-d93b-5ebaa6b9374d@oss.qualcomm.com>
Date: Wed, 17 Sep 2025 21:59:44 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v14 02/10] power: reset: reboot-mode: Add device tree
 node-based registration
Content-Language: en-US
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
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
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik
 <andre.draszik@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srini@kernel.org>
References: <20250815-arm-psci-system_reset2-vendor-reboots-v14-0-37d29f59ac9a@oss.qualcomm.com>
 <20250815-arm-psci-system_reset2-vendor-reboots-v14-2-37d29f59ac9a@oss.qualcomm.com>
 <in6bqvemnscvuxbumpxogxiiav7odmsc3iazktifninh6iqen7@qwhrhdidcx7y>
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <in6bqvemnscvuxbumpxogxiiav7odmsc3iazktifninh6iqen7@qwhrhdidcx7y>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: b6jc1VW2RIEfR0QdQUF9PZiZbNI3bkoY
X-Authority-Analysis: v=2.4 cv=btZMBFai c=1 sm=1 tr=0 ts=68cae203 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=6ImPWgPuv615vBLeUzsA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: b6jc1VW2RIEfR0QdQUF9PZiZbNI3bkoY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXyEV0xI+IW0gM
 IiTyT6d0U+zNJjU9WuTviZ3fr4s9aKYSqcuqgXZeTua96X4bcIaMhP+u/oeJIbFoOZPoGdjhAZm
 lq9MR5nVIcwRfOy6afhas7XRU6s1LOModJ2K73Q+/t/WurZvwxE3plkjaKjmknKXPzsnI5v50Yp
 xVrOfzLjdEmSrs0wzhyQvTVlzKsCef1nl+15i2at1ucuo/ShyHGtYIvBkMwIuEnqDhRnrPIufJr
 OsrSC8bP8EG0LSxyveuyP3CsaWr9Rxim6PvVLMTudIejqhHqzeSOjZLGXSPKczAiwtRGglvSfu/
 yXKYY7qtAs/wiuW9+ym0SzcdFcfw44Fy7FaArcg5FhwkPNcrhuHdCqfxLOqB+Yd/0lCZDxX1sAx
 8DhCVxD5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202



On 9/17/2025 12:18 AM, Sebastian Reichel wrote:
> Hi,
> 
> On Fri, Aug 15, 2025 at 08:05:07PM +0530, Shivendra Pratap wrote:
>> The reboot-mode driver does not have a strict requirement for
>> device-based registration. It primarily uses the device's of_node
>> to read mode-<cmd> properties and the device pointer for logging.
>>
>> Remove the dependency on struct device and introduce support for
>> Device Tree (DT) node-based registration. This enables drivers
>> that are not associated with a struct device to leverage the
>> reboot-mode framework.
>>
>> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
>> ---
> 
> Please use fwnode instead of device_node, so that the same thing
> can be used with non DT setups, if that becomes necessary. Otherwise
> LGTM.

To be more clear on this, have one question: the current unmodified
design of reboot-mode is dt based:

struct device_node *np = reboot->dev->of_node;
and then parses the node using for_each_property_of_node(np, prop).

We want to refactor reboot-mode to support non-DT setups by adding
support for fwnode-based approach (struct fwnode_handle *fwnode)?

Can you please explain a bit? Some more details would be helpful to
make the change.

thanks,
Shivendra

