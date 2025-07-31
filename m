Return-Path: <linux-pm+bounces-31681-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC52B16F6D
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 12:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DDD41AA4CE3
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 10:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA2D2BE03E;
	Thu, 31 Jul 2025 10:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n7lQX6do"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682732BD5B3
	for <linux-pm@vger.kernel.org>; Thu, 31 Jul 2025 10:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753957531; cv=none; b=jAkSlPxxmvZHtQU4irhKzvpJZ0GaZ+G9jHe7yr8bEzlDel3Kh06Bt63/wGU7P8XWH0gh930q9DAEN1+itaRyKZrnpbDIW6o8AoBqpkp+Rs0EVOPNtzG44QM1yxlj+SPxL7ZxBN4h2zIjDqcMrqfr1AhwHDqVUntvalbVI+RKJKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753957531; c=relaxed/simple;
	bh=Fdd8rVwrOI/ftl2mALt/laddxSDrHqp2Ly2OA1Dp8PM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JO1UCJ+NXyWQSopE5UPZ619nBzC/Q/lhgkPbMyCORRC9dBXF61ZyEAa0oIeBeY1BYkk18Xn/qqpqbXMA37ztZV+hHpH0OJMBx0CBjLz4Ne/3bqSA6b6tCfnZVKqQtukPrlr4C+PDu2gaTvtQSn34VK0oTEerFPlXJDaVZ57k62E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n7lQX6do; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45892deb25bso2139575e9.3
        for <linux-pm@vger.kernel.org>; Thu, 31 Jul 2025 03:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753957528; x=1754562328; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Fdd8rVwrOI/ftl2mALt/laddxSDrHqp2Ly2OA1Dp8PM=;
        b=n7lQX6doHNPHdI2TT/LQiEalgtdlDGkvQyblsljcHnUr1c8H3yY+lEBYDgG0ncVrSk
         eUH1G3URucTH+Fgq9Y4JtEovxF0pnkXXQbvROtfisvPGCsuBUkV0RctF31rJtPqtwTwV
         N9immdBKWtAB3zgNm+qJ2kL1DB4ZX02sypjRe8vCtLjJaPXyKJ9tLQhZkyQlSOLDZEsJ
         0hEru0hjgjCpL9b8ct6PpXOXafujAcbxplAzxK8E6STkj537HFCF54lBtC8C5iwK1zF5
         QS1te/6wYff6KBGyWwIin05zP/kgfzyPuLGv4qtXy4BIn2XtbsFvVHu1RJV9wUrpfyC+
         fS2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753957528; x=1754562328;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fdd8rVwrOI/ftl2mALt/laddxSDrHqp2Ly2OA1Dp8PM=;
        b=wVilQN/o5e/cdlYa3udzRHbWpNb3XadTMhNyKndkEYNGHQN9n5Lokhcj6F3IcJiNRh
         BvhtHxjs/Ka+QYZ1WfEdDrF1hzcZ/pfutJosiq1EjBB6RmOhntlwVEGrFXnxYVrQ1zrY
         h4kFif4UwgoqG+JwgQICHK795lg5NmA2mS9PaczHeFqMcg4U4TSCBk3qkMQWjBdgLe3V
         42Qyy/JKdudQutcGLRD78IcFjS/umg3GdCP6LerazwF/0kIIgwoe8WLe2Ga5g/utbFnI
         0wvCG9sz6KKeXEFVtjJ7laxeTSgImCWZ92h9z0oBDxsl3DYvUI/Oi7F8DpTygDuKBUI4
         L17Q==
X-Forwarded-Encrypted: i=1; AJvYcCWpM+Kzatvp98FiE3Koejk+bKFy/3n2HWXZaXhxwR9LCvFTUH0Z9s7VzDmcDrl5sxfgGarjDFJAAQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3QFNKuLU0ZWrfAjl5mnHrkpnOjI99mFRQZc746pVRQpI9W+kT
	ZlVpcF5RDceIWxSNacot9T3NdVk0TYT2WmMPgolmo9nwnjpTXHcvEjeps5Q1YLMGt8Q=
X-Gm-Gg: ASbGncv7kcKEdCptSNOw/rMtDjUJOmRszMYyi7SyXRmdPPEBOWjUmDNG5H62nagrxGp
	jYYmCGppPavPhC6/OOdNNyAkg3LbH5fYRFmpp+7Gm0zdADMQ8vpl3RmI1jCjE9ZEHd8iHN/VBiV
	4BoN4z1yVlzNuqFtt/tsMous/DMQajYvZ1RFd9M2RVXKGnEaT85rB7MODKdkaKNtWC9DPCKYqW4
	YS/PanT/e4BxIcAeIIdbya0Rw7X6sXQIcbV11veR3dsj5PUQRgzCBXRKh2dhI0CPNKGfyAE6wsK
	9BlUyg/dbnEeOC3zh5Swm2xr9mvwF/CdCHBy9sjZWPveaUlkmkPdgmelvhWzmV4DV/nYvGOl4cM
	1iFW6skGaWht82buVWuzlSwXTSQ==
X-Google-Smtp-Source: AGHT+IHhqyP93G+ZH0mqfHoo6oZhMJUnlWvEtPn99Mobxr9hcWgTGsVHemxeWgkdcIjD6PVicJSyoA==
X-Received: by 2002:a05:600c:1f92:b0:456:207e:fd86 with SMTP id 5b1f17b1804b1-45892b931ccmr73450555e9.2.1753957527737;
        Thu, 31 Jul 2025 03:25:27 -0700 (PDT)
Received: from [10.1.1.59] ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4a2f03sm1888068f8f.72.2025.07.31.03.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 03:25:27 -0700 (PDT)
Message-ID: <afa34f49d502d7f921818141979167920b8d924a.camel@linaro.org>
Subject: Re: [PATCH v13 07/10] firmware: psci: Implement vendor-specific
 resets as reboot-mode
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>, Bartosz
 Golaszewski	 <bartosz.golaszewski@linaro.org>, Bjorn Andersson
 <andersson@kernel.org>,  Sebastian Reichel	 <sre@kernel.org>, Rob Herring
 <robh@kernel.org>, Sudeep Holla	 <sudeep.holla@arm.com>, Souvik Chakravarty
 <Souvik.Chakravarty@arm.com>,  Krzysztof Kozlowski	 <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Andy Yan	 <andy.yan@rock-chips.com>,
 Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Konrad Dybcio
 <konradybcio@kernel.org>, 	cros-qcom-dts-watchers@chromium.org, Vinod Koul
 <vkoul@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Florian Fainelli	 <florian.fainelli@broadcom.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Mukesh Ojha
	 <mukesh.ojha@oss.qualcomm.com>, Stephen Boyd <swboyd@chromium.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, Elliot Berman <quic_eberman@quicinc.com>, 
 Srinivas Kandagatla
	 <srini@kernel.org>
Date: Thu, 31 Jul 2025 11:25:25 +0100
In-Reply-To: <473f7269-3852-64a0-8aa6-7299be0fc85f@oss.qualcomm.com>
References: 
	<20250727-arm-psci-system_reset2-vendor-reboots-v13-0-6b8d23315898@oss.qualcomm.com>
	 <20250727-arm-psci-system_reset2-vendor-reboots-v13-7-6b8d23315898@oss.qualcomm.com>
	 <b45b157593f1865a402f4098cdeafc298a294c6d.camel@linaro.org>
	 <b92c164f-c6df-a2c0-1416-67652a01b179@oss.qualcomm.com>
	 <34c52c88fd8fcbf68c453c1e94e4cd6294becff1.camel@linaro.org>
	 <473f7269-3852-64a0-8aa6-7299be0fc85f@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1+build2 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-07-31 at 11:05 +0530, Shivendra Pratap wrote:
>=20
>=20
> On 7/30/2025 8:53 PM, Andr=C3=A9 Draszik wrote:
> > More importantly, if e.g. an OOPS / panic happens after the reboot
> > notifier has run (and set vendor_reset.valid because a reboot mode
> > was requested),=C2=A0a panic handler changing reboot_mode to warm to
> > retain RAM contents will have no effect, because the the original
> > code above making those distinctions can not be reached anymore.
> >=20
> > Above scenario with OOPS / panic after reboot notifier could e.g.
> > happen as part of device_shutdown() - see kernel_shutdown_prepare()
>=20
> We can handle the panic path by adding a panic_notifier in psci
> and make vendor_reset.valid =3D false. Do you think adding this can clear
> the panic scenario above or there can still be some leak?

I think that would work. You then can't convey the reboot command, but
at that stage (panic/oops) it probably doesn't matter anymore, it only
cares about the crash handling which probably is enough.

Cheers,
Andre'

