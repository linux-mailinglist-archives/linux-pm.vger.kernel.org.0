Return-Path: <linux-pm+bounces-16641-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FF09B4279
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 07:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2C8A1C218E7
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 06:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD53D20125C;
	Tue, 29 Oct 2024 06:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="faX/GEw1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77A9201254
	for <linux-pm@vger.kernel.org>; Tue, 29 Oct 2024 06:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730184002; cv=none; b=Ar3g3kZYSAlIVwEtUbi2A2c/OZyQBEiTu7gXcY7LMjFZ5wxxl1ivrzV1TIjhIh/S7vsRbqwruM29eSZeYSsZut/6f99onj4soJX1AivibGGHsug0YfJJJQt1Gbf6r9PrSzi2x7bMzfRr3zRtB5Mg5HptMZAR96KVNaX8hIu0lbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730184002; c=relaxed/simple;
	bh=H58uJcpRDNvTax+VL+0+fCFLwZ31eZ9H75SsdG6oUmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pax7w6qa/FEsMvLDNX4MzP3wdbmmgO9wza0p8tBJSCIhduzyE6rH9XW/i44ANy5zfes6SoCvE4DD/J1t8BE0V6b7MLBXoJ/2Xzv27B2RgA0wdkdcDT28RHleU59K3p9V4DeYdZ80WJ9llZ6udQ5egHtYk0V1sFu7dBIJ2jsN12w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=faX/GEw1; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20c70abba48so40116605ad.0
        for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 23:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730184000; x=1730788800; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SmrD8WpF/OdMMrOZMzCUFVQhEI48ibTQY3atQcEu4nM=;
        b=faX/GEw1CkTrGuA1atfeUO4bC2e6YNdTUbeYFgX5adAKHofUoHzocz0HGqw1UvrPfB
         v3jz42lb2BJ2BUHyLVCHJI/I/zIDNzkyJ9SGPHwbDijTKwFhhTlpnYwh6e+5djHQzcmg
         9LAM+Rx82aEOFenuFe6MGKcJDuC59d9WH31O4GspuXz1RtnFijXmtQ8hqYsdzxa3rCW/
         CTPzozQk2Fp/GyZPq6ixLlvs4DgJ5brMadrNBjtmcaQCmSOiyl+0Hi7FvnBi2b2VwlrY
         xVeeiH6whM8dDOq+xu9IBwBQ9h8ojwW0YmN+kkvx3iujLVEODrq/kNpFXSZdCliBrniI
         qfKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730184000; x=1730788800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SmrD8WpF/OdMMrOZMzCUFVQhEI48ibTQY3atQcEu4nM=;
        b=k3W6PqJxKa+PFpCC6QuXFqwuR8Z62uhTTTaAhckoEZq6CD2gFZiSr1p7IhSFhNFYYN
         j5SRyISLaUYZuHbQkmJvFYL5w4BHzVRLsLO7weYFqSH0GAO2WKQTkL4jPG5m4FLpe1yP
         28F71cuhJEU7UgB9zDlwh3LlYy9hlThNFYXOm7UsKBwPCvBzD/Kx92fj+T2PeaZfltsd
         OEjuEgfURrgjFvURGfd1bR15yCldEsKTyyQ3xhzpoGPFeoNylc7u5TN/Ixj0vWk7OuJW
         Gje7PC37wflXCq5/zT5auPmi0w35LzE8olK9TvI1w6SAwTbLMfnWX6fsWQchTKDySEhX
         7ebg==
X-Forwarded-Encrypted: i=1; AJvYcCWzGtDyxQxIue98lkwlses4OEm9W6xgcsuE87AmHHgo70GBc75UejvGh8SZ45eA86qB1/JpysxK3g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzqacNJ8DkrWDfxHxlPGXWNtmhen58AV+x/tThN+2MOPYROlHdx
	LJu64sI3un/GVdzPfsqqDcFlOuVglV7KLV6Kev5RBcsoGltm+ueUOol9Q2rWG50=
X-Google-Smtp-Source: AGHT+IHvk9izIj+ZzjpdpqRGra6iF3H8KqUafcsWoWKS9IkQRHB1fwTjnsmShJ064C6yw8jOpQQVmA==
X-Received: by 2002:a17:903:244d:b0:20c:5d05:69b4 with SMTP id d9443c01a7336-210c6c06351mr149504975ad.26.1730184000220;
        Mon, 28 Oct 2024 23:40:00 -0700 (PDT)
Received: from localhost ([122.172.85.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc066488sm59857175ad.277.2024.10.28.23.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 23:39:59 -0700 (PDT)
Date: Tue, 29 Oct 2024 12:09:57 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: cpufreq: cpufreq-qcom-hw: Add SAR2130P
 compatible
Message-ID: <20241029063957.dszyl27kh52te73f@vireshk-i7>
References: <20241018-sar2130p-cpufreq-v1-1-822e00b9a663@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018-sar2130p-cpufreq-v1-1-822e00b9a663@linaro.org>

On 18-10-24, 19:41, Dmitry Baryshkov wrote:
> Document compatible for cpufreq hardware on Qualcomm SAR2130P platform.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Applied. Thanks.

-- 
viresh

