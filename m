Return-Path: <linux-pm+bounces-39147-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9293DC9DA6F
	for <lists+linux-pm@lfdr.de>; Wed, 03 Dec 2025 04:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 22688349043
	for <lists+linux-pm@lfdr.de>; Wed,  3 Dec 2025 03:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B1B246783;
	Wed,  3 Dec 2025 03:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrTMQnuR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC7C250C06
	for <linux-pm@vger.kernel.org>; Wed,  3 Dec 2025 03:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764732865; cv=none; b=LRsvKjW5t230hcbcMLyOb/6rS3FpX1w2BD+K5g/ClKejHYhGintFinI6O5lqj9dW8S5VHyC6hPSOnLKtBEtGhyi97+6JZTu4jk9pqrK3rFlcKCVMwD0kIbMjAfUmtXbcHGszgk6UfymSWsDZ2ozHm+czH1EH5EcWF9vgAxEmPOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764732865; c=relaxed/simple;
	bh=RGksxGlxd1razrRpLx1oTnTgpdVcEt1D1rGwT12EVP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RKI2w58U/sF/idM5MnWETlyA4ISqT8xe6sU2+UL/WGPAtNPT5z+W7sgM+LvPmhCyHUHfiUIvPyZPg0hVo0Wifdws0xxgGY/oRZbM3fTqF7RsziEFaQ9uoZex58wMu07q9MKGEGxr/bsvBs7+GTpNInGD3W9kEND31timLpUI1QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KrTMQnuR; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b98a619f020so4747674a12.2
        for <linux-pm@vger.kernel.org>; Tue, 02 Dec 2025 19:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764732863; x=1765337663; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FRfy5QGmIZODbekP4ivkGvjisPnPRYoUT+9cD5HVv3M=;
        b=KrTMQnuR+LPCIU6WB074wrNyrE1EPp/Qb+jXr/7Ewf+Eju0yValSn7yoJwiN0/ey7R
         B+ro7RfInkXVxiat3RbhHwCuFxeS43KzkMbUJwxC7p8B8yM4X+wuYa9zb+xm53am1kCU
         /A5CYnikof3lwYTxq6o7dfFHDHrmTjPJ0UZSrEsj0DuPCt8VzQ2xs89hPMdOFWOsQ7rm
         yKqCyH2713XNE3v59KNutyn31Cp0UO1DWAzcbZ/XjbqnHeYCr4c9F6sv9u4vxSkqOmQX
         H19Ad1c70Y8CPSYnAcsWLXZEX2DkL8IjiWYe0PhVTNzStZgZVH1XwaB0clLahpMpudgo
         M2qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764732863; x=1765337663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FRfy5QGmIZODbekP4ivkGvjisPnPRYoUT+9cD5HVv3M=;
        b=FOn8Ow7GH0ro09siLt5RbdeEv7GsGLhnfgktVcxL8O9dpAZ11RJxG9h2RLDASuT7mf
         yD5fm+pMBcp/7qQvtcmZwcDkMK6PgOlYz2Fvf5tR1OYzpyFH6U3eIwSEpdoMyEpzLSAq
         fWFLvExmAmLCRfPR0HNeRUe07n0KChuFUsenQGzlH2fR/L4cDw1owdPaplubY8xzWbKH
         rAnuB1tmnzHscSr3hrtWXizZkulpU2780yRpp+NIVTrhQl1YdQC2L8Tqmc8Bl8C59Reb
         8ArUFSrtEKdk3iVp8uPQw6B2q6V9TMIDfPrPQnfO/RnPHk/y1C0xba/r9ArOTlUyWu21
         xcdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWALtUaA9NSXKPgGmaZoC9R8jPVj0o6r4OVYFtgPaQvRinX62/t+b1kkhnf2wjXoPNuzyQp/Qfq9A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxR/VnUMygEOL7fZ+UCt8/nBLOqW8BXhqtR3tW4bXf3Mh+SPxek
	pElTS1CABxr3j7pTX6qOTZWMdafFBK8FV9elzF9p0gEOiUssWcNSIZoR
X-Gm-Gg: ASbGncszMxohXPjiOdnIALT1zC1vRcYqmhN8+fm6TBGolsdZmaRpfb+0saFKQk49337
	RglzM9cQy9Nl47ilZMFgZz1QXvFMxNdgMusJAaxxm08oLbCPzAhpJdLzfBKbfsYZZglMGoU6UWg
	FZFAqhTtU8EJmzYOcZJmstIgNTOYKTedMb1eS5UYUWY6dio7u87ccOvmNH1de1pAnzR6J/gyxz2
	Bn528zBOrtiKwrczlwnIMHzSXiCACvNYeklOcL8baqVnC42mLzy8ghGNck0zuTx8l3AWdc4Ob0i
	kE7QfJFlssjEToWWs5NGCQysoaosydbWiNmy7LonaxwdMR07wBFe0aRQG31kcI/X4A4yYK+XQdY
	mIMimqptNJl8aVpMdnoZPSMtRLAy8C3Byzf4slgbVDnw3MzShD7oQAVGMDJ1bA9MygdFl+jHzvJ
	qjRrDw3lf/E3rZtH+lj0GRriU=
X-Google-Smtp-Source: AGHT+IFxMzxQO6KofdGARUR6oYWbgoTNRcXyxWohQhQ68B7N5GSHLnrgZCmxirt4iBUacrPv/L/unQ==
X-Received: by 2002:a05:693c:2483:b0:2a4:5a26:25e1 with SMTP id 5a478bee46e88-2ab92e816d4mr474100eec.30.1764732862761;
        Tue, 02 Dec 2025 19:34:22 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a9653ca11esm60182255eec.0.2025.12.02.19.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 19:34:22 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 2 Dec 2025 19:34:21 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Nicolas Palix <nicolas.palix@imag.fr>, linux-pm@vger.kernel.org,
	Julia Lawall <Julia.Lawall@inria.fr>, linux-kernel@vger.kernel.org,
	cocci@inria.fr
Subject: Re: [PATCH 2/3] PM: runtime: Make pm_runtime_barrier() return void
Message-ID: <a63bb78f-ec2b-4e6e-9d8a-be00cb2a6c17@roeck-us.net>
References: <20251202193129.1411419-1-briannorris@chromium.org>
 <20251202193129.1411419-2-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202193129.1411419-2-briannorris@chromium.org>

On Tue, Dec 02, 2025 at 11:30:25AM -0800, Brian Norris wrote:
> No callers check the return code, and that's a good thing. Doing so
> would be racy and unhelpful.
> 
> Drop the return code entirely, so we don't make anyone think about its
> complexities.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Tested-by: Guenter Roeck <linux@roeck-us.net>

