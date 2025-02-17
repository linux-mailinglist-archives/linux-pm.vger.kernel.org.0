Return-Path: <linux-pm+bounces-22254-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E48A38D9E
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 21:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6F491732F9
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 20:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FEEE238D42;
	Mon, 17 Feb 2025 20:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqMwvxxR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC5F235BF4
	for <linux-pm@vger.kernel.org>; Mon, 17 Feb 2025 20:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739825100; cv=none; b=X+e6P5JVvaSVZP5jAtJwwdlcs2Do+UzJniEmaLV1KeS7F0158wO/w4RQXMU5Y4XPmY3beSOg2htJ0HhviGGgVXlOy4q37SHqiKt1j6ZfKpl1lUxVm91kC4aKcOgblDZzfCRFJTasQO/oBUrBRiwvhM/o9qbTodS9yUsyvKEsgVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739825100; c=relaxed/simple;
	bh=8pLWhykq/xuXsSGo3fdN/MDuXB8gYp2zSrRpJzw54+8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=RTnQwoZwI6baCA76jrLa6r6IRgboMqKdSxWG8ryoCe9lHqpflgHAJlQoW5l9lrYDknQmJdvEB59k0LPcEHcCiapFD/3RSNvJy9xei/wQ+v0KJlnTNj92xwSr3+rvxdmOUpQ2D+u31TjqaZd5gfwCApPkOWwS8DfX0cW4/jTxowg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LqMwvxxR; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e0505275b7so2741708a12.3
        for <linux-pm@vger.kernel.org>; Mon, 17 Feb 2025 12:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739825096; x=1740429896; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8pLWhykq/xuXsSGo3fdN/MDuXB8gYp2zSrRpJzw54+8=;
        b=LqMwvxxRkcENjS72aFBO0SbnqEL/0n1itpL7ht8kVVGunwJQqPWBDiK53s2qool4bo
         8PZfT8zZPGvjdAPhJh3xChI24kSPCmlj5jeBMKfTvSwuv0yLpeEmMdE5W3X6fNfvXmfE
         wqGfyjlmYc0/rSRHEsIinwyxnYj8HoDIZ4p0NiaXidnsM0QBa23wThmDCnsUI8yO6n+r
         4JM6ijdNxDl2S5Z3Geom1AgSSeTQOvmoE/oo2p30Y3UkZSOjS8pY0DudpIrqw3JmVT9R
         ufr9kL8YutuUwVMFT7q7wDYpjaLOOcn7/wO4fuR8Hh/buX5W4ZW2G35k8t75NjuaMvJ0
         a5+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739825096; x=1740429896;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8pLWhykq/xuXsSGo3fdN/MDuXB8gYp2zSrRpJzw54+8=;
        b=qD81HMfEesrQwQnzFMg2Afj7OvKrF5OaOTH8JE2kgZriou1GjvdAE8VZVhsiCh2JfR
         pLKfTmbqfcAzk3esMUHfZFi0RqlUCzJFghnxEbv+4XEOjVy0YMayZn7hIqwj9g6Y20Y+
         u4tBaKbVaM3yRbceH1WcNcSMbvDjJx8bbPY8VfY+dV4Vr9pf/KSAeFxrnHk2r9qNVlra
         nXr3e0Yan95MvU75s6cwk8H/JPezCeSEDsno3GfTBAxIC551T48nguPyM4ABqAbPrQAm
         Ebsa53vdu1C4G5/cDzwB+eRVhhhwM6Aviw1f5De4VuYlKwXsgq5ZNVqsqOQjx+TQl0CI
         J7aA==
X-Gm-Message-State: AOJu0YxHKM/u5P6UlvmCcjvhoJgS1cYbq6DISmtMIZNTknKIzG4c8VF9
	b58czxn0aAVaT9zj7x7e/SeZk63PLNaqvoxIvjiL/z9DFK7+pNjK7h00BfQXGIK3Wd3YOLKhmMd
	JZAyTVDuOSaWzwABBwLzSgY/AdO2LKAmo
X-Gm-Gg: ASbGncuxHcRidjL8kgr5ygQeVlAxoCZsQPY8H4s99fYU4A/UiL8yxuIAuvXke0vK19T
	M4fxq+QuS2U9XQnsIAMrYgd8z3xkGzTHXQLT9MP1d+7wY/pF7sw75HOW9iC/5mL3vCSfcCCJ3
X-Google-Smtp-Source: AGHT+IF2EEHGFKTYn1KC73CJALtPKogvwbcqnYt3N89uDplEyb0Crdf8Va6MydGVaM5QRbX7fVXKNv9h7x+1WTaXa+8=
X-Received: by 2002:a17:906:3190:b0:abb:6722:f98c with SMTP id
 a640c23a62f3a-abb70c5c019mr1067603466b.34.1739825096098; Mon, 17 Feb 2025
 12:44:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: James Dutton <james.dutton@gmail.com>
Date: Mon, 17 Feb 2025 20:44:19 +0000
X-Gm-Features: AWEUYZlcIM3HqJwp-yKRSySzLDYeKKErPzw0dSiDVsse2QzQZH3PhqI84AFMSr0
Message-ID: <CAAMvbhGRBhdz2RnReoGxDRM=bTws6s4qe5kh2nUqQDMRDYBh6Q@mail.gmail.com>
Subject: USB4 thunderbolt device suspend/resume problems. Unplug during suspend.
To: Linux PM mailing list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

I have a thunderbolt / usb4 10Gbps ethernet adapter.
While plugged in, it appears to handle suspend and resume OK.
The problem is the following:
1) Thunderbolt device plugged in. Device appears in "lscpi".
2) Suspend Laptop
3) Unplug the device while it is asleep.
4) Resume the Laptop
5) Laptop locks up, no stack trace, nothing output.

Further diagnosis has found the following:
I locks up in:
drivers/base/power/main.c:
static void device_resume(struct device *dev, pm_message_t state, bool async)
at the line that says:
"device_lock(dev);"
where "dev" is the dev of the 10Gbps ethernet adapter.

I don't have any other usb4 / thunderbolt devices but I am thinking
that this might affect all usb4 / thunderbolt devices that appear in
lspci.
Essentially, it looks to the OS like a PCIe card is removed during suspend.

Does anyone have any hints of where in the code to look for a fix for this?

Kind Regards

James

