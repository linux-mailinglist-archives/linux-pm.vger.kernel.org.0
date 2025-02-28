Return-Path: <linux-pm+bounces-23153-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A83A492C1
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 09:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83CB716CEF0
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 08:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD402CCC0;
	Fri, 28 Feb 2025 08:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ev7JvfhF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEF11C1F1F;
	Fri, 28 Feb 2025 08:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740729759; cv=none; b=jUF7hxaPJnVzjih6rYL3MzgN2GtjRSaGMV4EIzRl2qm0qmQcXYxeXxirkL9KR2YjWjXOUZrWxezY900RcMNiTnzFjm5bCh3xAST+MITzSojTXza1HNqbNxeqiPvQfxvzsK9Ab3/r1SemV4NmK0J8YN/C1Yq8nMSMBaMr0QjeKpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740729759; c=relaxed/simple;
	bh=CkcoKedkFAcyI5CUz2MK8r40A2kCmKCVvs1UInZmZgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W4NwsucDlkaooZX1HipBu3WM6Ix4pi06tgMJm4u6fzEYK7pj7Wb41A7TCKgJhmx3nVYYtM4oALYUqLS0idOtSCl5BFpghmNDXwUv3xjak2MJi30yy0FpzsA7GWnTI04GX0ryQUMasnHt/081zDsKO0+prJLUDoCTxVvIo5TevCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ev7JvfhF; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e4ad1d67bdso2609065a12.2;
        Fri, 28 Feb 2025 00:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740729755; x=1741334555; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RCYaADEDg2vn2H14xgH4DMVdszf0N1lJl2Wld6tc5C8=;
        b=Ev7JvfhFMv27z19orFk0vh5i4KQZEkwN290AqKVkOpLJ8p5wOciiASwt9RiYVIpMS9
         IyS6Ey8x/X/qjeB97ijOXFtkoWRB9ywUqbRYFN7AkwgerYNdc63zuHGWU6UxFHqoqye7
         eJAnCgLHW1VKWteki3V21d2o1QuzZTMDM5rf2xb0QdRhqsuy022QkdT1RgcEFqZY7RGl
         iW4NQYcxkI8NBrj5u/0xV0/7eXRppbkupoTHaFWWEMNeEylqcWAHQxFqXLIqCfzkEDMS
         Piat6H9z3fW6DNCA7rDPKO0nzRWE2pkS73rcK9NwIC7pJvDhDJOJRyZ+JZT9N6naZdfs
         s0Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740729755; x=1741334555;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RCYaADEDg2vn2H14xgH4DMVdszf0N1lJl2Wld6tc5C8=;
        b=PPICiB9V5N1uYr6pTk3bhk3pfDnA/dFHJ7sTqbsMD5pT/iFZwEu3z+3RN9/DL3z/ef
         N7yASq+JTogqLi5CRhMPc9dszNIxZjD7+xOhqLeY+pNifzfY2q9/PjBAlOa0DUqDtLRz
         pqanIIsBmFxTAHw7WEFTVwTiLCMxnHSOx8Y8BxS8qGHxSyiubiu83dKka/x0bfNTN9jy
         Ekf2U3Rl/b4uFsmMh97FNyI+4PQ8vigmvfgbHB5wZqEHV380jAZWmd1babGLRmzxmss3
         1gF8IwWpcjIC+2Mt7eqIa+qMqwRz2Cc8w58FJ6NvfEc4YLZjKdRp5WIkIVekTJxp0KoS
         cklg==
X-Forwarded-Encrypted: i=1; AJvYcCWcPlq8ONlsiEB35NM/UunjJu74ZdDyPOBRMbBiy0TY0zcLB5pLFUbdYCHHGJRcSvzbDhvS/Z9H0g==@vger.kernel.org, AJvYcCXCuXR5y3MxQiQCNVCh+KiGOtY6tVNIFtDE9URfv3xFUwiYwf1tLeBZIYet5QkOGEGpRV6hlMd4Sg93k7s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/uii3cZCEctpwWQdhl/MbpElVQv3tzuDnhEFMwJ0Rxd3i3f1M
	ffWH9el4JmhLmifFS8MGaUH/d3ap47E3IIbJEM64j1/gh7OBsrFv
X-Gm-Gg: ASbGncuAz+boe3Qhm/aISHu6a1Ry5q/WHCC1XvytVSy2esM8WGaRDR3TYPkox8YHLDd
	wMrOQQE+ITjyRbf8VydPNvl7wswj0kekQosxmKEL538T+fA5cdwIHJ7aAsMlo3LZq5vZik81P57
	HOrakk/fbX50OrzE7pb+M+udURSnuGvVRHWSBraPSMqCpDKkuYjNMjBNBIg/M6KIEMd2sZ552US
	b+QWC6s0ZJF+LOE/l4F8BeELC3JsB7Hg1c7sMU4oozrNkW6kcFTyEeNMk5HoM+cWNJIFtL0ZOyg
	kh/uSwweqK0VTLmg+RNjpPcgHVXwI2TB0gRr
X-Google-Smtp-Source: AGHT+IHdfiBh4QGDalbE/Ot28d4y3s0PoEiOnNxzHL+okZTH5HnyPc3irtzWbep9KdGlwodCJuIQNg==
X-Received: by 2002:a17:907:3f07:b0:ab2:c1da:b725 with SMTP id a640c23a62f3a-abf261ce0d4mr269076266b.30.1740729755131;
        Fri, 28 Feb 2025 00:02:35 -0800 (PST)
Received: from tp440p.steeds.sam ([69.63.64.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c101312sm251392766b.78.2025.02.28.00.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 00:02:34 -0800 (PST)
Date: Fri, 28 Feb 2025 10:02:29 +0200
From: Sicelo <absicsz@gmail.com>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: pali@kernel.org, Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org, maemo-leste@lists.dyne.org,
	phone-devel@vger.kernel.org,
	Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
	akemnade@kernel.org
Subject: Re: [PATCH] power: supply: bq27xxx: do not report bogus zero values
Message-ID: <Z8FtlaYkbVG1xrsc@tp440p.steeds.sam>
References: <20250207220605.106768-1-absicsz@gmail.com>
 <CB5B8FE7-D619-4D30-BD2D-58B6CEF83D46@goldelico.com>
 <511351B0-A78B-4517-B183-D39A4F807CB6@goldelico.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <511351B0-A78B-4517-B183-D39A4F807CB6@goldelico.com>

Hi

On Thu, Feb 27, 2025 at 06:48:49PM +0100, H. Nikolaus Schaller wrote:
> > 
> > I finally found time to test this patch on the GTA04 which uses an OpenMoko HF08
> > battery which comes with a built-in bq27000.
> > 
> > The result is that I can't read the /sys/class/power_supply/bq27000-battery/charge_now
> > at all and always get EINVAL. Independently of the charge level reported without
> > your patch.
> > 
> > If I remove this patch again, the values are reasonable as in all the years before.
> > 
> > What I don't know is how and to which values the EEPROM of the bq27000 has been
> > factory programmed so that the HF08 battery maybehave differently from yours.
> > 
> > Finally, I am not aware of reports from GTA04 users that the value stored in the NAC
> > register is being reset as you describe and capacity, energy and charge to be falsely
> > reported as 0.
> > 
> > So please restrict this patch to the N900.

In the case of the HF08, the value will not get reset since the chip is
inside the battery as describe. However, the patch should be fine for
HF08 and N900, etc., since the EINVAL should only be emitted when it has
been reset. Unfortunately, I made the mistake below...

> 
> You write:
> 
>   Therefore, discard readings for these properties if their value is 0 while EDVF is unset.
> 
> but the 'val' is not checked at all. Only the error return value
> 'ret' of bq27xxx_simple_value() which is 0 if reading was ok.
> 
> So shouldn't that be:
> 
> + if (!val->intval && di->opts & BQ27XXX_O_ZERO &&
> +   !(di->cache.flags & BQ27000_FLAG_EDVF))
> + return -EINVAL;
> 
> This could explain why I always get an -EINVAL here since BQ27000_FLAG_EDVF is likely not set.

You are absolutely correct, Thank you. It seems I spent more time
testing the non-working condition than the working condition. Apologies.

Will you submit the fix, or I should?

Regards
Sicelo A. Mhlongo

