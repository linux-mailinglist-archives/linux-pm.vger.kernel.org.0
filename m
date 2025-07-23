Return-Path: <linux-pm+bounces-31319-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A38CB0EF8C
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jul 2025 12:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68C153AE23C
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jul 2025 10:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC4228BAA1;
	Wed, 23 Jul 2025 10:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TEfu7Q8R"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A20428B7F1
	for <linux-pm@vger.kernel.org>; Wed, 23 Jul 2025 10:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753265728; cv=none; b=n0la+tdKZJuVGl1q7x2AuncCv43ZN0D0a5JyVjpEVDb7P8v00es2GzzUsluFP4nQn1IeVtFb01AN6Rb+KNqWo0IeW+/fq4W2jMONWC4zqE8SMSg7Gz2EbjGto3bo3exoFIvV9EBcAsDKWegYl7YfeZvFGgoXVOA5DhcgIrJwfkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753265728; c=relaxed/simple;
	bh=bVmnYXcNpbvjM55bFzMCxtV2rB1OTba8n+Ra95I9D4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QZ6oM+2ceMxNgS8vfuErJ1YSkpBEZy81rbOaBW0JHoVsGNJPWsJ9+Qe0T2uKd+Vvlg669zhSVZWZRhsqQ2RWjsmoJSV1bCHZRzAGtnvTFaRCXWC1AqmDcaFP1jXW6DIj7eKB5ftmajts0pTBcTzZPyxO+i3AifsT/tq/JSL9jpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TEfu7Q8R; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-70e3e0415a7so9028047b3.0
        for <linux-pm@vger.kernel.org>; Wed, 23 Jul 2025 03:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753265725; x=1753870525; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=keXN2baWTCHNPA/RphADFpl2yUS3e/Xrt6QyChUGi2o=;
        b=TEfu7Q8RvH0zoibNQleHT+ygvWvBbCNx1xUDEkeSzF68IvehmMfFa28zAX7LIqrx9k
         YebcXIKlkvbjEtvZhOiaEAl8IM35d+5ZBMvkksUwKWjR6KGWeMmsi3v6kAFREU7ZOW1v
         qKGy6d5iaBX9aW1pCPKV3NGdesIrS1lhduuv9INHJgtZ5R/WFIdvuOvxtFaez5Twhzpn
         21YzpQ0lebX828JVevt/kYGmM2vEwFELD25Lez+otiA2lCVcAMCKFwu1iAU4z+jMllm5
         JPV2wxw1/K1YjqFh+aJS1R1Ra4ytxCfYpR6ixAg5yjKNyjLqa6QPBiGSA/u9IB63NcjS
         ekpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753265725; x=1753870525;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=keXN2baWTCHNPA/RphADFpl2yUS3e/Xrt6QyChUGi2o=;
        b=Nc8t5abhmcg2Lb0Xdrexlj+prVdvVa0tqWg76TzrnmR1p7ibq6/46Bp7denK5/fFQR
         mAATcMNrK9OIAiuAPg7+SRDtpJTMHXbRfMK4oUN4JCU4X04fTx0vD9lA6tGMM7Wk/ERO
         iPWWoRl7FtvtVmifGnX00EnG+chB3yzNN3dVT7BNBJEXl5Zed1OeZ226PuDu9mj5Y4Mf
         ehSSuHbv/TSC7kw5qa62XC7BMoR1WFDAVycrypTZgP639+9rriGjCupdc6AkY9PvlJWp
         f/R3Jl18ceto4Qwscn6gIWmJgoIvtfAz6gtZioGkNOir0+b85zawR5UA5cYHeoqD9skd
         0Dew==
X-Forwarded-Encrypted: i=1; AJvYcCWIfvuRhiy5kl6TbbYi+PRWQO4mHVnxXx6MGC2S2xUA3zhCl0bHEid69+tmBtD8gDU3Wni1kMixKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6C5lnZE+4nrjguvylvz/vWJQy5ukcaWADLLfzhHV4iyfozNKE
	0NeavJzCGAcNCuyZvy8daGs1ejeMR8e8/aflWY35lECpXNN1lcjLaJO/x93kNWeVZmkH6cWjKNF
	ls5DMZEyis4jUjuUntTjIAtjvYOhwYea7A38JuqUqLQ==
X-Gm-Gg: ASbGnctyBaimO4kSr3eQKCOE/Gt3N040o/d1qr0goJi0CE52/fYtHig63qyx2FgTiMP
	afoNvvtIMq9rGFTmuxSDehdeEVkit09Dd/GdeQc4x6ovZWY5Gp+AwPyu47YAjHY40Vs8sT1y/b3
	Y5uKMRtBP99newc8pZ2mutNVQhJjRPlABYNKQ8Zv1p9nEjz2ukvQ+gVcP4eDUGW6PH+XVHlI5gx
	2OT4lyn95CPSlS0gPuZVtMfgoP49gO+KO3pJMMyLA==
X-Google-Smtp-Source: AGHT+IHLwbDU+l6YFqXq+ZhOTIt3EsG2LfI9gk0yhItHuQJhFHjnzjhqd5q6F+kb9kyqNAhw6q+3Ha0RnPN1bk1gZLw=
X-Received: by 2002:a05:690c:3704:b0:70e:61b:afed with SMTP id
 00721157ae682-719b4b61bdfmr28060077b3.7.1753265724935; Wed, 23 Jul 2025
 03:15:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716152758.4079467-1-pankaj.patil@oss.qualcomm.com>
In-Reply-To: <20250716152758.4079467-1-pankaj.patil@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 23 Jul 2025 12:14:49 +0200
X-Gm-Features: Ac12FXwdNShN-_Kv2LQC7hceFT9DkPQKcUCw0HK3tS9vOljvQ7MzDNxnuXt3sRs
Message-ID: <CAPDyKFovVuZgQNvRUomxd+P=poy_7xSWuCCwyTzhy88mJtcyqA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Add support for RPMHPD on Glymur SoC
To: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Cc: robh@kernel.org, lumag@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	konrad.dybcio@oss.qualcomm.com, quic_tingguoc@quicinc.com, 
	quic_rjendra@quicinc.com, kamal.wadhwa@oss.qualcomm.com, 
	linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 16 Jul 2025 at 17:28, Pankaj Patil
<pankaj.patil@oss.qualcomm.com> wrote:
>
> Add support for RPMHPD bindings and driver for the Qualcomm Glymur SoC
>
> Kamal Wadhwa (2):
>   dt-bindings: power: rpmpd: Add Glymur power domains
>   pmdomain: qcom: rpmhpd: Add Glymur RPMh Power Domains
>
>  .../devicetree/bindings/power/qcom,rpmpd.yaml |  1 +
>  drivers/pmdomain/qcom/rpmhpd.c                | 26 +++++++++++++++++++
>  2 files changed, 27 insertions(+)
>

Applied for next, thanks!

Kind regards
Uffe

