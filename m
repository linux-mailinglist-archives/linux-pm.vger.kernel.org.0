Return-Path: <linux-pm+bounces-36199-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77912BDF26F
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 16:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 323E83C51D1
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 14:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27822C029D;
	Wed, 15 Oct 2025 14:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fDZk1URF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DA52C0278
	for <linux-pm@vger.kernel.org>; Wed, 15 Oct 2025 14:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760539648; cv=none; b=i0OAiZbp+9ELEn7tee9Bc4xPap+8wWxwIw7jT4h371af1e1R2CHJP3oE2eSrtraCBRoExexrotFUevbeAIxQZNy0eZwgy5TB0fB2VYhg78Lbpb9bJQgLQwILJsoU6ztOZ2a0Ilwmxr51RPgeM6o9zvW2sMHuz0nferzIAB/fzjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760539648; c=relaxed/simple;
	bh=QUCvg677zhCDZSxrUQAlexw6PjexV7DKVMj4nJGBmi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PoDH1hTvoN/vU/DV1TfO/et1uyhB1XaH4JfoEsgcyRXZQOhXCiqDjKaYHOkioVLOua8R7lM8NZcFYqsYL9vYFZGR5o1d8X3pENv4BPRWCjYVT5/XZ8/K4WfqzcXbQaIn90ctVPlIh77jKD1i3Hsn2Lq6/aqnytdygtDcmN8cHsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fDZk1URF; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b2e0513433bso530399666b.1
        for <linux-pm@vger.kernel.org>; Wed, 15 Oct 2025 07:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760539645; x=1761144445; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BkRSLUnpznpy3qYmmJfpc7POjKcvG8Z1LeLnSK1GGKQ=;
        b=fDZk1URF5eS4U1dQlxHNMNPkp/ddZGxQOOoZBdyAtJdu9mnPnEpZHXdIHKLu5vj5OG
         8zw2OP4Njz5OSTbnJ8K2pXaKuSpYLrRtlQaO7S2sz7rk3GZH1diDieZrxCXrDFtLy5rU
         XcnCw3QIcCAR3YQ7Rbkjc3Oh6anB/XAnDVP890DhTunZyKQ4IgpR6IST6W1//kd7K+v4
         GH/WVO6Xg8bUlNMSRIMQX87RNguF1jLLH5u6J6w5L9ZhhlfSWhit8C3uxysPp8g23Sm8
         pnnniRTF6YoeJAlBaGD/EXTX+Gt5RkzyKeWnUzPEybmJo7O8iw2uRcwL6DvaxPxApNmH
         5F6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760539645; x=1761144445;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BkRSLUnpznpy3qYmmJfpc7POjKcvG8Z1LeLnSK1GGKQ=;
        b=L5XPp+OlcAN0cFKbEORvO4No4xrZwrn6yFzUj71YaSvmp/w4NOIZJ37RRqSzByiQAO
         m/vEPqpcfvHw2XPTJG3gDvCcnMq0knIMeFIBLfIyTtD7lUA7aWTy+riX5JXhsEPrhYTK
         +EDUk/maorAkySXB6UzoJkRtNDrHHR3a4HTNiOZPlWi/oglMZ3vAoNsuaYW1KyT3vJD3
         KpG1Bt0KvIxSkt+oyc5oXISWnanWEeUEs+Vd7ryOueyrHTtEPqCx5Pdnf/qG95UCiqkh
         7ILfG1IF6iFAbeS0s9KQ+qugROJ5GLPH64rqV5eobWd0t7Hho6knc/U80yWPDrKE7fXR
         4VMw==
X-Forwarded-Encrypted: i=1; AJvYcCVDVA7aPPbNfW/BG7002e6S6wQqcx5L0c0actPE3KQvJB0Xz0uGpKQzgTvfjIcCl8Uho7recqCDDg==@vger.kernel.org
X-Gm-Message-State: AOJu0YySZEuIIps4pRM1FXbnUSb3y8P0vm1kvu3Oh1bYONvfilQH3jzy
	eoKHw+j/Zdndm+BRzZRzh3dVGLrv0OQD5xDiQUCDKJbwgwPm3D+Hk/lH0nYubnP0a5hN928e6KS
	A229VKR4AfN+LvUW9mYek5Zm1gCfqS6TTYSM1QM5hqg==
X-Gm-Gg: ASbGncuxAb1Tpt9oGNCjCpbKJT1dbc++xIdzh3V//BHygebQwiqIPoejkMp+iipB4qe
	ukb4Ps8Xe5iqPqER9vDOVU15SdfZ8CLAvugU9dbrosJp8zUK++ucsMtM2DQ1Pg1YDTzgCKqmu5a
	rbmf0sFwzgbIys4J+DpIckgLh3ZfRdc6o0Ivc1Nlaqo5HLH9dA6xBxJ4HN4k4+mZZmVV88Ac0t6
	abcml2WZb2BLtc0+lycGn9A/X8mnNAacdCsEsTtpiNtN+SUEyICKTNlcJwAR/lm31mcOpiH
X-Google-Smtp-Source: AGHT+IEUqGfQp9YhYQvza9pi3u1frVExIPZGobHvkJpepK8/VlN4XugYvlYQpaqAjcg5hzZJQWZYiCQ8a7FDZgL9rGQ=
X-Received: by 2002:a17:907:3e95:b0:b3c:cda5:dc5f with SMTP id
 a640c23a62f3a-b50aa48b9cdmr2796236166b.9.1760539645069; Wed, 15 Oct 2025
 07:47:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015-arm-psci-system_reset2-vendor-reboots-v16-0-b98aedaa23ee@oss.qualcomm.com>
 <20251015-arm-psci-system_reset2-vendor-reboots-v16-5-b98aedaa23ee@oss.qualcomm.com>
In-Reply-To: <20251015-arm-psci-system_reset2-vendor-reboots-v16-5-b98aedaa23ee@oss.qualcomm.com>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Wed, 15 Oct 2025 16:47:08 +0200
X-Gm-Features: AS18NWDY7WIS_O4_p56TfpOvWCBi95zCtvBsZn2zTDEoiMSusyplTlJpgBuyRf4
Message-ID: <CACMJSetWthCcJo8v7EuUK-aDKhf5KTNG5WQQ9aTQu62B+E=DMA@mail.gmail.com>
Subject: Re: [PATCH v16 05/14] power: reset: reboot-mode: Expose sysfs for
 registered reboot_modes
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Sudeep Holla <sudeep.holla@arm.com>, Souvik Chakravarty <Souvik.Chakravarty@arm.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andy Yan <andy.yan@rock-chips.com>, Mark Rutland <mark.rutland@arm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Konrad Dybcio <konradybcio@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
	Vinod Koul <vkoul@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	John Stultz <john.stultz@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, Stephen Boyd <swboyd@chromium.org>, 
	Andre Draszik <andre.draszik@linaro.org>, 
	Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	Elliot Berman <quic_eberman@quicinc.com>, Srinivas Kandagatla <srini@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 Oct 2025 at 06:39, Shivendra Pratap
<shivendra.pratap@oss.qualcomm.com> wrote:
>
> Currently, there is no standardized mechanism for userspace to
> discover which reboot-modes are supported on a given platform.
> This limitation forces tools and scripts to rely on hardcoded
> assumptions about the supported reboot-modes.
>
> Create a class 'reboot-mode' and a device under it to expose a
> sysfs interface to show the available reboot mode arguments to
> userspace. Use the driver_name field of the struct
> reboot_mode_driver to create the device. For device-based
> drivers, configure the device driver name as driver_name.
>
> This results in the creation of:
>   /sys/class/reboot-mode/<driver>/reboot_modes
>
> This read-only sysfs file will exposes the list of supported
> reboot modes arguments provided by the driver, enabling userspace
> to query the list of arguments.
>
> Align the clean up path to maintain backward compatibility for
> existing reboot-mode based drivers.
>
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>

[snip]

> +
> +static int create_reboot_mode_device(struct reboot_mode_driver *reboot)
> +{
> +       struct reboot_mode_driver **dr;
> +       int ret = 0;
> +
> +       if (!rb_class) {
> +               rb_class = class_create("reboot-mode");
> +               if (IS_ERR(rb_class))
> +                       return PTR_ERR(rb_class);
> +       }
> +
> +       reboot->reboot_dev = device_create(rb_class, NULL, 0, NULL, reboot->driver_name);
> +       if (IS_ERR(reboot->reboot_dev))
> +               return PTR_ERR(reboot->reboot_dev);
> +
> +       ret = device_create_file(reboot->reboot_dev, &dev_attr_reboot_modes);
> +       if (ret)
> +               goto create_file_err;
> +
> +       dr = devres_alloc(release_reboot_mode_device, sizeof(*dr), GFP_KERNEL);
> +       if (!dr) {
> +               ret = -ENOMEM;
> +               goto devres_alloc_error;
> +       }
> +
> +       *dr = reboot;
> +       devres_add(reboot->reboot_dev, dr);

If you're using devres here - at least make it obvious by adding the
devm_ prefix to the function name and make it take an explicit struct
device * parameter so that it's clear who owns the managed resource.

Bart

