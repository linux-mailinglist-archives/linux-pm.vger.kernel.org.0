Return-Path: <linux-pm+bounces-43236-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOLyCz8QoGnbfQQAu9opvQ
	(envelope-from <linux-pm+bounces-43236-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 10:19:59 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A29031A3459
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 10:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 003E030C6C5F
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 09:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DBC39E19B;
	Thu, 26 Feb 2026 09:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gPFGORJO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CjHamfNH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1C239A7E1
	for <linux-pm@vger.kernel.org>; Thu, 26 Feb 2026 09:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772097327; cv=none; b=U+gG6R0vpdeOBJ8uaeM4u7M90pVxRFfTFb1PD14KORK7k4bR6cJNVGvMhhCufWsiQGZBkJxhZc/DslgGP2V56RbKFe3dnlUd+1SklyM1a5L6U7G5lpNoK0XssKcqczr/bdkEqHUqOySuIOIkoUH8Wy0hvjp+NdlbwFWjFsSL9lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772097327; c=relaxed/simple;
	bh=QlW5mac6XApHZfJPctnFhCmABhK3Hs1RwJL21IWHK6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OA6aAxGxiwRt2lHtF/94ZGoMfKoMYMJHtaG11FLyhUkjAgx1MXAtRTjYhPeGCWC0auoykMZJgXhrrQMEkqsiJieBKj8zrVQWLw9k42dxN/47kMULJ9VBmG7cnE8n0fpVeOS8T179SZPl4JJGRcaDoh5KIU6dvZ/U3wAyNkaZ9bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gPFGORJO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CjHamfNH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61Q4UtFF3225953
	for <linux-pm@vger.kernel.org>; Thu, 26 Feb 2026 09:15:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZPkSB83KryX1MJwmDnz55Mmxd+DrswTtGJyGY/cSfw0=; b=gPFGORJOofdOrAh0
	WYv5RFOR29P9KC/L+9KB6dbnjL3TS8mWScb1ZG2k/AO9xGTyXJK1N2cS9uE7+YpR
	9KvhF6ftp78kOOFZeFs5p3p8fVGXTZ16xPbA0TW6DCap2zzcLUyU+NhD3sRCo7UL
	CS/xUkrYTRLCNb1Brm9JdmGrJNHgSCfG4Wi7Wz2G2bFKxZaZq81HZT+A9geeQ2vs
	y7inRsvqR0GumDHWJinfBFEl4UU4sFcsTyXPNO7oO+RdNWFdvgjo9aespmLaoOFP
	8bCBt7ktEZ+XnT3cckmZzPCxM3wBn2ZxNuvpu7l43CwcFSX0Bcme0nemkYp85tGF
	dlGatw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cjdph12dy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 26 Feb 2026 09:15:23 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ab017c21e9so3255715ad.0
        for <linux-pm@vger.kernel.org>; Thu, 26 Feb 2026 01:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772097323; x=1772702123; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZPkSB83KryX1MJwmDnz55Mmxd+DrswTtGJyGY/cSfw0=;
        b=CjHamfNH67/P9pq1lmy+oUGcxwGnCsbmhp4YyQ5oVdOD1lDM1ToSxBeM3bYj5ygIpH
         zYhSS+DHvUHVvNfOstot9DjVtgImUSVAwpVN3659q7Oky7SY2rt16hq/LZO3g2Bwb45I
         jDjxzk9lQj2YxXGLjKLpfvqMZXNBJ0XVYJZsxpL0UoO4ng7LDwJjq8+F6cihgNvyeaTf
         XPhJLr8Urri4scA8jzO3ctfG0fNfJqU/kXdtsmfihGZLaamU30iJ2gG+lg9bc2VaMkne
         rtHhM0YoDtPVlKIdHrTh+Ljp42Z++3y/8rwZFn9KzfqZOCbEsTetscjE5OpAEXdKo3Zp
         FVaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772097323; x=1772702123;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZPkSB83KryX1MJwmDnz55Mmxd+DrswTtGJyGY/cSfw0=;
        b=mAEXjVCtq0zSrR+jd0CI+ycLMnV78siI8fhPZ8W076EB1q1Ncg9hhE4Ruro75I/8Sv
         X70hqH7vPC7YPZv1d3FlSeNGGPPx6xpzqr0SfkJS4Hdv5dfWj57b7v1QZbJM4vUQibFw
         LZIR/tZZ+pXCicMUJEBKJT3QG7XaGdetDK2VUWK90nQ+vDVAu5cEr7Pjd15YcGaScNIa
         F0zjkPsZsb85U1E5955kndey+/YpoIxz66Hr4N5YUHtUN1gCWn8pC2o2DJXTDdri3pHR
         30OdjDCCGL53PjwNeOFtvy1E7W45nHc2GiedWpbVSim7EdzC1e3c79KvqMbn4XuP5a9A
         Q0/g==
X-Forwarded-Encrypted: i=1; AJvYcCXhHCLsLSSiDaECJg5edbsxlV+HSmJgajrcnYvO/BP0nP2ZBoXvlwYFkPUfqEWncV6ycO6Y/WXs/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGcPe/1zypDmLyuiJ7dcMfoR+wefbkFKQ1mTj8Vue/xpxaRbfQ
	g+7smDdBYuHa/bnp+P+bcBejh0iOXF7RUF9UWEhvOOekwJErMtElOjyhb2gJ/i+pz8udWrYTl8A
	VOu6LUVCySiIFtnASXT3QXfv7jRjOAuonLrWQlkMseZKtz2gZAN7O3kZHv60HEA==
X-Gm-Gg: ATEYQzx1i7DMVF8NtA6HbJr9k089jX2DEY7XrtI8wjfQbotiqG9JVgjN+uwqX7eNsKe
	MdYY2IhWxTdRmT7nKzpSNZ5dkCc9DO2JxGImzloeDko6TAQp/FRCRQqT5HqWh7TITk+TLPFxVOV
	mwn7vjwl7W01r2ZbxNUnvbXzxUUCrRlxrJTYyYS9ovRTHRgaV76JOGfAJnJW+tFSygIsu7/KwDH
	l0HW7DImBduhdlcf2RzzpCAGU8MODQJxGvBxBaLt173rg0MOM997sgpZgxEMYvgLofN40mOu5sR
	lMXJ/PaV23crF7zc/dpJ9aWc6VvWze3MWDzYcIcn1KYYoguwWwIyDZPig7BTgEbSFIINCZeoLF6
	QWUYXamrWLszTdYLDrZK0r4azvgBOk4UHLhXvdGKHd0GM
X-Received: by 2002:a17:902:e746:b0:2a9:6281:6a4c with SMTP id d9443c01a7336-2ad742b63e4mr125171385ad.0.1772097322761;
        Thu, 26 Feb 2026 01:15:22 -0800 (PST)
X-Received: by 2002:a17:902:e746:b0:2a9:6281:6a4c with SMTP id d9443c01a7336-2ad742b63e4mr125171155ad.0.1772097322271;
        Thu, 26 Feb 2026 01:15:22 -0800 (PST)
Received: from [10.253.79.190] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb69fa4fsm18661855ad.45.2026.02.26.01.15.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 01:15:21 -0800 (PST)
Message-ID: <c1355057-486d-4852-8fbd-f9916786de06@oss.qualcomm.com>
Date: Thu, 26 Feb 2026 17:14:33 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] arm64: dts: qcom: qcs8300-ride: Enable Bluetooth
 support
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-pm@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com
References: <20260225091700.286108-1-wei.deng@oss.qualcomm.com>
 <954f6a53-b597-47dd-926a-adb5a7513edb@oss.qualcomm.com>
Content-Language: en-US
From: Wei Deng <wei.deng@oss.qualcomm.com>
In-Reply-To: <954f6a53-b597-47dd-926a-adb5a7513edb@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: IEppBag6DLf9kSOSAGcwzwKDVdupcJs_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDA4MyBTYWx0ZWRfX5VWUXQIyKjog
 vaUf3w8aY9cmIGE/xHcJKZfu8/xqH7UyDauU9dMfGke2qEbTwRjdmW1UhCXoe/RpUygEhOjkOCd
 yf2kMgbf3sAptucQTxQrbFGNJGJFyNp8NzyRKq8vHw2J4GvzBUzY+JJ3FW5BzNKX9HNgLeLJzzI
 dc/eBbqcMPLzB2Rgkw46bcNAuWM9iPp0f9e/F2TSbC0a4Nw+JwcnvPJ1PvVSh5GuI72TiS+Q4aF
 qz4k84MNgODUl3T3PvPE8F7gJtoKAy1DHbASWGdClWYj9j9TXUl4Y9FL40TTLqb7s9tVHpc21el
 GAX07rif+lXQc1UQxl6hMcxsbWX288UDO35E+yERQcBQ0XYSQySz9IBkw4hsIIsMKuDAOx/+jwD
 x2bHiUauP8hKJc4m+ba0xVHBMc/FpYnErZEP18DczVxTgqHyumqbyC7TEgHI20JTCWv59dhTrEU
 THWggPRTIjgNCF74avQ==
X-Authority-Analysis: v=2.4 cv=NJLYOk6g c=1 sm=1 tr=0 ts=69a00f2b cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=UB3C3iIAKtE6oQ4yFSQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: IEppBag6DLf9kSOSAGcwzwKDVdupcJs_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-25_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602260083
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43236-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,holtmann.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.deng@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A29031A3459
X-Rspamd-Action: no action

Hi Konrad,


On 2/25/2026 8:27 PM, Konrad Dybcio wrote:
> On 2/25/26 10:17 AM, Wei Deng wrote:
>> Enable BT on qcs8300-ride by adding a BT device tree node.
>>
>> Since the platform uses the QCA6698 Bluetooth chip. While
>> the QCA6698 shares the same IP core as the WCN6855, it has
>> different RF components and RAM sizes, requiring new firmware
>> files. Use the firmware-name property to specify the NVM and
>> rampatch firmware to load.
>>
>> Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
>> ---
>> This patch depends on:
>> - WLAN
>> https://lore.kernel.org/all/20260122053624.4068718-1-wei.zhang@oss.qualcomm.com/
>>
>> Changes in v3:
>> - Rebase patches
>> - Remove unintended 'output-low' from bt-en-state pinctrl
>> - Use prerequisite-message-id to replace prerequisite-patch-id (Konrad)
> 
> Only now did I realize you're the author of both patches!
> 
> Next time around, please keep them in the same series, for easier
> tracking (since they're very much related)

Just to clarify — are you referring to the below WLAN-related patch and this one? 
https://lore.kernel.org/all/20260122053624.4068718-1-wei.zhang@oss.qualcomm.com/ 
If so, they are authored by different people. This BT-related patch depend on it.

> 
> [...]
> 
> 
>> +&uart2 {
>> +	status = "okay";
>> +	bluetooth: bluetooth {
> 
> Ideally there'd be a newline separating the properties from the subnodes
> 

Thanks, I’ll add an empty line before the subnode as suggested.

> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Konrad

-- 
Best Regards,
Wei Deng


