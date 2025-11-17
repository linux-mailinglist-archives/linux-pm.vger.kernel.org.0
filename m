Return-Path: <linux-pm+bounces-38106-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB48AC626CB
	for <lists+linux-pm@lfdr.de>; Mon, 17 Nov 2025 06:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75CB63A56F6
	for <lists+linux-pm@lfdr.de>; Mon, 17 Nov 2025 05:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D5D30F522;
	Mon, 17 Nov 2025 05:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oOGjgc8K";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AJjLPwv1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F532690D5
	for <linux-pm@vger.kernel.org>; Mon, 17 Nov 2025 05:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763358042; cv=none; b=e8m4FsDt6eH+FTw1AhBA1N8z/8vGn+AV7RVtvMVIzHAlvR+Li9hKI9gNG8ZO2yGBANd3vJcPxd9hTvEunKY99Yng80NvDGYDs91fGaJqSlN1SFMJ8+4Rxwr/CSu9GJCMFtIF4h23jhPzwXclwi+djCqE+reoxayA2b4p0PkYZzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763358042; c=relaxed/simple;
	bh=5CgktAeVU5b5o5Gv7ZUcWMPYpmWApRwqLma2om/YaYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B32TyM1XFZX8dxhcH5Hl3fi/dFVCUct0g9ARV2PB1zbXP76wWkeh8w4d9FZfGxJZdC1LkC+YsQkxjqCxxZy5/CNA2ZU0fmyCJTfSGYecXNcSUfuwn+aexaOs0u/XpXvTGOVw/1WozH7IH7RzDNhXd4oEvTtyL/yQXp+LjanDGvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oOGjgc8K; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AJjLPwv1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AH4o7Yv2852092
	for <linux-pm@vger.kernel.org>; Mon, 17 Nov 2025 05:40:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JwGLuFJyAq4A3H7EurGW9xTM5A4YqSMPozkgARyIVrc=; b=oOGjgc8Kq3rXZrJz
	CHfOvo5ezyaumC6LHqLq6qG53skD305fTxyljllaYLKjd9zUU0mlHDrLI1Jzesmh
	PTqn7SklfyMxBo0v2NoITpYpS1plQOsFjMBvToMazYei7gn25mT/zXRQX6IQ544x
	kL01vGc9x+2xLqLrltX078g1TBbZXcDCv5xJPQoPUX+JgfFVKBiiXB4eWQUobhHR
	IGommN1T4uXSI6JDBBO+O+WjJrW3trd4sdfFyQ3kr+Qj0QlEviHvlnb5EpFmEB6F
	KcqRmYyNf3FG6G9a4iJT/PNGJV36zbW3zYTzy6hOAhLh7+n/UDEl81qLKjWb94rS
	a4Yeaw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aejh0bf30-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 17 Nov 2025 05:40:38 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-29809acd049so63518405ad.3
        for <linux-pm@vger.kernel.org>; Sun, 16 Nov 2025 21:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763358038; x=1763962838; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JwGLuFJyAq4A3H7EurGW9xTM5A4YqSMPozkgARyIVrc=;
        b=AJjLPwv1/e9LtTpSlupw7gtmaAEcHGTyRj8A+E1CtmgfXMxOqxLyQDaqs72i8USQ3f
         dp8PDnUGXq7/7iv+3szCBI4rY+r/WrvINN7+cNWpXlfdNa7rclx5GBegNa3xd8jb6yJA
         irMqQAQ/T5116rZKZvAJgEhhLkd8oEg4TsBhTlVnOgRcF/HuyW2DG8wcX+R2qblqHAUX
         r49KlHlWYuGH1rj/e4w4ensodSuBjH0eREH+hTSXoZUJUgEcJ1rR2NB9mPjRTUPGUQPH
         lcfZCRU0SeDW28QB6yKxu5XtY0qp8Bqz7+rpq5cVhLYZfMQGB85oGDHoqfOocoHhp40F
         dSnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763358038; x=1763962838;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JwGLuFJyAq4A3H7EurGW9xTM5A4YqSMPozkgARyIVrc=;
        b=KLfqFfWv2SZAF+WPSkXMjQmlJsIahzXXwCW3XMM1vTiRdSgqkITN/wigIu4MHujNgE
         iJRfGNlIoYFMpuv0fyy51HqxlZvIJoQff4WvDhgVDIIz9YO973z9Wo3ju/cx6uDJjj5l
         5wpXxNlj2tYnKOUDvLhAkeoniujWC9SiBToigvvlMfkkyN3uAdF5xaSbXWzP1irJ4Hct
         TOsjcBeoLaKFWsNKkMOgznkQihaVUfJQyCFbIsNY4QgNIUOrnG9Qv8ICSup+sDM15GoH
         RWHZZQ0ECGaSCtaH2C5Xj7tclXAZYXmg3jp97fYPL46ZZG5rcqeWv/7zVliCbAlJINQ4
         de2w==
X-Forwarded-Encrypted: i=1; AJvYcCW5sPZd6Hh6P5TCSjh1Eg+kKlXVRBNggixYXVoLCMF9sZA8TBqXvHYZJGJxESNLcGHWDtyy/BXgLA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxvSAKo+Rga6CBDy1xoHTuEqu1bEfvSOyDk0QSe2M6MeNL06nh/
	A7kxnMYdLrZw69r8/iK8yRP1G0QuQwCLBXxe1BfdwrCKbijYicDqEmX6F+ZwmV72wdTxoH03WkB
	v9tQDP3FiI6d4PPIIGf793lReW5Peg9Y6QzMf/oeUQMn0+ljvUMHMDNAG9geNh4VAjxlYjA==
X-Gm-Gg: ASbGncvBbMb7qHVhyjVPv1nateUbErJeD9zCyUJX/Dsq/T0s193Trm8I89lCAkWiLiZ
	zgzPNTPbhOTmb3Fm0XZYJf8FU/ZDzF5cBMaa27FDLS/6Gk5Zp6VVNCwoCRUkDtRIr4eraL9Mbd+
	DUKM2zJbMnJxi++Nl32I6NmPWMr8zJV1dixiS+T4kJtw8kz8aUKGe19l/Yv3jf8vjUBUfvKtp1C
	Uit/MYwooaGvE+7ObqBAbn/CHttnfvSZYsvo8FMhZuFB0ZTuuwu2aSFxzrjMqAuR2+j3Ij5Uez0
	muF5ff+ZmOlEBOLS+Wm8SHSPe1GBlXXQiNNeq5+amlRT3fROgnO5PHgDNdKo92Zoivj81v4YSEQ
	2rSt62a8Dse+HXpdPOxG+suCZ9tHxkfKP
X-Received: by 2002:a17:902:ebcd:b0:294:f70d:5e33 with SMTP id d9443c01a7336-2986a6ba476mr125253415ad.12.1763358038118;
        Sun, 16 Nov 2025 21:40:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmA6o+kbOYh/BaAqHLrJj6Wk8KzmDvDjZ9KxgpwKs+YO/pyMn5IK4SjYWx/utHO71biwVziQ==
X-Received: by 2002:a17:902:ebcd:b0:294:f70d:5e33 with SMTP id d9443c01a7336-2986a6ba476mr125253145ad.12.1763358037616;
        Sun, 16 Nov 2025 21:40:37 -0800 (PST)
Received: from [10.219.57.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c245f8asm125541655ad.37.2025.11.16.21.40.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Nov 2025 21:40:37 -0800 (PST)
Message-ID: <17217b83-12ba-e3f2-da78-f423275da4ad@oss.qualcomm.com>
Date: Mon, 17 Nov 2025 11:10:33 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 1/2] Documentation: ABI: Add
 sysfs-class-reboot-mode-reboot_modes
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Sebastian Reichel <sre@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20251116-next-15nov_expose_sysfs-v1-0-3b7880e5b40e@oss.qualcomm.com>
 <20251116-next-15nov_expose_sysfs-v1-1-3b7880e5b40e@oss.qualcomm.com>
 <t3hfhlp27numfxurtmtcwrovvlgwdvnujain46kwmi37zehdak@xt3vngtkxpsm>
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <t3hfhlp27numfxurtmtcwrovvlgwdvnujain46kwmi37zehdak@xt3vngtkxpsm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: mwfaOqdiWbtbQYGm0eggxjhV0aK91fKy
X-Authority-Analysis: v=2.4 cv=A8lh/qWG c=1 sm=1 tr=0 ts=691ab556 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=NpYxkmfexd4ejymn4sUA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-GUID: mwfaOqdiWbtbQYGm0eggxjhV0aK91fKy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE3MDA0NSBTYWx0ZWRfX7nKumWD2hlZ4
 xlapkNmVz/K0UsJU3pOxW0/WIOrF9DuHCmDqqoPEz1E/4V/Zr//SSHEiJZdrtZN99JZXp6LLlG0
 DuN1KbbWMWJjSOL6hXXj/VaWSWmCRLILMU7/cX0jAaps4oQkKIH4MBMaFOxqAnVSi4ICTzjWoQO
 ksqhF4VRF4lQef//AfNqLpg7xvdAwA2mxNW+5XIgHeFa1JjFK3UJQB1HkWY6ig63ANJv33YeTzZ
 GLA2U6fh5WiBf0pUKbNQ1Ghtn3ZBFZllQ1gjkeLgR9eDIvISNPb16bl2q3pK5Zn73IEzCw6FT/O
 hLX3KL/DOowHxu3uZU5s1GcKFUgsXtKq3Vdo/GgQ2JlLAYxV/dewHXDwYIbI4qO+teG3K0m/UbJ
 Yvk0B+OBY7IiKVVJ7GqlLBd8fV235w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_02,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511170045



On 11/16/2025 11:14 PM, Dmitry Baryshkov wrote:
> On Sun, Nov 16, 2025 at 08:49:47PM +0530, Shivendra Pratap wrote:
>> Add ABI documentation for /sys/class/reboot-mode/*/reboot_modes, a
>> read-only sysfs attribute exposing the list of supported reboot-mode
>> arguments. This file is created by reboot-mode framework and provides a
>> user-readable interface to query available reboot-mode arguments.
>>
>> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
>> ---
>>  .../testing/sysfs-class-reboot-mode-reboot_modes   | 39 ++++++++++++++++++++++
>>  1 file changed, 39 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes b/Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..28280ffe9bf962ef9d2136ea5d7c6aef77c4bd34
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes
>> @@ -0,0 +1,39 @@
>> +What:		/sys/class/reboot-mode/<driver>/reboot_modes
>> +Date:		November 2025
>> +KernelVersion:	6.18.0-rc5
>> +Contact:	linux-pm@vger.kernel.org
>> +		Description:
>> +		This interface exposes the reboot-mode arguments
>> +		registered with the reboot-mode framework. It is
>> +		a read-only interface and provides a space
>> +		separated list of reboot-mode arguments supported
>> +		on the current platform.
>> +		Example:
>> +		 recovery fastboot bootloader
>> +
>> +		The exact sysfs path may vary depending on the
>> +		name of the driver that registers the arguments.
>> +		Example:
>> +		 /sys/class/reboot-mode/nvmem-reboot-mode/reboot_modes
>> +		 /sys/class/reboot-mode/syscon-reboot-mode/reboot_modes
>> +		 /sys/class/reboot-mode/qcom-pon/reboot_modes
> 
> This part is obvious, isn't it?

yes thats correct. Its just added for completeness of the documentation.

> 
>> +
>> +		The supported arguments can be used by userspace
>> +		to invoke device reset using the reboot() system
>> +		call, with the "argument" as string to "*arg"
>> +		parameter along with LINUX_REBOOT_CMD_RESTART2.
>> +		Example:
>> +		 reboot(LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2,
>> +		        LINUX_REBOOT_CMD_RESTART2, "bootloader");
> 
> So, does one need to write a tool for invoking reboot with the corerct
> set of args? If we are adding a sysfs interface, wouldn't it be logical
> to also add another sysfs file, setting the argument?

Some of such utilities are already in use and they pass command as an "*arg"
to the reboot SYSCALL.

reboot-mode is currently tied to the reboot SYSCALL - "*arg" being processed as
command. We can open a sysfs for setting the argument - That will be a design
change for reboot-mode and then we need to also decide that if the command
being passes will override the sysfs?

thanks,
Shivendra

