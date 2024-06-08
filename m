Return-Path: <linux-pm+bounces-8807-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E565890108A
	for <lists+linux-pm@lfdr.de>; Sat,  8 Jun 2024 10:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86EF528294C
	for <lists+linux-pm@lfdr.de>; Sat,  8 Jun 2024 08:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E994361FF6;
	Sat,  8 Jun 2024 08:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejR6Hw/P"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9D1C8D7
	for <linux-pm@vger.kernel.org>; Sat,  8 Jun 2024 08:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717836501; cv=none; b=XpltiEXpP5V9bGGWRxAwij6ILxRsrvWTsBalTMGV/8qeYit5A3vkiML+vx+UCWysTFGequ9Z3TQHEl8JoQDVLFlq62vafxiGyfh1V0v+ZD6MCHrY1Ho/hUkAuKYm5npk//qzAlN5zg5bBQHHc2mMMB9zH5LHlU2F085iVZtFMCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717836501; c=relaxed/simple;
	bh=kjW/OwKE/38nsTgfKPv6P/u0Ov0EctGEAhg2D4hqOUo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=o+0gk+7YOrg+v87cv4Vq2mcnZrUPc3Nd9uvX2SY7kLgFmdZ0FlQ3B1Fvvd4tqfs1FGksW8Tdm/pLP1+mrB0lk8ArwujsAdMSsanDKSewTjS7TVr4e0Ip9xnrdZ0TZTzuVYPzGiGqMQhqdl80XIbFeHN31BQBsBZmPkCYqqsFumQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ejR6Hw/P; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57a9a3bc083so1537706a12.1
        for <linux-pm@vger.kernel.org>; Sat, 08 Jun 2024 01:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717836498; x=1718441298; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kjW/OwKE/38nsTgfKPv6P/u0Ov0EctGEAhg2D4hqOUo=;
        b=ejR6Hw/PYQhSgS6Si3zjWKARFiYV0OrxKehQ8BalkmWYkmm6c1FkpyU3vRfYvTBPYw
         BDoGjqtAod/z3Bl9fyw9CeLYjESAX863M4GX42fiFh1c94mpflHBKZyNdT5f8l/Z2Qb2
         ubh2xoi9N5U39nEj7ifp+IpyWvq+WeRsQiGfUV1YCyIG1m6XzajudOyuPuWQPQUqe+hG
         kxvAm7jWkLHsQukpo7mWBedehSKjo6PQ6gAUKnMprBAXcY8YSs7oArg5odoiQMl5C/iL
         Xs4Igj2fJud5Q3rk6NKRA5fdqa7X/xNdrBUZsu/PkAgYlPwrjYJ9fgNDTuCMaBkvDTc5
         M6sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717836498; x=1718441298;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kjW/OwKE/38nsTgfKPv6P/u0Ov0EctGEAhg2D4hqOUo=;
        b=t3GVxtiZjRqhFW0Zb2MInMkmzVQUBXc1AJGMgW3bH+gsJJX/CzU2AIlutbHt+S6JMm
         LCu25+gVxZ+UyhOOVSILu1WoLQZRAtN8KjIqRpnMQiNUcmCDMFAXPiwJFBVgvx7gGF/e
         trZ0N1V2auq2alG1xzX5MySq/6yeuE6w5og2ncp7hpNr2PmFcBLI/oSyg1Z5lnlYBxsQ
         hJTLkgQBundjCvJqWRCvk5/He3/1HkPinhfX3jq9ZReeEIN5PJ0/wi0ikTHVZZXq8gbA
         7o7IfA/agA6vkmw8GJR4QT1uNVkejSrCwELUcXakP+oTYaGIjKr3nF5zZC7zlsqblF6y
         z0rg==
X-Forwarded-Encrypted: i=1; AJvYcCW6OlLutvlkRQ8/IehnPJdGuH0yC0WBv92HQpaniZK8vkHinQ4n7VChelhZgt81x9vZfk96DawXPb3y7ciZTA9YvwQx3RiU0aU=
X-Gm-Message-State: AOJu0YzWZVLYMjMceb7IApv6VuwANmhXLRRD4J+8grmK2vuLFDEMYxkj
	p5XV3+s0h96MXKoBG6YhLq7/8pmiJHLr5wX3bxfAlNUoPloRxYt7iTYJXD26MRVgCW3r4fngRjO
	e19uiUa1ohhBv6X6c9AMddGi5q1I=
X-Google-Smtp-Source: AGHT+IFeamgLDpai9z4xWPUhmP3JtUBJe5qabz+gPMtryfDxWnrxGjd+hEyDlCii8DSshBAi7pMeYYeK+vSi8R4mmMs=
X-Received: by 2002:a50:d683:0:b0:57c:72ee:a864 with SMTP id
 4fb4d7f45d1cf-57c72eea910mr149969a12.42.1717836498378; Sat, 08 Jun 2024
 01:48:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Philippe Simons <simons.philippe@gmail.com>
Date: Sat, 8 Jun 2024 10:48:07 +0200
Message-ID: <CADomA48qTvjvxURRBbyiiScM=jg9k4x+bPktSG03+fyW5VpEDA@mail.gmail.com>
Subject: Re: [PATCH 0/3] cpufreq: sun50i: add Allwinner H700 speed bin and
 additional OPPs
To: ryan@testtoast.com
Cc: andre.przywara@arm.com, conor+dt@kernel.org, jernej.skrabec@gmail.com, 
	krzysztof.kozlowski+dt@linaro.org, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-sunxi@lists.linux.dev, macroalpha82@gmail.com, 
	nm@ti.com, rafael@kernel.org, robh+dt@kernel.org, samuel@sholland.org, 
	sboyd@kernel.org, sudeep.holla@arm.com, tiny.windzz@gmail.com, 
	vireshk@kernel.org, wens@csie.org
Content-Type: text/plain; charset="UTF-8"

Tested on my RG35XX-H, no issues

Tested-by: Philippe Simons <simons.philippe@gmail.com>

