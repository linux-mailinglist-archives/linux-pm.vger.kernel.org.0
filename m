Return-Path: <linux-pm+bounces-24132-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B725A640A1
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 07:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 513891890E0A
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 06:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5463D21505B;
	Mon, 17 Mar 2025 06:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EFsN35dg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8F61459F7
	for <linux-pm@vger.kernel.org>; Mon, 17 Mar 2025 06:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742191548; cv=none; b=mPTrpVtdCqICsuVXErCVUuZCvy7YXpW/juu6E5LZ/auZW8fkZl/NXSpbSdch9pQ+xSOtqc6hL/R1hadc5uMux8aj2OlbFwtFzYLCS0JKSfW8kdTIwwDenWOE7gu9Lr2qjBJ+f0UJgO4WtVXQ3g/PCxPs4cCovhE0XE4XZoE8hL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742191548; c=relaxed/simple;
	bh=G2vibGduTBb4ht3i3PKQRMy9Dmd98eR9I1FTyOeaPLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mtd33SvKwmKyceVu22KRsdPIynOo3M4cpu80O00qy9/cSSHlow4cD5AxdZnsvx91SARsEhVuEQreK2hRByDSzuNGF1UeL+F5l1y72CY6S4/ahPe6bAWWpVyjaklel/3uPetUuzc4x1emA86K7e0cIvQrIuf/NqkerKfio8n4gDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EFsN35dg; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-301918a4e1bso381220a91.1
        for <linux-pm@vger.kernel.org>; Sun, 16 Mar 2025 23:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742191546; x=1742796346; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=upw8uAtsaSrMPnUE86VOFztOWYUwfbafLAIdnBxyqLs=;
        b=EFsN35dgnr2o6vUSJkigYRiHu36/zDmuPUW6p9L//TW+DNHwwmZiBtIrPLdRwl8lZH
         v/wHjpxKOrJFCXJK71CYifHA1biWDfrxqLwC3od8LBX/3F6BbBtmd38eGzETqwT16vp+
         imoRg11Z9M1EETvCQWyvYJE2puBUtMPhNAeMzn+1p+KWXKcI5lvX6GZreSJNOIkb/rrY
         XbUhyUfrWamlF3EpF0iuVx9zxcHQA+p9+P2P2D4RbkNAaB17Di3nd01QAgwnYMpOREpw
         mJQCo2qUVHxUZGD07XqCPX0cTo8nXcN593uQluW+rfHj0r7Qw0lgHuVSuylVVZ/BzYgx
         VV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742191546; x=1742796346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=upw8uAtsaSrMPnUE86VOFztOWYUwfbafLAIdnBxyqLs=;
        b=wDwkVrzBu327LF4w1dap1ut4UAeklnNG1V9Y4/6AVyyyhHchdV9Qts3bLsmMrgMGhZ
         j/NmORlU3ycWGsCQc56iFouoX6wE5NR5Zaox+qS4r89ZQc9tdiLJxXTQZsAChBM+nvB5
         z3ocdmTva4nTEM5vZolSyUrkpvg60Q4OcGHyHa4MZUb3au3TflOMJZ33r+/Pc8GNiyQx
         Cwy4dsdDNZwBM8bR5V9niNu2+Qe105EEhs5JvqCYa5PJ6C5zGj6zDoDebKZqMokF9P8+
         1eqdCy04LD6utijGKQT5IGg3C2GoleWP1xWDY/BkQPVt8+IEruzgoL1A34y3mdd6L1Iw
         g32A==
X-Forwarded-Encrypted: i=1; AJvYcCV36HbN4vL3tZe0Q8RX8MsNpO1EXNRfjo47S3xLHvKQVKNAmpmnpVNq3f4Br6hg5LoDAKHPV6btHw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwtVUUmRvRpsMHHe1zuA3brNSEF7xS9qe/oUCs6q00+zb5ulPD/
	eeUBTZT0IB45oLRNhVWouVvs+cW6a8dxI+lT6n+p/gySOd13hKH+TuYsicxVWSk=
X-Gm-Gg: ASbGncs0SnQljoqWlX0lUBmDtZorJe1R+dZvQdfgCIAFgIG87zGX9FWwLlEM4X7sLwm
	kph+4uNso7BBh+LioQlxqZEbs08Im21ytdFoEc9XMDG8uRKFfMm0DuUUjib7MpTqli9eWI+9eLY
	x2xWLPZosRz5uUfTxbKhv/+NpHYmGRzVjgoxl9Iv/pD1PWiDkrLu5u4R6lsEjcPN4E05Ac3MJQB
	cQC9O4iXGvjWTR4XCMe93CWTGcX9SiLpuJS8DhZ5ZEoRsoZoxMLWon1doLJlyjjpJa7YW6/0cAk
	TgE2IrYr9DjfTaBe3KBtsfiQVZavp3H7nLe6BIhJUHDV3A==
X-Google-Smtp-Source: AGHT+IFtexjCDcyLpMQ7w8Tna8IXMKgR/Z0hgY4wOijyqJA7aak89tOVwk16u6S1c8FJcbWL2KbxKQ==
X-Received: by 2002:a05:6a21:6191:b0:1f5:7862:7f3a with SMTP id adf61e73a8af0-1f5c121e71cmr16343310637.14.1742191546167;
        Sun, 16 Mar 2025 23:05:46 -0700 (PDT)
Received: from localhost ([122.172.84.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7371152948fsm6985187b3a.16.2025.03.16.23.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 23:05:45 -0700 (PDT)
Date: Mon, 17 Mar 2025 11:35:43 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Konrad Dybcio <konradybcio@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] dt-bindings: cpufreq: cpufreq-qcom-hw: Few
 improvements
Message-ID: <20250317060543.ebqshqxngd4mhrcf@vireshk-i7>
References: <20250313-dt-bindings-cpufreq-qcom-epss-v1-0-62b0f96ba888@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313-dt-bindings-cpufreq-qcom-epss-v1-0-62b0f96ba888@linaro.org>

On 13-03-25, 10:08, Krzysztof Kozlowski wrote:
> Make the cpufreq-epss/hw schema a bit stricter for each variant.
> 
> Best regards,
> Krzysztof
> 
> ---
> Krzysztof Kozlowski (3):
>       dt-bindings: cpufreq: cpufreq-qcom-hw: Add missing constraint for interrupt-names
>       dt-bindings: cpufreq: cpufreq-qcom-hw: Drop redundant minItems:1
>       dt-bindings: cpufreq: cpufreq-qcom-hw: Narrow properties on SDX75, SA8775p and SM8650
> 
>  .../bindings/cpufreq/cpufreq-qcom-hw.yaml          | 33 +++++++++++++++++++---
>  1 file changed, 29 insertions(+), 4 deletions(-)

Applied. Thanks.

-- 
viresh

