Return-Path: <linux-pm+bounces-33741-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 730EDB426C5
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 18:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EFAA3AEAC6
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 16:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCA52D1916;
	Wed,  3 Sep 2025 16:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Jqzcv09N"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-08.mail-europe.com (mail-08.mail-europe.com [57.129.93.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473C72D12E7
	for <linux-pm@vger.kernel.org>; Wed,  3 Sep 2025 16:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.129.93.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756916613; cv=none; b=VuBmh8qnUQhZnZwKF1DNfnSpDZKNpXQXwaeoGSH+8djkeMcUn4iOaRsdf4dnKB6mj+mYH7AqihADowH0KnvulM3s86PnW6FwCo1dECm8nzylqXzLB9s6VzkH3ggi/3NHpHo8eaYLNHRRbNTjtcq6txyzYqssWPAAu0KjUF9giGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756916613; c=relaxed/simple;
	bh=ImTdk45fEohuEmL0fTKBT+vvbto6WFa2InFnhG0G+MA=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Ckvtuo07GIOLc/l+GxTT7XTv0KFIEAb+B0sfhJlpveHh8iiSlYTxKVnpyrLYF8hyr2KRHiiKeSRjF3aGBlnmvwqtOcdAWN0ojBNSMDtaKoW9sVERGnrGuzxV6yxH5CnaKxGALGYt3YP9vHWAfr4ieDhMgIG7heOUfMHjGgkaT00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Jqzcv09N; arc=none smtp.client-ip=57.129.93.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1756916599; x=1757175799;
	bh=+ORUhx+zeVXnXE7+aCzen2Up5Y/VFjmxmSaXieTvP1Q=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Jqzcv09NnHP2W7WMJX5xh2S2uvEDF+9Sp8bKgdQ0ebTPhxHlru+hZMMhCNcPk9HBY
	 FraJ5casOZkfpodAsHrmoBaUX8OlhQBjzZMjXAM2hAiPENxbgsI5nUBQMbLMgZ1+4J
	 a3VekuOAEX2dWMDqa1TwC90EeJUG7rpFugT+W03JM6J7oEVLTG/6oeimN62fqEfyI2
	 vPOO++OsjQui0DW4WyVYJzLdK7XUe/x9sS/o5BHMpjhT+TaN38o1mFrFHL3FEvcqjp
	 bLKi0ZcVbGWdne2BVoSYIfshrEkmExQEXuyIfSbK9MRacs8Jx1W830ZBUFPd4fcey9
	 T3WLgI/l0HNSA==
Date: Wed, 03 Sep 2025 16:23:12 +0000
To: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
From: aprilgrimoire <aprilgrimoire@proton.me>
Cc: "mario.limonciello@amd.com" <mario.limonciello@amd.com>
Subject: [BUG] MECHREVO Yilong15Pro GM5HG7A: lid switch causing unwanted s2idle wakeups
Message-ID: <6ww4uu6Gl4F5n6VY5dl1ufASfKzs4DhMxAN8BuqUpCoqU3PQukVSVSBCl_lKIzkQ-S8kt1acPd58eyolhkWN32lMLFj4ViI0Tdu2jwhnYZ8=@proton.me>
Feedback-ID: 151975985:user:proton
X-Pm-Message-ID: acb382bdbb0c6be637933d3b0930c7d1f98c9157
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi!
Opening or closing the lid causes my laptop Yilong15Pro GM5HG7A to wake up =
from s2idle, similar to the symptom described in

https://community.frame.work/t/tracking-waking-from-sleep-when-plugged-in-a=
md-k-ubuntu-22-04/44168

This issue for Framework 13 has been fixed in

https://lore.kernel.org/platform-driver-x86/20231212045006.97581-5-mario.li=
monciello@amd.com/

For me specifically, two interrupts appear on such unwanted wakeups: IRQ1 a=
nd IRQ7. IRQ1 is the lid switch, with DRIVER=3D=3Dbutton. IRQ7 has SUBSYSTE=
M=3D=3Dserio and DRIVER=3D=3Damd_gpio. I tried some workarounds and got to =
disable IRQ1, but IRQ7 doesn't support disabling and the issue persists.

I did some modifications to the kernel code:

----- drivers/platform/x86/amd/pmc/pmc.c

static int amd_pmc_wa_irq1(struct amd_pmc_dev *pdev)
{
        ...
        if (device_may_wakeup(d)) {
                dev_info_once(d, "Disabling IRQ1 wakeup source to avoid pla=
tform firmware bug\n");
                disable_irq_wake(1);
                dev_warn(d, "Also disabling IRQ7!!! This is bad practice!!!=
 Remove after testing IMMEDIATELY!!!");
                disable_irq_wake(7);
                device_set_wakeup_enable(d, false);
        }
        ...
}

----- drivers/platform/x86/amd/pmc/pmc-quirks.c
        ...
        {
                .ident =3D "MECHREVO Yilong15Pro Series GM5HG7A",
                .driver_data =3D &quirk_spurious_8042,
                .matches =3D {
                        DMI_MATCH(DMI_SYS_VENDOR, "MECHREVO"),
                        DMI_MATCH(DMI_PRODUCT_NAME, "Yilong15Pro Series GM5=
HG7A"),
                        /* Not matching BIOS version: MECHREVO doesn't supp=
ort Linux officially, so no expectation of them fixing the bios. */
                }
        },
        ...

But IRC7 cannot be disabled:

(base) =E2=9E=9C  ~ echo disabled | sudo tee /sys/kernel/irq/7/wakeup
Password:
tee: /sys/kernel/irq/7/wakeup: Permission denied

In dsdt.dsl, I also nuked some code about the lid state and changed all Sha=
redAndWake to Shared, however it didn't work either.

Mechrevo officially only supports Windows, and this lid issue doesn't appea=
r on Windows. Does this indicate this issue can be workaround in the driver=
 level? What can be done next?

Thanks!

