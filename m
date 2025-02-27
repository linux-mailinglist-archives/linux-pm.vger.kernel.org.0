Return-Path: <linux-pm+bounces-23117-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5464EA484B1
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 17:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21BB51894584
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 16:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACDB1B0424;
	Thu, 27 Feb 2025 16:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OOIogdiD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE03B4EB38
	for <linux-pm@vger.kernel.org>; Thu, 27 Feb 2025 16:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740672578; cv=none; b=TTeh8ErqFYcI+joD8DwEUfydSwSiRAqgf+2e/XRKJ8F89bA9ClFCRLyBT5dK9quQHhrY8jimSTl1xkaAYKF16jyKakjP6ADsP7wU+3uHY+r95ooHapOaWeoZZ/qbLvS4D52BHnM5nRAzlhVNh3ymvgrOuRQjTjXdlNgUMw6Fp4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740672578; c=relaxed/simple;
	bh=vvmQSQ9bG7LyD/zOH8DXzpjJRKelZZHC5MkRHwo+th8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EtQe9sFn24SUa82CMhMjcX5SliuzxDscG/Z7TTLEYhJLwFw/ygeg05u57JRimdsXPIHpIfwUYXUh5jjdesptqsiS387C9Qd04+HjPKkEuCuaaQ0FpfIgrPqvgRHa407Iwf9EGGzS/DwZdK9KzosMMHzSg7NUNIA4M/T3uuwwGfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OOIogdiD; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30a69c1a8d3so12881211fa.3
        for <linux-pm@vger.kernel.org>; Thu, 27 Feb 2025 08:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740672575; x=1741277375; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4/VUsIry0p1NFH0lewyTgEe2QgpPTkg8i3AfM1Pq08c=;
        b=OOIogdiD5ezp1fmcU7+U3ej5qTAUzafzCz8D2VYFGXulMRNiKrwj9FfqXOHs5/7kvS
         FQTv5vZ53apCzejYyv4ybAvhhWCr0nxalcQKw1jG95Pd8rWk50DeJ8MqVdHtcqE2ggh1
         BwdlsInaVhDG9PGo+P/UglsqGVj375ZHa0HqD+93YJmy51znXHtQ3/N8AYcgnzYjcjLd
         zNsEVTuXlCJEAu12f4zfaM8fDX1N5tEC/eaOaKx1DMbtmiDwMVFcwcxg6qU3vHFgh0TF
         S2LKGgrlhhF4OCYWX1qx+CwrFuH2ICfOb4DhOnSp8HhImkH8DcS6tlfPr/IwtBqeOJfB
         xi0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740672575; x=1741277375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/VUsIry0p1NFH0lewyTgEe2QgpPTkg8i3AfM1Pq08c=;
        b=bkKityuFbSQmp+rnPeW2ocD+okvu4S0cpCP/St7B5fhIHEPnfY3rPSlrr/VZmgs0Lj
         GTJP2YI1jbbkAZdEVnE1oufbCt8SGJnqeKTFni3kMrVQGvKI5XdqUjV9yPHLK+iErB68
         rBeXoBRZMApQG9j7a8IJV40DU+4cZG9tNUnpQYElj/2L8O/WASJERdwrrVn3l+NOtbq1
         zbf17kRqLolFxeXjUJsKq7AJBzMConor0fBiUivensNrwpg5qZokvWJvOQkCAc5CLeyE
         ncmmhDstGpxlc6pvQx0+t+JK/4nPCvsD7wg+DlBBv1Tidy9pHZnbHUeW7LHlEnwHAPcX
         MsdQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2OHGGiWLoedGzTjWHvJhGKQSp7T+oqUnHB5pVT5VSTyNM4xMgsHjggkXQBk6+J2CPIWpHYOA+iA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9WNz8TmXdabs9DH0iHVvJ7taJFaJqye3MWUuI8YKC4t9ECfxr
	xbG4UQ4ChTXnRdKkzkEFbqQAjkxY858HMcy373AVUctt6jGGurJEvM2AvPwkwgs=
X-Gm-Gg: ASbGnctiqyMGS6oanVnK3tB69tR5Hzbs7H1Bmm0qWeyT6HkUYVFojz150di4rea2eg1
	cwOJJCnRpxeZ//htFOKX5tkwphifXyfXU9uuetWGhv1/89Khsp1QxAFW+XPeoAFhGLoF7vDsxaw
	DDXGp1k69LKOV7aJPUiD3mBI265h4v5xu0FD8GY57SawKcUyH3KVpxKG5P+MXTIZxSyFzMpWEJa
	z1m1T2C3WaWwTwaxz+fAs2WT4VrXZvnFQCgLnPe9VUqwwxVnSj02E2nQ31uSM5Y8mKUTS+fmlxZ
	4FkT/NaBe9WI1IVCeIX1GRhZSoenx7Jdf2tfYSlAd2b6b6yBQkZ8N7tQrv5S7KPqwrv4lW4zVkp
	pbqFvzA==
X-Google-Smtp-Source: AGHT+IGantaj4iOEBsmehQufqCtLyP839fLFIF8/OzQyOmwBYnvU25Q+3zna/G2tIKhQxmOj4KjClQ==
X-Received: by 2002:a2e:908d:0:b0:308:860e:d4d3 with SMTP id 38308e7fff4ca-30a598f6c62mr97724201fa.22.1740672574881;
        Thu, 27 Feb 2025 08:09:34 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30b8685f43asm1964521fa.82.2025.02.27.08.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 08:09:34 -0800 (PST)
Date: Thu, 27 Feb 2025 18:09:32 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Odelu Kukatla <quic_okukatla@quicinc.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
	Mike Tipton <mdtipton@quicinc.com>, Jagadeesh Kona <quic_jkona@quicinc.com>, 
	Sibi Sankar <quic_sibis@quicinc.com>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V9 3/7] interconnect: qcom: Add multidev EPSS L3 support
Message-ID: <7lqkbkor7w4qm4esclm4i42eq5pq6nbxnouoz5ywklkstgvbj6@rpm3rssyarsq>
References: <20250227155213.404-1-quic_rlaggysh@quicinc.com>
 <20250227155213.404-4-quic_rlaggysh@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227155213.404-4-quic_rlaggysh@quicinc.com>

On Thu, Feb 27, 2025 at 03:52:09PM +0000, Raviteja Laggyshetty wrote:
> EPSS on SA8775P has two instances, necessitating the creation of two
> device nodes with different compatibles due to the unique ICC node ID
> and name limitations in the interconnect framework. Add multidevice
> support for the OSM-L3 provider to dynamically obtain unique node IDs
> and register with the framework.
> EPSS topology includes a single master-slave pair within the same
> provider, the node linking logic is simplified by directly connecting
> the master node to the slave node.
> 
> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
> ---
>  drivers/interconnect/qcom/osm-l3.c | 37 ++++++++++--------------------
>  1 file changed, 12 insertions(+), 25 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 

-- 
With best wishes
Dmitry

