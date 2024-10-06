Return-Path: <linux-pm+bounces-15236-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C603992191
	for <lists+linux-pm@lfdr.de>; Sun,  6 Oct 2024 23:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D45CD2816C9
	for <lists+linux-pm@lfdr.de>; Sun,  6 Oct 2024 21:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254E218BB9C;
	Sun,  6 Oct 2024 21:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t5nMTpAB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0738E189917
	for <linux-pm@vger.kernel.org>; Sun,  6 Oct 2024 21:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728248878; cv=none; b=nEV0v2yea0rWoWNV75cjb1iUV0i333RtUfK6gCYEphqxdzqtcVfaBPHHefReWe2tCsvsrBMW4VCA9azbUYi9UT2i3MRCjwF4zgRWUsqYWmYtyzaPZ82eVxQushtpieLse5QGGUANgPObF4rgGvRQDlPUT+0Zq3I9Hcz2z0ShjcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728248878; c=relaxed/simple;
	bh=ZmEHLsPsF/N6ibvDSVVq/66rE5RN7QBCRfoTpzPD//E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I2mhZTsD0M+YfWQnbon10dC4fKbqCIUV9414ML0agCH+SmN5OyBQw/tabMjXFrFb2HzP2i/I/CEtsGB7ihtDaytKAo0feapkOLvGlGbUHlLOKpCpQAcuAU4MwXw5HuPnAxWGMgWNiIL6DcifRvztcmNBbUS4XtUcJ3ZcA0c3ons=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t5nMTpAB; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5398e33155fso4666741e87.3
        for <linux-pm@vger.kernel.org>; Sun, 06 Oct 2024 14:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728248873; x=1728853673; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Szw/D0bhQP/xtWqJOCA8PUzQroqabxhhElDsr640PI=;
        b=t5nMTpABdnd0ANto0f+s4DYsYy55O1o+LZitz9gcKKxOYmZpHdF0WLfbXBsO8XDDgo
         5pdttAbOtj7FS49WX8loWsfuYZzN7f15Y1SXfJrcLFPJOf9d2+whu+6Bn0rFkzaLy6ja
         Uo+2bMLk3KFHbcm63sS3mhMzuu5Ao8DYUWxutaiVKWv81y+q8aoEnflZkKuwSg6F+3Tx
         DxhLJRlpFgVFX/5oXeqyRDreZBquZSqlSG7AWvKOaGrpx+djtsassLLpdtYkY1B5iQt6
         Tpl2adGgYQG1s4JQiML/B1AM7o35qd2pWofERyQ+nC9z8GG/bl/8Qb5yOiNOw3dKDkHs
         116g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728248873; x=1728853673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Szw/D0bhQP/xtWqJOCA8PUzQroqabxhhElDsr640PI=;
        b=Fm3g7XqxzL6HZpoYZ8kYWqfWIkrn+JrOr3wvz0oNbATvDbea5B1uHyeZ9tV5cQ3Ah/
         WtDZRC6JRHuw7wACct8Mw95gI2G2bBXTL+25qx9gJIw6Ixpx5Fi+C6+bECR9xQlH9oeu
         1PtCLO8jWRi67cdXI1Rltw9mJhUYF2opNKpJuz6yyQVlgvTNxiVjAu1E0Zn/FKtjKgyV
         cNR969MzjGUNd5C79xHJI4+MVUDiNHeqqMFhx3XTi+A0rwrwuL41MG0Mkh/taDzaTquK
         hxYQhhaQTLDfNyF3f+xF/RzOGbNucFVEkdyjCL5gk139fY6w//kS3lEKBH6vAyf2vR5T
         lzpw==
X-Forwarded-Encrypted: i=1; AJvYcCVRi8QCWzsqLZliFC+30kLMYqa9obMEzyPCU7oK096EvkYqArx+Ie5rZqwjWFy1hTXLz3PHW4DFIQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGLbHy/qR9uKfYpk++7nqOcgzcbRSedmKvulPLa+1F+G5nQMgk
	apYfkFaTEAbSBP04YD0iEIUa+gozjOFs0/qei8dDYNKDicsNzQy499xmN+fjqV0dIpBWmRkylMc
	9h/4olGu/
X-Google-Smtp-Source: AGHT+IGNLcBHRM2Z/UXd6g9I6VwOvjvFpOD+yzP2cMKHxtpf6x5Xa2qcpwJRnTWlA6Rteu81F+BJow==
X-Received: by 2002:a05:6512:234d:b0:536:14a1:d660 with SMTP id 2adb3069b0e04-539ab85c035mr5226217e87.6.1728248873103;
        Sun, 06 Oct 2024 14:07:53 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00-89ea-67f6-92cd-b49.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:89ea:67f6:92cd:b49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539aff286f6sm617883e87.293.2024.10.06.14.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 14:07:52 -0700 (PDT)
Date: Mon, 7 Oct 2024 00:07:51 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Tingguo Cheng <quic_tingguoc@quicinc.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, kernel@quicinc.com, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, quic_fenglinw@quicinc.com, quic_tingweiz@quicinc.com, 
	Shazad Hussain <quic_shazhuss@quicinc.com>
Subject: Re: [PATCH v2 2/4] pmdomain: qcom: rpmhpd: Add qcs8300 power domains
Message-ID: <dy2kuyx23oraslo5cqc3a2udkxaafwyuugdkzcadwyel2mjyen@xrlus5lq4ygi>
References: <20240927-add_qcs615_qcs8300_powerdomains_driver_support-v2-0-18c030ad7b68@quicinc.com>
 <20240927-add_qcs615_qcs8300_powerdomains_driver_support-v2-2-18c030ad7b68@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927-add_qcs615_qcs8300_powerdomains_driver_support-v2-2-18c030ad7b68@quicinc.com>

On Fri, Sep 27, 2024 at 07:59:14PM GMT, Tingguo Cheng wrote:
> Add support for the power domains exposed by RPMh on the qcs8300
> platform. MMCX depends on CX, so mark CX as the parent of MMCX.
> 
> Co-developed-by: Shazad Hussain <quic_shazhuss@quicinc.com>
> Signed-off-by: Shazad Hussain <quic_shazhuss@quicinc.com>
> Signed-off-by: Tingguo Cheng <quic_tingguoc@quicinc.com>
> ---
>  drivers/pmdomain/qcom/rpmhpd.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 

-- 
With best wishes
Dmitry

