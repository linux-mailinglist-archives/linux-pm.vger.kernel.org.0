Return-Path: <linux-pm+bounces-36637-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64057BFB494
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 12:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15E8519C0039
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 10:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7ACD31D742;
	Wed, 22 Oct 2025 10:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kfiHY1Pj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D153161AF
	for <linux-pm@vger.kernel.org>; Wed, 22 Oct 2025 10:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761127423; cv=none; b=TOUp/zHY1wfVVPYxKVQ6oC5Vha5/fFvGQGErZURhPUj3QI2p8Vv+GghlIpAdPzoloLFr5dY5rsiqecdblWo++utTlkYGokAPJJxExwybTdMWHOPFDWHknRguXvdcBOSOZhJXt7O5Z/Ms5u/EiesktV9YoAHc5vvNdYkJwiP0hW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761127423; c=relaxed/simple;
	bh=Qbbi4MZBKkecaJJl494H7QcMGXGjmq/zovJ9I9dUy7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hjH/O5V1SzFqTuSTo9vpg5dK8aQt2JhzExrbUz6BTpSA5ynNCPIxfTiHOQA5ck4n5muO+8kN0lEw22N0pgNIOmvX19BJYP3Eum5e/hrY/K6MGoHsOUYI/Q5baxPd3H05i1BlPCiQVqc4Eb11M6M9Z4fkTFa2Yn0mV8ZYJzN2xGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kfiHY1Pj; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-63c4c346bd9so8475191a12.0
        for <linux-pm@vger.kernel.org>; Wed, 22 Oct 2025 03:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761127420; x=1761732220; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j80svTpQNDT2HO9SwazgBXuB8uzAZlJDHoPKa+K5IjE=;
        b=kfiHY1PjMsOHPsR9jJ4muQi0D4utfRZmNvVBKUphDChSMB4OMatKjPgL5IYiowKZdB
         CeKI/koN/f70ZsSePFBdOpXpLA2IF11aF9wlwZSOVB5zX52YoGyWv9zVbJHrCvoOsKA+
         Npw0aT8CMUyVDUPT2mAPbaakxM/fNGLgUxUDCMJK1Go83CBQmqBLWd4tO0lcoF9P9XyD
         ELvNRnNhg1P2MnqDEBtdRFaydl3AoXxkjPtN4HGgMQExa85rHUR2EIo4GERo1UuOUlAl
         lY7EJt6NSsN6Zq0eiGn8gF2bYkUBer7gysstSe4ZaD9YXtb5Yk9/+iGkV7FaforxveBf
         MP9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761127420; x=1761732220;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j80svTpQNDT2HO9SwazgBXuB8uzAZlJDHoPKa+K5IjE=;
        b=HE38UmKi6RJa975lKV/lk74jH7XesGDyAdKgO7waia3DM2kt4ocTS9ebKOcDQe6uWX
         GlfNQzVVmSjMXekeOOOxO16YZLSKNacDuwxqC/FfSitsfzLEmSnG/oCqC1oIsS/XCg9E
         9Rv4CXgVt3YH8vm25O+kkdintUabAEox6TkDWRQzyYw+OuYhJPKZRjZlYFJrO3/xHGyb
         OFEESWKiQsWA6BqEeNmgFAVH/b0y12Sv6T24WtgvmCl9736hZ0rBNbjLxffWUCwQIj2I
         /rcC4WfN8/OM8rsMFFG0aZWixtXIPTZ72jvsWSebGRBkoaHiwOSRppZPU6HejIDeSy4F
         PHbw==
X-Forwarded-Encrypted: i=1; AJvYcCWYk+4G/xY60Z3bEqRUID+1eWI6scivdEnXqgJc92BUPga9uWUA5gDh2OmWdP6lwce4nkS3V3qxYw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx10+J6FlVVXCWpdaYJa+veAs0/yoZR739phj3dz8ZkmTfhM2hn
	mzZd2CLnFl3FYj/fCr5lOERURMdXhNsrAR8xvip/SlvmPWpp2SknD79NSmU3gDwRrOEu3eLVD3P
	ADEkTdNuly+lp1aN+8xWO7vSh1aOocNbs4nS2VZQSMQ==
X-Gm-Gg: ASbGncvlgpa56tvqqVtuPaJk97FNXcVONZuQVKL63KGqgnhyFDP+L0nBaWBu8fPaMTh
	fR4JzcWk6TULVgKR7Vcc0djusiAkyVLFGTAOBj7+yh5itObZOqzFxuACbwvy65l+5yQRuxHQ1/W
	BycUx4MFaY8Jo0P4YHEtPLpwLqnbK1+WcZynixYQzaIFjmy87H3TlEKFerEQPSznclKnyr0XST7
	FWEb1QVxlGb2PPSTZb77/lhSl++495eQijFLXL+EEM3oMRSSdEvOkPJye3g358jOcQNgedZS5Qx
	n789Qt0=
X-Google-Smtp-Source: AGHT+IFRHS9fCtNlfozcKqfiZ/HU21GMsDA3YriXsWw67Ybr2fSHm2R56fU3GCdtVA2wLt6A2hgJEfeDgzt+vSey8O0=
X-Received: by 2002:a05:6402:40ca:b0:63e:17ef:a62d with SMTP id
 4fb4d7f45d1cf-63e17efa78dmr3015030a12.15.1761127420175; Wed, 22 Oct 2025
 03:03:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016-gs101-pd-v3-0-7b30797396e7@linaro.org>
 <20251016-gs101-pd-v3-3-7b30797396e7@linaro.org> <CAPDyKFqNEN_yfmGWZr=sC-W8-Drv7zn82WYa-y=v+Suk-JHvtQ@mail.gmail.com>
 <838a2a9f-9d4f-4c04-bab3-c6a7d52b60b3@kernel.org>
In-Reply-To: <838a2a9f-9d4f-4c04-bab3-c6a7d52b60b3@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 22 Oct 2025 12:03:02 +0200
X-Gm-Features: AS18NWDgqWuAfrcT_6PqRDb-GaFHTXtI7dspjwKLQKVO9xQrFqh11FPqeF5ceCc
Message-ID: <CAPDyKFr4G5m_tnC20w-K7Nh2m-ut77rbeHvWgDTgHLA0hkALNQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] dt-bindings: soc: samsung: gs101-pmu: allow
 power domains as children
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Peter Griffin <peter.griffin@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Will McVicker <willmcvicker@google.com>, 
	kernel-team@android.com, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 21 Oct 2025 at 18:18, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 21/10/2025 14:59, Ulf Hansson wrote:
> >> +  "^power-domain@[0-9a-f]+$":
> >> +    type: object
> >> +    description: Child node describing one power domain within the PMU
> >> +
> >
> > I think we should specify the power-domain-cells too, along the lines
> > of the below.
> >
> > '#power-domain-cells'
> >  const: 0
>
> That's not needed. The child (this child device node) schema will
> enforce it. Parent (so the PMU) is supposed only to list compatible.

Ah, I see. Thanks for clarifying!

Kind regards
Uffe

