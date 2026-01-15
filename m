Return-Path: <linux-pm+bounces-40902-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EC0D22837
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 07:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C437301721A
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 06:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D865322CBC0;
	Thu, 15 Jan 2026 06:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKwniacV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556232222C5
	for <linux-pm@vger.kernel.org>; Thu, 15 Jan 2026 06:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768457745; cv=none; b=t5pIwgPuxVoprSdwPrUiwskdL5tVRFbCj8pHD5nQxsucIrP4ui2DhxOd44hQq74J1q6LJrMyDzXQyUYCxpCoevHqBcDDSDN93XvaJDCYXDt6ZIG4dBD/nuVsL8bdEn8dUkuK36zIAv0RqUR0D++0BMYWAP8vhy2OLhjREeSQn0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768457745; c=relaxed/simple;
	bh=xuYDqmlOXdV6M+f9LMPEInQe4YGVV3/NVgJwk7BAxnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u9U06sU6WPD7FRfAsjd90sHcBpmslWysebrxuJNrydgq7C35HPMpIB3I0lgBIsKYXWBdO9R4NxfOSSdoMEb232ILzT10KCaJFSiQ7jLG15rU0Owlw2dfk8TSE01VSvsxYuUPet/wZRmA3Qq2PWlItYuOtaf4Ba/mHMYwHJiCPn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DKwniacV; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-bc29d64b39dso190539a12.3
        for <linux-pm@vger.kernel.org>; Wed, 14 Jan 2026 22:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768457742; x=1769062542; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LjxQx55L3HFhzEsrPSzupy5cs4/k1InHSQSDwivVXVQ=;
        b=DKwniacVWxzbvE77W7Jw+zibkKCLP8WFkWQqQtiIrSZna8Gv2ioa1vYVpH/7fxr0qE
         PSSR71km0nRz8YlkRSv6hhD9SZAaqvYQKTVD3y/tCFvwCnY1g/++L+LRi9o7aY774ytw
         jufy+1OvW/bqKsZ3YYjTFrxCk2OgsAZy1cokguq6DOeC1yfcYlkVZ+ZEpyk0Z+u6jnHk
         E+9Uydlaj19QRu9mbpu0x8bx5hvlB6euvky2/WvG0SrKEUTKstDARadc3r1p8byrfx6r
         RvC/ZQp7XMfiskYGVhEpbLqcrgC4uEb/sRk/+7syHw26phHyhP2NO5V7IRdFIVucSmmO
         Nd6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768457742; x=1769062542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LjxQx55L3HFhzEsrPSzupy5cs4/k1InHSQSDwivVXVQ=;
        b=PxKnOMAJ7vXRMWOudhAz0480yjhVFOGEAq1cqmd8qz73tX5ofQYqP3lEEhSTK6q7SD
         tcU4Z9dwkVXKm1lonK8zq9GnvYi63mYV6ZBvQYhfWBfqZi2qiOWH3osOZJYiJrq27xhz
         VlmYemcS/X6/JyxgAvCIMQexa75O5mpVHQF/15YE8Brbrve6mx1Q3WDRH5fwzu+WPG+y
         3Rx37215/OBsDCTootGpcggWAo7rYaJJdKVkqSPjdP1/UY4ZXarrjfoZO0W3768VmVv9
         BmgmQ60wCVmpyu8Kr3vfVrT7z3NbYTz4qNmv9ShCkuyqELCzHEFnn2qg7oILWa6QD49e
         opxA==
X-Forwarded-Encrypted: i=1; AJvYcCXqSrGuWutz9/UYmhOBkUZpuKBTH3rEAXMHF1o/cGBRTbWb6PiCrTle1eV7jtF6g+Myeb9AsQOyBg==@vger.kernel.org
X-Gm-Message-State: AOJu0YySVJMK46NLfkHfyoN/2XZIiYKuQyjFvFBn73HV93BeZ4gM5A5l
	4AlpEEH6atvtCliPzX9boEqT5oItAKSe4NltBaPPCMzHdIZbXHiEENDE
X-Gm-Gg: AY/fxX66OOAtxF2Q/JwMOQceJNk2wgXvmGceYYTYA2ht7UiLwoz1YmLd3QCVHLG8bb9
	wj+OKc92rtZXQi5MRSsY893ajNA0iDylMmw+EqxX8p7rcp4QC3Xw82jKeMi/zDPL6Ayxvig9QBQ
	idH9Hoio7poycSgwJBsR1Wk8Z/JBsQRAhi7Jz/HaiOeFcfsLZS+/i99J4pg4flzrM4cmsRV1RxV
	qdRgs1TdPePGs0Zs47BCrMiMA33X3OTxOBzzEa0bDy3NIvDyPrLwCtqCIalqZKlehLmBAVQ3wPd
	YfX8Je/55di5xUhW3K3AxDJAlSMwGz2awW4aIbOb1I6veTs3dtHkwPC5p0Gx2/QNBwgcplw1pm0
	pLjV8vMdRAzvfDYQDZbRI405C/agY7UGSYygQtRhkBqarUFyuX9/cQ3eoVx9ja0Gf0b1sIkUu1s
	GtJFhxe7WRbachyzhxrl5WoBTx
X-Received: by 2002:a17:90b:350b:b0:34a:8c77:d37b with SMTP id 98e67ed59e1d1-351090da11amr6037803a91.16.1768457741930;
        Wed, 14 Jan 2026 22:15:41 -0800 (PST)
Received: from google.com ([2402:7500:568:57ed:f859:ae8b:d60b:53d6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-352677ba62csm1059931a91.2.2026.01.14.22.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 22:15:41 -0800 (PST)
Date: Thu, 15 Jan 2026 14:15:37 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Daniel Palmer <daniel@0x0f.com>
Cc: geert@linux-m68k.org, sre@kernel.org, jserv@ccns.ncku.edu.tw,
	eleanor15x@gmail.com, linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/2] power: reset: Add QEMU virt-ctrl driver
Message-ID: <aWiGCY4aEF5dZOqY@google.com>
References: <20260112182258.1851769-1-visitorckw@gmail.com>
 <20260112182258.1851769-2-visitorckw@gmail.com>
 <CAFr9PXn9nzw=kmWqv_ZPZshhGuh0iAW5b=Csygt6WZOnmd2tig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFr9PXn9nzw=kmWqv_ZPZshhGuh0iAW5b=Csygt6WZOnmd2tig@mail.gmail.com>

Hi Daniel,

On Wed, Jan 14, 2026 at 07:01:58PM +0900, Daniel Palmer wrote:
> Hi Kuan-Wei,
> 
> On Tue, 13 Jan 2026 at 03:27, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> >
> > Add a new driver for the 'virt-ctrl' device found on QEMU virt machines
> > (e.g. m68k). This device provides a simple interface for system reset
> > and power off [1].
> >
> > This driver registers a restart handler for system reboot and sets the
> > global pm_power_off callback for system shutdown. It is designed to be
> > generic and can be reused by other architectures utilizing this QEMU
> > device.
> >
> > Link: https://gitlab.com/qemu-project/qemu/-/blob/v10.2.0/hw/misc/virt_ctrl.c [1]
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> 
> FWIW: I have a driver for this in my "m68k with devicetree" tree. As
> far as I could tell the virt_ctrl thing in QEMU might get more
> features aside from power control.
> So I made it a misc device instead.

Thanks for the note.
Just out of curious, are there currently specific plans to add
non-power features to virt_ctrl?

If new features are added, shouldn't they be exposed via separate
drivers in their respective subsystems, rather than consolidating
everything into a misc driver?

Regards,
Kuan-Wei



