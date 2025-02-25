Return-Path: <linux-pm+bounces-22940-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC638A44E64
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 22:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9D477A415C
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 21:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BC520E020;
	Tue, 25 Feb 2025 21:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BnJV8tek"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758021A2392
	for <linux-pm@vger.kernel.org>; Tue, 25 Feb 2025 21:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740517760; cv=none; b=I6owfbnc4izNcxNR/GkzdvFCcE909caj4SgMHQaAvHZn00KYDtchhpwKl48XC5LebuBrlkoXIEeVUuAqvC9pZrtL3/qmQ4Y8O4Fge/xjwPl8j5nAJabKDYv9gIcmgG0TPWXjud3ovz407SNC+sEKFtR9MgW+Ivp6rNu20WwHylE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740517760; c=relaxed/simple;
	bh=f9nu/gjYpScp2GZzc6dQlyISc0mFy1UpPKMQt+2+SPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aHn83JMMMfsQQ0tBJjfXem7PSUiyuzMYF8X/+85uU/LlVOGBm1UIIFC6X3ZrPV45zjLS0qmjgTnU7F/VYNnfdNwLG6ZWQTJY3rc3uK/Mc/rRJdWd8OvsQak8Q3hRxNA5gRA8n4UTTdAa7sYTXtrNITn/iRfwFObA9Nu3GNdDhv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BnJV8tek; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3072f8dc069so62853291fa.3
        for <linux-pm@vger.kernel.org>; Tue, 25 Feb 2025 13:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740517755; x=1741122555; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M4XoCEWv2ZTyY24QshaT4Wp49xDJ3qBHY1WAxKeHvOQ=;
        b=BnJV8tek0H2lBSDSA1XJYLnSTGkX5dc7IAY3Bcy7+6xD5yTFyClsz7CB9j2aKrnjs2
         Pwr2aY4vrxkpZQaMaz8clZQhNxTSNvZpvy4U5eWAd1F6TSgBF5ARLJ3vo2vgrIQA0nyc
         37TMXeGfvF9gJuYAHcmcWQNCM6lYq4h3eIqFxxa6O4uHgaU4RfqqHQfK9mprkU3QnsVh
         UoExr8p2tBvij30C89bFkKXq+E9ZyyD0YveWloESi7rb6LMJ7lnxd83iZpeUYTFKt5cA
         hpdkr0aQvbL0gEKafcJgwd1u1ZksD8FwvOvU+mzSxaiSWuaFjSRgulHcJ8d1vSLC4tOA
         s6AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740517755; x=1741122555;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M4XoCEWv2ZTyY24QshaT4Wp49xDJ3qBHY1WAxKeHvOQ=;
        b=UIxSJFl4ZfcBSLwO6DNdoqq7Pg8cZyC0QGNFZU4OBxCarBayylLgk74a/0Ezn6Fd9k
         7rQSmmWUSGrhR69BW2Pd6xIifldMLXcQu0YwgKaJt4NvWI7brNeDKUGpBWqniznr32PW
         7z30ophSauwQdN8/JQ7tB007rnfgLN26NmPXBEqyRPKGGmkpZgjUMXn8lgWvlRL338T0
         MWl0aEyajEB9vxqsRROV5Tt3KL1upiMCJDzG+T2nnDddEllC+mPt6RpIhObiYPCc0rMx
         UZ9/qMHVe7MJZdS9eUylPmG3AxiHUBgHtxkibe5ppQOUc/1LApfZcGlYk5LphSjESIR/
         DrRg==
X-Forwarded-Encrypted: i=1; AJvYcCVnglRpAPUrizC5LnOkL9rfAloaJtXu6xgcJv16/7ROwg7tLtFpMnap1F7dchhu2n5t5BMssEYW+g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAw3m9qwduBcqMsmQbq6r8Gk+0nk5vY4xDHhN/RdcyhBaCwYzI
	W6igJTqHfmVSAl0IB7QVDGzdyMru8O7skm5+oIOkTzNKCnijuqLb5UXocgCvqFY=
X-Gm-Gg: ASbGnctIhxpBfM8Q5006etjiQQ6eLd9Q2Vrb6jS5o2F1r/rKIRCB8pspM9dHopn+T4D
	j7VMFuS7GSS2chWXCXPBBUSVCc3Rg7Va//DeW8J8Eba6Wvu4EZvfXCjJ1E8aX3RGMg6iJVybMUd
	ElZ+B2nlBGwY0kV/A82nRKj7P0EU2BZeYCFMFe8bokD1c+yt4nX78zuGpcrLLtFcC8wtwqWGFM2
	tiOFaVprB33yWFRdPA/el4J41ghueF7vQN08Oat24oDxp54XSOzGME3LFrMyDV770GFn/8LK2F7
	OCd/MKyAVX8XdC6EbFFAM/A+mbUuH+x3dNHY9KrWtS79O6/s+rwdZ1u+XEvnI9Bn+e7QhPDQFUE
	CDf9Sjw==
X-Google-Smtp-Source: AGHT+IHZW6d9rnGPSbTopC+zVuHs8+WHbIcOmyVc/br2TV9KZrFgTMvD/wPr004/MWm+y+QcUxD/DA==
X-Received: by 2002:a2e:9c02:0:b0:308:e9ae:b5b3 with SMTP id 38308e7fff4ca-30b79132d13mr10353661fa.1.1740517755543;
        Tue, 25 Feb 2025 13:09:15 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a81ae82d6sm3139931fa.110.2025.02.25.13.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 13:09:14 -0800 (PST)
Date: Tue, 25 Feb 2025 23:09:12 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
Cc: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org, 
	daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com, 
	david.collins@oss.qualcomm.com, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] thermal: qcom-spmi-temp-alarm: Add temp alarm
 data struct based on HW subtype
Message-ID: <n57hjxg6v7z34qmlvygfwakol45dtj6jgma56w3xqxbj67op3x@5n7yoyydnxm4>
References: <20250225192429.2328092-1-anjelique.melendez@oss.qualcomm.com>
 <20250225192429.2328092-3-anjelique.melendez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225192429.2328092-3-anjelique.melendez@oss.qualcomm.com>

On Tue, Feb 25, 2025 at 11:24:26AM -0800, Anjelique Melendez wrote:
> Currently multiple if/else statements are used in functions to decipher
> between SPMI temp alarm Gen 1, Gen 2 and Gen 2 Rev 1 functionality. Instead
> refactor the driver so that SPMI temp alarm chips will have reference to a
> spmi_temp_alarm_data struct which defines data and function callbacks
> based on the HW subtype.
> 
> Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
> ---
>  drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 103 +++++++++++++-------
>  1 file changed, 68 insertions(+), 35 deletions(-)
>  }
>  
>  /**
>   * qpnp_tm_get_temp_stage() - return over-temperature stage
>   * @chip:		Pointer to the qpnp_tm chip
>   *
> - * Return: stage (GEN1) or state (GEN2) on success, or errno on failure.
> + * Return: stage on success, or errno on failure.
>   */
>  static int qpnp_tm_get_temp_stage(struct qpnp_tm_chip *chip)

-> qpnp_tm_gen1_get_temp_stage()

With that fixed,


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


>  {

-- 
With best wishes
Dmitry

