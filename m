Return-Path: <linux-pm+bounces-36338-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D9EBE7765
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 11:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAFDB423D66
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 09:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14FC2D6E73;
	Fri, 17 Oct 2025 09:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p8PkJAVR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A581B2DC35C
	for <linux-pm@vger.kernel.org>; Fri, 17 Oct 2025 09:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760691990; cv=none; b=Vkk6l74O7VsXvzy3b8o1wgXoTFJS91V67vE3MaEqgwFDl2/JZ486G9k6mgUsvurO5ZI/fTUACwa3gFHEAZeFrQKv/u3pNoAC+6/BRi9D0GncRXBbxOKh1r2m0CUgbua9CGLkTekJKH8W4UGWK/YRqXlnDWqxKiS8zTftzWlspbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760691990; c=relaxed/simple;
	bh=tL9LCQhpKIBjQIgS/5f1KpjSDRPB3nJi2aKghBl0jM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YTanJSVdwGfooef3rLoxA6KsYtsqlLGqq3nkKfsiDg5DUedzGjsvVkZRJcNRCCDVijavx3pXJqfS/8P6iT3VOsu6OBvtWh3xCWdZEu/jctrepr/km7hFwO/XOCa5bRyZ1agdNQ1gUGadN8oR1nqZngj261jRAl6Eagh/O8fpbXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p8PkJAVR; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b50206773adso529132466b.0
        for <linux-pm@vger.kernel.org>; Fri, 17 Oct 2025 02:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760691987; x=1761296787; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=418kpMdDHnOQzzDnjco0/swD3OeHn+l/8evRSWETxr8=;
        b=p8PkJAVRd2Vo0QVBck6JlHDW4H1DfgmBgUNao/9Nxyt77rBPmQMYnnrLCiL5RkCg9F
         7xOKXf3qxLoKusF2/EHXZkz5XcwpmCBC9VQHrhnlqs5rJUJfDNUFkSX/lA2gE7nYJ+Xm
         E9uBNrUd87yXlyIindIpkJ2u1iZWt5HaVZkijLxikgHQjmUKd6+oLC9YIKv+AiZUJkFb
         9j/8iSANWosU8+A+5zyqUOKgpUG8YpPFj4rUtYfiXhauZgIPdHSwOBR/LsFYVled3gcQ
         le4SDLYgaWgXbzqx8cPJ6UrU3m6tLzByNNerGPfwfG2soIjP6LOC2zEm86p2rMAzwS10
         JWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760691987; x=1761296787;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=418kpMdDHnOQzzDnjco0/swD3OeHn+l/8evRSWETxr8=;
        b=jbER8mDabgkiOa62j9T92vxA7RtaLIvK/iS+o2nD/Z25LFAR+uxh8pkHNDPUz9NG2O
         QS+8iB4SEXZEgLUMOC4gRYMnvCAT/fkpySKuye/qGhm/po6j7nEkGpa245CPpMTH7kKJ
         FOWLLUSKLSiCuBUE4XiC+X7JrUvEWz6e0Ue9LJq0XLSb/ixkq0TBjBlCnRkUIRgFVVEE
         p9xy43HHj0CWZQUU/+K+DtFk+8+N9BRW1ogFNP9CgrVde1oGanZR5LeMGgci3UsufJUm
         N7gWf5X01ZQ2mn2D+MeNxVcZaE4fi/p6V/iAq9TrJsnBRdeA0J+kzKB7wuhdpJEdTfyA
         X3bQ==
X-Forwarded-Encrypted: i=1; AJvYcCXju/y/ciQVErsYbXxaVmajMdEWFWN0lvje/Q4xLeDj/4egM+/Z5b61i67QN7Gzm7otcW4Yu9ZOdg==@vger.kernel.org
X-Gm-Message-State: AOJu0YztYPTyKWmPDc+JehpLDLAZwIQIb5vbsfDzEdbRbzvZUxrE2TSY
	j4tI88cPOaTM8U0nOtUhK2l+LQYTcGTUiZrroG6SdMfjVzWex57TaF79Nw/GVDsuVz71od6aehm
	EwC2FSarSea2a7R7vNKHMel7wEmbbz96YIHlyhlBYQg==
X-Gm-Gg: ASbGncvyyRuze44xe5ulYzpHXRhRbmK2BEEz6lfRzwU7Mn+j1pRc7sx8pMpBDzT0GKw
	XMx+uO5UYhqCsY2HnwTZwPm2DCDmuD+13gyRi7HszT/fcDXRI8n64zXjvYpxF8Lc/g2xM4JFR9T
	saakbxs+0fy/JrDyoSmSTKS/kNDr+tZpIWYkIKtwpZrNFC6rSb1rBySKK/e0KBlSwcoLaRKW+pI
	Rs8C8B8tOMrKGp2jfZRI8S7ovADMYLxX1fPh7qFMfKDRYl+pxs6II6K3fqPwRlNd4VhjfMGAFt3
	xP9ftDrsqjF19kYfndSrJQefuRA=
X-Google-Smtp-Source: AGHT+IG+w0UsfxJS4d6pFqa8XviZVfLhRM+rhE1KqiFzit259/+EaKQIY+0egVcn1SrXy9IXtpCbr0Z+t9PVc3PXPa4=
X-Received: by 2002:a17:907:868f:b0:b41:c602:c75d with SMTP id
 a640c23a62f3a-b645f7ef255mr378423666b.31.1760691986910; Fri, 17 Oct 2025
 02:06:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015-arm-psci-system_reset2-vendor-reboots-v16-0-b98aedaa23ee@oss.qualcomm.com>
 <20251015-arm-psci-system_reset2-vendor-reboots-v16-2-b98aedaa23ee@oss.qualcomm.com>
 <CACMJSesvTLe28Jz83b=zfHD2rvmf7-i_2+2DoV=dgooVqFEYbA@mail.gmail.com> <fa42adf0-8f15-ad4c-3788-578b1bee1c72@oss.qualcomm.com>
In-Reply-To: <fa42adf0-8f15-ad4c-3788-578b1bee1c72@oss.qualcomm.com>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Fri, 17 Oct 2025 11:06:15 +0200
X-Gm-Features: AS18NWCSgzHU1qRYaMmAnFnfeUajlPBrTb0Y5_GWRI3iwaw1dVFHqq2mvJmjYc8
Message-ID: <CACMJSesxazA7Nf6sAhUT16KfwtiUNjvb5JOEWkEb1B5fJtihMQ@mail.gmail.com>
Subject: Re: [PATCH v16 02/14] power: reset: reboot-mode: Add device tree
 node-based registration
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Sudeep Holla <sudeep.holla@arm.com>, Souvik Chakravarty <Souvik.Chakravarty@arm.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andy Yan <andy.yan@rock-chips.com>, Mark Rutland <mark.rutland@arm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Konrad Dybcio <konradybcio@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
	Vinod Koul <vkoul@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Moritz Fischer <moritz.fischer@ettus.com>, John Stultz <john.stultz@linaro.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, Stephen Boyd <swboyd@chromium.org>, 
	Andre Draszik <andre.draszik@linaro.org>, 
	Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	Elliot Berman <quic_eberman@quicinc.com>, Srinivas Kandagatla <srini@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 Oct 2025 at 19:19, Shivendra Pratap
<shivendra.pratap@oss.qualcomm.com> wrote:
> >>
> >> -                       info = devm_kzalloc(reboot->dev, sizeof(*info), GFP_KERNEL);
> >
> > This change is good - devres should not be used in subsystem library
> > code, only in drivers - but it doesn't seem to belong here, can you
> > please separate it out and make it backportable?
>
> sure. Just to confirm we should separate out the devm_kzalloc part of the
> change and add a fixes tag.
>

And preferably put it first in the series to avoid conflicts.

> >> @@ -123,8 +136,11 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
> >>                 return 0;
> >>
> >>  error:
> >> -               list_for_each_entry(info, &reboot->head, list)
> >> +               list_for_each_entry_safe(info, next, &reboot->head, list) {
> >> +                       list_del(&info->list);
> >
> > Same here, not deleting the entries currently seems like a bug? Do we
> > depend on the driver detach to clean up the resources on failure?
>
> sure, so this should also go as fixes? and should we remove the other
> dev_err(printk) also as fixes? or that can still got with the change
> where we add fwnode based registration?
>

It doesn't seem to be strictly required by current code as the users
use it "correctly" but if the API becomes used in different ways - for
instance the structure may be reused after failure - it's a good idea
to backport it. In general we should undo everything we did in the
same function if we fail at some point.

Bart

