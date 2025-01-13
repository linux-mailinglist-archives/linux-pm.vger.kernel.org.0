Return-Path: <linux-pm+bounces-20296-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 855A9A0B0C6
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 09:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54BC53A3F70
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 08:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18FB23312B;
	Mon, 13 Jan 2025 08:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KVN45Gn/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59AA2327AE
	for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2025 08:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736756093; cv=none; b=C3qpXoJDoLqEA/3f25KiJWIIdGx/XGF5oklxlmKQZDqPeBeLb9rVSBkCyT8N/LZWkk/Nr1nfZz9MWqIkq9US0lKGdNuXgwGf8iosvk/HGsts65tTji90+dy+UhtWCJVK8/hAv/3UU+2QZG8lvPa9WK51Nv+vvha4wa6gCuFh+MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736756093; c=relaxed/simple;
	bh=Hvgcs+cliAfpJ3VVSWJBygzxwPv3GVFdCfpgC7KIO4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sG71Y1xgN7LNdvAk/DA1j5utDFcOwvV4Z1vVmYq438ZCev+C0dX/m5rpU9SMMUVtts5QuJDeBJnj38vcA6bAV2b1uRI+iM/zpYHLN1sL8Gv3JRQxZGkgScnZ7z0T9wZIXXReNOEPPFmjhFCu8b/HlUeBNbZgOT/gRk3s4J+xa6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KVN45Gn/; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5401e6efffcso4175167e87.3
        for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2025 00:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736756090; x=1737360890; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EiBQMlbbRKX1jfLOnAiy2eBHbg9zc0uMkgrPET/8Jyw=;
        b=KVN45Gn/TeQcr8nxOFWmfi5aYFaqpsUZngD324pbbkZf3kC87yhZWqMkS8fxtJWyhJ
         6LUQOO9PbgWAnU/OzQY0oT1Ac+S77Dvy5494MNGw2UpsJoLw9eKpoax0AY86GhSIPP77
         QdyVLX+NnpqFKhyGxpmFwRa4vsylKm8miJ78niEGgTl9c9FaxxHgw+PTPwDXj2kT06AQ
         BdVtZE7MQg2AhksRsMRH+zom8UDpHllH3thYlpNKnZBzOFJDnKVL8GBn4SibvFsG/q3M
         woFfuub6dTfJLowWkXB9WEcmdFDO7U0QfBfgEl4bCayFezUdxd1yeBaizvMp4I9HyZwS
         xV7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736756090; x=1737360890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EiBQMlbbRKX1jfLOnAiy2eBHbg9zc0uMkgrPET/8Jyw=;
        b=FTr/s62/yc/hzzLGEIvWOADG7CdHl0PdE/7jauKMoH3CrnLmvjBIA5dA2zWOqri2qC
         ipmZspUGwfs2H69HRzBSNRIccseQZfwYNMIsV0BDZ1WZ9/ju57vUBO7GXkdfqm0leH2U
         2eFlDL1TZhPRElGrRDTfkJTb52hBaJj3JElNyt2S2+8o80bSaUszp1dwnlJ4XJzVhfvW
         0mc8NLQ3FE0/NfGGB3GuHDGpWq5X/NNdhvht0YVjLcxt/7ZG+jZTgzp1KG+xfdMKuc2s
         UGXJxwrYaSAaxfIZ/74pOMZcn2T0lN3mXodVdh65ajEuUvMb5+X1/rs0SV9NsObXUW9x
         LeZA==
X-Forwarded-Encrypted: i=1; AJvYcCWV5oKDYktNx/2rKEgok0qHE3kGHI1Hiamdru8kpzCTSZvWSkPSqQSzwNZ/A7zzlr8ENMzThBIhqg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyB+aPxrf/w64pqRZwZv9HPprYZtjOIUX6D30RDx9MtyCjTGrDK
	TfOAKnT4SksnaxKVoh6VnR2r4PPtvqUGMntzTtUlj8mAsrLkbaogTfCD8TYja70=
X-Gm-Gg: ASbGncv+Y47WSwezeJim23Wr+hx/3HaLg1+7FZgxEBSxlOgMLKyrg7DQ1JEf0SrG/ce
	/AL+HGRXHpCe1+XRyebAqjAJHd9TSMQdEv0f1c8K91AbMVbdbd88X3T6y4znJ8l4Qyc9Ei1kPUD
	3/VleUbSs1Q6tQJtj8di77ml2TQbhi+UfZGc8Fc4eGq/V1r+i30mkQxbOH3zBCp4guGndj45FVW
	CLv/hzHYBfWUmOaZfd/aWddqVYIGyPiW40giyVJw1wOiF+GHIc5ztaL9x17mtJ6/m5xLeva/PZO
	01lxxaxVJftp0X6AN6qvVzt/QbA2b0FsQHDE
X-Google-Smtp-Source: AGHT+IFiOGkWxTgwDiqqZRV/TncB2+0Lbwph18oB4337Oov0d7u7UgJwOOmW10YyJRV+FY90JH+dtg==
X-Received: by 2002:a05:6512:39cc:b0:540:3581:5047 with SMTP id 2adb3069b0e04-54284820134mr7051637e87.48.1736756089990;
        Mon, 13 Jan 2025 00:14:49 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5428be49dd5sm1253953e87.48.2025.01.13.00.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 00:14:48 -0800 (PST)
Date: Mon, 13 Jan 2025 10:14:46 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Odelu Kukatla <quic_okukatla@quicinc.com>, Mike Tipton <mdptipton@quicinc.com>, 
	Vivek Aknurwar <viveka@quicinc.com>, Sibi Sankar <quic_sibis@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 1/5] interconnect: core: Add dynamic id allocation
 support
Message-ID: <x4lsksrpwe5z6ti7gi2kufyhrpvffsmo2im3oqhqgfaft2ihfm@7xnd6bvy47rv>
References: <20250111161429.51-1-quic_rlaggysh@quicinc.com>
 <20250111161429.51-2-quic_rlaggysh@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250111161429.51-2-quic_rlaggysh@quicinc.com>

On Sat, Jan 11, 2025 at 04:14:25PM +0000, Raviteja Laggyshetty wrote:
> Current interconnect framework is based on static IDs for creating node
> and registering with framework. This becomes a limitation for topologies
> where there are multiple instances of same interconnect provider. Add
> icc_node_create_alloc_id() API to create icc node with dynamic id, this
> will help to overcome the dependency on static IDs.

This doesn't overcome the dependency on static ID. Drivers still have to
manually lookup the resulting ID and use it to link the nodes. Instead
ICC framework should be providing a completely dynamic solution:
- icc_node_create() should get a completely dynamic counterpart. Use
  e.g. 1000000 as a dynamic start ID.
- icc_link_create() shold get a counterpart which can create a link
  between two icc_node instances directly, without an additional lookup.

You can check if your implementation is correct if you can refactor
existing ICC drivers (e.g. icc-clk and/or icc-rpm to drop ID arrays
completely).

> 
> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
> ---
>  drivers/interconnect/core.c           | 32 +++++++++++++++++++++++++++
>  include/linux/interconnect-provider.h |  6 +++++
>  2 files changed, 38 insertions(+)
> 

-- 
With best wishes
Dmitry

