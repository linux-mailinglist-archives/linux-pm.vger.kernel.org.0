Return-Path: <linux-pm+bounces-12815-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 361D095CBBB
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 13:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 532A91C20E68
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 11:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A776B18754D;
	Fri, 23 Aug 2024 11:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xj8a4QtO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043F415382E;
	Fri, 23 Aug 2024 11:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724414014; cv=none; b=U/9+LwOvop6GYFh/IKyFWlUSS/kzd4f9XMI26VHQ2Y90M6DkJaWE7y1IZUIkAJAHaeW9iBeogZffNvgim1XHbEQ4yLZA5KRHV+6rTa25/AtfIsyGlubmrJBS6YnFWXQnPuN+9tytMAfzbvmwKhoiLgYNL5yRn+HGopSiKGA9jcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724414014; c=relaxed/simple;
	bh=bkd8aOXZmdZzWEyDAhR8G5uVU8gVqqo3IxhELzNqYD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gie24x/HonEhz8MfAi//gXruIj2B3RVRiMnMjku0nN7ooenlPZUYCohGJhrp3lu/m7lyKFxS3WFOhxjNWT9H5ghSy5j9eerDQ7a+/9bZ+2QX6ZYomJzMMzVScZ969lIv/D5Gsq/Dk79fOGr40M/LUrCeYh1HW6kWVsewFtwlHUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xj8a4QtO; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42817f1eb1fso14879095e9.1;
        Fri, 23 Aug 2024 04:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724414011; x=1725018811; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y4Qa+EV6v8ZB2IRZYzD1waaDvUl0h5wTKdlKd2XzMYI=;
        b=Xj8a4QtOJtaqvv44lBb5NKMZnVoC97+07tAVxyMsdAfhLrsMZqk2goGPDTnjY3+K6N
         iKnw3H8KiO2sOeaIT05cJ7VhF7V1sao1exYQ/Q+KErJpm/2m4b9pgT+FHBo5+iHh7YaK
         JZl3YqCBsxEqHzWHrM632NVddqeSTYBDa90EnYGQ/m+VoB7dCrtLJdW/tylpL0xy/LUc
         rOeLedDAUSnfQ/sfWz7sSiWQwL+yrm0+ByT0BgZrD1/iMauOZXbEHAMeIiSlGk7/oAfN
         +hL+tug594T717as3+mfHLosfxudMJOul0f1aiyzH4tk/mjm/izDEzTp2QhIbWDiJamc
         YpYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724414011; x=1725018811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4Qa+EV6v8ZB2IRZYzD1waaDvUl0h5wTKdlKd2XzMYI=;
        b=DL7nRgqqpK6dq4jVg3EmwaBUIcX1ZgKX3ZYH9YQg2aMQHCDPKyl+3lbjtDVM7/DXPE
         fvLQtJekaWsS1T1Shn7OE7rSQ4kScSLCmECg+wu9p45cY/8Z5WpAS54ytO2d4F7wooxp
         FdaCmu2oVGzqYOZ8vg4c5O2bb4UG8OU2pxjGYY0KJlb74wM1FQdjHZ15K7n5ihuM8zLQ
         iW7O2Z9rQ8qI7/sufIzCigOKfSfv4gwo3FLk7Tz9RfvcRnVjqEF9Ee4szcV2dkBycqKO
         +YXGuMkGqc+q8jG9kcFg0R6rnKd9o2EkZOvy8D8+Ed4FtLk/RZLUAaYwuXio63cpVvpy
         BV3w==
X-Forwarded-Encrypted: i=1; AJvYcCVk/c5S8gVfIqS3U/rQouHM80QaifSxsbUaGG9A/EwGPbG5augZze46e9JkhxP3LXJPwsFnsNwUilhVZnU=@vger.kernel.org, AJvYcCX9C+2QgEkMlu9m6unc9xff4RxnR3VYEJdc9xI0DsoaRDqTChay9Cq7cB281IXxoF67zEg9R4AZXkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YylgdTsmzUTz6YzpRR4+xImkXo2ivbA5vdKA3RVINipEKH8RMMk
	B7O8PRv7XxV/dr3sphcLsM+IUq2gVucUm1VJiyaSQwKlNNBVYCeS
X-Google-Smtp-Source: AGHT+IEOdga9aCjrjCpoQ31PaOCn35Tdda7+8wpViWtKG/KjqE3Q9icx1tmerrSqFubfounMdNwCNQ==
X-Received: by 2002:a05:600c:4f47:b0:426:61e8:fb35 with SMTP id 5b1f17b1804b1-42acc8d5137mr16033265e9.4.1724414010676;
        Fri, 23 Aug 2024 04:53:30 -0700 (PDT)
Received: from orome (p200300e41f29d300f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f29:d300:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-373081ff5b8sm3962533f8f.85.2024.08.23.04.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 04:53:30 -0700 (PDT)
Date: Fri, 23 Aug 2024 13:53:28 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <quic_kdybcio@quicinc.com>, Nikunj Kela <nkela@quicinc.com>, 
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Mikko Perttunen <mperttunen@nvidia.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Stephan Gerhold <stephan@gerhold.net>, 
	Ilia Lin <ilia.lin@kernel.org>, Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
	Vikash Garodia <quic_vgarodia@quicinc.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 07/10] drm/tegra: gr3d: Convert into
 devm_pm_domain_attach_list()
Message-ID: <kg3gfmh4vd5lgnglk7wzzullu7s3b7lpnh3czinmvpds2it7cm@bowytsfbzzvi>
References: <20240822224547.385095-1-ulf.hansson@linaro.org>
 <20240822224547.385095-8-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dsasrgumy5bfzyrj"
Content-Disposition: inline
In-Reply-To: <20240822224547.385095-8-ulf.hansson@linaro.org>


--dsasrgumy5bfzyrj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 12:45:44AM GMT, Ulf Hansson wrote:
> Rather than hooking up the PM domains through devm_pm_opp_attach_genpd()
> and manage the device-link, let's avoid the boilerplate-code by converting
> into devm_pm_domain_attach_list().
>=20
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>=20
> Changes in v3:
> 	- Updated commitmsg.
> 	- Converted to devm mangaged version of dev_pm_domain_attach_list()
>=20
> ---
>  drivers/gpu/drm/tegra/gr3d.c | 38 +++++++-----------------------------
>  1 file changed, 7 insertions(+), 31 deletions(-)

I'm not very familiar with most of the OPP bits in this driver, but it
looks like the corresponding code is now in the core, so this seems
fine:

Acked-by: Thierry Reding <treding@nvidia.com>

On a related note: we have two other case on Tegra where we attach to
multiple PM domains (drivers/usb/host/xhci-tegra.c and
drivers/usb/gadget/udc/tegra-xudc.c). Both of those don't use OPP, but
I wonder if they could also be simplified using the new
devm_pm_domain_attach_list() function?

Thierry

--dsasrgumy5bfzyrj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmbIeDQACgkQ3SOs138+
s6GH5hAAj0NN7iL0JJc60EmmVh+H2EQPjTib+taoAWQEwsmELcslXLSc4FI+ejKy
Wrr7KfyFIAyvn0aMfpN2BmO33LnQLlLGsrF4N5nnpu/Xs3T+zk7YSdXnVWb4iJGY
CLuzCCrwn+3zo6vXoLUOUfVjD31u1dow5T/0IXFfHJ8xLmhADMydsJuzCgkfLlY+
Ty56qPYurcouiUcDFTw3IBFpuRfwYxrbxvUaRINzCjgW+JQAGZJUQQiraOUJPe43
oV+O+oSUvYYl/XSkvjOfiny4f44DnA9Peude0UljUQ2jIBZJqeLPu019+lfovUqm
h3BxoypJmk1wU0z1qrSxEa3O1G62SlXCc/XqsPXYDaHRJrB9XXL+zjY4CsjhHNBC
iVGK4AEaOA6NhSKKpqUBnkNQARd57qBm6i0iGIZrPcoKmxoxNth4K0rsfaxXwgW3
mssfTiu4e1JB5BfIKY1tFdvNOiY9XEjw/+mMAWGHTQTOEUYJQz8CwnPVoulSRIs2
WEmweMuovxjEVODl7XfCtXTJoMdOBkYZT5aenofxSwggl8MaqgJQdNVsIIfof9Qy
PWWOJ5bOTMipJE9hY7AxHpIa2z89KK+ohIf89OvvZUH1W9v0iuIwtuNUveljHym0
9XEVHLsIcYaBD7iG7q5vHqEDB7RotZycfCKgZg073yNlQQGVzAw=
=AFIi
-----END PGP SIGNATURE-----

--dsasrgumy5bfzyrj--

