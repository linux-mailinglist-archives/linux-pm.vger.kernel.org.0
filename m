Return-Path: <linux-pm+bounces-35891-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D388EBCBB8A
	for <lists+linux-pm@lfdr.de>; Fri, 10 Oct 2025 07:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC65319E0CC2
	for <lists+linux-pm@lfdr.de>; Fri, 10 Oct 2025 05:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC4F265CD0;
	Fri, 10 Oct 2025 05:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p2bwy6/W"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7B623D7D2
	for <linux-pm@vger.kernel.org>; Fri, 10 Oct 2025 05:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760074147; cv=none; b=Y2rLPYUQ2M/KEWfzDzAVOUEk+eN2WGUiUq3X4VCjLDFKgNs3Bz5uDrmSqHCfaO+xt4in2k5xVKytI2dcjJepWah5girKyKSxYmJ6d0ScS9E0m3R9Mvq/QF2Sh+nxvurMFkqB8BXsACQuFG7Re1TMqL/xm0Su3khWa4tWlyWVsps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760074147; c=relaxed/simple;
	bh=8aR+InBDnBjn09cnwllCT+9UwMA0LVX9Wn4YRKaxBLY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GX11YLTrc5hTeBH6rqR8sL3lihYRW+MmN6yPJ5oGloWFLBD2vZRnVfD6147r0Ci4AnLfkLiV3+KgUIRAv9Kqz/w9paCgK2KoM+9rzRAncL4D1vF2HtQt3eMap1KB3huf+jteT+xL2eLHM59wWPi7OHtzbYV+MkCjdn7PIpl3QxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p2bwy6/W; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6318855a83fso3597316a12.2
        for <linux-pm@vger.kernel.org>; Thu, 09 Oct 2025 22:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760074143; x=1760678943; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8aR+InBDnBjn09cnwllCT+9UwMA0LVX9Wn4YRKaxBLY=;
        b=p2bwy6/WUIHRboQGuzwx3CKzj5GpwrXYeEMxPfjp25vfUnXlElyNPsyvuVjOSuYQQd
         ijT8HZnozmJdj5czSOQKRcL4Oqd8ILE4fZSwwMTYkXiPudrr85EJNXm8dwm31OScRQ/A
         r/9nRC0U1VVwomgPxC3NnHvj1gRqzJ2d7hAC9qtlTPha6IHT1O3Zcp/3jgAWd2ULJK+O
         zOB2h3Q5FW/ERZKgd1k5ok93ziMyMrPgMYsjn+kRko9XUMOZuLXpeUpkqTh9qdvV6eFw
         emv50INM8hLOjWcHTpbfr0JBkTu2w5IcKvqehYIRMHdEnZtMm4qHJ11kjOIWwFTa62F+
         /Org==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760074143; x=1760678943;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8aR+InBDnBjn09cnwllCT+9UwMA0LVX9Wn4YRKaxBLY=;
        b=KkCuIi5VmfOONDWOEF/bh9S9g9qT/ByyqaFN8J6JhrPv2Ydxq7zyvnSgIC4eGitwd4
         4fqM230f+F2mVyLRC9ypvzvnpipYCI8BzmEVmmozYJZyXow3ZOO5guLnBOFCrLShyn6E
         ll32f/nCO4ICfSAyiT0FYinHXevR0vI/5bv2noYRWpxRd47rQzysQqgg5NSl+HzETABd
         c5gIZ2KfOCF6vSQm7bfgMI6w/2u/z5NHxYaTYEgrHSc9avtg3iFdanhAMLy5kjTaWzPx
         QkA6ZvJA9/E4N7eKGiuq6rGzuoMfL40izmbSGSoTc/GafNw2n0RVnLwvIhZicw+y/LmU
         wUiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmFIs1Axt1M02uBq0CvsGxT0D5Ulw7aNsKzIgW7CZz9az5RtkqTyYGmKbdJaGIRkImi419ZfWzlQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyhzB8vWmdDyUS7ASMCvCIdFTADCIEQ4+6WpTSNQ4OdIOmpefXx
	IIym1ZL0wHOw2tNpgS3t8viNuzKo7Aif2ZFz4OY2RXu80mZZdFypkPfGHCDDNgbUQ+Y=
X-Gm-Gg: ASbGncuvvCrNhw7tMFpcYqb0fyDy3bZTxJ0Hs3mSN76XgqxzGZI8OrDKUqrhSE1rT6k
	FQmY1+bPcA8g0cgma6xhb9EEMf11FIZBhzsyI1h/WnLAdJehv3YQ+bRWaleoDqxuYlvJkux5v3F
	ZsezT+jm0cNSOvT0AG5pky10X5KTmlP7b/g7jRg17aepj9xTCuyfv028evGjFhoxSJdaKCBXm2c
	lMVsCSzLJpH+RdAtClVaiyPdGbtbWN45Qi0Tz5BHnbs2P8+MiDtCjtvYJpT3OqDzQNxD6+P0vhG
	MSBYuoawmeoAFIz4M6zUv8zdi4Kkm7EUJatuPEbyZIX7EmDyYe4vXxpYfQyIGEa3JB7w+UpTDzg
	kdBfXZUPtCzUDUc3XjCYsawNjkdgixc8Xy3DqYHDvLxfITkhL
X-Google-Smtp-Source: AGHT+IG0R4w9Z3PlluIRXd9lN4bhh6YAYGuTKxcKQNJqwpna264jwoUI8J+xZkraphoRjdWXanfcWg==
X-Received: by 2002:aa7:c594:0:b0:634:5297:e3b3 with SMTP id 4fb4d7f45d1cf-639d5c79798mr6900276a12.38.1760074142813;
        Thu, 09 Oct 2025 22:29:02 -0700 (PDT)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a461703dbsm1459171a12.0.2025.10.09.22.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 22:29:02 -0700 (PDT)
Message-ID: <a00c61f8c705ace0838ac021489d5300ea95dc21.camel@linaro.org>
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
Date: Fri, 10 Oct 2025 06:29:01 +0100
In-Reply-To: <ee66dca6-3cd6-41d3-82f9-d2673da00287@kernel.org>
References: <20251006-gs101-pd-v1-0-f0cb0c01ea7b@linaro.org>
	 <20251006-gs101-pd-v1-3-f0cb0c01ea7b@linaro.org>
	 <5df18f42-b567-4d27-9e12-29723af40d6e@kernel.org>
	 <9d4ccadf76ccfff1a8b5f572b8aa190e2dc40c29.camel@linaro.org>
	 <63fb3ccc10267add00b579d4a05497cbeeadc65e.camel@linaro.org>
	 <ee66dca6-3cd6-41d3-82f9-d2673da00287@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-2 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-10 at 02:35 +0200, Krzysztof Kozlowski wrote:
> On 09/10/2025 23:00, Andr=C3=A9 Draszik wrote:
> > On Thu, 2025-10-09 at 14:31 +0100, Andr=C3=A9 Draszik wrote:
> > > On Thu, 2025-10-09 at 09:13 +0900, Krzysztof Kozlowski wrote:
> > > > On 07/10/2025 01:43, Andr=C3=A9 Draszik wrote:
> > > > > Convert to using devm_kstrdup_const() so as to simplify cleanup d=
uring
> > > > > error handling.
> > > >=20
> > > >=20
> > > > This is either a fix (then describe the fixed issue and add Fixed t=
ag)
> > > > or you change the logic, not only simplify.
> > > >=20
> > > > Previously on of_genpd_add_provider_simple() the memory was not
> > > > kfree_const. Now it will be.
> > >=20
> > > Indeed it's a fix after all - While the driver doesn't allow unbind,
> >=20
> > Thinking more about it - at this stage, this patch is not a fix. The dr=
iver
> > can not unbind, hence there is no leak to be plugged, hence no fix.
>=20
> It is about error paths. Driver can fail binding.

Thank you Krzysztof for your patience. Yes, I had overlooked that
of_genpd_add_provider_simple() itself can fail. Sorry for
the noise.

Cheers,
Andre'

