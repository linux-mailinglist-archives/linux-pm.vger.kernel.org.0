Return-Path: <linux-pm+bounces-40220-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBBFCF52DD
	for <lists+linux-pm@lfdr.de>; Mon, 05 Jan 2026 19:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 794A730CF5B9
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jan 2026 18:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CED32D42A;
	Mon,  5 Jan 2026 18:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lHzxZzQ0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QrvHvDRc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA205322DC1
	for <linux-pm@vger.kernel.org>; Mon,  5 Jan 2026 18:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767636365; cv=none; b=bS9Uhf1rECiwx8Y0dhytG81fUoDIhgiXftD6MoDPTOpyCLzywUn82ADywX553VgVRy3/pxq9SfcogGxjgQOhIoBzAJVtAxCbKq4lg7S0jMHqTcVyfuiVvOdLwH1fIuX2Z5Mug/A5psO372WCE4eRJpTYAKqql3JPDPx+RGJj6pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767636365; c=relaxed/simple;
	bh=MviTLb+i+73XFtiB8m2lJ/JWKXjGQk81bE6taCgf6OM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IPnVEGHHEZqD1WrKDqGel99El8Oxm0Kd6AcWf89mqQ3XtphWaZ1dHHgGqIQzxhpC+AJeLOzFYAA5U3vT5NSsOL41BsQ5wnKGwu6iehYatUaDa3fkYm8xu6I9/LyaxKt7VqQSUEiaVfAsxein08qur4lyB2yDX9KyrnqEGTk61bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lHzxZzQ0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QrvHvDRc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 605FKeMn1751794
	for <linux-pm@vger.kernel.org>; Mon, 5 Jan 2026 18:05:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gasKLYXS3OeS8VFFBD54LZHts/X5wHza0ieO8b1vB6M=; b=lHzxZzQ0vAU9E8wS
	wowmKycVWNYP7vj8WDtDjRXfyAZx1OaXWC0eRMqrVSFyPMG46ByiwavisOdSNBAw
	wC/PRWhiT7CBtsqyMBW9Cb0KpSvsRQLBFG2ONRjC5dXYrOGKwkh/OwluYd36cDzd
	aHxLVcoCsNQEjPvggEBnV6wtXLHNeyChn9zTwvugPrEEJocdD7tUbEO5Pu69FjZo
	Nz5O7VOGBkI+boBYPMRiCE+hWCxFHqpY+Q2EQQUuNyjgYRHmMWjjn8QajuI1+PbW
	1OdOCFKiEtY0gzQJ6xJrG/DGu5yfRxC6Z9oZEiLly6WvT3Qqh8+8GTbbRaTiJkBd
	wbj7ag==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgfv00g31-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 05 Jan 2026 18:05:56 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a07fa318fdso2570665ad.0
        for <linux-pm@vger.kernel.org>; Mon, 05 Jan 2026 10:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767636356; x=1768241156; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gasKLYXS3OeS8VFFBD54LZHts/X5wHza0ieO8b1vB6M=;
        b=QrvHvDRcRiafRhF/bEowkCeKQ163RCOm23mABXrP+DubJRDjbuTbBnNIivmyXw2+Ix
         pOhftWSg7vKdJeC7y5akcuolvZeaMx25uoZc37vcsptjHFCTBbJaei+111TB8BMjPCDD
         1kJloEtOuZW+WfXE8WsOZlj/caeXrFe59XKptUAlniF5yXk6AwIiMcXLmPODZ6xQ3W0J
         QNEbR+yOPJxn65UjqFi+3E0P8ySLczyxOaG0ewwe/OEvXIhyZYZMLUpY+Sjj3bVxbtFQ
         pXOyJPvhG9hD2oviVlVZ6H08mg+GTF4BdadSrN4QmOAHPMmRIqlOHFjjsUlbHvnDlUiv
         XnDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767636356; x=1768241156;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gasKLYXS3OeS8VFFBD54LZHts/X5wHza0ieO8b1vB6M=;
        b=XEkdSemym4vwXSZ0n3hU+Vt9Rfdk2W8PRRknjy94hqFl0EeJ+4IAPsGXRsBeoVzrdz
         nvTESPpNDjffVgzzf3RMqpCLDdk8zYxoOWdstamC3Hwx3UvTYW9U7HufXEG8GRW6hza2
         Mejwp5hi0gaNW+EwL/py0YuTCeyFxVTqT2WM1teruKqoujRQTEpGIAfQJT8hPqLFioO3
         uSlEfl2EeVG9P9xBLqN+awSqE5/mELdcRilg0PF67ZPIcItHNKTqlpdrnLRKThBV2c4z
         mj91qvp8hVpfJqyUZRTZQfCDriL+GEsIuTCjeWZ2fjVrv6mdUtMPqy/m1sN+6EymDkRt
         DDAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqQGYBnpiIH/ClDpcZQktsMXZrNUHni2Lo9hxx5mnUK6nSc79q5n+WCZrxdlSDw3o8mlsWImMHQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzuyD9n0voPej9wiYZxMKlYh1xTLwAJoXCQoBuvzcRDOjISRrxR
	PzXjms92b9IcBX3iw72BcVwPrrt7QuuTD0pjzzVrBKe/vNca++IHxeOlTLgywXgRYUUXasc9cLU
	nCxOgY2tgjgZOg+NBqVUkyfxn7eu0VGwNNE7ZA4CbUGtWLLA1UnU9dbC9YxQN0w==
X-Gm-Gg: AY/fxX6+AuOpfhA7dK8+4FfN6PoEq1G4gAI3OJ0Th6d9DnvqUcFQ1NanocKNdqmtjlC
	8zT+eVP2RJ0cSJL9krFHEUkQvqQzR/lURAgaBQK8c+Ntg9OamItSfNnwTIyGrK5YYWQoA91VOSi
	Fj65gVFpMhKHtZslJfdtmajbaQf8pIi2evQqjMc4zy0KNMkKluSsm7DUZkAdCFlcFF4fJlT21n/
	QUcEUQDujeMIjrNBBIgPw2VwtWlA1ccEtyMBfh3Wd9Nbm1dUAAc/o5igxZWOpXxENe/UITdgK5z
	4o2JKzjonO2RcwubtxNkNi8ZnXc+teH2313EEC5KWDRUmsRkt7PO0llvIKxMX9BoXXK40JcrD7L
	bOljJmTT5NG1/CYx+4eGUBdEhJE1Px0m/yRYUDlD2DXg=
X-Received: by 2002:a17:903:3bad:b0:2a0:9084:3aff with SMTP id d9443c01a7336-2a3e2d52ac5mr3899695ad.61.1767636356115;
        Mon, 05 Jan 2026 10:05:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpQZwihDfp6inPGKAPgkcClDWOhLlQc6x8Cm9jLA9KjnRbNR5X66E87i7aMn7CjRQ48I+axw==
X-Received: by 2002:a17:903:3bad:b0:2a0:9084:3aff with SMTP id d9443c01a7336-2a3e2d52ac5mr3899525ad.61.1767636355569;
        Mon, 05 Jan 2026 10:05:55 -0800 (PST)
Received: from [10.216.40.68] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e2b809c3sm3905895ad.81.2026.01.05.10.05.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jan 2026 10:05:55 -0800 (PST)
Message-ID: <87f25d02-2805-9da7-0d7f-05ce8a022d25@oss.qualcomm.com>
Date: Mon, 5 Jan 2026 23:35:24 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v19 06/10] power: reset: Add psci-reboot-mode driver
Content-Language: en-US
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Yan
 <andy.yan@rock-chips.com>,
        John Stultz <john.stultz@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Srinivas Kandagatla <srini@kernel.org>
References: <20251228-arm-psci-system_reset2-vendor-reboots-v19-0-ebb956053098@oss.qualcomm.com>
 <20251228-arm-psci-system_reset2-vendor-reboots-v19-6-ebb956053098@oss.qualcomm.com>
 <CAMRc=Me8WQ=aMd-NJ1yzzHzqU8fT1u4eb7as=EjSpZ+Rpv9+rg@mail.gmail.com>
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <CAMRc=Me8WQ=aMd-NJ1yzzHzqU8fT1u4eb7as=EjSpZ+Rpv9+rg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=e9YLiKp/ c=1 sm=1 tr=0 ts=695bfd84 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=XO6BmJ_ieOJQNt0V76AA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: viMqidpUJY2hU_E8zdOaMBziN9aXr5Gc
X-Proofpoint-ORIG-GUID: viMqidpUJY2hU_E8zdOaMBziN9aXr5Gc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDE1NyBTYWx0ZWRfXzhbAxgv0/LTD
 ReahNI2C/417i/EXDuLgaMIIqz84W+80CPqTFX7w4JzQr6/FNYkLeqZNGMlBYFomxspyDg9pPcK
 z8dMwfj2h1DFQwgk8UXBzj9qaA/+SDRnFqjve0yCYe8dcCXhNMNPp99AsdMullI3/+Qkm63RiLF
 Z7ZjZYreyU2+6lUyOXJFdv5Aq1MjiUaysOyaUv30HSoWc9Y8qh5rPHqgFcr1Y/zd3Rvi1607H2w
 nQEEb2c6aFkdLDCeI+JkantHTZKb2tm4UceEHoRk1518zA28ffbrVB1RK0zk9Y2MgUV2h8Ijgyy
 LzpHXXADv1jutEgWv18w5rwctsADScJ/ld9ALGuYzVv2ubN+YDIRq7wlEM+5+f86UdKrjNFbsCq
 vO6rJJkv6KiADDH3OrUmKZ2pm6BikykGlRo4Qa/j5QliCUaqgLkQoLhNLcuiVN8KlPPTJSSIVa+
 gSL6AQ+wavEfj/OKbPg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601050157



On 1/2/2026 5:27 PM, Bartosz Golaszewski wrote:
> On Sun, Dec 28, 2025 at 6:21 PM Shivendra Pratap
> <shivendra.pratap@oss.qualcomm.com> wrote:
>>
> 
> [snip]
> 
>> +
>> +static int psci_reboot_mode_probe(struct faux_device *fdev)
>> +{
>> +       struct reboot_mode_driver *reboot;
>> +       struct device_node *psci_np;
>> +       struct device_node *np;
>> +       int ret;
>> +
>> +       psci_np = of_find_compatible_node(NULL, NULL, "arm,psci-1.0");
>> +       if (!psci_np)
>> +               return -ENODEV;
>> +
>> +       /*
>> +        * Find the psci:reboot-mode node.
>> +        * If NULL, continue to register predefined modes.
>> +        * np refcount to be handled by dev;
>> +        * psci_np refcount is decremented by of_find_node_by_name;
>> +        */
> 
> Can you make this comment into full sentences, I had trouble parsing
> the meaning for a minute.

Ack.

> 
>> +       np = of_find_node_by_name(psci_np, "reboot-mode");
>> +       fdev->dev.of_node = np;
> 
> The logic of the device assigning its own node is a bit sketchy,
> ideally this should be done before the device probes.

Will move it to init. thanks.

> 
>> +
>> +       reboot = devm_kzalloc(&fdev->dev, sizeof(*reboot), GFP_KERNEL);
>> +       if (!reboot)
>> +               return -ENOMEM;
>> +
>> +       psci_reboot_mode_set_predefined_modes(reboot);
>> +       reboot->write = psci_reboot_mode_write;
>> +       reboot->dev = &fdev->dev;
>> +
>> +       ret = devm_reboot_mode_register(&fdev->dev, reboot);
>> +       if (ret) {
>> +               dev_err(&fdev->dev, "devm_reboot_mode_register failed %d\n", ret);
>> +               return ret;
> 
> Use dev_err_probe().

Ack.

> 
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static struct faux_device_ops psci_reboot_mode_ops = {
>> +       .probe = psci_reboot_mode_probe,
>> +};
>> +
>> +static int __init psci_reboot_mode_init(void)
>> +{
>> +       struct faux_device *fdev;
>> +
>> +       fdev = faux_device_create("psci-reboot-mode", NULL, &psci_reboot_mode_ops);
>> +       if (!fdev)
>> +               return -ENODEV;
> 
> This will always create this device for everyone who includes this
> module. Move the of_find_compatible_node(NULL, NULL, "arm,psci-1.0")
> call from probe() here instead and don't create the device if it
> fails.

Ack. 
Will move both calls to init before creating the faux device. 

psci_np = of_find_compatible_node(NULL, NULL, "arm,psci-1.0");
and 
np = of_find_node_by_name(psci_np, "reboot-mode");
--

thanks,
Shivendra

