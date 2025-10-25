Return-Path: <linux-pm+bounces-36825-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B1BC08C25
	for <lists+linux-pm@lfdr.de>; Sat, 25 Oct 2025 08:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 083304E586C
	for <lists+linux-pm@lfdr.de>; Sat, 25 Oct 2025 06:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01832D7397;
	Sat, 25 Oct 2025 06:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNzcWh2b"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314A82D660E
	for <linux-pm@vger.kernel.org>; Sat, 25 Oct 2025 06:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761373447; cv=none; b=V3Et3Th5WSQq9f6C2sW3S0sAkeNTUikRpNYdl7nkSDJy2VOTE8S+RBPlPbXTh+BsC1RyB547DupfwendV3w2el3jfFPmEVmWpQraXm4xHSCSosGF1JXpy7uQv0nRuRS6RxWt9bsXaU+8A+aOr+IbrsNqhQAKTru3gYlyac2B3cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761373447; c=relaxed/simple;
	bh=FMw0+LtxF1XFnxeM6wfrdoWVKBhlpw1rYFoS6IMYePo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=opVdpbL4awnJgHlqxGju82n0vhZxeuY/J7IeOvB0QKxK5WPCACyNahX4iNpYOocYruB+Osv6VANtPTJLsV2Y1rHSpWxwfJT4X9a2ZS0DUuX58lT0pyKFVz+0REZ+VGo+/xm3KgZIfHoMSkpkTX0CfVyDcryvMHUk1l0Sp82Tx/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNzcWh2b; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7a26dab3a97so1738993b3a.0
        for <linux-pm@vger.kernel.org>; Fri, 24 Oct 2025 23:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761373445; x=1761978245; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Uyn+lqnfj+DF2Mnswe7yP+PmxmYmbtnyxPSWDdj2IYQ=;
        b=XNzcWh2bsHRhXIg5xNeAIKsJqhwchKF8+WPtWD5qzgB821m367N5VOXqOYeVdByUsT
         f21ry8atQ2Z/BMPzisV1yEM5pma5LujBytxUM1X1Nnvn2NWepzUUnP/X6YCAiZ4viYa7
         4ou9prwSwJLccbf3JmbYhKaGuEgiKeW45whAy1pSpbtXjxRnXMnxOzuk/QH7rwypRupH
         tqp2FvRl7v5fP1cmXi+Zt6EzSsTmSRAzSgkP9HZ7mNjHQ0fm0W8e9dl07UdmM6LF5r19
         ld+/wDwtZDehK7hQPL6Ig6kulgA5qKcZUUk2Q8+7Gmzweh0qV+7xgz8/NX//HwwKaHq8
         H3Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761373445; x=1761978245;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uyn+lqnfj+DF2Mnswe7yP+PmxmYmbtnyxPSWDdj2IYQ=;
        b=KvdKYCOYwEG1GJdKFRjgkWHsgFlRxQT8a3SOWFB2oka4gktEmU3Ih6hQ3QN1yQT1uS
         dvO01FjJ1x8ex4HuSohgLvl2oDgBrLtnAJ3sErVFvM5QoBLgePUrYQ0XdzrzrlX9h9vU
         ELVuk2iHtLRMi7DDbhZsbes5wSCuUNlUUNZBfm43rIln3b0LsLA5UK0JT0Y7eQ81KhTj
         t/lhKkvXVVohxX+egsGOKK74g8IOv7Z16fclElBdb6Kc0hqmUgHd4gtufxlQLBwEvzGa
         P+N2rTKPb9dZ+UIqZy0SJwx6iRdAceF8B/hjsCZWy391igo6RekUCuSA8amzdsm4aUWB
         pKAA==
X-Forwarded-Encrypted: i=1; AJvYcCWkq6FPVazw+d9sgh2FDlr1NmB5mqlVrGbu2jYLtnopXuFZvsOMpejfIfHVXK+axVl+/3x/sVmPlQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyMIVX1JciRh8BcFLOeYRiCsYdLw4p2Z7rww2gxHjr4uOkg+7pi
	i9n69jY2PsHC5nbSacO3UDU2CRDeJ8o428e44q2J81vrLqxx7K2QO7k0
X-Gm-Gg: ASbGncuEHtDN/aASlcVnA+MSqSGt6p3B6as4tgDpTCW2bdhHy2/mZrsHlhkkvq3RG2H
	frfs4i69SQpvhNLu4NWEdzItJzBmzxiYc+d/QFlXIrOzoyun9E3r3PEwhOh2zVzuLb386lA5DNn
	W852AWGZi0dSJEE/ovgVwS70ZPqINuP/JcwxHm4rhTGnCfnPm5zHJVGI2D4452UX2swO7AFODLu
	0QoUvGf+UJmq41JgndtGyrW8nCD//3vT2d5+S/l+93nBxRmgImBfctMDWPDww/1VnnOSqW8kf77
	u62bIM03mfYblbZmnbYH0iVYto3jiLeFd7GPryYXDw4O5M7EyDwYFRVMt//g0kYupqJPMlkvCmO
	62IRy6QcBt4Cbw2zl4lFE3nMkL2lKdKbJCKW7rzVnI3/df7PPr4vqmPRTIIalNUapZeaRcE5LE7
	O3D02JUXecdiW/QWNEzBsfKOhTcVAAOhKuiL0s+EydEFk+bflX2GQeeKLR
X-Google-Smtp-Source: AGHT+IHplQPVfCIQoY8PHDd3B2J4jw0QISC8FZ6gWYBjJGGEKcAtDwmwgPaM4vZb11xkzDseTqP+IA==
X-Received: by 2002:a17:903:249:b0:25c:8005:3efb with SMTP id d9443c01a7336-290cba423a6mr366592795ad.54.1761373445251;
        Fri, 24 Oct 2025 23:24:05 -0700 (PDT)
Received: from ?IPv6:2401:4900:88f6:d7b0:443:a828:b6ba:688d? ([2401:4900:88f6:d7b0:443:a828:b6ba:688d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e42ea7sm12204175ad.101.2025.10.24.23.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 23:24:03 -0700 (PDT)
Message-ID: <81e6af8eea5b0399d1685797d0ea6a6ebc273270.camel@gmail.com>
Subject: Re: [PATCH v2 2/2] add check for pointers with __free attribute
 initialized to NULL
From: ally heev <allyheev@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn	
 <lukas.bulwahn@gmail.com>, Joe Perches <joe@perches.com>, Jonathan Corbet	
 <corbet@lwn.net>, Andy Whitcroft <apw@canonical.com>,
 workflows@vger.kernel.org, 	linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, David Hunter	 <david.hunter.linux@gmail.com>,
 Shuah Khan <skhan@linuxfoundation.org>,  Viresh Kumar <vireshk@kernel.org>,
 Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, linux-pm	
 <linux-pm@vger.kernel.org>, dan.j.williams@intel.com
Date: Sat, 25 Oct 2025 11:53:56 +0530
In-Reply-To: <aPvAm1E7CvQfOIuS@stanley.mountain>
References: 
	<20251024-aheev-checkpatch-uninitialized-free-v2-0-16c0900e8130@gmail.com>
	 <20251024-aheev-checkpatch-uninitialized-free-v2-2-16c0900e8130@gmail.com>
	 <aPvAm1E7CvQfOIuS@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-24 at 21:08 +0300, Dan Carpenter wrote:
> On Fri, Oct 24, 2025 at 10:59:16PM +0530, Ally Heev wrote:
> > pointers with __free attribute initialized to NULL
> > pose potential cleanup issues [1] when a function uses
> > interdependent variables with cleanup attributes
> >=20
> > Link: https://docs.kernel.org/core-api/cleanup.html [1]
> > Link: https://lore.kernel.org/all/68f7b830ec21a_10e910070@dwillia2-mobl=
4.notmuch/
> > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Ally Heev <allyheev@gmail.com>
> > ---
>=20
> I don't think this patch is a good idea...  There are two issues to
> consider 1) The absolute number over warnings.  500+ is too high.
> 2) The ratio of bugs to false positives and we don't have any data on
> that but I bet it's low.  It needs to be at least 5%.  For anything
> lower than that, you're better off just reviewing code at random
> instead of looking through warnings.
>=20
> regards,
> dan carpenter

makes sense

General question about the process for my understanding:
Is checkpatch run on full tree by CI or someone and results reported
regularly ? My understanding was that we would run it only on patches
before submitting them Or we just run it on full tree before adding
new checks to understand if they are catching real issues

