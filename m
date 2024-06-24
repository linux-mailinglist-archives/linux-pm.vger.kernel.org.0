Return-Path: <linux-pm+bounces-9863-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92ED9914215
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 07:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3B7B1C21C13
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 05:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438C217BD8;
	Mon, 24 Jun 2024 05:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VoKOy9wz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868DA17BCB
	for <linux-pm@vger.kernel.org>; Mon, 24 Jun 2024 05:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719207347; cv=none; b=qsV5ZOLVqpWA35NA9DZ3C0/hB+yE5o7WJFV7/epTrM+TsXdg14eDs1vPS9OEQizKNaJdx39Us8qOXpIPa30O4dgbuo+PEiRDcCoLxLtbPW3+0iOX6JAeEfxr6g+fJAeYN7GTOSdphClCb0L7Vm5/FU1VlYkgXBZbMNZ3kmZZ6l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719207347; c=relaxed/simple;
	bh=tL4uu5xG9IpLZLy0hCoGBu/tiFpjMNGK6FbGRFIu9pY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ABs37W8AsTGvc3f3xpf8Cr1Ff+4rvWC+VbD5GGTYgpDlmu0PpYcTWruFWlO0dxprKCLE7TfYbx6tGo6gadpadRMz7/lCQp7NdD8FOrV/dvyrb3oRkmEceeyXunLcx/bj4/aTW4d93aHvCLpbA+VKnLhMioFxJkIMxyooPG7Xsu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VoKOy9wz; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52cdea1387eso1579276e87.0
        for <linux-pm@vger.kernel.org>; Sun, 23 Jun 2024 22:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719207344; x=1719812144; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uXt831VOucXeBGOMZLVEq9KmUHZ7mdnZ3c6OLXF1pJQ=;
        b=VoKOy9wzNbuO7AXMdpbBpiz298vg4heTuEtBX7OGxAKL2wLQWHILDRd3FcxX+Wk/Qi
         4UNwgxPIy6XDgiV/e3pxWv8rrxwcMi9cWZrM7wgIYhbowZqxCeWGd3/CYoKrJsXWAOwZ
         XkovlNEUOBVQ1Bv+GU5tobB8tV0fWRDz03NTimIO7H4Sl7bPaDtnQO3UEz5sY93TOTNr
         pftcHPInvcst+wAmtehzNDhwd4wM81RCtfvNH3PspJeHyLBt/E/Yl5N54wjx349uVyvo
         qAckLNQdUP+8kj2xo2c/gH/PDOE468bWVY3VFuMCCDXsuOFAKJMR41j0hMG5skqWfvBs
         iykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719207344; x=1719812144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uXt831VOucXeBGOMZLVEq9KmUHZ7mdnZ3c6OLXF1pJQ=;
        b=wnpgHv+V/dPDDzHaLQoWaf15zTPbKHRUcT33p9GJmlXCU/r+oaLz8AgnxXKeM3WkTu
         bVpG18Sruzw99izTH0iulJBIJSU4JkhCfz5+QPTLv93wdhfB3jEDoW8cVMhE6wx5q+Gc
         I3gtVcYhEkGwYKWzS+efA5S5OfaGqNTCNAy6Q+0ebB/KDqWq2nU0LqC8YUVx0u50XsgS
         SEk5sQeB2zLW6QUiNks3jZnL2rp3hSvAY005MsrZyTL+cpUJSPhjO+suTQbl3F6GYawo
         QLG/1pvjScT1T3JPAY54eu8tuuLprA7d6zU7YSYV5N6CEvx9UplLXGR4Cw9nOrwsm6Iz
         b1pQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiioLdGEhI/BoX9DENq/IuxoFI3D6s9UV0Y4M0FQIvuqEHM+GPgza9+9yYBDPXDFmmD8d9zk1ChQ1QTwwJCUzouQ2BJeoc840=
X-Gm-Message-State: AOJu0YwDKAiXOPkYyXrvUt0rQ5Q+STJ2Nr2L63STAD+LVxy8o/CL4Jxr
	9ZzMEwNfBVDU7j/AJ2ACxBKhjilHy9+PFgaQ0NSMhoWAAYykZzytrM1LBkXY6Z8=
X-Google-Smtp-Source: AGHT+IEtOtRS1h75iYfHFpZGCy3R5aFkLtRU38+6nWkEn2DerH/6c2kvfaOl1tHVW4jANaOgesxImA==
X-Received: by 2002:a19:e043:0:b0:52c:e121:c927 with SMTP id 2adb3069b0e04-52ce18647f7mr1944648e87.62.1719207343703;
        Sun, 23 Jun 2024 22:35:43 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cd63bd790sm899580e87.93.2024.06.23.22.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 22:35:43 -0700 (PDT)
Date: Mon, 24 Jun 2024 08:35:41 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	angelogioacchino.delregno@collabora.com, andersson@kernel.org, konrad.dybcio@linaro.org, 
	mturquette@baylibre.com, sboyd@kernel.org, ulf.hansson@linaro.org, quic_sibis@quicinc.com, 
	abel.vesa@linaro.org, otto.pflueger@abscue.de, quic_rohiagar@quicinc.com, 
	luca@z3ntu.xyz, quic_ipkumar@quicinc.com, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 5/7] clk: qcom: gcc-ipq9574: Add CPR clock definition
Message-ID: <cso2vpnfn4pzppil4ojmqzlus4uxnozejfe6rpobxbyy6k7gbe@4yify6sgcujh>
References: <20240624050254.2942959-1-quic_varada@quicinc.com>
 <20240624050254.2942959-6-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624050254.2942959-6-quic_varada@quicinc.com>

On Mon, Jun 24, 2024 at 10:32:52AM GMT, Varadarajan Narayanan wrote:
> Add the CPR clock definition needed for enabling access to
> CPR register space.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v2: Add rbcpr_clk_src to gcc_ipq9574_hws for registration.
> ---
>  drivers/clk/qcom/gcc-ipq9574.c | 39 ++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

