Return-Path: <linux-pm+bounces-12408-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64AE495652C
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 10:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A0A61F2376A
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 08:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A434E15AD95;
	Mon, 19 Aug 2024 08:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="3D0EH2eP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135C542A8F
	for <linux-pm@vger.kernel.org>; Mon, 19 Aug 2024 08:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724054675; cv=none; b=Qxar4C1FanYGuGUYPN74ajRDLJUmpLMkzQaPsKbt77YextNeF/LC8pqanUr9J3Go4+F/U9X/LVLJCm0UnrkKCgFfcP+nAYKaRr/oueZOpsaUid2rMrwMfpQR/QbS1RpSW1+zKtN/bUN+O6LGvRBmFdi43siESGpX1GGGysHKWtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724054675; c=relaxed/simple;
	bh=sh6d2T90VBt7PW0O2QnwFfJGTyOiMOwqTUNiAr1Wncs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n3M8xFhe/WfbkFwezkfklFhcevTuYdkcAbgzBZ7FPVX9Gw8ZHjcNzeblNauJh2Dl8ee9f95aRiJZLqFdw8T8K3mObEDWppxaTEZgDq5wvcvfTWweYMtXe9o1Wc0i3o12Au/T2RqxAg2E1x11EZ44N5O7HLzIHdLm6ZN8J8BzWxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=3D0EH2eP; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3717de33d58so2545823f8f.1
        for <linux-pm@vger.kernel.org>; Mon, 19 Aug 2024 01:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1724054672; x=1724659472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIN5rfSZYgO4e9KNw+kDYWbV7vK/3I6nosj6OAZGb0U=;
        b=3D0EH2ePLsZErl2JvwD6Jages0jiADKYrsFu2yJXemglMpFQYnz1zKuk6Ct1UXvfvD
         QrwHsKXgpkHhn3oszrr294Ll/Cf/x/qkUcazhl5ffwkIUBUbquVp1N8vMSaOconjThXv
         5j+zVxy3EWRJUYEjSw3lBgSRUb8W9F3O7dsjVRUU9KLeoJ7Oir7pr7kMuVZdBcYrVIqa
         McA/R9I3n3MRmWMyXffK7wK45aU8jLuaKZ7lZtwobcyEfz8UteYWXYQRRdmYYQ5vgJeD
         5kXGOCw+rSDu5aY6w1DRIM6ec8T+LPROoG0P4I0hSapyDRJXNSvtlz8jWc/FakSaxG02
         a43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724054672; x=1724659472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JIN5rfSZYgO4e9KNw+kDYWbV7vK/3I6nosj6OAZGb0U=;
        b=n6s6QEbug9Eak0BbbYf3YKJZLu4BC16B7SSG4CuWLUUw1xNGf/be2XE5s3cqlWxORo
         I0VD7AV8mGXHvRBFI1fPakC2Ktvv4DVRDJFyQ4G9DqSEqNjVMRY+Z6bRTP0YQNrNDulw
         4sxdV96lDck/3RC/e+6SqCwBMOoJRXXa1cBJ19Kg5SYEBqp4OWi2+zcQETPoJ91Q0L3W
         izeZCirmaZxpp+f9lzX4XCWglvt4C7a+aP8tMWT1gQnQAfKFxFoR6bvPqp+guR2Witz0
         zTCzw7jePa9XDoxeSFD0L51+evrv8D0e6vXG8wKAWK706rdKzClBuiRjEuX0+bb2E9FH
         rjNA==
X-Gm-Message-State: AOJu0YySn9p2VFTxl0IFU3EKAlbvcixK3fq59r9AoA04dhY+zu7qzDQO
	xKgG7g/bSMCRHgW/lP+p//Sk92lCI8b9k1YPX+B/wZAvqvaTslrSCzyqckD2ODNoK9g3ZOg4TsZ
	utp0=
X-Google-Smtp-Source: AGHT+IH3G85GGe9gDURbCijJL1PblYamaPRjroyy+mFEzzX+T5LHJCe/TbhZd3smYOqpPUe7YpmXEA==
X-Received: by 2002:adf:fd82:0:b0:371:8411:ef7 with SMTP id ffacd0b85a97d-371946ae86dmr8061498f8f.62.1724054671409;
        Mon, 19 Aug 2024 01:04:31 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:7b55:8f70:3ecb:b4ac])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189859d4esm9792432f8f.49.2024.08.19.01.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 01:04:31 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH] power: sequencing: qcom-wcn: add support for the WCN6855 PMU
Date: Mon, 19 Aug 2024 10:04:29 +0200
Message-ID: <172405466482.9106.768629947114407422.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240813190841.155067-1-brgl@bgdev.pl>
References: <20240813190841.155067-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Tue, 13 Aug 2024 21:08:41 +0200, Bartosz Golaszewski wrote:
> Enable support for controlling the power-up sequence of the PMU inside
> the WCN6855 model.
> 
> 

Applied, thanks!

[1/1] power: sequencing: qcom-wcn: add support for the WCN6855 PMU
      commit: b8e4b0529d59a3ccd0b25a31d3cfc8b0f3b34068

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

