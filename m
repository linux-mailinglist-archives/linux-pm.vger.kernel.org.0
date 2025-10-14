Return-Path: <linux-pm+bounces-36062-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A4BBD8F06
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 13:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 958FB19253FB
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 11:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C2D305940;
	Tue, 14 Oct 2025 11:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H/02+A+J"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFC6308F15
	for <linux-pm@vger.kernel.org>; Tue, 14 Oct 2025 11:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760440127; cv=none; b=oh9v0XtS2lj1kU9ngbuLONEyC5aW975pZpeOYsWSzdb4/vNa9r4bTXFaQr6/JkBPhXN9WlbVnlr3KhwEBAUZ9n1qyP0pYOJkZSEKM03FkdznpRScZv/VskEniUyilNqholiiGzTlAPm+x7Gp3xLA+26XJ6bSQqtswJ7/yWzjuk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760440127; c=relaxed/simple;
	bh=P+5GauTt6GT2A5ICewQhAYJjsy2WOR/Fp4RhjgMbv+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hpRu9k+TNIfMtNyO3RnMy6AoommwySscGC9LoJOF1fjCPuIIXGPQjtvBeSH4aoe6WnD9JtogtubrV7dMyolmY8Huw6rHU9TStv41C8Jk6tYrRBUSm5qXJ60KaMBXA7YwMBD0yNlRw6mqxMC6nvRPQkgjvJqBp2hqdccz+Z3g/4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=H/02+A+J; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-32ee4817c43so4158940a91.0
        for <linux-pm@vger.kernel.org>; Tue, 14 Oct 2025 04:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760440125; x=1761044925; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kIl7+t2byU2rLxGt9Fvez6I/u2Ic/lM71HIRdn+BxNU=;
        b=H/02+A+Jy1afx8MazniDdIkPUcfD3mozlAvQd3k00bvcAnKT9uWCcdBtRjpainlonI
         nyAN92GepjCoe20RpotEEe6h3gac/V13RTXHleFFcU3pMqUJsAbm9vygupmOdlWwS2FE
         JcdBE7DQ0/jjuceG3b6B7zWIaUIecCrDSG6gI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760440125; x=1761044925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kIl7+t2byU2rLxGt9Fvez6I/u2Ic/lM71HIRdn+BxNU=;
        b=Z1ctvVNbOUkFicZBS/bmdsOOCOw0IC5Af2fHjjbunQ+yK8towOKcJkURrIXCuF2qty
         DTfuNfiTON4ujIYWT/oRhnM9uKQ/Q8UKZtrZg+V+E24USlp+OrZROBLXGwfnTpCROq1K
         Jo+PR//4h3jNUrx2dRa2jHb2H8VrNnNpbkD4y7qkMzcSgt1VN6PCLJlE5/Tbhi2B/Rbk
         oEudt3QEYMHuP0GHxXZW2iZX74B/33RYZwfEUMdco4CT3vfYZAfXkfFw5sqfsc6pprXa
         snYuMAnNCEeyaZi4kvPWDHk4s1FpQn76D1nct+3qArt8T+oNjCJaC3MbCGFQ48WrQd4Q
         UHag==
X-Forwarded-Encrypted: i=1; AJvYcCXZuZNw2wvYFTonARMQ7JJUqd0D5n5kFcmw2go8MJaMj3IJxb7mxeDv32AgXgfUkYl/WL+fb6Fc0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZRN4xMUV56Ok9tdf4qRurJIGA4L++AN2t3fxUn524nFIkcDdP
	Zu+CgaHK0o075FAsAAJQfhOyTXqLNjVwq3twah3ANM5rmNvyAHRfqqR5w7joVKIWvQ==
X-Gm-Gg: ASbGncsL5ExG33zwuswq/Yg2D/lxJ+8ps205ATFF6Hocf/lS1YDsJTmkSVqZme8teyH
	PXD6rrRQug/X4cc0+VMIib5sOJ9DZTSX+16GHqkH8uJpms++McOQ48lEza9VdvMTMPNsrh2TzSN
	2lwYTkPCxjWcg742h50FmslXdTYc8mmSe77OscayiveYHAYunrN2Yence8wYCYeOqhTQxVfZN9J
	Nmd1eZTnlSMOEVqxkfc9O77NxSBArWc4FCbHEUN67KmiW5qeJyt2xPNHCeANciv/Z0JE4Ka2IJy
	EjC/8qLkQ3y5fim6RyBQs1BulEZtY2M6sC0S1LrvnkvbD5ZR58hFGYeMquSmnkT48KQlJ5zlPgG
	8+rnWxDE6eQC5ZrL7/5KEzNRlcWhlpSXVtEoI/5Aut9zMWIzY2TwfHQ==
X-Google-Smtp-Source: AGHT+IHZp5MLtuj8aEbRYmVAG30fR1mkEeXUfh1F7/djMcG98/l7AMsS3SPYvh8TdHqkm61PdymDQA==
X-Received: by 2002:a17:90b:4acf:b0:32e:6111:40ab with SMTP id 98e67ed59e1d1-339eda4744dmr37545449a91.3.1760440124929;
        Tue, 14 Oct 2025 04:08:44 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:f7c9:39b0:1a9:7d97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b61a1d386sm15642214a91.5.2025.10.14.04.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 04:08:44 -0700 (PDT)
Date: Tue, 14 Oct 2025 20:08:39 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, 
	Christian Loehle <christian.loehle@arm.com>, Sasha Levin <sashal@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tomasz Figa <tfiga@chromium.org>, stable@vger.kernel.org
Subject: Re: stable: commit "cpuidle: menu: Avoid discarding useful
 information" causes regressions
Message-ID: <gl4gcdqg4d7kqvnbmo3vuymdzcxjoi3qubgaiuu4pzlashxzjr@z7fqi3lek3e7>
References: <36iykr223vmcfsoysexug6s274nq2oimcu55ybn6ww4il3g3cv@cohflgdbpnq7>
 <2025101451-unlinked-strongly-2fb3@gregkh>
 <zfmoe4i3tpz3w4wrduhyxtyxtsdvgydtff3a235owqpzuzjug7@ulxspaydpvgi>
 <2025101421-citrus-barley-9061@gregkh>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025101421-citrus-barley-9061@gregkh>

On (25/10/14 10:02), Greg Kroah-Hartman wrote:
> The point is still the same, commit fa3fa55de0d6 ("cpuidle: governors:
> menu: Avoid using invalid recent intervals data"), is not backported to
> 6.1.y, it is however in the following released kernels:
> 	5.10.241 5.15.190 6.6.103 6.12.43 6.15.11 6.16.2 6.17
> so something got lost in our trees and it needs to be backported.

I can send a backport for 6.1, unless someone else wants to do it
(or is already on it).

