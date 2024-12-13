Return-Path: <linux-pm+bounces-19194-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 196ED9F1033
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 16:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B34416B37C
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 15:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28351E1C1B;
	Fri, 13 Dec 2024 15:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5GoCgJg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F1D1DFD9A;
	Fri, 13 Dec 2024 15:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734102167; cv=none; b=hK/2lFbeHY2PnI1MgZJ+9MdTwffpEc9JDoXryi6lqCqq5JF27VebPrLlz1xcxW7dtPpXWfPPue88yWbaB566Ee8yrBxM+2UKzixOYZC+O1+djgwKSiAt0JjPwwG2sV1ijF09Hb+FhdhjZQ1j9jg3llaFi1tV0dNTvC5Gsqyfxyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734102167; c=relaxed/simple;
	bh=c4RK0KdshLVnlcNk7ar6uYyJybsvc5HvNX/IW4sbOg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P24hR6p05O7hq7m19/YvPymqWG0cRA9KRCFLI72y9dJsau1TV28HERySdXG+7U1pAnL4wj4Ucwb0QRTvuwe9iYe8A51MaCAHnrJScQdI45Rp25gxwAD332xUwy5pB4v9W+4Xm1FU3aoYzp5dM1W+dOH0WR9wVohr1vtrGEqT7B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5GoCgJg; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a8aed87a0dso6302305ab.3;
        Fri, 13 Dec 2024 07:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734102165; x=1734706965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4XVYtKwTonTRAAEz/VpBAxqfQVzXNgnMIhjLVHKGIec=;
        b=T5GoCgJggZwunJF+juSxvAmVqGUjdKbP+Xu2qQeuiyx0TMRs5jvH+2qQsfJIlB0mgz
         G5QkF2HC8xvcc4xCdXao6fCUesVNhcf0o8Rc/8XTdh4+RqORl2ooDTt1xCMexYhFekyd
         udCmXT+y+JjlgcTio6CCCq5TXdIJP4UCL34iwRe0rhmBbIvt2FigJXHC+fOYZef+hfYm
         uaRNHShDP+8N4IyVY6Zk2RHLMsZQGkDYeumEc/nPOT50C8ofWeSAFZbLJq+FzgnlmqIU
         k2/CkjnLNCsFbKVJ01ss/zATE0XJyKI/gMC7l86DsCZsT+2WJqind7O+0EhI3T79AJlS
         66DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734102165; x=1734706965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4XVYtKwTonTRAAEz/VpBAxqfQVzXNgnMIhjLVHKGIec=;
        b=woMBbpSDkQMvcwX6e7+rhoANsJD5WJI/m2wY9bYgxEa35CbWUjlbjcc1IQWkPgLlWG
         iN9XqYaWM+KIEGbBM4EOLd8MyC4ZwjYqf/KraxZvGdRNaI4L7xZZ44Rm+zi+acFHQQgG
         bUDSp+HYcVR1pXrPdg8ZjKX8xXF3MZYI6BvBW/cUi9/cPy/IWaTF5LeWnqThuK0HcWLQ
         0spkDQen7uEvXyhVktuAD9JKxnGrOOOXgW5wYTkwfCHy0X8JAP30Fdpk5PUUspWWZvKG
         NWoDEqpDolMAtkYiH2xYsrl3eOUaA6UhG2TbXe9U51N6H5awfX1w0upqPyUTdD+p0l1K
         Wmuw==
X-Forwarded-Encrypted: i=1; AJvYcCWu7qI4r3cRSyaTLuHHXrhIuH+rSsAAdMBP4SmDhpU5UG5a6I6xaGYsb8qZLDfLhYuHjXpueew/ZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6xuuRmYkp8xx/U/oGNmI3mnS0ngCAuLcUoTuWKOCHOjFNpc1y
	dngl5PWGnmE+L5cuKxe1B0UgCQViaMY2r/AetflMjrV8vBlKDw1daTqg5g==
X-Gm-Gg: ASbGncvhGCBoBlPoa1oZX9Xk95bUnxPrBtRbThCNrzrdMATj9ypSpnbola/5gynNrdq
	nai72Q9YBmmWvolPi/4eOD4y+Mp2E3c9O2tbfHOX+oswgFBbSWfXXyHsDi7pHKUiikMm3x2cpTH
	mNjCdEhVj8nD5UhhbI1Lc605HTUey9Y7Fm+y/v5Ullk86BpVenTZXnRnWM/OtJeZLsZQVTWdI7k
	n1DN9AxFn6BhuTVJeDbqoyKkX2nFuDNfBxjEZZ8M70h9mJ1fU98VZCbXn8XExtSgifeFSpT6aKJ
	vPpqG9zsyueLzEyjm+KXqGSvIWM=
X-Google-Smtp-Source: AGHT+IH8IbuI7F6ky2rFAaRDM1zteBgZSha56oCzRrTXKDMqenUD4Nu189RS6ql+CVybbNzCPg37RA==
X-Received: by 2002:a92:c26a:0:b0:3a7:635e:d365 with SMTP id e9e14a558f8ab-3aff69dc06amr34304945ab.6.1734102165197;
        Fri, 13 Dec 2024 07:02:45 -0800 (PST)
Received: from localhost.localdomain (65-128-205-244.mpls.qwest.net. [65.128.205.244])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3ab2189b6c4sm12220525ab.26.2024.12.13.07.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 07:02:43 -0800 (PST)
From: Shimrra Shai <shimrrashai@gmail.com>
To: krzk@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	shimrrashai@gmail.com
Subject: Re: Re: [PATCH v1 2/2] [Draft] dt-bindings: arm: rockchip: Add Firefly ITX-3588J board
Date: Fri, 13 Dec 2024 09:02:25 -0600
Message-ID: <20241213150225.3538-1-shimrrashai@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <c1b662d8-6470-49f2-a904-139a33061885@kernel.org>
References: <c1b662d8-6470-49f2-a904-139a33061885@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 2024-12-13, Krzysztof Kozlowski wrote:

> Explain why this is draft, what does it even mean. Do you expect any
> review or not?

Correct. As I pointed out, not 100% of things work.

> Please run scripts/checkpatch.pl and fix reported warnings. Then please
> run `scripts/checkpatch.pl --strict` and (probably) fix more warnings.
> Some warnings can be ignored, especially from --strict run, but the code
> here looks like it needs a fix. Feel free to get in touch if the warning
> is not clear.

I did this, but I do not see any warnings beyond

"Prefer a maximum 75 chars per line (possible unwrapped commit
description?)"

for the 0th patch, which does not seem to be from the description and

"Missing commit description - Add an appropriate one"

for the others, and

"added, moved or deleted file(s), does MAINTAINERS need updating?"

on the 1st.

There don't seem to be any substantial errors indicated with the code
itself. What issues did you find, as you said it "looks like it needs a
fix"? Nonetheless I wasn't planning on this one being a final submit
anyway, since as I said it was a draft because there were things not
working yet. But if there are other problems with it, I need to know what
they are esp. given as I said those tools have not indicated more problems
than those and they seem to do more with not adding further info to the
emails than the code itself, yet you say the actual code needs a fix.

> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC. It might happen, that command when run on an older
> kernel, gives you outdated entries. Therefore please be sure you base
> your patches on recent Linux kernel.

Thanks for all this part. When you say this though:

> You missed at least devicetree list (maybe more), so this won't be
> tested by automated tooling. Performing review on untested code might be
> a waste of time.

what do you mean by "device tree list"? I was not aware of this part of
the kernel source code. I modeled this submission off of others I've seen
here and I have only seen them submit the .dts, Makefile entry, and .yaml
entry in rockchip.yaml. I have not seen a "device tree list" different from
those. E.g. for this submission for the Orange Pi 5,

https://lore.kernel.org/linux-rockchip/20241111045408.1922-1-honyuenkwun@gmail.com/

those are the only items touched that I can see unless I missed something
really subtle.

   Shimrra Shai

