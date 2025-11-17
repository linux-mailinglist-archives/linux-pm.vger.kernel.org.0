Return-Path: <linux-pm+bounces-38127-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B6039C644A0
	for <lists+linux-pm@lfdr.de>; Mon, 17 Nov 2025 14:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 82A3F4ECB54
	for <lists+linux-pm@lfdr.de>; Mon, 17 Nov 2025 13:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B6A32E6AB;
	Mon, 17 Nov 2025 13:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dMiW5bqR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B985932827C
	for <linux-pm@vger.kernel.org>; Mon, 17 Nov 2025 13:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763384653; cv=none; b=JEdRgBJpkWLVzFHWgqs79Tmz52W/ZpLhE2moxarAfK8Hfm7UDf0V/2S6eLsaEOE6LYA3cert2AolE+ocooKNZBKtklk+V/wvDe5Nkmk4E1+FB/QtpfgNFBdH8AdQy5UBPgSlJ7X2Fu3dNtoANCce6s/TBQTyfeiykYEZDRVjx28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763384653; c=relaxed/simple;
	bh=TZHjrSmYSS4DWh5CACHTqX+w/nnbvYaXNeAI64qJ1Xc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fPAkhS/6tRgGJxsFz6y66KCcDiDVhxYpqIThKWsEyWzUNzf5lJ4+Yse0ojMB76tj+bAcmWBMD/Cl2OGGCS+zVW9efPm4WDjOCTpLIsDzSjHARCONlM2kylfGDVZc+NlOvgG2nkbvIjNPE+vevvMNgA2RvstYmZxa8GjZleGuUck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dMiW5bqR; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-640aa1445c3so6497951a12.1
        for <linux-pm@vger.kernel.org>; Mon, 17 Nov 2025 05:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763384647; x=1763989447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LVyxoX1bacmdQTYzIG1A2gEIdf65OFXy9IfapYUbB3g=;
        b=dMiW5bqRQSiLrI3ivkRFOe+Apeb5ZN64oTVHducAy8+85b2XhjcfWakACwoSLJhYC7
         CrJhYWYKmVC7cV9C4PHmH8e4bEkO3VSdFD50cUz7WWidbsRNZi2FLtFXGkCWCwMFYTsO
         5OxxSAwiQaQZJOE+hOrNeDQDU6He0OKouuWpm31e2E8qkwEBsW7E+CoxK36D4qSVVk5m
         vTqNjLWv9rZRj5IrJc5ltlWPwefRl8rwkPggqZcZVySnDT2eI3OAH3dVFqZkcbUpfjIU
         pO99F4RvVE+9DeJYLlcYWROnonSYnZ3MQGV3haiS6gt9JjtzxB3/NjKfBP/j17vUkCNv
         IVRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763384647; x=1763989447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LVyxoX1bacmdQTYzIG1A2gEIdf65OFXy9IfapYUbB3g=;
        b=oA/gywH5iYN05Sxf4etzDnwtsSOAsNlLeVbj+qlUfN1eNEzxkY+4E76G3duhDZzXj8
         tejDiPNLNeV+1J0Y4L63DcNGs91ay/XcneVp1Kuuudcmz+oaKGvQFt85ohe70zmPmpt1
         3woILk9NbTow4YK0h+fMlF1L3LDywRQKvbA0L6ev4e54fjW1cmRu5q5odDc6e735vdj8
         mGwb6AuA8hcMDzOqwGPUXzTsrjnpA2RwK3ccS4Qs9vueGDFUqUmvazglJ0Lqyli78BY6
         Uwjl9mRsliCVrzATLNpor94HCrl3CHJhoiwjNq2L4/7kVEmyxO5E66CL6wBnKsA7PGwH
         wfNg==
X-Forwarded-Encrypted: i=1; AJvYcCXT/cYpfBWi3iWQ7dlMm3QtRIeCxwWLJTrl4B9DAKyvRlDpZqe8JfG+63RZTL8QQQeDXqjzrCedaA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz51AsWb7a1DQ1b2QA2uKHBj71ksxfYuLvH3csju7JEAvNu//XC
	9CtIrhYidxO//yY25uZSnw6AsI89/KcJnFNoX8AvMHhEqQh2fmUAlWfaUBrfimoounF1sDF2iym
	RyVP6t8RdrenD+5sjKrzRH4hK66wO/1I8Tq8aBDplyw==
X-Gm-Gg: ASbGncsjOElIWycd7q5npoPHiCEyCxGOHWKHRqaOMEqnKRBE7RV282qnA6oFeAdPSVz
	gvDnip2pGc0FsqGJepqxu5W9Hy45YfQjlJIh4d8vR2y/lO41gg83E1irdqpuzrg7F9TZq6wopx+
	bwOYDNook6KjmY51MFxDhnBSxsC0zFcuN5j5L/MqzIjzKSFCFvj9fGCKEd94by3LM3OVNNYMlnZ
	FXgQQvLaJ6R4D+iUiZZbvl5A5l1Xqp81cU9mtmzPmgm1tDJlhL8Xy8HlkddASKyMQv+PQcvkQMy
	6ke+2MzEIb9BuWaVt6nrqkVkh49ixMr1Cx2CUw==
X-Google-Smtp-Source: AGHT+IFUKOnXPDs8a2OOZs+pBEyl2f02D2H0K+/6kqQT8nCkgiZkxOsHHEpwkVcL+Z14TYTGf/esFClV15+tJAvuTeg=
X-Received: by 2002:a17:907:25c4:b0:b6d:6d66:e8e9 with SMTP id
 a640c23a62f3a-b73679623edmr1256089066b.61.1763384646724; Mon, 17 Nov 2025
 05:04:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251116-next-15nov_expose_sysfs-v1-0-3b7880e5b40e@oss.qualcomm.com>
In-Reply-To: <20251116-next-15nov_expose_sysfs-v1-0-3b7880e5b40e@oss.qualcomm.com>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Mon, 17 Nov 2025 14:03:53 +0100
X-Gm-Features: AWmQ_bnYqDUgPK_A-e9vDZgBjQY5CHNYg6xTYxhz9SjkX2KqaHURlYVBsLTAMfI
Message-ID: <CACMJSeuiL5XEZjh8mOSj7tUnR8wEYSJ6FfZA87v8TSu8xM8_JA@mail.gmail.com>
Subject: Re: [PATCH 0/2] reboot-mode: Expose sysfs for registered reboot modes
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Sebastian Reichel <sre@kernel.org>, Bjorn Andersson <andersson@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	Sebastian Reichel <sebastian.reichel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 16 Nov 2025 at 16:20, Shivendra Pratap
<shivendra.pratap@oss.qualcomm.com> wrote:
>
> The reboot-mode framework provides infrastructure for drivers that want
> to implement a userspace reboot command interface. However, there is
> currently no standardized way for userspace to discover the list of
> supported commands at runtime. This series introduces a sysfs interface
> in the reboot-mode framework to expose the list of supported reboot-mode
> commands to userspace. This will enable userspace tools to query
> available reboot modes using the sysfs interface.
>
> Example:
>   cat /sys/class/reboot-mode/<driver-name>/reboot_modes
>
> The series consists of two patches:
>   1. power: reset: reboot-mode: Expose sysfs for registered reboot_modes
>   2. Documentation: ABI: Add sysfs-class-reboot-mode-reboot_modes
>
> These patches were previously being reviewed as part of =E2=80=9Cvendor r=
esets
> for PSCI SYSTEM_RESET2=E2=80=9D, until v17. Following the suggestions fro=
m
> Bjorn, the reboot-mode sysfs patches have been split into a separate
> series here, for focused discussions and better alignment.
>
> Previous discussion on these patches:
> https://lore.kernel.org/all/20251109-arm-psci-system_reset2-vendor-reboot=
s-v17-5-46e085bca4cc@oss.qualcomm.com/
> https://lore.kernel.org/all/20251109-arm-psci-system_reset2-vendor-reboot=
s-v17-4-46e085bca4cc@oss.qualcomm.com/
>

When doing a split like this, please keep the versioning going. This
should be v18.

Bart

> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
>
> Changes from previous version:
> By Bjyon
>  - class is made static const and moved on the stack and registered
>    using class_register.
>  - Renamed name of class variable from rb_class to reboot_mode_class =E2=
=80=93
>    Bart/ Bjyon
>  - Renamed function name to prefix reboot_mode* to better align naming
>    convention in reboot-mode.
>  - Changed reboot_mode_device as static in reboot struct and registered
>    using device_register.
>  - Used dev_groups, instead of creating the sysfs attr file manually.
>  - Continued the reboot-mode registration even if the sysfs creation
>    fails at reboot_mode_create_device.
>  - Used container of dev in show_reboot_modes to get the structure
>    pointer of reboot.
>
> By Bart
>  -Synchronize class registration, as there may be race in this lazy
> class_register.
>  -Remove inversion kind of logic and align the return path of
> show_reboot_modes
>
> Other changes
>  - reboot_dev is renamed to reboot_mode_device to align the naming
>    conventions.
>  - Keep a check on status of device_register with bool flag as
>    device_unregister should be called only if the registration was
>   successful.
>  - Add a dummy function reboot_mode_device_release to avoid warn in
>    driver unload path.
>  - Date and version change in ABI documentation.
>
> Link to previous series:
> https://lore.kernel.org/all/20251109-arm-psci-system_reset2-vendor-reboot=
s-v17-0-46e085bca4cc@oss.qualcomm.com
>
> ---
> Shivendra Pratap (2):
>       Documentation: ABI: Add sysfs-class-reboot-mode-reboot_modes
>       power: reset: reboot-mode: Expose sysfs for registered reboot_modes
>
>  .../testing/sysfs-class-reboot-mode-reboot_modes   | 39 ++++++++++++
>  drivers/power/reset/reboot-mode.c                  | 72 ++++++++++++++++=
++++++
>  include/linux/reboot-mode.h                        |  3 +
>  3 files changed, 114 insertions(+)
> ---
> base-commit: 0f2995693867bfb26197b117cd55624ddc57582f
> change-id: 20251116-next-15nov_expose_sysfs-c0dbcf0d59da
>
> Best regards,
> --
> Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
>

