Return-Path: <linux-pm+bounces-29395-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 664F8AE4AFE
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 18:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43C1D164E59
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 16:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CCE299931;
	Mon, 23 Jun 2025 16:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qHnlrAH6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4914266EE7
	for <linux-pm@vger.kernel.org>; Mon, 23 Jun 2025 16:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750696297; cv=none; b=Tyf6z2hWyTK7H1IAg1jPHCjOkOCDQJBHkUFj2w/tmme8UTQ3Q2yP3XabdhZry3pbOLHrmbkWTcwnXCoZwXKae6hKZ07b6m1PGBHYJvHn6VH0qC1vORBWHvlKAcA5JiTFEI+gxRv+ocPczhIRqu6C1uzd0dCoV80TyWS4TClJ+jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750696297; c=relaxed/simple;
	bh=8KsekKS5aRcVIvVUBtntQtfWkhVyoUlhEiE174K9srA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DX7BujLE0u0NlnGGTDxjQbLDFrhsyrzyAJZeV2AVDFofsPP40h7/jT5LYh6oxovPZqgsQsDBTSBgOrDS9K+yvDUd619UNtEP+l+ze1Mb8HUUh49Cw3RhhGxGCXH8CqleLHp00aFqMQ9yipsIk7e3FmSzoJeDWROeUtlAdf/RxYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qHnlrAH6; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a536ecbf6fso2471563f8f.2
        for <linux-pm@vger.kernel.org>; Mon, 23 Jun 2025 09:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750696294; x=1751301094; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0j8AmL2vgCPrh67szF4XCY9cmGpFOza5ajW2zlzTb44=;
        b=qHnlrAH65AWvyLf+ffRGDHFQlQ8UXXXXodW7rITXKEKgsBWRUUJ01Pt101tLfNdNgz
         druRmSX5U+bCqNoLkySpbRnNjBEvGhtqWEA6sZgE3faNVC1MOopFIt7aJgpedENnbgA+
         vLhT/oF+iV4NNJl7ZENbUwAqvYWH3iddwhnanR5l4wIgKj8vv6iI+GCZR6dQ89GS88lQ
         4HUQJcYLu1l64TswOFIPMbymXvof9EgYaCIw8NBp8I3/Eqx4VOXqXjnURJXJZOFsUk3g
         05y1QuuzYM81dH5UL1YrQufYoHDEwKgH0zffz4y/y13dXfC9GgNjUFU4R5cTo53tNQSx
         Q+yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750696294; x=1751301094;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0j8AmL2vgCPrh67szF4XCY9cmGpFOza5ajW2zlzTb44=;
        b=mfPyBXRCuXFhDHlmZw7uDe7CYv2zcuveUn5J4iymVkp1svQrTuj01SD/xK+WnbM+M1
         YWfrq5d/smFxAh3htSyUx3U1y/BHbNT3qXg2uQTEZOyLjF8n6U3n2UObYojJRjcT5nFM
         matqaUC9EDfGfhLFmkDgFLNlaCk0I1CPHjD4LndL3sVWD/Uq7LCYR23K060iPui+hplv
         6v6zki/JnH+hGYTh5A44+RkHWPKEDBSR9itbeXu+1+ZcgI8kJ2r+EXVxBGav4JXGlBy7
         F2E4kkh5BEzv5Z2SyuXo9mU0ow1scmwAlLqHVT8Yo/zrxeZXIu8BweImd+bmqtfzDOkO
         illw==
X-Forwarded-Encrypted: i=1; AJvYcCVr0Xo6NNlh5AhK0C0QYSjC5qoJV1GZwKFJerVi1npnxw2O1/uC6lC2BRaH6eXQnJwjjUlVztkudQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGz9eRswPjUHJeg5LvLCNYENzAhjcLCc0SGf3b7X4mFpckHnZP
	muMQAJWP2nJ0E3jCKfnwnKPrOLTGrED3fsmKznncZeMHKzcM/d/n9ydRYoyqYN04swxJJJ7k86W
	EUwPs
X-Gm-Gg: ASbGncsr/C0tFvoFOP+GYPKT266SjbffAKVM38t42S9agSxpoXO/glcbSs33gGaKLya
	0Qj8rhy9YDxleGTsA0v5xP/MGm5wRlUQpPxh33QyJ5xAlYz7aVIatq3XHefiWldx31cLsbnVASb
	0IMHvqejHqk/fuZ6+P5ihkxKRVh9zKWGKv7cVujTMQ3kaE0OuCVesRb74shhZtAHkkket7hAc/q
	tRJ9ky1lcj+cUojMb9SDfRhzKn+RDDenPi2XZn3tpw8CSN/+6PrMt8GtK5ullFcD5HofjSjVCQT
	wxByAAp6hE+q8Mm0B/JaIEdlBo5+MQ2gaR8IEtUc/c0wpfQnkNfVB7AZfYGibLOQsg2SV4RGQQk
	=
X-Google-Smtp-Source: AGHT+IFtp9SY06hL7tr/NWr3bIhdcZjACNg+h+Rg5V3jKzfHdcvWGYIa/oooWJLbVLfw9PBe9ecQTg==
X-Received: by 2002:adf:9dc8:0:b0:3a3:63d3:369a with SMTP id ffacd0b85a97d-3a6d130ace1mr9778129f8f.25.1750696293870;
        Mon, 23 Jun 2025 09:31:33 -0700 (PDT)
Received: from [192.168.1.159] ([213.240.182.16])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d1187cf0sm9786922f8f.71.2025.06.23.09.31.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 09:31:33 -0700 (PDT)
Message-ID: <48c87af4-7d42-4283-b407-697b78d5b913@linaro.org>
Date: Mon, 23 Jun 2025 18:31:32 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: rectify file entry in QUALCOMM SMB CHARGER
 DRIVER
To: Lukas Bulwahn <lbulwahn@redhat.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lukas Bulwahn <lukas.bulwahn@redhat.com>
References: <20250623081240.149446-1-lukas.bulwahn@redhat.com>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250623081240.149446-1-lukas.bulwahn@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/23/25 10:12, Lukas Bulwahn wrote:
> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> 
> Commit 4deeea4b0741  ("MAINTAINERS: add myself as smbx charger driver
> maintainer") adds the section QUALCOMM SMB CHARGER DRIVER in MAINTAINERS,
> including a file entry pointing to qcom_smbx_charger.c. Within the same
> patch series, the commit 5ec53bcc7fce ("power: supply: pmi8998_charger:
> rename to qcom_smbx") renames qcom_pmi8998_charger.c to qcom_smbx.c and not
> to qcom_smbx_charger.c, though. Note that the commit message clearly
> indicates the intentional removal of the "_charger" suffix.
> 
> Refer to the intended file.

oh dear, thanks for catching this!

> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Acked-by: Casey connolly <casey.connolly@linaro.org>

> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 41f13ccef4c8..c76ea415c56f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20612,7 +20612,7 @@ M:	Casey Connolly <casey.connolly@linaro.org>
>   L:	linux-arm-msm@vger.kernel.org
>   S:	Maintained
>   F:	Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml
> -F:	drivers/power/supply/qcom_smbx_charger.c
> +F:	drivers/power/supply/qcom_smbx.c
>   
>   QUALCOMM QSEECOM DRIVER
>   M:	Maximilian Luz <luzmaximilian@gmail.com>

-- 
Casey (she/they)


