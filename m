Return-Path: <linux-pm+bounces-18812-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAAF9E910E
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 11:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEEA62811FC
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 10:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9AF216E3E;
	Mon,  9 Dec 2024 10:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o9sTKXLi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3892821639E
	for <linux-pm@vger.kernel.org>; Mon,  9 Dec 2024 10:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733741818; cv=none; b=Gbob1MrclDlMu0AopNmK21mKArS4ar0wxpKZjk9bZS3kbXrLRyLUVoiSCm1i+Mt812rAZWgcVUACUJKdvyCK3MRuDrGcyC0Vv+e4kGgdPswEcqX1ux3w8812nFty94corjyrch4VX6TM1zNorWpzxmxLDISZhO6cpiuuYFq77Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733741818; c=relaxed/simple;
	bh=+hIqe/S4QmDOQhbBqmZWXMgHf/K5HX6ZKx4rNqDaI+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KXcjD7Qb60zwH2Qo96Yn2SQxs+sPuz2zvUdgIDB3sGZacUqBI+wiVhmRTLaGIP4c+LuHSlEGL4p9hew9oN6hSBPo3bvAuGfpWWmgXGkTSgryDBo493KBti/6q7TyNrBqAh1pF8VUdsSGtaRNqXX7mM5q7cfp9w/QBca/r4tkmqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o9sTKXLi; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53e3778bffdso2806023e87.0
        for <linux-pm@vger.kernel.org>; Mon, 09 Dec 2024 02:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733741815; x=1734346615; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ujaAnVbj3AWarK9qtUD67P4FOEUURSL/PjGWuchpTYY=;
        b=o9sTKXLiYAY9D6gd+tBUC/DKVB1LSXHY77IFItaRz3YQACOwIi8PWrunjfnC4ZzISG
         baEpaAf7xWvTWqvKrCL3FNgDrrKuhKDBfqP+6QGy159jkX0qMSGuZ+pWWrCNhIYytPPA
         0inDWB6cDBbCv3gtF4nMXuE43+ZExKoWfY/h+vNJr64y0nv/4qm1ufJyT3T4tfE8Miac
         AaJ/YCvR2BJDPfibUmjlEt22horOEswtwINrJJCoWkmyHRcH2ioA8Gfhwx/AWjJbAk+h
         kJlCU4Kn2opYnLVqs8pQK4mljVLLHcGigNgdFQgp/nP5S5woZRkYW1T0r60HvymGWo0I
         EqZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733741815; x=1734346615;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujaAnVbj3AWarK9qtUD67P4FOEUURSL/PjGWuchpTYY=;
        b=LAz6Tnm+J08wD0KHv5my81lNVGwiKcqsCOZXMUL1dDT/SXdIidYvsCLP5rDxfJu8hE
         GotLDPVELsA3BloXLHtsCcGQoLUousZrK9tKJ8jb4SyIgNCnXQ2SDBOjC3Fp1EI660aU
         Ot2e8GcfhDxAIp3vC9tZP90TZYcpsDaoDjdOg1/2XBVDBWpc8vS6b1zmAcpqz9f9hclC
         cOX3FlP0FaEwlRLVxogVWH4Q5JCi70k8YRbr1vtNiQLQzRMZQ3R90LV2Mwx2rPy59CwT
         zUCny2TVfPrEQx7bJcrhqX0neO8YFF1wsYnI125Nkm/JRO2DTtwrlrYa8zz6EvU6a5SF
         Xt/g==
X-Forwarded-Encrypted: i=1; AJvYcCWdXCFPO6/RgI3A1jA1hGo5S1R+gWa0/BaKqPJNivOdQlgDnV2xq0i/Cle9scxsscDNIud1pzMzRg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxuNSBrCHPK/cNNVFb8vRLNaaLem19AiZYSMCW7VnKeu06j4l0h
	HqapuDqxlISmtAaF2GbO6VNG8a74F1NLQSvb0tEcrwJTvyYsystVyrXia3kOu7w=
X-Gm-Gg: ASbGncspH9MiM/jfFyX8iG1u8TmsDzibzB7bTZo6J+hWu2CODzCI7E9Q8OBOntOrEhp
	8Y+mv6enbzxCkCW9KFtnCNb17N7FPOzFIOzXtTnda72uY+JZqTdoF1rOdOh4JtXWMUV8JIN1jUc
	LP3LtMFq+D5bBVWTgXGcca+NnmE5qQwMs4euAUVoo6TgS6RgW7NuR03BKJ7yGH1e1dLjCcmxCdg
	LBBKg5J2Yc7sZ3bsE2cJIIdyPbkQfXqwt6ptDPSShbTEYPqphUgkV9kCL7PNfMte35JKQGa7a7o
	swvsA7e3xmRh33klmAIjxlw399k/8w==
X-Google-Smtp-Source: AGHT+IEe3E3bVz43C381ijw4BD9zV4cmUVA4lOxfc676Po+XiC+s2QUjs8LbA4yvZYwgljPHeTSG/A==
X-Received: by 2002:a05:6512:b15:b0:540:1ca7:4fe9 with SMTP id 2adb3069b0e04-540240c97b4mr13875e87.22.1733741814988;
        Mon, 09 Dec 2024 02:56:54 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54020269fdasm214549e87.182.2024.12.09.02.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 02:56:53 -0800 (PST)
Date: Mon, 9 Dec 2024 12:56:52 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 3/4] Bluetooth: hci_qca: use the power sequencer for
 wcn6750
Message-ID: <heyjpkzb4cxomosg4v5rzco3gi5d32vyecuyfgu2au22p5utat@2db4a3mxtblg>
References: <20241209103455.9675-1-quic_janathot@quicinc.com>
 <20241209103455.9675-4-quic_janathot@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209103455.9675-4-quic_janathot@quicinc.com>

On Mon, Dec 09, 2024 at 04:04:54PM +0530, Janaki Ramaiah Thota wrote:
> Older boards are having entry "enable-gpios" in dts, we can safely assume
> latest boards which are supporting PMU node enrty will support power
> sequencer.
> 
> Signed-off-by: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
> ---
>  drivers/bluetooth/hci_qca.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

