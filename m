Return-Path: <linux-pm+bounces-40415-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA42D01144
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 06:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 66A163001BF0
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 05:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5BE2EDD41;
	Thu,  8 Jan 2026 05:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=summations-net.20230601.gappssmtp.com header.i=@summations-net.20230601.gappssmtp.com header.b="xGKeAvZc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A94B2ECEAE
	for <linux-pm@vger.kernel.org>; Thu,  8 Jan 2026 05:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767850073; cv=none; b=BBd21guo2FBSy6H9pTjm0dXAQy+urQZOJ6Tiy3xHXU7lxsJ3uCwPNng3kTugEEJnOUlXUd7TmZVG/SO8YSnTvOE4zYfiEEB7PzFq1aikJJ+5fdTdWzNhSTjI6Ip1Fa7dLBTrDtSfYO9BvfTHLgb9CW5NgjrCbxaKRoMKsfNuFqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767850073; c=relaxed/simple;
	bh=axExFEVawx6b/HLBeJrzGMEy2cTYiNuIo7O1q0+jeGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kp87+EHXOnTUoXd6LVznQPuUlfAKbHvyA9u7xijnB7vBKvTx4F+TUYXU7MwQ4k6KwH1S06zhtJf0mB6+e8Aw+ahSrpSZiKdTkNw5qSO7UB6m5cd56QRgsaWDjrQqqaH50PVdY2g+f5gq8uMSWC/Jueh3zFCY4P2nBniokbyTA5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=summations.net; spf=pass smtp.mailfrom=summations.net; dkim=pass (2048-bit key) header.d=summations-net.20230601.gappssmtp.com header.i=@summations-net.20230601.gappssmtp.com header.b=xGKeAvZc; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=summations.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=summations.net
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-78f99901ed5so30637637b3.3
        for <linux-pm@vger.kernel.org>; Wed, 07 Jan 2026 21:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=summations-net.20230601.gappssmtp.com; s=20230601; t=1767850071; x=1768454871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BC+osoIwsp+MvsvfieiIYrUxWM9BGrlddB8KAIiHx4w=;
        b=xGKeAvZcSxK9lW8webwP+1N941XNaFYkt61G/E3lNAci0GtowPkgoiVTl9QSVaXWBR
         NWQe8Q+Jhim9ceguMLnCa8ihrljpG+P4/GTPznEWVBPPVUGGQcE1QAHTraBESCHwq3kX
         RnGM4vAdxFs7TFxTxOzlEQMAfRXB3lzqL/2nltlRl1Gn4Z3OOM1XFYihd4I2Pg6HYEI+
         lgzuuOMN7Z8aCJL0rFbnUBYqomZ1NaPVpmFm/TQwMRSeOZahfYNjMPQzlZJLLVvr0Anb
         zgZIN7rT030zYJ+BgnXq1LWJC2VEXQdpZHi/IeJSicd0XRgAGn0S/dNN306t5Vq52DcH
         cLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767850071; x=1768454871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BC+osoIwsp+MvsvfieiIYrUxWM9BGrlddB8KAIiHx4w=;
        b=FMoDFt+HzFQtipC5qUGUo25qbuPIQ9ifw04qk17fh92D1bf2OhPWki1mAo/D16VXXN
         QGmCImLlRdp+HN4n8O4TDBOQpCWwdy4GDuNVAYDvhEJimkzDenqj6tiTEAP01IJHZCpp
         Qbf1aXR4Bp3BSnzIcn5fr3QNcQJ/y24Rq4PnRkMYx/kSizEYlknJYRJSWaNPYZZpSe2U
         qmPIeu2O7jhniBlWfZ+dnwkP8iJV6e99xJmMURDr8rwi6i0NXQJqjDV7u7p1O6tejQAW
         yRw+e3KSOQVuX3WGm7VPNpo2ND424IHGNQMbmYUqRauO+9Uvfx2oSPl9Mq1Phgf6PTE9
         mQiw==
X-Forwarded-Encrypted: i=1; AJvYcCWanm0R8h0RttEX46ibvtOnjvx8pEbmz/cf7Xu2Mbbi+fCMDsdXJymo335mAp/wfCG0wemZrMwLwQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz25+vWk5hZwPMPCzAhwdytSq9iZLl+vDNVz5oV6ZcqPwYv9vU5
	eg/dLz5+2CSDRSB47cXLJ04ZVQhg3RYMDQn99JwCeUmmXlCE7z75GcDxt1ZK7zWlU9BMuFwjZ3o
	MqE3EsVNOKG+aQ/hCyIOHbbUS6divnVxkQyYH2oWNKEU=
X-Gm-Gg: AY/fxX4BWamZn1HHGTBgHnIdEHHAX2ABBhJMyalpYuTJGeqWSz9ghMBsHUwCpwecYet
	i97tLl7JeCSEdNd9xK0MOE13iOfbbSa3eYKGA6y/Bo+Algm9JJan8VPZzOM9j1s4aKy2F3xWa9F
	9gTNpZEundBABuRmdgERO0SJf2PMKy61FyCzqj6jEufITwE4N/8Rp4KzusN/aGJvnyI1/VgEHB8
	e9EMtoNHW6KIPdUD9eOds01B3ktN86LHPGj2MBwAM2QQu6pXPeUbHlqHHMlFaNA0lYdrFS/vnSx
	Se67ihgEc9iId/s0BODCOcVoQKHA
X-Google-Smtp-Source: AGHT+IFOgL9QuUd80/piaFldcHRAVd0y782EaLehHJfIPXTxtTytmiYz4W9EajgqaU/7OrfDZq3ETfFnz3U6oZf/2iM=
X-Received: by 2002:a05:690e:120f:b0:641:f5bc:696c with SMTP id
 956f58d0204a3-64716c60119mr4870525d50.72.1767850071169; Wed, 07 Jan 2026
 21:27:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106092117.3727152-1-joshua.yeong@starfivetech.com>
In-Reply-To: <20260106092117.3727152-1-joshua.yeong@starfivetech.com>
From: Rahul Pathak <rahul@summations.net>
Date: Thu, 8 Jan 2026 10:57:39 +0530
X-Gm-Features: AQt7F2qhmjlZCACoqEpff45oADUXIoYNWJ-4094MakljrIym7FWPaVOI4-KiK_c
Message-ID: <CABdD5xkq=LbaUo=jDGSF2U2Rb0r13EEJQMfSjxEMsSX0mCDyhQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] RISC-V: RPMI performance service bindings and cpufreq support
To: Joshua Yeong <joshua.yeong@starfivetech.com>
Cc: anup@brainfault.org, leyfoon.tan@starfivetech.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, rafael@kernel.org, 
	viresh.kumar@linaro.org, sboyd@kernel.org, jms@oss.tenstorrent.com, 
	darshan.prajapati@einfochips.com, charlie@rivosinc.com, 
	dfustini@oss.tenstorrent.com, michal.simek@amd.com, cyy@cyyself.name, 
	jassisinghbrar@gmail.com, andriy.shevchenko@linux.intel.com, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 2:51=E2=80=AFPM Joshua Yeong
<joshua.yeong@starfivetech.com> wrote:
>
> This patch series introduces support for the RISC-V RPMI (RISC-V Platform
> Management Interface) performance service, covering both Device Tree bind=
ings
> and a corresponding cpufreq driver.
>
> The first part of the series adds YAML bindings to describe the RPMI perf=
ormance
> service as provided by platform firmware, as well as the supervisor-level
> controller interface exposed to the operating system. The bindings also d=
ocument
> how CPU nodes reference performance domains managed by RPMI.
>
> The final patch builds on these definitions by introducing a cpufreq driv=
er that
> leverages the RPMI performance service to manage CPU frequency scaling on=
 RISC-V
> systems. The driver supports RPMI access through SBI-based transport mech=
anisms
> as well as dedicated supervisor-mode transports.
>
> RPMI specification reference [1] and [2]
>
> Test Environment is as follows:
> https://github.com/yeongjoshua/linux/tree/v6.19-rc4/rpmi-performance
> https://github.com/riscv-software-src/opensbi
> https://github.com/yeongjoshua/qemu/tree/rpmi-dev-upstream
>
> Use '-M virt -M rpmi=3Dtrue' when running qemu
>
> [1] https://github.com/riscv-non-isa/riscv-sbi-doc/releases
> [2] https://github.com/riscv-non-isa/riscv-rpmi/releases
>
> Joshua Yeong (5):
>   dt-bindings: firmware: Add RPMI performance service message proxy
>     bindings
>   dt-bindings: firmware: Add RPMI performance service bindings
>   dt-bindings: riscv: cpus: document performance-domains property
>   cpufreq: Add cpufreq driver for the RISC-V RPMI performance service
>     group
>   MAINTAINERS: Add RISC-V RPMI performance service group


Hi Joshua,

I have a general question -  RPMI performance service group is
primarily defined for devices but can also be used for CPUs.
Do you plan to add a RPMI devfreq driver too for devices?

Thanks
Rahul

