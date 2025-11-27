Return-Path: <linux-pm+bounces-38774-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A594C8DC74
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 11:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B9D13B0674
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 10:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650AF32BF41;
	Thu, 27 Nov 2025 10:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kF19TsBS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bRItMzpK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8317532B988
	for <linux-pm@vger.kernel.org>; Thu, 27 Nov 2025 10:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764239558; cv=none; b=IFHErL2oYgymVlazuXR/gIu61Sx7geCbOlOX0TqldOaO3AXj6Lwk2q+Kg4po5YPvcXLxGEFSb9htCCDEoBQBywG2w1HvCXiH5Nrqdocj+FpySXUqrQcB+QGsPTSBEGTIz1TpbgqF05heeJGaxJaFy7tltASOy6aOOZPkl2x2BZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764239558; c=relaxed/simple;
	bh=2CjRwBB9Yb5dLLTv5IaiNjJgQduCZZvkph0bLa59hH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PauNYOPMec2hTXiWW7NqJM4P2Ma0HF/x5sBA7dEX2MGNTLk9Ys3CZTswEDdYw+V6H6ptbY4TwoB/ZKVlmEFOgEH4FrReN++qkFvIulrVkASw6jAqLouEDeyjI+H0+u3HAQYeeFhI2hoT0Bue7C7fSW5cRQlcnrI9Dijp3aYZq3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kF19TsBS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bRItMzpK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ARAW2hY913930
	for <linux-pm@vger.kernel.org>; Thu, 27 Nov 2025 10:32:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6xBzaMOhRUmv+QMOjmwVE14dkxJT4RBhHpsCsNUiky8=; b=kF19TsBSTllKIdK1
	QvAdDam4lYKmnwttabaT8sIZu+d7ptgDSq8nhU8HlLOY7fPtwzfeTstPXFsr/en/
	qzARb86jgR+MczUhNi10cFegBtG7Pu1iiSIfijv5rT33Gt0EqBwzHu8Vn3Jx6w1g
	SeQ6yhLe/v4KaQEx5m5j6H/4+kE7bzKJXl5SUk7UlAvbePFKqCgi6fihQKHdKVnI
	TOUjM1U2hppAJbUmYVQLjdNqldBDhb++3KVlFN55iYXEs8rmiJF9jE8qXqLmtYJ2
	33nuZMzdYeUdWkd/4Cfs8zg4APNpn0RnT0+0YtNfK8+4AZ3wXq+UDMzCr5j+9qfr
	b8ihgw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4apmynr02u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 27 Nov 2025 10:32:35 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-884821f01a2so1667316d6.3
        for <linux-pm@vger.kernel.org>; Thu, 27 Nov 2025 02:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764239554; x=1764844354; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6xBzaMOhRUmv+QMOjmwVE14dkxJT4RBhHpsCsNUiky8=;
        b=bRItMzpKDh2RDw+ZLW8UYYnJiGqhjQDiPraZPGKDqXSt1fJmlcZmRUwqmHJ3PuZdsR
         4/PDAeR4cpaSDb4Ls/i0nEANPes3lVUyrk4pOa3yTRtMwU9UNUOdb8iJFg3nlsE5Qntn
         PHHN2OfXFoNpmjfflq18nwFu64qtNXv8Jr7GZ4xP8wS977HNeGYCjUf1a3q1cazIEg52
         DwuPlolG6JTMzXg3ligPE8v0S5R2nLQ5agyEIqRKBxDC/4syCGqXlI6O2wNT49jnx7Ys
         5mbHL6J1gFFy/1ZCTFcjEHWhILl+xT9H5AzepDHG+6glyYFmtV7AACYkYoDumIxaaA++
         VYMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764239554; x=1764844354;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6xBzaMOhRUmv+QMOjmwVE14dkxJT4RBhHpsCsNUiky8=;
        b=I8cIfNB6fd/s36v5zy2k8VwT2JXkj8xz6M2IUtHahiw50CaqrOsBL3Ck9ntNbW9+bF
         GdSBHGw0643NnwtE01m1dmO+rgqsjAclIPwFl3D5SBW6OQq/lxsP8teZahyKd8IRDaXx
         9iSQ8cLolyP3GpbL2aLexW712xbQwVu8PRTeB3N+0bpQ6e3S5E58Jh6eRyzq7G4mSe0B
         xZMNMSqw31vso6tC1ovf2dQVE4al0SDIo6LFYW6xrDzwfuCAT2KIsG/yjjYjk9ofgmfn
         g59DE7lakajTl3JbRvL2SFfj586mk6NVlMof1hO7sHmRIW87BSMMekWhdlef5XFx+nVN
         fdqQ==
X-Gm-Message-State: AOJu0YzzIotdwa20QBqY5CYNUNhtQ/phIzV3btyzrCsljfqjk18H1nna
	8yavDPhMJ4uyCyf2WGjhwXfKTnxWvARXlFqgb46kMJvQ2VsmnqzLCGJ5Ee72reD3djVgayPRXzU
	0u9rCeAGXgpOCCym2A5x0fT84z5xnu8lGHAwo0qylMiZaf2pYPc1QJgNvzEM/2A==
X-Gm-Gg: ASbGncsWoxVtAOmmuxHyHzFXyXaEXrxAqRQSoK8mK4k8Ux1tMbFaqAJgDAUPK1Hlw5Z
	+3Wdlnfd7D/lXgPfhlB6SWrrsvC+xZ5LhRqRll/Qj7QYmYUb7VxClYOAkrJe0E0Tym9CTlkz79/
	lDrVTDguvPX5gEbdZbT4kNkw/W5Ry6FR8BOZ8AsUUI0leVj/myTHQB7Ya4DzdqJmMqrxQnAkI3T
	9rpnwTjZMMTzAqh3y53nGlXlG0m5uafevrTmPGLPoe4wpfGQ0r9J6XkF+GxbZXM7Bchu9YbHabm
	DKbGSBJ93TH9uD/bqi/ZhKqu/9nFjk6Cnsus7zDtOvq464wINGtjEzmnNVRSXrJXpXe/0IBSGv/
	Zj8eEgNOdCRjXsg6BJtHVfw+Us/kS9VaUu0VD66rlzPOmlgMrhuBTi9rRk4RZhC00C8A=
X-Received: by 2002:ac8:5d14:0:b0:4e6:eaff:3a4b with SMTP id d75a77b69052e-4ee5b5eeeb3mr235846731cf.4.1764239554366;
        Thu, 27 Nov 2025 02:32:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHvuanT/+hsUReTNJmLheq6TefU/W/FUzZJ2Xkcj7pCGcJhY8sxHtZhKpW0cam2ypvDgTBDTQ==
X-Received: by 2002:ac8:5d14:0:b0:4e6:eaff:3a4b with SMTP id d75a77b69052e-4ee5b5eeeb3mr235846561cf.4.1764239553880;
        Thu, 27 Nov 2025 02:32:33 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f59aeb45sm124438666b.40.2025.11.27.02.32.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Nov 2025 02:32:33 -0800 (PST)
Message-ID: <d9822a0a-1256-46a0-9bbe-8b5c68efba4e@oss.qualcomm.com>
Date: Thu, 27 Nov 2025 11:32:30 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/8] dt-bindings: power: supply: Add schema for
 Qualcomm pmi8998 fuel gauge
To: david@ixit.cz, Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Casey Connolly <casey.connolly@linaro.org>,
        Casey Connolly <casey@connolly.tech>,
        Joel Selvaraj <foss@joelselvaraj.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Alexander Martinz <amartinz@shiftphones.com>,
        =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>,
        Richard Acayan <mailingradian@gmail.com>,
        Alexey Minnekhanov <alexeymin@postmarketos.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org
References: <20251124-pmi8998_fuel_gauge-v1-0-dd3791f61478@ixit.cz>
 <20251124-pmi8998_fuel_gauge-v1-1-dd3791f61478@ixit.cz>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251124-pmi8998_fuel_gauge-v1-1-dd3791f61478@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: OaPJ8m34sgDIP7Q9LZHqEg3uBYDsuYJS
X-Authority-Analysis: v=2.4 cv=QOplhwLL c=1 sm=1 tr=0 ts=692828c3 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=sfOm8-O8AAAA:8 a=OuZLqq7tAAAA:8
 a=RJeynrtfwxJuRQOpeUsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=TvTJqdcANYtsRzA46cdi:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI3MDA3NyBTYWx0ZWRfX322dSnkJRjIM
 vUrvt/EqsLJ6iCp+gAV9uSrgSoWr7H37089XAEw7vD4xLkmJy4aXCujVrjHcjX3w3ywlMlIYI71
 6ojG4l8TUCOKHVP9m56owjbf6pd/yadrHQ2GeHR4ycWHMIqezO7V6w+oL0g3VZMcnVbpY+/stnI
 hHwmXz94SuK1+/lvFPknDTdLzEFFImcRVyexFPvVc1GfrSUJ5snU/Uh9DL2al8pNk8nkWoXb9FT
 8EV941SNY2NE+sOK0J163ZGO8ygHlWE1S3TlR5T8vPBt/tD+CYjzVLbtRKEOGCIITslc5i64yQc
 P8OxQ+UOHz7XYimB3kL/O/BE4xTvln3Vz8yTEby7BXStdz6fVbP9AQnicvdUBwWQWNrbuuKwiou
 M2TI6/wLfK6usklkzm2xZa8GcnFwTA==
X-Proofpoint-GUID: OaPJ8m34sgDIP7Q9LZHqEg3uBYDsuYJS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511270077

On 11/24/25 10:53 PM, David Heidelberg via B4 Relay wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Add a device-tree schema for Qualcomm PMIC 8998 fuel gauge.
> 
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---

[...]

> +    pmic {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      fuel-gauge@4000 {
> +        compatible = "qcom,pmi8998-fg";
> +        reg = <0x4000>;
> +
> +        interrupts = <0x2 0x40 0x4 IRQ_TYPE_EDGE_RISING>;
> +        interrupt-names = "soc-delta";

A (much much older but still) similar in functionality, the PM8916
BMS block has 6 interrupts.

pmi8998.dtsi on msm-4.4 defines a total of 16 under the fg-gen3
megadevice. I would assume that at least a majority of them are useful
and/or required for full functionality.

There's 8 under 'fg-batt-soc', 5 under 'fg-batt-info' and 3 under
'fg-memif'

The main node also consumes an IIO channel provided by the RRADC

I'm not asking you to implement all the feature delta in v2, but I
will ask you to assess what the dt-bindings for a complete solution
would look like and to fill in all the resources that will be necessary
down the line, to the best of your knowledge, so that you won't have
to wrestle with bindings updates with every new feature addition

Konrad

