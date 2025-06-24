Return-Path: <linux-pm+bounces-29431-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5D0AE67A2
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jun 2025 16:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50DFB5A52D0
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jun 2025 13:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EB72D2391;
	Tue, 24 Jun 2025 13:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="zkLyr3M4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CB62D2385
	for <linux-pm@vger.kernel.org>; Tue, 24 Jun 2025 13:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750773491; cv=none; b=Ui+qqBwoGQEaQpEuisBEQQ8OV9N4AaMR1sTEU8DLbS6FL+X1wugl9hDz13k/rQZW5QYsrIMi1Jku8D659NI5X2U39BQxtaCAcRgv+e8JLwX8Oe52N+59CXveXOUXaKHGckSn1S8m8+HfdMuJya+JMPe45VT7fM51N0k9Evvtq1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750773491; c=relaxed/simple;
	bh=SRjdE7mQm9t+sBYLoVgmd8fzr5KQH8TyP1VOA9ZnGvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r+66hTFm+hh/7Jpm6i2vFAG+5GQRQW8GI0VJ77SlBxgJhqrH4iAHwnTXWa3mIL8AC5Ji1NZsG4c9gkm1A641R6gdN3pRshBma5WYJy3SP0QYNHiLonv2kIesqgItLnebsRJOgp+pxXSp1ULgfNIcEluJDNTu4L3EiDPqQAOzL48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=zkLyr3M4; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a6d77b43c9so2875104f8f.3
        for <linux-pm@vger.kernel.org>; Tue, 24 Jun 2025 06:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1750773488; x=1751378288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yfdwBnmwXKVxo4fI9YpCbPX/DuxoUKCmsus+7StatJk=;
        b=zkLyr3M4dif6AUhJ/unJG1Dxli+hAi3LwxS/pQ9gwc6jo0Wqb/L20TS/fWcUZSVojO
         M7/XpPdfqDyVVMPCGhr4P2rlLo/hsqxy5lz6HmUicJ1YLQGp+3QS+GF9t3fbGpGRS4gh
         xmxgVA886av4phe83Nvv/aYWyqbWWTsnHSA1nq/NgztXD+tsJkMdmv5BlbVQ48yQRPD7
         fCHyYilmjNvLVRFsBXuzn9eVWGFFF0FsgIqwOQyIjYv4UT4SNChp03BXOtnTEvvbQAzp
         +xIRVF7vmvqwL0tkfJtl0NbKlr5Y2EOgn+Z9yse5DkctMGQBDpy6ErxdZ+VEeEd1TpuI
         EjaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750773488; x=1751378288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yfdwBnmwXKVxo4fI9YpCbPX/DuxoUKCmsus+7StatJk=;
        b=SwixDVLWztaadl7UKwiMhJBuM1lgekMpgbCAHOCf8idIX19p3gp6lge5tBowNE4zN/
         /rrcLF0kDvCjBkht4AZ0zoxlpnK+ahuI5CpcwlOPcRMXAlxRKC2D8z9i14yOVL7FQxPM
         L7AzXpmtZzeOD254b+b8jsEavb/tD+L9nH6KImhH4hvfpcChQwCONetilMlngHL1yQ98
         ZtlxD58qvejZpCFssh7lMIoXkkZUyD2HhyeWNawzJb621P0IKVT16gTnqrYeRTc+zaU5
         iSHfChh7u/rA7d17kuYlEBBUT4+zQqrxu2zEU05RBxIn0nhkVY2nTqxw6txAkil9eEY6
         IkJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqhmyXSVhgincbPI7dmy1asvULcVjyVp4+FdjUIUbaAf1JtIJRfW1wPmxlGWb/Wx5rGXG/9VSbUg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8zsssC4LeoH3oamk5XDDisdTYowefSZrfdQMFWjfBvTe9oJlU
	pDYeFQ0D+72Iw7+CH/eTr/A/pJ20ZSwEDcMfN7DAO29KhxL1X2q/NIcWLh6OKnQ/fa8=
X-Gm-Gg: ASbGncubEi5PyAY7HIM05UOQNfp05yjBhLMy1P919Yk90/7Nvq4KSmuXE4DcN+H44of
	E4nEtQ+2EGXEpTY1xd+HT0inEqDPxuB3qHz2QZCcaJouTF2Ah+Tg6rfa1kGBTj/ykRe7RA47saG
	3ySPEssozB80aVjBwSj7zGOAUwQnpQ1zDYUm9L27uzVqvuZ/MKMgdRzWQXntHBSXl5NUSHjeUrt
	0n+Z/OCHUnTjWpdakGDo+OvIrt462YbgRRu8gWJm/GIKYpB/y6w2NtDEVnMrJV+8bSabw6dr/v5
	KPBSt0A03G0uoKsst+wh07lepRX19Z6kc/E+P74670IIIKQLv/gUymbilqsZrg==
X-Google-Smtp-Source: AGHT+IE2FNywqz+cFb7euMKYbolnteHJlkDlULxTNl06mbXFoTDBF9qk9BsatavRg5P2dnisXCo5bg==
X-Received: by 2002:a05:6000:4109:b0:3a4:f892:de7f with SMTP id ffacd0b85a97d-3a6d13071e8mr12590091f8f.36.1750773487721;
        Tue, 24 Jun 2025 06:58:07 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:34d2:109c:3293:19e9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e811724bsm1966761f8f.100.2025.06.24.06.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 06:58:07 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Drew Fustini <drew@pdp7.com>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Frank Binns <frank.binns@imgtec.com>,
	Matt Coster <matt.coster@imgtec.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH v6 0/8] Add TH1520 GPU support with power sequencing
Date: Tue, 24 Jun 2025 15:58:03 +0200
Message-ID: <175077347940.80530.12388970181360361507.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250623-apr_14_for_sending-v6-0-6583ce0f6c25@samsung.com>
References: <CGME20250623114429eucas1p1e74e09e74c5873b2f7f01228073be72a@eucas1p1.samsung.com> <20250623-apr_14_for_sending-v6-0-6583ce0f6c25@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 23 Jun 2025 13:42:38 +0200, Michal Wilczynski wrote:
> This patch series introduces support for the Imagination IMG BXM-4-64
> GPU found on the T-HEAD TH1520 SoC. A key aspect of this support is
> managing the GPU's complex power-up and power-down sequence, which
> involves multiple clocks and resets.
> 
> The TH1520 GPU requires a specific sequence to be followed for its
> clocks and resets to ensure correct operation. Initial discussions and
> an earlier version of this series explored managing this via the generic
> power domain (genpd) framework. However, following further discussions
> with kernel maintainers [1], the approach has been reworked to utilize
> the dedicated power sequencing (pwrseq) framework.
> 
> [...]

Applied, thanks!

[1/8] power: sequencing: Add T-HEAD TH1520 GPU power sequencer driver
      https://git.kernel.org/brgl/linux/c/d4c2d9b5b7ceed14a3a835fd969bb0699b9608d3

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

