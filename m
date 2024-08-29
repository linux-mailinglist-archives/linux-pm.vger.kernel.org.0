Return-Path: <linux-pm+bounces-13147-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 432759641EC
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 12:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADF18B2553B
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 10:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFF91AB530;
	Thu, 29 Aug 2024 10:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KSPUNarM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC2A1A76D1
	for <linux-pm@vger.kernel.org>; Thu, 29 Aug 2024 10:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724927088; cv=none; b=jKzEZgnBwt0C3IlgkO7wzaUCmpNkaGMFgh5/Xij+lHFfVlDgUJqhDmz/lnrValFH5p44KUQP46af4F2qGMeqFWo8kGahxyXjIRPkEek9T375THxhy/iCwCHslBitxd86zUd8wDeWs2IEW0PseWf7ZuZJyjzNA11I/fLOE9nCWzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724927088; c=relaxed/simple;
	bh=85nAiCVJwW62QrE2b6r88lCjF1lPmNgCQtLklbdsK4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YWXGhY+uQsYujfBkQiPhWbjaXI0kMANebX8pwy1xEpbbL1M02KWPNQPMOkWHhgf3S1xWLuzFPU/ZWcYdEJdn6yzlxDoRQK/x7Xbwp5csHsyFzoHHQzYkWJB7hrEsF1innIzviIcuKyUpI35MTqwF4da9ZG1dBpasNmoCo+GG3FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KSPUNarM; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5343e75c642so629298e87.2
        for <linux-pm@vger.kernel.org>; Thu, 29 Aug 2024 03:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724927084; x=1725531884; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SZ/w73AaDcXnHgRTfa/18n3sPpKrgC+SUsJfs6EyD5I=;
        b=KSPUNarMJxv5QF+730guNrvyHoQkZCBq0izZixImJvYwS8swJucGebck+DqRrcvEd+
         1Zhoqru9l8sff4ARw0pl8SX1yTe9deV/n+7U56h/FmI75o9rkOlPhXifwW+6YmPo9g8n
         /i8OGOrhfrjETC0+40p4gp9+Jqobos5ZXPp0Ot2qmwFKD+vsaH/TqcFCP/vDplk56S7M
         WPWL/QyLVPshstO2JkjLY8VVWW2d46uOP371sfCQw0T6b3WFNFj/L4yJA51aUFkCGEdo
         kyTtd6lNk8lHYnDHq87cLRxOrxvLGq3AlO7Gwqai+O0r4SJrNggHDpOE8Rub/WLXRbIo
         md/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724927084; x=1725531884;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZ/w73AaDcXnHgRTfa/18n3sPpKrgC+SUsJfs6EyD5I=;
        b=aGdSsDHNO3aGG8lYmcIbpugiLwpO1wBO++45pMzNQLlMtYRKiwuC50VA5N2Uzu1SSt
         OfHyuooV1EDxfbB4GcJMeQSJf/nan+SHsnA2kKT295obUe7lSjYiBhj8alYSR91OdVrF
         lPklACLhZ5qfXPhtSfyNuIgCadH+4VVz12Yw9H4NVk1XmiY23+vTQE4UtgL0Kdjbzq1S
         uL5Ti/JEd7tkE58pCG4uzF31X8ZoILgJCHYoy7UI5iyvnidzeUcBqeC6GHwaAzbr3E19
         jiJTZRvmmIjsusFuCW49nlLboiSFZaTUW9AMP1sOZRMA2hKLIHdEgEfIUh3Y6TLAhY+p
         UwFg==
X-Forwarded-Encrypted: i=1; AJvYcCXQqpsiF3fChTaRePbM4q7awZGZm1gqP7rwjDcYu+hZH0dNBCmnMWT7vR826rkBWtup2kHwlpRT5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9fHJsz/OWIjTfwC/YnlVxKws5L3KCLhBElBEgrF6lPYPI9Szi
	VZerSiur6Weqie6Uczbx8mp70VJa3/GSiHgY4nD+9a+luz2mpr6cRbBgdoCTLHQ=
X-Google-Smtp-Source: AGHT+IFvU8hzzwqySK6Z6GUIQ8oD4NTRyF61j/91mZyR2mOx6xG0K5M+rBICRiQtcdWNMlY5YDmVng==
X-Received: by 2002:a05:6512:b0b:b0:533:3fc8:88b1 with SMTP id 2adb3069b0e04-5353e5bf859mr1504710e87.54.1724927082870;
        Thu, 29 Aug 2024 03:24:42 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53540840f44sm117424e87.202.2024.08.29.03.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 03:24:42 -0700 (PDT)
Date: Thu, 29 Aug 2024 13:24:40 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, konradybcio@kernel.org, 
	catalin.marinas@arm.com, will@kernel.org, djakov@kernel.org, richardcochran@gmail.com, 
	geert+renesas@glider.be, neil.armstrong@linaro.org, arnd@arndb.de, 
	nfraprado@collabora.com, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v5 5/8] clk: qcom: ipq5332: Add couple of more
 interconnects
Message-ID: <kscjtfse3rkdg2sp2uzxiueadf5l66g253vrahfir364yk57lv@jbk4qfbricxx>
References: <20240829082830.56959-1-quic_varada@quicinc.com>
 <20240829082830.56959-6-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829082830.56959-6-quic_varada@quicinc.com>

On Thu, Aug 29, 2024 at 01:58:27PM GMT, Varadarajan Narayanan wrote:
> Update the GCC master/slave list to include couple of
> more interfaces needed by the Network Subsystem Clock
> Controller (NSSCC)
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  drivers/clk/qcom/gcc-ipq5332.c | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

