Return-Path: <linux-pm+bounces-3141-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 626A2844CDB
	for <lists+linux-pm@lfdr.de>; Thu,  1 Feb 2024 00:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15F9A28B26E
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jan 2024 23:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC2E13B7B8;
	Wed, 31 Jan 2024 23:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HM0mMkD/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9703F8ED;
	Wed, 31 Jan 2024 23:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706743209; cv=none; b=fL/bQ6dRXBE/yq3FEd76KKQghVlign2TfkpafS/mS5+fxsit2joWPNP9IWKRM9jEH0d/cW4DItsy1XYIF/I7yi1fV9mlQooDDeQAVwjWhzE2hfSYPVYfZ3vdABwazr/eSmyhBCXijCVMVm50+8QN0pQiCzmMyJMhV7QTEMsrio8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706743209; c=relaxed/simple;
	bh=xAKFpWy2WYrKAuOW3GMFvbc0mFyvSz6sd4M8U/M+wfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=elgoVwPiZtEN9eIpVMvS+tcVTyxCNDsIHO/QsVx5gBRd80+olT7RkYmGQEOthdlN8bG/ymLdO9/7Q16oxKW7WJZeMucbCBxNM0mlTQ8U0C6WxawxK3mPPhFSpEcMndt1vIzrbNlL1FZxQab24USuVVl27w/CVazV5l4vUzFV5to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HM0mMkD/; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-295daac78efso190228a91.3;
        Wed, 31 Jan 2024 15:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706743207; x=1707348007; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mNn41Rs8JhzOA9iWpZly1tLKK/bxOt9Z64RFV10twd4=;
        b=HM0mMkD/Zo0ave6B8cEOgmcymR05PkerC0EIudEV5SXVYk0Z5wZfYN/uU28jl6267x
         W6P0KWJn7dAx/E3E9DQe+LFL1cycAReOuf5MmVrOkMVn82I8a4QNz83HXdYMHDA+AseQ
         DQXLdRW0+c19CAHsLYELSuRGA8BKA70ZEZKp7y80Dnym5ElFSHzIIa5ohi0OvFpcphMF
         uyVsXu3Q0V+K3DuEUqCUg+at1TUSefkn4K3bBN+0uwHtzrtfD2PPvbmL09IQ5y0L4COV
         cfuKcrqk2XH36czX7MNTgm0EyQKtYNgU+h2DtfIpbI33H9QyxpggQfL3F55sCb5LqY9z
         oGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706743207; x=1707348007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mNn41Rs8JhzOA9iWpZly1tLKK/bxOt9Z64RFV10twd4=;
        b=WlDZbiJHiPiCOTvMBH7wlt4s+QcQYkEMqSRgXCCWL99J2vJ/vzbw9jNzK4zSU5gtMd
         lWYbS6vzuBa+a6AMnSIiEE06ZSHJaGuqOPimLEUk9N1Z6Mu/LKTVj7H6opt3XP14u+0m
         MLCXKRuRXgMcliIrJRd7qhy8mD5WHeFNhzsi+HdKIyLSQrfCgJgZ7S4kMXHfjIJ5huB6
         G7lbwCbK5sDE0kNeAhiWV/R/d+ao6508EAUTHhdSI5NLKMicpCGZaQFWiM866k5cyayo
         v2/R2cgOad2vhqlhYKyVUJh7y80Z5bHeTN3vgLU34JWqdLEudTfbJCIFDkaQtDMbXjmg
         /cTQ==
X-Gm-Message-State: AOJu0Yy1nxBtlYbaVZfq9o2jyfWhL0DUa2VbalKbWHhArrWMclbQYoSA
	4c8FR9dnuZAdmaliNa3LO5xmMX7G2Tq54rGnCG8jwzoABW2ZyVo2
X-Google-Smtp-Source: AGHT+IEwJOyENEo0RV/dSF4+36GJxsG/AU/qipnTFBZPFdzMx7YD5fDcamkmjrWkcYm42xtOpnANYw==
X-Received: by 2002:a17:90a:d103:b0:295:eaff:78f3 with SMTP id l3-20020a17090ad10300b00295eaff78f3mr2709654pju.8.1706743207369;
        Wed, 31 Jan 2024 15:20:07 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVrs67UgyRjt7ta5JVSJxCcxPfW1OctfiRBsYNEd1kvJDCYDbmM05kFcW7L1bNn4+4Vyvwm8GRwrF2EVBgi08QfaIjrx1+TG53eey3T1oC9zvKrfzJtky8GdBVar4A8VJ5KEgBHKTiu3Fb0vptKHFnTmWzw2hLWbGzm35z5F/ZZDo2lpPq5iDPM9s2ljh28lm0ToCZw/XMwC4m1JYOtGjmc9iIOOMDi5Led+nP/2INS4Hj7OXiha+1EYymN0YG3If3ewntYBwNiDWf0w86LBCyvlIl+dufh0smFPbj1ZUiMefw1bP9bTx1f9/9WEiBdMBJF4LgE9zbVVOnjMvC0w+GZEFLhN+1tRwwEQwmh3QiMO4HNyW2LL6U7+pLotMejcVR4UFxp8HiMGMjYM4+h5/C46fwovTsz8ALIrLR8hRys2qQEkQ0ZA9gZ8jcZjmQ9FsGtfK2aJq983DqSyQWE4sMAa6hWgJwXNHpvMsLATdnrx+2Ijo/QQaAWjxcHq0NVRIG9WOMpDVy2M+vnCOlHq23P2fg5FyPDDbZRnVkMKl2kFaHahWIvdissiGXUkeEeugn6Y+rIniOyWY6VWBZk6NKTONC2N/mpElYUqFy2ikXrfQ/to2OxgkIlDikeyIZ5f+w6u8KVI3BqqHN5Lhy3n0dekLtMJ0blRPUcbczNzCxO2gxfdNquvmZDRegILn1jR+2SHaGsiIzl0rSIzjludelOEVWGbf4ff7IJ94JVZYB4XhP06w==
Received: from google.com ([2620:15c:9d:2:dd5d:ba2a:a6f9:365f])
        by smtp.gmail.com with ESMTPSA id se16-20020a17090b519000b00295066a69c4sm2074603pjb.36.2024.01.31.15.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 15:20:07 -0800 (PST)
Date: Wed, 31 Jan 2024 15:20:04 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
	Support Opensource <support.opensource@diasemi.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Steve Twiss <stwiss.opensource@diasemi.com>,
	linux-input@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>, linux-renesas-soc@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v6 RESEND 6/6] dt-bindings: mfd: dlg,da9063: Convert
 da9062 to json-schema
Message-ID: <ZbrVpIIhIAuEEmlP@google.com>
References: <20240131102656.3379-1-biju.das.jz@bp.renesas.com>
 <20240131102656.3379-7-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131102656.3379-7-biju.das.jz@bp.renesas.com>

On Wed, Jan 31, 2024 at 10:26:56AM +0000, Biju Das wrote:
> Convert the da9062 PMIC device tree binding documentation to json-schema.
> 
> Document the missing gpio child node for da9062.
> 
> While at it, update description with link to product information and
> example.
> 
> The missing child node with of_compatible defined in MFD_CELL_OF is
> causing the below warning message:
> da9062-gpio: Failed to locate of_node [id: -1]
> 
> So, make all child nodes with of_compatible defined in struct mfd_cell
> as required property for da906{1,2} devices.
> 
> The "gpio-controller" and "#gpio-cells" properties are defined in the
> parent instead of gpio child node as there are existing driver users
> based on these parent properties.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Acked-by: Lee Jones <lee@kernel.org>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>


Thanks.

-- 
Dmitry

