Return-Path: <linux-pm+bounces-39702-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B326CCFEDF
	for <lists+linux-pm@lfdr.de>; Fri, 19 Dec 2025 13:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2ACE73025726
	for <lists+linux-pm@lfdr.de>; Fri, 19 Dec 2025 12:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D8F3009F7;
	Fri, 19 Dec 2025 12:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NEhTby2V";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Dz21pR7h"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830E82C08C4
	for <linux-pm@vger.kernel.org>; Fri, 19 Dec 2025 12:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766149059; cv=none; b=rmHp3wLMgTgERgf8Pl8Q8Ul/OIZyhIOAwN7HM/izTZQkhCWjPSC7kgfRjdxPBSidYUPcFGaPOlU8vwABfxyyebbYtBetQcPuljvO6vf35saa21vAqkyVh58sjlZdrjilUKvNWOuzt8KKt2XgwJQkRoYgbdqUZM2G+TGyaWFuVDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766149059; c=relaxed/simple;
	bh=Nmgmbc37BmbIUHfQjHR0gOnqRt+M/82LN9ZzoVB2q2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UVzFh6Bsmdx81kugH7JW/FkRRpM58kGP2aDhMXpGJnC529EbXnClC460z7izQAdoWyyE1V3vljIRiUVCRuBcWkyPP6+9+43TGOt97xYkPf155MoIEkK5GXqVQQhmaAwOdDqh+8Jv3UvK2YnCSUyaJZS6HYmdjdRraE3acScq838=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NEhTby2V; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Dz21pR7h; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJBglom1771837
	for <linux-pm@vger.kernel.org>; Fri, 19 Dec 2025 12:57:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rpUqy0FXyUwvP7vqrL31xDpc2ti1J8x7V9ekZZIqyLw=; b=NEhTby2VLOzoyeXO
	8EBxW9w46tRSXiqQQzIspIxXS1rr2+O374lNY1Lqc96HKmVnhRY6w5wTJvpPYAEa
	XNLTXMYTvAwz0nrlvPC1NKFFJusKSAf24qgpFNsgBEQWZwI6hSqUdeJjTWqOdcH9
	hh/KXn/QmIL6pVSZ6dMunlsr2tucDq2J/nhtQEMNghVtqAiutOP2qPyC1TuU4cfp
	UV1DhaADRQNxcM1cVDr+XW+l1SQJaUZK94alVxETSSBBB3PgrxLEdKBXcMsd1Oxs
	Ck8f9IfGHWFva/CsQ495clRhI3o77zKvj1UX6IxDHbtsYUygvB0MGhXqCRtRm/l6
	eP3qmQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b4r2bjpkx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 19 Dec 2025 12:57:36 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8adc67e5340so43070785a.2
        for <linux-pm@vger.kernel.org>; Fri, 19 Dec 2025 04:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766149056; x=1766753856; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rpUqy0FXyUwvP7vqrL31xDpc2ti1J8x7V9ekZZIqyLw=;
        b=Dz21pR7h9jGLYOg/WJmz1q4LqCRfeNujObzVD50KDKWGvtQDC0lwqX02osv1TGT/JK
         zZFBZhTX1xYgE4DiAAU/7u72Sw9E1Dc16/0cpo7+AnP6Lxfmlj8xuIzJL05pkOedtLxj
         lHsl80BM9pd6qHyklGoOEiWfbqt/x72EJ5I24LrnLKsN3LKH3BCk893TclIjgGfoH8EZ
         1TIATafvpElUhKR2URBXSFkxLFiADpsudKCD+gUBIr/Fz7UntrCCCTUZzqU7JIRHzozE
         GZxAb+jQ+s5lE9N9u1dMh+t19tEkTloFY7dVs8ElQ+/QFfXaPmXYy8hZYH4feIMhNuzg
         Wm6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766149056; x=1766753856;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rpUqy0FXyUwvP7vqrL31xDpc2ti1J8x7V9ekZZIqyLw=;
        b=M52oD1d7cIFSofLPz5zgRxtlrcIJNLk+A/eBY7b11gqKeGEz1haYE/IAdnTXYn7/zY
         seWOmp1EsQdd9+MSCyWGXk4oIyVbrrLMFdV6704XWZsuMWCsXbxMUJ4Nxd/0dIF1q51q
         2VIjWjqKNrMv+iOR1th8X97EuFNreQVr82jLPEW3Ntkwiz3Rvle0rxOWSDZRJzxELV94
         P5q1KOoh3Ef7IEQC6k5KXgdRgNHl9CRTRhlFzo39rGrRK9y13vv+sslKaB4MgKZi6R4T
         WhC2VY+5dQwrwkQdV0XGU2s7It9D4tV9vkmKEkynzdN4F7ZOFTqoTFi9cXpUDmku+Lu8
         GQXg==
X-Forwarded-Encrypted: i=1; AJvYcCUHwc7AADF0SdzXLICupoKe6tOoyeaWN8wo1zHtf/WUXNcTf3NfZ61+lmgDCVpxBQrC80N1AXJ4rA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+qO4Uk61B8lkvLY3i/SmTrQ9VxsIifpybFXNUb3FDZITo2IfG
	B50NnFIRiHKZSiGEDpV4cS4AVDZXLHID5FUw5mZL0wwNm6Jkz2FC7u6m/0GnmHLznXx71SO5W+f
	zcgzu3smVQHGbyRDuYsygwewx9g6WPPvRlE7O2AYuG28kCAX7IoK66Dwe5xC3oQ==
X-Gm-Gg: AY/fxX5vDAymCvg/c1D7vn3RsRazTbs9LvOItKJCyD4+CD49mMWN+S8LeXTwdVpImnT
	J6I/SR0ONI4+MS1u1aPnHLCGJixoad8sWHKB0ajQ3DZOWvFZxBAzF4Lk97NW257PmpSSwu2nfIn
	m2WIxOjsHP26ndXlIuutr9rGVWVLII4GBH5HYKuNMbxmlkKyv5irMmEdgLpZbmFGNnivIBu4vSP
	b5vHezeeEIH+UcJl9DWhey1r1TYlSpjJ/vDDaQbZ6vx732ffA2zfHXjdWVVqQaIyuf2h1EU5utt
	QfKEkJqLO4ysSX8pJ1WUYvUgqzjTG36h1TCXHorqXQhRqKI5ig6b15szWBvfnNUoxooDiMuaCNG
	yH95RAYmz+6Vnlc69Jp+ju3qv4mDcQBuS48He+LUsQxTvtTLkKSE7RygJFNTRWiPlfQ==
X-Received: by 2002:a05:620a:4111:b0:8a1:a5c5:ef18 with SMTP id af79cd13be357-8c08fab59d7mr303022685a.7.1766149055866;
        Fri, 19 Dec 2025 04:57:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFZ4KdFJ5tZqCD6zHIWJNWJ/1B/yl7GkUveDwgJaiMBUM//ImT2C9l2PhQ4e7IxsQe3cgUKw==
X-Received: by 2002:a05:620a:4111:b0:8a1:a5c5:ef18 with SMTP id af79cd13be357-8c08fab59d7mr303018985a.7.1766149055426;
        Fri, 19 Dec 2025 04:57:35 -0800 (PST)
Received: from [192.168.119.72] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b9159a6d0sm2126156a12.28.2025.12.19.04.57.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Dec 2025 04:57:34 -0800 (PST)
Message-ID: <298b7438-f6bc-4022-a56b-26585a6ddf91@oss.qualcomm.com>
Date: Fri, 19 Dec 2025 13:57:32 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH DNM 2/2] interconnect: Add a test Rust consumer driver
To: Benno Lossin <lossin@kernel.org>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Andreas Hindborg <a.hindborg@kernel.org>,
        Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
        Danilo Krummrich <dakr@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20250722-topic-icc_rs-v1-0-9da731c14603@oss.qualcomm.com>
 <20250722-topic-icc_rs-v1-2-9da731c14603@oss.qualcomm.com>
 <D4552EF5-21DB-44AF-8E45-F57B0B8CB853@collabora.com>
 <DBJGTCPDUU4J.16S98YARG0S7O@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <DBJGTCPDUU4J.16S98YARG0S7O@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: tMQuxhlVjrLQBJ6I9yGnIsXPiaER3DTW
X-Proofpoint-ORIG-GUID: tMQuxhlVjrLQBJ6I9yGnIsXPiaER3DTW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDEwNiBTYWx0ZWRfXz4GwVFUMf7Ks
 JgtS6BCN/uq9t0q81AapyMtzNYp4/GZe2hg7A22PpDB6NhciMjEUIBxqbsYVK7bFxpC9T/kSUYW
 IQDLgwIKreRtDvXGIqsr1iYwnmx5vcx5wLps1ujk0GhBtaWs4xusQdNmY4r55xpTp192u/9Ncgw
 xFLUgXdsM02JnUCCIZ2XgPyVtz8dd3hzf6I/csRI4SXxxmYd4c5zzw/b7emnCL1KrgKYzWuKabF
 WyHunhi1XiylgGtut5Q8tzUAlJyzFZECwCL2Py6r1Mefd+4jbS/YjJ7fqNk0B1amna40xJMg/ub
 dny//Jcp0o5FPb4W1C2K/DQ1GsKjgKvPEI6HObelpv5ngn2PEsXtN/jMsr7Mk/mdWnJsv/DWMIg
 bXcq0ZgPMXNWb1dZJ6AMoZOaOn3Po7Bduz9Lv4TRBvzNjomz+dyZTFykOyjZJzfciR4BJObR2ki
 gzRijkJMXZm1LtCi9qg==
X-Authority-Analysis: v=2.4 cv=WYwBqkhX c=1 sm=1 tr=0 ts=69454bc0 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=b_VcUuRT89JXC9oTYd4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_04,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512190106

On 7/23/25 3:22 PM, Benno Lossin wrote:
> On Wed Jul 23, 2025 at 3:10 PM CEST, Daniel Almeida wrote:
>> On 22 Jul 2025, at 18:14, Konrad Dybcio <konradybcio@kernel.org> wrote:
>>> +#[pin_data]
>>> +struct IccTestConsumerDriver {
>>> +    #[pin]
>>> +    path: IccPath,
>>> +}
>>
>> I don’t think this does anything useful without PhantomPinned, but Benno is
>> the right person to chime in here.
> 
> It does do something useful, there just has to be one type marked with
> `#[pin]` that is `!Unpin` (so for example `PhantomPinned`, `Opaque<T>`
> etc.).
> 
> In this case however, `IccPath` is a newtype of `*mut bindings::icc_path`
> which isn't `PhantomPinned`, so this doesn't ensure that the
> `IccTestConsumerDriver` will stay pinned after initializing.
> 
>> More importantly though, why do you have #[pin] on IccPath?
> 
> Another question is: why is `IccPath` not a newtype of
> `Opaque<bindings::icc_path>`? And then one can use `&IccPath`.

The short answer to all of your questions happens to be the simple
"the code compiled"..  :) I didn't know about Opaque<T>, thanks

Konrad

