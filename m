Return-Path: <linux-pm+bounces-16505-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 376089B192D
	for <lists+linux-pm@lfdr.de>; Sat, 26 Oct 2024 17:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E21571C20F58
	for <lists+linux-pm@lfdr.de>; Sat, 26 Oct 2024 15:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E7D13B286;
	Sat, 26 Oct 2024 15:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NwCpPHRx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D6742AAD
	for <linux-pm@vger.kernel.org>; Sat, 26 Oct 2024 15:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729956918; cv=none; b=KRrfHUhuwNDT+i6ehDxzzwKTkzdrvJo3zwbyGOLmlg25kg4bkduE8FaiR3OcfDM8HxG5Ca01PfsnoA93Tf39GYdkBuxefkWqIZIUNU5YbweTpoSoBXNwvduW0WAXrsczwbsaoNGiX1uf1zh1420w2M3nUTDR5wDrQ29z1c1HVOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729956918; c=relaxed/simple;
	bh=Llx+XPRJNrysBhF1LvN8whfiHHKOOZIgjA6bxQ7XJKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PUpzEWX6T8YFQRScwgXBpx0DnCIl7mabGIGLRpZzhsdNmsjBAC15InZf2d+VOVBL4dBWZBvRT2qbUYzoNG1dl/QheF7QSmlUk5OpNBB8eTWrJIZNZINuLxLIIzIMrgIkAe3Cd+nGWcVZ+fB5hotLfvpa6w0rDVAGNaLLfB14Aj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NwCpPHRx; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539f58c68c5so5169130e87.3
        for <linux-pm@vger.kernel.org>; Sat, 26 Oct 2024 08:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729956914; x=1730561714; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rt/tYXWIIxsry9kkJRH0JYnpXHyALFWOiwFr/jSdDb0=;
        b=NwCpPHRxEeVZKoVB5Vu/AS9iDztr0i4hl5tbmEOIoBtPw8GuZL8evHWjHNrCSCYeQl
         D34knSwnNJkyHA5oQPPIEbJvCp4hBlaBdWAJBjM0Y/nuD+Z3jo/gPySfhLntPVeAGdRK
         k+UDad4pQ31RTtf3KAbCo2kzRN/pxyLrHnW/s9LQt4A2AfiXthWTaFYskJWWBStxGf2x
         CsMrc+872BQeLlkjxs8beRwPOtjQtkjtDQt9QDR7e+TWUwfwICnj3PkgjRDalsz7Wma0
         ZTUX8n+MPerfR6tdEsmkKSiLJJCPLBiD5LC+PYDzKaRkiZTAc2JRKisERqcpk0iW6hPX
         djqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729956914; x=1730561714;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rt/tYXWIIxsry9kkJRH0JYnpXHyALFWOiwFr/jSdDb0=;
        b=RpsZyduH/WUQVpBftpjzkQZd1bnh5rHWVdUNlsBFcosUEC7lF/lG9RsYOigpg9lMVl
         RwHwfnBjH3UjKSF0zLLUYdfdjo/JAIhfUL3SdS5yfQuwua+bCy7i6+uPYC071JiXGn6q
         t65nz74yhqQQjKHnkxGqAY4NX90dd17y4wcaZNvDSbiwRfCHh/rF+/Ey0kLVsyFhOsu6
         gUoTBNktX3K0X+gzoe+MSfrSM99FmoGLpHnB/7Az0AYh3QIMdojoVHhql1euFaCWNtsr
         xKC8QUdFVns0zSTwe4X/ArECAO8QBzNr0LA5emeTWjknyP58GqigYdgvFrUYEcPbiIJv
         8NwA==
X-Forwarded-Encrypted: i=1; AJvYcCVQjf3Q4FKWQThcgghRTcBi/t/MMPQbyPgk+nhZ2LqkAE9OtAn5Gi3rBLyaNv1HdvdKym583oI4EQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YysMRx+B7v+vMSR53mGTTtL3CQyjU2z1oZyLJet66HBs+cuX3GW
	3SXdWL1UUb0TQojh84gnNZHzOYJFouYbR+N7iFpJkmj9cLTDb/OrN2O9laHJQO0=
X-Google-Smtp-Source: AGHT+IFG/neLAN94me4zADqziHHaojntKbMA0mWRCGaXwd03yz3ZtNdTkjXVSu3Tu/T9HlUdHdP88Q==
X-Received: by 2002:a05:6512:1108:b0:53b:1f59:dc59 with SMTP id 2adb3069b0e04-53b348bac0cmr2442766e87.6.1729956914370;
        Sat, 26 Oct 2024 08:35:14 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e10a700sm534883e87.10.2024.10.26.08.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 08:35:13 -0700 (PDT)
Date: Sat, 26 Oct 2024 18:35:12 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Sibi Sankar <quic_sibis@quicinc.com>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 3/3] interconnect: qcom: Add EPSS L3 support on SA8775P
Message-ID: <bhnh2xcptccepv2sdyowmre6tm26klnfk5gunmy4lvc76pcfr6@lt7myqju77d6>
References: <20241026123058.28258-1-quic_rlaggysh@quicinc.com>
 <20241026123058.28258-4-quic_rlaggysh@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241026123058.28258-4-quic_rlaggysh@quicinc.com>

On Sat, Oct 26, 2024 at 12:30:58PM +0000, Raviteja Laggyshetty wrote:
> Add Epoch Subsystem (EPSS) L3 interconnect provider support on
> SA8775P SoCs.

Please describe the reason for your changes. In its current form the
patch doesn't provide enough details.

Moreover I don't think it's a correct solution. Using a single ID space
for an interconnects doesn't really scale. In the longer term we should
follow CCF approach and switch to using the icc_node pointers when they
are known.

> 
> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
> ---
>  drivers/interconnect/qcom/osm-l3.c | 86 ++++++++++++++++++++++--------
>  1 file changed, 64 insertions(+), 22 deletions(-)
> 

-- 
With best wishes
Dmitry

