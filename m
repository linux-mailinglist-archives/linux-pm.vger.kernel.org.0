Return-Path: <linux-pm+bounces-27377-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69584ABC790
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 21:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE03E3B13FA
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 19:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4922B2010EE;
	Mon, 19 May 2025 19:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sNopv/G1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7451D63F8;
	Mon, 19 May 2025 19:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747681574; cv=none; b=JvbzBSUyhwDzv8ZdMet5bTCuuZ7BKp83Khks63XN95WIsBzaHXkqmnIRpeotn1/yZLvaWWGwQTeA62oLBhhTAJXWBfkK2VNrjFXRznZwJ+Il9HSqrA65Ta1KzVfZOCn+lvPjRAvhBEGMKma/vIQ24cJ0nucGZI5wFJLvf6KRADA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747681574; c=relaxed/simple;
	bh=tFw0t3atZjBtOeZNf2x8rUHoUf3ELXVU5h2N/f7iUeU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ol5LYs3XnjfX2rhO2fp1KCBn2ixx14ZHs5RZy85fAchpgQm+qBUlZFQfzpY+eUbG712FtJJnXlYmBThmaMRzsTSdKo1NVZ86ENGAu2r0x0VHu+PT1OBNm768utTSYzpuwWBRWNvZRLrBWd/SJ4iPq6kQ6XERbZMECQP5CBbRgq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sNopv/G1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78BD4C4CEF2;
	Mon, 19 May 2025 19:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747681573;
	bh=tFw0t3atZjBtOeZNf2x8rUHoUf3ELXVU5h2N/f7iUeU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sNopv/G1mOPoQ1TxFAoa+vMRTND1M8ZMppTV/fUTJRpY+Nc6kR4XkPCW++y5AzxIv
	 vu4h2Div/qtbDsucWBbCui+Tk3PhfCbAw3PzRMx/cZrgzWDyjoGM37NzG29PdiY/HJ
	 wxOjRY7tikCe1040ML6SWwpNWFtHz63ffqWeXwC/Udxqs5bzNraixWKs4EJ3/2JUyz
	 UeZI1oCNRkGrgMeSrCKcz0ediqh4cTWy8Y8Ps/mNZZj2yj+DRwibhHOb6hwFCxm7m3
	 0P5i5X8NXv4Ukk8K2VIxoCMSmpVmqSOV9d9VRQo7yX4ryM5l6DLMjfrOOsL4nS2ovl
	 sNH5bSHQ7RmVA==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6049acb776bso2630400eaf.3;
        Mon, 19 May 2025 12:06:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWHbq6kbZ9hAjOke3ET2QkfY5c3bgA5wAyqyDqxYfx+gJ3K/DKJy/z4+UUsEyBX0XHoartDN7UYCZUlKV0=@vger.kernel.org, AJvYcCXP3f2l7FKg7+RvfzBUaf4GOJWy4cDjY8uEGIV67oizBcqVdYI7oXq164bYIu3KXjLaoZ8iyn+CYb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJzDlALuxJorlXuu5q3fRgLfuanGQzJn5l/LV56nKrQRm5d3v9
	T8jKvd9ZZj5tXfGyDzzJKjqXexflv2jIskqPNxG2qpwqoaZZP09f9Z9vbmwYRzBf0M1gCGTWjgX
	KLgihrwNgd9WHCjqkcCLY4TuJpdnYtjQ=
X-Google-Smtp-Source: AGHT+IHQd1MO7PnPpXcqf49eS7DqEkMa9Ese0669wTU/fIYweQz4BJ0avm138TLbH5PdWepdpkuMlE+L3jWMHxEcrT8=
X-Received: by 2002:a05:6820:4b0b:b0:603:f2f6:fd41 with SMTP id
 006d021491bc7-609f378d263mr8902292eaf.3.1747681572545; Mon, 19 May 2025
 12:06:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aCtZdbNA5UwE4j4b@mai.linaro.org>
In-Reply-To: <aCtZdbNA5UwE4j4b@mai.linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 19 May 2025 21:06:01 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g-iTiuTpK44TNC+R2-RSW7mHRdDzunFEz0D9MyuJEL0A@mail.gmail.com>
X-Gm-Features: AX0GCFtx53qGapvJKo5U_71QDbS_8XlsT1cgStLo9xl7SyqztKtaHbGTP8NW5lU
Message-ID: <CAJZ5v0g-iTiuTpK44TNC+R2-RSW7mHRdDzunFEz0D9MyuJEL0A@mail.gmail.com>
Subject: Re: [GIT PULL] thermal drivers changes for v6.16-rc1
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rafael@kernel.org, krzysztof.kozlowski@linaro.org, 
	luca.ceresoli@bootlin.com, kike.correo99.f@gmail.com, 
	angelogioacchino.delregno@collabora.com, arnd@arndb.de, ansuelsmth@gmail.com, 
	srichara@quicinc.com, george.moussalem@outlook.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Mon, May 19, 2025 at 6:16=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> Hi Rafael,
>
> Please consider pulling the following changes since commit
> 82f2b0b97b36ee3fcddf0f0780a9a0825d52fec3:
>
>   Linux 6.15-rc6 (2025-05-11 14:54:11 -0700)
>
> are available in the Git repository at:
>
>   ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.gi=
t tags/thermal-v6.16-rc1
>
> for you to fetch changes up to e23cba0ab49a9cf95e9bc3a86cfbf336b0e285f6:
>
>   thermal/drivers/airoha: Fix spelling mistake (2025-05-16 12:50:01 +0200=
)
>
> ----------------------------------------------------------------
> - Make the Hisilicon driver to compile by default when ARCH_HISI is
>   set (Krzysztof Kozlowski)
>
> - Cleanup printk format with use of %pC instead of %pCn in the bcm2835
>   driver (Luca Ceresoli)
>
> - Fix variable naming coding style in the AmLogic driver (Enrique
>   Isidoro Vazquez Ramos)
>
> - Fix missing debugfs entry removal on failure by using the devm_
>   variant in the LVTS driver (AngeloGioacchino Del Regno)
>
> - Remove the unused lvts_debugfs_exit() function as the devm variant
>   introduced before takes care of removing the debugfs entry in the
>   LVTS driver (Arnd Bergmann)
>
> - Add the Airoha EN7581 thermal sensor support along with its DT
>   bindings (Christian Marangi)
>
> - Add ipq5018 compatible string DT binding, cleanup and add its suppot
>   in the QCom Tsens driver driver (Sricharan Ramabadhran and George
>   Moussalem)
>
> - Fix comments typos in the Airoha driver (Christian Marangi)
>
> ----------------------------------------------------------------
> AngeloGioacchino Del Regno (1):
>       thermal/drivers/mediatek/lvts: Fix debugfs unregister on failure
>
> Arnd Bergmann (1):
>       thermal/drivers/mediatek/lvts: Remove unused lvts_debugfs_exit
>
> Christian Marangi (3):
>       dt-bindings: thermal: Add support for Airoha EN7581 thermal sensor
>       thermal/drivers: Add support for Airoha EN7581 thermal sensor
>       thermal/drivers/airoha: Fix spelling mistake
>
> Enrique Isidoro Vazquez Ramos (1):
>       thermal/drivers/amlogic: Rename Uptat to uptat to follow kernel cod=
ing style
>
> George Moussalem (2):
>       thermal/drivers/qcom/tsens: Update conditions to strictly evaluate =
for IP v2+
>       thermal/drivers/qcom/tsens: Add support for tsens v1 without RPM
>
> Krzysztof Kozlowski (1):
>       thermal/drivers/hisi: Do not enable by default during compile testi=
ng
>
> Luca Ceresoli (2):
>       thermal/drivers/bcm2835: Use %pC instead of %pCn
>       vsprintf: remove redundant and unused %pCn format specifier
>
> Sricharan Ramabadhran (2):
>       dt-bindings: thermal: qcom-tsens: Add ipq5018 compatible
>       thermal/drivers/qcom/tsens: Add support for IPQ5018 tsens
>
> --

Pulled and added to linux-pm.git/thermal, thanks!

