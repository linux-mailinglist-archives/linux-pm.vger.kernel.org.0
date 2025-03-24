Return-Path: <linux-pm+bounces-24460-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D5AA6DEF1
	for <lists+linux-pm@lfdr.de>; Mon, 24 Mar 2025 16:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66D441888942
	for <lists+linux-pm@lfdr.de>; Mon, 24 Mar 2025 15:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376A625D530;
	Mon, 24 Mar 2025 15:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwB/AMH/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E4A25E81C;
	Mon, 24 Mar 2025 15:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742830957; cv=none; b=iTkaGS7s6GOgkBOCzyzYgMN2FvzP9yFV8BsBLzvXwyorqw/31vPk+jd01cHw9OerykKzoeMXe4QWD0EXYAuglVVINNMdsSHplGkYuYHCtwf+UH+18U+Yl2oitFZTls843jjO2V/On4zKwNahfYanzxtyckpUcsr0N955OiNr/34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742830957; c=relaxed/simple;
	bh=8vu4aSJUZt6eERbDA6xsJCnqSWgLVmsdbc8VVNXz5Zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h7q1IA+49MJ/BowpralUqCGy1tq2d9+DoZyfbFDY/CjNdEGbV5nIw2hCrflyB4W2kgxNclqN25yDyLVNFtUGsRb+KWQkEYEeNbCv4QdhhyhtCLSLdeyvblclmC6p/7VJkYknkS4v3PKywH6D4e3rjfT/ZVqVZCq8dvQOSw4sZCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KwB/AMH/; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4394a823036so46641855e9.0;
        Mon, 24 Mar 2025 08:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742830954; x=1743435754; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wikrh/SEDPAaexfAQV5frYQMm7RehPiF9viPOrQzuqM=;
        b=KwB/AMH/OlDlIphMX7/0YZ0z51vA3nDVKMURxos1Mv76aLqXkMy2bxCz5sJpjGa2rK
         abg4sD3weiMHvxIDVxVq35zLZS5V42DFx7N8ja7G8lmeXQv0zYr7jO7f8mdY3DZ9xwYh
         5g4WEginNi9MCoZNyqeQYYht2vBcXNmfhIqG5vAbd54tGqHqKmCL5GmklVccDqpBStio
         jk57Vpa1LhEHCmh67RtBYODrzsKwAvqD8Ym34Jwx/PWrInWLgSzbN7s3CpKQ/vNU5aky
         VJpT94+dRv/mfiI1RACDbj95IH9govWDr8Ctx78hs/nXreJgq0r+l1jLUXNIUJh1oVLz
         Cpcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742830954; x=1743435754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wikrh/SEDPAaexfAQV5frYQMm7RehPiF9viPOrQzuqM=;
        b=j7kMpyeEAYSU/nTxC2V9TLJR6Llg2HfPf7PsqrbIotwQ6YWg8fvbsKqsIoBDHMEKsm
         +UdbElltWohEI9V8DF2gYL/yIUcY2R8ZdBXTvZaTZJrL3DOK00tnn1M6YqGFLEB5gnQH
         iryI80fD0NR1ZwEGy+gE7evRMwBBDz7zMaz0RHebzo+spZBnrBiuTcjLp91m4uRYHSI8
         XEAo4RHbupt58ZX/vIMxhUi69B8ia0POz35uiFabmT0Vuyd3mPY+AInkEhU+67wpn/LJ
         qVPfZfkXezV7mfd9UMxzfsXRcuvMvidVqMhEEojoK7YLhsOQc40AoKpCgBh9vr2PF2u+
         MY3g==
X-Forwarded-Encrypted: i=1; AJvYcCVF87MUrSgZVu6quIAK2VlP7LFB7kyknaXAd6xjBwLXIFBkzX8ear4yOvStB5wL/7p/7Jq1ZdldzJsP+0k=@vger.kernel.org, AJvYcCVwSHWfVdr7cx6Mm40H2GLGFZpZE+ixfmKrcI1EXTkYHqczsglsTYIMV1q2EINCQseA149/4gGIVg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9Qo9KKmKQFqLQq1hOieCNKxA38Hwpej0zvBKGRaAc2Qh+Qdm2
	Y9UqaW/jEZJP+Y0Y12xoSTwQuHUZLcYvTBRsx6sC7ei5dk8FGpyN
X-Gm-Gg: ASbGncsLPt+2JaWnFt+Y6FcaGuC/yjvOHmG3zeJxsP8fJhs2j52zM4P+mhghMmYQgqN
	gDUAdRqrl/u/jiBEDLroE7jlZpQCV7prH+OBQ9geSsYMiJVUXsndwRaq35RtgTkBvarD7L9GWfH
	BVRsTPHGF6eF/Rmv/ovU6SiDQDwzYSvHnLwUEyllLyKwgozf+Jcfv+9Is7HK9hJ59wGHzX94CjS
	aeigvaLPfYdB8Q9P6ePIlk9mowyC/LK5qIMr5cF9b1e4Zn+HQBSeF+khLoOzFKbwjnkxHrPlMPt
	2zLH7ya0F6MdpKzHJtJB2cNkqOEgofE/o+WU/6hE6SZTOUo=
X-Google-Smtp-Source: AGHT+IFAnb9yuPviCSmn18DiuJMeNOU1h6t16xumhUoIaV2yN684DmMjM/KzVk2qA/W0JTjM+mkAgg==
X-Received: by 2002:a05:600c:cce:b0:43c:eec7:eab7 with SMTP id 5b1f17b1804b1-43d509ed65amr135023955e9.11.1742830953314;
        Mon, 24 Mar 2025 08:42:33 -0700 (PDT)
Received: from tp440p.steeds.sam ([41.84.242.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9b4ce9sm11422807f8f.53.2025.03.24.08.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 08:42:32 -0700 (PDT)
Date: Mon, 24 Mar 2025 17:42:27 +0200
From: Sicelo <absicsz@gmail.com>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
	pali@kernel.org, phone-devel@vger.kernel.org,
	Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
	akemnade@kernel.org
Subject: Re: [PATCH v2] power: supply: bq27xxx: do not report incorrect zero
 values
Message-ID: <Z-F9Y16PqwK6GOXY@tp440p.steeds.sam>
References: <20250322161718.253093-1-absicsz@gmail.com>
 <A77FAC9F-3CA2-4E53-9A36-8ADB5E16D17C@goldelico.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A77FAC9F-3CA2-4E53-9A36-8ADB5E16D17C@goldelico.com>

Hi

> > 
> > +static bool bq27xxx_value_is_valid(struct bq27xxx_device_info *di, int value)
> > +{
> > + /*
> > + * On bq27xxx_0_zero, consider zero values invalid if EDVF is not set
> > + */
> > + return value || !(di->opts & BQ27XXX_O_ZERO) ||
> > +       (di->cache.flags & BQ27000_FLAG_EDVF);
> 
> Hm. This still can return -EINVAL for a valid and successful readout of value == 0 which
> could happen for a fully drained HF08 in the GTA04 with bq27000.
> 
> Here is an excerpt from running a battery until depletion:
> 
> root@letux:~# echo off >/sys/class/power_supply/twl4030_usb/mode
> root@letux:~# while true; do echo $(date) $(cat /sys/class/power_supply/bq27000-battery/capacity)%; sleep 1; done
> 
> Mon Mar 24 14:37:11 UTC 2025 1%
> Mon Mar 24 14:37:12 UTC 2025 1%
> Mon Mar 24 14:37:13 UTC 2025 1%
> ...
> 
> Mon Mar 24 14:38:24 UTC 2025 1%
> Mon Mar 24 14:38:25 UTC 2025 1%
> Mon Mar 24 14:38:26 UTC 2025 1%
> Mon Mar 24 14:38:27 UTC 2025 1%
> cat: /sys/class/power_supply/bq27000-battery/capacity: Invalid argument
> Mon Mar 24 14:38:28 UTC 2025 %
> cat: /sys/class/power_supply/bq27000-battery/capacity: Invalid argument
> Mon Mar 24 14:38:29 UTC 2025 %
> cat: /sys/class/power_supply/bq27000-battery/capacity: Invalid argument
> Mon Mar 24 14:38:30 UTC 2025 %
> cat: /sys/class/power_supply/bq27000-battery/capacity: Invalid argument
> Mon Mar 24 14:38:32 UTC 2025 %
> ...
> cat: /sys/class/power_supply/bq27000-battery/capacity: Invalid argument
> Mon Mar 24 14:53:39 UTC 2025 %
> cat: /sys/class/power_supply/bq27000-battery/capacity: Invalid argument
> Mon Mar 24 14:53:40 UTC 2025 %
> cat: /sys/class/power_supply/bq27000-battery/capacity: Invalid argument
> Mon Mar 24 14:53:41 UTC 2025 %
> cat: /sys/class/power_supply/bq27000-battery/capacity: Invalid argument
> Mon Mar 24 14:53:42 UTC 2025 %
> Mon Mar 24 14:53:43 UTC 2025 0%
> Mon Mar 24 14:53:44 UTC 2025 0%
> Mon Mar 24 14:53:45 UTC 2025 0%
> Mon Mar 24 14:53:46 UTC 2025 0%
> Mon Mar 24 14:53:47 UTC 2025 0%
> Mon Mar 24 14:53:48 UTC 2025 0%
> Mon Mar 24 14:53:49 UTC 2025 0%
> Mon Mar 24 14:53:50 UTC 2025 0%
> Mon Mar 24 14:53:51 UTC 2025 0%
> Mon Mar 24 14:53:53 UTC 2025 0%
> 
> ...
> 
> Mon Mar 24 15:10:12 UTC 2025 0%
> Mon Mar 24 15:10:14 UTC 2025 0%
> Mon Mar 24 15:10:15 UTC 2025 0%
> --- here device did shut down ---
> 
> This means that the capacity can go to 0% for approx. 15 minutes before
> the BQ27000_FLAG_EDVF becomes set and 0% is reported. I would prefer not
> to see the EINVAL in between.
> 
> This all may end that we have to add another DT property to tell the driver
> if the bq27xxx is inside a battery or the battery is removeable and only check
> for value=0 in the latter case?
> 
> Or can you limit this logic to the bq27200 because it is unlikely that the
> i2c variant is used inside a battery pack and the HF08 battery uses the hdq
> variant?

I can see the problem. Thanks for testing. Let us retract this patch. I
think we can solve the issue in userspace.

Sincerely
Sicelo

