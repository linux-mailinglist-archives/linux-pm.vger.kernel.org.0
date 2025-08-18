Return-Path: <linux-pm+bounces-32509-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95730B29CE8
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 10:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27E8F7B5C17
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 08:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7F630C351;
	Mon, 18 Aug 2025 08:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="joLgrfFF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FDE308F3E
	for <linux-pm@vger.kernel.org>; Mon, 18 Aug 2025 08:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755507467; cv=none; b=JmHwDJr9SodFSf8tL03YgXgBp+alph0gOs+WL9KWOQsOoBhbZqM2Yee8mjDnqpxQ6z2NS/1hl3wTddYdQLQZbVE9QyaGbAMI2L9ngvIKqhId3inxW3F3nvzCUWCTb1zL1jdPNXUs2sSZXlZwcGwo2h633vKwFEgjvYAWPe4z05o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755507467; c=relaxed/simple;
	bh=U8a6I0ZFus0vFy7ECIXwDx8gidXc8/GABtP4Ugbvj3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mHMzqhcECwNOQtd+yeAa5SwfvHSPjxK4cDMZxlOU0vEljxrkGsCmeqeDm0CklZjmLJDGEDF27G1yZd1dZZrUpzGrF6/jP8BbbbxnKSKD/fzuHlq2jRU7QGPtKBRr6TSHT1d52eozSJs4riB3WtnyCEzIygQGE0DSD0Fdm0BJFao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=joLgrfFF; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b474a733bf2so298656a12.1
        for <linux-pm@vger.kernel.org>; Mon, 18 Aug 2025 01:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755507465; x=1756112265; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qe8G70eom6/4JetV7QH5UUKrtlBYh00PHg/YyriqGHk=;
        b=joLgrfFFDMF16c+OlfLqbc5LYzBoGzeW35Vcb+Ih/6SmgZvK9rQ4GB3Igx7zk1SRSa
         7Cqb/mOpzGIfuC7Url08iHGhfnTCVeYaKIP1OhAjkwPwiTfnr3phCpTazRTH8UCGXQpR
         yik3oTCKDfUpW2MvVykzbXPiZmo4vtPkRIJlPSXA7paAFCztpx3TMFZ6n2+Se6oyFUIo
         3GGczL2lrkSXMpMfRc78QdGFIewHmM9F84mgpkuS80Vu6ob6/8wfSRgTJS9L12OU3SfF
         yOa6SBNYgxZk2Meg/9pL29vhWKK/P+gqydI47mS0dVdbN8tmZBHo59Cz6gQe02qDHJR/
         7zFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755507465; x=1756112265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qe8G70eom6/4JetV7QH5UUKrtlBYh00PHg/YyriqGHk=;
        b=HT265GMy2Qze7iPLcyJhaFYRNNCZK0IWxfEbwbof74e9oEW6frOlAEQmxjBk8dHAsE
         Jf94oG/fVi3TsXQ9hHS2qAFv1DLbTbmBuD8gCCP6Yeh7xbBuUSYjL6MbVUzGuStwnL3X
         HUUlSRvXq24+jhq+0sxEmjtN1WYTQpCqHX1YL4UKYmp1/ZBlSCIntUK/b48Xs8ze6Fmc
         l1e0ySkWUZMCHulWbgpckf+G9ks/7wijTNDLHcVPLtogGbm7QLMWTPPAVSk6y+hI9O7B
         EuE5F7xnYT/G4VCcFGcb5UEJ4FHNGedFcKLaYAhzxORSxwnQlAoherCaxjXxfJeHhvhG
         mwUA==
X-Forwarded-Encrypted: i=1; AJvYcCVu9c9eNAwyVIhbGsqNg2s+gIXxZJRvpMlK6Imbj22LmyCnawzdmjciMfdXBZum7BjYZmJn/8KZvw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJATsQKHxk9OIpvyA1BtifisIBRsKfj+YhMOl99GZqiwdBiEcg
	jE8nU9AdXt5SlbPMLVV+eV1SmdTn27pNDsLHrpAwWbehjfpEK5XS27vWpTRA/RP0pcE=
X-Gm-Gg: ASbGnct3isDU0LSaijVb+ZALWkxWzxh1OLsAr+xghT3GZc4zmhpVvKmb36Cg9rf903M
	VyBNEXpu1zWqt+aTtExjGvdEdjQS/V/SKph9/JXyjwdU/TQN7kROzaa5WcYYvEOX5oNNnIJrkZb
	Lk1kHmKjY3OINjWhTJxjPrKav1iN6CxB/DrONyuHCoCKa7DalTpF+yrHGTFvtsAdo2yT05FfwU5
	Iij/ObJNpXnxJSllrlmhL3SOkDYzA6mwYNE0LQK/NLZ43Y8I2kXy1382q6yIoN1VIfZnKeiOP4g
	yNzHU++xuuoskPR7FhBiif46KwRkj2DUjX2LouDdp8AzbqwRjjtcrVGqsTimcZAE9rJrWGf+A9b
	P1s/NISzar7C6zHjLryYP1Dz0
X-Google-Smtp-Source: AGHT+IGpOHn1sY/HqKXMp8oqym8EA0mZNqXhfzJusUYFoebvw0MYrgm3dTzw/LGlv+S50fD/of1ijQ==
X-Received: by 2002:a17:903:228a:b0:234:a139:1206 with SMTP id d9443c01a7336-2446d916185mr159740845ad.40.1755507462625;
        Mon, 18 Aug 2025 01:57:42 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446cb0dc22sm74615795ad.66.2025.08.18.01.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 01:57:42 -0700 (PDT)
Date: Mon, 18 Aug 2025 14:27:40 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/3] PM/OPP: Support to match OPP based on both
 frequency and level.
Message-ID: <20250818085740.czv5lpbktpmj7cit@vireshk-i7>
References: <20250818-opp_pcie-v2-0-071524d98967@oss.qualcomm.com>
 <20250818-opp_pcie-v2-1-071524d98967@oss.qualcomm.com>
 <20250818085517.dj2nk4jeex263hvj@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818085517.dj2nk4jeex263hvj@vireshk-i7>

On 18-08-25, 14:25, Viresh Kumar wrote:

Also subject should be: "OPP: Add support to find OPP for a set of
keys" or something on those lines (I was more looking for the OPP:
prefix).

-- 
viresh

