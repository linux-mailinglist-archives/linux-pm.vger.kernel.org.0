Return-Path: <linux-pm+bounces-13187-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCF0965043
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 21:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C21A28B2C5
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 19:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390901BE873;
	Thu, 29 Aug 2024 19:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOMCQ/VQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A68E1BE868;
	Thu, 29 Aug 2024 19:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724960955; cv=none; b=GX4cXAVIMfwgkbpjo5TnrrXVWDSsMaKJiMMA5YHxTT2gDkj4+ERIThdDHhklsOaJoPq/xHnfd9jE4xRM2U6s6KOkvxxxwoPzPAipGLZU+0ibff1iEWazoSoRrXcQacIKSNl9mGTYiH1MlYI2ThmuuxewiTsmoUSXeZW4OiFC0Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724960955; c=relaxed/simple;
	bh=VQFkfIt1ZFmvcgrZPQB4L0rRyNlBeXoAfBINrTFokH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B2cE+T6ETKdV6HDKWoROeiEuB/RXcnwMCd1voDT0ZxW79QS6I4ie7h5yrMgwmXXX8rm+2ZyDNpDBvYpyF/inZUTg34rqPXU3fkJhGz2SHd9PJMZYgwepPojj3/N5OiXALstjhC3m14hFG77WW7oIryyhPFIBdKZTYHgx/siQyFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SOMCQ/VQ; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5bed72ff2f2so1241471a12.2;
        Thu, 29 Aug 2024 12:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724960952; x=1725565752; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C6zTyRy44LbsV/er+6Rmmr7d7exqhqQ5s8Va18uvln0=;
        b=SOMCQ/VQpSXbRGvD4QN4FFC4PBjB6PFtgwQXM19lDbBTZhg5GeSPldyo0kBQb447Aa
         KKZkp3UBQMNAXp/eN8GK8GGXHfT3sjePnK+wUPi8mGJwaSYDxcSdzGfk1KsgTtBO4Wvu
         sgKOnMNkzaGmEhF2IHYqAqGLG07F/KhML7vfBNvZcb3DIyoiMeSxEUMtsbY9nhXXYZO9
         19KnU2uEuJVVyGQ3OBIiMIymrFxK34o7SMnsbXKCs0fBle9lycaEIs41xXog2mt1U3/+
         Xx8tJMp7/VG2rbkgv6bpCwmIHYVCTx/oIq3dRBouWeYbjRXSNH6VtLLJ6yVa0qLWWtD+
         Z/YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724960952; x=1725565752;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C6zTyRy44LbsV/er+6Rmmr7d7exqhqQ5s8Va18uvln0=;
        b=TdGfwPdVxU1XVe70IvKAiT5r9/KNtEpPBtXG/KNzJqYPQAC/QzTsvEATq0VnMDzkFe
         Rivq1QVZ94MRQXit7W4sPvM+0Pe5zwvWIVnH1PKZJtKntrXRjRnbVsVKBdMXQ9o0PpTJ
         2yMfKd3yjR6ZFbBGXl5SdqT9jei5wi3xDDfAWdrdme0RDrZsgtp+5Uxq0OGn7CcDhm0N
         XpGoV2c1pVgNW/yJgIycavDKLTR4DMWW5gyfYka07fYwpRMbEDOu996T5dYMK77e9A7c
         4P2gwd6ou/VZFg71bqK1BgyPdfcyReGjk1Tql5BuhM2woNmaYFNiIvj2JhNFpJ+mWAKK
         QpuA==
X-Forwarded-Encrypted: i=1; AJvYcCUkY72gpC5F6BuQ3egZttU3tU/A0iMvh/xMQue3iL002fr1pPjhZpthK55ANzjN096Sy16LAJWbDDVYHHpS@vger.kernel.org, AJvYcCUt5zX7klMtj+Obdhb9RpEVDHc0CiPhgzibAESo1tnF26sivqyClcSRHieHA3jOGLewZpHErKIJRWKl@vger.kernel.org, AJvYcCV5HqpylIqjZYOqj6hAGntG8amjdnhzmDb5U4rwKxs38hZVY/PjRrvX/NnwbE5vVjStoHDrxlolgUE=@vger.kernel.org, AJvYcCW4jO7zBX6P3nMaIwN8QMcqOssdOHT/MrD5slHHl93DBJO9ut/M/2sgA52y1vaFIvyr9Mqw1MCel+w6jYTDbQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSjroT426onmSIErHLFNpxezt9blzJVqBXAv2drdUbH9p+Axu4
	9x9W4rgNiHoARYCVp5Qi9OrzQuwZ4UsJ15XMUWGUviYpUk72xeuw
X-Google-Smtp-Source: AGHT+IEG6BreU15tWsvDqXfz+6NfLSYPAoFtBNvZap0mdBrmPnCL4g6PIPExiJh2Sz2VysaWO/gXoQ==
X-Received: by 2002:a17:907:7292:b0:a86:a909:4f67 with SMTP id a640c23a62f3a-a897fa759c4mr273076266b.52.1724960951288;
        Thu, 29 Aug 2024 12:49:11 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988feb9f7sm114184666b.42.2024.08.29.12.49.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 12:49:10 -0700 (PDT)
Message-ID: <159df608-e52c-4317-a1f2-d0f94ebfc25a@gmail.com>
Date: Thu, 29 Aug 2024 21:49:07 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] interconnect: qcom: add QCS8300 interconnect provider
 driver
To: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
 Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Vladimir Lypak <vladimir.lypak@gmail.com>,
 Adam Skladowski <a39.skl@gmail.com>, Sibi Sankar <quic_sibis@quicinc.com>,
 Rohit Agarwal <quic_rohiagar@quicinc.com>,
 Rajendra Nayak <quic_rjendra@quicinc.com>,
 Andrew Halaney <ahalaney@redhat.com>, linux-arm-msm@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, quic_mdtipton@quicinc.com,
 quic_okukatla@quicinc.com
References: <20240827151622.305-1-quic_rlaggysh@quicinc.com>
 <20240827151622.305-3-quic_rlaggysh@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konradybcio@gmail.com>
In-Reply-To: <20240827151622.305-3-quic_rlaggysh@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27.08.2024 5:16 PM, Raviteja Laggyshetty wrote:
> Add driver for the Qualcomm interconnect buses found in QCS8300
> based platforms. The topology consists of several NoCs that are
> controlled by a remote processor that collects the aggregated
> bandwidth for each master-slave pairs.
> 
> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
> ---

[...]

> +static struct qcom_icc_bcm *dc_noc_bcms[] = {
> +};

Please drop such empty nodes

Konrad

