Return-Path: <linux-pm+bounces-29688-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B54AEBF92
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 21:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BE60563CBF
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 19:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332231E1E0B;
	Fri, 27 Jun 2025 19:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ed3n96Gv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3031F8724;
	Fri, 27 Jun 2025 19:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751051733; cv=none; b=rKuoJxePZ7beQ5eRupHkuag2wCp/S4KlhuzEkvEtTmRn+hNSjMFxHHY/AXOqnfUkY+acqtklF9Om4PA+LDc4a7CJHUU3SGcOIc9Lx/2byWgWJT4sxb2rJRvtCSNlQ6fJ9h/Zup2p+tYBpgXEd7UerJgYawo4PUYzAZy4k7lrTIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751051733; c=relaxed/simple;
	bh=4jrabYQ0JtI6OuhTCr7VLTvejtfzNWRPfphd7z7CjYs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=VDCWTSURH6OAMFRPRDuNNgGmfVgTZOBj6KCFti1skkhsI0vxsXlcQoVHYIkvVZmdvLsigKtHsUYzB621IwCXxthaF/5Hk04Bua/zubiW53JcqqzPimIV6YatToW2qJNtbLFbGkVxyluS35IQnydbJIkHZKunQsgVRw/ArfmF/6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ed3n96Gv; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b321bd36a41so350149a12.2;
        Fri, 27 Jun 2025 12:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751051731; x=1751656531; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MC33Lr444cQjbDQpogG91dDKBJUHhtcvW36ZB7YX1Y8=;
        b=ed3n96GvXcwUQ2W9eZuvVbhwpTgg8M5ol8CtCHyOFSaVKo7yga9uAqO50reIF+NLYs
         pKTQqggdzBYAhuapGSPn596Q56mzuOlJawi48UTAi9Y9q7EBIrwakvAQ5Gv4Vga/uySE
         MFPvG0SC4oVsTqXB2/oyWc6nE/t+mmUGyBGh70tiuBjcChk7neHTw0xB7qSDpQ08wUy6
         PKIUzNNC6zUbrYfinjLQE4B+dQvffV7ObFztj7jwFz4W6GE4rRSZVL1ziAgMOthJ8uGo
         chjKNLvINE9egH0/tHhJwl8GZlhoVDH/8Tv1mUWBxOsbqX0z1Zp7vrCeOzb36ZU1nkeu
         p36g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751051731; x=1751656531;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MC33Lr444cQjbDQpogG91dDKBJUHhtcvW36ZB7YX1Y8=;
        b=aE9lYnPRRuF0RlytBAeXf+NU1CinkPhnJVK7rnRKTE9tPg/74eDpQtY1I50bXC5V1E
         fTYQxLfdydDtU4vpPGgd7YU3klmlyzSRqAcrsFBfC/jtmoDcelA8rGYd5snyXPxzRb2c
         mKma5B/Ac89QzZfOuft7wdz0xz/c+MOADQk2qk9TbIcHc3Sj0dUIX4GpWK4wZkLp63Xe
         hmmvwX+nz4hSmOUq8A08EQHbqL7mBMr6/0iuNhQySfWej4Ht/1Exm0GcprbI3v4wIkof
         09QfBE49Bz/ZOulQ49AKEjOX+dfMc02khWZd/PRMqcXJsST9WmXe1mtqhgRHjYwQIRty
         6V8g==
X-Forwarded-Encrypted: i=1; AJvYcCVmQUizcrQGbI0uWoqKUfZImqiRu1YkEW79NUDsNKRED/z5aSPs6XO8cjdYpYWyUkpXI5p0UfWhOg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUPrtVYAcUysfXwtKD/+6k5UATl41BQgMwpa93fdM3FqpvEsVO
	LEdaViqVY9JEXo+DkggZPWTktl2rBmiZ2pT8xs9zMctX/vomfGuiUnbS
X-Gm-Gg: ASbGncvImzK3qIuq4bUB7WPwyiBHscr3B0Y35SqjM7/sMu524DTAnFCwWCK8pg4lS7c
	QsOyszEXiSh/4VthoLJo/hxlPhSns0IZPbtCzKvRZvScwUzV9epYkwlsDg0jXkWYxVi8QnZD81o
	K5iMx57+fRMLGcdbjSeqxGTdeHkoLxO7a403+SPWBGbaAqVqwuCQZi4ig4ewba/XJ012Nr0HvW/
	QL06mvpYYAyDKkV60qFjC4a+n4THdneWofp3ectvdLQRxvoi4IKrgwrRpghB8Z/Q/sBdNwWIci5
	7lQYfw1piMGsxJZoodltrKQ3KpfDSiDgI9vTRWC8nudFlO1cvvF5ygM=
X-Google-Smtp-Source: AGHT+IHcuG/PKrysKfVFrUFi9VUefuigkudHVP3viNjydqJL6P0UaWxAMZQHOs8+lKRCAE9NOXqMXA==
X-Received: by 2002:a17:903:2ece:b0:235:f70:fd44 with SMTP id d9443c01a7336-23ac45ce9d3mr68539455ad.21.1751051730662;
        Fri, 27 Jun 2025 12:15:30 -0700 (PDT)
Received: from localhost ([181.88.247.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb39b97dsm23407155ad.121.2025.06.27.12.15.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 12:15:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Jun 2025 16:15:26 -0300
Message-Id: <DAXK1634VYQI.1PEUCTQIYAF3Y@gmail.com>
Subject: Re: HP Omnibook Ultra Flip 14 - power profiles
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Armin Wolf" <W_Armin@gmx.de>,
 =?utf-8?q?Benjamin_Hasselgren-Hall=C3=A9n?= <benjamin@benis.se>
Cc: "platform-driver-x86@vger.kernel.org"
 <platform-driver-x86@vger.kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Daniel Lezcano" <daniel.lezcano@linaro.org>, "Zhang
 Rui" <rui.zhang@intel.com>, "Linux PM" <linux-pm@vger.kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <GXa7F-PA_8BE7nlK9r8dkdSv7c-DW52GvOUiyYHQ6RyoZDxIpNAocWDPYQDeS7WEZeUisqQH_bqmgSV-eaRmuw5r68MGKxyU9X_4Erd0RYQ=@benis.se> <1037e223-a6ad-4d12-9619-f69a29cecba1@gmx.de> <5I8UDmgF_DcJBmBE0zgCXjuvmmhLamDCHkpnkAwRjSAkCa5xcFUvU-SmAeymxTajjDPR8avuW55RxOjhd8idK6jLy-hz8i-Ma3RHSaFy2Gs=@benis.se> <9642ad7e-3e57-45f9-bfd9-beac3e55418e@gmx.de> <GXC8NQl6AY_N7nQAOCRLt7SDGjFNll_TnqQyzYnP_b1weGkRqITOR-kHKcM66lPonOCo9xO2nSWXr7yycwfFuKmjRMtXVlJKya8-qvvkGik=@benis.se> <de8321ce-e595-460a-81d7-f7dae8a7b790@gmx.de> <X-40AqXfdmQw5shUOk3VSaHSXmwJYWHPmDDMLyGUH6GpMt56ty5SbNg8EVfyI_uC9J07uqZ2TtGJmmpB_x8-xpcVOw29fnKzJZ4n9L0x78A=@benis.se> <9439ec38-aadd-4aac-ba51-a8786ba50239@gmx.de>
In-Reply-To: <9439ec38-aadd-4aac-ba51-a8786ba50239@gmx.de>

Hi all,

On Fri Jun 27, 2025 at 2:10 PM -03, Armin Wolf wrote:
> Am 26.06.25 um 15:20 schrieb Benjamin Hasselgren-Hall=C3=A9n:
>
>> Hi again,
>>
>> dmesg: https://drive.benis.se/s/2crz7zPzkrzaqXN
>
> The following message intrigues me:
>
> 	platform_profile: Failed to get profile for handler hp-wmi

This might be a regression.

This was reported a couple months ago and I completely forgot until I
saw this thread. See [1].

@Benjamin: Can you please check if your power profiles work on Linux
v6.12 (LTS)?

Also try:

$ cat /sys/firmware/acpi/platform_profile


[1] https://bugzilla.kernel.org/show_bug.cgi?id=3D220008

--=20
 ~ Kurt

