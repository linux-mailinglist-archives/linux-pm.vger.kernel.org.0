Return-Path: <linux-pm+bounces-39086-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DFAC9C32C
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 17:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0E84C4E0451
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 16:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4E12857C1;
	Tue,  2 Dec 2025 16:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MhEOWQW5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DYoGOmTs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041B128314E
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 16:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764692897; cv=none; b=X73733sYQxFNvOzIWMCIzoBLXsQMyvxDPhHJZWQqPLewdV0OQJgkl6zLuJ7RR9kgIb+hR3IiMkxqvBO/CHRq52A/UHkjwxvHCPQQhHis1FDA4UakrNrDCoQmi+EAfRiBzvLglqslQKY+lra5pqzM8Hymr7Ro6qGY7GOPB+nilg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764692897; c=relaxed/simple;
	bh=/fzG6+c7LFnjNfhU3u0bUL3UViKj/Hn79u5Wiznuxl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uFXID5Wcvlzkjk8BKQRH94INH6MmjmNNQsvG8pPR1UR7YLR86O5++bmIXcAOK5BkqVzyA37flqpNZS40NDcB4mJomtIkg5iAga9ZeXdg935rMDx04PcaP19dDBjg5bLziepSk8RcwCxloYvfDGK+tCVj2xyEmUWgHjeDvIyefYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MhEOWQW5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DYoGOmTs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B2DjNnd2821359
	for <linux-pm@vger.kernel.org>; Tue, 2 Dec 2025 16:28:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ql2fBAgtpQ2P+ST7cUT3v9H7Lr53iSbslB3cAaHxO6I=; b=MhEOWQW5lDahmfHT
	9+9S9WhNnYJjWJEfZ1OXv8Y4nQKkYeDht0v6nqEqNjtdigL4RWxz1MkO+geyaiQC
	uq7n3I3QXxpmLp2u2BKoywMl/QZ4rWmRSdYL15sw17pXY3LfwILX29IZ9KaikLea
	w6mUORGt0ByrLAxtSkgdzysmmSV8640VRF1ZlynP+hPML7/bSp/z1DCupCAqEPYN
	XrNc3+2wg/o7S6BE6JqVHADhNBNp81DoHWbY8XTgfXj0kd1eC/xVE1lUJlN5vWGb
	o/0JSzfZYWrj2elDaSudTAq5urQdeSXENmnj20tSPUMsn80cXUgSRYzEWNvxt335
	JwK4Ow==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4astjghy01-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 02 Dec 2025 16:28:14 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7b9321b9312so10290250b3a.1
        for <linux-pm@vger.kernel.org>; Tue, 02 Dec 2025 08:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764692894; x=1765297694; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ql2fBAgtpQ2P+ST7cUT3v9H7Lr53iSbslB3cAaHxO6I=;
        b=DYoGOmTsbXN4JFX+rJAz7wf/ujO14aAMQGICWWrppggyZc9XPo3yKinpfEhJWJXHQe
         hK1AAXAZH7mTwP9ODYFw1UfTQ7DRsfRLdG9XhA3hrsGqwbBTvSCMiHiWgJcgJ85m2fZS
         EdS/xfvbMMoCqPL3/iIHMyzzyiQ7uai2rQz2ch/EbIo3aYWaBKh/9Bir8E+QAwnUeYve
         hwHcqkmWno4z0rBPLkbENh+17I/RAgUMWSthR1IkHWD8gvXl4bG0DMF/1bpzxwRVKBXU
         qTfYAxdbwZkshjtevZOz5ccXY9qdaqjCBCXDeqDl0QwELx+o8V1UniumaVlMTTZxtCSI
         2wYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764692894; x=1765297694;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ql2fBAgtpQ2P+ST7cUT3v9H7Lr53iSbslB3cAaHxO6I=;
        b=ZWFXa74zNZJh+roH0jEN59AMQSdAAOCvelM2OeY8boW1SZ5TmHFZgqknekWXR/mQ99
         0NnyA5OjSnriiS7VolYxjgiSlyl7Zmn9mff/orwVOvjkUK5j4WyJqb04GkR/eqEDu6Sb
         WQGTe2/Wwt6ceMyHT2M9BgefGT9tFTcz0dC6klxnPJmwhzYsOj0ZCNISj0WGN8EbPBos
         yFvy1iRA5umbzCF9qE9lRT55abdrTOpKTlqczA9r3YMK/DyhuoiOmPbspktqLcMP2b06
         5FI6a1BfitTq2fLW+uBbIACQPERtPaq2g3GBUIjv57zWvvE6M/Ze1Np/vVxyZgctCSh/
         0Ovg==
X-Forwarded-Encrypted: i=1; AJvYcCXNspbkSFuHT5Dj9ymZkMIbVtOyLfLP45KUN1CzKBs+jDrFlrT8X7LPYPEOFh3UOHpdGGLiNqIjgA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyOv84BH3W9dZciOJcBvzwGFw/6zrVifcE4TuzupLVPRHwWxVxo
	AThmIjhNci6+Z4nD+nAOOv1S631t5NnbH5Ihnlh24+qaho/Q9OauCPuv5l8PEp1pBYhL3zf/sT+
	DWVJ9IG9PF6ovQxx00+2XvmQtUybAwlNOmxoUhKFcGADSpvseFofuDAw2ZXbyXToGpSyLsg==
X-Gm-Gg: ASbGncuTpkztBDqaCYHoNaSiF956JXXWbwBFkR9fP1h2eRqvH1QcxO0kpJ4O9ddu/+k
	U3kVurCZuN27SP5pRG3LfN9/8KnMVRtncNiYEEbiq5QxjFbRfD/1wR/vl+M8VDodeT22YHz3qP0
	lEkFOzw3mf8dh56yE3MuYuuvDa9oFYP1ar+cqr7Oikd8ACHFLLSMPQGVVVovShMGZhkaVclbbQY
	i0ocYMbS1Dhc5ERd9Rb8GS87xMpQC4JZr5GRoPuyoBk0i1yZf1r4KqBYSUwCxu+HH1S7GrTedIk
	R6qH7NKoevUFggkEf7TNQLdnxP9kN6p+e4SpRdqermJMizRH/mcn273aXBy2wbi86EcaM2xiA6x
	XTX5LS7gSXoyLXUrspuu4e4mfl0/Q7ap0j+OOjJhb3zM=
X-Received: by 2002:a05:6a00:17a3:b0:7b8:349:1b24 with SMTP id d2e1a72fcca58-7c58e116e23mr43694596b3a.22.1764692893464;
        Tue, 02 Dec 2025 08:28:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHSdR8VuHYkpJOg4GE1uXEpIu4TsV+GKdVb8CClpuTD4Tkj7jemoSnPQmqSjEGbPVh6mWu9ow==
X-Received: by 2002:a05:6a00:17a3:b0:7b8:349:1b24 with SMTP id d2e1a72fcca58-7c58e116e23mr43694554b3a.22.1764692892882;
        Tue, 02 Dec 2025 08:28:12 -0800 (PST)
Received: from [10.216.21.13] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d151eb5bd9sm17600035b3a.27.2025.12.02.08.28.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 08:28:12 -0800 (PST)
Message-ID: <f38fe0ed-5b10-523f-412b-3800183713ed@oss.qualcomm.com>
Date: Tue, 2 Dec 2025 21:58:07 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v20 2/2] power: reset: reboot-mode: Expose sysfs for
 registered reboot_modes
Content-Language: en-US
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>,
        Bartosz Golaszewski <bgolasze@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
References: <20251130-next-15nov_expose_sysfs-v20-0-18c80f8248dd@oss.qualcomm.com>
 <20251130-next-15nov_expose_sysfs-v20-2-18c80f8248dd@oss.qualcomm.com>
 <CAMRc=MeUoFhmxcxsvboKx1E3KCsqkd081d8e9PypuYCCiL1XFw@mail.gmail.com>
 <4f8f9217-f6d1-1321-c2be-5ee1dd807eca@oss.qualcomm.com>
 <CAMRc=MegAtTRvrxXRc1uQLn2F2-DMip-aFwz-q1JbOkny_8dWg@mail.gmail.com>
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <CAMRc=MegAtTRvrxXRc1uQLn2F2-DMip-aFwz-q1JbOkny_8dWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Br8Ya-VJKktYdRg9zu3TPOryfMKGMb7X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAyMDEzMCBTYWx0ZWRfX/FQMWQuzuxLs
 C6gosXa5WmisLqMs45aOhCFTFDXx1Szt8AUbHUKcDC4PgBvS/jy7Gr9f/Nv44Smyeo5T3GAv0FA
 caO2MnlC0rx5M75r18TLOkb6JF8o5cJKdlcAgMFwE5+KzRcyz1Cfuew/amfR8LbzUEGE0mXzW98
 P5CdWwIFkAHBYy9USs4kPUKrDphvcqqtcu48OpcDK1tHnJ8f+P8gsIAkw7YPfR7dsA6iV5Cg/uJ
 CGxSwJjhVMWV/9EEhRN29gCMcWP4FTLXs5xuOw1uK76hEw4e5O9uCLTqT5zqc8WKtlUHfXqXtUX
 abhXqrmk8gtnGo087v69ASSN8Z/ysVdresLY7t3aBBUqe7FS9H1SeDRqycM3/SjRaqpaHkdHoxZ
 p8xFbLtmqQDvdG5aQuLTMBuVvSst7g==
X-Proofpoint-GUID: Br8Ya-VJKktYdRg9zu3TPOryfMKGMb7X
X-Authority-Analysis: v=2.4 cv=EbfFgfmC c=1 sm=1 tr=0 ts=692f139e cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=z2extVIqzVdTwvkK1RMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512020130



On 12/1/2025 11:23 PM, Bartosz Golaszewski wrote:
> On Mon, Dec 1, 2025 at 6:43 PM Shivendra Pratap
> <shivendra.pratap@oss.qualcomm.com> wrote:
>>
>>>> @@ -132,9 +186,13 @@ int reboot_mode_unregister(struct reboot_mode_driver *reboot)
>>>>         struct mode_info *info;
>>>>
>>>>         unregister_reboot_notifier(&reboot->reboot_notifier);
>>>> +       if (device_is_registered(&reboot->reboot_mode_device))
>>>> +               device_unregister(&reboot->reboot_mode_device);
>>>
>>> If you bail out of reboot_mode_register_device(), you don't need the
>>> above check anymore because the device could
>>
>> We wanted to continue on failure, as per reviews.
>>
> 
> You're probably referring to this bit:
> 
> --
> On that note, I would argue that aborting the registration of
> reboot-modes, just because we failed to create the convenient "debug"
> interface, doesn't make sense. I think it would be better to just
> continue even when create_reboot_mode_device() returns an error.
> --

yes.

> 
> Anything in sysfs is not "debug". It if is, then it should go into
> debugfs instead.
> 
> Trying to register a sysfs object with the same name will result in a
> WARN() splat from sysfs core. I'd say we should definitely return an
> error if sysfs registration fails and just make sure it can't by
> assigning a unique name.

So, should we go ahead and make the change to fail reboot_mode_register, if
device registration fails?

thanks,
Shivendra

