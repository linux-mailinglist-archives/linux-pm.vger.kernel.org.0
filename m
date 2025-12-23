Return-Path: <linux-pm+bounces-39820-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CC0CD8435
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 07:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B1D43018747
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 06:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCFE3019DC;
	Tue, 23 Dec 2025 06:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwAmUTBH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1202D2FFF8C
	for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 06:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766471647; cv=none; b=WLJdI2MO4nSgc5TPuI7EhqnZCODvdvbpbQkc2KAc9qaGsV4FQcwU6DOksJMBiA5Yc/nh55ihGECyp+9iXKZdHTgmHICY0iYPC0YfyBcr4qPCA1uTEhqEi7SMBx3kYXp4RMwMASxvOUun5J8xEdPqNvrnqjmKPwFj4gaVr5hpqqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766471647; c=relaxed/simple;
	bh=zQMCxWwv+vy2hbOmutXkA1vn5ZNuVRvD6yhOueNtNZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nflj1T4hzDon7qgr7ulnuLU+G+GgxXMJJuQA2mZQamkjQB/kN5Z2lLEugpbo2HZpxli+Bowhw2YJDvc/O2lWsXILkjQae4w7Xmmy/luSyjQ4B1BSSfbMpz0Fq5Z85kjdWdjDH0bn0Bstr5mNSjjN5dyO7TCwIZDXwpPuYpEV4jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WwAmUTBH; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-37b9728a353so58744971fa.0
        for <linux-pm@vger.kernel.org>; Mon, 22 Dec 2025 22:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766471644; x=1767076444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=048jzD37H8lsx/zZlGI/PEx4g5lnBiNM8RokzD3mdsY=;
        b=WwAmUTBH+Z8XRKtBCqY+p4vhvOZdSmb+n+f1cbt8viJVJQHBr5U0jo/4s6d7qWWbBf
         m0+yEyt1/jvRcNLPLCeivO4iEJDrI+k3zJ4jS2PQa2ZNeiL1Tlbub2tME3cf4CpV5t5x
         y2v7G9wdrigZhwrK4c7Yef+E/fzqp/cS5XJetFqG4hBREaOaTvMWzFG+nlcM12NpLnyV
         bWftFqc5KSBKZ0BFk6cyJPxHYk5+KPRoe6KeznkQ0/TJBWIgfaUW2op7B7NEb1bQFuep
         6NgElzoJ6xi+uJ6OfcZAZFe+8coZdOUBZ5vF3OSWtmJtAEFFTI3kGZUoLI04b5pvc8/0
         nauA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766471644; x=1767076444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=048jzD37H8lsx/zZlGI/PEx4g5lnBiNM8RokzD3mdsY=;
        b=OtWvphtER1y5JhVQV20k0BoIeK/UXYQtXgjj8pp8Oazom8sXcAG7CFNkCfCJcquCoP
         QdSk/3ADkVt7JMkeJA+5wann77twuzmoFk7CRoGi2EI6uuN94jhSqkCwi6V0Kiyi3rpy
         cUxnfnmqYFIA8RTpmHhd63vIvf0xEJzYNBm89UJUyrntWUD8HLqU1Zb3wrVzkukOa5eA
         RFJ9DGt7QLTGFU/doe3j1cogcpboQHSBjWiGOCllHFT3RzzZ40CAoBWPkUsm50kmH78I
         bwwpw132KDANLhrew2QxNIbzWh6/mPVS18wyqpGgJZw36rB7GWGd27bIfpV9ikVKLufF
         orBg==
X-Forwarded-Encrypted: i=1; AJvYcCWJlwEblUTmXQ9U1o6svTvibSqbLvY0p1q4D+IBEq+zpO9hfwhWE64nJwuJAU2DSVRWjdGBXplB3g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyULXr5xUtYsIqe+CiyiSvIZsLuAgsUWkeIdAaPjMSCXEm2eTNx
	imrQ9pCq8hw0Ydl4RoIDz7+VZwDY6O6G6qEe6HxAlp1pU4CtKTSNtlor
X-Gm-Gg: AY/fxX73nX4kdje2nZX5CjnJlXsOljUaxdvWUU1WURGhmDB0rCHJegg1QyGAYGaehq4
	bRL56moTmL42wUaUS4xScbNNGlXiKeYxhkUr2xX6n9AOq0uXczEj4nuIZlLkQ5NQ0LDtrXngYfx
	p+lFgM14VmenqpR4V3gd06YMa6x6o74hO2Jv/irQAlNhT4HNG2CDGj1YQMdNVu37I0L0nVqO8zv
	V8pn1VE5AINJy4tssaBb5NL0RLD0I5x0WmScCGbjJnUfrA32RpnWG+4LBuU+OciVRl8v2opJLWI
	IIJwQN2BEe1Iz+E+mF8ghGlr39Ta6nWDQjjBoYY8Fa6Lt3GGZ0l6N5UzP2COtjYvcg6U8LABl1G
	3TyZTfbJdU/QUCaSB/OZBpLsdtUPuA+ay0WvihjAvMWyVsPTGZE1YCfoxq78EAhFdezEUaE/84k
	RAyoXUzcQ/Buym+34C9j0=
X-Google-Smtp-Source: AGHT+IFaFE0nlDnowk+Ou3U+M9eX56ZCvZ4aEX/mIAF0sQ5oS0z9Fh1vnyWDY8DQIpJC2t19J66zfQ==
X-Received: by 2002:a05:651c:1506:b0:378:e055:3150 with SMTP id 38308e7fff4ca-38121566b66mr43783861fa.5.1766471643890;
        Mon, 22 Dec 2025 22:34:03 -0800 (PST)
Received: from localhost ([194.190.17.114])
        by smtp.gmail.com with UTF8SMTPSA id 38308e7fff4ca-381224de6eesm33742031fa.6.2025.12.22.22.34.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 22:34:03 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: gmazyland@gmail.com
Cc: Dell.Client.Kernel@dell.com,
	dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-lvm@lists.linux.dev,
	linux-mm@kvack.org,
	linux-pm@vger.kernel.org,
	linux-raid@vger.kernel.org,
	lvm-devel@lists.linux.dev,
	mpatocka@redhat.com,
	pavel@ucw.cz,
	rafael@kernel.org,
	safinaskar@gmail.com
Subject: Re: [RFC PATCH 2/2] swsusp: make it possible to hibernate to device mapper devices
Date: Tue, 23 Dec 2025 09:33:55 +0300
Message-ID: <20251223063355.2740782-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <86300955-72e4-42d5-892d-f49bdf14441e@gmail.com>
References: <86300955-72e4-42d5-892d-f49bdf14441e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Milan Broz <gmazyland@gmail.com>:
> Anyway, my understanding is that all device-mapper targets use mempools,
> which should ensure that they can process even under memory pressure.

Okay, I just read some more code and docs.

dm-integrity fortunately uses bufio for checksums only.

And bufio allocates memory without __GFP_IO (thus allocation should not
lead to recursion). And bufio claims that "dm-bufio is resistant to allocation failures":
https://elixir.bootlin.com/linux/v6.19-rc2/source/drivers/md/dm-bufio.c#L1603 .

This still seems to be fragile.

So I will change mode to 'D' and hope for the best. :)

-- 
Askar Safin

