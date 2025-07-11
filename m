Return-Path: <linux-pm+bounces-30670-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F3EB0182A
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 11:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AF1D582901
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 09:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE702586DA;
	Fri, 11 Jul 2025 09:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="irDJu9ki"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460BC205AD7;
	Fri, 11 Jul 2025 09:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752226694; cv=none; b=OQldJVmb/sqA4b7W4Vtg6Af37XrlrkO91jMr/a6fbmFSUTWyxoorEo+C7mMswdTnmq3yz9aynTl0NhdMeOETwyQD9iT2TnT5ioep6KRZQ+Cevchx7gxoi7XAJeaQl0UGshW3BYdQVAAUHbhnt2p+UT+x4/RgrhD7whUijnm2ybQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752226694; c=relaxed/simple;
	bh=aGM5uu50OCGTiLPtbNszIi+73a80t2UdxvB3hZRy5dw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=LI8sQXgfGFc3AI5dD1rDWC0xIZpOzcefDy0NpupwxOFfoHCgKtTbRHoTKsHEZ8zH+S47HGnFP+eZENTf0WexGZMn4Py2SCbLlqG6bJtahby3asRE8UECBju72/t9MOrq/+FXvk8ywbEI4oj1nOZzP40Z3EHYMM8frtltKBNOcTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=irDJu9ki; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA1C4C4CEF5;
	Fri, 11 Jul 2025 09:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752226693;
	bh=aGM5uu50OCGTiLPtbNszIi+73a80t2UdxvB3hZRy5dw=;
	h=From:Date:Subject:To:Cc:From;
	b=irDJu9kiNfS/6vP4xx2p2WVpnH7ulpaTKr4lNX1UFk3b3qblmFHF8fvEvzpcm7ZTz
	 rhA5F/TTzVA01IDMzfnl/MoU8WCXib+ocd4IEGfbcuXtrj7qmkqdj9w/LtJR5RbJhs
	 v8cWpV5EmIjP8kyJPn54y5Z55FHT5JUHnhZhpMobICI5tEpBfG7OvMX5vH4T0bnrMu
	 e3K7SYyAcXds2e91XBCoIGyErS4HmLjySnwu2mI5oLdT41QXRBOlNvrVxkK+q/KEd1
	 bRjZQ6x1KQh4zRvmeCGqhmsfvMEfE1ErussCLq5FDh7I5wileAsK+BT+c7JU7hjBA+
	 ATgTH4XgZehcg==
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-73cddf31c47so1376606a34.2;
        Fri, 11 Jul 2025 02:38:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXVowEfy1jY+Kd9FSytHBWs1Pef16fTC3VsHJmrSLCLCwmZwYQSvqrqckqzXpxJ4iIGTWVDmfSt3FM10FI=@vger.kernel.org
X-Gm-Message-State: AOJu0YziCFkCvll+XFypVXSGIAwGs+u0GnUOTPj25rS1sVo8w+z41YQ7
	J8i/i1d1cB5jdzz7oZDaO5heMS/oqBshmtpsZBcuLMl3K7CUhR9KFtaiVfcF2TF6lgQzZPe5FoO
	bSaZMJEFRWKGLrXWrsozrklF6jaTqxAU=
X-Google-Smtp-Source: AGHT+IHYyJmTKPl/GRQgdoCf8lSk24u9dRYp7B5uEmqiXxoZFCW0e1Nc9Rqx0w83CzOj4mkE13lCVMgU5KWzmVNs2Gg=
X-Received: by 2002:a05:6830:2d83:b0:73b:2df2:a84 with SMTP id
 46e09a7af769-73cfb0e4a7cmr1139354a34.4.1752226692925; Fri, 11 Jul 2025
 02:38:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 11 Jul 2025 11:38:02 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iCR5vqDgzibNa99oi3SvTt8qx50EEUJMoyfzMH5zaJtQ@mail.gmail.com>
X-Gm-Features: Ac12FXzH1P-ga3vZPqUuc72zPZitGfyOr5-aKL0IYgmkuQJzZ5go35IYk8qse34
Message-ID: <CAJZ5v0iCR5vqDgzibNa99oi3SvTt8qx50EEUJMoyfzMH5zaJtQ@mail.gmail.com>
Subject: [GIT PULL] Power management fix for v6.16-rc6
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.16-rc6

with top-most commit ec3cae639482a8da11a3ae30d28ceceb9d6a3f56

 PM: sleep: Call pm_restore_gfp_mask() after dpm_resume()

on top of commit d7b8f8e20813f0179d8ef519541a3527e7661d3a

 Linux 6.16-rc5

to receive a power management fix for 6.16-rc6.

This fixes a coding mistake in a previous fix related to system suspend
and hibernation merged recently.

Thanks!


---------------

Rafael J. Wysocki (1):
      PM: sleep: Call pm_restore_gfp_mask() after dpm_resume()

---------------

 drivers/base/power/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

