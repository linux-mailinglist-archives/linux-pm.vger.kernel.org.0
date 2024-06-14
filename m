Return-Path: <linux-pm+bounces-9195-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA69908C7F
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 15:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAACD1F277D6
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 13:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35E819D8A8;
	Fri, 14 Jun 2024 13:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dwn9JsmK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC6B63B;
	Fri, 14 Jun 2024 13:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718371916; cv=none; b=pNWFsAQrk/0GEF+YqbIcBezhWy0nVugWydAMUm82HA/YGdMZrqDYJJTEGCUSCT7B3kjDYZDhj1AI/3Rx9rpdQ36MOL+kxQHEMNM6IPs+1TZPUv5Yqb1+NfUF/EWr2mG1RlEehUZJK8HLVBwWQKBDn6AGQdgU/F0hb1SRfuEY+nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718371916; c=relaxed/simple;
	bh=CnZQ/3VaTahmpIa3hGiXHaxl9bu6GAUI0idK+B82Eh4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ayycCW7dDbs0ZGH1m1ZRxGq0jeNiWu9JZlkQQW9XdPJwlOYqAID4n+aTulwPXVOV7HkUcYaDw0aTamt2xlU8W1UKzAd46u7u/B5+ASMsB10HGlYii5Ul58evmkcov/COVYyFxJRSJTs2oAPIcvxai42kyoQskjrewQD2TZxb+SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dwn9JsmK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DBD7C3277B;
	Fri, 14 Jun 2024 13:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718371916;
	bh=CnZQ/3VaTahmpIa3hGiXHaxl9bu6GAUI0idK+B82Eh4=;
	h=From:Date:Subject:To:Cc:From;
	b=Dwn9JsmKx98fLZ5S1VCQnogoOVlF9Z2mka5rb6o2ThuxPOGsun1Al6qGtsCWKNvJ9
	 T9pLFM6J7loVPZ1sgiZALHa/VdB3RftM+4BtcZfTRU0nMw8PaX5GGd6rhXe6DOoc6a
	 T3XtclAznDj5DTjcuWMd5GTd7S0SLSgMa3YZPER+/DVJocKcRf4bB2Lr98SSgt32bo
	 YYSxBO+BOnq/tA32Nd7nxX3T0N7sYgsfJNxFiUdvdrDqAZjLLFFvLtfn9DQ4NdV+q9
	 PqhkQ1PHk54DrKvOIFGaAUsCw2i2a09mV7uea0DvBrLPB12TgRGAg+IL3Jc4RBKkgS
	 9EnnJJp2rgyJQ==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3d223ce8661so62607b6e.0;
        Fri, 14 Jun 2024 06:31:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXJ0q+K6wzuAd8eLLkIPEXbiH/TM1N1NiO0uUR1qC5sYPLnAFGwFnmvXa3rLklE5LjnYHi1AzY8E3JhNmbSMFbl6e2uGIi4nDHZkRDP
X-Gm-Message-State: AOJu0Yzxz0FB66LvwQa9ucU+d3fgnJL+LqdkHBcm08kdIP/5t/lHa07w
	3Af7jTOX00j2palF+cepRhY5wBp4InkuCTFZhGKS0TMxUdWva8DyjiXQE29f+VXxl8XXD8cn78/
	UDnN+dsX2MkG4P21iguZcZ3u5CNM=
X-Google-Smtp-Source: AGHT+IEZ7JkJWmqtyZ0Gg8Rg94NXtukLbhKhQu2sUQ5b1nH44ZZG8kAwkQTejSXh0JuoQrOaOkGHQwmvsJ8S5ontoyg=
X-Received: by 2002:a4a:d027:0:b0:5aa:3e4f:f01e with SMTP id
 006d021491bc7-5bdadc10d0amr2809546eaf.1.1718371915381; Fri, 14 Jun 2024
 06:31:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 14 Jun 2024 15:31:44 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0husVUEZJUJzumfmB-18v2R5RuQbxTpxwRx1q1oVtLn3w@mail.gmail.com>
Message-ID: <CAJZ5v0husVUEZJUJzumfmB-18v2R5RuQbxTpxwRx1q1oVtLn3w@mail.gmail.com>
Subject: [GIT PULL] Power management fix for v6.10-rc4
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.10-rc4

with top-most commit 350cbb5d2f676bff22c49e5e81764c3b8da342a9

 cpufreq: intel_pstate: Check turbo_is_disabled() in store_no_turbo()

on top of commit 83a7eefedc9b56fe7bfeff13b6c7356688ffa670

 Linux 6.10-rc3

to receive a power management fix for 6.10-rc4.

This restores the behavior of the no_turbo sysfs attribute in the
intel_pstate driver which allowed users to make the driver start
using turbo P-states if they had been enabled on the fly by the
firmware after OS initialization.

Thanks!


---------------

Rafael J. Wysocki (1):
      cpufreq: intel_pstate: Check turbo_is_disabled() in store_no_turbo()

---------------

 drivers/cpufreq/intel_pstate.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

