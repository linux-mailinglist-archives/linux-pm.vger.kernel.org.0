Return-Path: <linux-pm+bounces-5802-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E748950BA
	for <lists+linux-pm@lfdr.de>; Tue,  2 Apr 2024 12:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E9A91F24BD3
	for <lists+linux-pm@lfdr.de>; Tue,  2 Apr 2024 10:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF495EE67;
	Tue,  2 Apr 2024 10:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fyr3C/ng"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFF0657AD
	for <linux-pm@vger.kernel.org>; Tue,  2 Apr 2024 10:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712054941; cv=none; b=JGqYItxFCw2sXzVVuVuez/PRqrCqXc+rvJlxLSm4lztQyYZ66msJZyjTS6qQZe+qhT+u9MtGxfuNT/rwn7OqHw8ncCFkgHsGOpn9nFJHR1LOfqXA0uIX2+wGfd4N2O4UE0D4Dg3043Al1deNP8tbiUaWgB+khs5YoPxyQpwoh6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712054941; c=relaxed/simple;
	bh=ntfWqHpmDy4DIMcm7CKN+FPSTquvhkckHhRW34UWCtc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mX2ysF122Rejyg+1zRs2FdcEg6QcnmAGqqW+HV060psWE+952YtzrdwSQPu1SPAkVW+heHSNfEKNus/2zp8B1igGKwbpfivtMk9oSPFwIYICul7BHNbOUiT0C0e475/7wdjU+65mpScuRYQB3X9HSxwQ20VWCROpiOSUYSJXlfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fyr3C/ng; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dcc73148611so5118641276.3
        for <linux-pm@vger.kernel.org>; Tue, 02 Apr 2024 03:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712054939; x=1712659739; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cL+6rU031lCbn4rJijXxXCPdj92d+pFHGEV2AGXf59Q=;
        b=fyr3C/ngTM2VuxuFV12egZBfFLQ4AxVeiSt2FjHUuultNYQuRd3xWWLYOn9q3mU4J8
         d1MQ+NGV6jqVWtDUpV2oE6xP+c44ufRS4UoTiZLWZR5qGp/IfZ09oW99yQDJR4DOGDQw
         BgxV/At5a2wwkuBFn11ZDArQu68DcH+UHJpQe8H1gIUmsSlH/WLA1Q/p86qdMYFyhuH2
         C1XqLR1YND2h0M/ld0sTne9OwweQ4NjxxQnoupiYz0mBDmMLs3AJ4v+57FTDSSeA8dU1
         TU+Kv9kTi2nvbtaapvwsHUkC7iNHapr+LXW9ui80qroQUBdAofRDpMmZ72BqT8WxwbqN
         azeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712054939; x=1712659739;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cL+6rU031lCbn4rJijXxXCPdj92d+pFHGEV2AGXf59Q=;
        b=D5t+Pc3EfHCu4TmyVf8GNlvcETmAjncKRrYf2a6noAX5s6mZYQq4R9HTfysy1IgnFa
         xMJRmkMdNo2kvbKAIab6K3wnzS0z7Zaa+cp0WCft8nNg1BUqQc75qpIDMLXzcm9XYZpT
         34dTpbUPa1+MhwnuWl+OavbMIhyDuNUp3Sq6UN/iRVf7sjibZlFnKly1YKSKODhSkRub
         sWtxKL9WLwe/VA46QIyCCsiJu+7SSudf+2RWtaMDfqMR2LIzP9xoYHz54xJY5YUdBxga
         XV3Xl2d25cdKbpsPU1DHiDRWbOKSUSTUxILz+/MqwPaFz/Fug26Bj9pq+Dwueas8oRbx
         CsVA==
X-Forwarded-Encrypted: i=1; AJvYcCXTQPYFqb2U6l6RarKFWiYGduuhEEQpaVEATuqZY0TXJL2ivS+nYozwFViZ5jDJPkCqPWm2BW7Mq/+PrHe1sAcDJsCmoRtKhKY=
X-Gm-Message-State: AOJu0Yyu55XGHCSH0/11u/2F1yqVLtLJlPnSFNMTGjB/oyn1AWlgXEjE
	T8kYl6bFI5obad0JBTCa4Z1FtRSXFfwT+dPCmw9vzjrbc7nNE5iedJtZpF35kH17HNdo5jpVIBS
	NSkjDODBOGfjthw9NhVmuX+XGXvI/dOQZWQIj2Q==
X-Google-Smtp-Source: AGHT+IF3amTy3mi9gx0Fg8qpLFvR2VZ42wU7eSSjKWNzlxbLx8pQTgtu/c6DCvvde5oLRreiYm6VwKWGKN3tbIa8iIE=
X-Received: by 2002:a25:99c1:0:b0:dcd:aee6:fa9 with SMTP id
 q1-20020a2599c1000000b00dcdaee60fa9mr8752476ybo.53.1712054939333; Tue, 02 Apr
 2024 03:48:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402103406.3638821-1-quic_varada@quicinc.com> <20240402103406.3638821-7-quic_varada@quicinc.com>
In-Reply-To: <20240402103406.3638821-7-quic_varada@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 2 Apr 2024 13:48:48 +0300
Message-ID: <CAA8EJpok9DzjSSt=ejegFo78zJqycs3S+bua76oXDivvzW7icg@mail.gmail.com>
Subject: Re: [PATCH v6 6/6] arm64: dts: qcom: ipq9574: Add icc provider
 ability to gcc
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, mturquette@baylibre.com, 
	sboyd@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, djakov@kernel.org, quic_anusha@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Apr 2024 at 13:34, Varadarajan Narayanan
<quic_varada@quicinc.com> wrote:
>
> IPQ SoCs dont involve RPM in managing NoC related clocks and
> there is no NoC scaling. Linux itself handles these clocks.
> However, these should not be exposed as just clocks and align
> with other Qualcomm SoCs that handle these clocks from a
> interconnect provider.
>
> Hence include icc provider capability to the gcc node so that
> peripherals can use the interconnect facility to enable these
> clocks.
>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq9574.dtsi | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

