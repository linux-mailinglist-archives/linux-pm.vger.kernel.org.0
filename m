Return-Path: <linux-pm+bounces-40928-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 42834D24C0E
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 14:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E364311F8BD
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 13:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B288395268;
	Thu, 15 Jan 2026 13:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="g2D/5Kmz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FB73A0B16
	for <linux-pm@vger.kernel.org>; Thu, 15 Jan 2026 13:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768483787; cv=none; b=Rzbq4y1VaQb2dkjp24wWIUU2EiJ7xeR4NZ+trFgxtkmaHLiXTBprFMESa6cPs3FZOcopxw/oevz5sAKb+NUy75v5LIxS8fn5of9D3UrS1uSk8PWfpPijb4GBYZI7ntkzfCkTDTErvQqCPYcay0QBBfuyV+LOcjOV0DkxRzwyXpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768483787; c=relaxed/simple;
	bh=irwPV2MgNHEQZ3kOMZ6puI5824+S4bl8VRfHr1Gcwhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lnzdDso06qnDTw+YShYRqgkkjazo1uDdA9x+go0miZi30zL0VKgWWXt6QHJ7ca9sNTxQkoIa9kwfAILWH/swecuqkPmYoQLLMmjVwkCuiZet8v8dS9WRWtU87UbNEOzhkaLIZUigl97pL+QVmUq4ADZ2bhcfPElYVHKaXilMYds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=g2D/5Kmz; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-65089cebdb4so1424892a12.0
        for <linux-pm@vger.kernel.org>; Thu, 15 Jan 2026 05:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1768483783; x=1769088583; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=irwPV2MgNHEQZ3kOMZ6puI5824+S4bl8VRfHr1Gcwhw=;
        b=g2D/5KmzlK8wrzPwCVZAdvZuiTlgW1M9Mw7goDtyYi9W/q8wYu9kzk767C2dvEhznV
         5C1VtYCPNIlPyjjQoHt2r//GT1gTttpPLQ3cA3eoSaJ3DIUMXvACYZMZr80bJijW2Hxm
         mxhq/LrqHt9DZgm7bZJNAY9MLKXtJ8OcXN8hM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768483783; x=1769088583;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=irwPV2MgNHEQZ3kOMZ6puI5824+S4bl8VRfHr1Gcwhw=;
        b=gR0XwoyOxJDFKxZXYc+9R2meWFPkjkeCnDh8Nff8tycUZ1IHjCyE/Ku9U+jSY9icin
         JM5TLwTUKL20w2k0Q8VBJbfsvwQWRaH+Iye1uq8nBWS3sYZ6lnyNdfEm2qtcDJaYVele
         44XZ/InigOvdSzP9WJ/y3cnouO+Yy7RvlogmedxFV70NWA83O9qk8kLyjLYt0W0NzIim
         c60bV6VPRgzy/9ggOOkXbt7osZSznzAZTwQ9qi4KC35PepWfDbxTPjVffVLsODdBSO8e
         heNsLaU5c25nQ9aMCFyKf/bSMICszOEIj9g2Iq+9JL8Kl/R4D2YRc2n+kQJu37Xpb4Gv
         dZEA==
X-Forwarded-Encrypted: i=1; AJvYcCVNFn3xVxxb/4BChq+DvSxnnkxvgTaa6nsitm1QARgnO3Rf84jgixvlsoxqp364BcExAi+Maek7aA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzFRSnSzGDIZQiWc8Wd6VAgkSzLh9EgUPQpcoNEDfsJqSTKyyHO
	GtfUMGQMnOWsbEjlAsGtB86j7Ytd1PGVcojMcVEMmbKt0oogn/DzFc/7DisYDyTMIkZlrEaaPy8
	6LYB+f0gd39yfae6PKA0X5iBuBO/T6OmfQJjWVub6Wg==
X-Gm-Gg: AY/fxX6A75Mx+04/yymjRkYyYzriWu3/BCWCvjFEGp3EJPHeeDOkwJd5632Yu5mSBVr
	GOzGdEtcUhyfI+wGHYNCYiTguKPGfZidhPJPHDCJH85eOCEEunt18sJGLHuqwR+st1VGrjx7zQd
	6Vcn7sjv17Rqd+hnpthcaZriWxNQHn4YooVc4ETQ/rpsbTXEe6992CX01FyY4BK3G3nYLSzwn1t
	sIGveYX0bi6uPX24+mXB1P4SNBQiT5IBzhkC/yFVNRn4p2L/stElMXwaV32X6wHCKrUAtE3
X-Received: by 2002:a17:907:1c26:b0:b83:e7e:372b with SMTP id
 a640c23a62f3a-b8761278c8bmr521627466b.44.1768483782468; Thu, 15 Jan 2026
 05:29:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112182258.1851769-1-visitorckw@gmail.com>
 <20260112182258.1851769-2-visitorckw@gmail.com> <CAFr9PXn9nzw=kmWqv_ZPZshhGuh0iAW5b=Csygt6WZOnmd2tig@mail.gmail.com>
 <aWiGCY4aEF5dZOqY@google.com>
In-Reply-To: <aWiGCY4aEF5dZOqY@google.com>
From: Daniel Palmer <daniel@0x0f.com>
Date: Thu, 15 Jan 2026 22:29:29 +0900
X-Gm-Features: AZwV_Qg63fOmGyWRiTETksr3IGtchRQvoevgze3Vmdxev9TfyY3aF-ZkirlrK-w
Message-ID: <CAFr9PXn66L8FxEydCrRDR=_pVtspsFO9hOvZuWNtEB5z=9Ds+Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] power: reset: Add QEMU virt-ctrl driver
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: geert@linux-m68k.org, sre@kernel.org, jserv@ccns.ncku.edu.tw, 
	eleanor15x@gmail.com, linux-kernel@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Kuan-Wei,

On Thu, 15 Jan 2026 at 15:15, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:

> > FWIW: I have a driver for this in my "m68k with devicetree" tree. As
> > far as I could tell the virt_ctrl thing in QEMU might get more
> > features aside from power control.
> > So I made it a misc device instead.
>
> Thanks for the note.
> Just out of curious, are there currently specific plans to add
> non-power features to virt_ctrl?

The docs here suggest that power control is the only currently
implemented feature but doesn't have to be the only feature:
https://github.com/qemu/qemu/blob/master/docs/specs/virt-ctlr.rst

> If new features are added, shouldn't they be exposed via separate
> drivers in their respective subsystems, rather than consolidating
> everything into a misc driver?

I guess if it did get new features maybe it'd be a multifunction
device? Since nothing except power control has ever actually been
implemented, maybe the way you have it right now makes the most sense.

Thanks,

Daniel

