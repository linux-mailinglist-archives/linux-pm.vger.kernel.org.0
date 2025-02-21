Return-Path: <linux-pm+bounces-22667-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FB3A3FB7A
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 17:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 767B4188E6EF
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 16:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A1C1DE4E5;
	Fri, 21 Feb 2025 16:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ty4rNvAb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E61442F
	for <linux-pm@vger.kernel.org>; Fri, 21 Feb 2025 16:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740155386; cv=none; b=aSmIfzTNY32A7jioaNoOgVfj76XZuaa49ZSRJJbtTzytlSEX7eu+5iyT41VHyjKZUV1dPEzgVDlFHhbeG8kW/gnqN82ROwoQGGiJkum/fk/QfVTksKVRSgubuHgSAXicp23ePd2Sb4igu4WFapaGDRbtmvUTs08Px7FJvfjYAKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740155386; c=relaxed/simple;
	bh=fBoYCwZcQCYhkm+R9DJkHNisr3S/E8IlAULXjqlh6mA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fwX1hz59dvKqmX1Es36fIyhP0j9h0N3x+dNRUbY0j0+m0E24ZUzbz5XYaAWlMaZVoVSn38mgIwT9Fsf8JtwMG8lwzs3X52A/to7O22ak3EUsFoB5i0+7E6vwDLo9TEs8j5e+SAysG0Kpijaw6k+JiOtj/sl2kded6qTPTCM0oI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ty4rNvAb; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-543d8badc30so2677426e87.0
        for <linux-pm@vger.kernel.org>; Fri, 21 Feb 2025 08:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740155382; x=1740760182; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RNzke/B0jvL0u/biZ2WURSdaDRxmzZ+8zMviyRXTzMQ=;
        b=ty4rNvAbl8z2NDvAZxFn3LA6wHCn///RQeYxCbcjeRUkxUuSXUNQFU/c1VDCKDITpH
         nXqSw2WthCXwE/S4b83ZF73ISEnRgpk10YlMW8xyGa/KhyGble6mNBuwcRBMMx9z28a5
         0b6POKFppfW8cW6p/4PzJNpPZivU4GSDRBcdCJg10GDJ8sJwf6luFudPApRNZNFqFpeJ
         RDc7bPJTP8qXMt3GCt0yA3epRyEE2OPolaWuglpU5VzUmRHFuVIkuHkBaJ30Q+fIAnqw
         Lw34uevSHNXoLb+vWXM54cv2bgBdyTTil/4+DVPEBAskifnCXgd3eVC9iFUI1cqZuzjs
         Dxnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740155382; x=1740760182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RNzke/B0jvL0u/biZ2WURSdaDRxmzZ+8zMviyRXTzMQ=;
        b=H7iSIVaKX4uPU2LbYu6kDSkJ7b5+UzIkozJ+N810lVWw3ZJq9h+CU2dBZNCLukyMsa
         gAb5pc9dV+rxLRCyiI2ITowYSE6dI0QR7sJVzeXPC05LqzyFar9Ax0ujty7qf2Yf/Ytv
         MD5HuP0wsWV7y51Jfz5Gox6NzbOfYQDrNFoRUWlurEBVkIJZc9WIH+gyBH2UhGQTHzzh
         jvGsqnYDC/cPsbIeFkFLE1weHyBCp6XIteUuq5LkY0LE2rjPYO+d5mOmk4NgpdZdjUuQ
         6QYmvbGHWx6oxdrPK9ysDKpvsfQejoc6WCownssBq5d/Otc5j/bovD3gkHqZ2sR8wzgX
         KukA==
X-Forwarded-Encrypted: i=1; AJvYcCXY+65i6RhvGaJ6HQc33i60cXu8KkZWXHVf2AI9w4o5Vwrket+81c+Pv11HZXItpPmAYZG7n0k0kw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxXMH6a+4/Y1tUHBVv7Wh2ea6ZrGqgM4fk8+A0iHBuUrBDNJqxl
	PO4jfi+L1fugRvSnpUSv+OOU6dQrXp0DpmLDmP+aYit0PcZvkrKNkbhlMn0Xid0=
X-Gm-Gg: ASbGncsq9/kfDVx5U0u508oM0A1h1EVbElmQtcgAx3P5R31OaTWTDfe5g+DzMW9Z+f0
	RdD1l2NJSqC0Sywk2UqJOvvF7LmZxkLNU1d7X55TVXajfXnPn9F90xYNwTjPIhUpW4Wi1oCONv5
	Q9Mdoz6UBiDJnpmR4ysInHPrBQXc5cWz6izv1viLiMF8JPoC5r7vd4EMAefmqxuR5+s61oezjtr
	MFg42ukOFcazJQmFBTZpIeCwE5+cqXEaa0FntWV3nCmbnOuEFZVG6FiBMIxJmlrF0Hk75vlc/GY
	HdGg4SF2ktdJpS7e0nCjYdgIrjX0qMjcZAw78VKir6Zg67KmMYWTTnXE1tCUlIof5msYKeDf2OC
	62bZF5A==
X-Google-Smtp-Source: AGHT+IHQHGtF1IRNvzfDKgAwDHfPBxdqZiPOZ1zVy8X+5men/XvW/Q187nct1imMKiSo1Kw74FRbQQ==
X-Received: by 2002:a05:6512:118a:b0:546:2f7a:38c1 with SMTP id 2adb3069b0e04-54838ee33b7mr1824643e87.11.1740155382579;
        Fri, 21 Feb 2025 08:29:42 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-545309f68dasm2135184e87.239.2025.02.21.08.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 08:29:41 -0800 (PST)
Date: Fri, 21 Feb 2025 18:29:39 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: George Moussalem <george.moussalem@outlook.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, amitk@kernel.org, thara.gopinath@gmail.com, robh@kernel.org, 
	krzk+dt@kernel.org, quic_srichara@quicinc.com
Subject: Re: [PATCH v5 5/5] arm64: dts: qcom: ipq5018: Add tsens node
Message-ID: <gozy64midqxmdguyzp37sqagzkfaozkfcgcdbq3zgzfwh5drru@znq44z5yi2ha>
References: <20250221161101.17204-1-george.moussalem@outlook.com>
 <DS7PR19MB88835D0B88C56EBE6127120C9DC72@DS7PR19MB8883.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS7PR19MB88835D0B88C56EBE6127120C9DC72@DS7PR19MB8883.namprd19.prod.outlook.com>

On Fri, Feb 21, 2025 at 08:11:01PM +0400, George Moussalem wrote:
> From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> 
> IPQ5018 has tsens V1.0 IP with 5 sensors, though 4 are in use.
> There is no RPM, so tsens has to be manually enabled. Adding the tsens
> and nvmem nodes and adding 4 thermal sensors (zones). With the
> critical temperature being 120'C and action is to reboot.
> 
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq5018.dtsi | 169 ++++++++++++++++++++++++++
>  1 file changed, 169 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

