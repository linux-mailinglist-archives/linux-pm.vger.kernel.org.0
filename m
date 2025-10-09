Return-Path: <linux-pm+bounces-35842-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 990FDBC9673
	for <lists+linux-pm@lfdr.de>; Thu, 09 Oct 2025 16:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9BD7A4ECB5F
	for <lists+linux-pm@lfdr.de>; Thu,  9 Oct 2025 14:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5D62E9EC7;
	Thu,  9 Oct 2025 14:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CdA/9S6U"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B3916EB42
	for <linux-pm@vger.kernel.org>; Thu,  9 Oct 2025 14:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760018438; cv=none; b=GoDNkmqMD+EgtRKzNvjMLvVrb8N2GdUeKqV5ph058kkotFxehtZW/2UIAYgYMVLEVNZQ/gUaM5d+qK2TX435BYLV44MWeXBg4h8WTVYmGaQOccE6gIUt2lMoBSfu4Q2QtfHBOEshMoeGEpfaXThiarhiZRvCNDG3b/HDXrA23pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760018438; c=relaxed/simple;
	bh=krqjWeofd3soeCmbUM50pDB4SpcRGAW6LDs+oBWEOQU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iS3bQ1OLSgVPJpKuFO7d4R2JlayWGrYxQSSRjWQr9tfvOkMaDLte/SZsadrqS+Ncxs7svIHGH52yWZzJFiZykCX/tBK66w5eQo2COWBydpeZYiMfuS33jle3PNkYamgepxo1xj3RsGVBUa5FxQ66Ub2UzZATfl38X31+f7akF2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CdA/9S6U; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6399706fd3cso1642990a12.2
        for <linux-pm@vger.kernel.org>; Thu, 09 Oct 2025 07:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760018435; x=1760623235; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=515o7326gcQ3D6uHqGhrkvo5xmocInFa3UoZMccGVHE=;
        b=CdA/9S6Ut++bW4H4RuOzSH6/eYUO7lDxHf7FT7LOkwlg5dVXFKi5J+rphteHJa2eAT
         u7q9Xryp+CF4EXns5Of46qcKg26wd/pM5fNxMSBvXlqzrkzNhQw4FmYR3TWLwiWZJ9Xa
         up+KaIbW/RnJKoiehPccMknJNWpenFcWR3VHYE+iVroQQGK51kM57c0+JLmq1MPq1nJ9
         tQhjHhlWdA/95q8XWso7Kah6iQs+6dye9nxDBZfrY1sFGDaJrI9W5lxxIhPuzRtJWkYu
         aO141egnW7d4SteZKCwy/cc5QFExang06bcfyBQAGf1klNtOrJkL2cY5pr3UTa8Mvk1w
         kG6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760018435; x=1760623235;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=515o7326gcQ3D6uHqGhrkvo5xmocInFa3UoZMccGVHE=;
        b=e92q8WRXXDviHuPfMHOdrxdHPcTDc83FZn/EyiloNI5/8/mcctZV/tE5AlkTHcvH6D
         3/Yng0ytvOkWm2UYRKYC5WRMBSYuE2Erzym77mI8FdS+HLA7RLuKFrXEHC7dZxcfY/Ti
         DgMEY7ONrMcgpORUrYUTcMl2gjJauqRlFWKapKsT+MugF3MmFqRsetituPIWwUyiw9vz
         X++aSn5mpsikFRT01lh4U6laHX2UeQvAerNWSzvtGIEFHWIvgzn193bV9B9y+kaE8iRT
         kH9NScBKOwtwBvoaC4MvJlvoogefNHsWsWo+vYF2fJFy0FXHOOvHS7UQ1m+SIfq2iWJW
         UHbA==
X-Forwarded-Encrypted: i=1; AJvYcCUxp5Lre3RlhfSUGAMtL5i8HnL7j+xeYUTbJENHXQttPZ6cg76Wa1XEVncLsMCqYV+a9qfRcskp4w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzbYTii0NpN9YeWIoJsDSEsxtbBedIqIYUj3PngEvbLUAasxbkm
	nXVH3OXDSvJX6YuQwyjnxRi/uGNypCau1FwrB6WWvSDZQLeOYrKv2Zz0WgPPciDlAks=
X-Gm-Gg: ASbGncvJ+zSpRMOhu9jtoeMeY9/yubEDNp7+WL8uyMU7Sm0gG99gaHCpgovsT/oNpFb
	qj65yYq/ZD1IoUYJSAoSX2d/Fw38QnrVuDPgJ0bgJKx6AicVjG+JoJ7NvbK1vTzqi3t/j2dT4ye
	kgt2G68yJdAt51xalkiZeIn1KqyuoFwlVmTiA9/Gn3UTOG7C3C9j3yOya1IYTI5xD0U4pcjELnW
	035HhLYzUF1VGeiqKlR4qFm/zwmMFqBtzh6xtxohB4Zsxt10CNXNlvGrFT6X+rT9CKkSHESV5Kr
	4heK3slzPe5MTmTKXGMxN2j5WIqqGSfIUXL3G1qEu47TfPgRb1qCWmogKUzC2cpcW3XZjkX6nsU
	/Mv/4/5CMaVil/oCHyNVLgoWL//A3pKbI2CaSkTaG4tlyrv9+KjgjvQ==
X-Google-Smtp-Source: AGHT+IEgmsVd+NJKivv9Nf15rZIeHvCLH7dQTFIvwmRIDeiyvpI4bVIdaRiBfWbq7EmQkO2KbsnQcQ==
X-Received: by 2002:a17:907:c27:b0:b3e:256:8332 with SMTP id a640c23a62f3a-b50ac6d378amr903062366b.54.1760018435004;
        Thu, 09 Oct 2025 07:00:35 -0700 (PDT)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652aa62csm1860412666b.19.2025.10.09.07.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 07:00:34 -0700 (PDT)
Message-ID: <63fb3ccc10267add00b579d4a05497cbeeadc65e.camel@linaro.org>
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
Date: Thu, 09 Oct 2025 15:00:33 +0100
In-Reply-To: <9d4ccadf76ccfff1a8b5f572b8aa190e2dc40c29.camel@linaro.org>
References: <20251006-gs101-pd-v1-0-f0cb0c01ea7b@linaro.org>
		 <20251006-gs101-pd-v1-3-f0cb0c01ea7b@linaro.org>
		 <5df18f42-b567-4d27-9e12-29723af40d6e@kernel.org>
	 <9d4ccadf76ccfff1a8b5f572b8aa190e2dc40c29.camel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-2 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-10-09 at 14:31 +0100, Andr=C3=A9 Draszik wrote:
> On Thu, 2025-10-09 at 09:13 +0900, Krzysztof Kozlowski wrote:
> > On 07/10/2025 01:43, Andr=C3=A9 Draszik wrote:
> > > Convert to using devm_kstrdup_const() so as to simplify cleanup durin=
g
> > > error handling.
> >=20
> >=20
> > This is either a fix (then describe the fixed issue and add Fixed tag)
> > or you change the logic, not only simplify.
> >=20
> > Previously on of_genpd_add_provider_simple() the memory was not
> > kfree_const. Now it will be.
>=20
> Indeed it's a fix after all - While the driver doesn't allow unbind,

Thinking more about it - at this stage, this patch is not a fix. The driver
can not unbind, hence there is no leak to be plugged, hence no fix.

> I added this patch due to the followup patches that add potential error
> returns during probe,

since it makes the error paths in those follow-up patches simpler

>  but somehow missed an already-existing error
> return after this call.

Ignore this last part. I forgot that I simplified this error path in this
patch myself :-)

So, I'm not sure how to rephrase, tbh.


Cheers,
A

