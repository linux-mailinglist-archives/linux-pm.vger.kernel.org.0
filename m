Return-Path: <linux-pm+bounces-32515-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2D5B29D5D
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 11:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A832A1885754
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 09:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949DC30DD1C;
	Mon, 18 Aug 2025 09:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C9W1K+cT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7CC277CB1
	for <linux-pm@vger.kernel.org>; Mon, 18 Aug 2025 09:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755508418; cv=none; b=efkmJH2vkXGf4Tw9OdoqNNeWob9b/LYq9LwL6y7RzJVnqH83Hivpd5LUQfVecWl+W7lVvPBdaW9jCQfGVx/NvM5sFfZ3EjlsqqD5IqtG424s0u0eINfQyNCTjC8Uj4o4xd8bDF6uLpsOqeqN4Gq7j8nayCvEdq/ktICA3Z1tz14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755508418; c=relaxed/simple;
	bh=xelw41k3pm5cV8Se8ISfXTeVZHnkMuKVO9e05eqy3No=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MHstDGIlgp+iHYoOlz2tZyKw1he20DYD34AidHd4Mq9H1/pGYOD3TK72q+OUgT5EwPzXWxP9Lxu2o6vmHnvgww25n6UAVaNP6apoZKOrUS+WXnm/noCxKfaKJhTOzRe2VG7SHbTG180Rr2yWMQhKdoR1bhLF44nkr4YnWO6qEss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C9W1K+cT; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76e2e629fc4so4064309b3a.0
        for <linux-pm@vger.kernel.org>; Mon, 18 Aug 2025 02:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755508416; x=1756113216; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ByAqf7ew0qsvJFSkObrVJcMa/hiCKQ4k7aVcvlUbpt4=;
        b=C9W1K+cT5ps42o3H9HzYBnM4SPO26FQcXEVBikx9EfxJIgbUgTjQh/A1vVVVo0ipZw
         jTt85Q9ciyP1y5VGy7QLDV7ft41Qzb4FfkkXL3slsxH1+rlgiDc7Xd++nU6RtiIoBPKI
         L6/Rzr2zHDjL3GN5WoEfYPn1SYFGiMQULulV2qc+3FERwucLibJTdVxqu9RQyaQyeyf7
         wbHN/lijD+5af2eb/dNiOcq+WDmqkixx3thL2CRhLntiTtBcNkdvGms9GTQMmAYWsuCR
         xfu1AfjnzJsrrzFuL8m3f/Sggy3ty+PKgb3TTH8tmbLWYYOWRQHDH3z5+ysD1MHb8l+3
         8ZYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755508416; x=1756113216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ByAqf7ew0qsvJFSkObrVJcMa/hiCKQ4k7aVcvlUbpt4=;
        b=aOUCrjf8zFU0zn5Qq0cvJUmIN5y2z/u4a8ibl6oj59qLmkHs2mgBhqgDkgMdlPa4jF
         mMb0+LSf/fiIkxT7JtMlofkMAC64R1fE6sgLh9GpX2AeEMnVd/OyduL/i1lGQNnEq6Hy
         1rDyggsAo+Dog0Zr03lEVPHUYxtQJpghXRGhxzylrDxUE680dEwpiRkP11MDx0yCCEE2
         A2wqzBhr7fT0rOVbvP6KQJQ1XTrPDHP55cg82+O6MLuZVVbOtN8xzNKrSt6VoHHdhHk7
         W9TI2L6Xdg32VuwmmD0VUgYuBIi36mAxQRPvF4ro8spkqs1FEZrtY067ti8YfWMdfr96
         XcHw==
X-Forwarded-Encrypted: i=1; AJvYcCXf5l0CZumlPKq+LdOYkkUKT5iu+vvggK198OtMrDPGEeY8At8KfcBxKXiTdViYFq3/uP0Vu+AHjQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGT88xL2I57ocMRS8GyY+f4iSmUwK8k7abKsA1FzUtQwlQC7zy
	wRcKfTuDMKfKrTEf2QNrVDAGzAeLPKrebWXi++jT+arPyCmjJ0R98EsXFeXwgiF8H/E=
X-Gm-Gg: ASbGncvNFKxl+atrwLUEwFIgDPJbbWVx2by8qxis3jwVsfUP+m8JUMx/aDWqk3fhVqX
	vgwjELu/pwo/cl37ikPsiuGMqdYgOrHBSytpKIrFId068aKqpgzFeIBwf7eoK47GPUhDt5LtSZa
	duogYEmNsVbB5NHrp5rw4VoSB30bE8mtx0rPsv6dB/FcvWVBJKN7SVS4uJo4wUm0Smo0DWFizBc
	shJ7zIHmD1/5L/toL+Ognaekcc/jThPknkt5wVVL2PhJjv0bEB0kMnVYd+PR/FRtwAyh579xP5M
	vilDW33F8dLPlRcVg2LpPlrHj/FD8bPWmC8C42QZDu1U60kvLnP/WLt2SqQbiL3RCL90zsJwDyf
	zpAlZTaYrxc9krCpvhkLaIMOT
X-Google-Smtp-Source: AGHT+IH4KDM7M4CRQXVnB3k6j8efu5yywyMexkJLQg2z4smAorz+ZWupNwv9P9EteJCL5oCvCbiASQ==
X-Received: by 2002:a17:903:1b04:b0:240:150e:57ba with SMTP id d9443c01a7336-2446d6d33d2mr159454275ad.3.1755508416372;
        Mon, 18 Aug 2025 02:13:36 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32343c4d680sm7505714a91.21.2025.08.18.02.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 02:13:35 -0700 (PDT)
Date: Mon, 18 Aug 2025 14:43:33 +0530
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
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: sm8450: Add opp-level to
 indicate PCIe data rates
Message-ID: <20250818091333.qlbipfkg2hasdzwi@vireshk-i7>
References: <20250818-opp_pcie-v2-0-071524d98967@oss.qualcomm.com>
 <20250818-opp_pcie-v2-2-071524d98967@oss.qualcomm.com>
 <20250818090240.in7frzv4pudvnl6q@vireshk-i7>
 <5f3261c3-3e44-42a5-bac7-624ce4e7041f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f3261c3-3e44-42a5-bac7-624ce4e7041f@oss.qualcomm.com>

On 18-08-25, 14:37, Krishna Chaitanya Chundru wrote:
> I tried to add the level as prefix as that will indicate the PCIe date
> rate also instead of 1, 2 to make more aligned with the PCIe
> representations. I will update this in the commit text in my next
> series.

Okay, I will let the DT maintainers confirm if that is okay or not.

-- 
viresh

