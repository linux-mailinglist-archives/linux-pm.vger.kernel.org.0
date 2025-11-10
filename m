Return-Path: <linux-pm+bounces-37766-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2C9C49D20
	for <lists+linux-pm@lfdr.de>; Tue, 11 Nov 2025 00:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7F5BA4EF761
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 23:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296E6305043;
	Mon, 10 Nov 2025 23:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rMfnUB62"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C141C336EFF
	for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 23:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762819086; cv=none; b=kXNRLKEoz0lmqjwgeCTRP0IC85PZYREEbp9BHgv1bd1pepFZKwopPPCKRyCc9wsoDyGAn6l7HjhInL/DwQYvWGyDREUOXurih+XSJnfMgqUYOODOeOQoG+SwkhHmyE/d9AK3cg1R4XRO8MWmF/ltQlkqQwQWPdpE0g8HPKwbyiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762819086; c=relaxed/simple;
	bh=gR2t+MCFT0pENLeKE/c4frJpybxo9Ti1EMQAvfgDQGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OABBh0Q/FXLejK0QRQhoKf03qv2Sj0hNDJc/kBZowHWnTwzz+vNR4fCq+jHRX4q0+L7r3I1k+1RWmL0XFwP0QwC+UYwPEnnosbdtwFoqmoRezwx4hl6DteoHZmpBUbqREbQJk/YIt6oHnY7VBnF9PxwAd5jGliYkN1ZRtOl6ATM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rMfnUB62; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5943d1d0656so4652202e87.0
        for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 15:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762819082; x=1763423882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gR2t+MCFT0pENLeKE/c4frJpybxo9Ti1EMQAvfgDQGI=;
        b=rMfnUB62IkZBgU4Z+MwGW9CfUGrmA19YQdXxMpBNsOeSJ0mEIRcXgpji9QXC0EYyJa
         o+/Tku8BunlJT5rqpTHIDQcnC0gQ3F+JkdSrYjtxQfXoIsyhWp6/QS7GuituJLbu5Vwy
         Y2z36yLhaznblXd+6FSzx3ztBGjYUzzA+q46QqvbjDXeQi0qTzWXA3AuPHvGZXRtu8Cq
         RTZKrvyOiNDmIj/4kKFajk4V5MVhg+bkHb0LR2U8TtduyxRf1DorNvQFruPMZ/SbpwDG
         13aG9D3U2O+aC7XKZ2XKF3l80D0Wm2qCGZQQeTFm/o11lzRynFNQt5R4bLoZZjz8H5GR
         UBqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762819082; x=1763423882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gR2t+MCFT0pENLeKE/c4frJpybxo9Ti1EMQAvfgDQGI=;
        b=WfB7iuLkJjkLGDXTcEW0ABSh7vLxHHjqDVDh/Glj/5+HHOhTCxmzhCTsmiExIKBgKn
         SRWTShtvyX2ABPu6X/7IrNRN9kgk70fI1aQdCpl6dBa4N6YRqcC6eVaiwi+oSaghQCWF
         RfAZm1FkP7MHY/Qa5ZXor8jDDc53bA/FWPwVIdZcssJtWaAZiB0D2X/A5GumNyQbz6Vl
         WIUwAVn99KW00BKGrMeZKyywRboKzqrczcRtEJ5syuu+9aIDPfbpm23xsTy6XX9EmmdH
         pjNWXb2eQqV5CvW09ck2Irw2htMDIeG1aXM6snRn1Au6fFwpLnHpqOWId+wsuoXB8Ya5
         aspw==
X-Forwarded-Encrypted: i=1; AJvYcCXkkta8/6qMNZPmFtzC+dH+pIpiY8yD/vSqIe73ldvWCa89gVjOCPfqeOMOoaO+oFQTm/fPz0lxbQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyF0/E/LDUUb2JShpxDAjdPJCUi3DGWO+pJ0JThx6DmcB+sMBoK
	tY9mCAWS/F+8RrlTJsXbU6KKKKn3J7ADEzDjY+f6aTOSIWZu50z3lK89kAGFaRlMKxZihfTY0HF
	njrp2b71oAqCrtB32MqCnBS2cfXfsQL9QG+/3a/BJbA==
X-Gm-Gg: ASbGnctMUsYq/ErQWCHjllcUkpv0r88sVfKzSfHmLBCwipD0DfmLAvRar/jYbr48Grx
	kh1Dv50O8RQAXzIz0BfSrspmmSov4Q2XaqgLe6LA76jrsKqDB5UJc1VmG1h7ujN4Qp7jFf6xr82
	tzaGnULo9dOe+4sHa6eDSFdU8zAKTb9YtdYgE8C5IPnsHPT3af1kECe+GaJ63JNCJ9gDOvURWRi
	Avfr1S7idMep1e5aF+oI+pIokP04aeuvHpEm3r1r1kH0IsVe09r2f6ecYIwMXPFYm4Nxmw=
X-Google-Smtp-Source: AGHT+IGq8/YFN7hlWLIK9a4/CG12Y6T0bDy/N5/JTLofPKZElIMDZsi5lcAadM+CuswrNL2lnuY1YgL0/HzwYkg+O1w=
X-Received: by 2002:a05:6512:b03:b0:594:4a5a:346 with SMTP id
 2adb3069b0e04-5945f15bf72mr2619011e87.17.1762819081904; Mon, 10 Nov 2025
 15:58:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107-wakeirq_support-v5-0-464e17f2c20c@oss.qualcomm.com> <20251107-wakeirq_support-v5-2-464e17f2c20c@oss.qualcomm.com>
In-Reply-To: <20251107-wakeirq_support-v5-2-464e17f2c20c@oss.qualcomm.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 11 Nov 2025 00:57:50 +0100
X-Gm-Features: AWmQ_blAezbQ4rkb-Vrevk4Zgb5huFnQ0lcUTpotRRUAIJPGPB05jzXROpJ4ido
Message-ID: <CACRpkdY9HsnG=xo=swnMcVha+unmvmxR6e6Ynsj09srM_tPmWA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] PCI: Add support for PCIe WAKE# interrupt
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Bartosz Golaszewski <brgl@bgdev.pl>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-gpio@vger.kernel.org, quic_vbadigan@quicinc.com, quic_mrana@quicinc.com, 
	sherry.sun@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 10:22=E2=80=AFAM Krishna Chaitanya Chundru
<krishna.chundru@oss.qualcomm.com> wrote:

> According to the PCIe specification 6, sec 5.3.3.2, there are two defined
> wakeup mechanisms: Beacon and WAKE# for the Link wakeup mechanisms to
> provide a means of signaling the platform to re-establish power and
> reference clocks to the components within its domain. Beacon is a hardwar=
e
> mechanism invisible to software (PCIe r7.0, sec 4.2.7.8.1). Adding WAKE#
> support in PCI framework.
>
> According to the PCIe specification, multiple WAKE# signals can exist in
> a system. In configurations involving a PCIe switch, each downstream port
> (DSP) of the switch may be connected to a separate WAKE# line, allowing
> each endpoint to signal WAKE# independently. From figure 5.4, WAKE# can
> also be terminated at the switch itself. To support this, the WAKE#
> should be described in the device tree node of the endpint/bridge. If all
> endpoints share a single WAKE# line, then WAKE# should be defined in the
> each node.
>
> To support legacy devicetree in direct attach case, driver will search
> in root port node for WAKE# if the driver doesn't find in the endpoint
> node.
>
> In pci_device_add(), PCI framework will search for the WAKE# in its node,
> If not found, it searches in its upstream port only if upstream port is
> root port to support legacy bindings. Once found, register for the wake I=
RQ
> in shared mode, as the WAKE# may be shared among multiple endpoints.
>
> When the IRQ is asserted, the handle_threaded_wake_irq() handler triggers
> a pm_runtime_resume(). The PM framework ensures that the parent device is
> resumed before the child i.e controller driver which can bring back devic=
e
> state to D0.
>
> WAKE# is added in dts schema and merged based on below links.
>
> Link: https://lore.kernel.org/all/20250515090517.3506772-1-krishna.chundr=
u@oss.qualcomm.com/
> Link: https://github.com/devicetree-org/dt-schema/pull/170
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.co=
m>

The GPIO parts look all right to me, a bit complex since we can't use
devm_* stuff here, but that happens.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

