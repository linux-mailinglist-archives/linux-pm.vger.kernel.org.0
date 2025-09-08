Return-Path: <linux-pm+bounces-34166-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C0AB493F9
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 17:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A43922054A1
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 15:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD2D31282E;
	Mon,  8 Sep 2025 15:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PkfM9Yu+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D44F3126DE
	for <linux-pm@vger.kernel.org>; Mon,  8 Sep 2025 15:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757346078; cv=none; b=o93zp6mqVXSIQ6AlxxIwRVSfsIV9paf5MitPk5srYz/gzUSc6xtylHsCfpQ11ftPrMdl04XKDVxbdjg66fknGdu9X2BNzHcLJr3zeWjx6zGXe4ZFRVmAcSlENQPlPnuepl7ULo+ci/0pnSwSRjtDvYrO1Rcs+3hHGaq0Fqs5kZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757346078; c=relaxed/simple;
	bh=G2fs2nKN2ZhgBjC25RM41Kh9rDq7tT3JvNkxLut32sM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oMW1ooYpbqOrhQ+CYHs8hnTyYtroBZdipUvvnu1/xi3uwaM8rbLZnBI8zpxXY74qjZztz45dytgtgZXohaLPj4scaQo8jYCqSRj6mhK7FlmPEPEROUZcaUfIkQtg0rCT3PE5WMg6jyHEphTW1wGb4hYtg5VN1/zJRbj0kuKdBOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PkfM9Yu+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5889LYVI003963
	for <linux-pm@vger.kernel.org>; Mon, 8 Sep 2025 15:41:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gUNywjEFdmTkr5x1l5m+XCGsRzCZz5+0YY3gu0GUprQ=; b=PkfM9Yu+/rv2MnZl
	juMEblxaJs+I6c+tH9adT04naeezqLbdt3+0KRkf+CBpg479N1M1Xc7CW7Y4pzBu
	Tpyfsj/vEb2UH7ZYficaX9JEdlJdMkDTUfhf0exzJDx3y+FgZLMIs20zu3UVPUrx
	sXLWQ5pkT3AMLqlfTXxBr0Gm63BZlSPWOfKoP/h+LesanJOsoRyh7x6VpGNcbthO
	KUd9xawEPStYPb6axXwBCdG5yPeY7Aj3t89D6bz9hNKcvgn6ajm0TFRm3bVI34Pb
	JaNqJRAnBzMex4V848mv6p1S3KTEjMfyycOxCSKIqFNQ/Q0PK0nX1xqd/Y6rAKvG
	GP6jUg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490dqfvxq4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 08 Sep 2025 15:41:16 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b612061144so2632671cf.1
        for <linux-pm@vger.kernel.org>; Mon, 08 Sep 2025 08:41:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757346075; x=1757950875;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gUNywjEFdmTkr5x1l5m+XCGsRzCZz5+0YY3gu0GUprQ=;
        b=A9bI9pEpoTms3y+V5ZFnkM7Fkc0cOf1a0OcWiShUKxke5rQHWnoPSpTd+ZvpNlBMxR
         pAxFa8e2izfkEaNYSa1IKj8iFKbdrtF0H1mCtqFBs3Sn7gfo1oCSgMxHbPN2dNWugghn
         e0Am6c2qoIAzhcs57W3yIx0glB8Ml5MkM6BJeIzYfwYyi6AIHi/xvG6l2pfbnK9W5iXM
         ClK6LH3EdqOUcm3xUsR/QFLNygcvurmL4JfkPItXHthyVbwlzvxr/1zAMuaDmwB9cNmu
         iGWOaQkSphJFJr3s3tMh5dTFvb4ewBQhKTNAl1wXdIH+RCBL9q/6WPKfMHdsWVxgRbrV
         4Mdg==
X-Forwarded-Encrypted: i=1; AJvYcCUbPJxkk1wdzOpUOeMub46FmUSHcm94gezva0K6+mwbrY9SPvsR4GvwPpCGyAxR/4RakNliYyBCZA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0vWt5gjiMIDikwlPXttWHMjVdvwVtO8DyoK/v7JmjklYTyGjA
	bbG84RYH29DjoO0CiFmONU/6fu/7HKH68hWMc6sfKx6NJfannjxKkYrH6v8x6jhwrQeFlZkhOgd
	bHIo/jyxc8b3rpjAq8Z3/ZPBSotCua6Wy4dpAf0Uu0j6yg4VPeQNvvcqCCHMb9U/KMvFzNw==
X-Gm-Gg: ASbGnctD7En826YjPsLKnJD+VSCmkdzHasmgIwE0NYaTci/svttf5m6Np40h3+82XKP
	ZiS1eYNo/cMItDehIqdAZ0LxalsfIjotsQq5X44bwUUg4955TEQ8f+q/jgbqEwZo0pnDjJo9/7s
	2+fyvnP12b8rdVpC34NFFgWh1wjJn2PJrUjObSfnG6FqkGpYSMDOUAV5uQpk2XfWHcjkfJrxjOm
	YXhvCeDn1+mD53jC3pLjwvYIqIOkAtQDoXWpqH4r9OyYsXig8DZcHlt1MCkOOoqDQ4LQRUFamHP
	GmJP1soam4kDj3BLvkZGxOqkEr1ylvEoqFT31ft5xnneQct98xKXDQuuIy0vxRFw+qEp8Y2ee5G
	SboFbrdCOJWNC682EmT9fBw==
X-Received: by 2002:ac8:5f14:0:b0:4b4:9175:fd48 with SMTP id d75a77b69052e-4b5f830417amr59239701cf.0.1757346075067;
        Mon, 08 Sep 2025 08:41:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEd5ZNZ50YBUchs3nuPz0LYnawAnj+cThrii0JYVr/emigl5wPPuJaCTU+N79pP56oMJTCaig==
X-Received: by 2002:ac8:5f14:0:b0:4b4:9175:fd48 with SMTP id d75a77b69052e-4b5f830417amr59239211cf.0.1757346074307;
        Mon, 08 Sep 2025 08:41:14 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b040d44c9adsm2198301666b.9.2025.09.08.08.41.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 08:41:13 -0700 (PDT)
Message-ID: <2f95d508-34ba-4a29-9add-63909db22b60@oss.qualcomm.com>
Date: Mon, 8 Sep 2025 17:41:11 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] cpuidle: qcom-spm: drop unnecessary initialisations
To: Johan Hovold <johan@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250908152213.30621-1-johan@kernel.org>
 <20250908152213.30621-3-johan@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250908152213.30621-3-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: sHEu5oP2Is_C9RG8vnj9fLu20u6khYza
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzNSBTYWx0ZWRfXy/m4d2aOaopJ
 HmnRWw8WugBpTFp2ukliRREYJspq8zd5RxkMpm4j4AJgswtVmMW33JaysD9uXWkwQSB6z93hqQH
 FvyMW5OwZ2T/FuVNtJ2NTqk9LuNgx1YcLpO7CjKSu0gCQeBkyg+letcbfHtb/GdVnSvz8rvH3zQ
 3xqZhUP+0t2i1LrqK6pm2+tkalJ0RT399Bfyj50/z4rK+k2bpX+80cUPHwLp+DLJMvleUidut7y
 5Vb+NdLyJGoZAKtmRfJKX+FYF4hE0yVx6k8iKa+apwvANRRayJ1uQYLJWurQA/Qn/CN9j1GDaIk
 HOM+AIpWZuQ5h0rCAtPAyEM7vsQ/BHftI9uQZXd3AF45TamnMWHYlts+xEoFmlibWMrWQpDWC8C
 bAtnIDuo
X-Proofpoint-GUID: sHEu5oP2Is_C9RG8vnj9fLu20u6khYza
X-Authority-Analysis: v=2.4 cv=N8UpF39B c=1 sm=1 tr=0 ts=68bef91c cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=vJ8C-6PKK5JqxMKs-bcA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_05,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060035

On 9/8/25 5:22 PM, Johan Hovold wrote:
> Drop the unnecessary initialisations of the platform device and driver
> data pointers which are assigned on first use when registering the
> cpuidle device during probe.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

