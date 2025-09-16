Return-Path: <linux-pm+bounces-34702-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD69B58BD6
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 04:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88DF12A8268
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 02:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A6922AE7F;
	Tue, 16 Sep 2025 02:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mm+qlQXJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E0F136988
	for <linux-pm@vger.kernel.org>; Tue, 16 Sep 2025 02:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757989918; cv=none; b=QjmJbesFi9PPoVGxV3FSZPyzkVSZcHEX7BbgydhjPLA896dYNGJjNjevy8KfxElflWTHV3gGq6fzeCWzpRmwVK9dJnAlEg6aoVwWMmp+gNuYOGRpGnX+JWkhZfxOQ4MsPCYrILBctT8qmY6b6x2VPyN6o7c79vhHZs5cZAQKryQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757989918; c=relaxed/simple;
	bh=4++fnWEvY6eDmK6WVvP64PvrKxXbk3rdz0KqSZeY+4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e2bKedvuAgDoiqYJY0mwhgxI17CPDPG3ETyk4sn7Lrl841AjDSmYIaex46GoIyTk2tdb1dNAOjWyJE1ai/cDDiArcAIIuF6UiBUdjqn6ZASvcpVAsutNLlnzuDVn3W27FLvRQ5I8khxTsQtH8CMtsVX/t6BSQavppByd3WVtnEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Mm+qlQXJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G1nJPJ002175
	for <linux-pm@vger.kernel.org>; Tue, 16 Sep 2025 02:31:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Mj+4DIC4FtIPwgZ5/qVKO3t6wbGyHNH2P4AZrpJL7T0=; b=Mm+qlQXJl1VaizLr
	wSM0NdoKUrX6uPom3OBAi5adxVMBKqwqOqWW6ejrrRgoBdHLE5qlPMrvT6e+VKnE
	ZVkdzOQkdbZ5nvPpPJmDi4PUiv101evyY3XIgp7oA396dY6qViMTG38F38VWGI6g
	d62E0DFa+jvvbKEFo7FD68eUVRhUjI9r26dp5bfCL+H7ebgsmuoN0aWZk65L50kk
	LrewTHg7dWq2+2QzcbJWXSErOgD0uo6HnTm93GK4kGvZYtXO0d5QXbX+neylzeSc
	bZ3P+I6xwpR7nuJ16ZrbK0PQPtTSPb/PaS8JErGkYaGg0h1e7esJgbPL8IPqYdld
	nuynBQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 496da9bd3d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 16 Sep 2025 02:31:55 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-76e2ea9366aso4638376b3a.2
        for <linux-pm@vger.kernel.org>; Mon, 15 Sep 2025 19:31:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757989914; x=1758594714;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mj+4DIC4FtIPwgZ5/qVKO3t6wbGyHNH2P4AZrpJL7T0=;
        b=W2vZlwdex3anYMQpZ4/dRoV4Z+0ms5aJ/tCh9vEQ03QroRN7m8Fshg7/OAubPOU0jd
         fHIOC7+pAdS/KkJoY38EBlzBhSps+lk81Rc68la+wdgKhCoHSR5kdAV/ZzOvASvhKO+h
         mlOpVi2N6cEC5Fj1DXKTrqi/qLwUZT1DEW11HvpwQd4SiwWuKGUNKzOKqSelYqk0Y9fB
         xp8PaVRLRzSvuHlNgGwzB33WFastAL8myX2TOg7of/GWzyCSEZdv9zNmDDrbsvz6pYw2
         A0+00YnHDTGEMl2AVCwbsGM/qoj5OoymzinwkXONo+m/ykxUoKnID/FH0EslsrmC51KX
         +SFA==
X-Forwarded-Encrypted: i=1; AJvYcCUvvTMrQ6+HeuLw4DyFRPmSQpXSD9N9JIm5RrkvmLRAKKJ7wd1U27xwPOklkpm9W82AnocMZs+lxA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx41IEwmMRIU5xWHxx67M6lrOFzcYUtJ4QBiDtjobMoYm39qlt+
	I2XD5aNxehy7aG8lsLQM3Q5+xDFTR+aAiFk6ZdCXTQKHUrs9IrPaosdKp2BZuVUaR6XuRGYWnFc
	oXPYaeKK3xM85yKhLJQF8/bJ4eELRfJGCCbOYRBsv0SeR/dwDuG+MwI78S/b+eQ==
X-Gm-Gg: ASbGncuVNmzrSaIFW+tiqbXtzNh9YbY0cOBLXoSnVlQLwdrBfFh5JqNPK3HUCq4c4gX
	cp8ZidtPm7y46nLbFvIW6HagRKZo7N0zNWmd7lt+S03EKIRhlfYOUIuIaJzoJED1WbtdIeApvMi
	EEyx+4kDHivdn4gH4537S8xWJnmayF9xnKC2oUp+CTM8kJIBnz18MpmDlYga1IUYuzxvjGuLlY9
	GpCy8jV2vYog9+bbQGIgu/NQMy/eaT+1orfqrAHW9f3hyVzqK0lopkxpq8cV58LS4fQqCCyjNpz
	kKaSgzYncGWgXlr8JH3Bpr8n5OyK1bGnD4DhIy+g3XJxFYMFOIeCSY6NxtKoWK8efcy2LvQz9XQ
	AopGBMmI9F1VvjQzmnD+awR7pfjyogAspaQ==
X-Received: by 2002:a05:6a21:6d98:b0:24d:301a:79b1 with SMTP id adf61e73a8af0-2602aa89c92mr19480585637.15.1757989914142;
        Mon, 15 Sep 2025 19:31:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGobrdOnAQJkdYAoa+zOeKuaa8r9jXR9CcquiRwbwPK5Q7sG5dUgcn7ckySyY/fCdIk4y0zFw==
X-Received: by 2002:a05:6a21:6d98:b0:24d:301a:79b1 with SMTP id adf61e73a8af0-2602aa89c92mr19480549637.15.1757989913655;
        Mon, 15 Sep 2025 19:31:53 -0700 (PDT)
Received: from [10.133.33.240] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a35b877bsm13162406a12.3.2025.09.15.19.31.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 19:31:53 -0700 (PDT)
Message-ID: <0cf4b0fd-e468-4aab-9ec2-38da93435557@oss.qualcomm.com>
Date: Tue, 16 Sep 2025 10:31:45 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/8] power: supply: qcom_battmgr: Add resistance power
 supply property
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Sebastian Reichel <sre@kernel.org>,
        Bjorn Andersson
 <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        David Collins <david.collins@oss.qualcomm.com>,
        =?UTF-8?Q?Gy=C3=B6rgy_Kurucz?= <me@kuruczgy.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, kernel@oss.qualcomm.com,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
References: <20250915-qcom_battmgr_update-v4-0-6f6464a41afe@oss.qualcomm.com>
 <20250915-qcom_battmgr_update-v4-3-6f6464a41afe@oss.qualcomm.com>
 <gk2ho7ugp35kb4x65meqsm3aufnry6srr4p7jspf6xyn7ywzkh@vd5ca7txjdk6>
Content-Language: en-US
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
In-Reply-To: <gk2ho7ugp35kb4x65meqsm3aufnry6srr4p7jspf6xyn7ywzkh@vd5ca7txjdk6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=M+5NKzws c=1 sm=1 tr=0 ts=68c8cc1b cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=Hj7Mza36WnbFS9u3f7kA:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: IqO3LCX6uubOU4gst71EGBkv65yL5hSL
X-Proofpoint-ORIG-GUID: IqO3LCX6uubOU4gst71EGBkv65yL5hSL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDA1NiBTYWx0ZWRfX7k4IUecgda9N
 XE6UtOy7ii8z84HiQSrr8NR0kOzOu8iuBAhB//t4qTcvX1mTVgipHZ88fDeX6GIlu9bxMmz5YKA
 bynUeBRMmeNdbnD3bRpfWRJFqrn623Qon2KZHyHq6CAzk9wXTdsAfZaytH/wqMninbuVc6KIWYL
 YAVInS9Zr5I2HlD4DlxJEB1QBIyJDL5GTFbuSN8dY4NAPKOhuZKx7MDdz978Hkzpi1P1qAGPeVT
 iAlQ5bRuKMR2bdrymePbIq+GzqChNuzVDThp+Dy7euJ+7JjlfEDl3F8n48GVQgTsowl+dnm2AXF
 LlutjWT+OY5Mh4UDnR1uEhLK3mHZgoAqJccbReboAAlFb9zYhFqxQKv5fpX2ibgzGsSIm1QCDB7
 KXdaE6SV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_01,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509150056


On 9/15/2025 6:18 PM, Dmitry Baryshkov wrote:
> On Mon, Sep 15, 2025 at 04:49:55PM +0800, Fenglin Wu via B4 Relay wrote:
>> From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
>>
>> Add power supply property to get battery internal resistance from
>> the battery management firmware.
>>
>> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on Thinkpad T14S OLED
> T14S is X1E80100, which uses SC8280XP-specific sets of properties. This
> patch changes only SM8350-related data. How was it tested?

I assumed that Neil has picked the series of the changes and tested the 
charge control limit functionality on his T14S device.

When I run "b4 trailers -u", the tag was added on all patches. I will 
remove the "Tested-by" trailer for the patches with functionality not 
applicable for X1E80100 platform.


