Return-Path: <linux-pm+bounces-11369-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D71C093B5E4
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2024 19:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 834FA1F22BE1
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2024 17:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A0015FA92;
	Wed, 24 Jul 2024 17:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c6vUAwb/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35A115F41F
	for <linux-pm@vger.kernel.org>; Wed, 24 Jul 2024 17:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721841991; cv=none; b=SB8R6YYIoxujXPXVLzh8DKPsUmqCTIIWFgJfIbezQABLYa/kNMEhpnAd5SbKwH6X81H3iU6v8WFA7dyPmgc1OGvkwMNFbJ7Vp1mp1LmtQZzSA9ZQIjdmGkRJl/7NUVAvzY2b3NnVzyd5EP30cQ+BWmIA1vTasHcyoVMNtycGRpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721841991; c=relaxed/simple;
	bh=nirmYw7F2dXu3jHlu65M8bPLc+xMzWCodmmYzuIxjFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pdhiUHrBnNTPG8eQXOdJ3a9pOJwkB27oW9JYbU87/S3fnjo5i0LlzweaYZmJwn1LJIhbBp5u2Q6BfaP3xv8phZ1w+T7d4klYUgcHDUzcPUuEToBpWTBT1OnPFIKdR0LkcRU9bt+FGJItmvBQODDk1moJblofNVo4YAfYrDiKFIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c6vUAwb/; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52fc14d6689so3617573e87.1
        for <linux-pm@vger.kernel.org>; Wed, 24 Jul 2024 10:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721841988; x=1722446788; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6gyjxRwZj2E8/gds3ss9PWGb0Bwbvl9UNoycwou2Ge8=;
        b=c6vUAwb/UeWzIuHEo6185p+G1KDKK8dDaWZ9CsMhmLDvbBrWLwgT1R6NkE9wmgQngA
         /dp5GZfmH8giO4TpCMZAeUgyK+XYpF+6JUlgwaCg8Z9qea6ae9mHTBCgWPHmlDROlWCy
         ToTDyX6+oC6Cy1W0osRfemF953dWfVql97YqXf6rRR9qVsn1Y9jR90VNoo8wTg5FHXBM
         ZbLh6tTQocJSs4HtLeU4lq8TPePxM1S1T1ctVaOvpWIx0vFSJta2AoHuFJbYnMMKWSe2
         DGzq8yZDXH6tKODSWVSZ1xFjdfSPNaB2o33jmQ4fcGRc3P25Vowd9bytuEfRUPH6cE5s
         vbsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721841988; x=1722446788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6gyjxRwZj2E8/gds3ss9PWGb0Bwbvl9UNoycwou2Ge8=;
        b=mNpNdjG5J5ApxOY4ugRw/czjOBTSmHxhs5j2ZpXCYY1tDZq+Au8IMsDic0pDpbOSxA
         sK6M0PddRN/lCm4HHtDZ8GhJWWlXpbMzXcmu9cFJYWk0/mufGsOv7KN7CgQDBIJBM7ey
         EpGU1ykzINg00JmUSnlBv5euG4afBm3JgulMxMXmhAcTq2DhILI5Qaz/HNYW1S/ntC/G
         0ZeUsWxlqmVGLBgOlBpu5xP6oXMBYye+1N9jbuz375DOo1Ms3MbjebVm0joFSxEDqO4P
         iBSZAsjt4xTcrb8gvulgHPiolUePOlx7UNPD7XeFkVaMN2GxY3IzkP68MUj7qJEk3/jm
         52uw==
X-Forwarded-Encrypted: i=1; AJvYcCXYA3dkcJOmP5vMg6UYnu7C+IosOCA6m8x60YJUUmjzATv50BF11Ld0E5HJIS45+ntqgODQgb5i0zV/4lFoG06DXGAqDVsz8WQ=
X-Gm-Message-State: AOJu0YwAEYSAs+zz9oPfxQnkTt1HiQsBSyQw8QkV3xVZslBJyYknY7r8
	apSYoB95Obkfplcqe+WpXUbPj5gzxyNsKswhX1hhCnLKmVxbs8KeKz8oRhtigH4=
X-Google-Smtp-Source: AGHT+IHlDpSkUv36Gv/Yk9ACZKyixMbYij87/r4e8rpjoasoFjkXepMGnJgzlNprXteCON2oLyXFpw==
X-Received: by 2002:a05:6512:b84:b0:52e:9b9e:a6cb with SMTP id 2adb3069b0e04-52fd3efa634mr362510e87.15.1721841987977;
        Wed, 24 Jul 2024 10:26:27 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52eff3bd6ecsm1445088e87.4.2024.07.24.10.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 10:26:27 -0700 (PDT)
Date: Wed, 24 Jul 2024 20:26:25 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, andersson@kernel.org, 
	mturquette@baylibre.com, sboyd@kernel.org, ilia.lin@kernel.org, rafael@kernel.org, 
	viresh.kumar@linaro.org, ulf.hansson@linaro.org, quic_sibis@quicinc.com, 
	quic_rjendra@quicinc.com, danila@jiaxyga.com, neil.armstrong@linaro.org, 
	otto.pflueger@abscue.de, abel.vesa@linaro.org, luca@z3ntu.xyz, geert+renesas@glider.be, 
	stephan.gerhold@kernkonzept.com, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, 
	Praveenkumar I <quic_ipkumar@quicinc.com>
Subject: Re: [PATCH v6 5/9] pmdomain: qcom: rpmpd: Add IPQ9574 power domains
Message-ID: <iy3l3ybmvllqxtyqq7fifiokxaaedrs22davveel4ikjoqivdm@dinswoc52qpz>
References: <20240710061102.1323550-1-quic_varada@quicinc.com>
 <20240710061102.1323550-6-quic_varada@quicinc.com>
 <d454e01f-3d6b-4a02-87cf-3d289bc6957c@linaro.org>
 <ZpeLYG6vegJYZ5Rs@hu-varada-blr.qualcomm.com>
 <ZqCD3xtkLHbw9BHN@hu-varada-blr.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqCD3xtkLHbw9BHN@hu-varada-blr.qualcomm.com>

On Wed, Jul 24, 2024 at 10:02:31AM GMT, Varadarajan Narayanan wrote:
> On Wed, Jul 17, 2024 at 02:44:08PM +0530, Varadarajan Narayanan wrote:
> > On Tue, Jul 16, 2024 at 02:15:12PM +0200, Konrad Dybcio wrote:
> > > On 10.07.2024 8:10 AM, Varadarajan Narayanan wrote:
> > > > From: Praveenkumar I <quic_ipkumar@quicinc.com>
> > > >
> > > > Add the APC power domain definitions used in IPQ9574.
> > > >
> > > > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> > > > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > > > ---
> > >
> > > Could you please confirm [1]?
> > >
> > > Konrad
> > >
> > > [1] https://lore.kernel.org/linux-arm-msm/57dadb35-5dde-4127-87aa-962613730336@linaro.org/
> >
> > The author is off for a few days. Will get back to you once he is in.
> 
> Have responded to that query. Please see https://lore.kernel.org/linux-arm-msm/ZqCCpf1FwLWulSgr@hu-varada-blr.qualcomm.com/

If it responds to voltage values, please model it as a regulator rather
than a power domain.

-- 
With best wishes
Dmitry

