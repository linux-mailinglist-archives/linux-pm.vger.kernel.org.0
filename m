Return-Path: <linux-pm+bounces-19196-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E009F112C
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 16:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B193282937
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 15:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344001E2838;
	Fri, 13 Dec 2024 15:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyjDDCii"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A075D1E2615;
	Fri, 13 Dec 2024 15:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734104494; cv=none; b=mWh/ohzyTRTvVgc+jKoaL8nPlX/uVHX2OwOhDKHSogVLRa6q8AwNLO7GAqIMwXRBbPaUx0xjDT3fqafM/uBRzvn0P/TEwsktg1eByCgaWnWh3CWTahSp+w5v9z+GT3UmNLsZv5rlXqXVnwLQQWg5OQRhmWk5pBGfHzar/3HCtiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734104494; c=relaxed/simple;
	bh=h9f2IPsO/xNe1+THhOsHQZkxK8oH5Xk2Qbl9ZG+DE+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QdMx++8WqZhD8y5gsHXJQUZM0K4SJuPk6nNLajkVgVixdHYT5qEZCIQilvUKwpw2I9FGChTyi/ivxrL4gInpG5KEibLR24FoTvI1DnUKzn6U/lDIb1Ox+QFV3isZk7DdPTJOIV6M/eX2n9/322am5pafCkQqce/GmPs/i68lObo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hyjDDCii; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-844de072603so159233039f.0;
        Fri, 13 Dec 2024 07:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734104491; x=1734709291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c4wKn96MiedFl6ia4ZZdGHhhDmKHeXzJLuTF6TNk3g4=;
        b=hyjDDCiiQrP8eVu1/GPsfnzbp7Ss74mkcFrIJhCKMvjwGNxXM2P8jnoB9OtdGYwYcj
         khq2uDXRm9+RbhCvncQvto7AAG+pw8+yv5EyAXOi8aILVdxzp3IY6vq0fGAkPSZtOW1V
         xR99ElicnYVTvmOG3lKNRrWHmtV9w77NbnBiINdLfgbGaW29sgm+GM97PpzMm4BJCvkp
         blcFxtMLdPO4/ZSrJLZGdT1+xrM6HCEmdzyjHRWTPOGDOz4ri99GnViDP8RuPODMhjiv
         6kUTgpi3QNktTpdykC/cbQIFhfhZM+we9Fk2gbZ3rsw2+y4cMZHjiHycrH/dhB4OmwVr
         ynDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734104491; x=1734709291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c4wKn96MiedFl6ia4ZZdGHhhDmKHeXzJLuTF6TNk3g4=;
        b=Jw1cNoElwYlilaV39PEwlEexsuEEME35Lc6YhVyj9eRSV2XI51LeDPz/jWRiiPh3Qx
         yhAYUA8SmSEt0h2hj3KNbEfpFsmfRwm2Y2HG2Q7l+3WavZdnN9YdcVaQsk6uZLP7sDy3
         LzE6cBKPdRENCP3eXKHFiEQ4m78vcYpFyDvNp2qsLGxnFZEH3lD32d/X+6FgTqVh/N5O
         GpanP92rygRgf1dqtNNdtXZQtTBygwqIWYA6nnLBT7tkohssHcPcnVs9Hy0LDOYOUYu2
         GrYqHQoyx6azvYkMUtlCP7be/ZW6BPNGr/k6LY1ygBHFRWV46CQbiH0uj/cJW0Ffqewm
         4ujg==
X-Forwarded-Encrypted: i=1; AJvYcCXmGihfMju61AnrcrIhmihCnGvUHmkWgoXpUW7pVx/6J1oDk3+m6z7tVmCP3Wg4ceoDjmspG6XFMw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzsB44cVdBtiK45HyIELk6FjcDkJsNtDEdatrsYluPPx9fobDN3
	9SU3BLjLtIophxHJ0F4evW7vJIYI5cRywZPj50lBj1TFIBjHR6bq
X-Gm-Gg: ASbGncvhPbt5vO4B4fsm0AMqBonf7bvAbAJjIKkDJBwERhOL2PZRbBUnuN97iJos21S
	1+64YVfEkVIAi4QbVmWVQXoM8imO44ZQsa+QQ+DeVf2Xz/6/c4TE2gHzJJGuNPXTJKvetqyTes6
	iy+ymd4DZLS11S8aLj1d3yNRsYSxso9+MmlR1iH3MBiK7Mkq/cCPyCG8bzbXyI/+DGTF029YylF
	QvUshyZPFaeLovto+yBU0H7C2jO9/04SrFM9QyCb6u7foU8zwuEl05zfjEwtNzNbeMONDnEym6Z
	CnMqdvA63gY2m2HcMPmIGu30M40=
X-Google-Smtp-Source: AGHT+IG7zKmTTY+3cU4+IRgs+3snv2XaZhum1/jfja2GkIpicjF9Tf6CDhdfxxuVlVsfE7nj39hb0A==
X-Received: by 2002:a05:6602:2cd0:b0:844:debf:2c8f with SMTP id ca18e2360f4ac-844e88ea5c0mr342460839f.14.1734104490740;
        Fri, 13 Dec 2024 07:41:30 -0800 (PST)
Received: from localhost.localdomain (65-128-205-244.mpls.qwest.net. [65.128.205.244])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-844cceb0c34sm148704339f.21.2024.12.13.07.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 07:41:29 -0800 (PST)
From: Shimrra Shai <shimrrashai@gmail.com>
To: krzk@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	shimrrashai@gmail.com
Subject: Re: Re: Re: [PATCH v1 2/2] [Draft] dt-bindings: arm: rockchip: Add Firefly ITX-3588J board
Date: Fri, 13 Dec 2024 09:41:14 -0600
Message-ID: <20241213154114.5078-1-shimrrashai@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <ca3f43f8-f96a-4d2b-9273-a4d936fab6a6@kernel.org>
References: <ca3f43f8-f96a-4d2b-9273-a4d936fab6a6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 2024-12-13, Krzysztof Kozlowski wrote:

> I mean exactly what is written. Use the tools and the tools will do the
> job.

Since the remainder of your post is talking about CCs and the only other
tools listed are related to CCs does this mean that by "device tree list"
you were referring to a place to send messages, not a file in the source
code with a list of device trees in it? I was interpreting your statement
as referring to the latter, not the former. You also mentioned things being
wrong with the code, too, even though they did not show up on the scripts/
checkpatch.pl tool.

> This does not work like this. Use the tools, not other people's
> incorrect CC list.

> I gave you instruction which tools to use, so I do not understand why do
> you insist on not using them.

I am having trouble understanding is why. Are you talking about messaging
or a part of the source code itself when you say "device tree list"? As you
said that is necessary "for automated tools to work" and that makes me
think it's some part of the source code run by such a tool, but here you
are talking about "CC lists" i.e. messaging. So I do not understand what
that word is referring to - that is my confusion. I certainly can use those
CC tools but if there is also something that needs change in the code it
won't be changed unless I know exactly what that is and thus I need to know
if there are any outstanding code changes indicated before I make another
submission using the CC tools.

     Shimrra

