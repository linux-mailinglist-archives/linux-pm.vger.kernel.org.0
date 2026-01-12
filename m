Return-Path: <linux-pm+bounces-40655-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C799D12242
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 12:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5FAF7304B4D3
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 11:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB03355815;
	Mon, 12 Jan 2026 11:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zt/kcdR5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A666C355049
	for <linux-pm@vger.kernel.org>; Mon, 12 Jan 2026 11:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768215818; cv=none; b=RPCOyDOlzePksY0CdQmQ3gDWv+q3q1dYUK7QjthksBNoz9KrmjY7ax5Kzm95vzw0B65O7EtOptXa343xBZP8aH5eELu+2/bE3c2EynVHbwXD1c5x8TaEeeaAZovQpHeHUn0zUrS//VoaUKYGo8dXRz5L41Q2BK2HRlTWNONkWG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768215818; c=relaxed/simple;
	bh=NgqM4UUbMqyNIz/GFA+SzHDO4/PJlRI74n+5LLiO3BI=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UkMHsuTCD5QggabmNEFnCkQ2nkn4x88xgI2iPmkpAQRN5jT/UoCv7dT70FDQwPMjlbE3OaCikl1L42D1C2hNT9a+sWfmzciioDceZy9iQ5hQ9KMfnEzE6HmREng5iQzY4JQYhyDRqCNfnTEKRMDpIyTERzHkUJfTnd5uHPMX4nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zt/kcdR5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EDAFC2BC86
	for <linux-pm@vger.kernel.org>; Mon, 12 Jan 2026 11:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768215818;
	bh=NgqM4UUbMqyNIz/GFA+SzHDO4/PJlRI74n+5LLiO3BI=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=Zt/kcdR5bUMSJSjc86b6aW5z6tlpPxjJZ0GLebVxLE3UXaF1yz7r35HCF44HYrrRN
	 ltR632hfg3dW78G2iQzh1TdcxmXDTH28cKjm1bqx+38NcMibl8cm2NmYRPJALIq9RK
	 18WEhb5d98uDNXwzj/UW+VrG64jbrARzpdvsB90oVVrVR5En+l2700v/Kl6UYOLs4B
	 IGsoGu7Sdu+fDrEQAstNsiFBraOmxoYb/Z9+jNuY1cFWaxQGdT21cPMSnsSYuYWk+l
	 G3sMgan/Oi5ERA4FJMbL/qx9TV0hkwHyNJY8YE5l+7QPWrSX0okcrZMVMV6R4oVrmJ
	 Rlvs4LZeakOBA==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-38316445a67so26708571fa.3
        for <linux-pm@vger.kernel.org>; Mon, 12 Jan 2026 03:03:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXAM4O5HA04klevXTMZmyvpE3R/9TzeP+jy1JlwUB/Udr6Ht0FhIamyD3LrNzCplYFWhDSq6t1Tzw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyoHQsB4AWRK+imYaTtN8ZAEXLYhU13yqGLEyUj5kE3iMnCFQAh
	rhM3hUOYN0ewa2/miawrvqkqU22mV78xPHa2U3nfQyeRgw7+nm/QuDufvy+pq/1H825b/TZ9aKJ
	60RqeBbRX332VdP/RyQ9qj8O5VYmS5WeyaMZ7sadpJQ==
X-Google-Smtp-Source: AGHT+IFohkkf9UHfdNA1htiBVdbZfkEaHRBgSuESNj4zQqJpi4VxNX3mipN9Pmd0KZs5DRsLqlBmxWaWnb8zj3OJKys=
X-Received: by 2002:a05:651c:a07:b0:37f:cb34:211b with SMTP id
 38308e7fff4ca-382ff68c23emr54526941fa.18.1768215816730; Mon, 12 Jan 2026
 03:03:36 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 12 Jan 2026 06:03:34 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 12 Jan 2026 06:03:34 -0500
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <aWSxcJTLzBFbMGad@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110-pci-m2-e-v3-0-4faee7d0d5ae@oss.qualcomm.com>
 <20260110-pci-m2-e-v3-4-4faee7d0d5ae@oss.qualcomm.com> <aWSxcJTLzBFbMGad@smile.fi.intel.com>
Date: Mon, 12 Jan 2026 06:03:34 -0500
X-Gmail-Original-Message-ID: <CAMRc=Md6+hhLMOmmDejKW+_jbWu3_XB4qNobyi27pezfXsVLFw@mail.gmail.com>
X-Gm-Features: AZwV_QgCCma7UwKHQgZ5nLG4r75yg0AnwRFvJBiXixfwLwob-etKnqTGCK9cMAM
Message-ID: <CAMRc=Md6+hhLMOmmDejKW+_jbWu3_XB4qNobyi27pezfXsVLFw@mail.gmail.com>
Subject: Re: [PATCH v3 04/14] software node: Add software_node_match_device() API
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas.schier@linux.dev>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, linux-acpi@vger.kernel.org, 
	manivannan.sadhasivam@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 Jan 2026 09:31:44 +0100, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> said:
> On Sat, Jan 10, 2026 at 12:26:22PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
>
>> Add software_node_match_device() API to match the swnode device with the
>> swnode driver. The matching is based on the compatible property in the
>> device and the driver's of_match_table.
>
> NAK. swnodes != real firmware nodes.
>

While I'm not arguing that this is *the* solution, I think it warrants
a discussion on proper matching of devices that are only backed by a software
node - for instance a serdev device on the auxiliary bus. I understand what
software nodes were historically but perhaps it's time to extend their role as
a full-blown firmware node allowing matching with drivers.

Reusing existing OF IDs is just one way, we could potentially think about a
high-level fwnode-based device to driver matching?

Bartosz

