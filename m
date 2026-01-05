Return-Path: <linux-pm+bounces-40229-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 65727CF5AC9
	for <lists+linux-pm@lfdr.de>; Mon, 05 Jan 2026 22:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 642253025720
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jan 2026 21:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAF12BEFF6;
	Mon,  5 Jan 2026 21:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lFUJ1iqt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Gm2eIds6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280842737E3
	for <linux-pm@vger.kernel.org>; Mon,  5 Jan 2026 21:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767648691; cv=none; b=F+wMQAj//FsewJ18RkEyDNX+MZqKLh6SzYtM7wcjSQMnan/0rd71uhOYXq2XWk6LzSuKY1nE3Jk21SLwFXwFbH4XXtm1fgop1STpXSPmheFf7TEqzhWFqDNtkVUCL7ma+DLUV5lrfECc8Rwvnl4zlE9G1AsgGdJGmY/sQmH9WGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767648691; c=relaxed/simple;
	bh=utkjV6+Kk2zjUaBHcQnXOzor5MiIt6uMzcWnSOF2MDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aEZ1WLSTSMjZMdCW/ERCkFkNZJ86ciHATAXaMo59TUFWXgVyNN5cXxUUkh8WeJl0xfrQIpTlRAHm1JKeOxzmugxjpPSbIf7F7a48Ql0gi8EERORsFbtWajEic7skmc+Tiit4sz6mrVce+4cEdlMpKJv0G1vJ/bEtsPSm0Erw+zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lFUJ1iqt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Gm2eIds6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 605GK23w3337608
	for <linux-pm@vger.kernel.org>; Mon, 5 Jan 2026 21:31:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4zu5KsSSAYr8IXy49RPMoofLX2Z45PWdd94vhBIDqqE=; b=lFUJ1iqt2RX7MJd9
	d/lofAm3V64RkHAtaYCanL5/o5QFTL5LQfLkcDzgDFaIQ+VS1q1PeQ9eoxYwV9/i
	dt926QH7MxKqiz6IQL2yDVa5OqvgaSHhN8HpiJQNw2OEAxMX4jXBOeYXvqKENBSj
	RfbrJW8bZPNGVrUzpaxFKZ5XSGxykDtw5tQBbeOq/jCxwZqRJ96MZwJsqguHw6Er
	Y6nR6nEThARXFInszk08xj2RsXAY1B+TtzxoGeXdJZUAe2ggBq13paSpVQOSFbql
	ET1gnVfGF/nY8cXCxUWdgfRdTKD8ZbN5NN5PuxJpSIyjD4U8c2nhU0ovkHRxLQbZ
	pXmM8A==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bggqu0v1x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 05 Jan 2026 21:31:29 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-9413e6717f0so571043241.1
        for <linux-pm@vger.kernel.org>; Mon, 05 Jan 2026 13:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767648688; x=1768253488; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4zu5KsSSAYr8IXy49RPMoofLX2Z45PWdd94vhBIDqqE=;
        b=Gm2eIds6ldMZ7YTUQmX1/536yRRLw3vD6QnPC0+hDv1JwngNZDjtkJ2vc04lIit2CM
         ZlOWgtrOGmPGEHDIMrs4DT4IGwhAwc76o1yW5l4Cz35V62hEbM9dpyu/d8EZHRo5jPjk
         T0vm9ZbZsCq3GPbvNKPOOqR6XbUsDkH9vISQwlFX1wGg5o0YMoZX6Ue+DKyA/eGHPNE7
         hyKT7pyjhazBc8jRSo8NOEo5koknZScw/7AVd3tcmhiDNy9MJYF61lA1wXz8mN3ZAMgS
         YO4bR2S0L5vF0gC6Uhsa0Swtz/S2MZGNZ/iU8gDzbM39L8ZMFyqmReS6rGc/QPlZgurs
         DfYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767648688; x=1768253488;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4zu5KsSSAYr8IXy49RPMoofLX2Z45PWdd94vhBIDqqE=;
        b=q0ml0q0oPXa5mOP3FLdVse/npFKK00+yq+XDRcK51+DmKntqpr/IVVap+QLoOEc3F2
         fgFnvIwXKP7ky0uZfkWZaHOe3Ji8AvJCUDpyYVdc8b3gtZifkmcmyjOIASCkgxirGdHE
         06ln5vrYzHKxEvBRFoImzkbu3XxPvzPiBWEXMRLCJPZISNvZ+wiAZLcCzvpzNSdrwe/2
         YvsZ9Syry5A18KNZYMU+yOuxgWwSiu3wl/66H6t23b5ebJil6IDQGTMC9yIW8/h0Tnrh
         qnZNb7Qw1lZyRZ7imXSuNOAx3yjbe3/p9p3M1UbbazupVoHuZtzqxVfJyFzzHmnMrtUa
         3Y/g==
X-Forwarded-Encrypted: i=1; AJvYcCXYsOVNkbSJ3Wf1GblBG3JpWQOjuVb+yR9P9K88z3QElC83mHkRTzkQLcVYxcCe9lWGh6Z3+d+93Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv9N1CrSbzMVpIH//HOHimEvRRMddd3lzM7RBR4JHgGz4pq/Fr
	kQ4orux1baXZCdcfKqkNUUJF7lRws2GO+VqBg+UWaHNiMJKy5lLAeGiextgaGshH0GBuW5lXKUa
	X38tcl1okXjp0bG8epzkqRcWrf03XMhqKkMo5kHEa1wIfm6lr1Vh7ohN1HIjOEg==
X-Gm-Gg: AY/fxX4tTSmcU6gLuYglfNqc+f5F6pWk1OM+SDNOcMpSqZBlCeFKNN1Ls2gdujXtgPd
	2kuBNuUPB9b8d+FdbaYGrPxPg1uaSFDY3rxL1QhxRWH03Rwvw7l49kbsycwiT+jLX7nPdXg/9fA
	ltKmbB95ihGbVj5CZXK2QhUqxgVVlorASYOz6otkT1Q7x85Q8P0zsgXz78DuDw7g08OLpR1iWsU
	XHSF+xZ5EA4ndqzft8TgP1ofUSXOodNOqE0YxEYW+yWRApXQTbu6NKAPpyF+4c50rlRwMWzg5kV
	r/8kjapL2cwVJSiTUJS7tvT/3Mjy4Yo5fK1+/t+O1XBm839xYrOpNW7ns2IkPXWLLT3HlPwwdS7
	q5aj2fvqKDbYT9YD4qSRNrwYQwu5oAHRdI2luAXZdjJlTnbkrqGnvK95dZzJNdGYl8ne6YyN0rH
	6kGP5f1b2ZxaFrF475Sji8r/U=
X-Received: by 2002:a05:6102:2912:b0:5db:e851:938e with SMTP id ada2fe7eead31-5ec74318ab0mr280761137.10.1767648688150;
        Mon, 05 Jan 2026 13:31:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHN6D3L01UfV6GWimrbBRPwGxz03pI11NWXb7fzsx236R9fU8MdRrZ4c01w5FGgeM95dAMb7w==
X-Received: by 2002:a05:6102:2912:b0:5db:e851:938e with SMTP id ada2fe7eead31-5ec74318ab0mr280739137.10.1767648687644;
        Mon, 05 Jan 2026 13:31:27 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-382eb8ad6besm652641fa.27.2026.01.05.13.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 13:31:26 -0800 (PST)
Date: Mon, 5 Jan 2026 23:31:25 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        John Stultz <john.stultz@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Srinivas Kandagatla <srini@kernel.org>
Subject: Re: [PATCH v19 01/10] power: reset: reboot-mode: Remove devres based
 allocations
Message-ID: <cvmtn335gwnl6rvmlm4vgyablsj735rknga4ffv53gpk4k7d6g@tt7ebuyusocu>
References: <20251228-arm-psci-system_reset2-vendor-reboots-v19-0-ebb956053098@oss.qualcomm.com>
 <20251228-arm-psci-system_reset2-vendor-reboots-v19-1-ebb956053098@oss.qualcomm.com>
 <CAMRc=McEB+yVYxropzsqLExZCU5Pd_iy_=5N3pTxu28-ZX=7_w@mail.gmail.com>
 <acbb37a1-3189-4d4e-5c05-55b13cd40a7f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acbb37a1-3189-4d4e-5c05-55b13cd40a7f@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDE4NyBTYWx0ZWRfX0cjqu2OYoEI2
 AykjeqozVmQf27jxf+M2ug+lOBTT6mh+LwUE/Po8oGqjf/GGWqn1tbKAvYXxUAOg1ZQxKl0WMr4
 Cf+4p/zBm8OL5qIOO3+g8djl6dBCD3ZDUpi59p+WrLbJW5T1NxHZZXACfWelCZ3TzAWYdyoLx94
 Gw0vAhW69F0+cXe78DsIWLsLWasWDGAUVR7TvvT1pEjOME4IJk8K/JR/8j+lelrIIgDJeqTFPWO
 y2Qop9rkiUUVbaWMqiGYeK85VApji1bFRBZ4TBQWhED1VZkj+SG42fhEt6cggO28wdTyo2HRVCe
 5LhuXLG2GW6Pfo5G4wA8GpjuN8Fa81IsFDqyxc+gD4L8/6DCx4ynkDIMUdGyFGkqB1dZfHFYDGk
 Ocgzj+8lMa1EXLORaUJOeMzUL/3WEa/pphgeosH3dCvu4PDM/bH+dh6MoqVL3rQxUBbRtAKwATi
 XVQpheiPyAe2gX4YzBw==
X-Proofpoint-ORIG-GUID: hh6tThsSK_riktiY5xLKrtSuHBiDLLgp
X-Authority-Analysis: v=2.4 cv=fr/RpV4f c=1 sm=1 tr=0 ts=695c2db1 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=gjb6EQGLQTTv68HWFF4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-GUID: hh6tThsSK_riktiY5xLKrtSuHBiDLLgp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601050187

On Mon, Jan 05, 2026 at 11:46:40PM +0530, Shivendra Pratap wrote:
> 
> 
> On 1/2/2026 3:35 PM, Bartosz Golaszewski wrote:
> > On Sun, Dec 28, 2025 at 6:20 PM Shivendra Pratap
> > <shivendra.pratap@oss.qualcomm.com> wrote:
> 
> [snip]
> 
> > 
> >> +                       pr_err("reboot mode %s without magic number\n", prop->name);
> > 
> > If this is an error, shouldn't we bail out?
> > 
> >> +                       continue;
> 
> This is not an error as per original design of reboot-mode framework.
> The code as of now says, if the reboot-mode node has an entry without
> proper magic value, ignore it, and, process the next.

Then why are you using error level for the message printout?

-- 
With best wishes
Dmitry

