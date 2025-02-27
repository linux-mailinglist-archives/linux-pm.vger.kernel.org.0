Return-Path: <linux-pm+bounces-23116-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EF6A48492
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 17:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6BB63B1CA6
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 16:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF1D1ADFE0;
	Thu, 27 Feb 2025 16:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YyIFrR4G"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F84822083
	for <linux-pm@vger.kernel.org>; Thu, 27 Feb 2025 16:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740672516; cv=none; b=s2vVsRG+tDA78JSxKZNa7DQkJJMIikY7Qq/MGuP+Umq0gVpa/ZuYyBuGI0O/uC0webip/uZCfccIO8z2bIxrt1p5c7nKwqvozitosRzEL2wnPZtbswO8MbWYuGexM6YqAoeoj1wpd9XtXJBEw2yS9OJnoTJuFAiKs9f0LXPHx3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740672516; c=relaxed/simple;
	bh=XM6Brp88bVea510+9dHCm/kJImSPWYA2w1vpsAIwc9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BzYKZOxewFZ3sCqFguYTeCoAdAewwAMejNLXZCzWv7wnzsN5vCsAYvmVZGMgUeQC9DNMNou+k0UgqvcVn588H1naQ5idWYLggsKgDy0J62eY/R1XXjTWfwzTlYnv44YNAjItb3pcw6L0TGIXTn7bdxUYjU7EyImxL5HdgpDrQWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YyIFrR4G; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5485646441cso1176500e87.2
        for <linux-pm@vger.kernel.org>; Thu, 27 Feb 2025 08:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740672512; x=1741277312; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8MSynCSxU/EJe8V1Ql1pW3EuovTtqAL4RYWUe0Gkt+w=;
        b=YyIFrR4GUEVcN7kBkQOfFG8Xj6Iy5wTbDxXgl3d6+Pqq6dIaKK7vDyBqvEV2mcCoUP
         vxeMI5vKVC0iDVjuF15j6FywxpstE0D0ry25XFRETIq0jF9IW9UaV9RaWUTbpZQP7tkX
         xCw1BbRMdvZaHLWIqcEIvBqB/EoFDKxIVObT3U7aIbfR9JUQOiohWlHMoCPCe2qy5veQ
         bQMmJID78TOXDE2kWritIudRAJLcPxhYXxVnUuhaUfeieV4AsTCx/6Jd5yLF6Km+MNgt
         bFQTHzuipLCjNcGxivdgIWwXqcrS1xaMbeLfKyGWKhF2n+ewy21x0H1Wka4chzMfGjre
         w7SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740672512; x=1741277312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8MSynCSxU/EJe8V1Ql1pW3EuovTtqAL4RYWUe0Gkt+w=;
        b=wIv/dLKWRVulmeKkKoggyrQB5Zf6tVq590vwobz6x0tp6HPysv112gqjUxkWu9uX7H
         qKkzUoYbyVeuAWiISegyH81H/P1X61OzOldjSgiKXHMT/ytTlO6/geT8TeGtgzLMlEYr
         0hYQG2VAFNrmHQ4EX1rCb5No8eeWnOc3g3IS6d31ioHKCetZNO860eM6psWTdNxvBHAt
         azeqd1Ku28TAGqj27rC6i11QtEJmCtDcyFb78u0W21GfG/2iUsJTr7qkaKQvhCRI/9ak
         IBgTjzmmq5qWDd1lwE6LzJeun4IxQiPgFkUgKL+Eelxy1eNBoV29HhRp+HDZtucSXTCw
         ucsA==
X-Forwarded-Encrypted: i=1; AJvYcCWEDWyEFTUk9rNYntyHp+gS2YrkmLvG8/rswgdoo5Ux3KkikiHfF+QPKv3dydkABvZsGDE4GOSX4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXJ0Goa1hWjBCuYoo1BiskO+o24CEt4VPtCeRmQpnZYmI22wF5
	ipQC2t2jnSriangT8/gpngJNbB5MdDQPm5Dz1apZcxfKaLwX9YjRupRjkKCza+U=
X-Gm-Gg: ASbGncsFMxzCfRn2nPqugniQvRSFAcefnD6wOpNWxJQhd4grMyeLxmkmeEXFYME02aM
	fsjPF12X0NX/2HYIFPySYtZyKYS3NRYZ5qOCGq1eXryWbvMsQQyIcApVTOsoTWi+fmOzEVL+WcZ
	wmsQ8vi7lLp/ElyV/q+mGwKdMNDBzVWRM9UEMB5+63q5JZzXSITpa3Ra7usMOYyF4gKpKC4iONT
	+Oh4Us+0QC8YJhtf6H+Wk5P2fHRz+ZG0Nw6G0M++rOYEHj+ajMvdYXHd58QaHSxj8RUDpdLls6q
	ifBL6VP9hnZZSaJnGVYpGfnDhw/sNHdwBX6M8SNUsnPaMT/J4NEMgwYJeiQYe5xfYqxdRmg2AeV
	HNwgxsA==
X-Google-Smtp-Source: AGHT+IEQzmuoS9H/Yzq87aXTU0VRLHo7mHqgbgUV7114Toj+TL1SlVVpSt2e8g8LP4hRC73xBqYbAw==
X-Received: by 2002:a05:6512:ba5:b0:545:e7f:cf33 with SMTP id 2adb3069b0e04-548510ddc55mr6665448e87.28.1740672512284;
        Thu, 27 Feb 2025 08:08:32 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549443b1292sm197427e87.108.2025.02.27.08.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 08:08:31 -0800 (PST)
Date: Thu, 27 Feb 2025 18:08:28 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Odelu Kukatla <quic_okukatla@quicinc.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
	Mike Tipton <mdtipton@quicinc.com>, Jagadeesh Kona <quic_jkona@quicinc.com>, 
	Sibi Sankar <quic_sibis@quicinc.com>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V9 2/7] interconnect: core: Add dynamic id allocation
 support
Message-ID: <bv73i444oh4oakgqet7brkdpmusvpf4x5nbi7kgfvykts43roj@jnc5ps2sazeb>
References: <20250227155213.404-1-quic_rlaggysh@quicinc.com>
 <20250227155213.404-3-quic_rlaggysh@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227155213.404-3-quic_rlaggysh@quicinc.com>

On Thu, Feb 27, 2025 at 03:52:08PM +0000, Raviteja Laggyshetty wrote:
> The current interconnect framework relies on static IDs for node
> creation and registration, which limits topologies with multiple
> instances of the same interconnect provider. To address this, update
> the interconnect framework APIs icc_node_create() and icc_link_create()
> APIs to dynamically allocate IDs for interconnect nodes during creation.
> This change removes the dependency on static IDs, allowing multiple
> instances of the same hardware, such as EPSS L3.
> 
> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
> ---
>  drivers/interconnect/core.c  | 13 ++++++++++++-
>  include/linux/interconnect.h |  3 +++
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 



> diff --git a/include/linux/interconnect.h b/include/linux/interconnect.h
> index 97ac253df62c..8b0f892aaed2 100644
> --- a/include/linux/interconnect.h
> +++ b/include/linux/interconnect.h
> @@ -20,6 +20,9 @@
>  #define Mbps_to_icc(x)	((x) * 1000 / 8)
>  #define Gbps_to_icc(x)	((x) * 1000 * 1000 / 8)
>  
> +/* macro to indicate dynamic id allocation */
> +#define ALLOC_DYN_ID	-1

Nit: ICC_ALLOC_DYN_ID

With that fixed,

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> +
>  struct icc_path;
>  struct device;
>  
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry

