Return-Path: <linux-pm+bounces-40837-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEBDD1DC6D
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 11:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 945CB30090D0
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 10:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95ACD38A2B9;
	Wed, 14 Jan 2026 10:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="uVDqPLrk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D189F38A295
	for <linux-pm@vger.kernel.org>; Wed, 14 Jan 2026 10:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768384933; cv=none; b=p6/v2umZsJp0hsPMNurkZQThWU+oM+7QY/dPjM4HhKeTJ1eKgv2QQ5nJirvzFiFdZzuGYCtl9LiTBDqQj+A6Z25cSK88uGXBIonB8jvgVUH5dln3WEmbX32VplDWF4h9cc0RWUNkf6rQ7X6gcJbRdDbvQ6JinV9xa/y9tnkF0c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768384933; c=relaxed/simple;
	bh=an3PQRdJRli5xUp+0iFhR8Tl9IEB+ilkJpCoeRs721w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rhQ3qJ9iLs/GPdSwAxrOb28+C6oKlJqFWO3wL6C5Uj21pdn99w0aURWxn6ds12l9NEAtPf6cDNFheWAFDIX+I2Gq3fcmd0C4HQT19pEp1FVLF+bMUxikneYnM2xHebZIVZdsnCEDSUQ0XZIVsnfdIQ7nFut5+s5rHAQyDZzzNxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=uVDqPLrk; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a0834769f0so59000305ad.2
        for <linux-pm@vger.kernel.org>; Wed, 14 Jan 2026 02:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1768384930; x=1768989730; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=an3PQRdJRli5xUp+0iFhR8Tl9IEB+ilkJpCoeRs721w=;
        b=uVDqPLrkDrMqsXwwzS8moU4Ao44HUstqz50/ZN1mm3qcJBKjcL86O7ZdWs3Th6JD6C
         YmrZBlKRcEGGFeeiaNd4T2wUlpLUTAQQq266823guGKaCRJNo1Sjc6QhuG8mx6iUlsi6
         B60uOmnYk7+CiNRUud8YohJBswnvrkZHzdphw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768384930; x=1768989730;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=an3PQRdJRli5xUp+0iFhR8Tl9IEB+ilkJpCoeRs721w=;
        b=WBQTtN1XVy47sYLVdw0xYQU2e1I6Jq/MAw40xHdIjb9UOa36q+YOPuYMw22PTdTGlS
         5QFU1iYu1eenHs0k5mnZDPzkML2UWWVrBER4ntlWOjgtltLiWhH845wcxusl0D6vSDEO
         lYh2orcowmvyuE6bYD9YmWFD50MEVHOUycYyaCH4mo5acKl/N+2QWgdSNygDE+PUUtso
         yYDZhDLoyIMmBA8fCHe6XgNghHK70SDGLLO1wiu+BSj2QH2yp+UQ+H4iDm6YerWrxAc2
         WG2Y8rJB0dogXLw19UWl90/vdEzmvPC8rAXueHhCN6be+CeJxX+oBzijBtkFZf2AfEfS
         kT4A==
X-Forwarded-Encrypted: i=1; AJvYcCUA8os0dRVoAQXMWQhSC4hugI5a7nAHY3khgr0dbGZ7PqvFfE/+9RlX+UhUWcTOf7xKv9KwXlPuZg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1RgrbBp9qHm16/Bo0j3UWkUyIbNVlaRr1zguXhdPmdmtsK6JS
	c9TKLAF88nLmt6VFmHyRkjouugM5kQghEeMo6/bqnve3k3gmoVk9iGNBd+LPfJyHWFTgnpEH12/
	78YSQMMs6/Bea42pZOSFkRqGJEeaZoFPOZ9VMLCcYkQ==
X-Gm-Gg: AY/fxX51KTUuBE5AZ3h5tLRz+EMBdi7I5aQ7XEygwL37UFz37FWc9e1JkPyqoW2FHUo
	C45LycmeQW0Yuq9E79RPkQjhiADQXT4tOvR73bxQtSEts/+mvEHSKVNWE0dUt3aJdx8qdNrwn93
	vhXzK25lPi1k2FUwv+H7/TEuh2SlrjlNrZ/tRS5jdquW9Vc0OzJGfFqNSAnHWDQNo/3n9Gldy+q
	n7UryisxX+YqTzWc8esyGHa9+6D2r6Oum6rx5Ka8oVLtGiH4Pe9DlTfv8oLmQmf3WNsKIZK
X-Received: by 2002:a17:902:d490:b0:2a0:e5da:febf with SMTP id
 d9443c01a7336-2a599e57f84mr19789975ad.46.1768384930034; Wed, 14 Jan 2026
 02:02:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112182258.1851769-1-visitorckw@gmail.com> <20260112182258.1851769-2-visitorckw@gmail.com>
In-Reply-To: <20260112182258.1851769-2-visitorckw@gmail.com>
From: Daniel Palmer <daniel@0x0f.com>
Date: Wed, 14 Jan 2026 19:01:58 +0900
X-Gm-Features: AZwV_QgguIt852C_mUjivXJfQcOZtzqwma4T4Ld0LagZcZXCH6S-e9IavQmDjH0
Message-ID: <CAFr9PXn9nzw=kmWqv_ZPZshhGuh0iAW5b=Csygt6WZOnmd2tig@mail.gmail.com>
Subject: Re: [PATCH 1/2] power: reset: Add QEMU virt-ctrl driver
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: geert@linux-m68k.org, sre@kernel.org, jserv@ccns.ncku.edu.tw, 
	eleanor15x@gmail.com, linux-kernel@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Kuan-Wei,

On Tue, 13 Jan 2026 at 03:27, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
>
> Add a new driver for the 'virt-ctrl' device found on QEMU virt machines
> (e.g. m68k). This device provides a simple interface for system reset
> and power off [1].
>
> This driver registers a restart handler for system reboot and sets the
> global pm_power_off callback for system shutdown. It is designed to be
> generic and can be reused by other architectures utilizing this QEMU
> device.
>
> Link: https://gitlab.com/qemu-project/qemu/-/blob/v10.2.0/hw/misc/virt_ctrl.c [1]
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>

FWIW: I have a driver for this in my "m68k with devicetree" tree. As
far as I could tell the virt_ctrl thing in QEMU might get more
features aside from power control.
So I made it a misc device instead.

Cheers,

Daniel

