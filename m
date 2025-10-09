Return-Path: <linux-pm+bounces-35841-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 067E0BC94E9
	for <lists+linux-pm@lfdr.de>; Thu, 09 Oct 2025 15:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2317F1A60C2B
	for <lists+linux-pm@lfdr.de>; Thu,  9 Oct 2025 13:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870C22E6CDA;
	Thu,  9 Oct 2025 13:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QOYpd02K"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF2E2C21D9
	for <linux-pm@vger.kernel.org>; Thu,  9 Oct 2025 13:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760016684; cv=none; b=Lw4oUemr8QcB8OG8fWznm08X8GTvPHbmuxkvyTM48ovKBh1i4J+HEOrmeVv5xiMey0EJc0ATfuIdBDRfXlQuwENphEBDIQ2Vu1M2mFxXD2Ybq7TlABQgviFTyCUq53XbvYorF4uCHmhRJT1Qf6ak7qiPBPTRUrnLT+Y+I2/jf+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760016684; c=relaxed/simple;
	bh=4uMuw9n5pwbOi9ibO0Djym5GMms0Of0kx57oeDZ/s/s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b0slTJ71UdZdYsIr03ZvfqRu1M/ZTKzyts0uTyBGHkChhtzaAuekL/Kzba+c2GWgI9MGzI+MWYneSXM+fqPlwlgNmaUZd1WmkFCLP6ly5nUGILMxQ09duBwS+AMZIWXDgwp0dJ5+BPYYVm+RkCN+Van/digQpQfVm1Dvta8IF2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QOYpd02K; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-63963066fb0so1934969a12.3
        for <linux-pm@vger.kernel.org>; Thu, 09 Oct 2025 06:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760016681; x=1760621481; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4uMuw9n5pwbOi9ibO0Djym5GMms0Of0kx57oeDZ/s/s=;
        b=QOYpd02K8BVgNunRW7q+mLlUaygR+qTqS46lbZKjTaHTxrBVGFu/XS56SXqS6lEl1s
         AR9Z3Of9CdnuTxKzHufvGgPmBuMbj5wN7FdFS7OhblKcWPYcU0xVVk17QcnozeQc5NlN
         3t58Ff9n8TcIXt5jbCIq2kiPrxypK/kxOAADc7VJU7FDn5QtnjF4jvkGa4RRJYvKs36g
         CBdJOnige3e0uILxxLYTM0sW9xze/h9D4yZah453EBY7UqePVO6KOPtfXm303AkeAu7i
         YZQ/qhx6NG+SZBA9vmKpN0skfQ1SbAVKZyEaZWwx8t+t/x4LCe1qt4ft4tdTVif1VQ6d
         eXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760016681; x=1760621481;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4uMuw9n5pwbOi9ibO0Djym5GMms0Of0kx57oeDZ/s/s=;
        b=LdUDBb2qiv6RgJrcwnVeg7G2C7KwsUKFlYJtNA4jr9EznvdgmgCNMqLE51/qKdCKr4
         isNfH7b6/z4CNTvt0o+z6WBuhMykihMU7/4GqQMrsBH1qLNhFHRANhwVxW/btUVPVsbQ
         gL1NmrYF5vQliRJqm9xEZx0ubB1CRdIqoKUJ2PjWqHUHommWiPHBG38nkzzSj5GBrF3s
         Iwsir/PpOC2ON5IdqRseqRJHtFBCFjUvOHjTS/QTTMkeeyiY2rFH5ddnfT7M9hIdV02r
         DPu8/u/DGw+KxTY3iMghn1wytqFDGCl/Sir3M6HyQd9xPPoBXkCg0S4Q4N6dS4+6flnE
         pgVg==
X-Forwarded-Encrypted: i=1; AJvYcCXrk+nukNFZZYrKm1UO693MjDA2BBlRMv8B0z7DmojSiRzL1ky/e/Ge4jVX7MdZBpShCKoAXAHsiA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1VARHpz0EWz6cqWdV0S/cSjregDkOA3lwotlvQ8yOBgf7587R
	Hj+N28+kyCq30hlw3MwibQI8H4CE+13Jxahrh+0ynrkvq0+1adN3hroCbJjp7rUI00k=
X-Gm-Gg: ASbGncs3YPduFH11VnrBHKwR++1uQHJ59gG4mFgZkAvyW+eFqK79QAEy+OKcaU1lsPc
	7tmICBWXqfdnfDuHrztsTrBGIiPJ7LREQCCPRulQ6CFPuw6cSwv5xRjBFRv3Kxw5HCf3ctsVISj
	1U+vQ9t0rOy+vC5sBi6RMK27P3YUmm8s0j32/aY151KXMpi9hhnrjcnIzDaFPelO9IVZmbDfcVb
	jETkr3n0OOW8b6Zr5Wuyqq5BEhStUNGvppC2VNM6h9cBK4QrIZDruoTO1imWtrVQ37ahwy0Ezzv
	RrZEtoav2ziilfLjpWynt9nEOvTiK4np7xRgW9Kgy4bA0P8xGsxYrQ2Z2x8WanT/nuodMtk4KMF
	VY6EMcZTowWKhZ/Tv+4skJ0fRkgpwdW7aHoPDy3jlSN8RDVOytqyc5w==
X-Google-Smtp-Source: AGHT+IEnaDw79r99A3B3756aMdxT7SHXjMqW6rLoG3x0RAXtUbJZNUbfM/vMx/v7BA9OApMfoCnFYg==
X-Received: by 2002:a17:907:9720:b0:b4b:dd7e:65f8 with SMTP id a640c23a62f3a-b50aaa9bbe9mr879682766b.25.1760016681115;
        Thu, 09 Oct 2025 06:31:21 -0700 (PDT)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652a9ebbsm1905425766b.7.2025.10.09.06.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 06:31:20 -0700 (PDT)
Message-ID: <9d4ccadf76ccfff1a8b5f572b8aa190e2dc40c29.camel@linaro.org>
Subject: Re: [PATCH 03/10] pmdomain: samsung: use to devm_kstrdup_const() to
 simplify error handling
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar
 <alim.akhtar@samsung.com>,  Rob Herring <robh@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,  Ulf
 Hansson <ulf.hansson@linaro.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, Tudor Ambarus
	 <tudor.ambarus@linaro.org>, Will McVicker <willmcvicker@google.com>, 
	kernel-team@android.com, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Date: Thu, 09 Oct 2025 14:31:19 +0100
In-Reply-To: <5df18f42-b567-4d27-9e12-29723af40d6e@kernel.org>
References: <20251006-gs101-pd-v1-0-f0cb0c01ea7b@linaro.org>
	 <20251006-gs101-pd-v1-3-f0cb0c01ea7b@linaro.org>
	 <5df18f42-b567-4d27-9e12-29723af40d6e@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-2 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-10-09 at 09:13 +0900, Krzysztof Kozlowski wrote:
> On 07/10/2025 01:43, Andr=C3=A9 Draszik wrote:
> > Convert to using devm_kstrdup_const() so as to simplify cleanup during
> > error handling.
>=20
>=20
> This is either a fix (then describe the fixed issue and add Fixed tag)
> or you change the logic, not only simplify.
>=20
> Previously on of_genpd_add_provider_simple() the memory was not
> kfree_const. Now it will be.

Indeed it's a fix after all - While the driver doesn't allow unbind,
I added this patch due to the followup patches that add potential error
returns during probe, but somehow missed an already-existing error
return after this call.

Thanks Krzysztof!

