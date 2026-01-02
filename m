Return-Path: <linux-pm+bounces-40123-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1EFCEE70B
	for <lists+linux-pm@lfdr.de>; Fri, 02 Jan 2026 12:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76DC630124C6
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jan 2026 11:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E406030E846;
	Fri,  2 Jan 2026 11:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IeWTKfd+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDBB30E82B
	for <linux-pm@vger.kernel.org>; Fri,  2 Jan 2026 11:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767355081; cv=none; b=CTfmegEAtkv+pb5UcPoJyvE7qPaYLTS5ZTGCljqOr6Up6XnOROyDAOKhVEUZe0ImiGPdKJpmmh/wbcqFvr1rzx6VbH2lBGfEJjFB3fdR3cms1pgXkFJ9xCTL3ckuAxfsOsnY2oEyXX0vcIHN22wN9GlSqmz41nS2+s7Bw7dnHbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767355081; c=relaxed/simple;
	bh=OOGEjXmkNZBdRQAKqI/w24brTc3UbeLXjGqJU6rxA9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BaOsSBANHTHlmvx3IqP2RnxM4ncWDeR00wXuECsSFClGXepXRjIH1O4rGipUx281BEP4c2ZoGk5pvVYt1wYAt9ALMmJd91ydeuKb9LPLXjt898Kxmo4NXMp1U7HMoROHo6bYYt9Wz7q7An4gv2twLEXEcQ9wiy1sVMqBhQdqvlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IeWTKfd+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43811C2BCAF
	for <linux-pm@vger.kernel.org>; Fri,  2 Jan 2026 11:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767355081;
	bh=OOGEjXmkNZBdRQAKqI/w24brTc3UbeLXjGqJU6rxA9Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IeWTKfd+Fk/gvvkFii9UdxAE2Rdwm85vq/0Y9Oi3EGgKimj2KuJmRqZTLflWf0Jf3
	 jVsIPfZSP89LMYOd70vs7WqZ0f/woBAcjA6ShM1Ssv2oo7eHeLAzAe9hAqmvwCQLSI
	 //nH1cWuZnfaoATJuIzNAr5/E3ZzCcKxB555G13mcMJ6CHrUj3mLYME/Q6FMdRnrLF
	 0/Sw8II2tW8yocs75r1Em3Vsntl/7dk2AmR6tX89XhPF6Xo2n0qMQG2ZigBjvSxDyj
	 FNmdf++W0fnYXpbJq1accwd0I+Y+i6cMOWY22LFMViiNCh+8fGbtDHR8AQ8LrRUFJe
	 WgL+Vo2yHu1NQ==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-59584301f0cso2865736e87.0
        for <linux-pm@vger.kernel.org>; Fri, 02 Jan 2026 03:58:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV03pv7H2t4poKOQirhG6RiEr2OWgdUS3zm+D06itxoXh0ZvMv+FHQKdde4oadkoKzdW0+wcqDuSg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzCvNbsuwHX7I3G6hirix+0Ji6jOWygKovtjQ6yhovvuitXE5L5
	oMmGeL16mv+YnDpwKc5KgYLconVADf9XR56NYDmE4awfI3br3sZu/EXl8BzmUwnqq4hxLIoMO78
	qqT3I7f3hesfNrg+W0QUO5rTrQdJqvgYtRcZMjt752A==
X-Google-Smtp-Source: AGHT+IES0kIDjgnYGEOnKFGJNYFH0vsVl7fqRNUatfgND9VTY3QWFONMo7Hx4HSU6Gk61wbu2Oe+VULtLcRg9b8wJ6Y=
X-Received: by 2002:a05:6512:4887:b0:59a:10c1:8f25 with SMTP id
 2adb3069b0e04-59a17d5dac9mr8692071e87.41.1767355079664; Fri, 02 Jan 2026
 03:57:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251228-arm-psci-system_reset2-vendor-reboots-v19-0-ebb956053098@oss.qualcomm.com>
 <20251228-arm-psci-system_reset2-vendor-reboots-v19-6-ebb956053098@oss.qualcomm.com>
In-Reply-To: <20251228-arm-psci-system_reset2-vendor-reboots-v19-6-ebb956053098@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Fri, 2 Jan 2026 12:57:47 +0100
X-Gmail-Original-Message-ID: <CAMRc=Me8WQ=aMd-NJ1yzzHzqU8fT1u4eb7as=EjSpZ+Rpv9+rg@mail.gmail.com>
X-Gm-Features: AQt7F2p2LtuO3Z-xskVqWJd7KmTcH-PyEGQI74hc0fHTK246U1sFcvAjuK93DWQ
Message-ID: <CAMRc=Me8WQ=aMd-NJ1yzzHzqU8fT1u4eb7as=EjSpZ+Rpv9+rg@mail.gmail.com>
Subject: Re: [PATCH v19 06/10] power: reset: Add psci-reboot-mode driver
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Bjorn Andersson <andersson@kernel.org>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Sudeep Holla <sudeep.holla@arm.com>, Souvik Chakravarty <Souvik.Chakravarty@arm.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Andy Yan <andy.yan@rock-chips.com>, 
	John Stultz <john.stultz@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Moritz Fischer <moritz.fischer@ettus.com>, Mark Rutland <mark.rutland@arm.com>, 
	Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, Andre Draszik <andre.draszik@linaro.org>, 
	Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	Srinivas Kandagatla <srini@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 28, 2025 at 6:21=E2=80=AFPM Shivendra Pratap
<shivendra.pratap@oss.qualcomm.com> wrote:
>

[snip]

> +
> +static int psci_reboot_mode_probe(struct faux_device *fdev)
> +{
> +       struct reboot_mode_driver *reboot;
> +       struct device_node *psci_np;
> +       struct device_node *np;
> +       int ret;
> +
> +       psci_np =3D of_find_compatible_node(NULL, NULL, "arm,psci-1.0");
> +       if (!psci_np)
> +               return -ENODEV;
> +
> +       /*
> +        * Find the psci:reboot-mode node.
> +        * If NULL, continue to register predefined modes.
> +        * np refcount to be handled by dev;
> +        * psci_np refcount is decremented by of_find_node_by_name;
> +        */

Can you make this comment into full sentences, I had trouble parsing
the meaning for a minute.

> +       np =3D of_find_node_by_name(psci_np, "reboot-mode");
> +       fdev->dev.of_node =3D np;

The logic of the device assigning its own node is a bit sketchy,
ideally this should be done before the device probes.

> +
> +       reboot =3D devm_kzalloc(&fdev->dev, sizeof(*reboot), GFP_KERNEL);
> +       if (!reboot)
> +               return -ENOMEM;
> +
> +       psci_reboot_mode_set_predefined_modes(reboot);
> +       reboot->write =3D psci_reboot_mode_write;
> +       reboot->dev =3D &fdev->dev;
> +
> +       ret =3D devm_reboot_mode_register(&fdev->dev, reboot);
> +       if (ret) {
> +               dev_err(&fdev->dev, "devm_reboot_mode_register failed %d\=
n", ret);
> +               return ret;

Use dev_err_probe().

> +       }
> +
> +       return 0;
> +}
> +
> +static struct faux_device_ops psci_reboot_mode_ops =3D {
> +       .probe =3D psci_reboot_mode_probe,
> +};
> +
> +static int __init psci_reboot_mode_init(void)
> +{
> +       struct faux_device *fdev;
> +
> +       fdev =3D faux_device_create("psci-reboot-mode", NULL, &psci_reboo=
t_mode_ops);
> +       if (!fdev)
> +               return -ENODEV;

This will always create this device for everyone who includes this
module. Move the of_find_compatible_node(NULL, NULL, "arm,psci-1.0")
call from probe() here instead and don't create the device if it
fails.

Bart

> +
> +       return 0;
> +}
> +device_initcall(psci_reboot_mode_init);
>
> --
> 2.34.1
>

