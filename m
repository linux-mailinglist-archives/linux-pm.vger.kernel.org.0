Return-Path: <linux-pm+bounces-7039-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C10638B1752
	for <lists+linux-pm@lfdr.de>; Thu, 25 Apr 2024 01:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15E21B22031
	for <lists+linux-pm@lfdr.de>; Wed, 24 Apr 2024 23:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5574416F0F3;
	Wed, 24 Apr 2024 23:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gAc/Ji1T"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CB916D9DE
	for <linux-pm@vger.kernel.org>; Wed, 24 Apr 2024 23:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714002132; cv=none; b=AzDDpnEAp8jua/d1NEKOcIQL+6Z7HqqlAszkf1YFMbAuMdeqSwrLnoMgFquV1dXsG2Xrc8hi2bHvG5AVXkG/VwbjkIZZtNuH/dqK/xxsME3YcTNyl83Q94eUJAHLx7mqnCi/0Z/+3eu0eYrZX5iD9YSBpXmDHieIXE7gUj5HdiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714002132; c=relaxed/simple;
	bh=PI+JeQg21yVOePuaS0Iw7b/7W79QBq8ROcxLJNdsIlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tUhc0Hj5MdPUm18j68Wx0WQAlR8J6DNAAqxSQRjEDjNHHm8EMaXkRTH2BM3xkMwPVjJ9tRS8rq8ouaTClFmxbLHbwlFGsuohUAaOO0wpz8Bfs32e9HLYAQbSfEPLcvORf2h0H0nLuqUMhguSX8oc+T7imOcdrCQoxjn3yWN3DH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gAc/Ji1T; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so488333276.1
        for <linux-pm@vger.kernel.org>; Wed, 24 Apr 2024 16:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714002130; x=1714606930; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3di6KRuk2RHSbdtvrUmozSSvs5i2WcfXE6+Fo0L3m8=;
        b=gAc/Ji1TR7JadObuMUESXqzZx/R9pYFyDyHNTd3em+uf9PVzR/EhWXaR+C6yX3+ev5
         gSuJZIItZu0pVHWHtY+5Jylrye3ORAuWPBv7Djlv/ph3ATrmlbDrxeL5drmtg7o+WsKT
         4zkcd/oeWIQqmLx+bDlrwdpQF2f7of78zwPnB/VwMa5eiGs0YJEIJ8rrhc+/9SS0dbFc
         rMHL2hhzI+9JjqmHid4TLreic+X9VG8Dfv6hMUxcPXeg7rCRHIf51f3mS8WRJxrdzgqF
         e+RO64ncTpeK8SjJ8O8zKcvChhV/PvYOHZJsfiD6x9Gd48sd/Nw7OfoUqU7TGUYPTUXb
         M5hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714002130; x=1714606930;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y3di6KRuk2RHSbdtvrUmozSSvs5i2WcfXE6+Fo0L3m8=;
        b=FDB+yuCvYIP4CORf4NoUS++TqX1r/eb5TJAZ5aO2Q4a+w3kkdeSeO6nocpSc4r4pxd
         yBpXIhl6A8wiTrsQD7BjuPMIYHKd6AxV0yD9zC+q1i72yGCiFyJE/IP87uEZSsK87l5g
         HGdP7+1AcrCJuOjYekqSOxjE8CwIJoN/9eLoOfcyaEbqB1j48rYKdyXUVJQOzLNNRGnL
         gBxjywTc4Wz1Y7PTrQ3U5KCcnFPiUxSLnP+Bwe35XENgV15SQx1487D/YO4UTCJ44A8i
         TD5BEUPFt24WY1DVkL3GLX8wsxcGf45Gfkc4upWyY2DqXDxoyw/P2/f3StE3Dy3pO0Y5
         8okw==
X-Forwarded-Encrypted: i=1; AJvYcCVpTiEwbSUPyXtMIATF6VXG8ULUnHzrmaHpuHhperbwUyEKFhoOzkg4Ufkmd6/u414NkMWKbDmqmKeb3YXwf80ZPVqdIQ0MJts=
X-Gm-Message-State: AOJu0Yzuqqx7KcyPCWKZ3vO9ex5mbMWFAyUTcMflmwqDB5tBFppFNHg9
	tgR84aKKGJfpHwAxjLX3W98I0uTDqdGoTH/A8AaJTCbEkl8MyII9BR5POx0XDFxvlwJ5cOEv//I
	GSvJ+syde7WUMl6ca/VljEfVEQ1WtLVVmkgVvoA==
X-Google-Smtp-Source: AGHT+IFNoEoWuTCW+J4r60ygLSWMpFSH9Zo3V9Aq2hPRxkt1QB/fN+kZPsxejKNUHrSBHusjPdMi8tBWqcJwR5uPFYI=
X-Received: by 2002:a05:6902:526:b0:dc6:ff12:13d7 with SMTP id
 y6-20020a056902052600b00dc6ff1213d7mr3280481ybs.60.1714002129912; Wed, 24 Apr
 2024 16:42:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424101503.635364-1-quic_tengfan@quicinc.com> <20240424101503.635364-3-quic_tengfan@quicinc.com>
In-Reply-To: <20240424101503.635364-3-quic_tengfan@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 25 Apr 2024 02:41:59 +0300
Message-ID: <CAA8EJpqGub3LuFPbwcA-MTYN2kY=94YXe=T3-mewYzxgcF-ZMQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sm4450: Add cpufreq support
To: Tengfei Fan <quic_tengfan@quicinc.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, andersson@kernel.org, 
	konrad.dybcio@linaro.org, manivannan.sadhasivam@linaro.org, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Apr 2024 at 13:16, Tengfei Fan <quic_tengfan@quicinc.com> wrote:
>
> Add a description of a SM4450 cpufreq-epss controller and references to
> it from CPU nodes.
>
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sm4450.dtsi | 29 ++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)

With the next patch being squashed in:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

