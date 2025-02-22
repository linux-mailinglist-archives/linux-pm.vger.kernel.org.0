Return-Path: <linux-pm+bounces-22720-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC845A407DE
	for <lists+linux-pm@lfdr.de>; Sat, 22 Feb 2025 12:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B89617E7B7
	for <lists+linux-pm@lfdr.de>; Sat, 22 Feb 2025 11:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6AA207E0B;
	Sat, 22 Feb 2025 11:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gggUN6ho"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6ACF2066C8;
	Sat, 22 Feb 2025 11:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740223753; cv=none; b=p3D8HM/hG6Tl3ZxsIZMmYZpAaIHMVYbCT7x6GRbfUKs0R0nx4M7zsPTnogxfIH7TkC4BYgA4sXLDPK3lzU3DnHk0D0Kl4NNtZmbGxY74xtYoxmobDoPRcd2wTXo1nhgUduvsPqsRIyDWTLTys5az/b5+1ED4onRscKVTsbdbgkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740223753; c=relaxed/simple;
	bh=3HcOk7KIE2X2SrurKPz1ZC+4TT9eXp5Ic6dRS70PdAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ql6H67QIg388FgXgxCgejAyoK1xjNwxl7OQz0orxq3EzeCUq0P6QbqHLpiVIe13+D1FiRfJ9R54HlqaX3BXhKUDhx9SaDwL1E7VBa7bQjdGaEMGvfBPvUcIX7qhNMrkAA/ePUu2azpHwbGFajSrLzJtsWI2GjmcF4PMfUyyBdhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gggUN6ho; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2fcb6c42c47so4775240a91.1;
        Sat, 22 Feb 2025 03:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740223751; x=1740828551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QECQwJDGEx9XpEmKOp8AR9iu2sg3HSyCp2tf6Nxzees=;
        b=gggUN6hocVdl6Bpo7sklTOVMEtfYRPEnCtJ8R8J8VX6RdUbnVwCLk9Zm/mPKL7myTc
         iG/oPyTCwl4PvahO7+TZEgQOHk08IfEHWzOYejGlWZifjKbz2S8CD26E8uPea1l3bJIs
         oTSf5lAHp9zmeUO+3VxaM/B+jGuoUZ/cY2l9jH5KGDbTRijOD1zXgeLSlJ6fag0iBELQ
         npfCKCwZL0gu+z9+OFWyZRVnORLVuWqejzpPHFp/YCbNL9LtQ69UnnNJYbvljaIINTyP
         ScsShpqYR/+o/TpxlPw+X65VcIV6EJ+ka3vYy5UvUJbjXuIEkQTdxtGJYWiH2DDZg26L
         xDJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740223751; x=1740828551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QECQwJDGEx9XpEmKOp8AR9iu2sg3HSyCp2tf6Nxzees=;
        b=Pcx/Hdd6O92Uay5vujzDSE9Rc8WPQlZkl6NZJ8qTV4G+ZBa8VEfF3TkNEOawTCAMDu
         Fr4mNiH1MjXWWsmn31IWRBQs2cJGGfvr+S6kXtLzXvvqZj3iJaU1H+FwQR4lxsGwjkfm
         +T7QfAj5l1tz1wx+0wCLoKCUySGKPilWACjyuFvZT/GoE9ODr9g7Tsg97Z2G+EdPpBuP
         donyOHphO9bOTpHXHNCNdSStyqTsrxixHt2Dbf4lxz4qCOnsapq9RUnUBMLcjrhJzbqJ
         9wup8hRZ8OZJmDBHybE2bWZUEuWfA5bF/4fltuVZIfJdBYn3dJ7/u360gEGh7BbllnHx
         BKHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXchjxbdXFUUEoj9w29FyZ4d8JsTu6io4viwOYE3pLcEwoBAL7IdBAmmWar5dy4NmvevL5WvI5eug==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqu2a/4Z7yMhFQUap4Uuh0lCLQ9rtn2AWn0sALZnXvfe27ZBWj
	PMqX2z+9bWEN25OGnsWKU3cxg/gKo0IFtS+gKXjUl/vsIB1hQgw1
X-Gm-Gg: ASbGncu9RHovIGmBYEith9kBxZ0GrdfztXugur1WQSf2kOprwU6ehSqEwZ7lItncegy
	NZn/APKE+AH+hRyC5qhUCEwe+tl+UMBI1levUL+rp2WnuSNTcNHyZlb1obiMF5HBNaxcDCvJSFF
	FvX4EyONB39LBlAWxcciQtJUCZ0J5/Yk+Dnb3guBlo/5NEtysi9NcXlyMsf+S3kzZV1E0yCDgO4
	rqbsFYo1eo4pCbajW0aPIxx/fvfuPDXLqLl1zKlo6/EBrnbPtfJ6JbkstN0Pn1SpMKChr9awoIz
	/xa3iX0OQ6LBnCnomGlOkBl7
X-Google-Smtp-Source: AGHT+IHTV4Fc835gBSr+KiZgTLVuCJR5c6HcR46bp0C4GHKJwo3ghQR31BLbPSzmwrvQLxMk4KDyfA==
X-Received: by 2002:a05:6a00:2ea9:b0:730:8d25:4c24 with SMTP id d2e1a72fcca58-73426cb1d46mr10451331b3a.10.1740223750960;
        Sat, 22 Feb 2025 03:29:10 -0800 (PST)
Received: from nuvole.. ([144.202.86.13])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-addee79a984sm12381005a12.32.2025.02.22.03.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 03:29:10 -0800 (PST)
From: Pengyu Luo <mitltlatltl@gmail.com>
To: sebastian.reichel@collabora.com
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	mitltlatltl@gmail.com
Subject: Re: [PATCH v3 5/6] power: supply: add Huawei Matebook E Go psy driver
Date: Sat, 22 Feb 2025 19:27:24 +0800
Message-ID: <20250222112724.336033-1-mitltlatltl@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <m2dy2vhvw7rhexvzkkloelgkcdcq6ci2ot54mdffpvosvagf64@usdxy2cnjeua>
References: <m2dy2vhvw7rhexvzkkloelgkcdcq6ci2ot54mdffpvosvagf64@usdxy2cnjeua>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, Feb 22, 2025 at 6:22 AM Sebastian Reichel <sebastian.reichel@collabora.com> wrote:
> On Fri, Feb 21, 2025 at 02:01:04PM +0800, Pengyu Luo wrote:
> > On Fri, Feb 21, 2025 at 9:33 AM Sebastian Reichel <sebastian.reichel@collabora.com> wrote:
> > > On Thu, Feb 20, 2025 at 02:43:20PM +0800, Pengyu Luo wrote:
> > > > On Thu, Feb 20, 2025 at 8:24 AM Sebastian Reichel <sebastian.reichel@collabora.com> wrote:
> > > > > On Tue, Jan 14, 2025 at 01:51:27AM +0800, Pengyu Luo wrote:
> > > > > > On the Huawei Matebook E Go tablet the EC provides access to the adapter
> > > > > > and battery status. Add the driver to read power supply status on the
> > > > > > tablet.
> > > > > >
> > > > > > Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
> > > > > > ---
> > > > > >  .../ABI/testing/sysfs-class-power-gaokun      |  47 ++
> > > > > >  drivers/power/supply/Kconfig                  |  10 +
> > > > > >  drivers/power/supply/Makefile                 |   1 +
> > > > > >  drivers/power/supply/huawei-gaokun-battery.c  | 548 ++++++++++++++++++
> > > > > >  4 files changed, 606 insertions(+)
> > > > > >  create mode 100644 Documentation/ABI/testing/sysfs-class-power-gaokun
> > > > > >  create mode 100644 drivers/power/supply/huawei-gaokun-battery.c
> > > > > >
> > > > > > diff --git a/Documentation/ABI/testing/sysfs-class-power-gaokun b/Documentation/ABI/testing/sysfs-class-power-gaokun
> > > > > > new file mode 100644
> > > > > > index 000000000..b1eb9e8d7
> > > > > > --- /dev/null
> > > > > > +++ b/Documentation/ABI/testing/sysfs-class-power-gaokun
> > > > > > @@ -0,0 +1,47 @@
> > > > > > +What:                /sys/class/power_supply/gaokun-ec-battery/smart_charge
> > > > > > +Date:                January 2025
> > > > > > +KernelVersion:       6.12
> > > > > > +Contact:     Pengyu Luo <mitltlatltl@gmail.com>
> > > > > > +Description:
> > > > > > +             This entry allows configuration of smart charging behavior with
> > > > > > +             four parameters. The format is: <mode> <delay> <start> <stop>.
> > > > > > +
> > > > > > +             - mode: Defines the charging mode (1 or 4). Mode 4 enables delay,
> > > > > > +                     while mode 1 does not.
> > > > > > +             - delay: Specifies the delay in hours (non-negative). This is
> > > > > > +                     only used when 'mode' is set to 4.
> > > > > > +             - start: The battery percentage at which charging starts (0-100).
> > > > > > +             - stop: The battery percentage at which charging stops (1-100).
> > > > > > +
> > > > > > +              When the laptop is connected to a power adapter, it starts
> > > > > > +              charging if the battery level is below the 'start' value. It
> > > > > > +              continues charging until the battery reaches the 'stop' level.
> > > > > > +              If the battery is already above the 'stop' level, charging is
> > > > > > +              paused.
> > > > > > +
> > > > > > +              When the power adapter is always connected, charging will
> > > > > > +              begin if the battery level falls below 'start', and charging
> > > > > > +              will stop once the battery reaches 'stop'.
> > > > > > +
> > > > > > +              If mode is set to 4, the above charging mode will only occur
> > > > > > +              after the specified delay in hours. If mode is 1, there is
> > > > > > +              no delay.
> > > > > > +
> > > > > > +             Access: Read, Write
> > > > > > +
> > > > > > +             Valid values:
> > > > > > +                     - mode: integer value (1 or 4)
> > > > > > +                     - delay: integer value, delay in hours (non-negative)
> > > > > > +                     - start: integer value, battery percentage (0-100)
> > > > > > +                     - stop: integer value, battery percentage (1-100)
> > > > >
> > > > > There are common properties for start and stop charging percentage,
> > > > > which should be used:
> > > > >
> > > > > * POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD
> > > > > * POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD
> > > > >
> > > >
> > > > Agree, but at least, we should pass delay, start, end. EC only
> > > > providedone interface to set mode and delay, that requires 4
> > > > arguments, we can handle it with 3 arguments, as you suggested
> > > > below. but if we treat start and end separated, then if we want
> > > > to set smart charge, we set start, set end, set delay(read start
> > > > read end, then set them again). It is a bit redundant.
> > >
> > > Yes, if these are separate properties you won't get atomic updates.
> > > But is that really a problem? Using the standard properties means
> > > that you get UI support in the future. I know at least the GNOME
> > > people are working on this.
> > >
> >
> > On my another x86_64 device with end threshold supported, KDE Plasma
> > supports showing this as
> >
> > > Battery is configured to charge up to aproximately <value>%
> >
> > it doesn't support setting things. So, can I keep passing delay, start,
> > end when setting, but also setting start and end as battery properties?
>
> No? Why should we create a custom sysfs ABI (which also breaks the
> one value per file rule), if we already have a standard ABI?
>

I got it, I will follow it. Since V4, I had dropped this driver to
focus on upstreaming the base EC driver, once the base driver is
upstreamed, I will send the new version of battery driver.

Best wishes,
Pengyu

