Return-Path: <linux-pm+bounces-31869-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BD1B1A055
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 13:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B7841895D8F
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 11:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068B2253B5C;
	Mon,  4 Aug 2025 11:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dlw3pFsq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAFC2405E8
	for <linux-pm@vger.kernel.org>; Mon,  4 Aug 2025 11:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754306025; cv=none; b=XAN+T1BKcCgxFLUipVcEgRyYh/2slbtW2KPg6u30rMHErOPY942vobHXY0jZcS1JkINK9dsnn8dhb1QQJDxCYqU8WjORjztxBnpqc8cOnrkt83iLmEzazAL1Ugsx/0YkM2qEcEsxiXhSo3Pl84tSz8ps5ghI/vF/lYPRFtkrZZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754306025; c=relaxed/simple;
	bh=/yT6SIbwMsDyXivBPq/u5jEb7k18emFAPJlUdi6+mro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7jgQDZB0FrZ9ioxukJBK9mSv1xtP44wLVY8lIz0CEcNehFdpEncHiX09C3fthIGDoCqUtK6wuA4do7Rwlj75P2BAAOSVldClyKbQOGIz0BZVZtDKE67mzXwoNuBylIkuL62nF+eq2V8pWk5CRu4T9d23GFakh54Uf4kxNHXbDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dlw3pFsq; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7682560a2f2so4050680b3a.1
        for <linux-pm@vger.kernel.org>; Mon, 04 Aug 2025 04:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754306024; x=1754910824; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WYxFvBBR753en9vuNva6YOR53xSyO7VCvwj1GDT38Q8=;
        b=dlw3pFsq+p9GpRztCVrhzKP0lJcpdn5txTF0zArhvSwBI1CV4XDYWXofEwTCLcZYg+
         fVtPrkSWcdS02TXPg+Uv7kkqnqWeWwIpHQ+xuc+WBxbwUW7PAtfFt85cbfSsutXrxzS9
         rpceV+yfasP5YpzxuiCBe8Sx7zS0/8FGZc7DpIZ8HfzCiV+ZsKrmQ/ppSQ1KOAeU3qGk
         j7J5hetgKsB/9jBVI2g5ohM22iSIUedveBQkoGcxtgYXRmdT4ABkyaZnr2Ej0g2MRES4
         4qVmNVuqDDTarQElVNS4NtkI/SJokDkeojnnQQeBQFElpH/w0U0Xaz6b0mvEckv/vSgu
         Jp5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754306024; x=1754910824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYxFvBBR753en9vuNva6YOR53xSyO7VCvwj1GDT38Q8=;
        b=psvSGytNDyHP9Q8r1zHHevHrJrK6uKHRP9AemC8WRZ0dfuk12MitvVh041aswkuFJD
         EAqK1FUBD411tOlzHyUTSeGRImrhbyOA+cj+TrZrATNRqO+Uj1axgYUHzdJfCl8st1fk
         NATewNWqEa0NOf2OeUghd6BUMvNLeHoQG++7b/37EeeS0doz605SMdCEXvEuBwHqWbar
         lEBuffDBYpIQQqDs8ImBJt/gbFTheZIZOsk6PqseQUiQB9cCMJpo/uRujVtBpimENHjt
         pMwJ+nhOimG7btxzVaEM2fElEfBo9pbBV0yU/i5CtY4gfHQokX2yBib/i1IsMvEoFAFJ
         d7tA==
X-Forwarded-Encrypted: i=1; AJvYcCWTnIxQsUbeDsd/rk5nRsivWrzibt9+vOd19UhdgfxexfwRp7AS9Q2OM4ElUrcUeMe2tRgkxr/A+g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl8PLYp+NhsxO5ZPFbW5k9y5Xzg3xcs3qfCrvd4LqN9DGTzTSr
	8qkwony/zdy8u4iuss10VKZNNN76EP/2OL7dpgq/4NaEgQZJoG4raGhrnlr+gXIXDAw=
X-Gm-Gg: ASbGncuYNPPQH59+9IccXOMdyu/xyZ/gaeJAGWgH/XgpPN/A2mzAiPHxMW+lKk15PRr
	u8lCMSUkxoylWfNb0gYY35GUn0qwKrtSe5y0lNCVHuX9FvgM5fzeNxDZMBf7d9QS4026HQ4p1Ko
	5xgyIyhACBsikkZzeUB8+zF0CiZ8uy378e3sR3F7n0Rlh3XFlQgyC6bYuVmQdm/8W6MjTYdDkWm
	RMq7aCypcv8zwAnplQ6n/p7Oz9ShYGpnJBhhrAPRSN7Ps70/cY7ePbwGz7ngidB4Oflku9QCo9G
	0W5H6sRUol+7wgwxzm9jMajEpodMVk3TAoJsXA4VxbLfFQMgfGclJMBefFre9IsVksov1upxG9O
	gtRS+7zN1eeOr3/Mp2mSPGOw=
X-Google-Smtp-Source: AGHT+IE3KOgmXKzWVwIXatZUzP0SpT7zF9MWUThR1kMx49+PPbc0ii9e8sraQgCudSaaczTwkfvsEg==
X-Received: by 2002:a05:6a00:ae15:b0:76b:fdac:d884 with SMTP id d2e1a72fcca58-76bfdacdd96mr5449606b3a.3.1754306023713;
        Mon, 04 Aug 2025 04:13:43 -0700 (PDT)
Received: from localhost ([122.172.83.75])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bfc270514sm3545933b3a.12.2025.08.04.04.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 04:13:43 -0700 (PDT)
Date: Mon, 4 Aug 2025 16:43:40 +0530
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
Subject: Re: [PATCH 0/3] opp: Add bw_factor support to adjust bandwidth
 dynamically
Message-ID: <20250804111340.t62d4y2zg77rr3rp@vireshk-i7>
References: <20250717-opp_pcie-v1-0-dde6f452571b@oss.qualcomm.com>
 <0dfe9025-de00-4ec2-b6ca-5ef8d9414301@oss.qualcomm.com>
 <20250801072845.ppxka4ry4dtn6j3m@vireshk-i7>
 <7bac637b-9483-4341-91c0-e31d5c2f0ea3@oss.qualcomm.com>
 <20250801085628.7gdqycsggnqxdr67@vireshk-i7>
 <7f1393ab-5ae2-428a-92f8-3c8a5df02058@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f1393ab-5ae2-428a-92f8-3c8a5df02058@oss.qualcomm.com>

On 01-08-25, 15:05, Krishna Chaitanya Chundru wrote:
> Currently we are fetching the OPP based on the frequency and setting
> that OPP using dev_pm_opp_set_opp().
> 
> As you are suggesting to use dev_pm_opp_set_prop_name() here.
> This what I understood
> 
> First set prop name using dev_pm_opp_set_prop_name then
> set opp dev_pm_opp_set_opp()
> 
> if you want to change above one we need to first clear using
> dev_pm_opp_put_prop_name() then again call dev_pm_opp_set_prop_name
> & dev_pm_opp_set_opp()

dev_pm_opp_set_prop_name() should be called only once at boot time and not
again later on. It is there to configure one of the named properties before the
OPP table initializes for a device. Basically it is there to select one of the
available properties for an OPP, like selecting a voltage applicable for an OPP
for a device.

-- 
viresh

